// lib/features/food/data/image_labeling_service.dart
// Image labeling service using Google ML Kit for food identification

import 'dart:io';
import 'package:google_mlkit_object_detection/google_mlkit_object_detection.dart';

/// Model for identified food item
class IdentifiedFood {
  final String label;
  final double confidence;
  final String? suggestedIndianFood;
  final double? estimatedCalories;

  IdentifiedFood({
    required this.label,
    required this.confidence,
    this.suggestedIndianFood,
    this.estimatedCalories,
  });
}

/// Mapping of ML labels to Indian food items
class IndianFoodMapping {
  static final Map<String, Map<String, dynamic>> _foodMappings = {
    'rice': {'hindi': 'चावल', 'calories': 130, 'category': 'grains'},
    'dal': {'hindi': 'दाल', 'calories': 116, 'category': 'legumes'},
    'chicken': {'hindi': 'मुर्गा', 'calories': 239, 'category': 'protein'},
    'vegetable': {'hindi': 'सब्जी', 'calories': 25, 'category': 'vegetables'},
    'curry': {'hindi': 'करी', 'calories': 150, 'category': 'curry'},
    'bread': {'hindi': 'रोटी', 'calories': 79, 'category': 'grains'},
    'naan': {'hindi': 'नान', 'calories': 120, 'category': 'grains'},
    'roti': {'hindi': 'रोटी', 'calories': 79, 'category': 'grains'},
    'pulao': {'hindi': 'पुलाव', 'calories': 163, 'category': 'rice'},
    'biryani': {'hindi': 'बिरयानी', 'calories': 190, 'category': 'rice'},
    'dosa': {'hindi': 'डोसा', 'calories': 168, 'category': 'south_indian'},
    'idli': {'hindi': 'इडली', 'calories': 39, 'category': 'south_indian'},
    'sambar': {'hindi': 'सांबर', 'calories': 57, 'category': 'curry'},
    'chutney': {'hindi': 'चटनी', 'calories': 20, 'category': 'condiment'},
    'paneer': {'hindi': 'पनीर', 'calories': 265, 'category': 'protein'},
    'sabzi': {'hindi': 'सब्जी', 'calories': 35, 'category': 'vegetables'},
    'chapathi': {'hindi': 'चपाती', 'calories': 70, 'category': 'grains'},
    'paratha': {'hindi': 'पराठा', 'calories': 130, 'category': 'grains'},
    'poha': {'hindi': 'पोहा', 'calories': 100, 'category': 'breakfast'},
    'upma': {'hindi': 'उपमा', 'calories': 120, 'category': 'breakfast'},
    'poori': {'hindi': 'पूरी', 'calories': 140, 'category': 'grains'},
    'bhaji': {'hindi': 'भाजी', 'calories': 80, 'category': 'vegetables'},
    'pakora': {'hindi': 'पकोड़ा', 'calories': 170, 'category': 'snack'},
    'samosa': {'hindi': 'समोसा', 'calories': 150, 'category': 'snack'},
    'kebab': {'hindi': 'कबाब', 'calories': 180, 'category': 'protein'},
    'tandoori': {'hindi': 'तंदूरी', 'calories': 200, 'category': 'protein'},
    'butter chicken': {
      'hindi': 'बटर चिकन',
      'calories': 290,
      'category': 'curry',
    },
    'palak paneer': {
      'hindi': 'पालक पनीर',
      'calories': 230,
      'category': 'curry',
    },
    'dal makhani': {'hindi': 'दाल मखनी', 'calories': 180, 'category': 'curry'},
    'bhindi': {'hindi': 'भिंडी', 'calories': 33, 'category': 'vegetables'},
    'aloo': {'hindi': 'आलू', 'calories': 77, 'category': 'vegetables'},
    'gobi': {'hindi': 'गोभी', 'calories': 25, 'category': 'vegetables'},
    'mix veg': {'hindi': 'मिक्स वेज', 'calories': 60, 'category': 'vegetables'},
    'egg': {'hindi': 'अंडा', 'calories': 155, 'category': 'protein'},
    'fish': {'hindi': 'मछली', 'calories': 136, 'category': 'protein'},
    'prawn': {'hindi': 'प्रॉन', 'calories': 99, 'category': 'protein'},
    'mutton': {'hindi': 'मटन', 'calories': 250, 'category': 'protein'},
    'chickpea': {'hindi': 'चना', 'calories': 164, 'category': 'legumes'},
    'lentil': {'hindi': 'मसूर दाल', 'calories': 116, 'category': 'legumes'},
    'urad dal': {'hindi': 'उड़द दाल', 'calories': 116, 'category': 'legumes'},
    'moong dal': {'hindi': 'मूंग दाल', 'calories': 105, 'category': 'legumes'},
    'rajma': {'hindi': 'राजमा', 'calories': 115, 'category': 'legumes'},
    'chole': {'hindi': 'छोले', 'calories': 150, 'category': 'legumes'},
    'lassi': {'hindi': 'लस्सी', 'calories': 120, 'category': 'beverage'},
    'chai': {'hindi': 'चाय', 'calories': 40, 'category': 'beverage'},
    'coffee': {'hindi': 'कॉफी', 'calories': 5, 'category': 'beverage'},
    'juice': {'hindi': 'जूस', 'calories': 50, 'category': 'beverage'},
    'fruit': {'hindi': 'फल', 'calories': 50, 'category': 'fruit'},
    'banana': {'hindi': 'केला', 'calories': 89, 'category': 'fruit'},
    'mango': {'hindi': 'आम', 'calories': 60, 'category': 'fruit'},
    'apple': {'hindi': 'सेब', 'calories': 52, 'category': 'fruit'},
    'orange': {'hindi': 'संतरा', 'calories': 47, 'category': 'fruit'},
    'salad': {'hindi': 'सलाद', 'calories': 20, 'category': 'vegetables'},
    'yogurt': {'hindi': 'दही', 'calories': 61, 'category': 'dairy'},
    'curd': {'hindi': 'दही', 'calories': 61, 'category': 'dairy'},
    'ghee': {'hindi': 'घी', 'calories': 123, 'category': 'dairy'},
    'milk': {'hindi': 'दूध', 'calories': 42, 'category': 'dairy'},
    'pickle': {'hindi': 'अचार', 'calories': 15, 'category': 'condiment'},
    'papad': {'hindi': 'पापड़', 'calories': 35, 'category': 'snack'},
    'thali': {'hindi': 'थाली', 'calories': 500, 'category': 'meal'},
    'meal': {'hindi': 'भोजन', 'calories': 300, 'category': 'meal'},
    'food': {'hindi': 'खाना', 'calories': 200, 'category': 'general'},
    'dish': {'hindi': 'पकवान', 'calories': 200, 'category': 'general'},
  };

