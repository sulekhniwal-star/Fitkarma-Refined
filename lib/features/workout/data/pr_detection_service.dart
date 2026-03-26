// lib/features/workout/data/pr_detection_service.dart
// Personal Record (PR) detection service for workout data

import 'package:flutter/foundation.dart';
import 'package:fitkarma/features/workout/data/workout_aw_service.dart';
import 'package:fitkarma/features/karma/data/karma_drift_service.dart';

/// Types of personal records
enum PRType {
  maxLift, // Maximum weight lifted for an exercise
  fastest5k, // Fastest 5K time
  longestRun, // Longest run distance
}

/// Model for a detected PR
class DetectedPR {
  final PRType type;
  final String exerciseName;
  final double value;
  final String unit;
  final double? previousBest;
  final double improvement;

  DetectedPR({
    required this.type,
    required this.exerciseName,
    required this.value,
    required this.unit,
    this.previousBest,
    required this.improvement,
  });

  String get typeLabel {
    switch (type) {
      case PRType.maxLift:
        return 'Max Lift';
      case PRType.fastest5k:
        return '5K Time';
      case PRType.longestRun:
        return 'Longest Run';
    }
  }

  String get formattedValue {
    switch (type) {
      case PRType.maxLift:
      case PRType.longestRun:
        return '${value.toStringAsFixed(1)} $unit';
      case PRType.fastest5k:
        // Format as mm:ss
        final minutes = value ~/ 60;
        final seconds = (value % 60).round();
        return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String get celebrationMessage {
    switch (type) {
      case PRType.maxLift:
        return '🎉 New PR! $exerciseName: $formattedValue';
      case PRType.fastest5k:
        return '🏃 New 5K PR! $formattedValue';
      case PRType.longestRun:
        return '🏃 New distance PR! $formattedValue';
    }
  }
}

/// Service to detect personal records from workout data
class PRDetectionService {
  final WorkoutAwService _workoutService = WorkoutAwService();
  final KarmaDriftService _karmaDriftService = KarmaDriftService();

  // XP reward for new PR
  static const int prXpReward = 100;

  /// Check workout log for potential PRs
  /// Returns list of detected PRs
  Future<List<DetectedPR>> checkForPRs({
    required String userId,
    required String workoutType,
    required int durationMinutes,
    double? totalDistanceMeters,
    double? averageSpeed,
    List<ExerciseLog>? exercises,
    String? gpsData,
  }) async {
    final List<DetectedPR> detectedPRs = [];

    // Check for running/cycling PRs from GPS data
    if (workoutType.toLowerCase().contains('run') ||
        workoutType.toLowerCase().contains('outdoor')) {
      if (totalDistanceMeters != null && totalDistanceMeters > 0) {
        // Check for longest run PR
        final longestRunPR = await _checkLongestRunPR(
          userId,
          totalDistanceMeters,
        );
        if (longestRunPR != null) {
          detectedPRs.add(longestRunPR);
        }

        // Check for 5K PR (if distance >= 5km)
        if (totalDistanceMeters >= 5000 && averageSpeed != null) {
          final fiveKPR = await _checkFastest5KPR(
            userId,
            totalDistanceMeters,
            averageSpeed,
          );
          if (fiveKPR != null) {
            detectedPRs.add(fiveKPR);
          }
        }
      }
    }

    // Check for strength exercise PRs
    if (exercises != null && exercises.isNotEmpty) {
      for (final exercise in exercises) {
        if (exercise.weightKg != null && exercise.reps != null) {
          final maxLiftPR = await _checkMaxLiftPR(
            userId,
            exercise.name,
            exercise.weightKg!,
            exercise.reps!,
          );
          if (maxLiftPR != null) {
            detectedPRs.add(maxLiftPR);
          }
        }
      }
    }

    return detectedPRs;
  }

  /// Check for max lift PR (estimated 1RM using Epley formula)
  /// 1RM = weight * (1 + reps/30)
  Future<DetectedPR?> _checkMaxLiftPR(
    String userId,
    String exerciseName,
    double weightKg,
    int reps,
  ) async {
    // Calculate estimated 1RM using Epley formula
    final estimated1RM = weightKg * (1 + reps / 30);

    // Get current best for this exercise
    final bestRecord = await _workoutService.getBestRecord(
      userId,
      'max_lift_$exerciseName',
    );

    if (bestRecord == null) {
      // First record for this exercise
      return DetectedPR(
        type: PRType.maxLift,
        exerciseName: exerciseName,
        value: estimated1RM,
        unit: 'kg',
        previousBest: null,
        improvement: 0,
      );
    }

    final previousBest = (bestRecord['value'] as num?)?.toDouble() ?? 0;

    if (estimated1RM > previousBest) {
      return DetectedPR(
        type: PRType.maxLift,
        exerciseName: exerciseName,
        value: estimated1RM,
        unit: 'kg',
        previousBest: previousBest,
        improvement: estimated1RM - previousBest,
      );
    }

    return null;
  }

  /// Check for fastest 5K PR
  /// Calculates 5K time from the total distance and speed
  Future<DetectedPR?> _checkFastest5KPR(
    String userId,
    double totalDistanceMeters,
    double averageSpeedMps,
  ) async {
    if (averageSpeedMps <= 0) return null;

    // Calculate time to complete 5K in seconds
    // If the run was longer than 5K, we use the pace from the full run
    final timeFor5K = 5000 / averageSpeedMps;

    // Get current best 5K time
    final bestRecord = await _workoutService.getBestRecord(
      userId,
      'fastest_5k',
    );

    if (bestRecord == null) {
      return DetectedPR(
        type: PRType.fastest5k,
        exerciseName: '5K Run',
        value: timeFor5K,
        unit: 'sec',
        previousBest: null,
        improvement: 0,
      );
    }

    final previousBest =
        (bestRecord['value'] as num?)?.toDouble() ?? double.infinity;

    // Lower is better for time
    if (timeFor5K < previousBest) {
      return DetectedPR(
        type: PRType.fastest5k,
        exerciseName: '5K Run',
        value: timeFor5K,
        unit: 'sec',
        previousBest: previousBest,
        improvement: previousBest - timeFor5K,
      );
    }

    return null;
  }

  /// Check for longest run PR
  Future<DetectedPR?> _checkLongestRunPR(
    String userId,
    double distanceMeters,
  ) async {
    // Get current best distance
    final bestRecord = await _workoutService.getBestRecord(
      userId,
      'longest_run',
    );

    if (bestRecord == null) {
      return DetectedPR(
        type: PRType.longestRun,
        exerciseName: 'Run',
        value: distanceMeters / 1000, // Convert to km
        unit: 'km',
        previousBest: null,
        improvement: 0,
      );
    }

    final previousBest = (bestRecord['value'] as num?)?.toDouble() ?? 0;
    final distanceKm = distanceMeters / 1000;

    if (distanceKm > previousBest) {
      return DetectedPR(
        type: PRType.longestRun,
        exerciseName: 'Run',
        value: distanceKm,
        unit: 'km',
        previousBest: previousBest,
        improvement: distanceKm - previousBest,
      );
    }

    return null;
  }

  /// Record a PR to the database and award XP
  Future<String?> recordPRAndAwardXP({
    required String userId,
    required DetectedPR pr,
  }) async {
    try {
      // Generate unique ID for the PR record
      final prId = 'pr_${DateTime.now().millisecondsSinceEpoch}';

      // Determine record type string
      String recordType;
      switch (pr.type) {
        case PRType.maxLift:
          recordType = 'max_lift_${pr.exerciseName}';
          break;
        case PRType.fastest5k:
          recordType = 'fastest_5k';
          break;
        case PRType.longestRun:
          recordType = 'longest_run';
          break;
      }

      // Record the PR
      await _workoutService.recordPersonalRecord(
        id: prId,
        userId: userId,
        recordType: recordType,
        exerciseName: pr.exerciseName,
        value: pr.value,
        unit: pr.unit,
      );

      // Award XP for the PR
      _awardXP(userId, prXpReward);

      debugPrint(
        'Recorded PR: ${pr.celebrationMessage} and awarded $prXpReward XP',
      );

      return prId;
    } catch (e) {
      debugPrint('Failed to record PR: $e');
      return null;
    }
  }

  /// Award XP to user
  void _awardXP(String userId, int xpAmount) {
    try {
      // Use karma drift service to add XP locally
      _karmaDriftService.addXp(
        userId: userId,
        baseXp: xpAmount,
        action: 'personal_record',
        description: 'New Personal Record!',
      );
    } catch (e) {
      debugPrint('Failed to award XP: $e');
    }
  }

  /// Get all PRs for a user
  Future<List<Map<String, dynamic>>> getAllPRs(String userId) async {
    return _workoutService.getPersonalRecords(userId);
  }

  /// Get PR history for a specific exercise
  Future<List<Map<String, dynamic>>> getPRHistoryForExercise(
    String userId,
    String exerciseName,
  ) async {
    final allPRs = await _workoutService.getPersonalRecords(userId);
    return allPRs.where((pr) => pr['exerciseName'] == exerciseName).toList();
  }
}

/// Model for exercise log during workout
class ExerciseLog {
  final String name;
  final int sets;
  final int? reps;
  final double? weightKg;
  final int? durationSec;

  ExerciseLog({
    required this.name,
    required this.sets,
    this.reps,
    this.weightKg,
    this.durationSec,
  });
}
