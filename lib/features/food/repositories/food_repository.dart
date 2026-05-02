import 'package:drift/drift.dart';
import 'package:dio/dio.dart';
import 'package:fitkarma/core/database/app_database.dart';
import 'package:fitkarma/core/database/tables_db.dart';
import 'package:fitkarma/core/config/app_config.dart';

class FoodRepository {
  final AppDatabase _db;
  final TablesDB _tables;
  final Dio _dio;

  FoodRepository(this._db, this._tables, this._dio);

  Future<void> pushToRemote(String localId) async {
    try {
      // 1. Fetch from local
      final log = await (_db.select(_db.foodLogs)..where((t) => t.id.equals(localId))).getSingle();
      
      // 2. Push to Appwrite
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.foodLogsCol,
        rowId: log.id,
        data: {
          'userId': log.userId,
          'foodName': log.foodName,
          'foodNameLocal': log.foodNameLocal,
          'mealType': log.mealType,
          'loggedAt': log.loggedAt.toIso8601String(),
          'calories': log.calories,
          'proteinG': log.proteinG,
          'carbsG': log.carbsG,
          'fatG': log.fatG,
          'portionUnit': log.portionUnit,
          'portionQty': log.portionQty,
          'source': log.source,
        },
      );

      // 3. Mark as synced
      await _db.markSynced(localId, log.id, 'food_logs');
    } catch (e) {
      // 4. Handle failure (increment attempts)
      await _db.incrementFailedAttempts(localId, 'food_logs');
      rethrow;
    }
  }

  Future<List<FoodLog>> searchLocal(String query) async {
    return (_db.select(_db.foodLogs)
          ..where((t) => t.foodName.like('%$query%'))
          ..limit(10))
        .get();
  }

  Future<List<FoodLog>> searchRemote(String query) async {
    try {
      final response = await _dio.get(
        'https://world.openfoodfacts.org/cgi/search.pl',
        queryParameters: {
          'search_terms': query,
          'search_simple': 1,
          'action': 'process',
          'json': 1,
          'page_size': 10,
        },
      );

      if (response.statusCode == 200) {
        final products = response.data['products'] as List<dynamic>;
        return products.map((p) {
          final nutriments = p['nutriments'] ?? {};
          return FoodLog(
            id: 'remote_${p['_id']}',
            userId: '', // Not assigned yet
            foodName: p['product_name'] ?? 'Unknown',
            mealType: 'snack', // Default
            loggedAt: DateTime.now(),
            calories: (nutriments['energy-kcal_100g'] ?? 0.0).toDouble(),
            proteinG: (nutriments['proteins_100g'] ?? 0.0).toDouble(),
            carbsG: (nutriments['carbohydrates_100g'] ?? 0.0).toDouble(),
            fatG: (nutriments['fat_100g'] ?? 0.0).toDouble(),
            portionUnit: '100g',
            portionQty: 1.0,
            source: 'openfoodfacts',
            syncStatus: 'synced',
            failedAttempts: 0,
          );
        }).toList();
      }
    } catch (e) {
      // Log error or ignore
    }
    return [];
  }
}
