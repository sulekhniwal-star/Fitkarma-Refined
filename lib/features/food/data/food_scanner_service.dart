import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scannerServiceProvider = Provider<FoodScannerService>((ref) => FoodScannerService());

class FoodScannerService {
  Future<String?> fetchFromOpenFoodFacts(String barcode) async {
    try {
      final response = await http.get(
        Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode.json'),
      );

      if (response.statusCode != 200) return null;

      final data = json.decode(response.body);
      if (data['status'] != 1) return null;

      final product = data['product'];
      return product['product_name'] ?? product['product_name_en'] ?? 'Unknown';
    } catch (e) {
      return null;
    }
  }

  Future<OpenFoodFactsResult?> getProductNutrition(String barcode) async {
    try {
      final response = await http.get(
        Uri.parse('https://world.openfoodfacts.org/api/v2/product/$barcode.json'),
      );

      if (response.statusCode != 200) return null;

      final data = json.decode(response.body);
      if (data['status'] != 1) return null;

      final product = data['product'];
      return OpenFoodFactsResult(
        name: product['product_name'] ?? product['product_name_en'] ?? 'Unknown',
        calories: _parseNutrient(product, 'energy-kcal_100g'),
        protein: _parseNutrient(product, 'proteins_100g'),
        carbs: _parseNutrient(product, 'carbohydrates_100g'),
        fat: _parseNutrient(product, 'fat_100g'),
        vitaminD: _parseNutrient(product, 'vitamin-d_100g'),
        vitaminB12: _parseNutrient(product, 'vitamin-b12_100g'),
        iron: _parseNutrient(product, 'iron_100g'),
        calcium: _parseNutrient(product, 'calcium_100g'),
      );
    } catch (e) {
      return null;
    }
  }

  double _parseNutrient(Map<String, dynamic> product, String key) {
    final value = product[key];
    if (value == null) return 0;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }
}

class OpenFoodFactsResult {
  final String name;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double vitaminD;
  final double vitaminB12;
  final double iron;
  final double calcium;

  OpenFoodFactsResult({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.vitaminD = 0,
    this.vitaminB12 = 0,
    this.iron = 0,
    this.calcium = 0,
  });
}

class VoiceLogState {
  final bool isListening;
  final String recognizedText;
  final List<String> suggestions;

  VoiceLogState({
    this.isListening = false,
    this.recognizedText = '',
    this.suggestions = const [],
  });

  VoiceLogState copyWith({
    bool? isListening,
    String? recognizedText,
    List<String>? suggestions,
  }) {
    return VoiceLogState(
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
      suggestions: suggestions ?? this.suggestions,
    );
  }
}

class VoiceLogNotifier extends Notifier<VoiceLogState> {
  @override
  VoiceLogState build() => VoiceLogState();

  void setListening(bool listening) {
    state = state.copyWith(isListening: listening);
  }

  void setRecognizedText(String text) {
    state = state.copyWith(
      recognizedText: text,
      suggestions: _parseSuggestions(text),
    );
  }

  void clear() {
    state = VoiceLogState();
  }

  List<String> _parseSuggestions(String text) {
    final words = text.toLowerCase().split(' ');
    final indianFoods = [
      'rice', 'dal', 'roti', 'sabzi', 'paneer', 'chicken', 'fish',
      'idli', 'dosa', 'sambar', 'biryani', 'naan', 'paratha',
      'khichdi', 'poha', 'upma', 'uttapam', 'vada', 'lassi', 'chai',
    ];
    return words.where((w) => indianFoods.contains(w)).toList();
  }
}

final voiceLogProvider = NotifierProvider<VoiceLogNotifier, VoiceLogState>(() => VoiceLogNotifier());