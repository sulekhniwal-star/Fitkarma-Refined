import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'sync_queue_dao.g.dart';


@DriftAccessor(tables: [SyncQueue, SyncDeadLetter])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueEntry>> getPending({int limit = 50}) =>
      (select(syncQueue)
            ..where((t) => t.status.equals('pending'))
            ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
            ..limit(limit))
          .get();

  Future<int> enqueue(SyncQueueCompanion entry) =>
      into(syncQueue).insert(entry);

  Future<bool> markProcessing(int id) =>
      update(syncQueue).replace(SyncQueueCompanion(
        id: Value(id),
        status: const Value('processing'),
        lastAttemptAt: Value(DateTime.now()),
      ));

  Future<bool> markCompleted(int id) =>
      update(syncQueue).replace(SyncQueueCompanion(
        id: Value(id),
        status: const Value('completed'),
      ));

  Future<bool> markFailed(int id, int currentRetryCount) =>
      update(syncQueue).replace(SyncQueueCompanion(
        id: Value(id),
        status: Value(currentRetryCount >= 3 ? 'failed' : 'pending'),
        retryCount: Value(currentRetryCount + 1),
        lastAttemptAt: Value(DateTime.now()),
      ));

  Future<void> moveToDeadLetter(SyncQueueEntry entry, String errorMessage) {
    return transaction(() async {
      await into(syncDeadLetter).insert(SyncDeadLetterCompanion.insert(
        syncTable: entry.syncTable,
        recordId: entry.recordId,
        operation: entry.operation,
        payload: entry.payload,
        errorMessage: Value(errorMessage),
        originalRetryCount: entry.retryCount,
        createdAt: DateTime.now(),
      ));
      await (delete(syncQueue)..where((t) => t.id.equals(entry.id))).go();
    });
  }

  Future<int> cleanupCompleted() =>
      (delete(syncQueue)..where((t) => t.status.equals('completed'))).go();

  Stream<int> watchPendingCount() {
    final query = selectOnly(syncQueue)
      ..addColumns([syncQueue.id.count()])
      ..where(syncQueue.status.equals('pending'));
    return query.watchSingle().map((row) => row.read(syncQueue.id.count()) ?? 0);
  }
}
