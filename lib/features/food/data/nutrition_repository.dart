import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/utils/nutrition_calculator.dart';

part 'nutrition_repository.g.dart';

class NutritionRepository {
  final AppDatabase db;

  NutritionRepository(this.db);

  /// Watches the latest nutrition goals for a user.
  Stream<NutritionGoal?> watchGoals(String userId) {
    return (db.select(db.nutritionGoals)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .watchSingleOrNull();
  }

  /// Fetches the current nutrition goals for a user.
  Future<NutritionGoal?> getGoals(String userId) {
    return (db.select(db.nutritionGoals)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.updatedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Calculates and sets goals based on user profile.
  Future<void> calculateAndSetGoals({
    required String userId,
    required double weightKg,
    required double heightCm,
    required int age,
    required bool isMale,
    required String activityLevel,
    required String goal,
  }) async {
    final bmr = NutritionCalculator.calculateBMR(
      weightKg: weightKg,
      heightCm: heightCm,
      age: age,
      isMale: isMale,
    );
    final multiplier = NutritionCalculator.getActivityMultiplier(activityLevel);
    final tdee = NutritionCalculator.calculateTDEE(bmr: bmr, activityMultiplier: multiplier);
    final calorieTarget = NutritionCalculator.calculateCalorieGoal(tdee, goal);

    // Standard split: 55% carbs, 20% protein, 25% fat
    final proteinTarget = (calorieTarget * 0.20 / 4).round();
    final carbsTarget = (calorieTarget * 0.55 / 4).round();
    final fatTarget = (calorieTarget * 0.25 / 9).round();

    await updateGoals(
      userId: userId,
      calorieTarget: calorieTarget,
      proteinTarget: proteinTarget,
      carbsTarget: carbsTarget,
      fatTarget: fatTarget,
    );
  }

  /// Updates or inserts new nutrition goals.
  Future<void> updateGoals({
    required String userId,
    required int calorieTarget,
    int? proteinTarget,
    int? carbsTarget,
    int? fatTarget,
  }) async {
    await db.into(db.nutritionGoals).insertOnConflictUpdate(
      NutritionGoalsCompanion.insert(
        id: const Uuid().v4(),
        userId: userId,
        calorieTarget: calorieTarget,
        proteinTarget: Value(proteinTarget),
        carbsTarget: Value(carbsTarget),
        fatTarget: Value(fatTarget),
        updatedAt: DateTime.now(),
        syncStatus: const Value('pending'),
      ),
    );
  }
}

@riverpod
NutritionRepository nutritionRepository(Ref ref) {
  return NutritionRepository(ref.watch(databaseProvider));
}
