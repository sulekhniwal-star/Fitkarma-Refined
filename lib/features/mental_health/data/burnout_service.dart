// lib/features/mental_health/data/burnout_service.dart
// Burnout Detection Service - Analyzes mood, sleep, and energy over 7 days

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/sleep/data/sleep_service.dart';

/// Burnout detection result
class BurnoutAnalysis {
  final bool isBurnoutDetected;
  final int burnoutScore; // 0-100, higher = more burned out
  final double avgMoodScore;
  final double avgEnergyLevel;
  final double avgSleepDuration;
  final double avgSleepQuality;
  final int consecutiveLowMoodDays;
  final int consecutivePoorSleepDays;
  final int consecutiveLowEnergyDays;
  final DateTime analysisDate;
  final List<String> contributingFactors;

  BurnoutAnalysis({
    required this.isBurnoutDetected,
    required this.burnoutScore,
    required this.avgMoodScore,
    required this.avgEnergyLevel,
    required this.avgSleepDuration,
    required this.avgSleepQuality,
    required this.consecutiveLowMoodDays,
    required this.consecutivePoorSleepDays,
    required this.consecutiveLowEnergyDays,
    required this.analysisDate,
    required this.contributingFactors,
  });
}

/// Burnout thresholds
class BurnoutThresholds {
  // Mood: 1-5 scale, low mood = <= 2
  static const int lowMoodThreshold = 2;
  // Energy: 1-10 scale, low energy = <= 3
  static const int lowEnergyThreshold = 3;
  // Sleep: duration in minutes, poor sleep = < 6 hours (360 min)
  static const int poorSleepDurationThreshold = 360;
  // Sleep quality: 1-10 scale, poor quality = <= 3
  static const int poorSleepQualityThreshold = 3;
  // Days to trigger burnout
  static const int burnoutTriggerDays = 7;
}

/// Recovery flow status
enum RecoveryFlowStatus { notStarted, inProgress, completed, relapse }

/// Recovery flow state stored in database
class RecoveryFlowState {
  final String id;
  final String userId;
  final DateTime startDate;
  final RecoveryFlowStatus status;
  final int currentDay; // 1-7
  final DateTime? completedDate;
  final List<String> completedActivities;
  final int relapseCount;

  RecoveryFlowState({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.status,
    required this.currentDay,
    this.completedDate,
    required this.completedActivities,
    required this.relapseCount,
  });
}

/// Burnout Service for detecting and managing burnout
class BurnoutService {
  final AppDatabase db;
  final SleepService _sleepService;

  BurnoutService(this.db) : _sleepService = SleepService(db);

  /// Analyze burnout based on 7-day pattern
  Future<BurnoutAnalysis> analyzeBurnout(String userId) async {
    final now = DateTime.now();
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    // Get mood logs for last 7 days
    final moodLogs = await _getMoodLogsInRange(userId, sevenDaysAgo, now);

    // Get sleep logs for last 7 days
    final sleepLogs = await _getSleepLogsInRange(userId, sevenDaysAgo, now);

    // Calculate averages
    final avgMoodScore = _calculateAvgMood(moodLogs);
    final avgEnergyLevel = _calculateAvgEnergy(moodLogs);
    final avgSleepDuration = _calculateAvgSleepDuration(sleepLogs);
    final avgSleepQuality = _calculateAvgSleepQuality(sleepLogs);

    // Calculate consecutive low days
    final consecutiveLowMoodDays = _calculateConsecutiveLowDays(
      moodLogs,
      (log) => log.moodScore <= BurnoutThresholds.lowMoodThreshold,
    );
    final consecutivePoorSleepDays = _calculateConsecutivePoorSleep(sleepLogs);
    final consecutiveLowEnergyDays = _calculateConsecutiveLowDays(
      moodLogs,
      (log) => (log.energyLevel ?? 5) <= BurnoutThresholds.lowEnergyThreshold,
    );

    // Calculate burnout score (0-100)
    final burnoutScore = _calculateBurnoutScore(
      avgMoodScore: avgMoodScore,
      avgEnergyLevel: avgEnergyLevel,
      avgSleepDuration: avgSleepDuration,
      avgSleepQuality: avgSleepQuality,
      consecutiveLowMoodDays: consecutiveLowMoodDays,
      consecutivePoorSleepDays: consecutivePoorSleepDays,
      consecutiveLowEnergyDays: consecutiveLowEnergyDays,
    );

    // Determine if burnout is detected
    final isBurnoutDetected =
        burnoutScore >= 50 &&
        consecutiveLowMoodDays >= BurnoutThresholds.burnoutTriggerDays;

    // Get contributing factors
    final contributingFactors = _getContributingFactors(
      avgMoodScore: avgMoodScore,
      avgEnergyLevel: avgEnergyLevel,
      avgSleepDuration: avgSleepDuration,
      avgSleepQuality: avgSleepQuality,
      consecutiveLowMoodDays: consecutiveLowMoodDays,
      consecutivePoorSleepDays: consecutivePoorSleepDays,
      consecutiveLowEnergyDays: consecutiveLowEnergyDays,
    );

    return BurnoutAnalysis(
      isBurnoutDetected: isBurnoutDetected,
      burnoutScore: burnoutScore,
      avgMoodScore: avgMoodScore,
      avgEnergyLevel: avgEnergyLevel,
      avgSleepDuration: avgSleepDuration,
      avgSleepQuality: avgSleepQuality,
      consecutiveLowMoodDays: consecutiveLowMoodDays,
      consecutivePoorSleepDays: consecutivePoorSleepDays,
      consecutiveLowEnergyDays: consecutiveLowEnergyDays,
      analysisDate: now,
      contributingFactors: contributingFactors,
    );
  }

