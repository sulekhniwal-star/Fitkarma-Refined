import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/karma/data/karma_notifier.dart';

final workoutServiceProvider = Provider<WorkoutService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return WorkoutService(db);
});

class WorkoutService {
  final AppDatabase _db;
  final List<LatLng> _routePoints = [];
  StreamSubscription<Position>? _positionSubscription;
  bool _isTracking = false;

  WorkoutService(this._db);

  bool get isTracking => _isTracking;
  List<LatLng> get routePoints => List.unmodifiable(_routePoints);

  Future<bool> checkLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) return null;
    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  void startGpsTracking({
    required Function(LatLng point) onPointAdded,
    required Function() onError,
  }) {
    if (_isTracking) return;
    _routePoints.clear();
    _isTracking = true;

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen(
      (position) {
        final point = LatLng(position.latitude, position.longitude);
        _routePoints.add(point);
        onPointAdded(point);
      },
      onError: (e) => onError(),
    );
  }

  void stopGpsTracking() {
    _isTracking = false;
    _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  double calculateDistanceKm() {
    if (_routePoints.length < 2) return 0;
    double totalMeters = 0;
    for (int i = 1; i < _routePoints.length; i++) {
      totalMeters += Geolocator.distanceBetween(
        _routePoints[i - 1].latitude,
        _routePoints[i - 1].longitude,
        _routePoints[i].latitude,
        _routePoints[i].longitude,
      );
    }
    return totalMeters / 1000;
  }

  Future<int> logWorkout({
    required String odUserId,
    required String title,
    required int durationMin,
    required double caloriesBurned,
    required String workoutType,
    int? rpe,
    double? distanceKm,
    String? routeJson,
  }) async {
    final log = WorkoutLogsCompanion.insert(
      userId: odUserId,
      title: title,
      durationMin: durationMin,
      caloriesBurned: caloriesBurned,
      workoutType: workoutType,
      rpe: Value(rpe),
      distanceKm: Value(distanceKm),
      routeJson: Value(routeJson),
      loggedAt: DateTime.now(),
    );

    final id = await _db.into(_db.workoutLogs).insert(log);

    await _checkPersonalRecords(odUserId, title, distanceKm);

    return id;
  }

  Future<void> _checkPersonalRecords(String odUserId, String title, double? distanceKm) async {
    if (distanceKm != null && distanceKm > 0) {
      final isRunning = title.toLowerCase().contains('run') ||
          title.toLowerCase().contains('outdoor');
      
      if (isRunning && distanceKm >= 5) {
        final record = PersonalRecordsCompanion.insert(
          userId: odUserId,
          recordType: 'fastest_5k',
          achievedAt: DateTime.now(),
        );
        await _db.into(_db.personalRecords).insert(record);
      }
    }
  }

  Future<List<WorkoutLog>> getWorkoutHistory(String odUserId, {int limit = 20}) {
    return (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
      ..limit(limit))
        .get();
  }

  Stream<List<WorkoutLog>> watchWorkoutHistory(String odUserId) {
    return (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }

  Future<List<WorkoutLog>> getWorkoutsForDate(String odUserId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (_db.select(_db.workoutLogs)
      ..where((t) =>
          t.userId.equals(odUserId) &
          t.loggedAt.isBiggerOrEqualValue(dayStart) &
          t.loggedAt.isSmallerThanValue(dayEnd)))
        .get();
  }

  Future<int> getTotalWorkoutsThisWeek(String odUserId) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);
    
    final result = await (_db.selectOnly(_db.workoutLogs)
      ..addColumns([_db.workoutLogs.id.count()])
      ..where(_db.workoutLogs.userId.equals(odUserId) &
          _db.workoutLogs.loggedAt.isBiggerOrEqualValue(startOfWeek)))
        .getSingle();
    
    return result.read(_db.workoutLogs.id.count()) ?? 0;
  }

  void dispose() {
    stopGpsTracking();
  }
}

final restTimerProvider = StateNotifierProvider<RestTimerNotifier, RestTimerState>((ref) {
  return RestTimerNotifier();
});

class RestTimerNotifier extends StateNotifier<RestTimerState> {
  Timer? _timer;

  RestTimerNotifier() : super(RestTimerState.initial());

