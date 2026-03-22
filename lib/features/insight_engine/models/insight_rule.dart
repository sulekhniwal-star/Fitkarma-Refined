import 'package:flutter/material.dart';

/// Priority levels for insight rules
enum InsightPriority { critical, high, medium, low }

/// Category of insight for grouping
enum InsightCategory {
  sleep,
  nutrition,
  hydration,
  workout,
  health,
  mood,
  cycle,
  streak,
  crossModule,
}

/// Abstract base class for all insight rules
/// Each rule defines:
/// - A condition that triggers the insight
/// - A message to display to the user
/// - Priority level for sorting
/// - Category for grouping
abstract class InsightRule {
  /// Unique identifier for this rule
  String get id;

  /// Human-readable name
  String get name;

  /// Category for grouping insights
  InsightCategory get category;

  /// Priority level (affects display order)
  InsightPriority get priority;

  /// Check if this rule should trigger an insight based on user data
  /// Returns the insight message if triggered, null otherwise
  Future<String?> condition(Map<String, dynamic> userData);

  /// Get the icon to display with this insight
  @Deprecated('Use iconCodePoint and iconFontFamily instead')
  IconData? get icon => null;

  /// Code point for the icon (Material Icons)
  int get iconCodePoint => 0xe87c; // default: lightbulb_outline

  /// Font family for the icon
  String get iconFontFamily => 'MaterialIcons';

  /// Get color for this insight category
  int get colorValue => 0xFF2196F3; // default: blue

  /// Check if this rule should run based on user preferences
  bool isEnabled(Map<String, dynamic> userPreferences);

  /// Get the cooldown period (in days) before this rule can trigger again
  int get cooldownDays => 7;

  /// Get data requirements for this rule
  List<String> get requiredDataTypes;
}

/// Data class holding user health data for evaluation
/// Includes current day data and recent history for correlations
class InsightContext {
  final String userId;
  final DateTime evaluationDate;

  // ========== TODAY'S DATA ==========
  
  // Sleep data
  final int? sleepDurationMin;
  final int? sleepQualityScore;
  final int? sleepDebtMin;

  // Nutrition data
  final double? proteinGrams;
  final double? calories;
  final double? carbsGrams;
  final double? fatGrams;

  // Hydration data
  final int? waterGlasses;

  // Activity data
  final int? steps;
  final int? workoutMinutes;
  final int? workoutCount;
  final double? workoutRpe; // Rate of Perceived Exertion (1-10)

  // Health metrics
  final int? systolicBp;
  final int? diastolicBp;
  final double? glucoseMgdl;
  final double? weightKg;
  final double? heightCm;

  // Mood data
  final int? moodScore;
  final int? energyLevel;
  final int? stressLevel;
  final int? screenTimeMinutes;

  // Cycle data
  final bool? isOnPeriod;
  final int? cycleDay;

  // Fasting
  final bool? isFastingToday;

  // Streaks
  final int? workoutStreak;
  final int? waterStreak;
  final int? mealStreak;

  // Goals
  final double? dailyProteinGoal;
  final int? dailyWaterGoal;
  final int? dailyStepGoal;
  final int? dailySleepGoal;

  // ========== HISTORICAL DATA FOR CORRELATIONS ==========
  
  /// Sleep-Mood history: List of {date, sleepHours, moodScore}
  /// Used to detect: if sleep < 6hrs leads to poor mood next day
  final List<Map<String, dynamic>>? sleepMoodHistory;
  
  /// Steps-Glucose history: List of {date, steps, glucose}
  /// Used to detect: correlation between high steps and lower glucose
  final List<Map<String, dynamic>>? stepsGlucoseHistory;
  
  /// Fasting-BP history: List of {date, isFasting, systolic}
  /// Used to detect: BP improvement on fasting days
  final List<Map<String, dynamic>>? fastingBpHistory;
  
  /// Calorie history: List of {date, calories}
  /// Used to detect: calorie spikes around festivals
  final List<Map<String, dynamic>>? calorieHistory;
  
  /// Screen time - mood history: List of {date, screenTime, mood}
  /// Used to detect: correlation between screen time and mood
  final List<Map<String, dynamic>>? screenTimeMoodHistory;
  
  /// Yesterday's data for consecutive-day analysis
  final int? yesterdayWorkoutRpe;
  final int? yesterdaySleepQuality;
  
  /// Festival: Date of upcoming festival (null if none in next 7 days)
  final DateTime? upcomingFestivalDate;

  const InsightContext({
    required this.userId,
    required this.evaluationDate,
    this.sleepDurationMin,
    this.sleepQualityScore,
    this.sleepDebtMin,
    this.proteinGrams,
    this.calories,
    this.carbsGrams,
    this.fatGrams,
    this.waterGlasses,
    this.steps,
    this.workoutMinutes,
    this.workoutCount,
    this.workoutRpe,
    this.systolicBp,
    this.diastolicBp,
    this.glucoseMgdl,
    this.weightKg,
    this.heightCm,
    this.moodScore,
    this.energyLevel,
    this.stressLevel,
    this.screenTimeMinutes,
    this.isOnPeriod,
    this.cycleDay,
    this.isFastingToday,
    this.workoutStreak,
    this.waterStreak,
    this.mealStreak,
    this.dailyProteinGoal,
    this.dailyWaterGoal,
    this.dailyStepGoal,
    this.dailySleepGoal,
    this.sleepMoodHistory,
    this.stepsGlucoseHistory,
    this.fastingBpHistory,
    this.calorieHistory,
    this.screenTimeMoodHistory,
    this.yesterdayWorkoutRpe,
    this.yesterdaySleepQuality,
    this.upcomingFestivalDate,
  });

  double? get bmi {
    if (weightKg == null || heightCm == null || heightCm! <= 0) return null;
    final heightM = heightCm! / 100;
    return weightKg! / (heightM * heightM);
  }

  double? get sleepHours => sleepDurationMin != null ? sleepDurationMin! / 60 : null;

  bool get hasEnoughDataForInsights {
    return sleepDurationMin != null ||
        proteinGrams != null ||
        waterGlasses != null ||
        steps != null ||
        workoutMinutes != null;
  }

  /// Helper: Check if protein is low on workout days
  bool get isLowProteinOnWorkoutDay {
    if (!hasWorkoutToday || proteinGrams == null || dailyProteinGoal == null) {
      return false;
    }
    return proteinGrams! < (dailyProteinGoal! * 0.7);
  }

  /// Check if today has a logged workout
  bool get hasWorkoutToday => (workoutMinutes ?? 0) > 0;

  /// Check if high intensity workout (RPE >= 8)
  bool get isHighIntensityWorkout => (workoutRpe ?? 0) >= 8;

  /// Check if high steps day (>= 8000)
  bool get isHighStepsDay => (steps ?? 0) >= 8000;

  /// Check if festival within 3 days
  bool get isFestivalSoon {
    if (upcomingFestivalDate == null) return false;
    final daysUntil = upcomingFestivalDate!.difference(evaluationDate).inDays;
    return daysUntil >= 0 && daysUntil <= 3;
  }
}
