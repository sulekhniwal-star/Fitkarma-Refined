import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class FastingWindowRule extends InsightRule {
  @override
  String get id => 'fasting_window_approaching';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    
    // Check for active fasting log
    final activeFast = await (db.select(db.fastingLogs)
          ..where((t) => t.userId.equals(userId) & t.fastEnd.isNull() & t.completed.equals(false))
          ..orderBy([(t) => OrderingTerm(expression: t.fastStart, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    if (activeFast == null) return false;

    // Calculate when the eating window starts
    final eatingWindowStart = activeFast.fastStart.add(Duration(minutes: (activeFast.targetDurationHours * 60).toInt()));
    final timeToStart = eatingWindowStart.difference(now);

    // Rule: window opens in ~30 minutes
    return timeToStart.inMinutes > 0 && timeToStart.inMinutes <= 30;
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your eating window opens in 30 minutes. Prepare a hydrating first meal.";
  }
}