  void startRestTimer({int durationSeconds = 60}) {
    _timer?.cancel();
    state = RestTimerState(
      isRunning: true,
      remainingSeconds: durationSeconds,
      totalSeconds: durationSeconds,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingSeconds <= 1) {
        timer.cancel();
        state = state.copyWith(
          isRunning: false,
          remainingSeconds: 0,
          isCompleted: true,
        );
      } else {
        state = state.copyWith(
          remainingSeconds: state.remainingSeconds - 1,
        );
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    state = RestTimerState.initial();
  }

  void resetForNextSet() {
    state = state.copyWith(isCompleted: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class RestTimerState {
  final bool isRunning;
  final int remainingSeconds;
  final int totalSeconds;
  final bool isCompleted;

  RestTimerState({
    required this.isRunning,
    required this.remainingSeconds,
    required this.totalSeconds,
    required this.isCompleted,
  });

  factory RestTimerState.initial() {
    return RestTimerState(
      isRunning: false,
      remainingSeconds: 0,
      totalSeconds: 60,
      isCompleted: false,
    );
  }

  RestTimerState copyWith({
    bool? isRunning,
    int? remainingSeconds,
    int? totalSeconds,
    bool? isCompleted,
  }) {
    return RestTimerState(
      isRunning: isRunning ?? this.isRunning,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  double get progress => totalSeconds > 0 ? remainingSeconds / totalSeconds : 0;
}

class CustomExercise {
  final String name;
  final int sets;
  final int reps;
  final int restSeconds;
  final double? weightKg;

  CustomExercise({
    required this.name,
    required this.sets,
    required this.reps,
    this.restSeconds = 60,
    this.weightKg,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'sets': sets,
    'reps': reps,
    'restSeconds': restSeconds,
    'weightKg': weightKg,
  };

  factory CustomExercise.fromJson(Map<String, dynamic> json) {
    return CustomExercise(
      name: json['name'] as String,
      sets: json['sets'] as int,
      reps: json['reps'] as int,
      restSeconds: json['restSeconds'] as int? ?? 60,
      weightKg: json['weightKg'] as double?,
    );
  }
}

final customWorkoutProvider = StateNotifierProvider<CustomWorkoutNotifier, CustomWorkoutState>((ref) {
  return CustomWorkoutNotifier();
});

class CustomWorkoutNotifier extends StateNotifier<CustomWorkoutState> {
  CustomWorkoutNotifier() : super(CustomWorkoutState.initial());

  void addExercise(CustomExercise exercise) {
    state = state.copyWith(
      exercises: [...state.exercises, exercise],
    );
  }

  void removeExercise(int index) {
    final exercises = List<CustomExercise>.from(state.exercises);
    exercises.removeAt(index);
    state = state.copyWith(exercises: exercises);
  }

  void updateExercise(int index, CustomExercise exercise) {
    final exercises = List<CustomExercise>.from(state.exercises);
    exercises[index] = exercise;
    state = state.copyWith(exercises: exercises);
  }

  void setWorkoutName(String name) {
    state = state.copyWith(name: name);
  }

  void setCategory(String category) {
    state = state.copyWith(category: category);
  }

  void reset() {
    state = CustomWorkoutState.initial();
  }
}

class CustomWorkoutState {
  final String name;
  final String category;
  final List<CustomExercise> exercises;

  CustomWorkoutState({
    required this.name,
    required this.category,
    required this.exercises,
  });

  factory CustomWorkoutState.initial() {
    return CustomWorkoutState(
      name: '',
      category: 'Strength',
      exercises: [],
    );
  }

  CustomWorkoutState copyWith({
    String? name,
    String? category,
    List<CustomExercise>? exercises,
  }) {
    return CustomWorkoutState(
      name: name ?? this.name,
      category: category ?? this.category,
      exercises: exercises ?? this.exercises,
    );
  }

  int get estimatedDurationMin {
    int total = 0;
    for (final ex in exercises) {
      total += ex.sets * 2;
      total += ex.restSeconds * (ex.sets - 1) ~/ 60;
    }
    return total.clamp(1, 180);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'category': category,
    'exercises': exercises.map((e) => e.toJson()).toList(),
  };
}