import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to mood and mental wellness
class GoodMoodRule extends InsightRule {
  @override
  String get id => 'mood_good';

  @override
  String get name => 'Good Mood';

  @override
  InsightCategory get category => InsightCategory.mood;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.sentiment_satisfied.codePoint;

  @override
  int get colorValue => 0xFF4CAF50; // Green

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['mood'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableMoodInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final mood = userData['moodScore'] as int?;

    if (mood == null) return null;

    if (mood >= 8) {
      return '😊 You\'re feeling great today! Keep that positive energy!';
    } else if (mood >= 6) {
      return '🙂 Good mood today! Hope it stays that way.';
    }
    return null;
  }
}

class LowMoodRule extends InsightRule {
  @override
  String get id => 'mood_low';

  @override
  String get name => 'Low Mood Support';

  @override
  InsightCategory get category => InsightCategory.mood;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.sentiment_dissatisfied.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['mood'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableMoodInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final mood = userData['moodScore'] as int?;

    if (mood == null) return null;

    if (mood <= 3) {
      return '💙 It seems like you\'re having a tough day. Remember to be kind to yourself.';
    } else if (mood <= 5) {
      return '💙 Things will get better. Take it one step at a time.';
    }
    return null;
  }
}

class BurnoutWarningRule extends InsightRule {
  @override
  String get id => 'burnout_warning';

  @override
  String get name => 'Burnout Warning';

  @override
  InsightCategory get category => InsightCategory.mood;

  @override
  InsightPriority get priority => InsightPriority.critical;

  @override
  int get iconCodePoint => Icons.psychology.codePoint;

  @override
  int get colorValue => 0xFFF44336; // Red

  @override
  int get cooldownDays => 3;

  @override
  List<String> get requiredDataTypes => ['mood', 'workout', 'sleep'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableMoodInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final mood = userData['moodScore'] as int?;
    final stress = userData['stressLevel'] as int?;
    final energy = userData['energyLevel'] as int?;
    final workoutMin = userData['workoutMinutes'] as int?;
    final sleepMin = userData['sleepDurationMin'] as int?;

    // Burnout indicators: low mood + high stress OR low energy + poor sleep + overtraining
    if (mood != null && stress != null) {
      if (mood <= 4 && stress >= 8) {
        return '⚠️ Signs of burnout detected: high stress and low mood. Consider taking a break.';
      }
    }

    if (energy != null && sleepMin != null && workoutMin != null) {
      if (energy <= 3 && sleepMin < 360 && workoutMin > 90) {
        return '😴 You may be overtraining with poor sleep. Rest is part of training!';
      }
    }

    return null;
  }
}

class HighEnergyRule extends InsightRule {
  @override
  String get id => 'high_energy';

  @override
  String get name => 'High Energy';

  @override
  InsightCategory get category => InsightCategory.mood;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.bolt.codePoint;

  @override
  int get colorValue => 0xFFFFEB3B; // Yellow

  @override
  int get cooldownDays => 3;

  @override
  List<String> get requiredDataTypes => ['mood'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableMoodInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final energy = userData['energyLevel'] as int?;

    if (energy == null) return null;

    if (energy >= 8) {
      return '⚡ You\'re feeling energetic! Great day to tackle challenges!';
    }
    return null;
  }
}

/// Get all mood rules
List<InsightRule> getMoodRules() {
  return [
    GoodMoodRule(),
    LowMoodRule(),
    BurnoutWarningRule(),
    HighEnergyRule(),
  ];
}
