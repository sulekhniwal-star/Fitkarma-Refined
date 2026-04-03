import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class WorkoutCompletedRule extends InsightRule {
  @override
  String get id => 'workout_completed';

  @override
  String get category => 'workout';

  @override
  int get priority => 45;

  @override
  String get title => 'Workout Done!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final workouts = input.workout?['count'] ?? 0;
    return workouts >= 1;
  }

  @override
  String message(InsightInput input) {
    final count = input.workout?['count'] ?? 0;
    return 'Great job! You completed $count workout(s) today.';
  }

  @override
  String? get icon => '💪';
}

class WorkoutStreakRule extends InsightRule {
  @override
  String get id => 'workout_streak';

  @override
  String get category => 'workout';

  @override
  int get priority => 60;

  @override
  String get title => 'Workout Streak!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final streak = input.streakDays ?? 0;
    return streak >= 7;
  }

  @override
  String message(InsightInput input) {
    final streak = input.streakDays ?? 0;
    return '$streak day workout streak! 🔥 Keep the momentum!';
  }

  @override
  String? get icon => '🔥';
}

class WorkoutRpeRule extends InsightRule {
  @override
  String get id => 'workout_rpe_high';

  @override
  String get category => 'workout';

  @override
  int get priority => 55;

  @override
  String get title => 'High Intensity Workout';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final rpe = input.workout?['rpe'] ?? 0;
    return rpe >= 8;
  }

  @override
  String message(InsightInput input) {
    return 'High intensity workout! Make sure to rest adequately.';
  }

  @override
  String? get icon => '⚡';
}

List<InsightRule> get workoutRules => [
  WorkoutCompletedRule(),
  WorkoutStreakRule(),
  WorkoutRpeRule(),
];
