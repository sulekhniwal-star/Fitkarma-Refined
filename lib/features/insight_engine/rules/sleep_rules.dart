import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class SleepQualityRule extends InsightRule {
  @override
  String get id => 'sleep_quality_poor';

  @override
  String get category => 'sleep';

  @override
  int get priority => 85;

  @override
  String get title => 'Poor Sleep Quality';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final hours = input.sleep?['hours'] ?? 0;
    return hours < 6;
  }

  @override
  String message(InsightInput input) {
    final hours = input.sleep?['hours'] ?? 0;
    return 'Only ${hours.round()} hours of sleep. Aim for 7-8 hours for recovery.';
  }

  @override
  String? get icon => '😴';
}

class SleepDurationRule extends InsightRule {
  @override
  String get id => 'sleep_duration_good';

  @override
  String get category => 'sleep';

  @override
  int get priority => 40;

  @override
  String get title => 'Great Sleep!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final hours = input.sleep?['hours'] ?? 0;
    return hours >= 7 && hours <= 9;
  }

  @override
  String message(InsightInput input) {
    return 'Excellent sleep duration! Your body is well-rested.';
  }

  @override
  String? get icon => '🌙';
}

class SleepConsistencyRule extends InsightRule {
  @override
  String get id => 'sleep_inconsistent';

  @override
  String get category => 'sleep';

  @override
  int get priority => 60;

  @override
  String get title => 'Irregular Sleep';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final variance = input.sleep?['varianceMinutes'] ?? 0;
    return variance > 60;
  }

  @override
  String message(InsightInput input) {
    return 'Inconsistent sleep times detected. Try to sleep and wake at similar times.';
  }

  @override
  String? get icon => '⏰';
}

List<InsightRule> get sleepRules => [
  SleepQualityRule(),
  SleepDurationRule(),
  SleepConsistencyRule(),
];
