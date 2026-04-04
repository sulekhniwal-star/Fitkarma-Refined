import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vision_service.g.dart';

class VisionService {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);

  Future<Map<String, double>> parseNutritionLabel(String imagePath) async {
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    
    Map<String, double> results = {};
    
    // Simple heuristic parser for common Indian label keywords
    for (var block in recognizedText.blocks) {
      for (var line in block.lines) {
        final text = line.text.toLowerCase();
        
        // Energy / Calories
        if (text.contains('energy') || text.contains('kcal') || text.contains('calories')) {
          _extractValue(text, 'calories', results);
        }
        // Protein
        if (text.contains('protein')) {
          _extractValue(text, 'protein', results);
        }
        // Fat
        if (text.contains('fat') && !text.contains('saturated') && !text.contains('trans')) {
          _extractValue(text, 'fat', results);
        }
        // Carbs
        if (text.contains('carb') || text.contains('carbohydrate')) {
          _extractValue(text, 'carbs', results);
        }
        // Iron
        if (text.contains('iron')) {
          _extractValue(text, 'iron', results);
        }
        // Calcium
        if (text.contains('calcium')) {
          _extractValue(text, 'calcium', results);
        }
      }
    }
    
    return results;
  }

  void _extractValue(String text, String key, Map<String, double> results) {
    // Regex to find numbers followed by optional units like g, kcal, mg
    final regExp = RegExp(r'(\d+\.?\d*)');
    final match = regExp.firstMatch(text);
    if (match != null) {
      results[key] = double.tryParse(match.group(1)!) ?? 0.0;
    }
  }

  void dispose() {
    _textRecognizer.close();
  }
}

@riverpod
VisionService visionService(Ref ref) {
  final service = VisionService();
  ref.onDispose(() => service.dispose());
  return service;
}
