import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';

/// Cross-module correlation rules
/// These rules analyze relationships between different health data points

// =============================================================================
// SLEEP × MOOD CORRELATION
// =============================================================================

/// Detects if poor sleep leads to bad mood next day
class SleepMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_sleep_mood';

  @override
  String get name => 'Sleep-Mood Pattern';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.bedtime.codePoint;

  @override
  int get colorValue => 0xFF7C4DFF; // Deep Purple

  @override
  int get cooldownDays => 14;

  @override
  List<String> get requiredDataTypes => ['sleepMoodHistory'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final history = userData['sleepMoodHistory'] as List<Map<String, dynamic>>?;
    if (history == null || history.length < 5) return null;

    // Count days where sleep < 6 hours AND next day mood <= 2
    int poorSleepLowMoodDays = 0;
    for (int i = 0; i < history.length - 1; i++) {
      final today = history[i];
      final tomorrow = history[i + 1];
      
      final sleepHours = (today['sleepHours'] as num?)?.toDouble();
      final tomorrowMood = (tomorrow['moodScore'] as num?)?.toInt();
      
      if (sleepHours != null && tomorrowMood != null) {
        if (sleepHours < 6 && tomorrowMood <= 2) {
          poorSleepLowMoodDays++;
        }
      }
    }

    // Pattern repeats >= 5 times in 30 days
    if (poorSleepLowMoodDays >= 5) {
      return '😴 Your sleep-mood pattern: Poor sleep (<6hrs) often leads to low mood next day. '
             'Prioritize sleep to improve your mood!';
    }

    return null;
  }
}

// =============================================================================
// WORKOUT × PROTEIN CORRELATION  
// =============================================================================

/// Detects if protein intake is low on workout days
class WorkoutProteinCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_workout_protein';

  @override
  String get name => 'Workout Nutrition';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.fitness_center.codePoint;

  @override
  int get colorValue => 0xFFFF5722; // Deep Orange

  @override
  int get cooldownDays => 5;

  @override
  List<String> get requiredDataTypes => ['workout', 'protein'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final hasWorkout = userData['hasWorkoutToday'] as bool? ?? false;
    final protein = userData['proteinGrams'] as double?;
    final proteinGoal = userData['dailyProteinGoal'] as double?;

    if (!hasWorkout || protein == null || proteinGoal == null || proteinGoal <= 0) {
      return null;
    }

    // Check if protein < 70% of goal on workout days
    if (protein < proteinGoal * 0.7) {
      return '🥩 You under-eat protein on workout days (${protein.toStringAsFixed(0)}g vs ${proteinGoal.toStringAsFixed(0)}g goal). '
             'Add protein within 2 hours of your workout for better recovery!';
    }

    return null;
  }
}

// =============================================================================
// FASTING × BP CORRELATION
// =============================================================================

/// Detects BP improvement on fasting days
class FastingBpCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_fasting_bp';

  @override
  String get name => 'Fasting Benefits';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.favorite.codePoint;

  @override
  int get colorValue => 0xFF4CAF50; // Green

  @override
  int get cooldownDays => 14;

  @override
  List<String> get requiredDataTypes => ['fastingBpHistory'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final history = userData['fastingBpHistory'] as List<Map<String, dynamic>>?;
    if (history == null || history.length < 4) return null;

    // Calculate average systolic on fasting vs non-fasting days
    List<int> fastingSys = [];
    List<int> nonFastingSys = [];

    for (final entry in history) {
      final isFasting = entry['isFasting'] as bool? ?? false;
      final systolic = (entry['systolic'] as num?)?.toInt();
      
      if (systolic != null) {
        if (isFasting) {
          fastingSys.add(systolic);
        } else {
          nonFastingSys.add(systolic);
        }
      }
    }

    if (fastingSys.isEmpty || nonFastingSys.isEmpty) return null;

    final avgFasting = fastingSys.reduce((a, b) => a + b) / fastingSys.length;
    final avgNonFasting = nonFastingSys.reduce((a, b) => a + b) / nonFastingSys.length;

    // If fasting days have >= 5 mmHg lower systolic
    if (avgNonFasting - avgFasting >= 5) {
      return '🩺 Great news! Your BP averages ${(avgNonFasting - avgFasting).toStringAsFixed(0)}mmHg lower on fasting days. '
             'Keep up the intermittent fasting!';
    }

    return null;
  }
}

// =============================================================================
// STEPS × GLUCOSE CORRELATION
// =============================================================================

