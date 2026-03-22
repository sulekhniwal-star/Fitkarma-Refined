import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fitkarma/features/insight_engine/models/insight_output.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';
import 'package:fitkarma/features/insight_engine/engine/rule_evaluator.dart';
import 'package:fitkarma/features/insight_engine/rules/nutrition_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/sleep_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/bp_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/glucose_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/workout_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/hydration_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/cross_module_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/mood_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/lab_report_rules.dart';

/// Main service for insight engine - coordinates data loading, rule evaluation, and storage
///
/// Note: This service works with in-memory storage. For persistence, integrate with Drift
/// after running build_runner to generate the insight tables.
class InsightService {
  final RuleEvaluator _evaluator = RuleEvaluator();

  // In-memory storage for insights and feedback
  final List<_StoredInsight> _insights = [];
  final List<_FeedbackEntry> _feedbackLogs = [];
  final Map<String, DateTime> _lastShownTimes = {};

  // Cache all rules
  late final List<InsightRule> _allRules;

  // Last evaluation time
  DateTime? _lastEvaluationTime;

  InsightService() {
    _allRules = [
      ...getNutritionRules(),
      ...getSleepRules(),
      ...getBpRules(),
      ...getGlucoseRules(),
      ...getWorkoutRules(),
      ...getHydrationRules(),
      ...getMoodRules(),
      ...getCrossModuleRules(),
      ...getLabReportRules(),
    ];
  }

  /// Merge local rules with server-delivered rules from Remote Config
  /// Call this after loading server_rules from Remote Config
  void mergeServerRules(List<Map<String, dynamic>> serverRulesJson) {
    _allRules = _evaluator.mergeRules(
      localRules: _allRules,
      serverRulesJson: serverRulesJson,
    );
  }

  /// Get all available rules
  List<InsightRule> get allRules => _allRules;

  /// Get user's current insights for display
  List<InsightOutput> getCurrentInsights(String userId) {
    return _insights
        .where((i) => i.userId == userId && i.status == InsightStatus.shown)
        .where(
          (i) => i.expiresAt == null || i.expiresAt!.isAfter(DateTime.now()),
        )
        .map((i) => i.toOutput())
        .take(2)
        .toList();
  }

  /// Generate new insights for today
  Future<List<InsightOutput>> generateInsights({
    required String userId,
    required InsightContext context,
    required Map<String, dynamic> userPreferences,
  }) async {
    // Check if enough time has passed since last evaluation
    if (_lastEvaluationTime != null) {
      final hoursSinceLast = DateTime.now()
          .difference(_lastEvaluationTime!)
          .inHours;
      if (hoursSinceLast < 6) {
        return [];
      }
    }

    if (!context.hasEnoughDataForInsights) {
      return [];
    }

    _lastEvaluationTime = DateTime.now();

    // Get suppressed rules (those with thumbs down feedback)
    final suppressedRules = _getSuppressedRuleIds(userId);

    // Evaluate all rules
    final insights = await _evaluator.evaluateRules(
      context: context,
      rules: _allRules,
      lastShownTimes: _lastShownTimes,
      suppressedRuleIds: suppressedRules,
    );

    // Sort by priority
    final sortedInsights = _evaluator.sortInsights(insights);

    // Limit to max 2 per day
    final limitedInsights = _evaluator.limitInsights(sortedInsights, 2);

    // Save to storage
    for (final insight in limitedInsights) {
      _saveInsight(userId, insight);
    }

    return limitedInsights;
  }

  /// Record user feedback on an insight
  void recordFeedback(
    String userId,
    String insightId,
    InsightFeedback feedback,
  ) {
    // Update the insight
    final index = _insights.indexWhere((i) => i.id == insightId);
    if (index != -1) {
      _insights[index] = _insights[index].copyWith(
        feedback: feedback,
        status: InsightStatus.acted,
      );
    }

    // Also record in feedback logs for analytics
    final storedInsight = _insights.firstWhere(
      (i) => i.id == insightId,
      orElse: () => _StoredInsight(
        id: '',
        userId: '',
        ruleId: '',
        ruleName: '',
        message: '',
        category: InsightCategory.health,
        priority: InsightPriority.medium,
        iconCodePoint: 0,
        iconFontFamily: '',
        colorValue: 0,
        generatedAt: DateTime.now(),
        status: InsightStatus.pending,
        feedback: InsightFeedback.none,
      ),
    );

    if (storedInsight.ruleId.isNotEmpty) {
      _feedbackLogs.add(
        _FeedbackEntry(
          id: '${userId}_${storedInsight.ruleId}_${DateTime.now().millisecondsSinceEpoch}',
          userId: userId,
          ruleId: storedInsight.ruleId,
          feedback: feedback,
          loggedAt: DateTime.now(),
          insightId: insightId,
        ),
      );
    }
  }

