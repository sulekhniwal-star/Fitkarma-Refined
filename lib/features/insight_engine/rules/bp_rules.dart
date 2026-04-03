import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class BpHighRule extends InsightRule {
  @override
  String get id => 'bp_high';

  @override
  String get category => 'bp';

  @override
  int get priority => 90;

  @override
  String get title => 'High Blood Pressure';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final systolic = input.bp?['systolic'] ?? 0;
    return systolic > 140;
  }

  @override
  String message(InsightInput input) {
    final sys = input.bp?['systolic'] ?? 0;
    return 'BP elevated (${sys.round()}/?). Consider meditation and reduced salt.';
  }

  @override
  String? get icon => '❤️';
}

class BpNormalRule extends InsightRule {
  @override
  String get id => 'bp_normal';

  @override
  String get category => 'bp';

  @override
  int get priority => 40;

  @override
  String get title => 'Healthy BP';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final systolic = input.bp?['systolic'] ?? 0;
    final diastolic = input.bp?['diastolic'] ?? 0;
    return systolic >= 90 && systolic <= 120 && diastolic >= 60 && diastolic <= 80;
  }

  @override
  String message(InsightInput input) {
    return 'Blood pressure is in healthy range. Keep up the good work!';
  }

  @override
  String? get icon => '💚';
}

List<InsightRule> get bpRules => [BpHighRule(), BpNormalRule()];
