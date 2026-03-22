// lib/features/sleep/data/sleep_service.dart
// Sleep Service for managing sleep logs

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// Sleep Service for managing sleep logs in the database
class SleepService {
  final AppDatabase db;
  final _uuid = const Uuid();

  SleepService(this.db);

  /// Log sleep for a specific date
  Future<SleepLog> logSleep({
    required String userId,
    required DateTime date,
    required String bedtime,
    required String wakeTime,
    required int durationMin,
    required int qualityScore,
    int? deepSleepMin,
    String source = 'manual',
    int sleepTargetMin = 480, // 8 hours default
  }) async {
    // Calculate sleep debt (positive means you owe sleep, negative means you have surplus)
    final sleepDebt = sleepTargetMin - durationMin;

    final id = _uuid.v4();

    await db
        .into(db.sleepLogs)
        .insert(
          SleepLogsCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            bedtime: bedtime,
            wakeTime: wakeTime,
            durationMin: durationMin,
            qualityScore: qualityScore,
            deepSleepMin: Value(deepSleepMin),
            sleepDebtMin: Value(sleepDebt > 0 ? sleepDebt : 0),
            source: source,
          ),
        );

    final result = await (db.select(
      db.sleepLogs,
    )..where((t) => t.id.equals(id))).getSingle();
    return result;
  }

  /// Update an existing sleep log
  Future<void> updateSleepLog({
    required String logId,
    String? bedtime,
    String? wakeTime,
    int? durationMin,
    int? qualityScore,
    int? deepSleepMin,
    int sleepTargetMin = 480,
  }) async {
    final updates = <SleepLogsCompanion>{
      if (bedtime != null) SleepLogsCompanion(bedtime: Value(bedtime)),
      if (wakeTime != null) SleepLogsCompanion(wakeTime: Value(wakeTime)),
      if (durationMin != null)
        SleepLogsCompanion(
          durationMin: Value(durationMin),
          sleepDebtMin: Value(
            sleepTargetMin > durationMin ? sleepTargetMin - durationMin : 0,
          ),
        ),
      if (qualityScore != null)
        SleepLogsCompanion(qualityScore: Value(qualityScore)),
      if (deepSleepMin != null)
        SleepLogsCompanion(deepSleepMin: Value(deepSleepMin)),
    };

    if (updates.isNotEmpty) {
      await (db.update(db.sleepLogs)..where((t) => t.id.equals(logId))).write(
        updates.reduce(
          (a, b) => SleepLogsCompanion(
            id: a.id,
            bedtime: a.bedtime,
            wakeTime: a.wakeTime,
            durationMin: a.durationMin,
            qualityScore: a.qualityScore,
            deepSleepMin: a.deepSleepMin,
            sleepDebtMin: a.sleepDebtMin,
            source: a.source,
          ),
        ),
      );
    }
  }

  /// Delete a sleep log
  Future<void> deleteSleepLog(String logId) async {
    await (db.delete(db.sleepLogs)..where((t) => t.id.equals(logId))).go();
  }

  /// Get sleep log by ID
  Future<SleepLog?> getSleepLog(String logId) async {
    return (await (db.select(
      db.sleepLogs,
    )..where((t) => t.id.equals(logId))).getSingleOrNull());
  }

  /// Get all sleep logs for a user
  Future<List<SleepLog>> getSleepLogs(String userId) async {
    return (await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get());
  }

  /// Get sleep logs for a date range
  Future<List<SleepLog>> getSleepLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.isBiggerOrEqualValue(start))
          ..where((t) => t.date.isSmallerThanValue(end))
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get());
  }

  /// Calculate weekly sleep debt
  Future<int> calculateWeeklySleepDebt(
    String userId, {
    int sleepTargetMin = 480,
  }) async {
    final now = DateTime.now();
    final weekAgo = DateTime(now.year, now.month, now.day - 7);

    final logs = await getSleepLogsInRange(userId, weekAgo, now);

    int totalDebt = 0;
    for (final log in logs) {
      final debt = sleepTargetMin - log.durationMin;
      if (debt > 0) {
        totalDebt += debt;
      }
    }

    return totalDebt;
  }
}
