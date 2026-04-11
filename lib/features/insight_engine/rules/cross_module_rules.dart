import 'package:flutter/material.dart';
import '../models/insight_rule.dart';

/// Concrete insight rule: low protein on workout days.
class WorkoutProteinRule extends InsightRule {
  const WorkoutProteinRule();

  @override
  String get id => 'workout_protein_gap';

  @override
  String get name => 'Protein gap on workout days';

  @override
  InsightPriority get priority => InsightPriority.normal;

  @override
  InsightModule get module => InsightModule.workout;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentWorkoutLogs.isEmpty) return null;

    final proteinGoal = (ctx.nutritionGoals?['proteinTarget'] as num?)?.toDouble() ?? 60;

    // Days this week when a workout was logged
    final workoutDays = ctx.recentWorkoutLogs
        .map((l) => DateTime.parse(l['logged_at'].toString()))
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    if (workoutDays.isEmpty) return null;

    // Check protein on those days
    int lowProteinDays = 0;
    for (final day in workoutDays) {
      final dayLogs = ctx.recentFoodLogs.where((l) {
        final d = DateTime.parse(l['logged_at'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      });
      final totalProtein = dayLogs.fold(0.0, (sum, l) => sum + ((l['protein_g'] as num?)?.toDouble() ?? 0));
      if (totalProtein < proteinGoal * 0.7) lowProteinDays++;
    }

    if (lowProteinDays < 2) return null;

    return const InsightOutput(
      ruleId: 'workout_protein_gap',
      module: InsightModule.workout,
      priority: InsightPriority.normal,
      titleEn: 'Low protein on workout days',
      titleHi: 'व्यायाम के दिन कम प्रोटीन',
      bodyEn: 'You\'re under-eating protein on most days you work out. Add a bowl of dal, eggs, or paneer post-workout to support muscle recovery.',
      bodyHi: 'जिन दिनों आप व्यायाम करते हैं, उन दिनों प्रोटीन कम है। वर्कआउट के बाद दाल, अंडे या पनीर खाएं।',
      actionLabel: 'Log Food',
      actionRoute: '/food',
      icon: Icons.fitness_center,
      color: Color(0xFFFF6B35),
    );
  }
}

/// Sleep × Mood correlation rule.
class SleepMoodCorrelationRule extends InsightRule {
  const SleepMoodCorrelationRule();

  @override
  String get id => 'sleep_mood_correlation';

  @override
  String get name => 'Poor sleep → low mood pattern';

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  InsightModule get module => InsightModule.crossModule;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentSleepLogs.length < 5 || ctx.recentMoodLogs.length < 5) return null;

    int lowMoodAfterBadSleepCount = 0;

    for (final sleepLog in ctx.recentSleepLogs) {
      final durationMin = (sleepLog['duration_min'] as num?)?.toInt() ?? 480;
      if (durationMin >= 360) continue; // ≥ 6 hours — skip

      final sleepDate = DateTime.parse(sleepLog['date'].toString());
      final nextDay = sleepDate.add(const Duration(days: 1));

      // Check mood next day
      final nextDayMood = ctx.recentMoodLogs.where((m) {
        final d = DateTime.parse(m['logged_at'].toString());
        return d.year == nextDay.year && d.month == nextDay.month && d.day == nextDay.day;
      });

      for (final mood in nextDayMood) {
        final score = (mood['score'] as num?)?.toInt() ?? 5;
        if (score <= 2) lowMoodAfterBadSleepCount++;
      }
    }

    if (lowMoodAfterBadSleepCount < 3) return null;

    return const InsightOutput(
      ruleId: 'sleep_mood_correlation',
      module: InsightModule.crossModule,
      priority: InsightPriority.high,
      titleEn: '😴 Poor sleep is hurting your mood',
      titleHi: 'नींद की कमी मूड को प्रभावित कर रही है',
      bodyEn: 'We noticed you feel low the day after sleeping less than 6 hours — this has happened 3+ times recently. Try a consistent 10 PM bedtime this week.',
      bodyHi: '6 घंटे से कम नींद के बाद आपका मूड खराब रहता है। इस सप्ताह रात 10 बजे सोने की कोशिश करें।',
      actionLabel: 'Track Sleep',
      actionRoute: '/lifestyle/sleep',
      icon: Icons.nights_stay,
      color: Color(0xFF6C3DC8),
    );
  }
}

/// Steps × Glucose correlation rule.
class StepsGlucoseRule extends InsightRule {
  const StepsGlucoseRule();

  @override
  String get id => 'steps_glucose_correlation';

  @override
  String get name => 'Walking improves post-meal glucose';

