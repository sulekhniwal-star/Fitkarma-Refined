import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final nutritionServiceProvider = Provider<NutritionService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return NutritionService(db);
});

class NutritionService {
  final AppDatabase _db;

  NutritionService(this._db);

  double calculateTdee({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required String gender,
    required double activityMultiplier,
  }) {
    double bmr;
    if (gender.toLowerCase() == 'male') {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * ageYears) + 5;
    } else {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * ageYears) - 161;
    }
    return bmr * activityMultiplier;
  }

  MacroTargets calculateMacros(double tdee) {
    const carbsPercent = 55;
    const proteinPercent = 20;
    const fatPercent = 25;

    const carbsCalPerGram = 4.0;
    const proteinCalPerGram = 4.0;
    const fatCalPerGram = 9.0;

    final carbsGrams = (tdee * carbsPercent / 100) / carbsCalPerGram;
    final proteinGrams = (tdee * proteinPercent / 100) / proteinCalPerGram;
    final fatGrams = (tdee * fatPercent / 100) / fatCalPerGram;

    return MacroTargets(
      calories: tdee,
      carbsPercent: carbsPercent.toDouble(),
      proteinPercent: proteinPercent.toDouble(),
      fatPercent: fatPercent.toDouble(),
      carbsGrams: carbsGrams,
      proteinGrams: proteinGrams,
      fatGrams: fatGrams,
    );
  }

  Future<void> saveNutritionGoals({
    required String odUserId,
    required double calorieGoal,
  }) async {
    await _db.into(_db.nutritionGoals).insertOnConflictUpdate(
      NutritionGoalsCompanion.insert(
        userId: odUserId,
        calorieGoal: calorieGoal,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<NutritionGoal?> getNutritionGoals(String odUserId) async {
    final results = await (_db.select(_db.nutritionGoals)
          ..where((t) => t.userId.equals(odUserId))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<Map<String, double>> getDailyTotals(String odUserId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    final logs = await (_db.select(_db.foodLogs)
          ..where((t) =>
              t.userId.equals(odUserId) &
              t.loggedAt.isBiggerOrEqualValue(dayStart) &
              t.loggedAt.isSmallerThanValue(dayEnd)))
        .get();

    double calories = 0, protein = 0, carbs = 0, fat = 0;

    for (final log in logs) {
      calories += log.calories;
      protein += log.proteinG;
      carbs += log.carbsG;
      fat += log.fatG;
    }

    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'iron': 0,
      'vitaminD': 0,
      'vitaminB12': 0,
      'calcium': 0,
    };
  }

  MicronutrientGap? findBiggestGap(Map<String, double> totals, NutritionGoal? goals) {
    final defaultRdas = {
      'Iron': 18.0,
      'Vitamin D': 15.0,
      'Vitamin B12': 2.4,
      'Calcium': 1000.0,
    };

    final gaps = defaultRdas.entries.map((e) {
      final current = totals[e.key] ?? 0;
      return MicronutrientGap(
        nutrient: e.key,
        current: current,
        target: e.value,
        gap: (e.value - current).clamp(0, e.value),
        suggestions: _getSuggestions(e.key),
      );
    }).toList();

    gaps.sort((a, b) => b.gap.compareTo(a.gap));
    return gaps.first.gap > 0 ? gaps.first : null;
  }

  List<String> _getSuggestions(String nutrient) {
    switch (nutrient) {
      case 'Iron':
        return ['Add 1 cup spinach (6mg)', 'Add 50g paneer (2mg)', 'Add dal'];
      case 'Vitamin D':
        return ['Add 1 egg yolk (1mcg)', 'Add fish', 'Get sunlight'];
      case 'Vitamin B12':
        return ['Add 1 egg (0.5mcg)', 'Add yogurt (1mcg)'];
      case 'Calcium':
        return ['Add milk (300mg)', 'Add paneer (150mg)', 'Add yogurt'];
      default:
        return [];
    }
  }

  List<GroceryItem> generateGroceryList(NutritionGoal? goals) {
    if (goals == null) return [];

    return [
      GroceryItem(name: 'Whole grains/Roti', quantity: '7 days', reason: 'Carbs target'),
      GroceryItem(name: 'Pulses/Dal', quantity: '1 kg', reason: 'Protein + Iron'),
      GroceryItem(name: 'Eggs', quantity: '14', reason: 'Protein + B12'),
      GroceryItem(name: 'Milk', quantity: '3 liters', reason: 'Calcium + Protein'),
      GroceryItem(name: 'Paneer/Cottage Cheese', quantity: '500g', reason: 'Protein + Calcium'),
      GroceryItem(name: 'Leafy greens', quantity: '1 bunch', reason: 'Iron + Calcium'),
    ];
  }
}

class MacroTargets {
  final double calories;
  final double carbsPercent;
  final double proteinPercent;
  final double fatPercent;
  final double carbsGrams;
  final double proteinGrams;
  final double fatGrams;

  MacroTargets({
    required this.calories,
    required this.carbsPercent,
    required this.proteinPercent,
    required this.fatPercent,
    required this.carbsGrams,
    required this.proteinGrams,
    required this.fatGrams,
  });
}

class MicronutrientGap {
  final String nutrient;
  final double current;
  final double target;
  final double gap;
  final List<String> suggestions;

  MicronutrientGap({
    required this.nutrient,
    required this.current,
    required this.target,
    required this.gap,
    required this.suggestions,
  });

  String get summaryText => "You're ${gap.round()} $nutrient short";
  String get suggestionText => suggestions.isNotEmpty ? suggestions.first : '';
}

class GroceryItem {
  final String name;
  final String quantity;
  final String reason;

  GroceryItem({
    required this.name,
    required this.quantity,
    required this.reason,
  });
}

enum NutritionStatus { green, yellow, red }

extension NutritionStatusExtension on double {
  NutritionStatus getStatus(double target) {
    final percent = (this / target * 100);
    if (percent >= 90 && percent <= 110) return NutritionStatus.green;
    if (percent >= 70) return NutritionStatus.yellow;
    return NutritionStatus.red;
  }
}