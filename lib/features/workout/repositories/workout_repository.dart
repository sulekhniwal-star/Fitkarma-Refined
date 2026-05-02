import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/database/app_database.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

part 'workout_repository.g.dart';

class WorkoutRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  WorkoutRepository(this._db, this._tables);

  Future<void> pushWorkoutToRemote(String localId) async {
    try {
      final workout = await (_db.select(_db.workouts)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.workoutsCol,
        rowId: workout.id,
        data: {
          'userId': workout.userId,
          'name': workout.name,
          'type': workout.type,
          'startedAt': workout.startedAt.toIso8601String(),
          'durationMinutes': workout.durationMinutes,
          'caloriesBurned': workout.caloriesBurned,
          'distanceKm': workout.distanceKm,
          'avgHeartRate': workout.avgHeartRate,
          'exercisesJson': workout.exercisesJson,
        },
      );

      await _db.markSynced(localId, workout.id, 'workouts');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'workouts');
      rethrow;
    }
  }
}

@riverpod
WorkoutRepository workoutRepository(Ref ref) {
  return WorkoutRepository(
    ref.watch(appDatabaseProvider),
    ref.watch(appwriteTablesDBProvider),
  );
}
