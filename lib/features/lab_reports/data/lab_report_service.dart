// lib/features/lab_reports/data/lab_report_service.dart
// Lab Report Service - handles OCR and data extraction from lab reports

import 'dart:convert';
import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fitkarma/core/security/encryption_service.dart';
import 'package:uuid/uuid.dart';

/// Lab report data model - extracted values from OCR
class ExtractedLabReportData {
  final String? glucose;
  final String? hemoglobin;
  final String? cholesterolTotal;
  final String? cholesterolLDL;
  final String? cholesterolHDL;
  final String? tsh;
  final String? creatinine;
  final String? vitaminD;
  final String? vitaminB12;
  final DateTime? reportDate;
  final String rawText;

  ExtractedLabReportData({
    this.glucose,
    this.hemoglobin,
    this.cholesterolTotal,
    this.cholesterolLDL,
    this.cholesterolHDL,
    this.tsh,
    this.creatinine,
    this.vitaminD,
    this.vitaminB12,
    this.reportDate,
    required this.rawText,
  });

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'glucose': glucose,
    'hemoglobin': hemoglobin,
    'cholesterolTotal': cholesterolTotal,
    'cholesterolLDL': cholesterolLDL,
    'cholesterolHDL': cholesterolHDL,
    'tsh': tsh,
    'creatinine': creatinine,
    'vitaminD': vitaminD,
    'vitaminB12': vitaminB12,
    'reportDate': reportDate?.toIso8601String(),
    'rawText': rawText,
  };

  /// Create from JSON
  factory ExtractedLabReportData.fromJson(Map<String, dynamic> json) {
    return ExtractedLabReportData(
      glucose: json['glucose'],
      hemoglobin: json['hemoglobin'],
      cholesterolTotal: json['cholesterolTotal'],
      cholesterolLDL: json['cholesterolLDL'],
      cholesterolHDL: json['cholesterolHDL'],
      tsh: json['tsh'],
      creatinine: json['creatinine'],
      vitaminD: json['vitaminD'],
      vitaminB12: json['vitaminB12'],
      reportDate: json['reportDate'] != null
          ? DateTime.parse(json['reportDate'])
          : null,
      rawText: json['rawText'] ?? '',
    );
  }

  /// Copy with modified values
  ExtractedLabReportData copyWith({
    String? glucose,
    String? hemoglobin,
    String? cholesterolTotal,
    String? cholesterolLDL,
    String? cholesterolHDL,
    String? tsh,
    String? creatinine,
    String? vitaminD,
    String? vitaminB12,
    DateTime? reportDate,
    String? rawText,
  }) {
    return ExtractedLabReportData(
      glucose: glucose ?? this.glucose,
      hemoglobin: hemoglobin ?? this.hemoglobin,
      cholesterolTotal: cholesterolTotal ?? this.cholesterolTotal,
      cholesterolLDL: cholesterolLDL ?? this.cholesterolLDL,
      cholesterolHDL: cholesterolHDL ?? this.cholesterolHDL,
      tsh: tsh ?? this.tsh,
      creatinine: creatinine ?? this.creatinine,
      vitaminD: vitaminD ?? this.vitaminD,
      vitaminB12: vitaminB12 ?? this.vitaminB12,
      reportDate: reportDate ?? this.reportDate,
      rawText: rawText ?? this.rawText,
    );
  }

  /// Check if any values were extracted
  bool get hasValues =>
      glucose != null ||
      hemoglobin != null ||
      cholesterolTotal != null ||
      cholesterolLDL != null ||
      cholesterolHDL != null ||
      tsh != null ||
      creatinine != null ||
      vitaminD != null ||
      vitaminB12 != null;
}

/// Lab Report Service
class LabReportService {
  final ImagePicker _imagePicker = ImagePicker();
  TextRecognizer? _textRecognizer;
  final Uuid _uuid = const Uuid();

  TextRecognizer get _textRecognizerInstance {
    _textRecognizer ??= TextRecognizer();
    return _textRecognizer!;
  }

