import 'package:flutter/foundation.dart';
import 'package:workmanager/workmanager.dart';
import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import 'rule_evaluator.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';

import '../rules/server_rules.dart';
import 'insight_rule_registry.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final userId = inputData?['userId'] as String?;
    if (userId == null) return Future.value(true);

    try {
      await DriftService.init();
      final db = DriftService.db;
      
      // Load static rules + server rules (if any cached)
      // Since we don't have Ref here, we can't easily watch the provider, 
      // but we can manually instantiate the config from cache if needed.
      final rules = InsightRuleRegistry.getAllRules(null); 
      
      final scheduler = InsightScheduler(db, rules); 
      await scheduler.runEvaluation(userId);
      return Future.value(true);
    } catch (e) {
      debugPrint('Insight background task failed: $e');
      return Future.value(false);
    }
  });
}

class InsightScheduler {
  final AppDatabase db;
  final List<InsightRule> rules;

  InsightScheduler(this.db, this.rules);

  static const String taskName = "com.fitkarma.insight_engine_task";
  static const String _lastRunKey = 'insight_engine_last_run';

  /// Initializes WorkManager and registers periodic task
  Future<void> initialize(String userId) async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: kDebugMode,
    );

    await Workmanager().registerPeriodicTask(
      "insight_periodic_task",
      taskName,
      frequency: const Duration(hours: 24),
      inputData: {'userId': userId},
      constraints: Constraints(
        networkType: NetworkType.connected,
      ),
    );

    // Call check on foreground
    await checkAndRunForeground(userId);
  }

  /// Runs on app foreground if last run > 20h ago
  Future<void> checkAndRunForeground(String userId) async {
    final lastRunEntry = await (db.select(db.remoteConfigCache)
          ..where((t) => t.key.equals(_lastRunKey)))
        .getSingleOrNull();

    final lastRun = lastRunEntry?.lastUpdated ?? DateTime(1970);
    final now = DateTime.now();

    if (now.difference(lastRun).inHours > 20) {
      await runEvaluation(userId);
    }
  }

  /// Core evaluation logic with throttling, deduplication, and suppression
  Future<void> runEvaluation(String userId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    // 1. Throttling: max 2 insight cards surfaced per day
    final logsToday = await (db.select(db.insightLogs)
          ..where((t) => t.userId.equals(userId) & t.shownAt.isBiggerOrEqualValue(today)))
        .get();

    if (logsToday.length >= 2) return;

    // 2. Deduplicate: never shows the same insight id twice in the same day
    final shownTodayIds = logsToday.map((e) => e.insightId).toSet();

    // 3. User ratings: suppress rules with > 3 thumbs-down from the same user
    final negativeRatingCounts = await _getNegativeRatingCounts(userId);
    final suppressedIds = negativeRatingCounts.entries
        .where((e) => e.value > 3)
        .map((e) => e.key)
        .toSet();

    // 4. Filter rules
    final eligibleRules = rules.where((r) => 
      !shownTodayIds.contains(r.id) && 
      !suppressedIds.contains(r.id)
    ).toList();

    if (eligibleRules.isEmpty) return;

    // 5. Evaluate
    final evaluator = RuleEvaluator(eligibleRules);
    final results = await evaluator.evaluateAll(DriftService(db), userId);

    // 6. Capture surfaced insights (respecting daily limit of 2)
    final availableSlots = 2 - logsToday.length;
    for (final result in results.take(availableSlots)) {
      await db.into(db.insightLogs).insert(InsightLogsCompanion.insert(
        userId: userId,
        insightId: result.id,
        shownAt: now,
      ));
    }

    // 7. Update last run timestamp in Drift (using RemoteConfigCache as a general KV store)
    await db.into(db.remoteConfigCache).insertOnConflictUpdate(RemoteConfigCacheCompanion.insert(
      key: _lastRunKey,
      value: 'LAST_RUN_SUCCESS',
      type: 'timestamp',
      lastUpdated: now,
    ));
  }

  Future<Map<String, int>> _getNegativeRatingCounts(String userId) async {
    final ratings = await (db.select(db.insightRatings)
          ..where((t) => t.userId.equals(userId) & t.rating.equals(-1)))
        .get();
    
    final counts = <String, int>{};
    for (final r in ratings) {
      counts[r.insightId] = (counts[r.insightId] ?? 0) + 1;
    }
    return counts;
  }

  /// Stores user ratings (👍/👎) in Drift
  Future<void> storeRating(String userId, String insightId, bool isPositive) async {
    await db.into(db.insightRatings).insert(InsightRatingsCompanion.insert(
      userId: userId,
      insightId: insightId,
      rating: isPositive ? 1 : -1,
      ratedAt: DateTime.now(),
    ));
  }
}
