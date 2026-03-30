import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'sync_queue_dao.g.dart';

@DriftAccessor(tables: [SyncQueue, SyncDeadLetter])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  /// Get pending items ordered by priority then creation time.
  Future<List<SyncQueueEntry>> getPending({int limit = 20}) =>
      (select(syncQueue)
            ..where((t) => t.status.equals('pending'))
            ..orderBy([
              (t) => OrderingTerm.asc(t.priority),
              (t) => OrderingTerm.asc(t.createdAt),
            ])
            ..limit(limit))
          .get();

  /// Enqueue a sync operation with idempotency key.
  Future<int> enqueue(SyncQueueCompanion entry) =>
      into(syncQueue).insert(entry);

  /// Check if an item with the same idempotency key already exists.
  Future<bool> existsByIdempotencyKey(String key) async {
    final count = await (selectOnly(syncQueue)
          ..addColumns([syncQueue.id.count()])
          ..where(syncQueue.idempotencyKey.equals(key))
          ..where(syncQueue.status.isNotValue('completed')))
        .getSingle();
    return (count.read(syncQueue.id.count()) ?? 0) > 0;
  }

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

  /// Mark failed — moves to DLQ if max retries exceeded.
  Future<void> markFailed(int id, int currentRetryCount, String error) async {
    const maxRetries = 5;
    if (currentRetryCount >= maxRetries) {
      final entry = await (select(syncQueue)
            ..where((t) => t.id.equals(id)))
          .getSingleOrNull();
      if (entry != null) {
        await moveToDeadLetter(entry, error);
      }
    } else {
      await update(syncQueue).replace(SyncQueueCompanion(
        id: Value(id),
        status: const Value('pending'),
        retryCount: Value(currentRetryCount + 1),
        lastAttemptAt: Value(DateTime.now()),
      ));
    }
  }

  /// Move a failed item to the dead-letter queue.
  Future<void> moveToDeadLetter(SyncQueueEntry entry, String errorMessage) {
    return transaction(() async {
      await into(syncDeadLetter).insert(SyncDeadLetterCompanion.insert(
        syncTable: entry.syncTable,
        recordId: entry.recordId,
        operation: entry.operation,
        payload: entry.payload,
        idempotencyKey: entry.idempotencyKey,
        priority: entry.priority,
        errorMessage: Value(errorMessage),
        originalRetryCount: entry.retryCount,
        userId: entry.userId,
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
    return query.watchSingle()
        .map((row) => row.read(syncQueue.id.count()) ?? 0);
  }

  // ── Dead Letter Queue ─────────────────────────────────────

  Future<List<SyncDeadLetterEntry>> getDeadLetters({int limit = 100}) =>
      (select(syncDeadLetter)
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(limit))
          .get();

  Future<int> getDeadLetterCount() async {
    final query = selectOnly(syncDeadLetter)
      ..addColumns([syncDeadLetter.id.count()]);
    final row = await query.getSingle();
    return row.read(syncDeadLetter.id.count()) ?? 0;
  }

  /// Re-enqueue a dead-letter item back to the sync queue.
  Future<void> retryDeadLetter(int deadLetterId) async {
    final dl = await (select(syncDeadLetter)
          ..where((t) => t.id.equals(deadLetterId)))
        .getSingleOrNull();
    if (dl == null) return;

    await transaction(() async {
      await into(syncQueue).insert(SyncQueueCompanion.insert(
        syncTable: dl.syncTable,
        recordId: dl.recordId,
        operation: dl.operation,
        payload: dl.payload,
        idempotencyKey: dl.idempotencyKey,
        priority: dl.priority,
        userId: dl.userId,
        createdAt: DateTime.now(),
      ));
      await (delete(syncDeadLetter)..where((t) => t.id.equals(dl.id))).go();
    });
  }

  Future<int> discardDeadLetter(int id) =>
      (delete(syncDeadLetter)..where((t) => t.id.equals(id))).go();
}