  /// Check for persistent low mood over 14 days
  Future<PersistentLowMoodResult> checkPersistentLowMood(String userId) async {
    final now = DateTime.now();
    final fourteenDaysAgo = now.subtract(const Duration(days: 14));

    // Get mood logs for last 14 days
    final moodLogs = await _getMoodLogsInRange(userId, fourteenDaysAgo, now);

    if (moodLogs.isEmpty) {
      return PersistentLowMoodResult(
        hasPersistentLowMood: false,
        lowMoodDays: 0,
        totalDaysWithLogs: 0,
        percentageLowMood: 0,
        recommendation: null,
      );
    }

    // Calculate days with low mood
    int lowMoodDays = 0;
    final Map<String, bool> dailyMoods = {};

    for (final log in moodLogs) {
      final dateKey =
          '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      if (!dailyMoods.containsKey(dateKey)) {
        dailyMoods[dateKey] =
            log.moodScore <= BurnoutThresholds.lowMoodThreshold;
      }
    }

    lowMoodDays = dailyMoods.values.where((v) => v).length;
    final totalDaysWithLogs = dailyMoods.length;
    final percentageLowMood = (lowMoodDays / totalDaysWithLogs) * 100;

    // Determine if persistent low mood (>= 14 days of logs with >50% low mood)
    final hasPersistentLowMood =
        totalDaysWithLogs >= 14 && percentageLowMood > 50;

    String? recommendation;
    if (hasPersistentLowMood) {
      recommendation = _getProfessionalHelpRecommendation();
    }

