import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Rules related to hydration and water intake
class HydrationGoalRule extends InsightRule {
  @override
  String get id => 'hydration_goal';

  @override
  String get name => 'Hydration Goal';

  @override
  InsightCategory get category => InsightCategory.hydration;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.water_drop.codePoint;

  @override
  int get colorValue => 0xFF03A9F4; // Light Blue

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['water'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHydrationInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glasses = userData['waterGlasses'] as int?;
    final goal = userData['dailyWaterGoal'] as int?;

    if (glasses == null || goal == null || goal <= 0) return null;

    if (glasses >= goal) {
      return '💧 Hydration goal achieved! $glasses glasses - great job!';
    } else if (glasses >= goal * 0.75) {
      return '💧 Almost there! $glasses/$goal glasses. Keep drinking!';
    } else if (glasses >= goal * 0.5) {
      return '💧 $glasses/$goal glasses. You\'re halfway there!';
    }
    return null;
  }
}

class LowHydrationRule extends InsightRule {
  @override
  String get id => 'low_hydration';

  @override
  String get name => 'Low Hydration Warning';

  @override
  InsightCategory get category => InsightCategory.hydration;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.warning_amber.codePoint;

  @override
  int get colorValue => 0xFFFF9800; // Orange

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['water'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHydrationInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glasses = userData['waterGlasses'] as int?;
    final goal = userData['dailyWaterGoal'] as int?;

    if (glasses == null || goal == null) return null;

    if (glasses < goal * 0.25 && glasses > 0) {
      return '💧 Only $glasses glasses so far. Try to drink more water!';
    } else if (glasses == 0) {
      return '🚰 Don\'t forget to hydrate! Start with a glass of water.';
    }
    return null;
  }
}

class HydrationStreakRule extends InsightRule {
  @override
  String get id => 'hydration_streak';

  @override
  String get name => 'Hydration Streak';

  @override
  InsightCategory get category => InsightCategory.streak;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.local_fire_department.codePoint;

  @override
  int get colorValue => 0xFF00BCD4; // Cyan

  @override
  int get cooldownDays => 1;

  @override
  List<String> get requiredDataTypes => ['water', 'streak'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHydrationInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final streak = userData['waterStreak'] as int?;
    final glasses = userData['waterGlasses'] as int?;
    final goal = userData['dailyWaterGoal'] as int?;

    if (streak == null || streak == 0) return null;
    if (glasses == null || goal == null || glasses < goal) return null;

    if (streak >= 7) {
      return '🌊 $streak-day hydration streak! Your body thanks you!';
    } else if (streak >= 3) {
      return '💧 $streak days of hitting your water goal. Keep it going!';
    }
    return null;
  }
}

class HydrationReminderRule extends InsightRule {
  @override
  String get id => 'hydration_reminder';

  @override
  String get name => 'Hydration Reminder';

  @override
  InsightCategory get category => InsightCategory.hydration;

  @override
  InsightPriority get priority => InsightPriority.low;

  @override
  int get iconCodePoint => Icons.notifications.codePoint;

  @override
  int get colorValue => 0xFF4FC3F7; // Light Blue

  @override
  int get cooldownDays => 2;

  @override
  List<String> get requiredDataTypes => ['water'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHydrationInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final glasses = userData['waterGlasses'] as int?;

    // Only show reminder if it's afternoon/evening and low water intake
    if (glasses == null || glasses >= 4) return null;

    return '💧 Tip: Keep a water bottle at your desk to stay hydrated throughout the day.';
  }
}

/// Get all hydration rules
List<InsightRule> getHydrationRules() {
  return [
    HydrationGoalRule(),
    LowHydrationRule(),
    HydrationStreakRule(),
    HydrationReminderRule(),
  ];
}
