import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class NutritionData {
  final double? energy;
  final double? protein;
  final double? carbs;
  final double? fat;

  NutritionData({this.energy, this.protein, this.carbs, this.fat});
}

class OcrService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  /// Recognizes nutrition information from a label image.
  Future<NutritionData?> recognizeNutritionLabel(InputImage inputImage) async {
    try {
      final RecognizedText recognizedText = await _textRecognizer.processImage(inputImage);
      
      String fullText = recognizedText.text.toLowerCase();
      
      return NutritionData(
        energy: _extractValue(fullText, r'(energy|calories|kcal)\D*(\d+\.?\d*)'),
        protein: _extractValue(fullText, r'(protein)\D*(\d+\.?\d*)'),
        carbs: _extractValue(fullText, r'(carbohydrate|carbs)\D*(\d+\.?\d*)'),
        fat: _extractValue(fullText, r'(fat|total fat)\D*(\d+\.?\d*)'),
      );
    } catch (e) {
      return null;
    }
  }

  double? _extractValue(String text, String pattern) {
    final regex = RegExp(pattern);
    final match = regex.firstMatch(text);
    if (match != null && match.groupCount >= 2) {
      return double.tryParse(match.group(2)!);
    }
    return null;
  }

  void dispose() {
    _textRecognizer.close();
  }
}

