// lib/features/food/data/ocr_nutrition_service.dart
// OCR service for reading nutrition labels using Google ML Kit

import 'dart:io';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

/// Model for extracted nutrition data from OCR
class ExtractedNutritionData {
  final String rawText;
  final double? calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final double? saturatedFat;
  final double? transFat;
  final double? cholesterol;
  final double? sodium;
  final double? fiber;
  final double? sugar;
  final double? vitaminD;
  final double? vitaminA;
  final double? vitaminC;
  final double? calcium;
  final double? iron;
  final double? potassium;
  final double? servingSize;
  final int? servingsPerContainer;

  ExtractedNutritionData({
    required this.rawText,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.saturatedFat,
    this.transFat,
    this.cholesterol,
    this.sodium,
    this.fiber,
    this.sugar,
    this.vitaminD,
    this.vitaminA,
    this.vitaminC,
    this.calcium,
    this.iron,
    this.potassium,
    this.servingSize,
    this.servingsPerContainer,
  });

  bool get hasData =>
      calories != null || protein != null || carbs != null || fat != null;
}

/// Service for OCR text recognition on nutrition labels
class OcrNutritionService {
  final TextRecognizer _textRecognizer;

  OcrNutritionService()
    : _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Process an image file and extract nutrition information
  Future<ExtractedNutritionData> processImage(File imageFile) async {
    try {
      final inputImage = InputImage.fromFile(imageFile);
      final recognizedText = await _textRecognizer.processImage(inputImage);

      final rawText = recognizedText.text;
      final nutritionData = _parseNutritionText(rawText);

      return ExtractedNutritionData(
        rawText: rawText,
        calories: nutritionData['calories'],
        protein: nutritionData['protein'],
        carbs: nutritionData['carbs'],
        fat: nutritionData['fat'],
        saturatedFat: nutritionData['saturatedFat'],
        transFat: nutritionData['transFat'],
        cholesterol: nutritionData['cholesterol'],
        sodium: nutritionData['sodium'],
        fiber: nutritionData['fiber'],
        sugar: nutritionData['sugar'],
        vitaminD: nutritionData['vitaminD'],
        vitaminA: nutritionData['vitaminA'],
        vitaminC: nutritionData['vitaminC'],
        calcium: nutritionData['calcium'],
        iron: nutritionData['iron'],
        potassium: nutritionData['potassium'],
        servingSize: nutritionData['servingSize'],
        servingsPerContainer: nutritionData['servingsPerContainer'],
      );
    } catch (e) {
      return ExtractedNutritionData(
        rawText: '',
        calories: null,
        protein: null,
        carbs: null,
        fat: null,
      );
    }
  }

  /// Parse nutrition values from recognized text
  Map<String, dynamic> _parseNutritionText(String text) {
    final result = <String, dynamic>{};
    final lines = text.toLowerCase().split('\n');

    // Look for serving size
    result['servingSize'] = _extractNumber(text, [
      r'serving size\s*(\d+\.?\d*)\s*(g|ml|oz)?',
      r'serving\s*(\d+\.?\d*)\s*(g|ml|oz)',
    ]);

    result['servingsPerContainer'] = _extractInt(text, [
      r'servings per container\s*(\d+)',
    ]);

    // Extract calories
    result['calories'] = _extractNumber(text, [
      r'calories\s*(\d+\.?\d*)',
      r'energy\s*(\d+\.?\d*)\s*kcal',
    ]);

    // Extract macronutrients
    result['protein'] = _extractNumber(text, [r'protein\s*(\d+\.?\d*)\s*g']);

    result['carbs'] = _extractNumber(text, [
      r'(total\s*)?carbohydrate[s]?\s*(\d+\.?\d*)\s*g',
      r'carb[s]?\s*(\d+\.?\d*)\s*g',
    ]);

    result['fat'] = _extractNumber(text, [
      r'total\s*fat\s*(\d+\.?\d*)\s*g',
      r'fat\s*(\d+\.?\d*)\s*g',
    ]);

    result['saturatedFat'] = _extractNumber(text, [
      r'saturated\s*fat\s*(\d+\.?\d*)\s*g',
      r'sat\.?\s*fat\s*(\d+\.?\d*)\s*g',
    ]);

    result['transFat'] = _extractNumber(text, [
      r'trans\s*fat\s*(\d+\.?\d*)\s*g',
      r'trans\s*fatty\s*acid[s]?\s*(\d+\.?\d*)\s*g',
    ]);

    result['cholesterol'] = _extractNumber(text, [
      r'cholesterol\s*(\d+\.?\d*)\s*mg',
    ]);

    result['sodium'] = _extractNumber(text, [
      r'sodium\s*(\d+\.?\d*)\s*mg',
      r'salt\s*(\d+\.?\d*)\s*mg',
    ]);

    // Extract fiber
    result['fiber'] = _extractNumber(text, [
      r'(dietary\s*)?fiber\s*(\d+\.?\d*)\s*g',
    ]);

    // Extract sugar
    result['sugar'] = _extractNumber(text, [
      r'(total\s*)?sugars?\s*(\d+\.?\d*)\s*g',
      r'sugar[s]?\s*(\d+\.?\d*)\s*g',
    ]);

    // Extract vitamins
    result['vitaminD'] = _extractNumber(text, [
      r'vitamin\s*d\s*(\d+\.?\d*)\s*(mcg|iu)',
    ]);

    result['vitaminA'] = _extractNumber(text, [
      r'vitamin\s*a\s*(\d+\.?\d*)\s*(mcg|iu)',
    ]);

    result['vitaminC'] = _extractNumber(text, [
      r'vitamin\s*c\s*(\d+\.?\d*)\s*mg',
    ]);

    // Extract minerals
    result['calcium'] = _extractNumber(text, [r'calcium\s*(\d+\.?\d*)\s*mg']);

    result['iron'] = _extractNumber(text, [r'iron\s*(\d+\.?\d*)\s*mg']);

    result['potassium'] = _extractNumber(text, [
      r'potassium\s*(\d+\.?\d*)\s*mg',
    ]);

    return result;
  }

  /// Extract a number using regex patterns
  double? _extractNumber(String text, List<String> patterns) {
    for (final pattern in patterns) {
      final regex = RegExp(pattern, caseSensitive: false);
      final match = regex.firstMatch(text);
      if (match != null && match.groupCount >= 1) {
        final value = double.tryParse(match.group(1)!);
        if (value != null && value > 0) {
          return value;
        }
      }
    }
    return null;
  }

  /// Extract an integer using regex patterns
  int? _extractInt(String text, List<String> patterns) {
    for (final pattern in patterns) {
      final regex = RegExp(pattern, caseSensitive: false);
      final match = regex.firstMatch(text);
      if (match != null && match.groupCount >= 1) {
        return int.tryParse(match.group(1)!);
      }
    }
    return null;
  }

  void dispose() {
    _textRecognizer.close();
  }
}
