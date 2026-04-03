import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

class MoodPositiveRule extends InsightRule {
  @override
  String get id => 'mood_positive';

  @override
  String get category => 'mood';

  @override
  int get priority => 40;

  @override
  String get title => 'Great Mood!';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final mood = input.mood?['score'] ?? 0;
    return mood >= 7;
  }

  @override
  String message(InsightInput input) {
    return 'You reported a great mood today! Keep it up!';
  }

  @override
  String? get icon => '😊';
}

class MoodLowRule extends InsightRule {
  @override
  String get id => 'mood_low';

  @override
  String get category => 'mood';

  @override
  int get priority => 75;

  @override
  String get title => 'Feeling Low?';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final mood = input.mood?['score'] ?? 0;
    return mood <= 4;
  }

  @override
  String message(InsightInput input) {
    return 'Mood low today. Try a walk, meditation, or talking to someone.';
  }

  @override
  String? get icon => '😔';
}

class BurnoutRiskRule extends InsightRule {
  @override
  String get id => 'burnout_risk';

  @override
  String get category => 'mood';

  @override
  int get priority => 80;

  @override
  String get title => 'Burnout Warning';

  @override
  bool get isCrossModule => false;

  @override
  bool condition(InsightInput input) {
    final consecutiveDays = input.mood?['consecutiveLowMoodDays'] ?? 0;
    return consecutiveDays >= 5;
  }

  @override
  String message(InsightInput input) {
    return '5+ days of low mood. Consider a rest day and self-care.';
  }

  @override
  String? get icon => '🛋️';
}

List<InsightRule> get moodRules => [MoodPositiveRule(), MoodLowRule(), BurnoutRiskRule()];
