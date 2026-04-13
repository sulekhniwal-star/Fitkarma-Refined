import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

class FoodDriftService {
  final AppDatabase _db;

  FoodDriftService(this._db);

  /// Returns a stream of today's food logs for a specific user.
  Stream<List<FoodLog>> getTodayLogs(String userId, DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (_db.select(_db.foodLogs)
          ..where((t) =>
              t.userId.equals(userId) &
              t.loggedAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  /// Inserts a new food log entry.
  Future<int> insertLog(FoodLogsCompanion log) async {
    return await _db.into(_db.foodLogs).insert(log);
  }

  /// Searches food items using FTS5 (Full Text Search).
  Future<List<FoodItem>> searchFoodFts(String query) async {
    return await _db.searchFoodFts(query);
  }

  /// Fetches the most recent food logs for a user.
  Future<List<FoodLog>> getRecentLogs(String userId, int limit) async {
    return await (_db.select(_db.foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  /// Copies all meals from yesterday to today for a user.
  Future<int> copyYesterdayMeals(String userId) async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final startOfYesterday = DateTime(yesterday.year, yesterday.month, yesterday.day);
    final endOfYesterday = startOfYesterday.add(const Duration(days: 1));

    final yesterdayLogs = await (_db.select(_db.foodLogs)
          ..where((t) =>
              t.userId.equals(userId) &
              t.loggedAt.isBetweenValues(startOfYesterday, endOfYesterday)))
        .get();

    if (yesterdayLogs.isEmpty) return 0;

    int count = 0;
    await _db.batch((batch) {
      for (final log in yesterdayLogs) {
        batch.insert(
          _db.foodLogs,
          FoodLogsCompanion.insert(
            userId: userId,
            foodItemId: Value(log.foodItemId),
            foodName: log.foodName,
            mealType: log.mealType,
            quantityG: log.quantityG,
            calories: log.calories,
            proteinG: log.proteinG,
            carbsG: log.carbsG,
            fatG: log.fatG,
            fiberG: Value(log.fiberG),
            loggedAt: now,
            logMethod: const Value('copy_yesterday'),
            idempotencyKey: generateIdempotencyKey(userId, 'food_log', '${log.id}_copy'),
          ),
        );
        count++;
      }
    });

    return count;
  }

  /// Seeds the local database with food items.
  Future<void> bulkInsertFoodItems(List<FoodItemsCompanion> items) async {
    await _db.batch((batch) {
      batch.insertAll(_db.foodItems, items, mode: InsertMode.insertOrReplace);
    });
  }
}
