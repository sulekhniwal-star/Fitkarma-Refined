import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';
import '../repositories/workout_repository.dart';

part 'workout_provider.g.dart';

@riverpod
class WorkoutNotifier extends _$WorkoutNotifier {
  @override
  Stream<List<Workout>> build() {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value([]);

    return ref.watch(appDatabaseProvider).watchWorkoutHistory(user.$id, 50);
  }

  Future<void> startWorkout({
    required String name,
    required String type,
  }) async {
    final authState = ref.read(authNotifierProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();
    
    final companion = WorkoutsCompanion.insert(
      id: id,
      userId: user.$id,
      name: name,
      type: type,
      startedAt: DateTime.now(),
      durationMinutes: const Value(null), // In-progress
    );

    await db.into(db.workouts).insert(companion);
    
    try {
      await ref.read(workoutRepositoryProvider).pushWorkoutToRemote(id);
    } catch (_) {}
  }

  Future<void> finishWorkout({
    required String id,
    required int durationMinutes,
    double? caloriesBurned,
    double? distanceKm,
    String? exercisesJson,
  }) async {
    final db = ref.read(appDatabaseProvider);
    
    await (db.update(db.workouts)..where((t) => t.id.equals(id))).write(
      WorkoutsCompanion(
        durationMinutes: Value(durationMinutes),
        caloriesBurned: Value(caloriesBurned),
        distanceKm: Value(distanceKm),
        exercisesJson: Value(exercisesJson),
        syncStatus: const Value('pending'),
      ),
    );
    
    try {
      await ref.read(workoutRepositoryProvider).pushWorkoutToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<Workout?> activeWorkout(ActiveWorkoutRef ref) {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value(null);

  return ref.watch(appDatabaseProvider).watchActiveWorkout(user.$id);
}

@riverpod
Stream<List<Workout>> workoutHistory(WorkoutHistoryRef ref, {int limit = 20}) {
  final authState = ref.watch(authNotifierProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchWorkoutHistory(user.$id, limit);
}

@riverpod
Map<String, dynamic> personalRecords(PersonalRecordsRef ref) {
  final historyAsync = ref.watch(workoutHistoryProvider(limit: 100));
  
  return historyAsync.when(
    data: (workouts) {
      final records = <String, dynamic>{};
      
      for (final workout in workouts) {
        if (workout.exercisesJson == null) continue;
        try {
          final List<dynamic> exercises = jsonDecode(workout.exercisesJson!);
          for (final ex in exercises) {
            final name = ex['exercise'] as String;
            final sets = ex['sets'] as List<dynamic>;
            
            for (final set in sets) {
              final weight = (set['weight'] as num?)?.toDouble() ?? 0.0;
              final reps = (set['reps'] as num?)?.toInt() ?? 0;
              
              if (!records.containsKey(name) || weight > (records[name]['weight'] as double)) {
                records[name] = {'weight': weight, 'reps': reps, 'date': workout.startedAt};
              }
            }
          }
        } catch (_) {}
      }
      return records;
    },
    loading: () => {},
    error: (_, __) => {},
  );
}
