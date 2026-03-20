// lib/features/food/data/food_drift_service.dart
// Drift service for FoodLog CRUD operations

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

/// Drift service for managing FoodLog entries in local database
class FoodDriftService {
  final AppDatabase db;

  FoodDriftService(this.db);

  /// Generate a unique ID for a food log entry
  String _generateIdempotencyKey(
    String userId,
    DateTime loggedAt,
    String foodName,
  ) {
    final data = '$userId-${loggedAt.toIso8601String()}-$foodName';
    return md5.convert(utf8.encode(data)).toString();
  }

  /// Create a new food log entry
  Future<String> createFoodLog({
    required String userId,
    String? foodItemId,
    String? recipeId,
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
    required DateTime loggedAt,
    required String logMethod,
  }) async {
    final id = 'foodlog_${DateTime.now().millisecondsSinceEpoch}';
    final idempotencyKey = _generateIdempotencyKey(userId, loggedAt, foodName);

    await db
        .into(db.foodLogs)
        .insert(
          FoodLogsCompanion.insert(
            id: id,
            userId: userId,
            foodItemId: Value(foodItemId),
            recipeId: Value(recipeId),
            foodName: foodName,
            mealType: mealType,
            quantityG: quantityG,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fiberG: Value(fiberG),
            vitaminDMcg: Value(vitaminDMcg),
            vitaminB12Mcg: Value(vitaminB12Mcg),
            ironMg: Value(ironMg),
            calciumMg: Value(calciumMg),
            loggedAt: loggedAt,
            logMethod: logMethod,
            syncStatus: 'pending',
            idempotencyKey: idempotencyKey,
          ),
        );

    return id;
  }

  /// Get all food logs for a user
  Future<List<FoodLog>> getUserFoodLogs(String userId) async {
    return await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Get food logs for a user within a date range
  Future<List<FoodLog>> getFoodLogsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    return await (db.select(db.foodLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.loggedAt.isBiggerOrEqualValue(startDate) &
                t.loggedAt.isSmallerOrEqualValue(endDate),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Get food logs by meal type for a specific date
  Future<List<FoodLog>> getFoodLogsByMealType(
    String userId,
    String mealType,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await (db.select(db.foodLogs)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.mealType.equals(mealType) &
                t.loggedAt.isBiggerOrEqualValue(startOfDay) &
                t.loggedAt.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .get();
  }

  /// Get pending food logs (for sync)
  Future<List<FoodLog>> getPendingFoodLogs() async {
    return await (db.select(db.foodLogs)
          ..where((t) => t.syncStatus.equals('pending'))
          ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]))
        .get();
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
    await (db.update(db.foodLogs)..where((t) => t.id.equals(id))).write(
      FoodLogsCompanion(
        foodItemId: foodItemId != null
            ? Value(foodItemId)
            : const Value.absent(),
        recipeId: recipeId != null ? Value(recipeId) : const Value.absent(),
        foodName: foodName != null ? Value(foodName) : const Value.absent(),
        mealType: mealType != null ? Value(mealType) : const Value.absent(),
        quantityG: quantityG != null ? Value(quantityG) : const Value.absent(),
        calories: calories != null ? Value(calories) : const Value.absent(),
        proteinG: proteinG != null ? Value(proteinG) : const Value.absent(),
        carbsG: carbsG != null ? Value(carbsG) : const Value.absent(),
        fatG: fatG != null ? Value(fatG) : const Value.absent(),
        fiberG: Value(fiberG),
        vitaminDMcg: Value(vitaminDMcg),
        vitaminB12Mcg: Value(vitaminB12Mcg),
        ironMg: Value(ironMg),
        calciumMg: Value(calciumMg),
        logMethod: logMethod != null ? Value(logMethod) : const Value.absent(),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Delete a food log entry
  Future<void> deleteFoodLog(String id) async {
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(id))).go();
  }

  /// Mark a food log as synced
  Future<void> markAsSynced(String id) async {
    await (db.update(db.foodLogs)..where((t) => t.id.equals(id))).write(
      const FoodLogsCompanion(syncStatus: Value('synced')),
    );
  }

  /// Mark a food log as conflict
  Future<void> markAsConflict(String id) async {
    await (db.update(db.foodLogs)..where((t) => t.id.equals(id))).write(
      const FoodLogsCompanion(syncStatus: Value('conflict')),
    );
  }

  /// Get daily nutrition summary for a user
  Future<Map<String, double>> getDailyNutritionSummary(
    String userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final logs =
        await (db.select(db.foodLogs)..where(
              (t) =>
                  t.userId.equals(userId) &
                  t.loggedAt.isBiggerOrEqualValue(startOfDay) &
                  t.loggedAt.isSmallerThanValue(endOfDay),
            ))
            .get();

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;

    for (final log in logs) {
      totalCalories += log.calories;
      totalProtein += log.proteinG;
      totalCarbs += log.carbsG;
      totalFat += log.fatG;
      totalFiber += log.fiberG ?? 0;
    }

    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
      'fiber': totalFiber,
    };
  }
}
