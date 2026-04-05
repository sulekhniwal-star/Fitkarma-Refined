import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';

part 'health_service.g.dart';

class HealthService {
  final AppDatabase db;
  final Health _health = Health();

  HealthService(this.db);

  static const _types = [
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.WATER,
    HealthDataType.SLEEP_SESSION,
  ];

  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(_types);
  }

  Future<void> syncTodaySteps(String userId) async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    if (steps != null) {
      // Upsert into Drift
      await db.into(db.stepLogs).insertOnConflictUpdate(
        StepLogsCompanion.insert(
          id: 'steps_${userId}_${midnight.millisecondsSinceEpoch}',
          userId: userId,
          date: midnight,
          count: steps,
          source: 'health_connect',
        ),
      );
    }
  }

  Future<void> syncTodayMetrics(String userId) async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    
    // 1. Sync Steps
    await syncTodaySteps(userId);
    
    // 2. Sync Active Burned (Cals)
    try {
      final data = await _health.getHealthDataFromTypes(
        startTime: midnight,
        endTime: now,
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
      );
      
      double totalCals = 0;
      for (var point in data) {
         if (point.value is NumericHealthValue) {
            totalCals += (point.value as NumericHealthValue).numericValue;
         }
      }
      
      // Update calories in the day's record
      await db.into(db.stepLogs).insertOnConflictUpdate(
        StepLogsCompanion.insert(
          id: 'steps_${userId}_${midnight.millisecondsSinceEpoch}',
          userId: userId,
          date: midnight,
          count: 0, // placeholder, insertOnConflictUpdate will preserve previous if used correctly with custom update or just use partial
          calories: Value(totalCals.toInt()),
          source: 'health_connect',
        ),
      );
    } catch (_) {}
  }
}

@riverpod
HealthService healthService(Ref ref) {
  return HealthService(ref.watch(databaseProvider));
}
