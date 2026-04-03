import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class NutritionRule extends InsightRule {
  @override
  String get id => 'nutrition_protein_low';

  @override
  String get category => 'nutrition';

  @override
  int get priority => 80;

  @override
  String get title => 'Low Protein Intake';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final protein = input.nutrition?['protein'] ?? 0;
    return protein < 50;
  }

  @override
  String message(InsightInput input) {
    final protein = input.nutrition?['protein'] ?? 0;
    return 'You had only ${protein.round()}g protein today. Add eggs, paneer, or dal to meet your target.';
  }

  @override
  String? get icon => '🥚';
}

class NutritionCalorieRule extends InsightRule {
  @override
  String get id => 'nutrition_calorie_high';

  @override
  String get category => 'nutrition';

  @override
  int get priority => 70;

  @override
  String get title => 'High Calorie Day';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final calories = input.nutrition?['calories'] ?? 0;
    return calories > 2500;
  }

  @override
  String message(InsightInput input) {
    final calories = input.nutrition?['calories'] ?? 0;
    return 'High calorie intake (${calories.round()} kcal). Great if active, otherwise consider lighter meals.';
  }

  @override
  String? get icon => '🔥';
}

class NutritionMicronutrientRule extends InsightRule {
  @override
  String get id => 'nutrition_micronutrient_gap';

  @override
  String get category => 'nutrition';

  @override
  int get priority => 60;

  @override
  String get title => 'Micronutrient Gap';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final iron = input.nutrition?['iron'] ?? 0;
    return iron < 10;
  }

  @override
  String message(InsightInput input) {
    final iron = input.nutrition?['iron'] ?? 0;
    return 'Iron intake low (${iron.round()}mg). Add leafy greens or lentils tomorrow.';
  }

  @override
  String? get icon => '🥬';
}

class NutritionBalanceRule extends InsightRule {
  @override
  String get id => 'nutrition_macro_balance';

  @override
  String get category => 'nutrition';

  @override
  int get priority => 50;

  @override
  String get title => 'Balanced Macros';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final carbs = input.nutrition?['carbs'] ?? 0;
    final protein = input.nutrition?['protein'] ?? 0;
    final fat = input.nutrition?['fat'] ?? 0;
    final total = carbs + protein + fat;
    if (total == 0) return false;
    final carbsPct = (carbs / total * 100);
    return carbsPct >= 40 && carbsPct <= 65;
  }

  @override
  String message(InsightInput input) {
    return 'Great macro balance today! Your carbs/protein/fat ratio looks optimal.';
  }

  @override
  String? get icon => '⚖️';
}

List<InsightRule> get nutritionRules => [
  NutritionRule(),
  NutritionCalorieRule(),
  NutritionMicronutrientRule(),
  NutritionBalanceRule(),
];
