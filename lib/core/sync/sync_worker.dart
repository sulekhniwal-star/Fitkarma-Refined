import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import '../providers/core_providers.dart';
import '../../features/food/providers/food_provider.dart';
import '../../features/health/repositories/health_repository.dart';
import '../../features/journal/repositories/journal_repository.dart';
import '../../features/workout/repositories/workout_repository.dart';
import '../../features/habit/repositories/habit_repository.dart';
import '../../features/wedding/repositories/wedding_repository.dart';
import '../../features/social/repositories/social_repository.dart';
import '../../features/reports/repositories/reports_repository.dart';

part 'sync_worker.g.dart';

@riverpod
class SyncWorker extends _$SyncWorker {
  @override
  bool build() => false;

  Future<void> syncPending() async {
    final db = ref.read(appDatabaseProvider);
    final foodRepository = ref.read(foodRepositoryProvider);
    
    // Iterate through all tables that support sync
    await _syncTable(db.foodLogs, foodRepository.pushToRemote);
    await _syncTable(db.bpReadings, (id) => ref.read(healthRepositoryProvider).pushBpToRemote(id));
    await _syncTable(db.glucoseReadings, (id) => ref.read(healthRepositoryProvider).pushGlucoseToRemote(id));
    await _syncTable(db.spo2Readings, (id) => ref.read(healthRepositoryProvider).pushSpo2ToRemote(id));
    await _syncTable(db.sleepLogs, (id) => ref.read(healthRepositoryProvider).pushSleepToRemote(id));
    await _syncTable(db.stepCounts, (id) => ref.read(healthRepositoryProvider).pushStepsToRemote(id));
    await _syncTable(db.weightLogs, (id) => ref.read(healthRepositoryProvider).pushWeightToRemote(id));
    
    // Journal & Workouts
    await _syncTable(db.journalEntries, (id) => ref.read(journalRepositoryProvider).pushEntryToRemote(id));
    await _syncTable(db.workouts, (id) => ref.read(workoutRepositoryProvider).pushWorkoutToRemote(id));
    await _syncTable(db.habits, (id) => ref.read(habitRepositoryProvider).pushHabitToRemote(id));
    await _syncTable(db.weddingPlans, (id) => ref.read(weddingRepositoryProvider).pushPlanToRemote(id));
    await _syncTable(db.socialPosts, (id) => ref.read(socialRepositoryProvider).pushPostToRemote(id));
    await _syncTable(db.labReports, (id) => ref.read(reportsRepositoryProvider).pushReportToRemote(id));
  }

  Future<void> _syncTable<T extends HasResultSet, D>(
    ResultSetImplementation<T, D> table,
    Future<void> Function(String id) syncFn,
  ) async {
    final db = ref.read(appDatabaseProvider);
    final pending = await db.getPendingRecords(table);
    
    for (final record in pending) {
      // Use reflection-like access for generic record
      final id = (record as dynamic).id as String;
      try {
        await syncFn(id);
      } catch (e) {
        await db.incrementFailedAttempts(id, table.aliasedName);
      }
    }
  }
}

@riverpod
Stream<ConnectivityResult> connectivityStream(Ref ref) {
  return Connectivity().onConnectivityChanged.map((results) => results.first);
}

@riverpod
Future<int> dlqCount(Ref ref) async {
  final db = ref.read(appDatabaseProvider);
  int count = 0;
  
  final foodLogsDLQ = await db.getDLQRecords(db.foodLogs);
  count += foodLogsDLQ.length;
  
  final bpReadingsDLQ = await db.getDLQRecords(db.bpReadings);
  count += bpReadingsDLQ.length;
  
  final glucoseReadingsDLQ = await db.getDLQRecords(db.glucoseReadings);
  count += glucoseReadingsDLQ.length;
  
  final spo2ReadingsDLQ = await db.getDLQRecords(db.spo2Readings);
  count += spo2ReadingsDLQ.length;
  
  final sleepLogsDLQ = await db.getDLQRecords(db.sleepLogs);
  count += sleepLogsDLQ.length;
  
  return count;
}

@riverpod
Future<int> pendingSyncCount(Ref ref) async {
  final db = ref.read(appDatabaseProvider);
  int count = 0;
  
  final foodLogsPending = await db.getPendingRecords(db.foodLogs);
  count += foodLogsPending.length;
  
  final bpReadingsPending = await db.getPendingRecords(db.bpReadings);
  count += bpReadingsPending.length;
  
  final glucoseReadingsPending = await db.getPendingRecords(db.glucoseReadings);
  count += glucoseReadingsPending.length;
  
  final spo2ReadingsPending = await db.getPendingRecords(db.spo2Readings);
  count += spo2ReadingsPending.length;
  
  final sleepLogsPending = await db.getPendingRecords(db.sleepLogs);
  count += sleepLogsPending.length;
  
  return count;
}

@riverpod
class SyncManager extends _$SyncManager {
  @override
  bool build() {
    final connectivity = ref.watch(connectivityStreamProvider);
    
    connectivity.whenData((status) {
      if (status != ConnectivityResult.none) {
        ref.read(syncWorkerProvider.notifier).syncPending();
      }
    });

    return false;
  }
}
