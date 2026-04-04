import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/drift_service.dart';

part 'food_nlp_service.g.dart';

class ParsedFood {
  final String query;
  final double quantity;
  final String unit;
  final FoodItem? matchedItem;
  final double calculatedCalories;
  final double grams;

  ParsedFood({
    required this.query,
    required this.quantity,
    required this.unit,
    this.matchedItem,
    this.calculatedCalories = 0,
    this.grams = 0,
  });
}

@riverpod
class FoodNLPService extends _$FoodNLPService {
  @override
  void build() {}

  static const Map<String, double> _textNumbers = {
    'half': 0.5,
    'quarter': 0.25,
    'one': 1.0,
    'two': 2.0,
    'three': 3.0,
    'four': 4.0,
    'a': 1.0,
    'an': 1.0,
  };

  static const List<String> _indianUnits = [
    'katori', 'bowl', 'glass', 'cup', 'plate', 'piece', 'roti', 'paratha', 
    'chapati', 'idli', 'dosa', 'vada', 'puri', 'ladle', 'scoop', 'gm', 'kg', 'ml', 'unit', 'serving'
  ];

  Future<List<ParsedFood>> parse(String input) async {
    final results = <ParsedFood>[];
    final db = ref.read(driftDbProvider);

    // 1. Split by common separators ("and", ",", "+", "with", "followed by")
    final segments = input.toLowerCase().split(RegExp(r'and|,|\+|\bwith\b|\bfollowed by\b'));

    for (var segment in segments) {
      segment = segment.trim();
      if (segment.isEmpty) continue;

      // 2. Extract Quantity
      double quantity = 1.0;
      String remaining = segment;

      // Check for numeric quantity (e.g., "1.5", "2")
      final numericMatch = RegExp(r'^(\d+(\.\d+)?)').firstMatch(segment);
      if (numericMatch != null) {
        quantity = double.tryParse(numericMatch.group(0)!) ?? 1.0;
        remaining = segment.replaceFirst(numericMatch.group(0)!, '').trim();
      } else {
        // Check for text numbers (e.g., "half", "two")
        for (final entry in _textNumbers.entries) {
          if (segment.startsWith('${entry.key} ')) {
            quantity = entry.value;
            remaining = segment.replaceFirst(entry.key, '').trim();
            break;
          }
        }
      }

      // 3. Extract Unit
      String foundUnit = 'piece';
      String foodName = remaining;

      for (final unit in _indianUnits) {
        if (remaining.startsWith(unit) || remaining.startsWith('${unit}s')) {
          foundUnit = unit;
          foodName = remaining.replaceFirst(RegExp('^${unit}s?'), '').replaceFirst(RegExp(r'^of\s+'), '').trim();
          break;
        }
      }

      // 4. Search Local Database and Scale Nutrition
      if (foodName.isNotEmpty) {
        final matches = await db.searchFoodFts(foodName);
        if (matches.isNotEmpty) {
          final item = matches.first;
          final scaleData = _calculateWeightAndCals(item, quantity, foundUnit);
          
          results.add(ParsedFood(
            query: foodName,
            quantity: quantity,
            unit: foundUnit,
            matchedItem: item,
            grams: scaleData.grams,
            calculatedCalories: scaleData.calories,
          ));
        } else {
          results.add(ParsedFood(
            query: foodName,
            quantity: quantity,
            unit: foundUnit,
          ));
        }
      }
    }

    return results;
  }

  ({double grams, double calories}) _calculateWeightAndCals(FoodItem item, double quantity, String unit) {
    double grams = 0;
    
    // 1. Check servingSizes JSON in the database item
    if (item.servingSizes != null) {
      try {
        final List<dynamic> sizes = jsonDecode(item.servingSizes!);
        final match = sizes.firstWhere((s) => s['name'] == unit, orElse: () => null);
        if (match != null) {
          grams = (match['grams'] as num).toDouble() * quantity;
        }
      } catch (_) {}
    }

    // 2. Fallback to common unit heuristics
    if (grams == 0) {
      final Map<String, double> heuristics = {
        'katori': 150.0,
        'bowl': 250.0,
        'glass': 250.0,
        'cup': 200.0,
        'roti': 40.0,
        'chapati': 40.0,
        'paratha': 80.0,
        'idli': 50.0,
        'piece': 50.0,
        'gm': 1.0,
        'ml': 1.0,
      };
      grams = (heuristics[unit] ?? 100.0) * quantity;
    }

    final calories = (item.caloriesPer100g / 100.0) * grams;
    return (grams: grams, calories: calories);
  }
}
