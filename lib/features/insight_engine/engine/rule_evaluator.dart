import 'package:fitkarma/features/insight_engine/models/insight_models.dart';
import 'package:fitkarma/features/insight_engine/rules/nutrition_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/sleep_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/steps_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/hydration_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/workout_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/bp_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/glucose_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/mood_rules.dart';
import 'package:fitkarma/features/insight_engine/rules/cross_module_rules.dart';
import 'package:fitkarma/features/insight_engine/engine/server_rules_service.dart';

class RuleEvaluator {
  final ServerRulesService? _serverRulesService;

  RuleEvaluator({ServerRulesService? serverRulesService})
      : _serverRulesService = serverRulesService;

  List<InsightRule> get allRules => [
    ...nutritionRules,
    ...sleepRules,
    ...stepsRules,
    ...hydrationRules,
    ...workoutRules,
    ...bpRules,
    ...glucoseRules,
    ...moodRules,
    ...crossModuleRules,
  ];

  Future<List<InsightRule>> getMergedRules() async {
    final local = allRules;

    List<InsightRule> serverRules = [];
    if (_serverRulesService != null) {
      try {
        final serverInsightRules = await _serverRulesService.fetchServerRules();
        serverRules = serverInsightRules
            .where((r) => r.isValid)
            .map((r) => r.toInsightRule())
            .toList();
      } catch (_) {
        // Server rules unavailable, use local only
      }
    }

    return [...local, ...serverRules];
  }

  List<InsightRule> getAllRulesWithServer(List<InsightRule> serverRules) {
    return [...allRules, ...serverRules];
  }

  InsightResult evaluate(InsightInput input, {int maxInsights = 2}) {
    final now = DateTime.now();
    final triggeredInsights = <InsightOutput>[];

    for (final rule in allRules) {
      if (rule.condition(input)) {
        triggeredInsights.add(InsightOutput(
          ruleId: rule.id,
          category: rule.category,
          title: rule.title,
          message: rule.message(input),
          icon: rule.icon,
          priority: rule.priority,
          generatedAt: now,
        ));
      }
    }

    triggeredInsights.sort((a, b) => b.priority.compareTo(a.priority));

    final selectedInsights = triggeredInsights.take(maxInsights).toList();

    return InsightResult(
      insights: selectedInsights,
      evaluatedAt: now,
    );
  }

  List<InsightOutput> evaluateAll(InsightInput input) {
    final now = DateTime.now();
    final triggeredInsights = <InsightOutput>[];

    for (final rule in allRules) {
      if (rule.condition(input)) {
        triggeredInsights.add(InsightOutput(
          ruleId: rule.id,
          category: rule.category,
          title: rule.title,
          message: rule.message(input),
          icon: rule.icon,
          priority: rule.priority,
          generatedAt: now,
        ));
      }
    }

    triggeredInsights.sort((a, b) => b.priority.compareTo(a.priority));
    return triggeredInsights;
  }
}