/// Detects positive impact of walking on blood glucose
class StepsGlucoseCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_steps_glucose';

  @override
  String get name => 'Walking Lowers Glucose';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.directions_walk.codePoint;

  @override
  int get colorValue => 0xFF2196F3; // Blue

  @override
  int get cooldownDays => 14;

  @override
  List<String> get requiredDataTypes => ['stepsGlucoseHistory'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final history = userData['stepsGlucoseHistory'] as List<Map<String, dynamic>>?;
    if (history == null || history.length < 4) return null;

    // Compare average glucose on high step days (>=8000) vs low step days
    List<double> highStepGlucose = [];
    List<double> lowStepGlucose = [];

    for (final entry in history) {
      final steps = (entry['steps'] as num?)?.toInt();
      final glucose = (entry['glucose'] as num?)?.toDouble();

      if (glucose != null && steps != null) {
        if (steps >= 8000) {
          highStepGlucose.add(glucose);
        } else {
          lowStepGlucose.add(glucose);
        }
      }
    }

    if (highStepGlucose.isEmpty || lowStepGlucose.isEmpty) return null;

    final avgHighSteps = highStepGlucose.reduce((a, b) => a + b) / highStepGlucose.length;
    final avgLowSteps = lowStepGlucose.reduce((a, b) => a + b) / lowStepGlucose.length;

    // If high step days have notably lower glucose
    if (avgLowSteps - avgHighSteps >= 10) {
      return '🚶 Your data shows ${(avgLowSteps - avgHighSteps).toStringAsFixed(0)}mg/dL lower glucose on days with 8000+ steps! '
             'Walking really helps manage blood sugar.';
    }

    return null;
  }
}

// =============================================================================
// FESTIVAL × CALORIE CORRELATION
// =============================================================================

/// Proactive insight before festivals to prevent calorie overload
class FestivalCalorieInsightRule extends InsightRule {
  @override
  String get id => 'cross_festival_calorie';

  @override
  String get name => 'Festival Preparation';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  int get iconCodePoint => Icons.celebration.codePoint;

  @override
  int get colorValue => 0xFFE91E63; // Pink

  @override
  int get cooldownDays => 7;

  @override
  List<String> get requiredDataTypes => ['festival', 'calorieHistory'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final festivalDate = userData['upcomingFestivalDate'] as DateTime?;
    final calorieHistory = userData['calorieHistory'] as List<Map<String, dynamic>>?;
    
    if (festivalDate == null) return null;

    final now = DateTime.now();
    final daysUntilFestival = festivalDate.difference(now).inDays;

    // Only show 3 days before festival
    if (daysUntilFestival < 0 || daysUntilFestival > 3) return null;

    // Check past festival patterns
    if (calorieHistory != null && calorieHistory.length >= 3) {
      // Calculate average calorie spike during festivals
      // For now, just give proactive advice
      return '🎉 Festival in $daysUntilFestival day${daysUntilFestival == 1 ? '' : 's'}! '
             'Tip: Start your day with high-protein breakfast to stay fuller longer. '
             'Stay hydrated between rich meals!';
    }

    // If no history, still give proactive advice
    if (daysUntilFestival <= 3) {
      return '🎉 Festival coming up in $daysUntilFestival day${daysUntilFestival == 1 ? '' : 's'}! '
             'Pro tip: Eat protein first, then vegetables, then carbs - '
             'this helps control overall intake!';
    }

    return null;
  }
}

// =============================================================================
// RPE × SLEEP CORRELATION (BURNT RISK)
// =============================================================================

/// Detects burnout risk: high intensity workout + poor sleep
class RpeSleepBurnoutRule extends InsightRule {
  @override
  String get id => 'cross_rpe_sleep_burnout';

  @override
  String get name => 'Burnout Risk Alert';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.critical;

  @override
  int get iconCodePoint => Icons.warning_amber.codePoint;

  @override
  int get colorValue => 0xFFF44336; // Red

  @override
  int get cooldownDays => 5;

  @override
  List<String> get requiredDataTypes => ['workoutRpe', 'sleepQuality', 'yesterdayData'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final todayRpe = userData['workoutRpe'] as double?;
    final yesterdayRpe = userData['yesterdayWorkoutRpe'] as int?;
    final yesterdaySleepQuality = userData['yesterdaySleepQuality'] as int?;
    final todaySleepQuality = userData['sleepQualityScore'] as int?;

    // Check consecutive days: high RPE today + poor sleep today OR 
    // high RPE yesterday + poor sleep yesterday
    
    bool highRpePoorSleep = false;
    
    // Case 1: High RPE today + poor sleep quality
    if (todayRpe != null && todaySleepQuality != null) {
      if (todayRpe >= 8 && todaySleepQuality <= 2) {
        highRpePoorSleep = true;
      }
    }
    
    // Case 2: High RPE yesterday + poor sleep yesterday
    if (yesterdayRpe != null && yesterdaySleepQuality != null) {
      if (yesterdayRpe >= 8 && yesterdaySleepQuality <= 2) {
        highRpePoorSleep = true;
      }
    }

    if (highRpePoorSleep) {
      return '⚠️ Burnout risk detected! High-intensity workout (RPE 8+) combined with poor sleep '
             'puts significant stress on your body. Consider: 1) Easy recovery workout tomorrow, '
             '2) Prioritize 7-8 hours sleep tonight, 3) Light stretching instead of intense exercise.';
    }

    return null;
  }
}

