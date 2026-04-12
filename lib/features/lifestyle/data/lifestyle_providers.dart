import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

final medicationProvider = StreamProvider.family<List<Medication>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.medications)
    ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
      .watch();
});

final recentMoodLogsProvider = StreamProvider.family<List<MoodLog>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.moodLogs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
    ..limit(30))
      .watch();
});

final sleepLogsProvider = StreamProvider.family<List<SleepLog>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.sleepLogs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
    ..limit(7))
      .watch();
});

final activeHabitsProvider = StreamProvider.family<List<Habit>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.habits)
    ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
      .watch();
});

final sleepDebtProvider = Provider.family<AsyncValue<int>, String>((ref, userId) {
  final sleepHistory = ref.watch(sleepLogsProvider(userId));
  
  return sleepHistory.when(
    data: (logs) {
      if (logs.isEmpty) return const AsyncData(0);
      // Assuming a target of 8 hours (480 mins) per day
      const targetMin = 480;
      int totalDebt = 0;
      for (final log in logs) {
        final debt = targetMin - log.durationMin;
        if (debt > 0) totalDebt += debt;
      }
      return AsyncData(totalDebt);
    },
    loading: () => const AsyncLoading(),
    error: (e, st) => AsyncError(e, st),
  );
});

final chronotypeProvider = FutureProvider.family<String?, String>((ref, userId) async {
  final db = ref.watch(databaseProvider);
  final logs = await db.sleepLogsDao.getLast30DaysLogs(userId);
  
  if (logs.length < 30) return null; // Need 30 days of logs for classification

  final bedTimesMin = logs.map((log) {
    try {
      final parts = log.bedtime.split(':');
      final hour = int.parse(parts[0]);
      final min = int.parse(parts[1]);
      // Normalize to minutes past 6 PM to handle passing midnight
      int normalizedHour = hour;
      if (normalizedHour < 18) {
        normalizedHour += 24;
      }
      return (normalizedHour * 60) + min;
    } catch (e) {
      return 22 * 60; // fallback to 10 PM
    }
  }).toList();

  bedTimesMin.sort();
  final medianBedtimeMin = bedTimesMin[bedTimesMin.length ~/ 2];
  
  // Median < 10:30 PM (22.5 h) -> Early Bird
  // Median > 12:30 AM (24.5 h) -> Night Owl
  // Else -> Intermediate
  if (medianBedtimeMin < (22.5 * 60)) {
    return 'Early Bird';
  } else if (medianBedtimeMin > (24.5 * 60)) {
    return 'Night Owl';
  } else {
    return 'Intermediate';
  }
});
