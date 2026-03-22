// lib/features/medications/data/prescription_ocr_service.dart
// Prescription OCR Service - ML Kit + Appwrite Function integration

import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

/// Extracted medication from prescription
class ExtractedMedication {
  final String name;
  final String? dosage;
  final String? frequency;
  final String? duration;
  final double confidence;

  ExtractedMedication({
    required this.name,
    this.dosage,
    this.frequency,
    this.duration,
    this.confidence = 0.0,
  });
}

/// Result of prescription OCR
class PrescriptionOCRResult {
  final String rawText;
  final List<ExtractedMedication> medications;
  final bool isSuccessful;
  final String? errorMessage;

  PrescriptionOCRResult({
    required this.rawText,
    required this.medications,
    required this.isSuccessful,
    this.errorMessage,
  });

  factory PrescriptionOCRResult.failure(String error) {
    return PrescriptionOCRResult(
      rawText: '',
      medications: [],
      isSuccessful: false,
      errorMessage: error,
    );
  }
}

/// Prescription OCR Service
class PrescriptionOCRService {
  final TextRecognizer _textRecognizer = TextRecognizer();

  /// Process prescription image and extract medication details
  Future<PrescriptionOCRResult> processPrescription(String imagePath) async {
    try {
      // Step 1: Use ML Kit to extract text from image
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final rawText = recognizedText.text;

      if (rawText.isEmpty) {
        return PrescriptionOCRResult.failure('No text detected in image');
      }

      // Step 2: Send to Appwrite Function for LLM processing
      final medications = await _extractMedicationsWithLLM(rawText);

      return PrescriptionOCRResult(
        rawText: rawText,
        medications: medications,
        isSuccessful: true,
      );
    } catch (e) {
      return PrescriptionOCRResult.failure(
        'Failed to process prescription: $e',
      );
    }
  }

  /// Use Appwrite Function (LLM) to extract medication details
  Future<List<ExtractedMedication>> _extractMedicationsWithLLM(
    String rawText,
  ) async {
    try {
      // Call Appwrite Function for LLM processing
      // This would call a custom Appwrite Function that uses LLM to extract
      // medication name, dosage, frequency, and duration from the OCR text

      final response = await http.post(
        Uri.parse(
          'https://cloud.appwrite.io/v1/functions/prescription-parser/executions',
        ),
        headers: {
          'Content-Type': 'application/json',
          // Add appropriate auth headers
        },
        body: jsonEncode({'text': rawText}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseLLMResponse(data);
      } else {
        // Fallback to local extraction if function fails
        return _fallbackExtractMedications(rawText);
      }
    } catch (e) {
      // Fallback to local extraction on network error
      return _fallbackExtractMedications(rawText);
    }
  }

  /// Parse LLM response into ExtractedMedication objects
  List<ExtractedMedication> _parseLLMResponse(dynamic data) {
    try {
      final medications = <ExtractedMedication>[];

      // Expected response format from LLM:
      // {
      //   "medications": [
      //     {"name": "Metformin", "dosage": "500mg", "frequency": "twice daily", "duration": "3 months", "confidence": 0.9},
      //     ...
      //   ]
      // }

      if (data['medications'] != null) {
        for (final med in data['medications']) {
          medications.add(
            ExtractedMedication(
              name: med['name'] ?? '',
              dosage: med['dosage'],
              frequency: med['frequency'],
              duration: med['duration'],
              confidence: (med['confidence'] ?? 0.0).toDouble(),
            ),
          );
        }
      }

      return medications;
    } catch (e) {
      return _fallbackExtractMedications('');
    }
  }

  /// Fallback local extraction when LLM is unavailable
  List<ExtractedMedication> _fallbackExtractMedications(String rawText) {
    final medications = <ExtractedMedication>[];

    // Common medication patterns
    final lines = rawText.split('\n');

    // Simple keyword-based extraction
    for (final line in lines) {
      final lowerLine = line.toLowerCase();

      // Look for dosage patterns (e.g., 500mg, 10mg, 1g)
      final dosagePattern = RegExp(
        r'(\d+\s*(?:mg|g|ml|mcg))',
        caseSensitive: false,
      );
      final dosageMatch = dosagePattern.firstMatch(line);

      // Look for frequency patterns
      String? frequency;
      if (lowerLine.contains('twice') || lowerLine.contains('2 times')) {
        frequency = 'twice daily';
      } else if (lowerLine.contains('once') || lowerLine.contains('1 time')) {
        frequency = 'once daily';
      } else if (lowerLine.contains('three') || lowerLine.contains('3 times')) {
        frequency = 'three times daily';
      } else if (lowerLine.contains('four') || lowerLine.contains('4 times')) {
        frequency = 'four times daily';
      }

      // Look for duration patterns
      String? duration;
      final durationPattern = RegExp(
        r'(\d+\s*(?:weeks|months|days|years))',
        caseSensitive: false,
      );
      final durationMatch = durationPattern.firstMatch(line);
      if (durationMatch != null) {
        duration = durationMatch.group(0);
      }

      // If we found relevant info in the line, create an extracted medication
      if (dosageMatch != null || frequency != null || duration != null) {
        // Try to extract medication name (usually at the start of the line)
        final name = line.split(RegExp(r'[\d\-\s]')).first.trim();

        if (name.isNotEmpty && name.length > 2) {
          medications.add(
            ExtractedMedication(
              name: name,
              dosage: dosageMatch?.group(0),
              frequency: frequency,
              duration: duration,
              confidence: 0.5, // Lower confidence for fallback
            ),
          );
        }
      }
    }

    // If no medications found, return the raw text for manual entry
    if (medications.isEmpty && rawText.isNotEmpty) {
      medications.add(
        ExtractedMedication(
          name: rawText, // Return raw text as the "medication"
          confidence: 0.0,
        ),
      );
    }

    return medications;
  }

  /// Dispose the text recognizer
  void dispose() {
    _textRecognizer.close();
  }
}

/// Service to handle prescription photo storage
class PrescriptionPhotoService {
  /// Save prescription photo to local storage
  /// Returns the local file path (NOT uploaded to cloud)
  Future<String> savePrescriptionPhoto(String sourcePath) async {
    try {
      final sourceFile = File(sourcePath);
      if (!await sourceFile.exists()) {
        throw Exception('Source file does not exist');
      }

      // Get app documents directory
      final directory = await _getPrescriptionsDirectory();

      // Create unique filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'prescription_$timestamp.jpg';
      final destinationPath = '$directory/$fileName';

      // Copy file to local storage
      await sourceFile.copy(destinationPath);

      // Return local path only - NOT uploaded to cloud
      return destinationPath;
    } catch (e) {
      throw Exception('Failed to save prescription photo: $e');
    }
  }

  /// Delete prescription photo from local storage
  Future<void> deletePrescriptionPhoto(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Silent fail
    }
  }

  /// Get prescriptions directory
  Future<String> _getPrescriptionsDirectory() async {
    // Using path_provider to get documents directory
    // In production, this would use path_provider package
    final directory = 'prescriptions';
    return directory;
  }

  /// Check if prescription photo exists
  Future<bool> prescriptionPhotoExists(String path) async {
    final file = File(path);
    return file.exists();
  }
}
