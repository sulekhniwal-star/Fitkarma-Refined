// lib/features/fasting/data/fasting_service.dart
// Fasting Service with protocol calculations, timer, and XP rewards

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// Fasting protocol types
enum FastingProtocol {
  protocol16_8, // 16 hours fasting, 8 hours eating
  protocol18_6, // 18 hours fasting, 6 hours eating
  protocol5_2, // 5 days normal, 2 days restricted
  omad, // One Meal A Day (23:1)
  custom,
  ramadan, // Sehri to Iftar
}

extension FastingProtocolExtension on FastingProtocol {
  String get displayName {
    switch (this) {
      case FastingProtocol.protocol16_8:
        return '16:8';
      case FastingProtocol.protocol18_6:
        return '18:6';
      case FastingProtocol.protocol5_2:
        return '5:2';
      case FastingProtocol.omad:
        return 'OMAD';
      case FastingProtocol.custom:
        return 'Custom';
      case FastingProtocol.ramadan:
        return 'Ramadan';
    }
  }

  String get description {
    switch (this) {
      case FastingProtocol.protocol16_8:
        return '16 hours fasting, 8 hours eating window';
      case FastingProtocol.protocol18_6:
        return '18 hours fasting, 6 hours eating window';
      case FastingProtocol.protocol5_2:
        return '5 days normal eating, 2 days restricted';
      case FastingProtocol.omad:
        return 'One Meal A Day (23:1)';
      case FastingProtocol.custom:
        return 'Custom fasting schedule';
      case FastingProtocol.ramadan:
        return 'Sehri to Iftar (sunrise to sunset)';
    }
  }

  int get fastingHours {
    switch (this) {
      case FastingProtocol.protocol16_8:
        return 16;
      case FastingProtocol.protocol18_6:
        return 18;
      case FastingProtocol.protocol5_2:
        return 24; // Full day fasting
      case FastingProtocol.omad:
        return 23;
      case FastingProtocol.custom:
        return 16;
      case FastingProtocol.ramadan:
        return 0; // Variable based on location
    }
  }

  String get dbValue {
    switch (this) {
      case FastingProtocol.protocol16_8:
        return '16:8';
      case FastingProtocol.protocol18_6:
        return '18:6';
      case FastingProtocol.protocol5_2:
        return '5:2';
      case FastingProtocol.omad:
        return 'omad';
      case FastingProtocol.custom:
        return 'custom';
      case FastingProtocol.ramadan:
        return 'ramadan';
    }
  }

  static FastingProtocol fromDbValue(String value) {
    switch (value) {
      case '16:8':
        return FastingProtocol.protocol16_8;
      case '18:6':
        return FastingProtocol.protocol18_6;
      case '5:2':
        return FastingProtocol.protocol5_2;
      case 'omad':
        return FastingProtocol.omad;
      case 'ramadan':
        return FastingProtocol.ramadan;
      default:
        return FastingProtocol.custom;
    }
  }
}

/// Fasting stages
enum FastingStage { eating, earlyFasting, fatBurning, ketosis, deepKetosis }

extension FastingStageExtension on FastingStage {
  String get displayName {
    switch (this) {
      case FastingStage.eating:
        return 'Eating Window';
      case FastingStage.earlyFasting:
        return 'Early Fasting';
      case FastingStage.fatBurning:
        return 'Fat Burning';
      case FastingStage.ketosis:
        return 'Ketosis';
      case FastingStage.deepKetosis:
        return 'Deep Ketosis';
    }
  }

  String get description {
    switch (this) {
      case FastingStage.eating:
        return 'Your body is digesting food';
      case FastingStage.earlyFasting:
        return 'Glycogen stores being used';
      case FastingStage.fatBurning:
        return 'Body starting to burn fat';
      case FastingStage.ketosis:
        return 'Ketone production increased';
      case FastingStage.deepKetosis:
        return 'Maximum fat burning';
    }
  }

  int get minHours {
    switch (this) {
      case FastingStage.eating:
        return 0;
      case FastingStage.earlyFasting:
        return 4;
      case FastingStage.fatBurning:
        return 8;
      case FastingStage.ketosis:
        return 12;
      case FastingStage.deepKetosis:
        return 18;
    }
  }