  /// Dismiss an insight
  void dismissInsight(String userId, String insightId) {
    final index = _insights.indexWhere((i) => i.id == insightId);
    if (index != -1) {
      _insights[index] = _insights[index].copyWith(
        status: InsightStatus.dismissed,
      );
    }
  }

  /// Get suppressed rule IDs based on user feedback
  Set<String> _getSuppressedRuleIds(String userId) {
    final userFeedback = _feedbackLogs
        .where((l) => l.userId == userId)
        .toList();

    // Suppress if more than 2 thumbs down in last 30 days
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final thumbsDownCount = <String, int>{};

    for (final log in userFeedback) {
      if (log.loggedAt.isAfter(thirtyDaysAgo) &&
          log.feedback == InsightFeedback.thumbsDown) {
        thumbsDownCount[log.ruleId] = (thumbsDownCount[log.ruleId] ?? 0) + 1;
      }
    }

    return thumbsDownCount.entries
        .where((e) => e.value > 2)
        .map((e) => e.key)
        .toSet();
  }

  void _saveInsight(String userId, InsightOutput insight) {
    _insights.add(
      _StoredInsight(
        id: insight.id,
        userId: userId,
        ruleId: insight.ruleId,
        ruleName: insight.ruleName,
        message: insight.message,
        category: insight.category,
        priority: insight.priority,
        iconCodePoint: insight.iconCodePoint,
        iconFontFamily: insight.iconFontFamily,
        colorValue: insight.color.value,
        generatedAt: insight.generatedAt,
        expiresAt: insight.expiresAt,
        status: InsightStatus.shown,
        feedback: InsightFeedback.none,
        metadata: insight.metadata,
      ),
    );

    // Update last shown time for cooldown
    _lastShownTimes[insight.ruleId] = DateTime.now();
  }
}

/// In-memory storage class for insights
class _StoredInsight {
  final String id;
  final String userId;
  final String ruleId;
  final String ruleName;
  final String message;
  final InsightCategory category;
  final InsightPriority priority;
  final int iconCodePoint;
  final String iconFontFamily;
  final int colorValue;
  final DateTime generatedAt;
  final DateTime? expiresAt;
  final InsightStatus status;
  final InsightFeedback feedback;
  final Map<String, dynamic>? metadata;

  _StoredInsight({
    required this.id,
    required this.userId,
    required this.ruleId,
    required this.ruleName,
    required this.message,
    required this.category,
    required this.priority,
    required this.iconCodePoint,
    required this.iconFontFamily,
    required this.colorValue,
    required this.generatedAt,
    this.expiresAt,
    required this.status,
    required this.feedback,
    this.metadata,
  });

  _StoredInsight copyWith({
    String? id,
    String? userId,
    String? ruleId,
    String? ruleName,
    String? message,
    InsightCategory? category,
    InsightPriority? priority,
    int? iconCodePoint,
    String? iconFontFamily,
    int? colorValue,
    DateTime? generatedAt,
    DateTime? expiresAt,
    InsightStatus? status,
    InsightFeedback? feedback,
    Map<String, dynamic>? metadata,
  }) {
    return _StoredInsight(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      ruleId: ruleId ?? this.ruleId,
      ruleName: ruleName ?? this.ruleName,
      message: message ?? this.message,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      iconFontFamily: iconFontFamily ?? this.iconFontFamily,
      colorValue: colorValue ?? this.colorValue,
      generatedAt: generatedAt ?? this.generatedAt,
      expiresAt: expiresAt ?? this.expiresAt,
      status: status ?? this.status,
      feedback: feedback ?? this.feedback,
      metadata: metadata ?? this.metadata,
    );
  }

  InsightOutput toOutput() {
    return InsightOutput(
      id: id,
      ruleId: ruleId,
      ruleName: ruleName,
      message: message,
      category: category,
      priority: priority,
      iconCodePoint: iconCodePoint,
      iconFontFamily: iconFontFamily,
      color: Color(colorValue),
      generatedAt: generatedAt,
      expiresAt: expiresAt,
      status: status,
      feedback: feedback,
      metadata: metadata,
    );
  }
}

/// In-memory feedback log entry
class _FeedbackEntry {
  final String id;
  final String userId;
  final String ruleId;
  final InsightFeedback feedback;
  final DateTime loggedAt;
  final String insightId;

  _FeedbackEntry({
    required this.id,
    required this.userId,
    required this.ruleId,
    required this.feedback,
    required this.loggedAt,
    required this.insightId,
  });
}