    return PersistentLowMoodResult(
      hasPersistentLowMood: hasPersistentLowMood,
      lowMoodDays: lowMoodDays,
      totalDaysWithLogs: totalDaysWithLogs,
      percentageLowMood: percentageLowMood,
      recommendation: recommendation,
    );
  }

  String _getProfessionalHelpRecommendation() {
    return 'Based on your logs, you\'ve been experiencing low mood for an extended period. '
        'Consider reaching out to a mental health professional for support. '
        'You can also access Indian helpline resources for immediate help.';
  }

  Future<List<MoodLog>> _getMoodLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (await (db.select(db.moodLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.loggedAt.isBiggerOrEqualValue(start))
          ..where(
            (t) =>
                t.loggedAt.isSmallerThanValue(end.add(const Duration(days: 1))),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get());
  }

  Future<List<SleepLog>> _getSleepLogsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.date.isBiggerOrEqualValue(start))
          ..where(
            (t) => t.date.isSmallerThanValue(end.add(const Duration(days: 1))),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .get());
  }

  double _calculateAvgMood(List<MoodLog> logs) {
    if (logs.isEmpty) return 3.0; // Neutral
    final total = logs.fold<int>(0, (sum, log) => sum + log.moodScore);
    return total / logs.length;
  }

  double _calculateAvgEnergy(List<MoodLog> logs) {
    final logsWithEnergy = logs.where((l) => l.energyLevel != null).toList();
    if (logsWithEnergy.isEmpty) return 5.0; // Neutral
    final total = logsWithEnergy.fold<int>(
      0,
      (sum, log) => sum + (log.energyLevel ?? 5),
    );
    return total / logsWithEnergy.length;
  }

  double _calculateAvgSleepDuration(List<SleepLog> logs) {
    if (logs.isEmpty) return 420.0; // 7 hours default
    final total = logs.fold<int>(0, (sum, log) => sum + log.durationMin);
    return total / logs.length;
  }

  double _calculateAvgSleepQuality(List<SleepLog> logs) {
    if (logs.isEmpty) return 5.0; // Neutral
    final total = logs.fold<int>(0, (sum, log) => sum + log.qualityScore);
    return total / logs.length;
  }

  int _calculateConsecutiveLowDays(
    List<MoodLog> logs,
    bool Function(MoodLog) isLow,
  ) {
    if (logs.isEmpty) return 0;

    // Sort by date descending
    final sortedLogs = List<MoodLog>.from(logs)
      ..sort((a, b) => b.loggedAt.compareTo(a.loggedAt));

    // Group by day
    final Map<String, bool> dailyStatus = {};
    for (final log in sortedLogs) {
      final dateKey =
          '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      if (!dailyStatus.containsKey(dateKey)) {
        dailyStatus[dateKey] = isLow(log);
      }
    }

    // Count consecutive low days from today backwards
    int consecutive = 0;
    final today = DateTime.now();
    for (int i = 0; i < 14; i++) {
      final date = today.subtract(Duration(days: i));
      final dateKey = '${date.year}-${date.month}-${date.day}';
      if (dailyStatus[dateKey] == true) {
        consecutive++;
      } else if (dailyStatus[dateKey] == false) {
        break;
      }
    }
    return consecutive;
  }

  int _calculateConsecutivePoorSleep(List<SleepLog> logs) {
    if (logs.isEmpty) return 0;

    final sortedLogs = List<SleepLog>.from(logs)
      ..sort((a, b) => b.date.compareTo(a.date));

    int consecutive = 0;
    final today = DateTime.now();
    for (int i = 0; i < 14; i++) {
      final date = today.subtract(Duration(days: i));
      final dateKey = '${date.year}-${date.month}-${date.day}';

      final log = sortedLogs.firstWhere(
        (l) => '${l.date.year}-${l.date.month}-${l.date.day}' == dateKey,
        orElse: () => SleepLog(
          id: '',
          userId: '',
          date: date,
          bedtime: '',
          wakeTime: '',
          durationMin: 420,
          qualityScore: 5,
          source: '',
          sleepDebtMin: 0,
        ),
      );

      final isPoorSleep =
          log.durationMin < BurnoutThresholds.poorSleepDurationThreshold ||
          log.qualityScore <= BurnoutThresholds.poorSleepQualityThreshold;

      if (isPoorSleep) {
        consecutive++;
      } else {
        break;
      }
    }
    return consecutive;
  }

  int _calculateBurnoutScore({
    required double avgMoodScore,
    required double avgEnergyLevel,
    required double avgSleepDuration,
    required double avgSleepQuality,
    required int consecutiveLowMoodDays,
    required int consecutivePoorSleepDays,
    required int consecutiveLowEnergyDays,
  }) {
    int score = 0;

    // Mood contribution (max 25 points)
    if (avgMoodScore <= 2)
      score += 25;
    else if (avgMoodScore <= 2.5)
      score += 20;
    else if (avgMoodScore <= 3)
      score += 10;

    // Energy contribution (max 20 points)
    if (avgEnergyLevel <= 3)
      score += 20;
    else if (avgEnergyLevel <= 4)
      score += 15;
    else if (avgEnergyLevel <= 5)
      score += 5;

    // Sleep duration contribution (max 15 points)
    if (avgSleepDuration < 300)
      score += 15; // < 5 hours
    else if (avgSleepDuration < 360)
      score += 10; // < 6 hours
    else if (avgSleepDuration < 420)
      score += 5; // < 7 hours

    // Sleep quality contribution (max 15 points)
    if (avgSleepQuality <= 3)
      score += 15;
    else if (avgSleepQuality <= 4)
      score += 10;
    else if (avgSleepQuality <= 5)
      score += 5;

    // Consecutive days contribution (max 25 points)
    final maxConsecutive = [
      consecutiveLowMoodDays,
      consecutivePoorSleepDays,
      consecutiveLowEnergyDays,
    ].reduce((a, b) => a > b ? a : b);
    if (maxConsecutive >= 7)
      score += 25;
    else if (maxConsecutive >= 5)
      score += 20;
    else if (maxConsecutive >= 3)
      score += 10;

    return score.clamp(0, 100);
  }

  List<String> _getContributingFactors({
    required double avgMoodScore,
    required double avgEnergyLevel,
    required double avgSleepDuration,
    required double avgSleepQuality,
    required int consecutiveLowMoodDays,
    required int consecutivePoorSleepDays,
    required int consecutiveLowEnergyDays,
  }) {
    final factors = <String>[];

    if (avgMoodScore <= 2.5) {
      factors.add('Low mood consistently');
    }
    if (avgEnergyLevel <= 3) {
      factors.add('Low energy levels');
    }
    if (avgSleepDuration < 360) {
      factors.add(
        'Insufficient sleep (${(avgSleepDuration / 60).toStringAsFixed(1)} hours)',
      );
    }
    if (avgSleepQuality <= 3) {
      factors.add('Poor sleep quality');
    }
    if (consecutiveLowMoodDays >= 5) {
      factors.add('Extended period of low mood');
    }
    if (consecutivePoorSleepDays >= 5) {
      factors.add('Multiple nights of poor sleep');
    }
    if (consecutiveLowEnergyDays >= 5) {
      factors.add('Persistent low energy');
    }

    return factors;
  }
}

/// Result class for persistent low mood check
class PersistentLowMoodResult {
  final bool hasPersistentLowMood;
  final int lowMoodDays;
  final int totalDaysWithLogs;
  final double percentageLowMood;
  final String? recommendation;

  PersistentLowMoodResult({
    required this.hasPersistentLowMood,
    required this.lowMoodDays,
    required this.totalDaysWithLogs,
    required this.percentageLowMood,
    this.recommendation,
  });
}
