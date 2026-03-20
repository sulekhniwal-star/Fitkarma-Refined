import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to workout and exercise
class WorkoutCompletedRule extends InsightRule {
  @override
  String get id => 'workout_completed';

  @override
  String get name => 'Workout Completed';

  @override
  InsightCategory get category => InsightCategory.workout;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.fitness_center.codePoint;

  @override
  int get colorValue => 0xFFFF5722; // Deep Orange

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['workout'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableWorkoutInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final workoutMin = userData['workoutMinutes'] as int?;
    final workoutCount = userData['workoutCount'] as int?;

    if (workoutMin == null || workoutMin == 0) return null;

    if (workoutMin >= 45) {
      return '💪 Amazing workout! ${workoutMin} minutes - that\'s a solid session!';
    } else if (workoutMin >= 30) {
      return '🔥 Great workout today! ${workoutMin} minutes in the books.';
    } else if (workoutMin >= 15) {
      return '👍 Good start! ${workoutMin} minutes. Every bit counts!';
    }
    return null;
  }
}

class WorkoutStreakRule extends InsightRule {
  @override
  String get id => 'workout_streak';

  @override
  String get name => 'Workout Streak';

  @override
  InsightCategory get category => InsightCategory.streak;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.local_fire_department.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['workout', 'streak'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableWorkoutInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final streak = userData['workoutStreak'] as int?;

    if (streak == null || streak == 0) return null;

    if (streak >= 30) {
      return '🏆 Incredible! ${streak}-day workout streak! You\'re unstoppable!';
    } else if (streak >= 14) {
      return '🔥 Amazing! ${streak} days strong! Keep the momentum going!';
    } else if (streak >= 7) {
      return '💪 ${streak}-day streak! You\'re building a great habit!';
    } else if (streak >= 3) {
      return '👍 ${streak}-day workout streak! Keep it up!';
    }
    return null;
  }
}

class NoWorkoutRule extends InsightRule {
  @override
  String get id => 'no_workout_today';

  @override
  String get name => 'No Workout Today';

  @override
  InsightCategory get category => InsightCategory.workout;

  @override
  InsightPriority get priority => InsightPriority.low;

  @override
  int get iconCodePoint => Icons.directions_run.codePoint;

  @override
  int get colorValue => 0xFF9E9E9E; // Grey

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['workout'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableWorkoutInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final workoutMin = userData['workoutMinutes'] as int?;

    // Only show this if no workout today
    if (workoutMin != null && workoutMin > 0) return null;

    final streak = userData['workoutStreak'] as int?;

    if (streak != null && streak > 0) {
      return '😴 Rest day? You have a ${streak}-day streak to protect!';
    } else {
      return '🏃 Consider adding a quick workout today. Even 15 minutes helps!';
    }
  }
}

class StepsGoalRule extends InsightRule {
  @override
  String get id => 'steps_goal';

  @override
  String get name => 'Steps Goal';

  @override
  InsightCategory get category => InsightCategory.workout;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.directions_walk.codePoint;

  @override
  int get colorValue => 0xFF2196F3; // Blue

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['steps'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableWorkoutInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final steps = userData['steps'] as int?;
    final goal = userData['dailyStepGoal'] as int?;

    if (steps == null || goal == null || goal <= 0) return null;

    final percentage = (steps / goal * 100).round();

    if (percentage >= 100) {
      return '🎯 Steps goal crushed! ${steps.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} steps - amazing!';
    } else if (percentage >= 75) {
      return '🚶 ${percentage}% of your ${goal.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} step goal. Almost there!';
    }
    return null;
  }
}

/// Get all workout rules
List<InsightRule> getWorkoutRules() {
  return [
    WorkoutCompletedRule(),
    WorkoutStreakRule(),
    NoWorkoutRule(),
    StepsGoalRule(),
  ];
}