  int get colorValue {
    switch (this) {
      case FastingStage.eating:
        return 0xFF4CAF50; // Green
      case FastingStage.earlyFasting:
        return 0xFF2196F3; // Blue
      case FastingStage.fatBurning:
        return 0xFFFF9800; // Orange
      case FastingStage.ketosis:
        return 0xFF9C27B0; // Purple
      case FastingStage.deepKetosis:
        return 0xFFF44336; // Red
    }
  }
}

/// Fasting state
class FastingState {
  final bool isFasting;
  final DateTime? startTime;
  final FastingProtocol? protocol;
  final Duration elapsed;
  final Duration target;
  final double progress;
  final FastingStage stage;
  final bool isRamadanMode;
  final DateTime? sehriTime;
  final DateTime? iftarTime;

  FastingState({
    this.isFasting = false,
    this.startTime,
    this.protocol,
    this.elapsed = Duration.zero,
    this.target = const Duration(hours: 16),
    this.progress = 0.0,
    this.stage = FastingStage.eating,
    this.isRamadanMode = false,
    this.sehriTime,
    this.iftarTime,
  });

  String get elapsedFormatted {
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final seconds = elapsed.inSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get remainingFormatted {
    final remaining = target - elapsed;
    if (remaining.isNegative) {
      return 'Overtime: ${(-remaining).inHours}h';
    }
    final hours = remaining.inHours;
    final minutes = remaining.inMinutes % 60;
    return '${hours}h ${minutes}m remaining';
  }
}

/// Fasting Service
class FastingService {
  final AppDatabase db;
  final _uuid = const Uuid();

  FastingService(this.db);

  /// Start a new fast
  Future<FastingLog> startFast({
    required String userId,
    required FastingProtocol protocol,
    int? customFastingHours,
    bool isRamadanMode = false,
    DateTime? sehriTime,
    DateTime? iftarTime,
    List<int>? hydrationAlertIntervals, // in minutes
  }) async {
    final id = 'fasting_${_uuid.v4()}';
    final now = DateTime.now();

    int targetHours = protocol.fastingHours;
    if (protocol == FastingProtocol.custom && customFastingHours != null) {
      targetHours = customFastingHours;
    }

    String? hydrationAlertsJson;
    if (hydrationAlertIntervals != null) {
      hydrationAlertsJson = json.encode(hydrationAlertIntervals);
    }

    await db
        .into(db.fastingLogs)
        .insert(
          FastingLogsCompanion.insert(
            id: id,
            userId: userId,
            fastStart: now,
            fastType: protocol.dbValue,
            isCompleted: const Value(false),
            targetDurationHours: Value(targetHours),
            isRamadanMode: Value(isRamadanMode),
            sehriTime: Value(sehriTime),
            iftarTime: Value(iftarTime),
            hydrationAlerts: Value(hydrationAlertsJson),
          ),
        );

    final saved = await (db.select(
      db.fastingLogs,
    )..where((tbl) => tbl.id.equals(id))).getSingle();
    return saved;
  }

  /// End a fast and award XP
  Future<FastingLog?> endFast(String fastingId) async {
    final now = DateTime.now();

    // Get the fasting log
    final fasting = await (db.select(
      db.fastingLogs,
    )..where((tbl) => tbl.id.equals(fastingId))).getSingleOrNull();

    if (fasting == null) return null;

    // Calculate XP (15 XP per completed fast)
    const xpEarned = 15;

    await (db.update(
      db.fastingLogs,
    )..where((tbl) => tbl.id.equals(fastingId))).write(
      FastingLogsCompanion(
        fastEnd: Value(now),
        isCompleted: const Value(true),
        xpEarned: Value(xpEarned),
      ),
    );

    final updated = await (db.select(
      db.fastingLogs,
    )..where((tbl) => tbl.id.equals(fastingId))).getSingle();
    return updated;
  }

