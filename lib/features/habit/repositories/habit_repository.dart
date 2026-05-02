import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/app_database.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

part 'habit_repository.g.dart';

class HabitRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  HabitRepository(this._db, this._tables);

  Future<void> pushHabitToRemote(String localId) async {
    try {
      final habit = await (_db.select(_db.habits)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.habitsCol,
        rowId: habit.id,
        data: {
          'userId': habit.userId,
          'name': habit.name,
          'icon': habit.icon,
          'currentStreak': habit.currentStreak,
          'longestStreak': habit.longestStreak,
          'completedDatesJson': habit.completedDatesJson,
        },
      );

      await _db.markSynced(localId, habit.id, 'habits');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'habits');
      rethrow;
    }
  }
}

@riverpod
HabitRepository habitRepository(Ref ref) {
  return HabitRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appwriteTablesDBProvider),
  );
}
