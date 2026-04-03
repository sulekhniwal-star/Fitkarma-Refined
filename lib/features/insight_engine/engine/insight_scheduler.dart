import 'package:fitkarma/features/insight_engine/models/insight_models.dart';
import 'package:fitkarma/features/insight_engine/engine/rule_evaluator.dart';

class InsightScheduler {
  static const int maxInsightsPerDay = 2;
  static const Duration throttleDuration = Duration(hours: 12);

  final Map<String, List<String>> _shownInsights = {};
  final Map<String, DateTime> _lastEvaluation = {};
  final Set<String> _suppressedRules = {};

  Future<bool> canShowInsightsToday(String odUserId) async {
    final today = DateTime.now();
    final dayKey = '${today.year}-${today.month}-${today.day}';
    final shown = _shownInsights[odUserId] ?? [];
    return shown.length < maxInsightsPerDay;
  }

  Future<DateTime?> getLastEvaluationTime(String odUserId) async {
    return _lastEvaluation[odUserId];
  }

  Future<bool> shouldThrottle(String odUserId) async {
    final lastTime = _lastEvaluation[odUserId];
    if (lastTime == null) return false;
    final now = DateTime.now();
    return now.difference(lastTime) < throttleDuration;
  }

  Future<void> recordInsightShown(String odUserId, String ruleId) async {
    final today = DateTime.now();
    final dayKey = '${today.year}-${today.month}-${today.day}';
    _shownInsights.putIfAbsent(odUserId, () => []);
    _shownInsights[odUserId]!.add(ruleId);
    _lastEvaluation[odUserId] = DateTime.now();
  }

  Future<void> recordFeedback(String odUserId, String ruleId, bool isThumbsUp) async {
    if (!isThumbsUp) {
      _suppressedRules.add('$odUserId:$ruleId');
    }
  }

  Future<List<String>> getSuppressedRules(String odUserId) async {
    return _suppressedRules
        .where((s) => s.startsWith('$odUserId:'))
        .map((s) => s.split(':')[1])
        .toList();
  }

  Future<InsightResult> getInsightsForToday(InsightInput input, {int maxInsights = 2}) async {
    final suppressed = await getSuppressedRules(input.odUserId);
    final evaluator = RuleEvaluator();
    
    var allInsights = evaluator.evaluateAll(input);
    allInsights = allInsights.where((i) => !suppressed.contains(i.ruleId)).toList();
    allInsights.sort((a, b) => b.priority.compareTo(a.priority));

    final selected = allInsights.take(maxInsights).toList();

    return InsightResult(
      insights: selected,
      evaluatedAt: DateTime.now(),
    );
  }
}
