import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class GlucoseHighRule extends InsightRule {
  @override
  String get id => 'glucose_high';

  @override
  String get category => 'glucose';

  @override
  int get priority => 90;

  @override
  String get title => 'High Blood Sugar';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final glucose = input.glucose?['mgdl'] ?? 0;
    return glucose > 140;
  }

  @override
  String message(InsightInput input) {
    final glucose = input.glucose?['mgdl'] ?? 0;
    return 'Blood sugar elevated (${glucose.round()} mg/dL). Avoid sugary foods.';
  }

  @override
  String? get icon => '🍬';
}

class GlucoseNormalRule extends InsightRule {
  @override
  String get id => 'glucose_normal';

  @override
  String get category => 'glucose';

  @override
  int get priority => 40;

  @override
  String get title => 'Healthy Blood Sugar';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final glucose = input.glucose?['mgdl'] ?? 0;
    return glucose >= 70 && glucose <= 100;
  }

  @override
  String message(InsightInput input) {
    return 'Blood sugar is in healthy range.';
  }

  @override
  String? get icon => '✅';
}

List<InsightRule> get glucoseRules => [GlucoseHighRule(), GlucoseNormalRule()];
