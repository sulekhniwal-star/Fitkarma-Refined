import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/sync_tables.dart';
import '../tables/insight_tables.dart';
import '../tables/india_platform_tables.dart';

part 'sync_dao.g.dart';

@DriftAccessor(
  tables: [
    SyncQueue,
    SyncDeadLetter,
    RemoteConfigCache,
    InsightLogs,
    InsightRatings,
  ],
)
class SyncDao extends DatabaseAccessor<AppDatabase> with _$SyncDaoMixin {
  SyncDao(super.db);

  /// Adds an operation to the sync queue.
  Future<int> enqueue(SyncQueueCompanion entry) {
    return into(syncQueue).insert(entry);
  }

  /// Fetches all pending synchronization tasks, ordered by createdAt (oldest first).
  Future<List<SyncQueueEntry>> getPendingTasks({int limit = 50}) {
    return (select(syncQueue)
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
          ])
          ..limit(limit))
        .get();
  }

  /// Removes a task from the queue after successful synchronization.
  Future<void> removeTask(int taskId) {
    return (delete(syncQueue)..where((t) => t.id.equals(taskId))).go();
  }

  /// Increments the retry count for a failed task.
  Future<void> incrementRetry(int taskId) async {
    final task = await (select(
      syncQueue,
    )..where((t) => t.id.equals(taskId))).getSingle();
    await (update(syncQueue)..where((t) => t.id.equals(taskId))).write(
      SyncQueueCompanion(retryCount: Value(task.retryCount + 1)),
    );
  }

  /// Moves a task to the dead letter table after maximum retries.
  Future<void> moveToDeadLetter(
    SyncQueueEntry task,
    String errorMessage,
  ) async {
    await transaction(() async {
      await into(syncDeadLetter).insert(
        SyncDeadLetterCompanion.insert(
          userId: '',
          originalItem: task.payload,
          failCount: task.retryCount + 1,
          lastError: Value(errorMessage),
          createdAt: DateTime.now(),
        ),
      );
      await removeTask(task.id);
    });
  }

  /// Updates local remote config cache.
  Future<void> updateConfig(String key, String value) {
    return into(remoteConfigCache).insert(
      RemoteConfigCacheCompanion.insert(
        key: key,
        value: value,
        type: 'string',
        lastUpdated: DateTime.now(),
      ),
      mode: InsertMode.insertOrReplace,
    );
  }
}
