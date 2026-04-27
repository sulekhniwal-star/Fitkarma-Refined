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
Stream<ConnectivityResult> connectivityStream(ConnectivityStreamRef ref) {
  return Connectivity().onConnectivityChanged.map((results) => results.first);
}

@riverpod
Future<int> dlqCount(DlqCountRef ref) async {
  final db = ref.read(appDatabaseProvider);
  int count = 0;
  
  count += (await db.getDLQRecords(db.foodLogs)).length;
  count += (await db.getDLQRecords(db.bpReadings)).length;
  count += (await db.getDLQRecords(db.glucoseReadings)).length;
  count += (await db.getDLQRecords(db.spo2Readings)).length;
  count += (await db.getDLQRecords(db.sleepLogs)).length;
  
  return count;
}

@riverpod
Future<int> pendingSyncCount(PendingSyncCountRef ref) async {
  final db = ref.read(appDatabaseProvider);
  int count = 0;
  
  count += (await db.getPendingRecords(db.foodLogs)).length;
  count += (await db.getPendingRecords(db.bpReadings)).length;
  count += (await db.getPendingRecords(db.glucoseReadings)).length;
  count += (await db.getPendingRecords(db.spo2Readings)).length;
  count += (await db.getPendingRecords(db.sleepLogs)).length;
  
  return count;
}

@riverpod
void syncManager(SyncManagerRef ref) {
  final connectivity = ref.watch(connectivityStreamProvider);
  
  connectivity.whenData((status) {
    if (status != ConnectivityResult.none) {
      ref.read(syncWorkerProvider.notifier).syncPending();
    }
  });
}
