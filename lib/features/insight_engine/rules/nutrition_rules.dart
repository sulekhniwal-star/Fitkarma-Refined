import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to nutrition: protein, calories, macros
class ProteinGoalRule extends InsightRule {
  @override
  String get id => 'nutrition_protein_goal';

  @override
  String get name => 'Protein Goal';

  @override
  InsightCategory get category => InsightCategory.nutrition;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.restaurant.codePoint;

  @override
  int get colorValue => 0xFF4CAF50; // Green

  @override
  int get cooldownDays => 3;

  @override
  List<String> get requiredDataTypes => ['protein', 'nutritionGoal'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableNutritionInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final protein = userData['proteinGrams'] as double?;
    final goal = userData['dailyProteinGoal'] as double?;

    if (protein == null || goal == null || goal <= 0) return null;

    final percentage = (protein / goal * 100).round();

    if (percentage >= 100) {
      return '🎉 Amazing! You hit $percentage% of your daily protein goal!';
    } else if (percentage >= 75) {
      return '💪 So close! You\'ve reached $percentage% of your protein goal. Just a bit more!';
    } else if (percentage >= 50) {
      return '🥚 You\'re at $percentage% of your protein goal. Keep going!';
    } else if (percentage >= 25) {
      return '🍗 $percentage% protein done. Consider adding some protein-rich foods.';
    }
    return null;
  }
}

class LowProteinWarningRule extends InsightRule {
  @override
  String get id => 'nutrition_low_protein';

  @override
  String get name => 'Low Protein Warning';

  @override
  InsightCategory get category => InsightCategory.nutrition;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.warning_amber.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['protein', 'nutritionGoal'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableNutritionInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final protein = userData['proteinGrams'] as double?;
    final goal = userData['dailyProteinGoal'] as double?;

    if (protein == null || goal == null || goal <= 0) return null;

    final percentage = protein / goal * 100;

    if (percentage < 25) {
      return '⚠️ Low protein intake today (${protein.toStringAsFixed(0)}g). Consider eggs, chicken, or legumes.';
    }
    return null;
  }
}

class CalorieGoalRule extends InsightRule {
  @override
  String get id => 'nutrition_calorie_goal';

  @override
  String get name => 'Calorie Balance';

  @override
  InsightCategory get category => InsightCategory.nutrition;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.local_fire_department.codePoint;

  @override
  int get colorValue => 0xFFE91E63; // Pink

  @override
  int get cooldownDays => 3;

  @override
  List<String> get requiredDataTypes => ['calories'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableNutritionInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final calories = userData['calories'] as double?;
    final protein = userData['proteinGrams'] as double?;

    if (calories == null || calories < 500) return null;

    // High protein percentage check
    if (protein != null && calories > 0) {
      final proteinCals = protein * 4;
      final proteinPercent = (proteinCals / calories * 100).round();

      if (proteinPercent > 40) {
        return '🥗 Great protein distribution! $proteinPercent% of your calories from protein.';
      }
    }

    return null;
  }
}

class MacroBalanceRule extends InsightRule {
  @override
  String get id => 'nutrition_macro_balance';

  @override
  String get name => 'Macro Balance';

  @override
  InsightCategory get category => InsightCategory.nutrition;

  @override
  InsightPriority get priority => InsightPriority.low;

  @override
  int get iconCodePoint => Icons.pie_chart.codePoint;

  @override
  int get colorValue => 0xFF9C27B0; // Purple

  @override
  int get cooldownDays => 5;

  @override
  List<String> get requiredDataTypes => ['protein', 'carbs', 'fat'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableNutritionInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final protein = userData['proteinGrams'] as double?;
    final carbs = userData['carbsGrams'] as double?;
    final fat = userData['fatGrams'] as double?;

    if (protein == null || carbs == null || fat == null) return null;
    if (protein < 10 || carbs < 10 || fat < 5) return null;

    final proteinCals = protein * 4;
    final carbsCals = carbs * 4;
    final fatCals = fat * 9;
    final totalCals = proteinCals + carbsCals + fatCals;

    if (totalCals <= 0) return null;

    final proteinPercent = (proteinCals / totalCals * 100).round();

    // Check for high protein
    if (proteinPercent >= 35 && proteinPercent <= 50) {
      return '💪 Your macros are well-balanced with $proteinPercent% protein - great for fitness!';
    }

    return null;
  }
}

/// Get all nutrition rules
List<InsightRule> getNutritionRules() {
  return [
    ProteinGoalRule(),
    LowProteinWarningRule(),
    CalorieGoalRule(),
    MacroBalanceRule(),
  ];
}
