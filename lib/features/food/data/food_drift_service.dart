import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final foodDriftServiceProvider = Provider<FoodDriftService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return FoodDriftService(db);
});

class FoodDriftService {
  final AppDatabase _db;

  FoodDriftService(this._db);

  Future<int> insertFoodLog(FoodLogsCompanion log) async {
    return _db.into(_db.foodLogs).insert(log);
  }

  Future<void> updateFoodLog(FoodLogsCompanion log) async {
    await _db.update(_db.foodLogs).replace(log);
  }

  Future<int> deleteFoodLog(int id) async {
    return (_db.delete(_db.foodLogs)..where((t) => t.id.equals(id))).go();
  }

  Future<List<FoodLog>> getLogsForUser(String userId, {DateTime? from, DateTime? to}) {
    final query = _db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);

    if (from != null) {
      query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    }
    return query.get();
  }

  Stream<List<FoodLog>> watchLogsForUser(String userId, {int limit = 50}) {
    return (_db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
      ..limit(limit))
        .watch();
  }

  Future<List<FoodLog>> getPendingSync(String userId) {
    return (_db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(userId) & t.syncStatus.equals('pending')))
        .get();
  }

  Future<void> markSynced(int id) async {
    await (_db.update(_db.foodLogs)..where((t) => t.id.equals(id))).write(
      const FoodLogsCompanion(syncStatus: Value('synced')),
    );
  }

  Future<List<FoodItem>> searchFoodItems(String query) {
    return (_db.select(_db.foodItems)
      ..where((t) => t.name.like('%$query%')))
        .get();
  }

  Future<List<FoodItem>> getAllFoodItems() {
    return _db.select(_db.foodItems).get();
  }

  Future<FoodItem?> getFoodItemById(int id) async {
    final results = await (_db.select(_db.foodItems)..where((t) => t.id.equals(id))).get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> insertFoodItem(FoodItemsCompanion item) {
    return _db.into(_db.foodItems).insert(item);
  }

  Future<double> getTotalCaloriesForDate(String userId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    final result = await (_db.selectOnly(_db.foodLogs)
      ..addColumns([_db.foodLogs.calories.sum()])
      ..where(_db.foodLogs.userId.equals(userId) &
          _db.foodLogs.loggedAt.isBiggerOrEqualValue(dayStart) &
          _db.foodLogs.loggedAt.isSmallerThanValue(dayEnd)))
        .getSingle();

    return result?.read(_db.foodLogs.calories.sum()) ?? 0.0;
  }

  Future<Map<String, double>> getDailyMacros(String userId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));

    final logs = await (_db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(userId) &
          t.loggedAt.isBiggerOrEqualValue(dayStart) &
          t.loggedAt.isSmallerThanValue(dayEnd)))
        .get();

    double calories = 0, protein = 0, carbs = 0, fat = 0;
    for (final log in logs) {
      calories += log.calories;
      protein += log.proteinG;
      carbs += log.carbsG;
      fat += log.fatG;
    }

    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
    };
  }
}