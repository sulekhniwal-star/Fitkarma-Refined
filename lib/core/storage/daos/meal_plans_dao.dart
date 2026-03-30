import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'meal_plans_dao.g.dart';


@DriftDatabase(tables: [MealPlans])
class MealPlansDao extends DatabaseAccessor<AppDatabase>
    with _$MealPlansDaoMixin {
  MealPlansDao(super.db);

  Future<List<MealPlan>> getActive(String userId) =>
      (select(mealPlans)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.isActive.equals(true)))
          .get();

  Future<MealPlan?> getById(int id) =>
      (select(mealPlans)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertPlan(MealPlansCompanion entry) =>
      into(mealPlans).insert(entry);

  Future<bool> updatePlan(MealPlansCompanion entry) =>
      update(mealPlans).replace(entry);

  Future<int> deletePlan(int id) =>
      (delete(mealPlans)..where((t) => t.id.equals(id))).go();
}
