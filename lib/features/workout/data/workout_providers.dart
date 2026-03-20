// lib/features/workout/data/workout_providers.dart
// Riverpod providers for workout feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/workout/data/workout_aw_service.dart';
import 'package:fitkarma/core/seed/workout_seed_data.dart';

/// Provider for WorkoutAwService
final workoutAwServiceProvider = Provider<WorkoutAwService>((ref) {
  return WorkoutAwService();
});

/// Provider for all workouts
final allWorkoutsProvider = FutureProvider<List<Workout>>((ref) async {
  final service = ref.watch(workoutAwServiceProvider);
  return service.getAllWorkouts();
});

/// Provider for featured workouts
final featuredWorkoutsProvider = FutureProvider<List<Workout>>((ref) async {
  final service = ref.watch(workoutAwServiceProvider);
  return service.getFeaturedWorkouts();
});

/// Provider for workouts by category
final workoutsByCategoryProvider = FutureProvider.family<List<Workout>, String>(
  (ref, category) async {
    final service = ref.watch(workoutAwServiceProvider);
    return service.getWorkoutsByCategory(category);
  },
);

/// Provider for workouts by difficulty
final workoutsByDifficultyProvider =
    FutureProvider.family<List<Workout>, String>((ref, difficulty) async {
      final service = ref.watch(workoutAwServiceProvider);
      return service.getWorkoutsByDifficulty(difficulty);
    });

/// Provider for a single workout by ID
final workoutByIdProvider = FutureProvider.family<Workout?, String>((
  ref,
  workoutId,
) async {
  final service = ref.watch(workoutAwServiceProvider);
  return service.getWorkout(workoutId);
});

/// Provider for workout categories
final workoutCategoriesProvider = Provider<List<String>>((ref) {
  return WorkoutSeedData.getCategories();
});

/// Provider for workout difficulties
final workoutDifficultiesProvider = Provider<List<String>>((ref) {
  return WorkoutSeedData.getDifficulties();
});

/// Provider for category icons
final categoryIconsProvider = Provider<Map<String, String>>((ref) {
  return WorkoutSeedData.getCategoryIcons();
});

/// Provider for difficulty colors
final difficultyColorsProvider = Provider<Map<String, String>>((ref) {
  return WorkoutSeedData.getDifficultyColors();
});

/// Notifier for selected category
class SelectedCategoryNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setCategory(String? category) {
    state = category;
  }

  void clear() {
    state = null;
  }
}

final selectedCategoryProvider =
    NotifierProvider<SelectedCategoryNotifier, String?>(
      SelectedCategoryNotifier.new,
    );

/// Notifier for selected difficulty
class SelectedDifficultyNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setDifficulty(String? difficulty) {
    state = difficulty;
  }

  void clear() {
    state = null;
  }
}

final selectedDifficultyProvider =
    NotifierProvider<SelectedDifficultyNotifier, String?>(
      SelectedDifficultyNotifier.new,
    );

/// Workout session state
class WorkoutSessionState {
  final Workout? currentWorkout;
  final DateTime? startTime;
  final bool isActive;
  final bool isPaused;
  final int elapsedSeconds;

  WorkoutSessionState({
    this.currentWorkout,
    this.startTime,
    this.isActive = false,
    this.isPaused = false,
    this.elapsedSeconds = 0,
  });

  WorkoutSessionState copyWith({
    Workout? currentWorkout,
    DateTime? startTime,
    bool? isActive,
    bool? isPaused,
    int? elapsedSeconds,
  }) {
    return WorkoutSessionState(
      currentWorkout: currentWorkout ?? this.currentWorkout,
      startTime: startTime ?? this.startTime,
      isActive: isActive ?? this.isActive,
      isPaused: isPaused ?? this.isPaused,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }
}

/// Notifier for workout session
class WorkoutSessionNotifier extends Notifier<WorkoutSessionState> {
  @override
  WorkoutSessionState build() {
    return WorkoutSessionState();
  }

  void startWorkout(Workout workout) {
    state = WorkoutSessionState(
      currentWorkout: workout,
      startTime: DateTime.now(),
      isActive: true,
      isPaused: false,
      elapsedSeconds: 0,
    );
  }

  void pauseWorkout() {
    if (state.isActive) {
      state = state.copyWith(isPaused: true);
    }
  }

  void resumeWorkout() {
    if (state.isActive && state.isPaused) {
      state = state.copyWith(isPaused: false);
    }
  }

  void endWorkout() {
    state = WorkoutSessionState();
  }

  void updateElapsedTime(int seconds) {
    state = state.copyWith(elapsedSeconds: seconds);
  }
}

final workoutSessionProvider =
    NotifierProvider<WorkoutSessionNotifier, WorkoutSessionState>(
      WorkoutSessionNotifier.new,
    );

/// Notifier for RPE (Rate of Perceived Exertion) value - 1-10
class RpeValueNotifier extends Notifier<int> {
  @override
  int build() => 5;

