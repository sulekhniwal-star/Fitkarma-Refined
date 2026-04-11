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
