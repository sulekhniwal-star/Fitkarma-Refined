import 'package:health/health.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/network/sync_queue.dart';
import 'package:drift/drift.dart';

class HealthConnectService {
  final AppDatabase db;
  final Health _health = Health();

  HealthConnectService({required this.db});

  static const _dataTypes = [
    HealthDataType.STEPS,
    HealthDataType.SLEEP_SESSION,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
  ];

  /// Request permissions for Health Connect
  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(_dataTypes);
  }

  /// Syncs steps from Health Connect to Drift
  Future<int> syncSteps(DateTime from, DateTime to, String userId) async {
    final healthData = await _health.getHealthDataFromTypes(
      startTime: from,
      endTime: to,
      types: [HealthDataType.STEPS],
    );

    int totalSteps = 0;
    for (var data in healthData) {
      if (data.type == HealthDataType.STEPS) {
        final steps = (data.value as NumericHealthValue).numericValue.toInt();
        totalSteps += steps;

        // Insert into StepLogs
        final idempotencyKey = generateIdempotencyKey(userId, 'steps', data.dateFrom.toIso8601String());
        await db.into(db.stepLogs).insertOnConflictUpdate(
          StepLogsCompanion.insert(
            userId: userId,
            date: data.dateFrom,
            stepCount: steps,
            source: 'health_connect',
            idempotencyKey: idempotencyKey,
            syncStatus: const Value('pending'),
          ),
        );
      }
    }
    return totalSteps;
  }

  /// Syncs sleep sessions to Drift
  Future<void> syncSleep(DateTime from, DateTime to, String userId) async {
    final sleepData = await _health.getHealthDataFromTypes(
      startTime: from,
      endTime: to,
      types: [HealthDataType.SLEEP_SESSION],
    );

    for (var data in sleepData) {
      final duration = data.dateTo.difference(data.dateFrom).inMinutes;
      
      await db.into(db.sleepLogs).insertOnConflictUpdate(
        SleepLogsCompanion.insert(
          userId: userId,
          date: data.dateFrom,
          bedtime: '${data.dateFrom.hour.toString().padLeft(2, '0')}:${data.dateFrom.minute.toString().padLeft(2, '0')}',
          wakeTime: '${data.dateTo.hour.toString().padLeft(2, '0')}:${data.dateTo.minute.toString().padLeft(2, '0')}',
          durationMin: duration,
          qualityScore: 3, // Default mid
          source: 'health_connect',
        ),
      );
    }
  }

  /// Syncs heart rate to Drift
  Future<void> syncHeartRate(DateTime from, String userId) async {
    final hrData = await _health.getHealthDataFromTypes(
      startTime: from,
      endTime: DateTime.now(),
      types: [HealthDataType.HEART_RATE],
    );

    for (var data in hrData) {
      final bpm = (data.value as NumericHealthValue).numericValue.toInt();
      
      await db.into(db.heartRateLogs).insert(
        HeartRateLogsCompanion.insert(
          userId: userId,
          bpm: bpm,
          timestamp: data.dateFrom,
          source: 'health_connect',
        ),
      );
    }
  }
}

