import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class LowMoodStreakRule extends InsightRule {
  @override
  String get id => 'low_mood_streak';
  @override
  int get priority => 2;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final sevenDaysAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
    
    final logs = await (db.select(db.moodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
        .get();

    if (logs.isEmpty) return false;

    final avgMood = logs.fold(0.0, (sum, item) => sum + item.moodScore) / logs.length;
    return avgMood < 2.5;
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your mood has been low for a week. Consider talking to someone or trying a 10-min meditation.";
  }
}