  @override
  InsightModule get module => InsightModule.crossModule;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentGlucoseLogs.length < 4 || ctx.recentStepLogs.length < 4) return null;

    double activeAvg = 0, sedentaryAvg = 0;
    int activeCount = 0, sedentaryCount = 0;

    for (final glucoseLog in ctx.recentGlucoseLogs) {
      final glucoseDate = DateTime.parse(glucoseLog['logged_at'].toString());
      final day = DateTime(glucoseDate.year, glucoseDate.month, glucoseDate.day);

      final stepEntry = ctx.recentStepLogs.where((s) {
        final d = DateTime.parse(s['date'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      }).firstOrNull;

      final steps = (stepEntry?['count'] as num?)?.toInt() ?? 0;
      final glucose = (glucoseLog['value_mg_dl'] as num?)?.toDouble() ?? 0;

      if (steps >= 8000) {
        activeAvg += glucose;
        activeCount++;
      } else {
        sedentaryAvg += glucose;
        sedentaryCount++;
      }
    }

    if (activeCount == 0 || sedentaryCount == 0) return null;
    activeAvg /= activeCount;
    sedentaryAvg /= sedentaryCount;

    final diff = (sedentaryAvg - activeAvg).round();
    if (diff < 10) return null; // < 10 mg/dL difference — not meaningful

    return InsightOutput(
      ruleId: 'steps_glucose_correlation',
      module: InsightModule.crossModule,
      priority: InsightPriority.high,
      titleEn: '🚶 Walking lowers your glucose by $diff mg/dL',
      titleHi: 'पैदल चलने से आपका ग्लूकोज $diff mg/dL कम होता है',
      bodyEn: 'On days you walk 8,000+ steps, your blood sugar is $diff mg/dL lower on average. A 20-min walk after lunch can make a big difference.',
      bodyHi: 'जिन दिनों आप 8,000+ कदम चलते हैं, उन दिनों ब्लड शुगर $diff mg/dL कम रहता है।',
      actionLabel: 'Track Steps',
      actionRoute: '/steps',
      icon: Icons.directions_walk,
      color: const Color(0xFF2ECC71),
    );
  }
}

/// RPE × Sleep burnout risk rule.
class RpeSleepBurnoutRule extends InsightRule {
  const RpeSleepBurnoutRule();

  @override
  String get id => 'rpe_sleep_burnout';

  @override
  String get name => 'Burnout risk: high RPE + poor sleep';

  @override
  InsightPriority get priority => InsightPriority.high;

  @override
  InsightModule get module => InsightModule.crossModule;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentWorkoutLogs.isEmpty || ctx.recentSleepLogs.isEmpty) return null;

    int consecutiveBurnoutDays = 0;
    final today = ctx.today;

    for (int i = 0; i < 5; i++) {
      final day = today.subtract(Duration(days: i));

      final workouts = ctx.recentWorkoutLogs.where((w) {
        final d = DateTime.parse(w['logged_at'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      });

      final sleepEntry = ctx.recentSleepLogs.where((s) {
        final d = DateTime.parse(s['date'].toString());
        return d.year == day.year && d.month == day.month && d.day == day.day;
      }).firstOrNull;

      final highRpe = workouts.any((w) => ((w['rpe_level'] as num?)?.toDouble() ?? 0) >= 8);
      final poorSleep = sleepEntry != null &&
          ((sleepEntry['quality_score'] as num?)?.toInt() ?? 5) <= 2;

      if (highRpe && poorSleep) {
        consecutiveBurnoutDays++;
      } else {
        break; // Only count consecutive days
      }
    }

    if (consecutiveBurnoutDays < 2) return null;

    return const InsightOutput(
      ruleId: 'rpe_sleep_burnout',
      module: InsightModule.crossModule,
      priority: InsightPriority.high,
      titleEn: '⚠️ Burnout risk detected',
      titleHi: 'थकान का खतरा — आराम करें',
      bodyEn: 'You\'ve had intense workouts with poor sleep for 2+ consecutive days. Take an active recovery day — light yoga or a walk only.',
      bodyHi: 'कई दिनों से तीव्र व्यायाम और खराब नींद है। आज हल्की योग या सैर करें।',
      actionLabel: 'Log Sleep',
      actionRoute: '/lifestyle/sleep',
      icon: Icons.warning_amber,
      color: Color(0xFFE74C3C),
    );
  }
}

/// Fasting × BP correlation rule.
class FastingBpCorrelationRule extends InsightRule {
  const FastingBpCorrelationRule();

  @override
  String get id => 'fasting_bp_correlation';

  @override
  String get name => 'Fasting lowers systolic BP';

