// lib/features/sleep/data/sleep_providers.dart
// Sleep feature providers for Riverpod state management

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:drift/drift.dart';

// ============================================================================
// Chronotype Enum
// ============================================================================

/// User chronotype classification based on sleep patterns
enum Chronotype {
  earlyBird,
  intermediate,
  nightOwl,
  unknown;

  String get displayName {
    switch (this) {
      case Chronotype.earlyBird:
        return 'Early Bird';
      case Chronotype.intermediate:
        return 'Intermediate';
      case Chronotype.nightOwl:
        return 'Night Owl';
      case Chronotype.unknown:
        return 'Unknown';
    }
  }

  String get emoji {
    switch (this) {
      case Chronotype.earlyBird:
        return '🌅';
      case Chronotype.intermediate:
        return '⏰';
      case Chronotype.nightOwl:
        return '🦉';
      case Chronotype.unknown:
        return '❓';
    }
  }

  String get description {
    switch (this) {
      case Chronotype.earlyBird:
        return 'You tend to go to bed early and wake up early. Great for morning routines!';
      case Chronotype.intermediate:
        return 'You have a balanced sleep schedule. Keep it up!';
      case Chronotype.nightOwl:
        return 'You tend to stay up late and wake up later. Perfect for evening productivity!';
      case Chronotype.unknown:
        return 'Log more sleep to discover your chronotype';
    }
  }
}

// ============================================================================
// Sleep Data Models
// ============================================================================

/// Sleep log entry with computed properties
class SleepLogEntry {
  final String id;
  final String userId;
  final DateTime date;
  final String bedtime;
  final String wakeTime;
  final int durationMin;
  final int qualityScore;
  final int? deepSleepMin;
  final int sleepDebtMin;
  final String source;

  SleepLogEntry({
    required this.id,
    required this.userId,
    required this.date,
    required this.bedtime,
    required this.wakeTime,
    required this.durationMin,
    required this.qualityScore,
    this.deepSleepMin,
    required this.sleepDebtMin,
    required this.source,
  });

  double get durationHours => durationMin / 60.0;

  factory SleepLogEntry.fromDrift(SleepLog log) {
    return SleepLogEntry(
      id: log.id,
      userId: log.userId,
      date: log.date,
      bedtime: log.bedtime,
      wakeTime: log.wakeTime,
      durationMin: log.durationMin,
      qualityScore: log.qualityScore,
      deepSleepMin: log.deepSleepMin,
      sleepDebtMin: log.sleepDebtMin,
      source: log.source,
    );
  }
}

/// Weekly sleep data for charts
class WeeklySleepData {
  final List<SleepLogEntry> logs;
  final int totalSleepMin;
  final int avgDurationMin;
  final int avgQualityScore;
  final int totalSleepDebtMin;

  WeeklySleepData({
    required this.logs,
    required this.totalSleepMin,
    required this.avgDurationMin,
    required this.avgQualityScore,
    required this.totalSleepDebtMin,
  });

  double get avgDurationHours => avgDurationMin / 60.0;
}

// ============================================================================
// Providers
// ============================================================================

/// Provider for getting current user ID
final sleepUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  return userId ?? '';
});

/// Provider for today's sleep log
final todaySleepLogProvider = FutureProvider<SleepLogEntry?>((ref) async {
  final userId = await ref.watch(sleepUserIdProvider.future);
  if (userId.isEmpty) return null;

  final driftService = ref.watch(driftServiceProvider);
  final db = driftService.db;

  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);

  final sleepLog =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..orderBy([(t) => OrderingTerm.desc(t.date)])
            ..limit(1))
          .getSingleOrNull();

  if (sleepLog == null) return null;
  return SleepLogEntry.fromDrift(sleepLog);
});

/// Provider for last night's sleep (for logging purposes)
final lastNightSleepProvider = FutureProvider<SleepLogEntry?>((ref) async {
  final userId = await ref.watch(sleepUserIdProvider.future);
  if (userId.isEmpty) return null;

  final driftService = ref.watch(driftServiceProvider);
  final db = driftService.db;

  final now = DateTime.now();
  final yesterdayStart = DateTime(now.year, now.month, now.day - 1);

  final sleepLog =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(yesterdayStart))
            ..where(
              (t) => t.date.isSmallerThanValue(
                DateTime(now.year, now.month, now.day),
              ),
            )
            ..orderBy([(t) => OrderingTerm.desc(t.date)])
            ..limit(1))
          .getSingleOrNull();

  if (sleepLog == null) return null;
  return SleepLogEntry.fromDrift(sleepLog);
});

