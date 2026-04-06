
enum FitnessGoal { weightLoss, maintenance, muscleGain, athletic }

enum ActivityLevel {
  sedentary,    // desk job, no exercise
  lightlyActive, // 1-3 days/week
  moderatelyActive, // 3-5 days/week
  veryActive,   // 6-7 hard days/week
  extremelyActive, // 2x/day or physical job
}

enum Gender { male, female, other }

class NutritionGoalTargets {
  const NutritionGoalTargets({
    required this.calorieTarget,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    // RDA micronutrient targets (per day)
    required this.ironMg,
    required this.calciumMg,
    required this.vitaminDMcg,
    required this.vitaminB12Mcg,
  });

  final int calorieTarget;
  final int proteinG;
  final int carbsG;
  final int fatG;
  final double ironMg;
  final double calciumMg;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
}

class TdeeCalculator {
  TdeeCalculator._();

  /// Returns Basal Metabolic Rate using Mifflin-St Jeor (kcal/day).
  static double bmr({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required Gender gender,
  }) {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * ageYears;
    return gender == Gender.male ? base + 5 : base - 161;
  }

  /// Returns Total Daily Energy Expenditure = BMR × activity multiplier.
  static double tdee({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required Gender gender,
    required ActivityLevel activity,
  }) {
    final b = bmr(weightKg: weightKg, heightCm: heightCm, ageYears: ageYears, gender: gender);
    return b * _activityMultiplier(activity);
  }

  /// Adjusts TDEE for fitness goal and returns full [NutritionGoalTargets].
  static NutritionGoalTargets calculateGoals({
    required double weightKg,
    required double heightCm,
    required int ageYears,
    required Gender gender,
    required ActivityLevel activity,
    required FitnessGoal goal,
  }) {
    double calories = tdee(
      weightKg: weightKg,
      heightCm: heightCm,
      ageYears: ageYears,
      gender: gender,
      activity: activity,
    );

    // Calorie adjustment per goal
    switch (goal) {
      case FitnessGoal.weightLoss:
        calories *= 0.80; // -20% deficit
        break;
      case FitnessGoal.muscleGain:
        calories *= 1.10; // +10% surplus
        break;
      case FitnessGoal.athletic:
        calories *= 1.15; // +15% for performance
        break;
      case FitnessGoal.maintenance:
        break; // no adjustment
    }

    final kcal = calories.round();

    // Macro split (% of calories)
    // Weight loss: higher protein. Muscle gain: balanced. Maintenance: standard Indian.
    final (proteinPct, carbsPct, fatPct) = _macroSplit(goal);

    final proteinG = ((kcal * proteinPct) / 4).round(); // 4 kcal/g
    final carbsG   = ((kcal * carbsPct)   / 4).round();
    final fatG     = ((kcal * fatPct)     / 9).round(); // 9 kcal/g

    // Micronutrient RDA — Indian population context
    // ICMR 2020 guidelines
    final isMale = gender == Gender.male;
    return NutritionGoalTargets(
      calorieTarget: kcal,
      proteinG: proteinG,
      carbsG: carbsG,
      fatG: fatG,
      ironMg: isMale ? 17.0 : 21.0,      // higher for women (ICMR)
      calciumMg: 600.0,                    // ICMR adult RDA
      vitaminDMcg: 15.0,                   // 600 IU → 15 mcg
      vitaminB12Mcg: 2.2,                  // ICMR adult RDA
    );
  }

  /// BMI from weight and height.
  static double bmi({required double weightKg, required double heightCm}) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// BMI category using Asian (Indian) cutoffs (WHO 2004).
  static String bmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 23.0) return 'Normal';
    if (bmi < 27.5) return 'Overweight';
    return 'Obese';
  }

  // ── Private helpers ────────────────────────────────────────────────────────

  static double _activityMultiplier(ActivityLevel level) {
    switch (level) {
      case ActivityLevel.sedentary:         return 1.2;
      case ActivityLevel.lightlyActive:     return 1.375;
      case ActivityLevel.moderatelyActive:  return 1.55;
      case ActivityLevel.veryActive:        return 1.725;
      case ActivityLevel.extremelyActive:   return 1.9;
    }
  }

  static (double, double, double) _macroSplit(FitnessGoal goal) {
    switch (goal) {
      case FitnessGoal.weightLoss:    return (0.35, 0.45, 0.20);
      case FitnessGoal.muscleGain:    return (0.30, 0.45, 0.25);
      case FitnessGoal.athletic:      return (0.25, 0.55, 0.20);
      case FitnessGoal.maintenance:   return (0.20, 0.55, 0.25);
    }
  }
}
