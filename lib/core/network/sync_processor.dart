import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_endpoints.dart';
import '../network/appwrite_client.dart';
import '../network/connectivity_service.dart';
import '../storage/app_database.dart';
import '../storage/daos/sync_queue_dao.dart';

/// Sync priority levels — lower number = higher priority.
enum SyncPriority {
  critical(0),
  high(1),
  normal(2),
  low(3);

  const SyncPriority(this.value);
  final int value;
}

/// Processes the sync queue with exponential backoff, priority ordering,
/// and dead-letter queue for permanently failed items.
class SyncProcessor {
  final AppDatabase _db;
  final SyncQueueDao _syncDao;
  final ConnectivityService _connectivity;
  final Databases _databases;

  Timer? _timer;
  bool _processing = false;

  static const _batchSize = 20;
  static const _maxRetries = 5;
  static const _pollInterval = Duration(seconds: 30);

  SyncProcessor({
    required AppDatabase db,
    required ConnectivityService connectivity,
  })  : _db = db,
        _syncDao = db.syncQueueDao,
        _connectivity = connectivity,
        _databases = AppwriteClient.databases;

  /// Start watching connectivity and processing queue.
  void start() {
    _connectivity.isOnlineStream.listen((online) {
      if (online) _processQueue();
    });
    _timer = Timer.periodic(_pollInterval, (_) => _processQueue());
    // Initial process if already online
    if (_connectivity.isOnline) {
      _processQueue();
    }
  }

  void stop() {
    _timer?.cancel();
  }

  /// Enqueue a new sync operation.
  Future<void> enqueue({
    required String table,
    required int recordId,
    required String operation,
    required Map<String, dynamic> payload,
    required String userId,
    SyncPriority priority = SyncPriority.normal,
    Map<String, String>? versionVector,
  }) async {
    final idempotencyKey = _generateIdempotencyKey(
      userId: userId,
      entityType: table,
      localId: recordId,
      createdAt: DateTime.now(),
    );

    // Deduplicate
    if (await _syncDao.existsByIdempotencyKey(idempotencyKey)) return;

    await _syncDao.enqueue(SyncQueueCompanion.insert(
      syncTable: table,
      recordId: recordId,
      operation: operation,
      payload: jsonEncode(payload),
      idempotencyKey: idempotencyKey,
      priority: priority.value,
      versionVector: Value(
        versionVector != null ? jsonEncode(versionVector) : null,
      ),
      userId: userId,
      createdAt: DateTime.now(),
    ));
  }

  // ═══════════════════════════════════════════════════════════════
  // Queue Processing
  // ═══════════════════════════════════════════════════════════════

  Future<void> _processQueue() async {
    if (_processing || !_connectivity.isOnline) return;
    _processing = true;

    try {
      final batch = await _syncDao.getPending(limit: _batchSize);

      for (final item in batch) {
        try {
          await _syncDao.markProcessing(item.id);
          await _syncItem(item);
          await _syncDao.markCompleted(item.id);
        } catch (e, st) {
          debugPrint('Sync failed for ${item.syncTable}/${item.recordId}: $e');
          await _syncDao.markFailed(item.id, item.retryCount, e.toString());
        }
      }

      // Cleanup old completed items
      await _syncDao.cleanupCompleted();
    } catch (e, st) {
      debugPrint('Sync queue processing error: $e\n$st');
    } finally {
      _processing = false;
    }
  }

