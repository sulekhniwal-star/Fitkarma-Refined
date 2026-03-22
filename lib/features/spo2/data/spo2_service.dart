// lib/features/spo2/data/spo2_service.dart
// SpO2 Service for blood oxygen tracking

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// SpO2 Classification
enum SpO2Classification {
  low, // < 90% - Critical
  moderate, // 90-94% - Low
  normal, // 95-100% - Normal
}

extension SpO2ClassificationExtension on SpO2Classification {
  String get displayName {
    switch (this) {
      case SpO2Classification.low:
        return 'Critical';
      case SpO2Classification.moderate:
        return 'Low';
      case SpO2Classification.normal:
        return 'Normal';
    }
  }

  String get description {
    switch (this) {
      case SpO2Classification.low:
        return 'Seek immediate medical attention!';
      case SpO2Classification.moderate:
        return 'Please consult your doctor';
      case SpO2Classification.normal:
        return 'Blood oxygen level is healthy';
    }
  }

  int get colorValue {
    switch (this) {
      case SpO2Classification.low:
        return 0xFFF44336; // Red
      case SpO2Classification.moderate:
        return 0xFFFF9800; // Orange
      case SpO2Classification.normal:
        return 0xFF4CAF50; // Green
    }
  }

  bool get isNormal => this == SpO2Classification.normal;
}

/// Classify SpO2 percentage
SpO2Classification classifySpO2(double spo2Percentage) {
  if (spo2Percentage < 90) {
    return SpO2Classification.low;
  }
  if (spo2Percentage < 95) {
    return SpO2Classification.moderate;
  }
  return SpO2Classification.normal;
}

/// Check if SpO2 is in alert range (< 95%)
bool isSpO2Alert(double spo2Percentage) {
  return spo2Percentage < 95;
}

/// SpO2 Statistics
class SpO2Statistics {
  final double averageSpO2;
  final double minSpO2;
  final double maxSpO2;
  final int totalLogs;
  final Map<SpO2Classification, int> classificationCounts;

  SpO2Statistics({
    required this.averageSpO2,
    required this.minSpO2,
    required this.maxSpO2,
    required this.totalLogs,
    required this.classificationCounts,
  });

  factory SpO2Statistics.empty() {
    return SpO2Statistics(
      averageSpO2: 0,
      minSpO2: 0,
      maxSpO2: 0,
      totalLogs: 0,
      classificationCounts: {},
    );
  }
}

/// SpO2 Service
class SpO2Service {
  final AppDatabase db;
  static const _uuid = Uuid();

  SpO2Service(this.db);

  /// Log a new SpO2 reading
  Future<Spo2Log> logSpO2({
    required String userId,
    required double spo2Percentage,
    int? pulseRate,
    String source = 'manual',
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    // Classify SpO2
    final classification = classifySpO2(spo2Percentage);

    final companion = Spo2LogsCompanion(
      id: Value(id),
      userId: Value(userId),
      spo2Percentage: Value(spo2Percentage),
      pulseRate: Value(pulseRate),
      loggedAt: Value(now),
    );

    await db.into(db.spo2Logs).insert(companion);

    return (db.select(db.spo2Logs)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  /// Get latest SpO2 log
  Future<Spo2Log?> getLatestSpO2Log(String userId) async {
    return (db.select(db.spo2Logs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get recent SpO2 logs
  Future<List<Spo2Log>> getRecentSpO2Logs(String userId, int days) async {
    final cutoff = DateTime.now().subtract(Duration(days: days));
    return (db.select(db.spo2Logs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.loggedAt.isBiggerOrEqualValue(cutoff),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
        .get();
  }

  /// Get SpO2 statistics
  Future<SpO2Statistics> getSpO2Statistics(String userId, int days) async {
    final logs = await getRecentSpO2Logs(userId, days);

    if (logs.isEmpty) {
      return SpO2Statistics.empty();
    }

    final spo2Values = logs
        .map((l) => l.spo2Percentage)
        .where((s) => s != null)
        .cast<double>()
        .toList();

    if (spo2Values.isEmpty) {
      return SpO2Statistics.empty();
    }

    final average = spo2Values.reduce((a, b) => a + b) / spo2Values.length;
    final minVal = spo2Values.reduce((a, b) => a < b ? a : b);
    final maxVal = spo2Values.reduce((a, b) => a > b ? a : b);

    // Count classifications
    final Map<SpO2Classification, int> counts = {};
    for (final log in logs) {
      if (log.spo2Percentage != null) {
        final classification = classifySpO2(log.spo2Percentage!);
        counts[classification] = (counts[classification] ?? 0) + 1;
      }
    }

    return SpO2Statistics(
      averageSpO2: average,
      minSpO2: minVal,
      maxSpO2: maxVal,
      totalLogs: logs.length,
      classificationCounts: counts,
    );
  }

  /// Delete an SpO2 log
  Future<void> deleteSpO2Log(String logId) async {
    await (db.delete(db.spo2Logs)..where((t) => t.id.equals(logId))).go();
  }
}
