import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'food_logs_dao.g.dart';


@DriftDatabase(tables: [FoodLogs])
class FoodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$FoodLogsDaoMixin {
  FoodLogsDao(super.db);

  Future<List<FoodLog>> getAll(String userId) =>
      (select(foodLogs)..where((t) => t.userId.equals(userId))).get();

  Future<List<FoodLog>> getByDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<List<FoodLog>> getByMealType(
      String userId, DateTime date, String mealType) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.mealType.equals(mealType))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  Future<int> getDailyCalories(String userId, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final query = selectOnly(foodLogs)
      ..addColumns([foodLogs.calories.sum()])
      ..where(foodLogs.userId.equals(userId))
      ..where(foodLogs.loggedAt.isBetweenValues(start, end));
    final row = await query.getSingle();
    return row.read(foodLogs.calories.sum()) ?? 0;
  }

  Future<Map<String, double>> getDailyMacros(
      String userId, DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final query = selectOnly(foodLogs)
      ..addColumns([
        foodLogs.protein.sum(),
        foodLogs.carbs.sum(),
        foodLogs.fat.sum(),
        foodLogs.fiber.sum(),
      ])
      ..where(foodLogs.userId.equals(userId))
      ..where(foodLogs.loggedAt.isBetweenValues(start, end));
    final row = await query.getSingle();
    return {
      'protein': row.read(foodLogs.protein.sum()) ?? 0.0,
      'carbs': row.read(foodLogs.carbs.sum()) ?? 0.0,
      'fat': row.read(foodLogs.fat.sum()) ?? 0.0,
      'fiber': row.read(foodLogs.fiber.sum()) ?? 0.0,
    };
  }

  Future<int> insertLog(FoodLogsCompanion entry) =>
      into(foodLogs).insert(entry);

  Future<bool> updateLog(FoodLogsCompanion entry) =>
      update(foodLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(foodLogs)..where((t) => t.id.equals(id))).go();

  Stream<List<FoodLog>> watchByDate(String userId, DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }
}