  Future<void> _syncItem(dynamic item) async {
    final payload = jsonDecode(item.payload) as Map<String, dynamic>;
    final collectionId = _mapTableToCollection(item.syncTable);

    // Exponential backoff delay before retry
    if (item.retryCount > 0) {
      final delayMs = 1000 * (1 << (item.retryCount - 1)); // 1s, 2s, 4s, 8s, 16s
      await Future.delayed(Duration(milliseconds: delayMs));
    }

    switch (item.operation) {
      case 'create':
        await _databases.createDocument(
          databaseId: AW.databaseId,
          collectionId: collectionId,
          documentId: ID.custom('${item.userId}_${item.recordId}'),
          data: payload,
          permissions: [
            Permission.read(Role.user(item.userId)),
            Permission.update(Role.user(item.userId)),
          ],
        );
        break;
      case 'update':
        await _databases.updateDocument(
          databaseId: AW.databaseId,
          collectionId: collectionId,
          documentId: '${item.userId}_${item.recordId}',
          data: payload,
        );
        break;
      case 'delete':
        await _databases.deleteDocument(
          databaseId: AW.databaseId,
          collectionId: collectionId,
          documentId: '${item.userId}_${item.recordId}',
        );
        break;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  // Utilities
  // ═══════════════════════════════════════════════════════════════

  /// Generate an idempotency key to prevent duplicate writes on retry.
  static String _generateIdempotencyKey({
    required String userId,
    required String entityType,
    required int localId,
    required DateTime createdAt,
  }) {
    final input = '$userId:$entityType:$localId:${createdAt.toIso8601String()}';
    // Simple hash — replace with crypto sha256 in production
    return input.hashCode.toRadixString(16).padLeft(16, '0');
  }

  String _mapTableToCollection(String table) {
    const mapping = {
      'food_logs': AW.colFoodLogs,
      'food_items': AW.colFoodItems,
      'workout_logs': AW.colWorkoutLogs,
      'step_logs': AW.colStepLogs,
      'sleep_logs': AW.colSleepLogs,
      'mood_logs': AW.colMoodLogs,
      'habits': AW.colHabits,
      'habit_completions': AW.colHabitCompletions,
      'body_measurements': AW.colBodyMeasurements,
      'medications': AW.colMedications,
      'fasting_logs': AW.colFastingLogs,
      'meal_plans': AW.colMealPlans,
      'recipes': AW.colRecipes,
      'blood_pressure_logs': AW.colBloodPressureLogs,
      'glucose_logs': AW.colGlucoseLogs,
      'spo2_logs': AW.colSpo2Logs,
      'period_logs': AW.colPeriodLogs,
      'journal_entries': AW.colJournalEntries,
      'doctor_appointments': AW.colDoctorAppointments,
      'lab_reports': AW.colLabReports,
      'abha_links': AW.colAbhaLinks,
      'emergency_card': AW.colEmergencyCard,
      'karma_transactions': AW.colKarmaTransactions,
      'nutrition_goals': AW.colNutritionGoals,
    };
    return mapping[table] ?? table;
  }
}

// ═══════════════════════════════════════════════════════════════
// Delta Sync
// ═══════════════════════════════════════════════════════════════

/// Performs delta sync — only fetches documents updated since last sync.
class DeltaSync {
  final Databases _databases;
  final String _userId;

  DeltaSync({
    required Databases databases,
    required String userId,
  })  : _databases = databases,
        _userId = userId;

  /// Fetch all documents updated after [lastSync] for a collection.
  Future<List<Map<String, dynamic>>> fetchDelta({
    required String collectionId,
    required DateTime lastSync,
    int limit = 100,
  }) async {
    final result = await _databases.listDocuments(
      databaseId: AW.databaseId,
      collectionId: collectionId,
      queries: [
        Query.greaterThan('\$updatedAt', lastSync.toIso8601String()),
        Query.orderAsc('\$updatedAt'),
        Query.limit(limit),
      ],
    );

    return result.documents.map((doc) => doc.data).toList();
  }

  /// Run full delta sync across all user collections.
  Future<Map<String, int>> syncAll({
    required DateTime lastSync,
    required List<String> collections,
  }) async {
    final counts = <String, int>{};

    for (final collectionId in collections) {
      try {
        final docs = await fetchDelta(
          collectionId: collectionId,
          lastSync: lastSync,
        );
        counts[collectionId] = docs.length;
        // Process each document — upsert into local Drift tables
        // (Implementation depends on specific table mapping)
      } catch (e) {
        debugPrint('Delta sync failed for $collectionId: $e');
        counts[collectionId] = 0;
      }
    }

    return counts;
  }
}
