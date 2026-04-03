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

class RuleEvaluator {
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
