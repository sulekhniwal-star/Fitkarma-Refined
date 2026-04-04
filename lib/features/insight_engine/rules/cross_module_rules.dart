import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/insight_engine/models/insight_models.dart';

final correlationServiceProvider = Provider<CorrelationService>((ref) {
  final db = ref.watch(driftDatabaseProvider);
  return CorrelationService(db);
});

class CorrelationService {
  final AppDatabase _db;

  CorrelationService(this._db);

  Future<SleepMoodCorrelationResult> getSleepMoodCorrelation(String odUserId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final sleepLogs = await (_db.select(_db.sleepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    final moodLogs = await (_db.select(_db.moodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    final sleepByDate = <String, int>{};
    for (final log in sleepLogs) {
      final key = '${log.date.year}-${log.date.month}-${log.date.day}';
      sleepByDate[key] = log.durationMin;
    }

    final moodByDate = <String, int>{};
    for (final log in moodLogs) {
      final key = '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      moodByDate[key] = log.moodScore;
    }

    int patternCount = 0;
    final sortedSleepKeys = sleepByDate.keys.toList()..sort();
    
    for (int i = 0; i < sortedSleepKeys.length - 1; i++) {
      final sleepKey = sortedSleepKeys[i];
      if ((sleepByDate[sleepKey] ?? 480) < 360) {
        final nextDate = DateTime.parse(sleepKey).add(const Duration(days: 1));
        final nextKey = '${nextDate.year}-${nextDate.month}-${nextDate.day}';
        if ((moodByDate[nextKey] ?? 5) <= 2) {
          patternCount++;
        }
      }
    }

    return SleepMoodCorrelationResult(
      patternCount: patternCount,
      hasPattern: patternCount >= 5,
    );
  }

  Future<WorkoutProteinResult> getWorkoutProteinCorrelation(String odUserId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    const goalProtein = 100.0;
    
    final workouts = await (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
      .get();

    if (workouts.isEmpty) {
      return WorkoutProteinResult(hasLowProtein: false, workoutDaysWithLowProtein: 0);
    }

    final workoutDates = workouts.map((w) {
      return '${w.loggedAt.year}-${w.loggedAt.month}-${w.loggedAt.day}';
    }).toSet();

    final foodLogs = await (_db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
      .get();

    final proteinByDate = <String, double>{};
    for (final log in foodLogs) {
      final key = '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      proteinByDate[key] = (proteinByDate[key] ?? 0) + log.proteinG;
    }

    int lowProteinDays = 0;
    for (final date in workoutDates) {
      final protein = proteinByDate[date] ?? 0;
      if (protein < goalProtein * 0.7) {
        lowProteinDays++;
      }
    }

    return WorkoutProteinResult(
      hasLowProtein: lowProteinDays > 0,
      workoutDaysWithLowProtein: lowProteinDays,
    );
  }

  Future<FastingBpResult> getFastingBpCorrelation(String odUserId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final fastingLogs = await (_db.select(_db.fastingLogs)
      ..where((t) => t.userId.equals(odUserId) & t.completed.equals(true) & t.fastStart.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    if (fastingLogs.isEmpty) {
      return FastingBpResult(averageImprovementMmhg: 0, hasImprovement: false);
    }

    final fastingDates = <String>{};
    for (final fast in fastingLogs) {
      final date = fast.fastStart;
      fastingDates.add('${date.year}-${date.month}-${date.day}');
    }

    final bpLogs = await (_db.select(_db.bloodPressureLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    double fastingDaySystolic = 0;
    int fastingDayCount = 0;
    double nonFastingDaySystolic = 0;
    int nonFastingDayCount = 0;

    for (final bp in bpLogs) {
      final key = '${bp.loggedAt.year}-${bp.loggedAt.month}-${bp.loggedAt.day}';
      final systolic = double.tryParse(bp.systolic) ?? 0;
      
      if (systolic > 0) {
        if (fastingDates.contains(key)) {
          fastingDaySystolic += systolic;
          fastingDayCount++;
        } else {
          nonFastingDaySystolic += systolic;
          nonFastingDayCount++;
        }
      }
    }

    if (fastingDayCount == 0 || nonFastingDayCount == 0) {
      return FastingBpResult(averageImprovementMmhg: 0, hasImprovement: false);
    }

    final avgFasting = fastingDaySystolic / fastingDayCount;
    final avgNonFasting = nonFastingDaySystolic / nonFastingDayCount;
    final improvement = avgNonFasting - avgFasting;

    return FastingBpResult(
      averageImprovementMmhg: improvement,
      hasImprovement: improvement >= 5,
    );
  }

  Future<StepsGlucoseResult> getStepsGlucoseCorrelation(String odUserId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    
    final stepLogs = await (_db.select(_db.stepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(sevenDaysAgo)))
      .get();

    final glucoseLogs = await (_db.select(_db.glucoseLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
      .get();

    final stepsByDate = <String, int>{};
    for (final log in stepLogs) {
      final key = '${log.date.year}-${log.date.month}-${log.date.day}';
      stepsByDate[key] = (stepsByDate[key] ?? 0) + log.steps;
    }

    final glucoseByDate = <String, List<double>>{};
    for (final log in glucoseLogs) {
      final key = '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      final val = double.tryParse(log.glucoseMgdl) ?? 0;
      if (val > 0) {
        glucoseByDate.putIfAbsent(key, () => []).add(val);
      }
    }

    double walkingDayGlucose = 0;
    int walkingDayCount = 0;
    double nonWalkingDayGlucose = 0;
    int nonWalkingDayCount = 0;

    for (final entry in glucoseByDate.entries) {
      final avgGlucose = entry.value.reduce((a, b) => a + b) / entry.value.length;
      final steps = stepsByDate[entry.key] ?? 0;
      
      if (steps >= 8000) {
        walkingDayGlucose += avgGlucose;
        walkingDayCount++;
      } else {
        nonWalkingDayGlucose += avgGlucose;
        nonWalkingDayCount++;
      }
    }

    if (walkingDayCount == 0 || nonWalkingDayCount == 0) {
      return StepsGlucoseResult(averageReductionMgdl: 0, hasCorrelation: false);
    }

    final avgWalking = walkingDayGlucose / walkingDayCount;
    final avgNonWalking = nonWalkingDayGlucose / nonWalkingDayCount;
    final reduction = avgNonWalking - avgWalking;

    return StepsGlucoseResult(
      averageReductionMgdl: reduction,
      hasCorrelation: reduction > 0,
    );
  }

  Future<FestivalResult> getUpcomingFestival(String odUserId) async {
    final now = DateTime.now();
    final threeDaysBefore = now.subtract(const Duration(days: 3));

    final query = _db.select(_db.festivalCalendar)
      ..where((t) => t.date.isBiggerOrEqualValue(threeDaysBefore) & t.date.isSmallerOrEqualValue(now.add(const Duration(days: 14))));
    final festivals = await query.get();

    if (festivals.isEmpty) {
      return FestivalResult(hasUpcomingFestival: false, daysUntil: null, festivalName: null);
    }

    final festival = festivals.first;
    final daysUntil = festival.date.difference(now).inDays;

    return FestivalResult(
      hasUpcomingFestival: daysUntil >= -3 && daysUntil <= 3,
      daysUntil: daysUntil,
      festivalName: festival.name,
    );
  }

  Future<RpeSleepBurnoutResult> getRpeSleepBurnoutRisk(String odUserId) async {
    final fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
    
    final workouts = await (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(fiveDaysAgo)))
      .get();

    final sleepLogs = await (_db.select(_db.sleepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(fiveDaysAgo)))
      .get();

    final workoutByDate = <String, int>{};
    for (final w in workouts) {
      final key = '${w.loggedAt.year}-${w.loggedAt.month}-${w.loggedAt.day}';
      workoutByDate[key] = w.rpe ?? w.durationMin ~/ 10;
    }

    final sleepByDate = <String, int>{};
    for (final s in sleepLogs) {
      final key = '${s.date.year}-${s.date.month}-${s.date.day}';
      sleepByDate[key] = s.durationMin;
    }

    int consecutiveDays = 0;
    final now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      final checkDate = now.subtract(Duration(days: i));
      final dateKey = '${checkDate.year}-${checkDate.month}-${checkDate.day}';
      
      final rpe = workoutByDate[dateKey] ?? 0;
      final sleepHours = (sleepByDate[dateKey] ?? 480) / 60;

      if (rpe >= 8 && sleepHours <= 6) {
        consecutiveDays++;
      }
    }

    return RpeSleepBurnoutResult(
      hasBurnoutRisk: consecutiveDays >= 2,
      consecutiveDays: consecutiveDays,
    );
  }

  Future<ScreenTimeMoodResult> getScreenTimeMoodCorrelation(String odUserId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    
    final query = _db.select(_db.moodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo));
    final moodLogs = await query.get();

    final moodByDate = <String, int>{};
    final screenTimeByDate = <String, int>{};
    
    for (final log in moodLogs) {
      final key = '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      moodByDate[key] = log.moodScore;
      screenTimeByDate[key] = log.screenTimeMin ?? 0;
    }

    int lowMoodHighScreenDays = 0;
    int totalDays = 0;

    for (final entry in moodByDate.entries) {
      totalDays++;
      final screenTime = screenTimeByDate[entry.key] ?? 0;
      if (screenTime > 240 && entry.value <= 4) {
        lowMoodHighScreenDays++;
      }
    }

    return ScreenTimeMoodResult(
      hasCorrelation: totalDays >= 7 && lowMoodHighScreenDays >= 5,
      daysWithCorrelation: lowMoodHighScreenDays,
    );
  }
}

class SleepMoodCorrelationResult {
  final int patternCount;
  final bool hasPattern;

  SleepMoodCorrelationResult({required this.patternCount, required this.hasPattern});
}

class WorkoutProteinResult {
  final bool hasLowProtein;
  final int workoutDaysWithLowProtein;

  WorkoutProteinResult({required this.hasLowProtein, required this.workoutDaysWithLowProtein});
}

class FastingBpResult {
  final double averageImprovementMmhg;
  final bool hasImprovement;

  FastingBpResult({required this.averageImprovementMmhg, required this.hasImprovement});
}

class StepsGlucoseResult {
  final double averageReductionMgdl;
  final bool hasCorrelation;

  StepsGlucoseResult({required this.averageReductionMgdl, required this.hasCorrelation});
}

class FestivalResult {
  final bool hasUpcomingFestival;
  final int? daysUntil;
  final String? festivalName;

  FestivalResult({required this.hasUpcomingFestival, this.daysUntil, this.festivalName});
}

class RpeSleepBurnoutResult {
  final bool hasBurnoutRisk;
  final int consecutiveDays;

  RpeSleepBurnoutResult({required this.hasBurnoutRisk, required this.consecutiveDays});
}

class ScreenTimeMoodResult {
  final bool hasCorrelation;
  final int daysWithCorrelation;

  ScreenTimeMoodResult({required this.hasCorrelation, required this.daysWithCorrelation});
}

class SleepMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_sleep_mood';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 75;

  @override
  String get title => 'Sleep-Mood Pattern';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.mood == null) return false;
    return (input.mood!['consecutiveLowMoodDays'] as int? ?? 0) >= 5;
  }

  @override
  String message(InsightInput input) {
    return 'Low sleep often leads to poor mood next day. Prioritize 7+ hours of rest.';
  }

  @override
  String? get icon => '😴';
}

class WorkoutProteinCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_workout_protein';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 70;

  @override
  String get title => 'Post-Workout Protein';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.workout == null || input.nutrition == null) return false;
    final hasWorkout = (input.workout!['count'] as int? ?? 0) > 0;
    final protein = input.nutrition!['protein'] ?? 0;
    return hasWorkout && protein < 70;
  }

  @override
  String message(InsightInput input) {
    return 'You under-eat protein on workout days. Add eggs, paneer, or dal for recovery.';
  }

  @override
  String? get icon => '🥚';
}

class FastingBpCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_fasting_bp';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 60;

  @override
  String get title => 'Fasting Benefits BP';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.bp == null) return false;
    final fasting = input.fastingHours ?? 0;
    final bp = input.bp!['systolic'] as double? ?? 0;
    return fasting >= 16 && bp > 0 && bp < 120;
  }

