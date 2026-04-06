import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';
import '../../../core/constants/api_endpoints.dart';
import 'package:uuid/uuid.dart';

part 'food_repository.g.dart';

class FoodRepository {
  final AppDatabase db;
  final SyncQueueRepository syncQueue;

  FoodRepository(this.db, this.syncQueue);

  Future<List<FoodItem>> searchFood(String query, {List<String>? allowedIds, List<String>? forbiddenIds}) async {
    return db.searchFoodFts(query, allowedIds: allowedIds, forbiddenIds: forbiddenIds);
  }

  Future<void> logFood({
    required String userId,
    required FoodItem item,
    required double quantityG,
    required String mealType,
    required String logMethod,
  }) async {
    final scale = quantityG / 100.0;
    final logId = const Uuid().v4();
    final idempotencyKey = const Uuid().v4();
    
    final companion = FoodLogsCompanion.insert(
      id: logId,
      userId: userId,
      foodName: item.name,
      foodItemId: Value(item.id),
      mealType: mealType,
      quantityG: quantityG,
      calories: item.caloriesPer100g * scale,
      proteinG: item.proteinPer100g * scale,
      carbsG: item.carbsPer100g * scale,
      fatG: item.fatPer100g * scale,
      fiberG: Value(item.fiberPer100g != null ? item.fiberPer100g! * scale : null),
      vitaminDMcg: Value(item.vitaminDPer100g != null ? item.vitaminDPer100g! * scale : null),
      vitaminB12Mcg: Value(item.vitaminB12Per100g != null ? item.vitaminB12Per100g! * scale : null),
      ironMg: Value(item.ironPer100g != null ? item.ironPer100g! * scale : null),
      calciumMg: Value(item.calciumPer100g != null ? item.calciumPer100g! * scale : null),
      loggedAt: DateTime.now(),
      logMethod: logMethod,
      idempotencyKey: idempotencyKey,
    );

    // 1. Write to local Drift
    await db.into(db.foodLogs).insert(companion);

    // 2. Add to Sync Queue
    await syncQueue.addToQueue(
      collectionId: AW.foodLogs,
      operation: 'create',
      localId: logId,
      payload: (await (db.select(db.foodLogs)..where((t) => t.id.equals(logId))).getSingle()).toJson(),
    );
  }

  Stream<List<FoodLog>> watchTodayLogs(String userId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqual(Variable(startOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<void> deleteLog(String logId) async {
    // 1. Get original record to retrieve appwriteDocId if any
    final log = await (db.select(db.foodLogs)..where((t) => t.id.equals(logId))).getSingleOrNull();
    if (log == null) return;

    // 2. Remove from local Drift
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(logId))).go();

    // 3. Add delete operation to Sync Queue
    await syncQueue.addToQueue(
      collectionId: AW.foodLogs,
      operation: 'delete',
      localId: logId,
      payload: {}, // delete doesn't need payload usually
      appwriteDocId: log.idempotencyKey.replaceAll(':', '_'), // using convention
    );
  }
}

@riverpod
FoodRepository foodRepository(Ref ref) {
  return FoodRepository(
    ref.watch(databaseProvider),
    ref.watch(syncQueueRepositoryProvider.notifier),
  );
}

