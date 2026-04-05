import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import '../presentation/workout_log_screen.dart';
import '../presentation/pr_celebration_overlay.dart';
import '../../karma/data/karma_service.dart';

part 'workout_controller.g.dart';

@riverpod
class WorkoutController extends _$WorkoutController {
  @override
  void build() {}
  
  Stream<List<PersonalRecord>> watchUserPRs(String userId) {
    final db = ref.read(databaseProvider);
    return (db.select(db.personalRecords)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.achievedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<List<PersonalRecord>> getBestRecords(String userId) async {
    final db = ref.read(databaseProvider);
    // Fetch all and group by exercise in memory for simplicity or use custom query
    final all = await (db.select(db.personalRecords)
          ..where((t) => t.userId.equals(userId)))
        .get();
        
    final Map<String, PersonalRecord> bestMap = {};
    for (final pr in all) {
      final existing = bestMap[pr.exerciseName];
      if (existing == null || pr.value > existing.value) {
        bestMap[pr.exerciseName] = pr;
      }
    }
    return bestMap.values.toList();
  }

  Future<void> saveWorkout({
    required List<ExerciseWithSets> exercises,
    required String title,
    required String userId,
    double? rpe,
  }) async {
    final db = ref.read(databaseProvider);
    final workoutId = const Uuid().v4();
    final now = DateTime.now();

    await db.transaction(() async {
      // 1. Create Workout Log
      await db.into(db.workoutLogs).insert(
        WorkoutLogsCompanion.insert(
          id: workoutId,
          userId: userId,
          title: title,
          durationMin: 0, 
          loggedAt: now,
          rpeLevel: Value(rpe),
          source: 'manual',
          idempotencyKey: 'workout_$workoutId',
        ),
      );

      // 2. Create Exercise Sets & Check for PRs
      for (final exWithSet in exercises) {
        double? exerciseMaxWeight;
        int? repsForMaxWeight;

        for (final set in exWithSet.sets) {
          if (!set.isCompleted) continue;

          await db.into(db.exerciseSets).insert(
            ExerciseSetsCompanion.insert(
              id: const Uuid().v4(),
              workoutLogId: workoutId,
              exerciseId: exWithSet.exercise.id,
              setNumber: set.setNumber,
              weight: Value(set.weight),
              reps: Value(set.reps),
              rpe: Value(set.rpe),
              isWarmup: Value(set.isWarmup),
              isCompleted: Value(set.isCompleted),
              createdAt: now,
            ),
          );

          // Track the best set in this workout for this exercise
          final currentWeight = set.weight ?? 0;
          if (exerciseMaxWeight == null || currentWeight > exerciseMaxWeight) {
            exerciseMaxWeight = currentWeight;
            repsForMaxWeight = set.reps;
          }
        }

        // 3. Check for PR after all sets for this exercise are processed
        if (exerciseMaxWeight != null && exerciseMaxWeight > 0) {
          await checkPR(
            exerciseId: exWithSet.exercise.id,
            weight: exerciseMaxWeight,
            reps: repsForMaxWeight ?? 0,
            unit: 'kg', // Default to kg for now, could be passed from profile
            userId: userId,
          );
        }
      }
    });
    
    // Award XP
    final karma = ref.read(karmaServiceProvider.notifier);
    await karma.grantXP(KarmaAction.workout);
  }

  Future<void> checkPR({
    required String exerciseId,
    required double weight,
    required int reps,
    required String unit,
    required String userId,
  }) async {
    final db = ref.read(databaseProvider);
    final exercise = await (db.select(db.exercises)..where((t) => t.id.equals(exerciseId))).getSingle();
    
    // Check for "Absolute Weight" PR
    final currentPR = await (db.select(db.personalRecords)
      ..where((t) => t.exerciseName.equals(exercise.name))
      ..orderBy([(t) => OrderingTerm(expression: t.value, mode: OrderingMode.desc)])
      ..limit(1))
      .getSingleOrNull();

    // Also check for "Rep PR" (Max weight for THIS specific rep count)
    final repPR = await (db.select(db.personalRecords)
      ..where((t) => t.exerciseName.equals(exercise.name) & t.reps.equals(reps))
      ..orderBy([(t) => OrderingTerm(expression: t.value, mode: OrderingMode.desc)])
      ..limit(1))
      .getSingleOrNull();

    bool isNewAbsolutePR = currentPR == null || weight > currentPR.value;
    bool isNewRepPR = repPR == null || weight > repPR.value;

    if (isNewAbsolutePR || (isNewRepPR && reps > 0)) {
      final prId = const Uuid().v4();
      final newPR = PersonalRecord(
        id: prId,
        userId: userId,
        exerciseName: exercise.name,
        value: weight,
        reps: reps,
        unit: unit,
        achievedAt: DateTime.now(),
        syncStatus: 'pending',
      );
      
      await db.into(db.personalRecords).insert(newPR);
      
      // If it's an absolute PR, celebrate! 
      // (Maybe rep PRs also deserve celebration if it's a significant milestone)
      if (isNewAbsolutePR) {
        ref.read(pRCelebrationProvider.notifier).show(newPR);
      }
    }
  }
}
