import 'dart:convert';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class LabReportOCRService {
  LabReportOCRService._();

  static final LabReportOCRService instance = LabReportOCRService._();

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  static const _labTestPatterns = {
    'glucose_fasting': ['glucose fasting', 'fasting blood sugar', 'fbs', 'glucose f'],
    'glucose_post': ['glucose postprandial', 'ppbs', 'glucose post'],
    'glucose_random': ['random blood sugar', 'rbs', 'glucose r'],
    'hemoglobin': ['haemoglobin', 'hb', 'hgb', 'haemoglobin a1c', 'hba1c'],
    'cholesterol_total': ['total cholesterol', 'total chol', 'tc'],
    'ldl': ['ldl cholesterol', 'ldl c', 'bad cholesterol'],
    'hdl': ['hdl cholesterol', 'hdl c', 'good cholesterol'],
    'triglycerides': ['triglycerides', 'tg', 'trig'],
    'tsh': ['tsh', 'thyroid stimulating', 'thyrotropin'],
    't3': ['t3', 'triiodothyronine'],
    't4': ['t4', 'thyroxine'],
    'vitamin_d': ['vitamin d', '25-hydroxy', '25 oh', 'calcidiol'],
    'vitamin_b12': ['vitamin b12', 'cobalamin', 'b 12'],
    'creatinine': ['creatinine', 'creat'],
    'urea': ['urea', 'blood urea', 'bun'],
    'uric_acid': ['uric acid', 'urate'],
    'sgot': ['sgot', 'ast', 'aspartate'],
    'sgpt': ['sgpt', 'alt', 'alanine'],
    'bilirubin': ['bilirubin total', 'total bilirubin', 'tb'],
    'wbc': ['wbc', 'leukocyte', 'white blood'],
    'rbc': ['rbc', 'erythrocyte', 'red blood'],
    'platelet': ['platelet', 'platelets', 'thrombocyte'],
  };

  Future<ExtractedLabData> extractFromImage(String imagePath) async {
    try {
      final inputImage = InputImage.fromFilePath(imagePath);
      final recognizedText = await _textRecognizer.processImage(inputImage);
      
      final rawText = recognizedText.text;
      
      if (rawText.isEmpty) {
        return ExtractedLabData(rawText: '', values: {});
      }
      
      final llmProcessed = await _callAppwriteFunction(rawText);
      
      if (llmProcessed != null) {
        return llmProcessed;
      }
      
      return _fallbackParse(rawText);
    } catch (e) {
      debugPrint('Lab report OCR failed: $e');
      return ExtractedLabData(rawText: '', values: {});
    }
  }

  Future<ExtractedLabData?> _callAppwriteFunction(String rawText) async {
    try {
      final response = await http.post(
        Uri.parse('https://cloud.fitkarma.com/v1/functions/lab-report-parser'),
        headers: {
          'Content-Type': 'application/json',
          'x-appwrite-project': 'fitkarma',
        },
        body: jsonEncode({'text': rawText}),
      ).timeout(const Duration(seconds: 30));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final values = (data['values'] as Map<String, dynamic>?)
            ?.map((k, v) => MapEntry(k, (v as num?)?.toDouble())) ?? {};
        
        return ExtractedLabData(
          rawText: rawText,
          values: values,
          confidence: data['confidence'] as double? ?? 0.5,
        );
      }
    } catch (e) {
      debugPrint('LLM extraction failed, falling back: $e');
    }
    return null;
  }

  ExtractedLabData _fallbackParse(String rawText) {
    final values = <String, double>{};
    final lines = rawText.split('\n');
    final valuePattern = RegExp(r'(\d+(?:\.\d+)?)\s*(?:mg|dL|µg|mcg|U|L|%|ng|pg|/µL|/mm³|g/dL)?', caseSensitive: false);
    final rangePattern = RegExp(r'[\[\(]?\s*(\d+(?:\.\d+)?)\s*[-–—]\s*(\d+(?:\.\d+)?)\s*[\]\)]?', caseSensitive: false);
    
    for (final line in lines) {
      final lowerLine = line.toLowerCase();
      
      for (final entry in _labTestPatterns.entries) {
        for (final pattern in entry.value) {
          if (lowerLine.contains(pattern)) {
            final valueMatch = valuePattern.firstMatch(line);
            if (valueMatch != null) {
              final value = double.tryParse(valueMatch.group(1)!);
              if (value != null && value > 0) {
                values[entry.key] = value;
              }
              break;
            }
          }
        }
      }
    }
    
    return ExtractedLabData(rawText: rawText, values: values);
  }

  void dispose() {
    _textRecognizer.close();
  }
}

class ExtractedLabData {
  final String rawText;
  final Map<String, double?> values;
  final double confidence;

  ExtractedLabData({
    required this.rawText,
    required this.values,
    this.confidence = 1.0,
  });

  double? operator [](String key) => values[key];

  Map<String, dynamic> toJson() => values.map((k, v) => MapEntry(k, v));

  @override
  String toString() => 'ExtractedLabData(${values.length} values)';
}