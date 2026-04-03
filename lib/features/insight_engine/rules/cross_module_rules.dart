import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class SleepNutritionCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_sleep_nutrition';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 65;

  @override
  String get title => 'Sleep & Nutrition Connection';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final sleepHours = input.sleep?['hours'] ?? 0;
    final calories = input.nutrition?['calories'] ?? 0;
    return sleepHours < 6 && calories > 2000;
  }

  @override
  String message(InsightInput input) {
    return 'Poor sleep + high calories. Better sleep may reduce cravings.';
  }

  @override
  String? get icon => '🌙';
}

class ExerciseMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_exercise_mood';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 60;

  @override
  String get title => 'Exercise Boost';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final workoutCount = input.workout?['count'] ?? 0;
    final mood = input.mood?['score'] ?? 0;
    return workoutCount >= 1 && mood >= 7;
  }

  @override
  String message(InsightInput input) {
    return 'Workout days = better mood! Keep moving.';
  }

  @override
  String? get icon => '🏃';
}

class HydrationBpCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_hydration_bp';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 70;

  @override
  String get title => 'Hydration & BP';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final water = input.water?['ml'] ?? 0;
    final bp = input.bp?['systolic'] ?? 0;
    return water < 1500 && bp > 130;
  }

  @override
  String message(InsightInput input) {
    return 'Low water + high BP. Try increasing hydration.';
  }

  @override
  String? get icon => '💧';
}

class StepsSleepCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_steps_sleep';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 55;

  @override
  String get title => 'Active Days, Better Sleep';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    final sleep = input.sleep?['hours'] ?? 0;
    return steps > 8000 && sleep < 6;
  }

  @override
  String message(InsightInput input) {
    return 'High steps but poor sleep. Rest is as important as activity.';
  }

  @override
  String? get icon => '👟';
}

List<InsightRule> get crossModuleRules => [
  SleepNutritionCorrelationRule(),
  ExerciseMoodCorrelationRule(),
  HydrationBpCorrelationRule(),
  StepsSleepCorrelationRule(),
];
