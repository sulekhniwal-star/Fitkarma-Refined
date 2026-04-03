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

  Future<int> countSleepMoodPattern(String odUserId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final sleepLogs = await (_db.select(_db.sleepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    final moodLogs = await (_db.select(_db.moodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    final sleepByDate = <String, double>{};
    for (final log in sleepLogs) {
      final key = '${log.date.year}-${log.date.month}-${log.date.day}';
      sleepByDate[key] = log.durationMin.toDouble() / 60;
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
      if ((sleepByDate[sleepKey] ?? 8) < 6) {
        final nextDate = DateTime.parse(sleepKey).add(const Duration(days: 1));
        final nextKey = '${nextDate.year}-${nextDate.month}-${nextDate.day}';
        if ((moodByDate[nextKey] ?? 5) <= 2) {
          patternCount++;
        }
      }
    }

    return patternCount;
  }

  Future<bool> hasLowProteinOnWorkoutDays(String odUserId) async {
    final recentDays = DateTime.now().subtract(const Duration(days: 7));
    
    final workouts = await (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(recentDays)))
      .get();

    if (workouts.isEmpty) return false;

    final workoutDates = workouts.map((w) => '${w.loggedAt.year}-${w.loggedAt.month}-${w.loggedAt.day}').toSet();
    const goalProtein = 100.0;

    final foodLogs = await (_db.select(_db.foodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(recentDays)))
      .get();

    final proteinByDate = <String, double>{};
    for (final log in foodLogs) {
      final key = '${log.loggedAt.year}-${log.loggedAt.month}-${log.loggedAt.day}';
      proteinByDate[key] = (proteinByDate[key] ?? 0) + log.proteinG;
    }

    for (final date in workoutDates) {
      final protein = proteinByDate[date] ?? 0;
      if (protein < goalProtein * 0.7) {
        return true;
      }
    }

    return false;
  }

  Future<double> getBpImprovementFromFasting(String odUserId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    
    final fastingLogs = await (_db.select(_db.fastingLogs)
      ..where((t) => t.userId.equals(odUserId) & t.fastEnd.isNotNull() & t.fastStart.isBiggerOrEqualValue(thirtyDaysAgo)))
      .get();

    if (fastingLogs.isEmpty) return 0;

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

    if (fastingDayCount == 0 || nonFastingDayCount == 0) return 0;

    final avgFasting = fastingDaySystolic / fastingDayCount;
    final avgNonFasting = nonFastingDaySystolic / nonFastingDayCount;

    return avgNonFasting - avgFasting;
  }

  Future<bool> hasStepsGlucoseCorrelation(String odUserId) async {
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

    if (walkingDayCount == 0 || nonWalkingDayCount == 0) return false;

    return (walkingDayGlucose / walkingDayCount) < (nonWalkingDayGlucose / nonWalkingDayCount);
  }

  Future<DateTime?> getUpcomingFestival(String odUserId) async {
    final now = DateTime.now();
    final threeDaysLater = now.add(const Duration(days: 3));

    final festivals = await (_db.select(_db.festivalCalendar)
      ..where((t) => t.date.isBiggerOrEqualValue(now) & t.date.isSmallerOrEqualValue(threeDaysLater)))
      .get();

    return festivals.isNotEmpty ? festivals.first.date : null;
  }

  Future<bool> hasRpeSleepBurnoutRisk(String odUserId) async {
    final fiveDaysAgo = DateTime.now().subtract(const Duration(days: 5));
    
    final workouts = await (_db.select(_db.workoutLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(fiveDaysAgo)))
      .get();

    final sleepLogs = await (_db.select(_db.sleepLogs)
      ..where((t) => t.userId.equals(odUserId) & t.date.isBiggerOrEqualValue(fiveDaysAgo)))
      .get();

    int consecutiveDays = 0;
    final now = DateTime.now();

    for (int i = 0; i < 5; i++) {
      final checkDate = now.subtract(Duration(days: i));
      final dateKey = '${checkDate.year}-${checkDate.month}-${checkDate.day}';
      
      bool hasHighRpe = false;
      bool hasLowSleep = false;

      for (final w in workouts) {
        final wKey = '${w.loggedAt.year}-${w.loggedAt.month}-${w.loggedAt.day}';
        if (wKey == dateKey) {
          hasHighRpe = w.durationMin >= 45;
        }
      }

      for (final s in sleepLogs) {
        final sKey = '${s.date.year}-${s.date.month}-${s.date.day}';
        if (sKey == dateKey) {
          hasLowSleep = s.durationMin < 360;
        }
      }

      if (hasHighRpe && hasLowSleep) {
        consecutiveDays++;
      } else {
        consecutiveDays = 0;
      }
    }

    return consecutiveDays >= 2;
  }

  Future<bool> hasScreenTimeMoodCorrelation(String odUserId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    
    final moodLogs = await (_db.select(_db.moodLogs)
      ..where((t) => t.userId.equals(odUserId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
      .get();

    return moodLogs.where((l) => l.moodScore <= 4).length >= 5;
  }
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
    return input.mood?['consecutiveLowMoodDays'] != null && 
           (input.mood!['consecutiveLowMoodDays'] as int) >= 5;
  }

  @override
  String message(InsightInput input) {
    return 'Low sleep often leads to poor mood next day. Prioritize rest.';
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
    final workoutCount = input.workout?['count'] ?? 0;
    final protein = input.nutrition?['protein'] ?? 0;
    return workoutCount >= 1 && protein < 70;
  }

  @override
  String message(InsightInput input) {
    return 'You under-eat protein on workout days. Add eggs or paneer.';
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
    final fasting = input.fastingHours ?? 0;
    final bp = input.bp?['systolic'] ?? 0;
    return fasting >= 16 && bp > 0 && bp < 120;
  }

  @override
  String message(InsightInput input) {
    return 'Your blood pressure is lower on fasting days. Keep it up!';
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
    final steps = input.steps?['total'] ?? 0;
    final glucose = input.glucose?['mgdl'] ?? 0;
    return steps >= 8000 && glucose > 0 && glucose < 140;
  }

  @override
  String message(InsightInput input) {
    return 'Your blood sugar is lower on active days. Keep walking!';
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
    final calories = input.nutrition?['calories'] ?? 0;
    return calories > 2500;
  }

  @override
  String message(InsightInput input) {
    return 'High calorie day detected. Plan lighter meals tomorrow to balance.';
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
    final rpe = input.workout?['rpe'] ?? 5;
    final sleep = input.sleep?['hours'] ?? 0;
    return rpe >= 8 && sleep < 6;
  }

  @override
  String message(InsightInput input) {
    return 'High intensity + poor sleep = burnout risk. Take a rest day.';
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
    final mood = input.mood?['score'] ?? 5;
    return mood <= 4;
  }

  @override
  String message(InsightInput input) {
    return 'Mood low lately. Try reducing screen time and going outside.';
  }

  @override
  String? get icon => '📱';
}

class SleepNutritionCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_sleep_nutrition';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 65;

  @override
  String get title => 'Sleep & Nutrition Connection';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final sleepHours = input.sleep?['hours'] ?? 0;
    final calories = input.nutrition?['calories'] ?? 0;
    return sleepHours < 6 && calories > 2000;
  }

  @override
  String message(InsightInput input) => 'Poor sleep + high calories. Better sleep may reduce cravings.';

  @override
  String? get icon => '🌙';
}

class ExerciseMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_exercise_mood';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 60;

  @override
  String get title => 'Exercise Boost';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final workoutCount = input.workout?['count'] ?? 0;
    final mood = input.mood?['score'] ?? 0;
    return workoutCount >= 1 && mood >= 7;
  }

  @override
  String message(InsightInput input) => 'Workout days = better mood! Keep moving.';

  @override
  String? get icon => '🏃';
}

class HydrationBpCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_hydration_bp';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 70;

  @override
  String get title => 'Hydration & BP';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final water = input.water?['ml'] ?? 0;
    final bp = input.bp?['systolic'] ?? 0;
    return water < 1500 && bp > 130;
  }

  @override
  String message(InsightInput input) => 'Low water + high BP. Try increasing hydration.';

  @override
  String? get icon => '💧';
}

class StepsSleepCorrelationRule extends InsightRule {
  @override
  String get id => 'cross_steps_sleep';

  @override
  String get category => 'cross_module';

  @override
  int get priority => 55;

  @override
  String get title => 'Active Days, Better Sleep';

  @override
  bool get isCrossModule => true;

  @override
  bool condition(InsightInput input) {
    final steps = input.steps?['total'] ?? 0;
    final sleep = input.sleep?['hours'] ?? 0;
    return steps > 8000 && sleep < 6;
  }

  @override
  String message(InsightInput input) => 'High steps but poor sleep. Rest is as important as activity.';

  @override
  String? get icon => '👟';
}

List<InsightRule> get crossModuleRules => [
  SleepMoodCorrelationRule(),
  WorkoutProteinCorrelationRule(),
  FastingBpCorrelationRule(),
  StepsGlucoseCorrelationRule(),
  FestivalCalorieSpikeRule(),
  RpeSleepBurnoutRule(),
  ScreenTimeMoodRule(),
  SleepNutritionCorrelationRule(),
  ExerciseMoodCorrelationRule(),
  HydrationBpCorrelationRule(),
  StepsSleepCorrelationRule(),
];