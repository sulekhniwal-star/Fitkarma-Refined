import 'dart:convert';
import 'package:appwrite/appwrite.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/app_database.dart';
import '../storage/drift_service.dart';
import '../constants/api_endpoints.dart';
import '../network/appwrite_service.dart';

part 'sync_service.g.dart';

@riverpod
class SyncService extends _$SyncService {
  @override
  void build() {}

  Databases get _dbAppwrite => ref.read(appwriteDatabasesProvider);

  /// Main entry point for syncing pending items.
  Future<void> processQueue({AppDatabase? database, Databases? databases}) async {
    final AppDatabase db = database ?? ref.read(driftDbProvider);
    final remoteDb = databases ?? _dbAppwrite;
    
    final pendingItems = await (db.select(db.syncQueue)
          ..where((t) => t.retryCount.isSmallerThan(const Constant(5)))
          ..orderBy([(t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc)])
          ..limit(20))
        .get();
        
    if (pendingItems.isEmpty) return;

    for (final item in pendingItems) {
      await _syncItem(db, remoteDb, item);
    }
  }

  /// Static method for background isolates.
  static Future<void> processManual(AppDatabase db, Databases databases) async {
    final items = await (db.select(db.syncQueue)
          ..where((t) => t.retryCount.isSmallerThan(const Constant(5)))
          ..orderBy([(t) => OrderingTerm(expression: t.priority, mode: OrderingMode.asc)])
          ..limit(20))
        .get();

    for (final item in items) {
      // Create a minimal implementation or delegate to a pure function
      await _syncItemStatic(db, databases, item);
    }
  }

  static Future<void> _syncItemStatic(AppDatabase db, Databases remoteDb, SyncQueueEntry item) async {
    try {
      final payload = jsonDecode(item.payload) as Map<String, dynamic>;
      // Remove Drift-specific fields
      payload.remove('syncStatus');
      payload.remove('id');

      final documentId = item.appwriteDocId ?? item.idempotencyKey.replaceAll(':', '_');

      // Section 8: Conflict Resolution Strategies
      if (item.collection == AW.stepLogs) {
        // Strategy: max(client, server)
        try {
          final serverDoc = await remoteDb.getDocument(
            databaseId: AW.dbId,
            collectionId: AW.stepLogs,
            documentId: documentId,
          );
          final int serverCount = serverDoc.data['count'] ?? 0;
          final int clientCount = payload['count'] ?? 0;
          
          if (clientCount > serverCount) {
            await remoteDb.updateDocument(
              databaseId: AW.dbId,
              collectionId: AW.stepLogs,
              documentId: documentId,
              data: payload,
            );
          }
        } catch (e) {
          if (e is AppwriteException && e.code == 404) {
            await remoteDb.createDocument(
              databaseId: AW.dbId,
              collectionId: AW.stepLogs,
              documentId: documentId,
              data: payload,
            );
          } else {
            rethrow;
          }
        }
      } 
      else if (_isClientWinsCollection(item.collection)) {
        // Strategy: Client Wins (Encrypted data)
        try {
          await remoteDb.createDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: documentId,
            data: payload,
          );
        } catch (e) {
          if (e is AppwriteException && e.code == 409) {
            await remoteDb.updateDocument(
              databaseId: AW.dbId,
              collectionId: item.collection,
              documentId: documentId,
              data: payload,
            );
          } else {
            rethrow;
          }
        }
      }
      else {
        // Default Strategy: Append-only or Idempotent Create
        if (item.operation == 'create') {
          await remoteDb.createDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: documentId,
            data: payload,
          );
        } else if (item.operation == 'update' && item.appwriteDocId != null) {
          await remoteDb.updateDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
            data: payload,
          );
        } else if (item.operation == 'delete' && item.appwriteDocId != null) {
          await remoteDb.deleteDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
          );
        }
      }

      // Success: Remove from queue
      await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
    } catch (e) {
      if (e is AppwriteException && e.code == 409 && item.operation == 'create') {
        // Idempotency: already exists on server, treat as success
        await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
      } else {
        final newRetryCount = item.retryCount + 1;
        await (db.update(db.syncQueue)..where((t) => t.id.equals(item.id))).write(
          SyncQueueCompanion(
            retryCount: Value(newRetryCount),
            lastError: Value(e.toString()),
          ),
        );
      }
    }
  }

  Future<void> _syncItem(AppDatabase db, Databases remoteDb, SyncQueueEntry item) async {
    await _syncItemStatic(db, remoteDb, item);
  }

  static bool _isClientWinsCollection(String collection) {
    return [
      AW.periodLogs,
      AW.journalEntries,
      AW.bloodPressureLogs,
      AW.glucoseLogs,
      AW.doctorAppointments,
      AW.spo2Logs,
    ].contains(collection);
  }
}

