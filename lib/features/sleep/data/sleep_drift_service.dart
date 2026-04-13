import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';

enum Chronotype { earlyBird, nightOwl, intermediate }

class SleepDriftService {
  final AppDatabase _db;

  SleepDriftService(this._db);

  Stream<List<SleepLog>> getWeeklyLogs(String userId) {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return (_db.select(_db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerThanValue(sevenDaysAgo))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)]))
        .watch();
  }

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

  Chronotype? detectChronotype(List<SleepLog> logs) {
    if (logs.length < 30) return null;

    double totalBedtimeHour = 0;
    for (final log in logs) {
      final parts = log.bedtime.split(':');
      final hour = double.parse(parts[0]) + (double.parse(parts[1]) / 60.0);
      totalBedtimeHour += (hour < 5) ? (hour + 24) : hour;
    }

    final avgHour = totalBedtimeHour / logs.length;
    
    if (avgHour < 22) return Chronotype.earlyBird;
    if (avgHour >= 24) return Chronotype.nightOwl;
    return Chronotype.intermediate;
  }

  Future<int> insertSleepLog({
    required String userId,
    required DateTime bedtime,
    required DateTime wakeTime,
    required int quality,
    String? note,
  }) async {
    final duration = wakeTime.difference(bedtime).inMinutes;
    final bedtimeStr = '${bedtime.hour.toString().padLeft(2, '0')}:${bedtime.minute.toString().padLeft(2, '0')}';
    final wakeTimeStr = '${wakeTime.hour.toString().padLeft(2, '0')}:${wakeTime.minute.toString().padLeft(2, '0')}';
    
    final companion = SleepLogsCompanion.insert(
      userId: userId,
      date: DateTime.now(),
      bedtime: bedtimeStr,
      wakeTime: wakeTimeStr,
      durationMin: duration,
      qualityScore: quality,
      notes: Value(note),
      source: 'manual',
    );

    return await _db.into(_db.sleepLogs).insert(companion);
  }
}
