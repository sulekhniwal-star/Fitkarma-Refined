import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/config/active_diet_config.dart';
import '../../auth/data/auth_repository.dart';
import '../../onboarding/domain/onboarding_controller.dart';
import 'tdee_calculator.dart';

part 'nutrition_goal_engine.g.dart';

@riverpod
Future<NutritionGoalTargets> nutritionGoals(NutritionGoalsRef ref) async {
  final user = await ref.watch(currentUserProvider.future);
  if (user == null) {
     return const NutritionGoalTargets(
      calorieTarget: 2000, 
      proteinG: 100, 
      carbsG: 250, 
      fatG: 50,
      ironMg: 17, 
      calciumMg: 600, 
      vitaminDMcg: 15, 
      vitaminB12Mcg: 2.2,
    );
  }

  // Calculate base goals from profile
  final goals = TdeeCalculator.calculateGoals(
    weightKg: user.weightKg ?? 70,
    heightCm: user.heightCm ?? 170,
    ageYears: user.age ?? 25,
    gender: (user.gender?.toLowerCase() == 'male') ? Gender.male : Gender.female,
    activity: _mapActivity(user.activityLevel),
    goal: _mapGoal(user.fitnessGoal),
  );

  // Apply dynamic offsets from festivals/weddings
  final dietModifier = await ref.watch(activeDietConfigProvider.future);
  
  final finalCalories = goals.calorieTarget + dietModifier.totalCalorieOffset;
  
  // Re-adjust macros based on new calorie target (keeping proportions)
  final double ratio = finalCalories / goals.calorieTarget;

  return NutritionGoalTargets(
    calorieTarget: finalCalories.clamp(1200, 4000),
    proteinG: (goals.proteinG * ratio).round(),
    carbsG: (goals.carbsG * ratio).round(),
    fatG: (goals.fatG * ratio).round(),
    ironMg: goals.ironMg,
    calciumMg: goals.calciumMg,
    vitaminDMcg: goals.vitaminDMcg,
    vitaminB12Mcg: goals.vitaminB12Mcg,
  );
}

ActivityLevel _mapActivity(String? level) {
    if (level == null) return ActivityLevel.sedentary;
    switch (level.toLowerCase()) {
      case 'sedentary': return ActivityLevel.sedentary;
      case 'light': return ActivityLevel.lightlyActive;
      case 'moderate': return ActivityLevel.moderatelyActive;
      case 'very': return ActivityLevel.veryActive;
      case 'extreme': return ActivityLevel.extremelyActive;
      default: return ActivityLevel.lightlyActive;
    }
}

FitnessGoal _mapGoal(String? goal) {
  if (goal == null) return FitnessGoal.maintenance;
  switch (goal.toLowerCase()) {
    case 'loss': return FitnessGoal.weightLoss;
    case 'gain': return FitnessGoal.muscleGain;
    case 'athletic': return FitnessGoal.athletic;
    default: return FitnessGoal.maintenance;
  }
}
