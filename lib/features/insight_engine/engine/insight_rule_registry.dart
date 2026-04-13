import '../models/insight_rule.dart';
import '../rules/nutrition_rules.dart';
import '../rules/sleep_rules.dart';
import '../rules/bp_rules.dart';
import '../rules/glucose_rules.dart';
import '../rules/mood_rules.dart';
import '../rules/fasting_rules.dart';
import '../rules/correlation_rules.dart';
import '../rules/server_rules.dart';
import '../../../core/config/remote_config.dart';

class InsightRuleRegistry {
  static List<InsightRule> getAllRules(RemoteConfigData? config) {
    final rules = <InsightRule>[
      ProteinDeficitRule(),
      MicronutrientGapRule(),
      SleepDebtRule(),
      PoorSleepConsistencyRule(),
      ElevatedBPConsistencyRule(),
      PostMealSpikeRule(),
      LowMoodStreakRule(),
      FastingWindowRule(),
      SleepMoodCorrelationRule(),
      WorkoutProteinRule(),
      FastingBPRule(),
      FestivalCalorieRule(),
      PostMealWalkRule(),
    ];

    if (config != null) {
      rules.addAll(ServerRuleFetcher.getRules(config));
    }

    return rules;
  }
}
