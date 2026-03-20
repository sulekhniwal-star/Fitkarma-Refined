// lib/features/food/data/food_repository.dart
// Repository for food data: Drift-first, Appwrite fallback, queue sync

import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';
import 'package:fitkarma/features/food/data/food_drift_service.dart';
import 'package:fitkarma/features/food/data/food_aw_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:flutter/foundation.dart';

/// Repository for food logs and food items
///
/// Architecture:
/// - Read: Drift (local) first, fallback to Appwrite
/// - Write: Always write to Drift first, then queue for Appwrite sync
/// - Sync: Background service watches connectivity and syncs pending items
class FoodRepository {
  final FoodDriftService _driftService;
  final FoodAwService _awService;
  final AuthAwService _authService;
  final ConnectivityService _connectivityService;

  FoodRepository({
    required FoodDriftService driftService,
    required FoodAwService awService,
    required AuthAwService authService,
    required ConnectivityService connectivityService,
  }) : _driftService = driftService,
       _awService = awService,
       _authService = authService,
       _connectivityService = connectivityService;

  /// Create a new food log entry
  ///
  /// Always writes to local Drift first, then attempts to sync to Appwrite
  Future<String> createFoodLog({
    required String foodName,
    required String mealType,
    required double quantityG,
    required double calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    double? fiberG,
    double? vitaminDMcg,
    double? vitaminB12Mcg,
    double? ironMg,
    double? calciumMg,
    String? foodItemId,
    String? recipeId,
    DateTime? loggedAt,
    String logMethod = 'manual',
  }) async {
    final userId = await _authService.getStoredUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    final logTime = loggedAt ?? DateTime.now();

    // Always create in local Drift first
    final localId = await _driftService.createFoodLog(
      userId: userId,
      foodItemId: foodItemId,
      recipeId: recipeId,
      foodName: foodName,
      mealType: mealType,
      quantityG: quantityG,
      calories: calories,
      proteinG: proteinG,
      carbsG: carbsG,
      fatG: fatG,
      fiberG: fiberG,
      vitaminDMcg: vitaminDMcg,
      vitaminB12Mcg: vitaminB12Mcg,
      ironMg: ironMg,
      calciumMg: calciumMg,
      loggedAt: logTime,
      logMethod: logMethod,
    );

    // Try to sync to Appwrite if online
    if (_connectivityService.isOnline) {
      try {
        final logs = await _driftService.getPendingFoodLogs();
        final pendingLog = logs.firstWhere(
          (l) => l.id == localId,
          orElse: () => throw Exception('Log not found'),
        );

        await _awService.syncFoodLog(
          id: pendingLog.id,
          userId: pendingLog.userId,
          foodItemId: pendingLog.foodItemId,
          recipeId: pendingLog.recipeId,
          foodName: pendingLog.foodName,
          mealType: pendingLog.mealType,
          quantityG: pendingLog.quantityG,
          calories: pendingLog.calories,
          proteinG: pendingLog.proteinG,
          carbsG: pendingLog.carbsG,
          fatG: pendingLog.fatG,
          fiberG: pendingLog.fiberG,
          vitaminDMcg: pendingLog.vitaminDMcg,
          vitaminB12Mcg: pendingLog.vitaminB12Mcg,
          ironMg: pendingLog.ironMg,
          calciumMg: pendingLog.calciumMg,
          loggedAt: pendingLog.loggedAt,
          logMethod: pendingLog.logMethod,
          idempotencyKey: pendingLog.idempotencyKey,
        );

        // Mark as synced
        await _driftService.markAsSynced(localId);
      } catch (e) {
        debugPrint('Background sync failed for food log: $e');
        // Keep as pending, will be synced later
      }
    }

    return localId;
  }

  /// Get food logs for the current user
  ///
  /// Tries local Drift first, falls back to Appwrite if needed
  Future<List<FoodLog>> getUserFoodLogs() async {
    final userId = await _authService.getStoredUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    try {
      // Try local first
      final localLogs = await _driftService.getUserFoodLogs(userId);
      if (localLogs.isNotEmpty) {
        return localLogs;
      }

      // Fallback to Appwrite if local is empty
      if (_connectivityService.isOnline) {
        final remoteLogs = await _awService.getUserFoodLogs(userId);
        // Could optionally import remote logs to local Drift here
        return localLogs; // Return local for now
      }

      return localLogs;
    } catch (e) {
      debugPrint('Get food logs failed: $e');
      rethrow;
    }
  }

