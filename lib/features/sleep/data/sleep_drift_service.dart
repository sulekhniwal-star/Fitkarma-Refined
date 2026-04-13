import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

enum Chronotype { earlyBird, nightOwl, intermediate }

class SleepDriftService {
  final AppDatabase _db;

  SleepDriftService(this._db);

  /// Returns a stream of sleep logs for the last 7 days.
  Stream<List<SleepLog>> getWeeklyLogs(String userId) {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return (_db.select(_db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isAfterValue(sevenDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  /// Calculates the current weekly sleep debt in minutes.
  /// 
  /// Each night's target is 7 hours (420 minutes). 
  /// Surplus sleep does not offset debt from previous nights.
  int computeSleepDebt(List<SleepLog> logs) {
    const targetMin = 420;
    int totalDebt = 0;
    
    for (final log in logs) {
      final deficit = targetMin - log.durationMin;
      if (deficit > 0) {
        totalDebt += deficit;
      }
    }
    return totalDebt;
  }

  /// Detects the user's chronotype based on historical bedtime.
  /// 
  /// Requires at least 30 logs for a stable detection.
  Chronotype? detectChronotype(List<SleepLog> logs) {
    if (logs.length < 30) return null;

    double totalBedtimeHour = 0;
    for (final log in logs) {
      final hour = log.bedtime.hour + (log.bedtime.minute / 60.0);
      // Handle wrap-around (e.g., 01:00 am as 25:00)
      totalBedtimeHour += (hour < 5) ? (hour + 24) : hour;
    }

    final avgHour = totalBedtimeHour / logs.length;
    
    if (avgHour < 22) return Chronotype.earlyBird;
    if (avgHour >= 24) return Chronotype.nightOwl;
    return Chronotype.intermediate;
  }

  /// Inserts a new sleep log.
  Future<int> insertSleepLog({
    required String userId,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int quality,
    String? note,
  }) async {
    final duration = wakeTime.difference(bedtime).inMinutes;
    
    final companion = SleepLogsCompanion.insert(
      userId: userId,
      bedtime: bedtime,
      wakeTime: wakeTime,
      durationMin: duration,
      quality: quality,
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'sleep_log', DateTime.now().toIso8601String()),
    );

    return await _db.into(_db.sleepLogs).insert(companion);
  }
}