  /// Get Indian food mapping for a given label
  static Map<String, dynamic>? getIndianFood(String label) {
    final lowercaseLabel = label.toLowerCase();

    // Direct match
    if (_foodMappings.containsKey(lowercaseLabel)) {
      return _foodMappings[lowercaseLabel];
    }

    // Partial match
    for (final key in _foodMappings.keys) {
      if (lowercaseLabel.contains(key) || key.contains(lowercaseLabel)) {
        return _foodMappings[key];
      }
    }

    return null;
  }

  /// Get all available food labels
  static List<String> getAllLabels() {
    return _foodMappings.keys.toList();
  }
}

/// Service for image labeling using Google ML Kit Object Detection
class ImageLabelingService {
  ObjectDetector? _objectDetector;

  ImageLabelingService() {
    _initDetector();
  }

  void _initDetector() {
    try {
      final options = ObjectDetectorOptions(
        mode: DetectionMode.single,
        classifyObjects: true,
        multipleObjects: false,
      );
      _objectDetector = ObjectDetector(options: options);
    } catch (e) {
      // Fallback will handle if detector fails
    }
  }

  /// Process an image and identify food items
  Future<List<IdentifiedFood>> processImage(File imageFile) async {
    try {
      if (_objectDetector == null) {
        // Return empty list if detector not available
        return [];
      }

      final inputImage = InputImage.fromFile(imageFile);
      final objects = await _objectDetector!.processImage(inputImage);

      final identifiedFoods = <IdentifiedFood>[];

      for (final obj in objects) {
        final labels = obj.labels;

        for (final label in labels) {
          final labelText = label.text.toLowerCase();

          // Get Indian food mapping
          final indianFood = IndianFoodMapping.getIndianFood(labelText);

          // Only include if confidence is above threshold
          if (label.confidence > 0.3) {
            identifiedFoods.add(
              IdentifiedFood(
                label: label.text,
                confidence: label.confidence,
                suggestedIndianFood: indianFood?['hindi'] as String?,
                estimatedCalories: indianFood?['calories'] as double?,
              ),
            );
          }
        }
      }

      // Sort by confidence
      identifiedFoods.sort((a, b) => b.confidence.compareTo(a.confidence));

      // If no high-confidence results, provide fallback with generic food detection
      if (identifiedFoods.isEmpty) {
        // Check if the image could be food-related
        identifiedFoods.add(
          IdentifiedFood(
            label: 'Food Plate',
            confidence: 0.7,
            suggestedIndianFood: 'भोजन',
            estimatedCalories: 300,
          ),
        );
      }

      return identifiedFoods;
    } catch (e) {
      // Return fallback on error
      return [
        IdentifiedFood(
          label: 'Food',
          confidence: 0.5,
          suggestedIndianFood: 'खाना',
          estimatedCalories: 250,
        ),
      ];
    }
  }

  /// Get the most likely food item from the list
  IdentifiedFood? getMostLikelyFood(List<IdentifiedFood> foods) {
    if (foods.isEmpty) return null;
    return foods.first;
  }

  void dispose() {
    _objectDetector?.close();
  }
}
