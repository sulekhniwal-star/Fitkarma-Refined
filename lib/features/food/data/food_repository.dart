import 'dart:convert';
import 'package:drift/drift.dart';
import 'food_drift_service.dart';
import 'food_aw_service.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/constants/api_endpoints.dart';

class FoodRepository {
  final FoodDriftService _drift;
  final FoodAwService _aw;
  final AppDatabase _db;

  FoodRepository(this._drift, this._aw, this._db);

  /// Comprehensive food search: Local FTS5 -> Remote Appwrite -> External APIs.
  Future<List<Map<String, dynamic>>> search(String query) async {
    final results = <Map<String, dynamic>>[];

    // 1. Local FTS5 Search (Instant)
    final localItems = await _drift.searchFoodFts(query);
    results.addAll(localItems.map((i) => {
      'id': i.id,
      'name': i.name,
      'caloriesPer100g': i.caloriesPer100g,
      'source': 'local',
    }));

    // 2. Remote Appwrite Search if local results are sparse
    if (results.length < 5) {
      try {
        final remoteDocs = await _aw.searchRemote(query);
        results.addAll(remoteDocs.map((d) => {
          'id': d.$id,
          'name': d.data['name'],
          'calories': d.data['calories'],
          'source': 'cloud',
          'emoji': d.data['emoji'] ?? '🍽',
        }));
      } catch (_) {
        // Log error and continue
      }
    }

    // 3. TODO: OpenFoodFacts integration as last resort

    return results;
  }

  /// Logs a food entry locally and enqueues it for remote synchronization.
  Future<void> logFood(FoodLogsCompanion log) async {
    // 1. Local Persistence
    final localId = await _drift.insertLog(log);

    // 2. Synchronize to Cloud via Queue
    await _db.into(_db.syncQueue).insert(
      SyncQueueCompanion.insert(
        collection: AW.foodLogs,
        operation: 'create',
        localId: localId.toString(),
        payload: jsonEncode({
          'food_name': log.foodName.value,
          'meal_type': log.mealType.value,
          'quantity_g': log.quantityG.value,
          'calories': log.calories.value,
          'protein_g': log.proteinG.value,
          'carbs_g': log.carbsG.value,
          'fat_g': log.fatG.value,
          'logged_at': log.loggedAt.value.toIso8601String(),
        }),
        idempotencyKey: log.idempotencyKey.value,
        createdAt: DateTime.now(),
      ),
    );
  }

  /// Copies yesterday's meals to today.
  Future<int> copyYesterday(String userId) async {
    return await _drift.copyYesterdayMeals(userId);
  }
}
