import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/config/active_diet_config.dart';
import '../../../core/di/providers.dart';
import '../../auth/data/auth_repository.dart';
import 'tdee_calculator.dart';

part 'nutrition_goal_engine.g.dart';

@riverpod
Future<NutritionGoalTargets> nutritionGoals(Ref ref) async {
  final userAsync = await ref.watch(currentUserProvider.future);
  if (userAsync == null) {
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

  // Fetch user profile from local Drift DB (not from Appwrite)
  final db = ref.watch(databaseProvider);
  final profile = await db.userProfilesDao.getProfile(userAsync.$id);
  
  // Fallback defaults if no profile
  final weight = profile?.weight ?? 70.0;
  final height = profile?.height ?? 170.0;
  final gender = profile?.gender;
  final activity = profile?.activityLevel ?? 'sedentary';
  final goal = profile?.fitnessGoal ?? 'maintenance';
  
  // Calculate age from DOB if available
  int age = 25;
  if (profile?.dob != null) {
    age = DateTime.now().year - profile!.dob!.year;
  }

  // Calculate base goals from profile
  final goals = TdeeCalculator.calculateGoals(
    weightKg: weight,
    heightCm: height,
    ageYears: age,
    gender: (gender?.toLowerCase() == 'male') ? Gender.male : 
            (gender?.toLowerCase() == 'female') ? Gender.female : Gender.other,
    activity: _mapActivity(activity),
    goal: _mapGoal(goal),
  );

  // Apply dynamic offsets from festivals/weddings
  final dietModifier = await ref.watch(activeDietConfigProvider.future);
  
  final finalCalories = goals.calorieTarget + dietModifier.totalCalorieOffset;
  
  // Re-adjust macros based on new calorie target (keeping proportions)
  final double ratio = finalCalories / goals.calorieTarget;

  return NutritionGoalTargets(
    calorieTarget: finalCalories.clamp(1200, 4000).toInt(),
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
      case 'lightlyactive': return ActivityLevel.lightlyActive;
      case 'moderate': return ActivityLevel.moderatelyActive;
      case 'moderatelyactive': return ActivityLevel.moderatelyActive;
      case 'very': return ActivityLevel.veryActive;
      case 'veryactive': return ActivityLevel.veryActive;
      case 'extreme': return ActivityLevel.extremelyActive;
      case 'extremelyactive': return ActivityLevel.extremelyActive;
      default: return ActivityLevel.lightlyActive;
    }
}

FitnessGoal _mapGoal(String? goal) {
  if (goal == null) return FitnessGoal.maintenance;
  switch (goal.toLowerCase()) {
    case 'loss': return FitnessGoal.weightLoss;
    case 'weightloss': return FitnessGoal.weightLoss;
    case 'gain': return FitnessGoal.muscleGain;
    case 'musclegain': return FitnessGoal.muscleGain;
    case 'athletic': return FitnessGoal.athletic;
    default: return FitnessGoal.maintenance;
  }
}