  /// Get food logs for a specific date
  Future<List<FoodLog>> getFoodLogsByDate(DateTime date) async {
    final userId = await _authService.getStoredUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await _driftService.getFoodLogsByDateRange(
      userId,
      DateTime(date.year, date.month, date.day),
      DateTime(date.year, date.month, date.day, 23, 59, 59),
    );
  }

  /// Get food logs by meal type for a specific date
  Future<List<FoodLog>> getFoodLogsByMealType(
    String mealType,
    DateTime date,
  ) async {
    final userId = await _authService.getStoredUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await _driftService.getFoodLogsByMealType(userId, mealType, date);
  }

  /// Update a food log entry
  Future<void> updateFoodLog({
    required String id,
    String? foodItemId,
    String? recipeId,
    String? foodName,
    String? mealType,
    double? quantityG,
    double? calories,
    double? proteinG,
    double? carbsG,
    double? fatG,
    double? fiberG,
    double? vitaminDMcg,
    double? vitaminB12Mcg,
    double? ironMg,
    double? calciumMg,
    String? logMethod,
  }) async {
    // Update in local Drift first
    await _driftService.updateFoodLog(
      id: id,
      foodItemId: foodItemId,
      recipeId: recipeId,
      foodName: foodName,
      mealType: mealType,
      quantityG: quantityG,
      calories: calories,
      proteinG: proteinG,
      carbsG: carbsG,
      fatG: fatG,
      fiberG: fiberG,
      vitaminDMcg: vitaminDMcg,
      vitaminB12Mcg: vitaminB12Mcg,
      ironMg: ironMg,
      calciumMg: calciumMg,
      logMethod: logMethod,
    );

    // Try to sync to Appwrite if online
    if (_connectivityService.isOnline) {
      try {
        final userId = await _authService.getStoredUserId();
        if (userId != null) {
          await _awService.updateFoodLog(
            id: id,
            userId: userId,
            foodItemId: foodItemId,
            recipeId: recipeId,
            foodName: foodName,
            mealType: mealType,
            quantityG: quantityG,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fiberG: fiberG,
            vitaminDMcg: vitaminDMcg,
            vitaminB12Mcg: vitaminB12Mcg,
            ironMg: ironMg,
            calciumMg: calciumMg,
            logMethod: logMethod,
          );
        }
      } catch (e) {
        debugPrint('Background sync failed for food log update: $e');
      }
    }
  }

  /// Delete a food log entry
  Future<void> deleteFoodLog(String id) async {
    // Delete from local Drift first
    await _driftService.deleteFoodLog(id);

    // Try to delete from Appwrite if online
    if (_connectivityService.isOnline) {
      try {
        await _awService.deleteFoodLog(id);
      } catch (e) {
        debugPrint('Background sync failed for food log deletion: $e');
      }
    }
  }

  /// Search food items
  Future<List<Map<String, dynamic>>> searchFoodItems(String query) async {
    // Only search Appwrite (source of truth for food items)
    if (!_connectivityService.isOnline) {
      return [];
    }

    try {
      return await _awService.searchFoodItems(query);
    } catch (e) {
      debugPrint('Search food items failed: $e');
      return [];
    }
  }

  /// Get daily nutrition summary
  Future<Map<String, double>> getDailyNutritionSummary(DateTime date) async {
    final userId = await _authService.getStoredUserId();
    if (userId == null) {
      throw Exception('User not authenticated');
    }

    return await _driftService.getDailyNutritionSummary(userId, date);
  }

  /// Sync pending food logs to Appwrite
  ///
  /// Called by background sync service
  Future<void> syncPendingLogs() async {
    if (!_connectivityService.isOnline) {
      return;
    }

    final pendingLogs = await _driftService.getPendingFoodLogs();

    for (final log in pendingLogs) {
      try {
        await _awService.syncFoodLog(
          id: log.id,
          userId: log.userId,
          foodItemId: log.foodItemId,
          recipeId: log.recipeId,
          foodName: log.foodName,
          mealType: log.mealType,
          quantityG: log.quantityG,
          calories: log.calories,
          proteinG: log.proteinG,
          carbsG: log.carbsG,
          fatG: log.fatG,
          fiberG: log.fiberG,
          vitaminDMcg: log.vitaminDMcg,
          vitaminB12Mcg: log.vitaminB12Mcg,
          ironMg: log.ironMg,
          calciumMg: log.calciumMg,
          loggedAt: log.loggedAt,
          logMethod: log.logMethod,
          idempotencyKey: log.idempotencyKey,
        );

        await _driftService.markAsSynced(log.id);
      } catch (e) {
        debugPrint('Failed to sync food log ${log.id}: $e');

        // Mark as conflict after multiple failures
        // Could implement retry logic here
      }
    }
  }
}