  @override
  String message(InsightInput input) {
    return 'Your blood pressure is 5+ mmHg lower on fasting days. Keep it up!';
  }

  @override
  String? get icon => '🩺';
}

class StepsGlucoseCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_steps_glucose';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 65;

  @override
  String get title => 'Walking Lowers Sugar';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.steps == null || input.glucose == null) return false;
    final steps = input.steps!['total'] ?? 0;
    final glucose = input.glucose!['mgdl'] ?? 0;
    return steps >= 8000 && glucose > 0 && glucose < 140;
  }

  @override
  String message(InsightInput input) {
    return 'Your blood sugar is lower on days with 8K+ steps. Keep moving!';
  }

  @override
  String? get icon => '🚶';
}

class FestivalCalorieSpikeRule extends InsightRule {
  @override
  String get id => 'cross_festival_calorie';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 80;

  @override
  String get title => 'Festival Prep';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.nutrition == null) return false;
    return (input.nutrition!['calories'] ?? 0) > 2500;
  }

  @override
  String message(InsightInput input) {
    return 'Festival in 3 days! Plan lighter meals to balance the celebrations.';
  }

  @override
  String? get icon => '🪔';
}

class RpeSleepBurnoutRule extends InsightRule {
  @override
  String get id => 'cross_rpe_sleep_burnout';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 90;

