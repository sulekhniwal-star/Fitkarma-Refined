import 'package:fitkarma/features/insight_engine/models/insight_output.dart';
import 'package:fitkarma/features/insight_engine/models/insight_rule.dart';
import 'package:fitkarma/features/insight_engine/engine/rule_evaluator.dart';

/// Manages when to run insight evaluation and throttling
class InsightScheduler {
  final RuleEvaluator _evaluator = RuleEvaluator();

  /// Maximum number of insights to show per day
  static const int maxInsightsPerDay = 2;

  /// Last evaluation time
  DateTime? _lastEvaluationTime;

  /// Minimum interval between evaluations (hours)
  static const int minEvaluationIntervalHours = 6;

  /// Check if it's time to run evaluation
  bool shouldRunEvaluation() {
    final now = DateTime.now();

    // First run
    if (_lastEvaluationTime == null) {
      return true;
    }

    // Check if enough time has passed
    final hoursSinceLast = now.difference(_lastEvaluationTime!).inHours;
    return hoursSinceLast >= minEvaluationIntervalHours;
  }

  /// Run the insight evaluation
  Future<List<InsightOutput>> runEvaluation({
    required InsightContext context,
    required List<InsightRule> rules,
    required Map<String, DateTime> lastShownTimes,
    required Set<String> suppressedRuleIds,
  }) async {
    _lastEvaluationTime = DateTime.now();

    // Evaluate all rules
    final insights = await _evaluator.evaluateRules(
      context: context,
      rules: rules,
      lastShownTimes: lastShownTimes,
      suppressedRuleIds: suppressedRuleIds,
    );

    // Sort by priority
    final sortedInsights = _evaluator.sortInsights(insights);

    // Limit to max insights per day
    final limitedInsights = _evaluator.limitInsights(
      sortedInsights,
      maxInsightsPerDay,
    );

    return limitedInsights;
  }

  /// Get the next scheduled evaluation time
  DateTime? getNextEvaluationTime() {
    if (_lastEvaluationTime == null) {
      return DateTime.now();
    }

    return _lastEvaluationTime!.add(
      const Duration(hours: minEvaluationIntervalHours),
    );
  }

  /// Reset the scheduler (for testing)
  void reset() {
    _lastEvaluationTime = null;
  }

  /// Get insights that are still valid (not expired)
  List<InsightOutput> filterValidInsights(List<InsightOutput> insights) {
    final now = DateTime.now();
    return insights.where((insight) {
      // Check if not expired
      if (insight.expiresAt != null && insight.expiresAt!.isBefore(now)) {
        return false;
      }
      // Check if not dismissed
      if (insight.status == InsightStatus.dismissed) {
        return false;
      }
      return true;
    }).toList();
  }

  /// Get insights that should be marked as expired
  List<String> getExpiredInsightIds(List<InsightOutput> insights) {
    final now = DateTime.now();
    return insights
        .where(
          (insight) =>
              insight.expiresAt != null && insight.expiresAt!.isBefore(now),
        )
        .map((insight) => insight.id)
        .toList();
  }
}
