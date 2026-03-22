// lib/features/bp/data/bp_service.dart
// BP Service with EncryptionService integration using HKDF-derived BP key

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// BP Classification based on AHA guidelines
enum BpClassification {
  normal,
  elevated,
  stage1Hypertension,
  stage2Hypertension,
  hypertensiveCrisis,
}

extension BpClassificationExtension on BpClassification {
  String get displayName {
    switch (this) {
      case BpClassification.normal:
        return 'Normal';
      case BpClassification.elevated:
        return 'Elevated';
      case BpClassification.stage1Hypertension:
        return 'Stage 1 Hypertension';
      case BpClassification.stage2Hypertension:
        return 'Stage 2 Hypertension';
      case BpClassification.hypertensiveCrisis:
        return 'Hypertensive Crisis';
    }
  }

  String get description {
    switch (this) {
      case BpClassification.normal:
        return 'Blood pressure is in a healthy range';
      case BpClassification.elevated:
        return 'Blood pressure is slightly elevated';
      case BpClassification.stage1Hypertension:
        return 'High blood pressure - consider lifestyle changes';
      case BpClassification.stage2Hypertension:
        return 'High blood pressure - consult a doctor';
      case BpClassification.hypertensiveCrisis:
        return 'Seek immediate medical attention!';
    }
  }

  int get colorValue {
    switch (this) {
      case BpClassification.normal:
        return 0xFF4CAF50; // Green
      case BpClassification.elevated:
        return 0xFFFFEB3B; // Yellow
      case BpClassification.stage1Hypertension:
        return 0xFFFF9800; // Orange
      case BpClassification.stage2Hypertension:
        return 0xFFF44336; // Red
      case BpClassification.hypertensiveCrisis:
        return 0xFF9C27B0; // Purple
    }
  }
}

/// Classify BP reading based on AHA guidelines
/// Returns the classification based on systolic and diastolic values
BpClassification classifyBp(int systolic, int diastolic) {
  // Hypertensive Crisis: ≥180/120 - requires immediate care
  if (systolic >= 180 || diastolic >= 120) {
    return BpClassification.hypertensiveCrisis;
  }

  // Stage 2 Hypertension: ≥140/90
  if (systolic >= 140 || diastolic >= 90) {
    return BpClassification.stage2Hypertension;
  }

  // Stage 1 Hypertension: 130-139 / 80-89
  if (systolic >= 130 || diastolic >= 80) {
    return BpClassification.stage1Hypertension;
  }

  // Elevated: 120-129 / <80
  if (systolic >= 120 && systolic < 130 && diastolic < 80) {
    return BpClassification.elevated;
  }

  // Normal: <120/80
  return BpClassification.normal;
}

/// Check if BP reading is in hypertensive crisis (emergency)
bool isHypertensiveCrisis(int systolic, int diastolic) {
  return systolic >= 180 || diastolic >= 120;
}

/// BP Service for managing blood pressure logs
class BpService {
  final AppDatabase db;
  static const _uuid = Uuid();

  BpService(this.db);

  /// Log a new BP reading with encryption
  Future<BloodPressureLog> logBp({
    required String userId,
    required int systolic,
    required int diastolic,
    int? pulse,
    String source = 'manual',
  }) async {
    final classification = classifyBp(systolic, diastolic);
    final id = _uuid.v4();
    final now = DateTime.now();

    // Generate idempotency key
    final idempotencyKey = '${userId}_bp_${now.millisecondsSinceEpoch}';

    // Create the BP log entry - int values will be encrypted by converter
    final companion = BloodPressureLogsCompanion.insert(
      id: id,
      userId: userId,
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse != null ? Value(pulse) : const Value.absent(),
      loggedAt: now,
      classification: classification.displayName,
      source: source,
      idempotencyKey: idempotencyKey,
    );

    await db.into(db.bloodPressureLogs).insert(companion);

    // Return the created log
    final results = await (db.select(
      db.bloodPressureLogs,
    )..where((t) => t.id.equals(id))).getSingle();
    return results;
  }

