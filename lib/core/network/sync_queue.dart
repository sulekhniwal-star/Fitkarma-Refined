import 'dart:convert';
import 'dart:math';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as aw_models;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:workmanager/workmanager.dart';

import '../constants/api_endpoints.dart';
import '../network/appwrite_client.dart';
import '../storage/app_database.dart';
import '../storage/drift_service.dart';

/// Generates a SHA-256 idempotency key for sync operations.
String generateIdempotencyKey(String userId, String entityType, String localId) {
  final input = '$userId:$entityType:$localId:${DateTime.now().millisecondsSinceEpoch}';
  final bytes = utf8.encode(input);
  final digest = sha256.convert(bytes);
  return digest.toString();
}

class SyncQueueProcessor {
  final AppDatabase db;
  final Realtime realtime; // Not strictly needed for sync queue but good to have

  SyncQueueProcessor({required this.db}) : realtime = AppwriteClient.realtime;

  /// Fetches pending sync items and processes them in batches.
  Future<void> flushPending() async {
    final pendingItems = await (db.select(db.syncQueue)
          ..where((t) => t.retryCount.isLessThan(5))
          ..orderBy([(t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.asc)])
          ..limit(20))
        .get();

    for (final item in pendingItems) {
      // Implement exponential backoff check
      final backoffSeconds = pow(2, item.retryCount).toInt(); // 1, 2, 4, 8, 16
      final nextRetryAt = item.createdAt.add(Duration(seconds: backoffSeconds));

      if (DateTime.now().isBefore(nextRetryAt)) {
        continue; // Wait for the next flush cycle
      }

      try {
        await _processItem(item);
        // On success, delete from queue
        await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
      } catch (e) {
        final newRetryCount = item.retryCount + 1;
        final errorLog = e.toString();

        if (newRetryCount >= 5) {
          // Move to Dead Letter Table after 5 failures
          await db.into(db.syncDeadLetter).insert(
                SyncDeadLetterCompanion.insert(
                  userId: 'guest', // Should be dynamic
                  originalItem: item.payload,
                  failCount: newRetryCount,
                  lastError: Value(errorLog),
                  createdAt: DateTime.now(),
                ),
              );
          // Remove from active queue
          await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
        } else {
          // Update retry count and last error
          await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id))).write(
            SyncQueueCompanion(
              retryCount: Value(newRetryCount),
              lastError: Value(errorLog),
            ),
          );
        }
      }
    }
  }

  /// Processes a single sync item with Appwrite.
  Future<void> _processItem(SyncQueueEntry item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final databases = AppwriteClient.databases;

    try {
      switch (item.operation) {
        case 'create':
          await databases.createDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId ?? ID.unique(),
            data: {
              ...payload,
              'idempotency_key': item.idempotencyKey,
            },
          );
          break;
        case 'update':
          if (item.appwriteDocId == null) throw Exception('Appwrite Document ID missing for update');
          await databases.updateDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
            data: payload,
          );
          break;
        case 'delete':
          if (item.appwriteDocId == null) throw Exception('Appwrite Document ID missing for delete');
          await databases.deleteDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
          );
          break;
        default:
          throw Exception('Unsupported sync operation: ${item.operation}');
      }
    } on AppwriteException catch (e) {
      if (e.code == 409) {
        // Conflict - document already exists or version mismatch
        // If it's a 'create' operation, we can consider it a "soft success" or trigger a fetch/sync
        return;
      }
      rethrow;
    }
  }
}

/// WorkManager entry point for background synchronization.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      // Re-initialize services in the background isolate
      await DriftService.init();
      await AppwriteClient.initialize();

      // Check connectivity
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return Future.value(true);
      }

      final processor = SyncQueueProcessor(db: DriftService.db);
      await processor.flushPending();

      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  });
}
