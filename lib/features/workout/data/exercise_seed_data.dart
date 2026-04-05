import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';

class ExerciseSeedData {
  static final items = [
    ExercisesCompanion(
      id: Value('bench_press_bb'),
      name: Value('Barbell Bench Press'),
      muscleGroup: Value('Chest'),
      equipment: Value('Barbell'),
      isCustom: Value(false),
    ),
    ExercisesCompanion(
      id: Value('squat_bb'),
      name: Value('Barbell Back Squat'),
      muscleGroup: Value('Legs'),
      equipment: Value('Barbell'),
    ),
    ExercisesCompanion(
      id: Value('deadlift_bb'),
      name: Value('Barbell Deadlift'),
      muscleGroup: Value('Back'),
      equipment: Value('Barbell'),
    ),
    ExercisesCompanion(
      id: Value('overhead_press_bb'),
      name: Value('Overhead Press'),
      muscleGroup: Value('Shoulders'),
      equipment: Value('Barbell'),
    ),
    ExercisesCompanion(
      id: Value('bicep_curl_db'),
      name: Value('Dumbbell Bicep Curl'),
      muscleGroup: Value('Arms'),
      equipment: Value('Dumbbell'),
    ),
    ExercisesCompanion(
      id: Value('pushup_bw'),
      name: Value('Push-ups'),
      muscleGroup: Value('Chest'),
      equipment: Value('Bodyweight'),
    ),
    ExercisesCompanion(
      id: Value('pullup_bw'),
      name: Value('Pull-ups'),
      muscleGroup: Value('Back'),
      equipment: Value('Bodyweight'),
    ),
    ExercisesCompanion(
      id: Value('lunges_bw'),
      name: Value('Lunges'),
      muscleGroup: Value('Legs'),
      equipment: Value('Bodyweight'),
    ),
    ExercisesCompanion(
      id: Value('surya_namaskar'),
      name: Value('Surya Namaskar'),
      muscleGroup: Value('Full Body'),
      equipment: Value('Bodyweight'),
      description: Value('Traditional Indian Sun Salutation'),
    ),
    ExercisesCompanion(
      id: Value('plank_bw'),
      name: Value('Plank'),
      muscleGroup: Value('Core'),
      equipment: Value('Bodyweight'),
    ),
  ];
}