  /// Pick image from camera
  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      throw Exception('Failed to capture image: $e');
    }
    return null;
  }

  /// Pick image from gallery
  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxWidth: 2048,
        maxHeight: 2048,
      );
      if (image != null) {
        return File(image.path);
      }
    } catch (e) {
      throw Exception('Failed to pick image: $e');
    }
    return null;
  }

  /// Extract text from image using ML Kit OCR
  Future<String> extractTextFromImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizerInstance.processImage(
        inputImage,
      );
      return recognizedText.text;
    } catch (e) {
      throw Exception('Failed to extract text from image: $e');
    }
  }

  /// Extract lab values from raw text using regex (fallback when LLM unavailable)
  ExtractedLabReportData extractLabValuesWithRegex({required String rawText}) {
    final normalizedText = rawText.toLowerCase();

    return ExtractedLabReportData(
      glucose: _extractValue(normalizedText, [
        'glucose',
        'fasting sugar',
        'blood sugar',
        'glucose f',
        'glucose (f)',
      ]),
      hemoglobin: _extractValue(normalizedText, [
        'hemoglobin',
        'hb ',
        'haemoglobin',
        'hgb',
        'haemoglobin (hb)',
      ]),
      cholesterolTotal: _extractValue(normalizedText, [
        'total cholesterol',
        'cholesterol total',
        'tc ',
        'cholesterol (total)',
      ]),
      cholesterolLDL: _extractValue(normalizedText, [
        'ldl',
        'ldl-c',
        'bad cholesterol',
        'cholesterol (ldl)',
      ]),
      cholesterolHDL: _extractValue(normalizedText, [
        'hdl',
        'hdl-c',
        'good cholesterol',
        'cholesterol (hdl)',
      ]),
      tsh: _extractValue(normalizedText, [
        'tsh',
        'thyroid stimulating',
        'thyrotropin',
      ]),
      creatinine: _extractValue(normalizedText, [
        'creatinine',
        'serum creatinine',
        'creat',
        'creatinine (s)',
      ]),
      vitaminD: _extractValue(normalizedText, [
        'vitamin d',
        '25-hydroxy vitamin d',
        '25 oh d',
        '25(oh)d',
        'vit d',
        'vitamin-d',
      ]),
      vitaminB12: _extractValue(normalizedText, [
        'vitamin b12',
        'b12',
        'cobalamin',
        'vit b12',
        'vitamin-b12',
      ]),
      reportDate: _extractDate(rawText),
      rawText: rawText,
    );
  }

  /// Extract numeric value with regex
  String? _extractValue(String text, List<String> keywords) {
    for (final keyword in keywords) {
      // Look for pattern: keyword followed by number (with optional units)
      final regex = RegExp(
        '$keyword[^0-9.]*([0-9]+\\.?[0-9]*)\\s*(mg/dl|µg/ml|ng/ml|iu|units?|g/dl|%)?',
        caseSensitive: false,
      );
      final match = regex.firstMatch(text);
      if (match != null && match.group(1) != null) {
        return match.group(1);
      }
    }
    return null;
  }

  /// Extract date from text
  DateTime? _extractDate(String text) {
    // Common date patterns
    final datePatterns = [
      RegExp(r'(\d{1,2})[/\-](\d{1,2})[/\-](\d{2,4})'),
      RegExp(
        r'(\d{1,2})\s+(jan|feb|mar|apr|may|jun|jul|aug|sep|oct|nov|dec)[a-z]*\s+(\d{2,4})',
        caseSensitive: false,
      ),
    ];

    for (final pattern in datePatterns) {
      final match = pattern.firstMatch(text);
      if (match != null) {
        try {
          final dateStr = match.group(0)!;
          return DateTime.tryParse(dateStr);
        } catch (_) {
          continue;
        }
      }
    }
    return null;
  }

  /// Encrypt and prepare data for storage
  String encryptData(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    return EncryptionService.instance.encryptDataClass(
      jsonString,
      EncryptionDataClass.labReports,
    );
  }

  /// Decrypt stored data
  Map<String, dynamic>? decryptData(String encryptedData) {
    try {
      final decrypted = EncryptionService.instance.decryptDataClass(
        encryptedData,
        EncryptionDataClass.labReports,
      );
      return jsonDecode(decrypted) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  /// Generate a new UUID
  String generateId() => _uuid.v4();

  /// Generate idempotency key
  String generateIdempotencyKey() => _uuid.v4();

  /// Dispose resources
  void dispose() {
    _textRecognizer?.close();
    _textRecognizer = null;
  }
}
