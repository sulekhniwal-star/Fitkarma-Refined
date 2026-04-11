import 'package:flutter/material.dart';
import '../models/insight_rule.dart';

/// Rule for cumulative sleep debt.
class SleepDebtRule extends InsightRule {
  const SleepDebtRule();

  @override
  String get id => 'sleep_debt';

  @override
  String get name => 'Cumulative weekly sleep debt';

  @override
  InsightModule get module => InsightModule.sleep;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    const targetMin = 480; // 8 hours
    int totalDebt = 0;
    int loggedDays = 0;

    for (int i = 0; i < 7; i++) {
      final day = ctx.today.subtract(Duration(days: i));
      final sleepLog = ctx.recentSleepLogs.where((s) {
        final d = DateTime.parse(s['date'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      }).firstOrNull;

      if (sleepLog != null) {
        loggedDays++;
        final duration = (sleepLog['duration_min'] as num?)?.toInt() ?? 0;
        if (duration < targetMin) {
          totalDebt += (targetMin - duration);
        }
      }
    }

    if (loggedDays < 4 || totalDebt < 300) return null; // > 5 hours debt

    final hours = (totalDebt / 60).toStringAsFixed(1);

    return InsightOutput(
      ruleId: 'sleep_debt',
      module: InsightModule.sleep,
      priority: InsightPriority.high,
      titleEn: '😴 High Sleep Debt: $hours hrs',
      titleHi: 'नींद की भारी कमी: $hours घंटे',
      bodyEn: 'You\'ve missed about $hours hours of sleep this week. Cumulative debt affects focus and recovery. Try to sleep 30 mins earlier tonight.',
      bodyHi: 'इस सप्ताह आपकी नींद में $hours घंटे की कमी रही है। आज रात 30 मिनट पहले सोने की कोशिश करें।',
      actionLabel: 'Sleep Tracker',
      actionRoute: '/lifestyle/sleep',
      icon: Icons.nights_stay,
      color: const Color(0xFF9B59B6),
    );
  }
}

/// Rule for sleep consistency (wake time variance).
class SleepConsistencyRule extends InsightRule {
  const SleepConsistencyRule();

  @override
  String get id => 'sleep_consistency';

  @override
  String get name => 'Sleep consistency (wake time variance)';

  @override
  InsightModule get module => InsightModule.sleep;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentSleepLogs.length < 5) return null;

    final wakeTimes = ctx.recentSleepLogs.take(5).map((s) {
      final parts = (s['wake_time'] as String).split(':');
      return int.parse(parts[0]) * 60 + int.parse(parts[1]);
    }).toList();

    // Calculate variance (roughly)
    int minTime = wakeTimes.reduce((a, b) => a < b ? a : b);
    int maxTime = wakeTimes.reduce((a, b) => a > b ? a : b);

    if (maxTime - minTime < 90) return null; // Variance < 1.5 hours — good

    return const InsightOutput(
      ruleId: 'sleep_consistency',
      module: InsightModule.sleep,
      priority: InsightPriority.normal,
      titleEn: '⏰ Inconsistent Wake Times',
      titleHi: 'उठने का समय अनियमित है',
      bodyEn: 'Your wake-up time has varied by over 90 mins recently. A consistent circadian rhythm improves energy levels. Try for ±15 mins each day.',
      bodyHi: 'हाल ही में आपके जागने का समय बहुत बदला है। एक निश्चित समय पर जागने से ऊर्जा बढ़ती है।',
      actionLabel: 'View Trends',
      actionRoute: '/lifestyle/sleep',
      icon: Icons.alarm,
      color: Color(0xFF3498DB),
    );
  }
}
