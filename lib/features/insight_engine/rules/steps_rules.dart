import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class StepsGoalRule extends InsightRule {
  @override
  String get id => 'steps_goal_met';

  @override
  String get category => 'steps';

  @override
  int get priority => 45;

  @override
  String get title => 'Step Goal Achieved!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    return steps >= 10000;
  }

  @override
  String message(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    return 'Amazing! You hit ${steps.round()} steps today!';
  }

  @override
  String? get icon => '👟';
}

class StepsLowRule extends InsightRule {
  @override
  String get id => 'steps_low';

  @override
  String get category => 'steps';

  @override
  int get priority => 70;

  @override
  String get title => 'Low Activity Day';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    return steps < 3000;
  }

  @override
  String message(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    return 'Only $steps steps today. Try a 15-minute walk.';
  }

  @override
  String? get icon => '🚶';
}

class StepsImprovementRule extends InsightRule {
  @override
  String get id => 'steps_improving';

  @override
  String get category => 'steps';

  @override
  int get priority => 50;

  @override
  String get title => 'Step Improvement';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final trend = input.steps?['trend'] ?? 0;
    return trend > 20;
  }

  @override
  String message(InsightInput input) {
    return 'Your steps increased 20%+ this week. Keep it up!';
  }

  @override
  String? get icon => '📈';
}

List<InsightRule> get stepsRules => [
  StepsGoalRule(),
  StepsLowRule(),
  StepsImprovementRule(),
];
