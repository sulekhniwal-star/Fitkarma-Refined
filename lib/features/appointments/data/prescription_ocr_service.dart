import 'dart:convert';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class PrescriptionOCRService {
  PrescriptionOCRService._();

  static final PrescriptionOCRService instance = PrescriptionOCRService._();

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<List<ExtractedMedication>> extractMedicationsFromPhoto(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      final rawText = recognizedText.text;
      
      if (rawText.isEmpty) {
        return [];
      }
      
      final llmProcessed = await _callAppwriteFunction(rawText);
      
      if (llmProcessed != null) {
        return llmProcessed;
      }
      
      return _fallbackParse(rawText);
    } catch (e) {
      debugPrint('Prescription OCR failed: $e');
      return [];
    }
  }

  Future<List<ExtractedMedication>?> _callAppwriteFunction(String rawText) async {
    try {
      final response = await http.post(
        Uri.parse('https://cloud.fitkarma.com/v1/functions/prescription-parser'),
        headers: {
          'Content-Type': 'application/json',
          'x-appwrite-project': 'fitkarma',
        },
        body: jsonEncode({'text': rawText}),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final medications = data['medications'] as List<dynamic>? ?? [];
        return medications.map((m) => ExtractedMedication(
          name: m['name'] ?? '',
          dosage: m['dosage'] ?? '',
          frequency: m['frequency'] ?? '',
          duration: m['duration'] ?? '',
        )).toList();
      }
    } catch (e) {
      debugPrint('LLM extraction failed, falling back: $e');
    }
    return null;
  }

  List<ExtractedMedication> _fallbackParse(String rawText) {
    final lines = rawText.split('\n').where((l) => l.trim().isNotEmpty).toList();
    final medications = <ExtractedMedication>[];
    
    final namePattern = RegExp(r'^([A-Za-z]+(?:\s+[A-Za-z]+)*)', caseSensitive: false);
    final dosagePattern = RegExp(r'(\d+)\s*(mg|mcg|g|ml)', caseSensitive: false);
    final freqPattern = RegExp(r'(1-?0?|2-?|3-??|4-?)(?:\s*-\s*(?:daily|week|month|times|times\/day|t\/d))?', caseSensitive: false);
    
    for (final line in lines) {
      String name = '';
      String dosage = '';
      String frequency = '';
      
      final nameMatch = namePattern.firstMatch(line);
      if (nameMatch != null && nameMatch.group(1)!.length > 2) {
        name = nameMatch.group(1)!.trim();
      }
      
      final dosageMatch = dosagePattern.firstMatch(line);
      if (dosageMatch != null) {
        dosage = dosageMatch.group(0)!.trim();
      }
      
      final freqMatch = freqPattern.firstMatch(line);
      if (freqMatch != null) {
        frequency = freqMatch.group(0)!.trim();
      }
      
      if (name.isNotEmpty) {
        medications.add(ExtractedMedication(
          name: name,
          dosage: dosage,
          frequency: frequency,
          duration: '',
          rawText: line,
        ));
      }
    }
    
    return medications;
  }

  void dispose() {
    _textRecognizer.close();
  }
}

class ExtractedMedication {
  final String name;
  final String dosage;
  final String frequency;
  final String duration;
  final String rawText;

  ExtractedMedication({
    required this.name,
    required this.dosage,
    required this.frequency,
    required this.duration,
    this.rawText = '',
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'dosage': dosage,
    'frequency': frequency,
    'duration': duration,
  };
}