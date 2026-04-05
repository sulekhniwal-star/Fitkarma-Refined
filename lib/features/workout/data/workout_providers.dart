import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import 'workout_repository.dart';

final workoutRepositoryProvider = Provider<WorkoutRepository>((ref) {
  return WorkoutRepository(ref.watch(databaseProvider));
});

final workoutListProvider = FutureProvider.family<List<Workout>, String>((ref, category) async {
  final repo = ref.watch(workoutRepositoryProvider);
  await repo.seedWorkouts();
  if (category.isEmpty) {
    return repo.getAllWorkouts();
  }
  return repo.getByCategory(category);
});

final workoutDetailProvider = FutureProvider.family<Workout?, String>((ref, id) async {
  final repo = ref.watch(workoutRepositoryProvider);
  return repo.getWorkoutById(id);
});