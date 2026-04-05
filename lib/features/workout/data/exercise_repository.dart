import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import 'exercise_seed_data.dart';

part 'exercise_repository.g.dart';

class ExerciseRepository {
  final AppDatabase db;

  ExerciseRepository(this.db);

  Future<void> seedIfNeeded() async {
    final count = await db.exercises.select().get();
    if (count.isEmpty) {
      await db.batch((batch) {
        batch.insertAll(db.exercises, ExerciseSeedData.items);
      });
    }
  }

  Future<List<Exercise>> searchExercises(String query) async {
    return await (db.select(db.exercises)
          ..where((t) => t.name.contains(query) | t.muscleGroup.contains(query)))
        .get();
  }

  Future<List<Exercise>> getExercisesByMuscleGroup(String muscleGroup) async {
    return await (db.select(db.exercises)
          ..where((t) => t.muscleGroup.equals(muscleGroup)))
        .get();
  }
}

@riverpod
ExerciseRepository exerciseRepository(Ref ref) {
  return ExerciseRepository(ref.watch(databaseProvider));
}