  void setRpe(int value) {
    if (value >= 1 && value <= 10) {
      state = value;
    }
  }
}

final rpeValueProvider = NotifierProvider<RpeValueNotifier, int>(
  RpeValueNotifier.new,
);

/// Rest timer state for between sets
class RestTimerState {
  final bool isActive;
  final int totalSeconds;
  final int remainingSeconds;

  RestTimerState({
    this.isActive = false,
    this.totalSeconds = 60,
    this.remainingSeconds = 60,
  });

  RestTimerState copyWith({
    bool? isActive,
    int? totalSeconds,
    int? remainingSeconds,
  }) {
    return RestTimerState(
      isActive: isActive ?? this.isActive,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

/// Notifier for rest timer state
class RestTimerNotifier extends Notifier<RestTimerState> {
  @override
  RestTimerState build() {
    return RestTimerState();
  }

  void startTimer(int seconds) {
    state = RestTimerState(
      isActive: true,
      totalSeconds: seconds,
      remainingSeconds: seconds,
    );
  }

  void tick() {
    if (state.isActive && state.remainingSeconds > 0) {
      state = state.copyWith(remainingSeconds: state.remainingSeconds - 1);
    }
    if (state.remainingSeconds == 0) {
      state = state.copyWith(isActive: false);
    }
  }

  void stopTimer() {
    state = RestTimerState();
  }

  void setRemainingSeconds(int seconds) {
    state = state.copyWith(remainingSeconds: seconds);
  }
}

final restTimerProvider = NotifierProvider<RestTimerNotifier, RestTimerState>(
  RestTimerNotifier.new,
);

/// GPS tracking state
class GpsTrackingState {
  final bool isTracking;
  final List<GpsPoint> trackPoints;
  final double? totalDistanceMeters;
  final Duration? duration;
  final double? currentSpeed;
  final double? averagePace; // min/km

  GpsTrackingState({
    this.isTracking = false,
    this.trackPoints = const [],
    this.totalDistanceMeters,
    this.duration,
    this.currentSpeed,
    this.averagePace,
  });

  GpsTrackingState copyWith({
    bool? isTracking,
    List<GpsPoint>? trackPoints,
    double? totalDistanceMeters,
    Duration? duration,
    double? currentSpeed,
    double? averagePace,
  }) {
    return GpsTrackingState(
      isTracking: isTracking ?? this.isTracking,
      trackPoints: trackPoints ?? this.trackPoints,
      totalDistanceMeters: totalDistanceMeters ?? this.totalDistanceMeters,
      duration: duration ?? this.duration,
      currentSpeed: currentSpeed ?? this.currentSpeed,
      averagePace: averagePace ?? this.averagePace,
    );
  }
}

/// GPS point model
class GpsPoint {
  final double latitude;
  final double longitude;
  final double? altitude;
  final double? speed;
  final DateTime timestamp;

  GpsPoint({
    required this.latitude,
    required this.longitude,
    this.altitude,
    this.speed,
    required this.timestamp,
  });
}

/// Notifier for GPS tracking state
class GpsTrackingNotifier extends Notifier<GpsTrackingState> {
  @override
  GpsTrackingState build() {
    return GpsTrackingState();
  }

  void startTracking() {
    state = GpsTrackingState(isTracking: true);
  }

  void stopTracking() {
    state = state.copyWith(isTracking: false);
  }

  void addPoint(GpsPoint point) {
    state = state.copyWith(trackPoints: [...state.trackPoints, point]);
  }

  void updateDistance(double distanceMeters) {
    state = state.copyWith(totalDistanceMeters: distanceMeters);
  }

  void updateDuration(Duration duration) {
    state = state.copyWith(duration: duration);
  }

  void updateSpeed(double speed) {
    state = state.copyWith(currentSpeed: speed);
  }

  void updateAveragePace(double pace) {
    state = state.copyWith(averagePace: pace);
  }

  void reset() {
    state = GpsTrackingState();
  }
}

final gpsTrackingProvider =
    NotifierProvider<GpsTrackingNotifier, GpsTrackingState>(
      GpsTrackingNotifier.new,
    );

/// Notifier for selected calendar date
class SelectedCalendarDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) {
    state = date;
  }
}

final selectedCalendarDateProvider =
    NotifierProvider<SelectedCalendarDateNotifier, DateTime>(
      SelectedCalendarDateNotifier.new,
    );

/// Date range for calendar queries
class DateRange {
  final DateTime start;
  final DateTime end;

  DateRange({required this.start, required this.end});
}

/// Custom workout exercise
class CustomExercise {
  final String id;
  final String name;
  final String? instructions;
  final int sets;
  final int? reps;
  final int? durationSec;
  final double? weightKg;
  final int restTimeSec;
  final int orderIndex;

  CustomExercise({
    required this.id,
    required this.name,
    this.instructions,
    required this.sets,
    this.reps,
    this.durationSec,
    this.weightKg,
    this.restTimeSec = 60,
    required this.orderIndex,
  });

