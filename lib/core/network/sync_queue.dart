import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../storage/app_database.dart';
import '../storage/drift_service.dart';

part 'sync_queue.g.dart';

enum SyncPriority {
  critical(0),
  high(1),
  normal(2),
  low(3);

  final int value;
  const SyncPriority(this.value);
}

@riverpod
class SyncQueueRepository extends _$SyncQueueRepository {
  @override
  void build() {}

  AppDatabase get _db => ref.read(driftDbProvider);

  Future<void> addToQueue({
    required String collectionId,
    required String operation, // create | update | delete
    required String localId,
    required Map<String, dynamic> payload,
    String? appwriteDocId,
    SyncPriority priority = SyncPriority.normal,
  }) async {
    final id = const Uuid().v4();
    
    // Deterministic Idempotency Key: sha256(collection + operation + localId + payload_json)
    // For simplicity here, we'll combine key fields. 
    // This prevents duplicate 'create' operations if the network fails after the server receives the request.
    final idempotencyKey = '$collectionId:$operation:$localId';
    
    await _db.into(_db.syncQueue).insert(
      SyncQueueCompanion.insert(
        id: id,
        collection: collectionId,
        operation: operation,
        localId: localId,
        payload: jsonEncode(payload),
        idempotencyKey: idempotencyKey,
        priority: Value(priority.value),
        createdAt: DateTime.now(),
        appwriteDocId: Value(appwriteDocId),
      ),
    );
  }

  Future<List<SyncQueueEntry>> getPendingItems({int limit = 20}) {
    // Priority 0 (critical) comes first, then 1 (high), etc.
    return (_db.select(_db.syncQueue)
          ..where((t) => t.retryCount.isSmallerThan(const Constant(5)))
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc),
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc),
          ])
          ..limit(limit))
        .get();
  }

  Future<void> markSynced(String id) {
    return (_db.delete(_db.syncQueue)..where((t) => t.id.equals(id))).go();
  }

  Future<void> recordFailure(String id, String error) async {
    final entry = await (_db.select(_db.syncQueue)..where((t) => t.id.equals(id))).getSingle();
    final newRetryCount = entry.retryCount + 1;
    
    if (newRetryCount >= 5) {
      // Move to Dead Letter
      await _db.into(_db.syncDeadLetter).insert(SyncDeadLetterCompanion.insert(
        id: const Uuid().v4(),
        userId: 'session_user', // placeholder
        originalItem: jsonEncode(entry.toJson()),
        failCount: newRetryCount,
        lastError: error,
        createdAt: DateTime.now(),
      ));
      await markSynced(id);
    } else {
      await (_db.update(_db.syncQueue)..where((t) => t.id.equals(id))).write(
        SyncQueueCompanion(
          retryCount: Value(newRetryCount),
          lastError: Value(error),
        ),
      );
    }
  }
}
