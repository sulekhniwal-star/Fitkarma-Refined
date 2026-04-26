// lib/core/storage/sync_engine_service.dart

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import 'app_database.dart';
import 'daos/sync_dao.dart';
import '../network/appwrite_client.dart';
import 'package:appwrite/appwrite.dart';

class SyncEngineService {
  final AppDatabase db;
  final SyncDao syncDao;
  final _uuid = const Uuid();

  SyncEngineService({required this.db, required this.syncDao});

  /// Processes the sync queue. Should be called when online.
  Future<void> processQueue() async {
    final pending = await syncDao.getPendingTasks(limit: 10);
    if (pending.isEmpty) return;

    for (final task in pending) {
      try {
        await _syncTask(task);
        await syncDao.removeTask(task.id);
      } catch (e) {
        if (task.retryCount > 5) {
          await syncDao.moveToDeadLetter(task, e.toString());
        } else {
          await syncDao.incrementRetry(task.id);
        }
      }
    }
  }

  Future<void> _syncTask(SyncQueueEntry task) async {
    // ignore: unused_local_variable
    final payload = jsonDecode(task.payload);
    
    // Logic to call Appwrite based on task.operation and task.collection
    // For example:
    // if (task.operation == 'create') {
    //   await AppwriteClient.databases.createDocument(
    //     databaseId: 'main',
    //     collectionId: task.collection,
    //     documentId: task.localId,
    //     data: payload,
    //   );
    // }
    
    // Update local record status to 'synced'
    // This requires a generic way to update any table by ID.
  }
}
