class NutritionCalculator {
  /// Calculates Basal Metabolic Rate (BMR) using Mifflin-St Jeor Equation.
  static double calculateBMR({
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
  }) {
    if (isMale) {
      return (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
    } else {
      return (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
    }
  }

  /// Calculates Total Daily Energy Expenditure (TDEE).
  static double calculateTDEE({
    required double bmr,
    required double activityMultiplier,
  }) {
    return bmr * activityMultiplier;
  }

  /// Map activity level to multiplier.
  static double getActivityMultiplier(String level) {
    switch (level.toLowerCase()) {
      case 'sedentary':
        return 1.2;
      case 'lightly_active':
        return 1.375;
      case 'moderately_active':
        return 1.55;
      case 'very_active':
        return 1.725;
      case 'extra_active':
        return 1.9;
      default:
        return 1.2;
    }
  }

  /// Calculates targets based on goal.
  static int calculateCalorieGoal(double tdee, String goal) {
    switch (goal.toLowerCase()) {
      case 'lose_weight':
        return (tdee - 500).round();
      case 'gain_weight':
        return (tdee + 500).round();
      case 'maintain':
      default:
        return tdee.round();
    }
  }
}
