import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class InsightOutput {
  final String id;
  final String message;

  InsightOutput({required this.id, required this.message});
}

class RuleEvaluator {
  final List<InsightRule> rules;

  RuleEvaluator(this.rules);

  /// Runs all rules in priority order, returns the first 2 whose condition() == true
  Future<List<InsightOutput>> evaluateAll(DriftService db, String userId) async {
    // Sort rules by priority (1 = highest)
    final sortedRules = List<InsightRule>.from(rules)..sort((a, b) => a.priority.compareTo(b.priority));
    
    final List<InsightOutput> results = [];
    
    for (final rule in sortedRules) {
      if (await rule.condition(db, userId)) {
        final message = await rule.message(db, userId);
        results.add(InsightOutput(id: rule.id, message: message));
      }
      
      if (results.length >= 2) break;
    }
    
    return results;
  }
}
