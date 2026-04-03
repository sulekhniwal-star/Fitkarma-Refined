import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class HydrationLowRule extends InsightRule {
  @override
  String get id => 'hydration_low';

  @override
  String get category => 'hydration';

  @override
  int get priority => 75;

  @override
  String get title => 'Low Water Intake';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final water = input.water?['ml'] ?? 0;
    return water < 1500;
  }

  @override
  String message(InsightInput input) {
    final water = input.water?['ml'] ?? 0;
    return 'Only ${water.round()}ml water today. Aim for 2-3L.';
  }

  @override
  String? get icon => '💧';
}

class HydrationGoodRule extends InsightRule {
  @override
  String get id => 'hydration_good';

  @override
  String get category => 'hydration';

  @override
  int get priority => 40;

  @override
  String get title => 'Well Hydrated!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final water = input.water?['ml'] ?? 0;
    return water >= 2000;
  }

  @override
  String message(InsightInput input) {
    return 'Great hydration today! Your body thanks you.';
  }

  @override
  String? get icon => '💦';
}

List<InsightRule> get hydrationRules => [
  HydrationLowRule(),
  HydrationGoodRule(),
];
