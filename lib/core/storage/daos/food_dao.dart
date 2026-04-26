import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables/core_log_tables.dart';

part 'food_dao.g.dart';

@DriftAccessor(tables: [FoodLogs, FoodItems, Recipes, MealPlans])
class FoodDao extends DatabaseAccessor<AppDatabase> with _$FoodDaoMixin {
  FoodDao(super.db);

  final _uuid = const Uuid();

  /// Returns a stream of today's food logs for a specific user.
  Stream<List<FoodLog>> getTodayLogs(String userId, DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(foodLogs)
          ..where((t) =>
              t.userId.equals(userId) &
              t.loggedAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  /// Inserts a new food log entry.
  Future<void> insertLog(FoodLogsCompanion log) async {
    var companion = log;
    if (!companion.id.present) {
      companion = companion.copyWith(
        id: Value(_uuid.v4()),
        idempotencyKey: Value(_uuid.v4()),
        createdAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value('pending'),
      );
    }
    await into(foodLogs).insert(companion);
  }

  /// Searches food items using FTS5 (Full Text Search).
  Future<List<FoodItem>> searchFoodFts(String query) async {
    final rows = await customSelect(
      "SELECT food_items.* FROM food_items "
      "INNER JOIN food_items_fts ON food_items_fts.rowid = food_items.local_row_id "
      "WHERE food_items_fts MATCH '$query*' "
      "ORDER BY bm25(food_items_fts) "
      "LIMIT 50",
      readsFrom: {foodItems},
    ).get();
    return rows.map((row) => foodItems.map(row.data)).toList();
  }

  /// Fetches the most recent food logs for a user.
  Future<List<FoodLog>> getRecentLogs(String userId, int limit) async {
    return await (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();
  }

  /// Seeds the local database with food items.
  Future<void> bulkInsertFoodItems(List<FoodItemsCompanion> items) async {
    await batch((batch) {
      for (var item in items) {
        var companion = item;
        if (!companion.id.present) {
          companion = companion.copyWith(
            id: Value(_uuid.v4()),
            idempotencyKey: Value(_uuid.v4()),
          );
        }
        batch.insert(foodItems, companion, mode: InsertMode.insertOrReplace);
      }
    });
  }

  /// Copies all meals from yesterday to today for a user.
  Future<int> copyYesterdayMeals(String userId) async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final startOfYesterday = DateTime(yesterday.year, yesterday.month, yesterday.day);
    final endOfYesterday = startOfYesterday.add(const Duration(days: 1));

    final yesterdayLogs = await (select(foodLogs)
          ..where((t) =>
              t.userId.equals(userId) &
              t.loggedAt.isBetweenValues(startOfYesterday, endOfYesterday)))
        .get();

    if (yesterdayLogs.isEmpty) return 0;

    int count = 0;
    await batch((batch) {
      for (final log in yesterdayLogs) {
        batch.insert(
          foodLogs,
          FoodLogsCompanion.insert(
            id: _uuid.v4(),
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
            idempotencyKey: _generateIdempotencyKey(userId, 'food_log', '${log.id}_copy'),
            createdAt: Value(now),
            updatedAt: Value(now),
            syncStatus: const Value('pending'),
          ),
        );
        count++;
      }
    });

    return count;
  }

  String _generateIdempotencyKey(String userId, String type, String seed) {
    return '$userId:$type:$seed:${DateTime.now().millisecondsSinceEpoch}';
  }
}