  /// Get all BP logs for a user
  Future<List<BloodPressureLog>> getBpLogs(String userId) async {
    return (db.select(db.bloodPressureLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Get BP logs for a specific date range
  Future<List<BloodPressureLog>> getBpLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.bloodPressureLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.loggedAt.isBiggerOrEqualValue(start) &
                t.loggedAt.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
        .get();
  }

  /// Get recent BP logs (last N days)
  Future<List<BloodPressureLog>> getRecentBpLogs(
    String userId,
    int days,
  ) async {
    final end = DateTime.now();
    final start = end.subtract(Duration(days: days));
    return getBpLogsInRange(userId, start, end);
  }

  /// Get latest BP reading
  Future<BloodPressureLog?> getLatestBpLog(String userId) async {
    final results =
        await (db.select(db.bloodPressureLogs)
              ..where((t) => t.userId.equals(userId))
              ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
              ..limit(1))
            .get();
    return results.isNotEmpty ? results.first : null;
  }

  /// Get average BP for a date range
  Future<Map<String, double>> getAverageBp(String userId, int days) async {
    final logs = await getRecentBpLogs(userId, days);

    if (logs.isEmpty) {
      return {'systolic': 0, 'diastolic': 0, 'pulse': 0};
    }

    int totalSystolic = 0;
    int totalDiastolic = 0;
    int totalPulse = 0;
    int pulseCount = 0;

    for (final log in logs) {
      if (log.systolic != null) totalSystolic += log.systolic!;
      if (log.diastolic != null) totalDiastolic += log.diastolic!;
      if (log.pulse != null) {
        totalPulse += log.pulse!;
        pulseCount++;
      }
    }

    return {
      'systolic': totalSystolic / logs.length,
      'diastolic': totalDiastolic / logs.length,
      'pulse': pulseCount > 0 ? totalPulse / pulseCount : 0,
    };
  }

  /// Delete a BP log
  Future<void> deleteBpLog(String logId) async {
    await (db.delete(
      db.bloodPressureLogs,
    )..where((t) => t.id.equals(logId))).go();
  }

  /// Get BP statistics for trend analysis
  Future<BpStatistics> getBpStatistics(String userId, int days) async {
    final logs = await getRecentBpLogs(userId, days);

    if (logs.isEmpty) {
      return BpStatistics.empty();
    }

    // Calculate averages
    int sumSys = 0, sumDia = 0, sumPulse = 0;
    int pulseCount = 0;
    int sysMin = 300, sysMax = 0;
    int diaMin = 200, diaMax = 0;

    for (final log in logs) {
      if (log.systolic != null) {
        sumSys += log.systolic!;
        sysMin = log.systolic! < sysMin ? log.systolic! : sysMin;
        sysMax = log.systolic! > sysMax ? log.systolic! : sysMax;
      }
      if (log.diastolic != null) {
        sumDia += log.diastolic!;
        diaMin = log.diastolic! < diaMin ? log.diastolic! : diaMin;
        diaMax = log.diastolic! > diaMax ? log.diastolic! : diaMax;
      }

      if (log.pulse != null) {
        sumPulse += log.pulse!;
        pulseCount++;
      }
    }

    return BpStatistics(
      averageSystolic: sumSys / logs.length,
      averageDiastolic: sumDia / logs.length,
      averagePulse: pulseCount > 0 ? sumPulse / pulseCount : null,
      minSystolic: sysMin,
      maxSystolic: sysMax,
      minDiastolic: diaMin,
      maxDiastolic: diaMax,
      totalLogs: logs.length,
      periodDays: days,
    );
  }
}

/// BP Statistics data class
class BpStatistics {
  final double averageSystolic;
  final double averageDiastolic;
  final double? averagePulse;
  final int minSystolic;
  final int maxSystolic;
  final int minDiastolic;
  final int maxDiastolic;
  final int totalLogs;
  final int periodDays;

  BpStatistics({
    required this.averageSystolic,
    required this.averageDiastolic,
    this.averagePulse,
    required this.minSystolic,
    required this.maxSystolic,
    required this.minDiastolic,
    required this.maxDiastolic,
    required this.totalLogs,
    required this.periodDays,
  });

  factory BpStatistics.empty() {
    return BpStatistics(
      averageSystolic: 0,
      averageDiastolic: 0,
      averagePulse: null,
      minSystolic: 0,
      maxSystolic: 0,
      minDiastolic: 0,
      maxDiastolic: 0,
      totalLogs: 0,
      periodDays: 0,
    );
  }
}
