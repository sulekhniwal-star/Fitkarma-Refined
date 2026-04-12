/// Insight Engine — Abstract model types.
library;

import 'package:flutter/material.dart';

/// Severity / display priority of an insight.
enum InsightPriority {
  critical,   // Health alert — always surface
  high,       // Strong pattern, surface same day
  normal,     // General tip, queue for next day slot
  low,        // Nice-to-know, only if no other insights
}

/// Which module sourced the insight.
enum InsightModule {
  nutrition,
  sleep,
  workout,
  hydration,
  mood,
  steps,
  bloodPressure,
  glucose,
  fasting,
  period,
  crossModule,
  festival,
  server,
}

/// Abstract base class every Rule must implement.
abstract class InsightRule {
  const InsightRule();

  /// Unique identifier used to suppress (thumbs-down) a rule.
  String get id;

  /// Human-readable English name shown in settings.
  String get name;

  /// Priority determines display slot (max 2 per day for normal/low).
  InsightPriority get priority => InsightPriority.normal;

  InsightModule get module;

  /// Returns an [InsightOutput] if the rule fires, or `null` if it doesn't.
  /// [context] carries Drift data snapshots — all reads happen before evaluation.
  Future<InsightOutput?> evaluate(InsightContext context);
}

/// Data bundles passed into each rule during evaluation.
/// All DB reads happen in [InsightScheduler] before calling [evaluate].
class InsightContext {
  const InsightContext({
    required this.userId,
    required this.today,
    required this.recentFoodLogs,
    required this.recentSleepLogs,
    required this.recentWorkoutLogs,
    required this.recentMoodLogs,
    required this.recentBpLogs,
    required this.recentGlucoseLogs,
    required this.recentStepLogs,
    required this.nutritionGoals,
    this.recentFastingLogs = const [],
    this.activeFestivals = const [],
    this.hasLabReports = false,
    this.accountAgeDays = 0,
  });

  final String userId;
  final DateTime today;
  final List<Map<String, dynamic>> recentFoodLogs;
  final List<Map<String, dynamic>> recentSleepLogs;
  final List<Map<String, dynamic>> recentWorkoutLogs;
  final List<Map<String, dynamic>> recentMoodLogs;
  final List<Map<String, dynamic>> recentBpLogs;
  final List<Map<String, dynamic>> recentGlucoseLogs;
  final List<Map<String, dynamic>> recentStepLogs;
  final List<Map<String, dynamic>> recentFastingLogs;
  final Map<String, dynamic>? nutritionGoals;
  final List<Map<String, dynamic>> activeFestivals;
  final bool hasLabReports;
  final int accountAgeDays;
}

/// The output of a fired rule — shown on the Dashboard as an InsightCard.
class InsightOutput {
  const InsightOutput({
    required this.ruleId,
    required this.module,
    required this.priority,
    required this.titleEn,
    required this.titleHi,
    required this.bodyEn,
    required this.bodyHi,
    this.actionLabel,
    this.actionRoute,
    this.icon,
    this.color,
  });

  final String ruleId;
  final InsightModule module;
  final InsightPriority priority;
  final String titleEn;
  final String titleHi;
  final String bodyEn;
  final String bodyHi;
  final String? actionLabel;
  final String? actionRoute;
  final IconData? icon;
  final Color? color;
}