/// Provider for weekly sleep data
final weeklySleepDataProvider = FutureProvider<WeeklySleepData>((ref) async {
  final userId = await ref.watch(sleepUserIdProvider.future);
  if (userId.isEmpty) {
    return WeeklySleepData(
      logs: [],
      totalSleepMin: 0,
      avgDurationMin: 0,
      avgQualityScore: 0,
      totalSleepDebtMin: 0,
    );
  }

  final driftService = ref.watch(driftServiceProvider);
  final db = driftService.db;

  final now = DateTime.now();
  final weekAgo = DateTime(now.year, now.month, now.day - 7);

  final logs =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(weekAgo))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  if (logs.isEmpty) {
    return WeeklySleepData(
      logs: [],
      totalSleepMin: 0,
      avgDurationMin: 0,
      avgQualityScore: 0,
      totalSleepDebtMin: 0,
    );
  }

  final entries = logs.map((l) => SleepLogEntry.fromDrift(l)).toList();
  final totalSleepMin = entries.fold<int>(0, (sum, e) => sum + e.durationMin);
  final avgDurationMin = (totalSleepMin / entries.length).round();
  final avgQualityScore =
      entries.fold<int>(0, (sum, e) => sum + e.qualityScore) ~/ entries.length;
  final totalSleepDebtMin = entries.fold<int>(
    0,
    (sum, e) => sum + e.sleepDebtMin,
  );

  return WeeklySleepData(
    logs: entries,
    totalSleepMin: totalSleepMin,
    avgDurationMin: avgDurationMin,
    avgQualityScore: avgQualityScore,
    totalSleepDebtMin: totalSleepDebtMin,
  );
});

/// Provider for sleep debt (cumulative weekly deficit)
final sleepDebtProvider = FutureProvider<int>((ref) async {
  final weeklyData = await ref.watch(weeklySleepDataProvider.future);
  return weeklyData.totalSleepDebtMin;
});

/// Provider for user's chronotype
final chronotypeProvider = FutureProvider<Chronotype>((ref) async {
  final userId = await ref.watch(sleepUserIdProvider.future);
  if (userId.isEmpty) return Chronotype.unknown;

  final driftService = ref.watch(driftServiceProvider);
  final db = driftService.db;

  // Need at least 30 days of sleep logs to detect chronotype
  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

  final logs =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(thirtyDaysAgo)))
          .get();

  // Need at least 30 days of data
  if (logs.length < 30) {
    return Chronotype.unknown;
  }

  // Calculate median bedtime
  final bedtimes = logs
      .map((l) => _parseTimeToMinutes(l.bedtime))
      .where((m) => m != null)
      .cast<int>()
      .toList();

  if (bedtimes.length < 30) {
    return Chronotype.unknown;
  }

  bedtimes.sort();
  final medianBedtime = bedtimes[bedtimes.length ~/ 2];

  // Classify based on median bedtime
  // Early Bird: before 10:30 PM (22:30 = 1350 minutes)
  // Night Owl: after 12:30 AM (00:30 = 30 minutes or after midnight)
  // Intermediate: in between
  if (medianBedtime < 1350) {
    // Before 10:30 PM
    return Chronotype.earlyBird;
  } else if (medianBedtime > 30 && medianBedtime < 150) {
    // Between 12:30 AM and 2:30 AM
    return Chronotype.nightOwl;
  } else {
    return Chronotype.intermediate;
  }
});

/// Parse time string (HH:MM) to minutes from midnight
int? _parseTimeToMinutes(String timeStr) {
  try {
    final parts = timeStr.split(':');
    if (parts.length != 2) return null;

    var hours = int.parse(parts[0]);
    final minutes = int.parse(parts[1]);

    // Handle times after midnight (e.g., 01:30)
    if (hours < 12 && timeStr.contains('AM')) {
      hours += 24;
    }

    return hours * 60 + minutes;
  } catch (e) {
    return null;
  }
}

/// Provider for sleep logs in the last 30 days
final sleepLogs30DaysProvider = FutureProvider<List<SleepLogEntry>>((
  ref,
) async {
  final userId = await ref.watch(sleepUserIdProvider.future);
  if (userId.isEmpty) return [];

  final driftService = ref.watch(driftServiceProvider);
  final db = driftService.db;

  final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));

  final logs =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(thirtyDaysAgo))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .get();

  return logs.map((l) => SleepLogEntry.fromDrift(l)).toList();
});

/// Provider for sleep statistics
final sleepStatsProvider = FutureProvider<SleepStats>((ref) async {
  final weeklyData = await ref.watch(weeklySleepDataProvider.future);
  final chronotype = await ref.watch(chronotypeProvider.future);

  return SleepStats(
    avgDurationMin: weeklyData.avgDurationMin,
    avgQualityScore: weeklyData.avgQualityScore,
    totalSleepDebtMin: weeklyData.totalSleepDebtMin,
    logsThisWeek: weeklyData.logs.length,
    chronotype: chronotype,
  );
});

class SleepStats {
  final int avgDurationMin;
  final int avgQualityScore;
  final int totalSleepDebtMin;
  final int logsThisWeek;
  final Chronotype chronotype;

  SleepStats({
    required this.avgDurationMin,
    required this.avgQualityScore,
    required this.totalSleepDebtMin,
    required this.logsThisWeek,
    required this.chronotype,
  });

  double get avgDurationHours => avgDurationMin / 60.0;
}

// ============================================================================
// Sleep Target Settings
// ============================================================================

/// Default sleep target in minutes (8 hours)
const int defaultSleepTargetMin = 480;

/// Provider for user's sleep target (in minutes)
final sleepTargetProvider = Provider<int>((ref) => defaultSleepTargetMin);
