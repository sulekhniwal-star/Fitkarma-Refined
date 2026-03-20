// lib/features/steps/data/step_repository.dart
// Repository for step data - combines health platform and local storage

import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/steps/data/health_service.dart';
import 'package:fitkarma/features/steps/data/step_drift_service.dart';

class StepRepository {
  final HealthService healthService;
  final StepDriftService driftService;

  StepRepository({required this.healthService, required this.driftService});

  /// Initialize and request permissions
  Future<bool> initialize() async {
    return await healthService.requestPermissions();
  }

  /// Sync today's steps from health platform to local storage
  Future<void> syncTodaySteps(String userId) async {
    final steps = await healthService.getTodaySteps();
    final distanceKm = healthService.calculateDistanceKm(steps);

    final id = '${userId}_${DateTime.now().toIso8601String().split('T')[0]}';

    await driftService.saveTodaySteps(
      id: id,
      userId: userId,
      steps: steps,
      distanceKm: distanceKm,
    );
  }

  /// Get today's steps (from local storage)
  Future<int> getTodaySteps(String userId) async {
    final todayLog = await driftService.getTodaySteps(userId);
    return todayLog?.steps ?? 0;
  }

  /// Get steps for a specific date
  Future<int> getStepsForDate(String userId, DateTime date) async {
    final logs = await driftService.getStepsInRange(
      userId,
      date,
      date.add(const Duration(days: 1)),
    );
    return logs.isEmpty ? 0 : logs.first.steps;
  }

  /// Get weekly step data
  Future<List<StepDayData>> getWeeklySteps(String userId) async {
    final logs = await driftService.getLast7DaysSteps(userId);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // Create a map for existing data
    final dataMap = <String, StepLog>{};
    for (final log in logs) {
      final dateKey = '${log.date.year}-${log.date.month}-${log.date.day}';
      dataMap[dateKey] = log;
    }

    // Build 7 days of data
    final result = <StepDayData>[];
    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final dateKey = '${date.year}-${date.month}-${date.day}';
      final log = dataMap[dateKey];

      result.add(
        StepDayData(
          date: date,
          steps: log?.steps ?? 0,
          goalMet: log != null && log.steps >= 10000, // Default goal
        ),
      );
    }

    return result;
  }

  /// Calculate 7-day rolling average for adaptive goal
  Future<int> calculateAdaptiveGoal(String userId) async {
    final average = await driftService.get7DayAverage(userId);
    // Round to nearest thousand, minimum 5000 steps
    final goal = (average / 1000).round() * 1000;
    return goal < 5000 ? 5000 : goal;
  }

  /// Get current platform being used
  HealthPlatform get currentPlatform => healthService.currentPlatform;

  /// Check if using pedometer fallback
  bool get isUsingFallback => healthService.shouldUsePedometerFallback;
}

/// Data class for daily step data
class StepDayData {
  final DateTime date;
  final int steps;
  final bool goalMet;

  StepDayData({required this.date, required this.steps, required this.goalMet});

  String get dayName {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }
}
