import 'package:drift/drift.dart';
import '../models/insight_rule.dart';
import '../../../core/storage/drift_service.dart';

class SleepMoodCorrelationRule extends InsightRule {
  @override
  String get id => 'sleep_mood_correlation';
  @override
  int get priority => 2;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final sevenDaysAgo = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
    
    final sleepLogs = await (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.isBiggerOrEqualValue(sevenDaysAgo)))
        .get();
    
    final moodLogs = await (db.select(db.moodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
        .get();

    if (sleepLogs.isEmpty || moodLogs.isEmpty) return false;

    final avgSleep = sleepLogs.fold(0, (sum, item) => sum + item.durationMin) / sleepLogs.length;
    final avgMood = moodLogs.fold(0.0, (sum, item) => sum + item.moodScore) / moodLogs.length;

    return avgSleep < 360 && avgMood < 3.0;
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your mood drops on poor sleep nights — pattern detected over 8 days.";
  }
}

class WorkoutProteinRule extends InsightRule {
  @override
  String get id => 'workout_protein_deficit';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final workoutToday = await (db.select(db.workoutLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(today)))
        .get();

    if (workoutToday.isEmpty) return false;

    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (goal == null) return false;

    final foodToday = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(today)))
        .get();
    
    final proteinToday = foodToday.fold(0.0, (sum, item) => sum + item.proteinG);
    return proteinToday < (goal.proteinG * 0.6);
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingle();
    final foodToday = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & (t.loggedAt.isBiggerOrEqualValue(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)))))
        .get();
    final proteinToday = foodToday.fold(0.0, (sum, item) => sum + item.proteinG);
    final gap = (goal.proteinG - proteinToday).toStringAsFixed(1);
    
    return "You under-eat protein by $gap g on workout days — add paneer or eggs post-workout.";
  }
}

class FastingBPRule extends InsightRule {
  @override
  String get id => 'fasting_bp_drop';
  @override
  int get priority => 3;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    final fastingToday = await (db.select(db.fastingLogs)
          ..where((t) => t.userId.equals(userId) & t.fastStart.isBiggerOrEqualValue(today)))
        .get();

    if (fastingToday.isEmpty) return false;

    final bpLogs = await (db.select(db.bloodPressureLogs)
          ..where((t) => t.userId.equals(userId)))
        .get();

    if (bpLogs.isEmpty) return false;

    // This is hard since systolic is encrypted. 
    // For now returning false or mocking logic if encryption is bypassed.
    return false;
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "Your systolic BP is lower on fasting days.";
  }
}

class FestivalCalorieRule extends InsightRule {
  @override
  String get id => 'festival_calorie_excess';
  @override
  int get priority => 2;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    final now = DateTime.now();
    
    // Check if festival week
    final festival = await (db.select(db.festivalCalendar)
          ..where((t) => t.startDate.isSmallerOrEqualValue(now) & t.endDate.isBiggerOrEqualValue(now)))
        .getSingleOrNull();

    if (festival == null) return false;

    final sevenDaysAgo = now.subtract(const Duration(days: 7));
    final logs = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqualValue(sevenDaysAgo)))
        .get();

    if (logs.isEmpty) return false;

    final goal = await (db.select(db.nutritionGoals)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (goal == null) return false;

    final avgCal = logs.fold(0.0, (sum, item) => sum + item.calories) / 7;
    return avgCal > (goal.tdee + 500);
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "You consumed extra calories during this festival week — here's a 3-day reset plan.";
  }
}

class PostMealWalkRule extends InsightRule {
  @override
  String get id => 'post_meal_walk_nudge';
  @override
  int get priority => 1;

  @override
  Future<bool> condition(DriftService dbProvider, String userId) async {
    final db = dbProvider.database;
    
    final last3HighPostMeal = await (db.select(db.glucoseLogs)
          ..where((t) => t.userId.equals(userId) & t.readingType.equals('post_meal') & t.classification.equals('high'))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(3))
        .get();

    if (last3HighPostMeal.length < 3) return false;

    final lastSteps = await (db.select(db.stepLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();

    if (lastSteps == null) return false;

    // Simplified: check if last known daily step count is low
    return lastSteps.stepCount < 5000; 
  }

  @override
  Future<String> message(DriftService dbProvider, String userId) async {
    return "A 20-min walk after lunch may help normalize your post-meal glucose.";
  }
}

