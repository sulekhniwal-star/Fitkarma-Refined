import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../models/insight_rule.dart';
import '../rules/cross_module_rules.dart';

part 'rule_evaluator.g.dart';

/// Evaluates all registered [InsightRule]s against a fresh [InsightContext]
/// and returns up to [maxCards] fired insights sorted by priority.
class RuleEvaluator {
  RuleEvaluator._();

  static const int maxCards = 2;

  /// All registered rules — add new rules here.
  static const List<InsightRule> _registry = [
    WorkoutProteinRule(),
    SleepMoodCorrelationRule(),
    StepsGlucoseRule(),
    RpeSleepBurnoutRule(),
    ProteinGapRule(),
  ];

  /// Loads Drift data for [userId], evaluates all rules, returns top [maxCards].
  static Future<List<InsightOutput>> evaluate({
    required String userId,
    required dynamic db, // AppDatabase
  }) async {
    final now = DateTime.now();
    final thirtyDaysAgo = now.subtract(const Duration(days: 30));

    // ── Drift reads ──────────────────────────────────────────────────────────
    final foodLogs = await db.customSelect(
      'SELECT * FROM food_logs WHERE user_id = ? AND logged_at > ? ORDER BY logged_at DESC LIMIT 200',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final sleepLogs = await db.customSelect(
      'SELECT * FROM sleep_logs WHERE user_id = ? AND date > ? ORDER BY date DESC LIMIT 60',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final workoutLogs = await db.customSelect(
      'SELECT * FROM workout_logs WHERE user_id = ? AND logged_at > ? ORDER BY logged_at DESC LIMIT 60',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final moodLogs = await db.customSelect(
      'SELECT * FROM mood_logs WHERE user_id = ? AND logged_at > ? ORDER BY logged_at DESC',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final bpLogs = await db.customSelect(
      'SELECT * FROM blood_pressure_logs WHERE user_id = ? AND logged_at > ? ORDER BY logged_at DESC LIMIT 30',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final glucoseLogs = await db.customSelect(
      'SELECT * FROM glucose_logs WHERE user_id = ? AND logged_at > ? ORDER BY logged_at DESC LIMIT 60',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    final stepLogs = await db.customSelect(
      'SELECT * FROM step_logs WHERE user_id = ? AND date > ? ORDER BY date DESC LIMIT 60',
      variables: [db.variable(userId), db.variable(thirtyDaysAgo)],
    ).get();

    Map<String, dynamic>? nutritionGoals;
    final goalsResult = await db.customSelect(
      'SELECT * FROM nutrition_goals WHERE user_id = ? ORDER BY updated_at DESC LIMIT 1',
      variables: [db.variable(userId)],
    ).get();
    if (goalsResult.isNotEmpty) {
      nutritionGoals = goalsResult.first.data;
    }

    final context = InsightContext(
      userId: userId,
      today: now,
      recentFoodLogs: foodLogs.map((r) => r.data).toList(),
      recentSleepLogs: sleepLogs.map((r) => r.data).toList(),
      recentWorkoutLogs: workoutLogs.map((r) => r.data).toList(),
      recentMoodLogs: moodLogs.map((r) => r.data).toList(),
      recentBpLogs: bpLogs.map((r) => r.data).toList(),
      recentGlucoseLogs: glucoseLogs.map((r) => r.data).toList(),
      recentStepLogs: stepLogs.map((r) => r.data).toList(),
      nutritionGoals: nutritionGoals,
    );

    // ── Evaluate all rules in parallel ───────────────────────────────────────
    final futures = _registry.map((rule) => _safeEvaluate(rule, context));
    final results = await Future.wait(futures);

    final fired = results.whereType<InsightOutput>().toList();

    // Sort by priority (critical first)
    fired.sort((a, b) => a.priority.index.compareTo(b.priority.index));

    return fired.take(maxCards).toList();
  }

  static Future<InsightOutput?> _safeEvaluate(InsightRule rule, InsightContext ctx) async {
    try {
      return await rule.evaluate(ctx);
    } catch (_) {
      return null; // Never crash the UI due to a rule error
    }
  }
}

/// Riverpod provider that exposes the insight list for a given userId.
@riverpod
Future<List<InsightOutput>> insightEngine(Ref ref, String userId) async {
  if (userId.isEmpty) return [];
  final db = ref.watch(databaseProvider);
  return RuleEvaluator.evaluate(userId: userId, db: db);
}