// =============================================================================
// SCREEN TIME × MOOD CORRELATION
// =============================================================================

/// Detects correlation between excessive screen time and low mood
class ScreenTimeMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_screen_time_mood';

  @override
  String get name => 'Screen Time & Mood';

  @override
  InsightCategory get category => InsightCategory.crossModule;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.phone_android.codePoint;

  @override
  int get colorValue => 0xFF9C27B0; // Purple

  @override
  int get cooldownDays => 10;

  @override
  List<String> get requiredDataTypes => ['screenTimeMoodHistory'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCrossModuleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final history = userData['screenTimeMoodHistory'] as List<Map<String, dynamic>>?;
    if (history == null || history.length < 7) return null;

    // Check if high screen time correlates with low mood
    int highScreenLowMoodDays = 0;
    int totalDays = 0;

    for (final entry in history) {
      final screenTime = (entry['screenTime'] as num?)?.toInt();
      final mood = (entry['mood'] as num?)?.toInt();

      if (screenTime != null && mood != null) {
        totalDays++;
        // High screen time (>240 min) + low mood (<=3)
        if (screenTime > 240 && mood <= 3) {
          highScreenLowMoodDays++;
        }
      }
    }

    // If pattern appears in at least 4 out of 7 days
    if (totalDays >= 7 && highScreenLowMoodDays >= 4) {
      return '📱 Notice: High screen time (>4hrs) often coincides with low mood days. '
             'Try a 24-hour digital detox or set screen-free times - your mood might thank you!';
    }

    return null;
  }
}

// =============================================================================
// BMI CATEGORY RULE
// =============================================================================

class BmiCategoryRule extends InsightRule {
  @override
  String get id => 'health_bmi_category';

  @override
  String get name => 'BMI Category';

  @override
  InsightCategory get category => InsightCategory.health;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.monitor_weight.codePoint;

  @override
  int get colorValue => 0xFF607D8B; // Blue Grey

  @override
  int get cooldownDays => 14;

  @override
  List<String> get requiredDataTypes => ['bodyMeasurements'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableHealthInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final bmi = userData['bmi'] as double?;

    if (bmi == null) return null;

    if (bmi >= 18.5 && bmi < 25) {
      return '⚖️ Your BMI (${bmi.toStringAsFixed(1)}) is in the healthy range. Great!';
    } else if (bmi >= 25 && bmi < 30) {
      return '📊 Your BMI (${bmi.toStringAsFixed(1)}) indicates overweight. '
             'Small lifestyle changes can help - focus on protein-rich meals and regular activity.';
    } else if (bmi >= 30) {
      return '📊 Your BMI (${bmi.toStringAsFixed(1)}) indicates obesity. '
             'Consider consulting a healthcare professional for personalized guidance.';
    } else if (bmi < 18.5) {
      return '📊 Your BMI (${bmi.toStringAsFixed(1)}) is below normal. '
             'Consider nutritional consultation to reach a healthy weight.';
    }

    return null;
  }
}

// =============================================================================
// PERIOD × WELLNESS RULE  
// =============================================================================

class PeriodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_period_wellness';

  @override
  String get name => 'Period & Wellness';

  @override
  InsightCategory get category => InsightCategory.cycle;

  @override
  InsightPriority get priority => InsightPriority.medium;

  @override
  int get iconCodePoint => Icons.auto_awesome.codePoint;

  @override
  int get colorValue => 0xFFE91E63; // Pink

  @override
  int get cooldownDays => 7;

  @override
  List<String> get requiredDataTypes => ['cycle', 'mood', 'workout'];

  @override
  bool isEnabled(Map<String, dynamic> userPreferences) {
    return userPreferences['enableCycleInsights'] != false;
  }

  @override
  Future<String?> condition(Map<String, dynamic> userData) async {
    final isOnPeriod = userData['isOnPeriod'] as bool?;
    final mood = userData['moodScore'] as int?;
    final workoutMinutes = userData['workoutMinutes'] as int?;

    if (isOnPeriod != true) return null;

    if (mood != null && mood <= 4) {
      return '💊 On your period and feeling low? It\'s completely normal. '
             'Be gentle with yourself - try light yoga or a walk.';
    }

    if (workoutMinutes != null && workoutMinutes > 0) {
      return '💪 Working out on your period! Light exercise can help with cramps. '
             'Keep listening to your body!';
    }

    return null;
  }
}

/// Get all cross-module correlation rules
List<InsightRule> getCrossModuleRules() {
  return [
    SleepMoodCorrelationRule(),
    WorkoutProteinCorrelationRule(),
    FastingBpCorrelationRule(),
    StepsGlucoseCorrelationRule(),
    FestivalCalorieInsightRule(),
    RpeSleepBurnoutRule(),
    ScreenTimeMoodCorrelationRule(),
    BmiCategoryRule(),
    PeriodCorrelationRule(),
  ];
}
