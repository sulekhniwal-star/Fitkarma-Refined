import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import '../providers/core_providers.dart';
import '../../features/food/providers/food_provider.dart';
import '../../features/health/repositories/health_repository.dart';

part 'sync_worker.g.dart';

@riverpod
class SyncWorker extends _$SyncWorker {
  @override
  void build() {}

  Future<void> syncPending() async {
    final db = ref.read(appDatabaseProvider);
    
    // Iterate through all tables that support sync
    await _syncTable(db.foodLogs, (id) => ref.read(foodRepositoryProvider).pushToRemote(id));
    await _syncTable(db.bpReadings, (id) => ref.read(healthRepositoryProvider).pushBpToRemote(id));
    await _syncTable(db.glucoseReadings, (id) => ref.read(healthRepositoryProvider).pushGlucoseToRemote(id));
    await _syncTable(db.spo2Readings, (id) => ref.read(healthRepositoryProvider).pushSpo2ToRemote(id));
    await _syncTable(db.sleepLogs, (id) => ref.read(healthRepositoryProvider).pushSleepToRemote(id));
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
  count += foodLogsDLQ.length.toInt();
  
  final bpReadingsDLQ = await db.getDLQRecords(db.bpReadings);
  count += bpReadingsDLQ.length.toInt();
  
  final glucoseReadingsDLQ = await db.getDLQRecords(db.glucoseReadings);
  count += glucoseReadingsDLQ.length.toInt();
  
  final spo2ReadingsDLQ = await db.getDLQRecords(db.spo2Readings);
  count += spo2ReadingsDLQ.length.toInt();
  
  final sleepLogsDLQ = await db.getDLQRecords(db.sleepLogs);
  count += sleepLogsDLQ.length.toInt();
  
  return count;
}

@riverpod
Future<int> pendingSyncCount(Ref ref) async {
  final db = ref.read(appDatabaseProvider);
  int count = 0;
  
  final foodLogsPending = await db.getPendingRecords(db.foodLogs);
  count += foodLogsPending.length.toInt();
  
  final bpReadingsPending = await db.getPendingRecords(db.bpReadings);
  count += bpReadingsPending.length.toInt();
  
  final glucoseReadingsPending = await db.getPendingRecords(db.glucoseReadings);
  count += glucoseReadingsPending.length.toInt();
  
  final spo2ReadingsPending = await db.getPendingRecords(db.spo2Readings);
  count += spo2ReadingsPending.length.toInt();
  
  final sleepLogsPending = await db.getPendingRecords(db.sleepLogs);
  count += sleepLogsPending.length.toInt();
  
  return count;
}

@riverpod
void syncManager(Ref ref) {
  final connectivity = ref.watch(connectivityStreamProvider);
  
  connectivity.whenData((status) {
    if (status != ConnectivityResult.none) {
      ref.read(syncWorkerProvider.notifier).syncPending();
    }
  });
}
