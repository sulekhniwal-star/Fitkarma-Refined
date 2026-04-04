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

  Future<void> processQueue({AppDatabase? database, Databases? databases}) async {
    final AppDatabase db = database ?? ref.read(driftDbProvider);
    final remoteDb = databases ?? _dbAppwrite;
    
    final pendingItems = await (db.select(db.syncQueue)
          ..where((t) => t.retryCount.isSmallerThan(const Constant(5)))
          ..limit(20))
        .get();
        
    if (pendingItems.isEmpty) return;

    for (final item in pendingItems) {
      try {
        final payload = jsonDecode(item.payload) as Map<String, dynamic>;
        
        // Remove Drift-specific fields that shouldn't go to Appwrite
        payload.remove('syncStatus');
        payload.remove('id');

        // Deterministic document ID for 'create' provides idempotency
        final documentId = item.appwriteDocId ?? item.idempotencyKey.replaceAll(':', '_');

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

        await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
      } catch (e) {
        // Handle Appwrite exceptions (e.g. 409 conflict means it was already created)
        if (e is AppwriteException && e.code == 409) {
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
  }

  /// A static method that can be called from a background isolate.
  static Future<void> processManual(AppDatabase db, Databases databases) async {
    final items = await (db.select(db.syncQueue)
          ..where((t) => t.retryCount.isSmallerThan(const Constant(5)))
          ..limit(20))
        .get();

    for (final item in items) {
      try {
        final payload = jsonDecode(item.payload) as Map<String, dynamic>;
        payload.remove('syncStatus');
        payload.remove('id');
        
        final documentId = item.appwriteDocId ?? item.idempotencyKey.replaceAll(':', '_');

        if (item.operation == 'create') {
          await databases.createDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: documentId,
            data: payload,
          );
        } else if (item.operation == 'update' && item.appwriteDocId != null) {
          await databases.updateDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
            data: payload,
          );
        } else if (item.operation == 'delete' && item.appwriteDocId != null) {
          await databases.deleteDocument(
            databaseId: AW.dbId,
            collectionId: item.collection,
            documentId: item.appwriteDocId!,
          );
        }

        await (db.delete(db.syncQueue)..where((t) => t.id.equals(item.id))).go();
      } catch (e) {
        if (e is AppwriteException && e.code == 409) {
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
  }
}
