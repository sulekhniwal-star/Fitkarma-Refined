// lib/features/workout/data/pr_providers.dart
// Riverpod providers for Personal Records

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/workout/data/pr_detection_service.dart';
import 'package:fitkarma/features/workout/presentation/pr_history_chart.dart';

/// Provider for PR detection service
final prDetectionServiceProvider = Provider<PRDetectionService>((ref) {
  return PRDetectionService();
});

/// Provider for user's all personal records
final personalRecordsProvider = FutureProvider.family<List<Map<String, dynamic>>, String>((ref, userId) async {
  final prService = ref.watch(prDetectionServiceProvider);
  return prService.getAllPRs(userId);
});

/// Provider for PR history for a specific exercise
final prHistoryProvider = FutureProvider.family<List<PRHistoryData>, ({String userId, String exerciseName})>((ref, params) async {
  final prService = ref.watch(prDetectionServiceProvider);
  final prMaps = await prService.getPRHistoryForExercise(params.userId, params.exerciseName);
  return prMaps.map((m) => PRHistoryData.fromMap(m)).toList();
});

/// Notifier for managing workout completion with PR detection
class WorkoutCompletionNotifier extends Notifier<WorkoutCompletionState> {
  @override
  WorkoutCompletionState build() {
    return const WorkoutCompletionState();
  }

  /// Check for PRs after a workout and optionally show celebration
  Future<List<DetectedPR>> checkForPRs({
    required String userId,
    required String workoutType,
    required int durationMinutes,
    double? totalDistanceMeters,
    double? averageSpeed,
    List<ExerciseLog>? exercises,
    String? gpsData,
    bool recordPRs = true,
  }) async {
    state = state.copyWith(isCheckingPRs: true);
    
    try {
      final prService = ref.read(prDetectionServiceProvider);
      
      // Check for PRs
      final detectedPRs = await prService.checkForPRs(
        userId: userId,
        workoutType: workoutType,
        durationMinutes: durationMinutes,
        totalDistanceMeters: totalDistanceMeters,
        averageSpeed: averageSpeed,
        exercises: exercises,
        gpsData: gpsData,
      );

      // Record PRs and award XP
      if (recordPRs && detectedPRs.isNotEmpty) {
        for (final pr in detectedPRs) {
          await prService.recordPRAndAwardXP(
            userId: userId,
            pr: pr,
          );
        }
      }

      state = state.copyWith(
        isCheckingPRs: false,
        lastDetectedPRs: detectedPRs,
      );

      return detectedPRs;
    } catch (e) {
      state = state.copyWith(
        isCheckingPRs: false,
        error: e.toString(),
      );
      return [];
    }
  }

  /// Clear the last detected PRs
  void clearLastPRs() {
    state = state.copyWith(lastDetectedPRs: []);
  }
}

/// State for workout completion with PR detection
class WorkoutCompletionState {
  final bool isCheckingPRs;
  final List<DetectedPR> lastDetectedPRs;
  final String? error;

  const WorkoutCompletionState({
    this.isCheckingPRs = false,
    this.lastDetectedPRs = const [],
    this.error,
  });

  WorkoutCompletionState copyWith({
    bool? isCheckingPRs,
    List<DetectedPR>? lastDetectedPRs,
    String? error,
  }) {
    return WorkoutCompletionState(
      isCheckingPRs: isCheckingPRs ?? this.isCheckingPRs,
      lastDetectedPRs: lastDetectedPRs ?? this.lastDetectedPRs,
      error: error,
    );
  }
}

/// Provider for workout completion with PR detection
final workoutCompletionProvider = NotifierProvider<WorkoutCompletionNotifier, WorkoutCompletionState>(
  WorkoutCompletionNotifier.new,
);

/// Helper function to check PRs after GPS workout
Future<List<DetectedPR>> checkGPSWorkoutPRs({
  required String userId,
  required String workoutType,
  required int durationMinutes,
  required double totalDistanceMeters,
  required double averageSpeedMps,
}) async {
  final prService = PRDetectionService();
  
  final detectedPRs = await prService.checkForPRs(
    userId: userId,
    workoutType: workoutType,
    durationMinutes: durationMinutes,
    totalDistanceMeters: totalDistanceMeters,
    averageSpeed: averageSpeedMps,
  );

  // Record and award XP
  for (final pr in detectedPRs) {
    await prService.recordPRAndAwardXP(userId: userId, pr: pr);
  }

  return detectedPRs;
}

/// Helper function to check PRs after strength workout
Future<List<DetectedPR>> checkStrengthWorkoutPRs({
  required String userId,
  required List<ExerciseLog> exercises,
}) async {
  final prService = PRDetectionService();
  
  final detectedPRs = await prService.checkForPRs(
    userId: userId,
    workoutType: 'Strength',
    durationMinutes: 0,
    exercises: exercises,
  );

  // Record and award XP
  for (final pr in detectedPRs) {
    await prService.recordPRAndAwardXP(userId: userId, pr: pr);
  }

  return detectedPRs;
}
