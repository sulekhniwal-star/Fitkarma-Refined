import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'package:fitkarma/core/storage/app_database.dart' as db;
import 'package:fitkarma/core/network/connectivity_service.dart';
import 'package:fitkarma/core/config/remote_config.dart';

//══════════════════════════════════════════════════════════════════════════════
// SECURITY: Document-level permissions for sync operations
//══════════════════════════════════════════════════════════════════════════════
// When creating/updating documents from sync queue, ALWAYS add permissions:
//
// await tablesDb.createRow(
//   databaseId: AW.dbFitkarma,
//   tableId: tableName,
//   rowId: ID.unique(),
//   data: payload,
//   permissions: [
//     Permission.read(Role.user(uid)),
//     Permission.write(Role.user(uid)),
//   ],
// );

const _maxRetries = 5;
const _batchSize = 20;
const _baseDelayMs = 1000;

enum SyncPriority {
  critical(0),
  high(1),
  normal(2),
  low(3);

  final int value;
  const SyncPriority(this.value);
}

enum SyncOperation {
  create('create'),
  update('update'),
  delete('delete');

  final String value;
  const SyncOperation(this.value);
}

final appDatabaseProvider = Provider<db.AppDatabase>((ref) {
  final database = db.AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final pendingSyncCountProvider = FutureProvider<int>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  return database.syncQueueDao.getPendingCount();
});

final deadLetterCountProvider = FutureProvider<int>((ref) async {
  final database = ref.watch(appDatabaseProvider);
  final result = await (database.selectOnly(database.syncDeadLetter)
    ..addColumns([database.syncDeadLetter.id.count()]))
      .getSingle();
  return result.read(database.syncDeadLetter.id.count()) ?? 0;
});

class SyncQueueService {
  final Ref _ref;
  bool _isProcessing = false;
  Timer? _backoffTimer;
  bool _initialized = false;

  SyncQueueService(this._ref);

  db.AppDatabase get _database => _ref.read(appDatabaseProvider);

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;

    ConnectivityService.instance.initialize();

    ConnectivityService.instance.isOnlineStream.listen((isOnline) {
      if (isOnline) {
        _processQueue();
      }
    });