  /// Get active fast (if any)
  Future<FastingLog?> getActiveFast(String userId) async {
    return (db.select(db.fastingLogs)
          ..where(
            (tbl) => tbl.userId.equals(userId) & tbl.isCompleted.equals(false),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.fastStart)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get latest completed fast
  Future<FastingLog?> getLatestCompletedFast(String userId) async {
    return (db.select(db.fastingLogs)
          ..where(
            (tbl) => tbl.userId.equals(userId) & tbl.isCompleted.equals(true),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.fastEnd)])
          ..limit(1))
        .getSingleOrNull();
  }

  /// Get fasting history
  Future<List<FastingLog>> getFastingHistory(
    String userId, {
    int days = 30,
  }) async {
    final start = DateTime.now().subtract(Duration(days: days));
    return (db.select(db.fastingLogs)
          ..where(
            (tbl) =>
                tbl.userId.equals(userId) &
                tbl.fastStart.isBiggerOrEqualValue(start),
          )
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.fastStart)]))
        .get();
  }

  /// Get fasting statistics
  Future<FastingStatistics> getFastingStatistics(
    String userId, {
    int days = 30,
  }) async {
    final history = await getFastingHistory(userId, days: days);
    final completedFasts = history.where((f) => f.isCompleted).toList();

    if (completedFasts.isEmpty) {
      return FastingStatistics.empty();
    }

    int totalXp = 0;
    Duration totalFastingTime = Duration.zero;

    for (final fast in completedFasts) {
      totalXp += fast.xpEarned;
      if (fast.fastEnd != null) {
        totalFastingTime += fast.fastEnd!.difference(fast.fastStart);
      }
    }

    final avgDuration = totalFastingTime ~/ completedFasts.length;
    final completionRate = completedFasts.length / days * 100;

    return FastingStatistics(
      totalFasts: completedFasts.length,
      totalXpEarned: totalXp,
      averageDuration: avgDuration,
      longestFast: completedFasts
          .map((f) => f.fastEnd?.difference(f.fastStart) ?? Duration.zero)
          .reduce((a, b) => a > b ? a : b),
      completionRate: completionRate.clamp(0, 100),
    );
  }

  /// Calculate current fasting state
  FastingState calculateFastingState(FastingLog? activeFast) {
    if (activeFast == null) {
      return FastingState();
    }

    final now = DateTime.now();
    final elapsed = now.difference(activeFast.fastStart);
    final target = Duration(hours: activeFast.targetDurationHours);
    final progress = (elapsed.inMinutes / target.inMinutes).clamp(0.0, 1.0);
    final stage = _getFastingStage(elapsed.inHours);

    return FastingState(
      isFasting: true,
      startTime: activeFast.fastStart,
      protocol: FastingProtocolExtension.fromDbValue(activeFast.fastType),
      elapsed: elapsed,
      target: target,
      progress: progress,
      stage: stage,
      isRamadanMode: activeFast.isRamadanMode,
      sehriTime: activeFast.sehriTime,
      iftarTime: activeFast.iftarTime,
    );
  }

  FastingStage _getFastingStage(int hoursElapsed) {
    if (hoursElapsed < 4) return FastingStage.earlyFasting;
    if (hoursElapsed < 8) return FastingStage.fatBurning;
    if (hoursElapsed < 12) return FastingStage.ketosis;
    return FastingStage.deepKetosis;
  }

  /// Delete a fasting log
  Future<void> deleteFastingLog(String id) async {
    await (db.delete(db.fastingLogs)..where((tbl) => tbl.id.equals(id))).go();
  }
}

/// Fasting statistics
class FastingStatistics {
  final int totalFasts;
  final int totalXpEarned;
  final Duration averageDuration;
  final Duration longestFast;
  final double completionRate;

  FastingStatistics({
    required this.totalFasts,
    required this.totalXpEarned,
    required this.averageDuration,
    required this.longestFast,
    required this.completionRate,
  });

  factory FastingStatistics.empty() {
    return FastingStatistics(
      totalFasts: 0,
      totalXpEarned: 0,
      averageDuration: Duration.zero,
      longestFast: Duration.zero,
      completionRate: 0,
    );
  }

  String get averageDurationFormatted {
    final hours = averageDuration.inHours;
    final minutes = averageDuration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  String get longestFastFormatted {
    final hours = longestFast.inHours;
    final minutes = longestFast.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }
}