  @override
  String get title => 'Burnout Risk';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.workout == null || input.sleep == null) return false;
    final rpe = input.workout!['rpe'] as int? ?? 5;
    final sleepHours = input.sleep!['hours'] ?? 0;
    return rpe >= 8 && sleepHours < 6;
  }

  @override
  String message(InsightInput input) {
    return 'High intensity + poor sleep for 2+ days = burnout risk. Take a rest day.';
  }

  @override
  String? get icon => '🛋️';
}

class ScreenTimeMoodRule extends InsightRule {
  @override
  String get id => 'cross_screen_mood';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 65;

  @override
  String get title => 'Screen Time & Mood';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    if (input.mood == null) return false;
    final mood = input.mood!['score'] as int? ?? 5;
    final screenTime = input.mood!['screenTimeMin'] as int? ?? 0;
    return screenTime > 240 && mood <= 4;
  }

  @override
  String message(InsightInput input) {
    return 'High screen time (>4 hrs) correlates with low mood. Try a digital detox.';
  }

  @override
  String? get icon => '📱';
}

List<InsightRule> get crossModuleRules => [
  SleepMoodCorrelationRule(),
  WorkoutProteinCorrelationRule(),
  FastingBpCorrelationRule(),
  StepsGlucoseCorrelationRule(),
  FestivalCalorieSpikeRule(),
  RpeSleepBurnoutRule(),
  ScreenTimeMoodRule(),
];