    final isOnline = await ConnectivityService.instance.isOnline();
    if (isOnline) {
      _processQueue();
    }
  }

  Future<void> enqueue({
    required String recordTable,
    required int recordId,
    required SyncOperation operation,
    required Map<String, dynamic> payload,
    SyncPriority priority = SyncPriority.normal,
    String? userId,
  }) async {
    final now = DateTime.now();
    final idempotencyKey = _generateIdempotencyKey(
      userId ?? '',
      recordTable,
      recordId,
      now,
    );

    final companion = db.SyncQueueCompanion(
      recordTable: Value(recordTable),
      recordId: Value(recordId),
      operation: Value(operation.value),
      payloadJson: Value(jsonEncode(payload)),
      createdAt: Value(now),
      priority: Value(priority.value),
      idempotencyKey: Value(idempotencyKey),
      status: const Value('pending'),
    );

    await _database.syncQueueDao.enqueue(companion);
    _processQueue();
  }

  String _generateIdempotencyKey(String userId, String recordTable, int recordId, DateTime createdAt) {
    final input = '$userId$recordTable$recordId${createdAt.toIso8601String()}';
    return sha256.convert(utf8.encode(input)).toString();
  }

  Future<void> _processQueue() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      while (await ConnectivityService.instance.isOnline()) {
        final items = await _database.syncQueueDao.getPending(limit: _batchSize);
        if (items.isEmpty) break;

        for (final item in items) {
          if (!await ConnectivityService.instance.isOnline()) break;

          try {
            await _processItem(item);
          } catch (e) {
            debugPrint('Sync error for item ${item.id}: $e');
            await _handleRetry(item, e.toString());
          }
        }
      }
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _processItem(db.SyncQueueData item) async {
    try {
      switch (item.operation) {
        case 'create':
          await _createDocument(item);
          break;
        case 'update':
          await _updateDocument(item);
          break;
        case 'delete':
          await _deleteDocument(item);
          break;
        default:
          throw Exception('Unknown operation: ${item.operation}');
      }

      await _database.syncQueueDao.markDone(item.id);
      debugPrint('Synced item ${item.id}: ${item.operation}');
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _createDocument(db.SyncQueueData item) async {
    final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
    final tablesDb = _ref.read(appwriteTablesDbProvider);

    try {
      await tablesDb.createRow(
        databaseId: AW.dbFitkarma,
        tableId: item.recordTable,
        rowId: ID.unique(),
        data: payload,
      );
    } catch (e) {
      throw Exception('Create failed: $e');
    }
  }

  Future<void> _updateDocument(db.SyncQueueData item) async {
    final payload = jsonDecode(item.payloadJson) as Map<String, dynamic>;
    final tablesDb = _ref.read(appwriteTablesDbProvider);

    try {
      await tablesDb.updateRow(
        databaseId: AW.dbFitkarma,
        tableId: item.recordTable,
        rowId: item.recordId.toString(),
        data: payload,
      );
    } catch (e) {
      throw Exception('Update failed: $e');
    }
  }

  Future<void> _deleteDocument(db.SyncQueueData item) async {
    final tablesDb = _ref.read(appwriteTablesDbProvider);

    try {
      await tablesDb.deleteRow(
        databaseId: AW.dbFitkarma,
        tableId: item.recordTable,
        rowId: item.recordId.toString(),
      );
    } catch (e) {
      throw Exception('Delete failed: $e');
    }
  }

  Future<void> _handleRetry(db.SyncQueueData item, String error) async {
    await _database.syncQueueDao.incrementRetry(item.id);

    final updated = await (_database.select(_database.syncQueue)
          ..where((t) => t.id.equals(item.id)))
        .getSingle();

    if (updated.retryCount >= _maxRetries) {
      await _moveToDeadLetter(item, error);
      await _database.syncQueueDao.markFailed(item.id, error, DateTime.now());
    } else {
      _scheduleRetry(updated.retryCount);
    }
  }

  void _scheduleRetry(int retryCount) {
    _backoffTimer?.cancel();
    final delayMs = _baseDelayMs * (1 << retryCount);
    _backoffTimer = Timer(Duration(milliseconds: delayMs), _processQueue);
  }

  Future<void> _moveToDeadLetter(db.SyncQueueData item, String error) async {
    final companion = db.SyncDeadLetterCompanion(
      recordTable: Value(item.recordTable),
      recordId: Value(item.recordId),
      operation: Value(item.operation),
      payloadJson: Value(item.payloadJson),
      error: Value(error),
      failedAt: Value(DateTime.now()),
    );

    await _database.syncDeadLetterDao.insertDeadLetter(companion);
    debugPrint('Moved item ${item.id} to dead letter');
  }

  Future<void> retryDeadLetter(int id) async {
    final database = _ref.read(appDatabaseProvider);
    final items = await database.syncDeadLetterDao.getAll();
    final item = items.firstWhere((i) => i.id == id);

    final companion = db.SyncQueueCompanion(
      recordTable: Value(item.recordTable),
      recordId: Value(item.recordId),
      operation: Value(item.operation),
      payloadJson: Value(item.payloadJson),
      createdAt: Value(DateTime.now()),
      priority: const Value(2),
      idempotencyKey: Value(_generateIdempotencyKey(
        '',
        item.recordTable,
        item.recordId,
        DateTime.now(),
      )),
      status: const Value('pending'),
      retryCount: const Value(0),
    );

    await _database.syncQueueDao.enqueue(companion);
    await database.syncDeadLetterDao.retryAndRemove(id);
  }

  Future<void> discardDeadLetter(int id) async {
    final database = _ref.read(appDatabaseProvider);
    await database.syncDeadLetterDao.retryAndRemove(id);
  }

  void dispose() {
    _backoffTimer?.cancel();
  }
}

String getEntityTypePriority(String entityType, Map<String, dynamic> payload) {
  if (_isHealthCrisis(payload)) {
    return 'critical';
  }

  switch (entityType) {
    case 'food_logs':
    case 'step_logs':
    case 'workout_logs':
    case 'mood_logs':
      return 'normal';
    case 'step_batches':
      return 'low';
    default:
      return 'normal';
  }
}

bool _isHealthCrisis(Map<String, dynamic> payload) {
  final systolic = payload['systolic'];
  final diastolic = payload['diastolic'];

  if (systolic != null || diastolic != null) {
    final sys = int.tryParse(systolic?.toString() ?? '') ?? 0;
    final dia = int.tryParse(diastolic?.toString() ?? '') ?? 0;
    if (sys >= 180 || dia >= 120) return true;
  }

  final glucose = payload['glucoseMgdl'];
  if (glucose != null) {
    final glucoseValue = int.tryParse(glucose.toString()) ?? 0;
    if (glucoseValue > 300 || glucoseValue < 50) return true;
  }

  return false;
}