import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_output.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';
import 'package:fitkarma/features/insight_engine/rules/server_rule.dart';
import 'package:uuid/uuid.dart';

/// Pure evaluation logic for insight rules
/// Evaluates all rules (local + server) and generates insight outputs
class RuleEvaluator {
  final Uuid _uuid = const Uuid();

  /// Merge local hardcoded rules with server-delivered rules
  List<InsightRule> mergeRules({
    required List<InsightRule> localRules,
    required List<Map<String, dynamic>> serverRulesJson,
  }) {
    final List<InsightRule> allRules = List.from(localRules);

    // Add server rules (parsed from JSON)
    final serverRules = ServerInsightRule.parseRules(serverRulesJson);
    allRules.addAll(serverRules);

    return allRules;
  }

  /// Evaluate all rules and return triggered insights
  Future<List<InsightOutput>> evaluateRules({
    required InsightContext context,
    required List<InsightRule> rules,
    required Map<String, DateTime> lastShownTimes,
    required Set<String> suppressedRuleIds,
  }) async {
    final List<InsightOutput> insights = [];
    final now = context.evaluationDate;

    for (final rule in rules) {
      // Skip suppressed rules
      if (suppressedRuleIds.contains(rule.id)) {
        continue;
      }

      // Check cooldown
      final lastShown = lastShownTimes[rule.id];
      if (lastShown != null) {
        final daysSinceLastShown = now.difference(lastShown).inDays;
        if (daysSinceLastShown < rule.cooldownDays) {
          continue;
        }
      }

      // Evaluate the rule
      try {
        final message = await rule.condition(_contextToMap(context));
        if (message != null && message.isNotEmpty) {
          final insight = _createInsightOutput(rule, message, now);
          insights.add(insight);
        }
      } catch (e) {
        // Skip rules that throw errors during evaluation
        continue;
      }
    }

    return insights;
  }

  /// Sort insights by priority (critical first) then by category
  List<InsightOutput> sortInsights(List<InsightOutput> insights) {
    return insights..sort((a, b) {
      // First sort by priority
      final priorityCompare = a.priority.sortOrder.compareTo(
        b.priority.sortOrder,
      );
      if (priorityCompare != 0) return priorityCompare;

      // Then by category
      return a.category.index.compareTo(b.category.index);
    });
  }

  /// Limit insights to max number per day
  List<InsightOutput> limitInsights(
    List<InsightOutput> insights,
    int maxPerDay,
  ) {
    if (insights.length <= maxPerDay) return insights;
    return insights.take(maxPerDay).toList();
  }

  InsightOutput _createInsightOutput(
    InsightRule rule,
    String message,
    DateTime now,
  ) {
    return InsightOutput(
      id: _uuid.v4(),
      ruleId: rule.id,
      ruleName: rule.name,
      message: message,
      category: rule.category,
      priority: rule.priority,
      iconCodePoint: rule.iconCodePoint,
      iconFontFamily: rule.iconFontFamily,
      color: Color(rule.colorValue),
      generatedAt: now,
      expiresAt: now.add(const Duration(days: 2)),
      status: InsightStatus.pending,
      feedback: InsightFeedback.none,
    );
  }

  Map<String, dynamic> _contextToMap(InsightContext context) {
    return {
      // Basic info
      'userId': context.userId,
      'evaluationDate': context.evaluationDate,

      // Today's data
      'sleepDurationMin': context.sleepDurationMin,
      'sleepHours': context.sleepHours,
      'sleepQualityScore': context.sleepQualityScore,
      'sleepDebtMin': context.sleepDebtMin,
      'proteinGrams': context.proteinGrams,
      'calories': context.calories,
      'carbsGrams': context.carbsGrams,
      'fatGrams': context.fatGrams,
      'waterGlasses': context.waterGlasses,
      'steps': context.steps,
      'workoutMinutes': context.workoutMinutes,
      'workoutCount': context.workoutCount,
      'workoutRpe': context.workoutRpe,
      'hasWorkoutToday': context.hasWorkoutToday,
      'isHighIntensityWorkout': context.isHighIntensityWorkout,
      'isHighStepsDay': context.isHighStepsDay,
      'systolicBp': context.systolicBp,
      'diastolicBp': context.diastolicBp,
      'glucoseMgdl': context.glucoseMgdl,
      'weightKg': context.weightKg,
      'heightCm': context.heightCm,
      'bmi': context.bmi,
      'moodScore': context.moodScore,
      'energyLevel': context.energyLevel,
      'stressLevel': context.stressLevel,
      'screenTimeMinutes': context.screenTimeMinutes,
      'isOnPeriod': context.isOnPeriod,
      'cycleDay': context.cycleDay,
      'isFastingToday': context.isFastingToday,

      // Streaks
      'workoutStreak': context.workoutStreak,
      'waterStreak': context.waterStreak,
      'mealStreak': context.mealStreak,

      // Goals
      'dailyProteinGoal': context.dailyProteinGoal,
      'dailyWaterGoal': context.dailyWaterGoal,
      'dailyStepGoal': context.dailyStepGoal,
      'dailySleepGoal': context.dailySleepGoal,

      // Historical data for correlations
      'sleepMoodHistory': context.sleepMoodHistory,
      'stepsGlucoseHistory': context.stepsGlucoseHistory,
      'fastingBpHistory': context.fastingBpHistory,
      'calorieHistory': context.calorieHistory,
      'screenTimeMoodHistory': context.screenTimeMoodHistory,
      'yesterdayWorkoutRpe': context.yesterdayWorkoutRpe,
      'yesterdaySleepQuality': context.yesterdaySleepQuality,
      'upcomingFestivalDate': context.upcomingFestivalDate,
      'isFestivalSoon': context.isFestivalSoon,

      // Helper flags
      'isLowProteinOnWorkoutDay': context.isLowProteinOnWorkoutDay,
    };
  }
}
