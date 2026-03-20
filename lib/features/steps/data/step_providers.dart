// lib/features/steps/data/step_providers.dart
// Providers and state management for steps feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/dashboard/data/dashboard_providers.dart';
import 'package:fitkarma/features/steps/data/health_service.dart';
import 'package:fitkarma/features/steps/data/step_drift_service.dart';
import 'package:fitkarma/features/steps/data/step_repository.dart';

// --- Providers ---

/// Provider for health service singleton
final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});

/// Provider for step drift service
final stepDriftServiceProvider = Provider<StepDriftService>((ref) {
  final db = ref.watch(databaseProvider);
  return StepDriftService(db);
});

/// Provider for step repository
final stepRepositoryProvider = Provider<StepRepository>((ref) {
  return StepRepository(
    healthService: ref.watch(healthServiceProvider),
    driftService: ref.watch(stepDriftServiceProvider),
  );
});

// --- State Providers ---

/// State for step data
class StepsState {
  final int todaySteps;
  final int dailyGoal;
  final int weeklyTotal;
  final double xpEarnedToday;
  final bool isLoading;
  final String? error;
  final HealthPlatform platform;
  final List<StepDayData> weeklyData;

  StepsState({
    this.todaySteps = 0,
    this.dailyGoal = 10000,
    this.weeklyTotal = 0,
    this.xpEarnedToday = 0,
    this.isLoading = false,
    this.error,
    this.platform = HealthPlatform.none,
    this.weeklyData = const [],
  });

  StepsState copyWith({
    int? todaySteps,
    int? dailyGoal,
    int? weeklyTotal,
    double? xpEarnedToday,
    bool? isLoading,
    String? error,
    HealthPlatform? platform,
    List<StepDayData>? weeklyData,
  }) {
    return StepsState(
      todaySteps: todaySteps ?? this.todaySteps,
      dailyGoal: dailyGoal ?? this.dailyGoal,
      weeklyTotal: weeklyTotal ?? this.weeklyTotal,
      xpEarnedToday: xpEarnedToday ?? this.xpEarnedToday,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      platform: platform ?? this.platform,
      weeklyData: weeklyData ?? this.weeklyData,
    );
  }

  double get progressPercent =>
      dailyGoal > 0 ? (todaySteps / dailyGoal).clamp(0.0, 1.0) : 0.0;

  bool get goalMet => todaySteps >= dailyGoal;
}

/// Provider for daily goal
final dailyGoalProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(stepRepositoryProvider);
  return await repository.calculateAdaptiveGoal('current_user');
});

/// Provider for today's steps
final todayStepsProvider = FutureProvider<int>((ref) async {
  final repository = ref.watch(stepRepositoryProvider);
  return await repository.getTodaySteps('current_user');
});

/// Provider for weekly data
final weeklyStepsProvider = FutureProvider<List<StepDayData>>((ref) async {
  final repository = ref.watch(stepRepositoryProvider);
  return await repository.getWeeklySteps('current_user');
});

/// Provider for checking if using pedometer fallback
final isUsingPedometerProvider = Provider<bool>((ref) {
  final repository = ref.watch(stepRepositoryProvider);
  return repository.isUsingFallback;
});

/// Provider for current platform
final currentPlatformProvider = Provider<HealthPlatform>((ref) {
  final repository = ref.watch(stepRepositoryProvider);
  return repository.currentPlatform;
});

/// Provider for calculating XP earned today
final xpEarnedTodayProvider = Provider<double>((ref) {
  final stepsAsync = ref.watch(todayStepsProvider);
  return stepsAsync.maybeWhen(
    data: (steps) {
      final xp = (steps ~/ 1000) * 5;
      return xp > 50 ? 50.0 : xp.toDouble();
    },
    orElse: () => 0.0,
  );
});
