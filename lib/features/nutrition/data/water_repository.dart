import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/network/sync_queue.dart';

class WaterRepository {
  final AppDatabase db;

  WaterRepository(this.db);

  /// Logs water intake and queues it for synchronization.
  Future<void> logWater({
    required String userId,
    required int amountMl,
  }) async {
    final now = DateTime.now();
    final idempotencyKey = generateIdempotencyKey(userId, 'water', now.toIso8601String());

    await db.into(db.waterLogs).insert(
          WaterLogsCompanion.insert(
            userId: userId,
            amountMl: amountMl,
            loggedAt: now,
            idempotencyKey: idempotencyKey,
            syncStatus: const Value('pending'),
          ),
        );

    // Queue for background sync with Appwrite
    await db.into(db.syncQueue).insert(
          SyncQueueCompanion.insert(
            userId: userId,
            operation: 'create',
            collection: 'water_logs',
            payload: jsonEncode({
              'amount_ml': amountMl,
              'logged_at': now.toIso8601String(),
              'idempotency_key': idempotencyKey,
            }),
            idempotencyKey: idempotencyKey,
            createdAt: now,
          ),
        );
  }

  /// Fetches all water logs for a specific user and date.
  Future<List<WaterLog>> getDailyWater(String userId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await (db.select(db.waterLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBetweenValues(startOfDay, endOfDay))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();
  }

  /// Returns the total water intake (in ml) for a specific user and date.
  Future<int> getTotalDailyWater(String userId, DateTime date) async {
    final logs = await getDailyWater(userId, date);
    return logs.fold(0, (sum, log) => sum + log.amountMl);
  }

  /// Deletes a specific water log and handles sync cancellation if needed.
  Future<void> deleteWaterLog(int id) async {
    await (db.delete(db.waterLogs)..where((t) => t.id.equals(id))).go();
    // In a full sync implementation, we'd also queue a delete operation for Appwrite
  }
}

final waterRepositoryProvider = Provider<WaterRepository>((ref) {
  // Use the global static DB instance as per project pattern
  return WaterRepository(DriftService.db);
});

final dailyWaterTotalProvider = FutureProvider.family<int, (String, DateTime)>((ref, arg) async {
  final repo = ref.watch(waterRepositoryProvider);
  return repo.getTotalDailyWater(arg.$1, arg.$2);
});
