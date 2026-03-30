import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'nutrition_goals_dao.g.dart';


@DriftAccessor(tables: [NutritionGoals])
class NutritionGoalsDao extends DatabaseAccessor<AppDatabase>
    with _$NutritionGoalsDaoMixin {
  NutritionGoalsDao(super.db);

  Future<NutritionGoal?> getActive(String userId) =>
      (select(nutritionGoals)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.isActive.equals(true)))
          .getSingleOrNull();

  Future<int> upsertGoal(NutritionGoalsCompanion entry) =>
      into(nutritionGoals).insertOnConflictUpdate(entry);

  Future<int> deleteGoal(int id) =>
      (delete(nutritionGoals)..where((t) => t.id.equals(id))).go();

  Stream<NutritionGoal?> watchActive(String userId) {
    return (select(nutritionGoals)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.isActive.equals(true)))
        .watchSingleOrNull();
  }
}
