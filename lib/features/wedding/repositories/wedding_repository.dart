import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables_db.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

class WeddingRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  WeddingRepository(this._db, this._tables);

  Future<void> pushPlanToRemote(String localId) async {
    try {
      final plan = await (_db.select(_db.weddingPlans)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.weddingPlansCol,
        rowId: plan.id,
        data: {
          'userId': plan.userId,
          'role': plan.role,
          'relation': plan.relation,
          'firstEventTs': plan.firstEventTs.toIso8601String(),
          'lastEventTs': plan.lastEventTs.toIso8601String(),
          'eventsJson': plan.eventsJson,
          'prepWeeks': plan.prepWeeks,
          'primaryGoal': plan.primaryGoal,
          'currentPhase': plan.currentPhase,
          'createdAt': plan.createdAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, plan.id, 'wedding_plans');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'wedding_plans');
      rethrow;
    }
  }
}

final weddingRepositoryProvider = Provider<WeddingRepository>((ref) {
  return WeddingRepository(
    ref.read(appDatabaseProvider),
    ref.read(appwriteTablesDBProvider),
  );
});
