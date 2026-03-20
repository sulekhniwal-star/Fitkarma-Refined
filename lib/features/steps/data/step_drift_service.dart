// lib/features/steps/data/step_drift_service.dart
// Drift service for step data persistence

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

class StepDriftService {
  final AppDatabase db;

  StepDriftService(this.db);

  /// Get step log for today
  Future<StepLog?> getTodaySteps(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final results =
        await (db.select(db.stepLogs)..where(
              (t) =>
                  t.userId.equals(userId) &
                  t.date.isBiggerOrEqualValue(startOfDay) &
                  t.date.isSmallerThanValue(endOfDay),
            ))
            .get();

    return results.isEmpty ? null : results.first;
  }

  /// Get step logs for a date range
  Future<List<StepLog>> getStepsInRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.stepLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.date.isBiggerOrEqualValue(startDate) &
                t.date.isSmallerThanValue(endDate),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  /// Get last 7 days of step data
  Future<List<StepLog>> getLast7DaysSteps(String userId) async {
    final now = DateTime.now();
    final endDate = DateTime(
      now.year,
      now.month,
      now.day,
    ).add(const Duration(days: 1));
    final startDate = endDate.subtract(const Duration(days: 7));

    return await getStepsInRange(userId, startDate, endDate);
  }

  /// Upsert step log (insert or update)
  Future<void> upsertStepLog(StepLogsCompanion entry) async {
    await db.into(db.stepLogs).insertOnConflictUpdate(entry);
  }

  /// Create or update today's step entry
  Future<void> saveTodaySteps({
    required String id,
    required String userId,
    required int steps,
    double? distanceKm,
  }) async {
    final now = DateTime.now();
    final date = DateTime(now.year, now.month, now.day);

    await upsertStepLog(
      StepLogsCompanion.insert(
        id: id,
        userId: userId,
        date: date,
        steps: steps,
        distanceKm: Value(distanceKm),
      ),
    );
  }

  /// Delete step log
  Future<int> deleteStepLog(String id) async {
    return await (db.delete(db.stepLogs)..where((t) => t.id.equals(id))).go();
  }

  /// Get weekly total
  Future<int> getWeeklyTotal(String userId) async {
    final logs = await getLast7DaysSteps(userId);
    int total = 0;
    for (final log in logs) {
      total += log.steps;
    }
    return total;
  }

  /// Get average steps per day for last 7 days
  Future<double> get7DayAverage(String userId) async {
    final logs = await getLast7DaysSteps(userId);
    if (logs.isEmpty) return 0;

    int total = 0;
    for (final log in logs) {
      total += log.steps;
    }
    return total / 7;
  }

  /// Watch today's steps (reactive)
  Stream<StepLog?> watchTodaySteps(String userId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (db.select(db.stepLogs)..where(
          (t) =>
              t.userId.equals(userId) &
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay),
        ))
        .watch()
        .map((results) => results.isEmpty ? null : results.first);
  }
}
