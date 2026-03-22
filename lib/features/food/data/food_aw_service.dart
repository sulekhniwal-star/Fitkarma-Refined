// lib/features/food/data/food_aw_service.dart
// Appwrite service for food items search and logs sync

import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:flutter/foundation.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Collection IDs for food-related data
class FoodCollectionIds {
  static const String foodLogs = 'food_logs';
  static const String foodItems = 'food_items';
  static const String databaseId = 'fitkarma';
}

/// Appwrite service for food-related operations
class FoodAwService {
  final AuthAwService _authService = AuthAwService();

  /// Get the Appwrite Databases instance
  appwrite.Databases get _databases => AppwriteClient.databases;

  /// Search food items in Appwrite
  Future<List<Map<String, dynamic>>> searchFoodItems(String query) async {
    try {
      final userId = await _authService.getStoredUserId();
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      // Use queries to search food items
      final response = await _databases.listDocuments(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodItems,
        queries: [
          appwrite.Query.search('name', query),
          appwrite.Query.limit(50),
        ],
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Search food items failed: ${e.message}');
      rethrow;
    }
  }

  /// Get food item by ID
  Future<Map<String, dynamic>?> getFoodItem(String itemId) async {
    try {
      final response = await _databases.getDocument(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodItems,
        documentId: itemId,
      );
      return response.data;
    } on appwrite.AppwriteException catch (e) {
      if (e.code == 404) {
        return null;
      }
      debugPrint('Get food item failed: ${e.message}');
      rethrow;
    }
  }

  /// Create a food log in Appwrite
  Future<String> createFoodLog({
    required String id,
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
    required String idempotencyKey,
  }) async {
    try {
      final response = await _databases.createDocument(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodLogs,
        documentId: id,
        data: {
          'userId': userId,
          'foodItemId': foodItemId,
          'recipeId': recipeId,
          'foodName': foodName,
          'mealType': mealType,
          'quantityG': quantityG,
          'calories': calories,
          'proteinG': proteinG,
          'carbsG': carbsG,
          'fatG': fatG,
          'fiberG': fiberG,
          'vitaminDMcg': vitaminDMcg,
          'vitaminB12Mcg': vitaminB12Mcg,
          'ironMg': ironMg,
          'calciumMg': calciumMg,
          'loggedAt': loggedAt.toIso8601String(),
          'logMethod': logMethod,
          'syncStatus': 'synced',
          'idempotencyKey': idempotencyKey,
        },
        permissions: [
          appwrite.Permission.read(appwrite.Role.user(userId)),
          appwrite.Permission.write(appwrite.Role.user(userId)),
        ],
      );

      return response.$id;
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Create food log failed: ${e.message}');
      rethrow;
    }
  }

  /// Update a food log in Appwrite
  Future<void> updateFoodLog({
    required String id,
    required String userId,
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
    try {
      final Map<String, dynamic> data = {};
      if (foodItemId != null) data['foodItemId'] = foodItemId;
      if (recipeId != null) data['recipeId'] = recipeId;
      if (foodName != null) data['foodName'] = foodName;
      if (mealType != null) data['mealType'] = mealType;
      if (quantityG != null) data['quantityG'] = quantityG;
      if (calories != null) data['calories'] = calories;
      if (proteinG != null) data['proteinG'] = proteinG;
      if (carbsG != null) data['carbsG'] = carbsG;
      if (fatG != null) data['fatG'] = fatG;
      if (fiberG != null) data['fiberG'] = fiberG;
      if (vitaminDMcg != null) data['vitaminDMcg'] = vitaminDMcg;
      if (vitaminB12Mcg != null) data['vitaminB12Mcg'] = vitaminB12Mcg;
      if (ironMg != null) data['ironMg'] = ironMg;
      if (calciumMg != null) data['calciumMg'] = calciumMg;
      if (logMethod != null) data['logMethod'] = logMethod;

      await _databases.updateDocument(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodLogs,
        documentId: id,
        data: data,
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Update food log failed: ${e.message}');
      rethrow;
    }
  }

  /// Delete a food log from Appwrite
  Future<void> deleteFoodLog(String id) async {
    try {
      await _databases.deleteDocument(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodLogs,
        documentId: id,
      );
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Delete food log failed: ${e.message}');
      rethrow;
    }
  }

  /// Get food logs from Appwrite for a user
  Future<List<Map<String, dynamic>>> getUserFoodLogs(String userId) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodLogs,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.limit(100),
          appwrite.Query.orderDesc('loggedAt'),
        ],
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get user food logs failed: ${e.message}');
      rethrow;
    }
  }

  /// Get food logs from Appwrite for a specific date range
  Future<List<Map<String, dynamic>>> getFoodLogsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await _databases.listDocuments(
        databaseId: FoodCollectionIds.databaseId,
        collectionId: FoodCollectionIds.foodLogs,
        queries: [
          appwrite.Query.equal('userId', userId),
          appwrite.Query.greaterThanEqual(
            'loggedAt',
            startDate.toIso8601String(),
          ),
          appwrite.Query.lessThan('loggedAt', endDate.toIso8601String()),
          appwrite.Query.limit(100),
          appwrite.Query.orderDesc('loggedAt'),
        ],
      );

      return response.documents.map((doc) => doc.data).toList();
    } on appwrite.AppwriteException catch (e) {
      debugPrint('Get food logs by date range failed: ${e.message}');
      rethrow;
    }
  }

  /// Sync local food logs to Appwrite
  Future<void> syncFoodLog({
    required String id,
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
    required String idempotencyKey,
  }) async {
    try {
      await createFoodLog(
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
        loggedAt: loggedAt,
        logMethod: logMethod,
        idempotencyKey: idempotencyKey,
      );
    } catch (e) {
      debugPrint('Sync food log failed: $e');
      rethrow;
    }
  }
}
