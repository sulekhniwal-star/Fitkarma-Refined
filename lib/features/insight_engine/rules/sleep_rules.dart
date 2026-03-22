import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to sleep tracking and quality
class SleepGoalRule extends InsightRule {
  @override
  String get id => 'sleep_goal_achieved';

  @override
  String get name => 'Sleep Goal';

  @override
  InsightCategory get category => InsightCategory.sleep;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.bedtime.codePoint;

  @override
  int get colorValue => 0xFF3F51B5; // Indigo

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['sleep'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableSleepInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final sleepMin = userData['sleepDurationMin'] as int?;
    final goal = userData['dailySleepGoal'] as int?;

    if (sleepMin == null || goal == null || goal <= 0) return null;

    final hours = sleepMin / 60;
    final goalHours = goal / 60;

    if (hours >= goalHours) {
      return '😴 Great sleep! You got ${hours.toStringAsFixed(1)}hrs (target: ${goalHours.toStringAsFixed(1)}hrs)';
    } else if (hours >= goalHours * 0.8) {
      return '🌙 Almost there! ${hours.toStringAsFixed(1)}hrs sleep. Just ${(goalHours - hours).toStringAsFixed(1)}hrs more to hit your goal.';
    }
    return null;
  }
}

class SleepDebtRule extends InsightRule {
  @override
  String get id => 'sleep_debt_warning';

  @override
  String get name => 'Sleep Debt Warning';

  @override
  InsightCategory get category => InsightCategory.sleep;

  @override
  InsightPriority get priority => InsightPriority.critical;

  @override
  int get iconCodePoint => Icons.warning.codePoint;

  @override
  int get colorValue => 0xFFF44336; // Red

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['sleep'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableSleepInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final sleepDebt = userData['sleepDebtMin'] as int?;
    final sleepMin = userData['sleepDurationMin'] as int?;

    if (sleepDebt == null || sleepMin == null) return null;

    if (sleepDebt > 60) {
      return '⚠️ Sleep debt of ${(sleepDebt / 60).toStringAsFixed(1)}hrs! Prioritize rest tonight.';
    } else if (sleepDebt > 30) {
      return '😫 You have ${(sleepDebt / 60).toStringAsFixed(1)}hrs sleep debt. Try to get extra rest.';
    }
    return null;
  }
}

class SleepQualityRule extends InsightRule {
  @override
  String get id => 'sleep_quality_good';

  @override
  String get name => 'Sleep Quality';

  @override
  InsightCategory get category => InsightCategory.sleep;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.star.codePoint;

  @override
  int get colorValue => 0xFF673AB7; // Deep Purple

  @override
  int get cooldownDays => 3;

  @override
  List<String> get requiredDataTypes => ['sleep'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableSleepInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final quality = userData['sleepQualityScore'] as int?;

    if (quality == null) return null;

    if (quality >= 85) {
      return '⭐ Excellent sleep quality! You\'re well-rested.';
    } else if (quality >= 70) {
      return '👍 Good sleep quality today. Keep it up!';
    } else if (quality < 50) {
      return '😴 Sleep quality was low ($quality%). Try going to bed earlier tomorrow.';
    }
    return null;
  }
}

class InconsistentSleepRule extends InsightRule {
  @override
  String get id => 'sleep_inconsistent';

  @override
  String get name => 'Inconsistent Sleep';

  @override
  InsightCategory get category => InsightCategory.sleep;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.schedule.codePoint;

  @override
  int get colorValue => 0xFFFF5722; // Deep Orange

  @override
  int get cooldownDays => 4;

  @override
  List<String> get requiredDataTypes => ['sleep'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableSleepInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    // This would need historical data - simplified for now
    // In a real implementation, we'd check variance in sleep times
    return null;
  }
}

/// Get all sleep rules
List<InsightRule> getSleepRules() {
  return [
    SleepGoalRule(),
    SleepDebtRule(),
    SleepQualityRule(),
    InconsistentSleepRule(),
  ];
}
