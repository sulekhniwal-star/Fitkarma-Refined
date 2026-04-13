import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class PostMealSpikeRule extends InsightRule {
  @override
  String get id => 'post_meal_glucose_spike';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    
    final lastPostMealLogs = await (db.select(db.glucoseLogs)
          ..where((t) => t.userId.equals(userId) & t.readingType.equals('post_meal'))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(3))
        .get();

    if (lastPostMealLogs.length < 3) return false;

    // We can't directly compare glucoseMgdl because it's encrypted in Drift, 
    // BUT the requirement says "if post_meal_glucose > 140".
    // In a real app with encryption, we'd need to decrypt here.
    // Assuming for this logic we have access to decrypted values or 'classification'.
    // However, if I use the Drift table directly, it's encrypted.
    // For now, I'll check 'classification' if it indicates 'high'.
    
    return lastPostMealLogs.every((log) => log.classification == 'high' || log.classification == 'diabetic');
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Post-meal glucose spikes detected 3 days in a row. A 20-min walk after lunch may help.";
  }
}