  CustomExercise copyWith({
    String? id,
    String? name,
    String? instructions,
    int? sets,
    int? reps,
    int? durationSec,
    double? weightKg,
    int? restTimeSec,
    int? orderIndex,
  }) {
    return CustomExercise(
      id: id ?? this.id,
      name: name ?? this.name,
      instructions: instructions ?? this.instructions,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      durationSec: durationSec ?? this.durationSec,
      weightKg: weightKg ?? this.weightKg,
      restTimeSec: restTimeSec ?? this.restTimeSec,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'instructions': instructions,
      'sets': sets,
      'reps': reps,
      'durationSec': durationSec,
      'weightKg': weightKg,
      'restTimeSec': restTimeSec,
      'orderIndex': orderIndex,
    };
  }

  factory CustomExercise.fromJson(Map<String, dynamic> json) {
    return CustomExercise(
      id: json['id'] as String,
      name: json['name'] as String,
      instructions: json['instructions'] as String?,
      sets: json['sets'] as int,
      reps: json['reps'] as int?,
      durationSec: json['durationSec'] as int?,
      weightKg: (json['weightKg'] as num?)?.toDouble(),
      restTimeSec: json['restTimeSec'] as int? ?? 60,
      orderIndex: json['orderIndex'] as int,
    );
  }
}

/// Custom workout builder state
class CustomWorkoutBuilderState {
  final String title;
  final String? description;
  final int estimatedDurationMin;
  final String category;
  final List<CustomExercise> exercises;
  final bool isEditing;
  final String? editingWorkoutId;

  CustomWorkoutBuilderState({
    this.title = '',
    this.description,
    this.estimatedDurationMin = 30,
    this.category = 'Strength',
    this.exercises = const [],
    this.isEditing = false,
    this.editingWorkoutId,
  });

  CustomWorkoutBuilderState copyWith({
    String? title,
    String? description,
    int? estimatedDurationMin,
    String? category,
    List<CustomExercise>? exercises,
    bool? isEditing,
    String? editingWorkoutId,
  }) {
    return CustomWorkoutBuilderState(
      title: title ?? this.title,
      description: description ?? this.description,
      estimatedDurationMin: estimatedDurationMin ?? this.estimatedDurationMin,
      category: category ?? this.category,
      exercises: exercises ?? this.exercises,
      isEditing: isEditing ?? this.isEditing,
      editingWorkoutId: editingWorkoutId ?? this.editingWorkoutId,
    );
  }

  int get totalSets => exercises.fold(0, (sum, e) => sum + e.sets);

  int get estimatedTotalRestTime =>
      exercises.fold(0, (sum, e) => sum + (e.sets - 1) * e.restTimeSec);
}

/// Notifier for custom workout builder
class CustomWorkoutBuilderNotifier extends Notifier<CustomWorkoutBuilderState> {
  @override
  CustomWorkoutBuilderState build() {
    return CustomWorkoutBuilderState();
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setDescription(String? description) {
    state = state.copyWith(description: description);
  }

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  void setEstimatedDuration(int minutes) {
    state = state.copyWith(estimatedDurationMin: minutes);
  }

  void addExercise(CustomExercise exercise) {
    state = state.copyWith(exercises: [...state.exercises, exercise]);
  }

  void removeExercise(String exerciseId) {
    state = state.copyWith(
      exercises: state.exercises.where((e) => e.id != exerciseId).toList(),
    );
  }

  void updateExercise(CustomExercise exercise) {
    state = state.copyWith(
      exercises: state.exercises.map((e) {
        return e.id == exercise.id ? exercise : e;
      }).toList(),
    );
  }

  void reorderExercises(int oldIndex, int newIndex) {
    final exercises = List<CustomExercise>.from(state.exercises);
    final item = exercises.removeAt(oldIndex);
    exercises.insert(newIndex, item);
    state = state.copyWith(exercises: exercises);
  }

  void startEditing(String workoutId) {
    state = state.copyWith(isEditing: true, editingWorkoutId: workoutId);
  }

  void reset() {
    state = CustomWorkoutBuilderState();
  }
}

final customWorkoutBuilderProvider =
    NotifierProvider<CustomWorkoutBuilderNotifier, CustomWorkoutBuilderState>(
      CustomWorkoutBuilderNotifier.new,
    );

/// Set tracking for active workout
class SetTracker {
  final String exerciseId;
  final int currentSet;
  final bool isCompleted;

  SetTracker({
    required this.exerciseId,
    required this.currentSet,
    this.isCompleted = false,
  });
}

/// Notifier for set tracking
class SetTrackerNotifier extends Notifier<SetTracker?> {
  @override
  SetTracker? build() => null;

  void startTracking(String exerciseId, int currentSet) {
    state = SetTracker(
      exerciseId: exerciseId,
      currentSet: currentSet,
      isCompleted: false,
    );
  }

  void completeSet() {
    if (state != null) {
      state = SetTracker(
        exerciseId: state!.exerciseId,
        currentSet: state!.currentSet,
        isCompleted: true,
      );
    }
  }

  void clear() {
    state = null;
  }
}

final setTrackerProvider = NotifierProvider<SetTrackerNotifier, SetTracker?>(
  SetTrackerNotifier.new,
);
