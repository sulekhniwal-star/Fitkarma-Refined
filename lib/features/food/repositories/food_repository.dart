
import 'package:appwrite/appwrite.dart';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/database/app_database.dart';
import 'package:fitkarma/core/config/app_config.dart';

class FoodRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  FoodRepository(this._db, this._tables);

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
}