  @override
  InsightModule get module => InsightModule.crossModule;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentFastingLogs.isEmpty || ctx.recentBpLogs.isEmpty) return null;

    final fastingDays = ctx.recentFastingLogs
        .where((l) => l['is_completed'] == true)
        .map((l) => DateTime.parse(l['start_time'].toString()))
        .map((d) => DateTime(d.year, d.month, d.day))
        .toSet();

    if (fastingDays.isEmpty) return null;

    double fastingBpAvg = 0, normalBpAvg = 0;
    int fastingCount = 0, normalCount = 0;

    for (final bp in ctx.recentBpLogs) {
      final date = DateTime.parse(bp['logged_at'].toString());
      final day = DateTime(date.year, date.month, date.day);

      if (fastingDays.contains(day)) {
        fastingBpAvg += (bp['systolic'] as num).toDouble();
        fastingCount++;
      } else {
        normalBpAvg += (bp['systolic'] as num).toDouble();
        normalCount++;
      }
    }

    if (fastingCount < 3 || normalCount < 3) return null;

    fastingBpAvg /= fastingCount;
    normalBpAvg /= normalCount;

    final reduction = (normalBpAvg - fastingBpAvg).round();
    if (reduction < 5) return null;

    return InsightOutput(
      ruleId: 'fasting_bp_correlation',
      module: InsightModule.crossModule,
      priority: InsightPriority.normal,
      titleEn: '🧘 Fasting reduces your BP by $reduction mmHg',
      titleHi: 'उपवास से आपका बीपी $reduction mmHg कम होता है',
      bodyEn: 'Your systolic BP is $reduction mmHg lower on days you complete a fast. Consistent intermittent fasting can help manage hypertension.',
      bodyHi: 'उपवास वाले दिनों में आपका बीपी $reduction mmHg कम रहता है।',
      actionLabel: 'Fast Tracker',
      actionRoute: '/lifestyle/fasting',
      icon: Icons.auto_awesome,
      color: const Color(0xFF27AE60),
    );
  }
}

/// Screen Time × Mood correlation rule.
class ScreenTimeMoodRule extends InsightRule {
  const ScreenTimeMoodRule();

  @override
  String get id => 'screen_time_mood';

  @override
  String get name => 'High screen time impacts mood';

  @override
  InsightModule get module => InsightModule.crossModule;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.recentMoodLogs.length < 7) return null;

    int highScreenLowMoodDays = 0;
    for (final mood in ctx.recentMoodLogs) {
      final screenTime = (mood['screen_time_min'] as num?)?.toInt() ?? 0;
      final score = (mood['score'] as num?)?.toInt() ?? 5;

      if (screenTime > 240 && score <= 2) {
        highScreenLowMoodDays++;
      }
    }

    if (highScreenLowMoodDays < 4) return null;

    return const InsightOutput(
      ruleId: 'screen_time_mood',
      module: InsightModule.crossModule,
      priority: InsightPriority.normal,
      titleEn: '📱 Screen time is affecting your mood',
      titleHi: 'स्क्रीन टाइम आपके मूड को प्रभावित कर रहा है',
      bodyEn: 'We noticed a pattern: days with 4+ hours of screen time often lead to lower mood. Try a 1-hour digital detox before bed today.',
      bodyHi: '4+ घंटे स्क्रीन टाइम से आपका मूड खराब रहता है। आज सोने से पहले फोन से दूर रहें।',
      actionLabel: 'Mood Tracker',
      actionRoute: '/lifestyle/mood',
      icon: Icons.phonelink_off,
      color: Color(0xFFE67E22),
    );
  }
}

/// Festival × Calorie spike rule.
class FestivalCalorieRule extends InsightRule {
  const FestivalCalorieRule();

  @override
  String get id => 'festival_calorie_spike';

  @override
  String get name => 'Festival nutrition proactive nudge';

  @override
  InsightModule get module => InsightModule.festival;

  @override
  Future<InsightOutput?> evaluate(InsightContext ctx) async {
    if (ctx.activeFestivals.isEmpty) return null;

    final festival = ctx.activeFestivals.first;
    final name = festival['name_en'] ?? 'Festival';

    return InsightOutput(
      ruleId: 'festival_calorie_nudge',
      module: InsightModule.festival,
      priority: InsightPriority.normal,
      titleEn: '🎉 $name is approaching!',
      titleHi: '🎉 $name आने वाला है!',
      bodyEn: 'With $name ahead, plan your meals to enjoy the festivities while staying on track. A light workout today can help prepare!',
      bodyHi: 'तैयारी शुरू करें! आज हल्का व्यायाम करें ताकि आप उत्सव का आनंद ले सकें।',
      actionLabel: 'View Plan',
      actionRoute: '/festival-calendar',
      icon: Icons.celebration,
      color: const Color(0xFFFFD700),
    );
  }
}
