// lib/features/dashboard/data/dashboard_providers.dart
// Dashboard data providers - reads from Drift database

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

// ============================================================================
// User ID Provider
// ============================================================================

/// Provider for the current user's ID
final currentUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  return userId ?? '';
});

// ============================================================================
// User Profile Provider
// ============================================================================

/// Provider for user profile from Drift
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) return null;

  final db = ref.watch(databaseProvider);
  final profile = await (db.select(
    db.userProfiles,
  )..where((t) => t.userId.equals(userId))).getSingleOrNull();
  return profile;
});

// ============================================================================
// Karma/XP Provider
// ============================================================================

/// Provider for karma points and level
final karmaStatsProvider = FutureProvider<KarmaStats>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) {
    return KarmaStats(
      xpPoints: 0,
      level: 1,
      title: 'Beginner',
      pointsToNextLevel: 100,
    );
  }

  final db = ref.watch(databaseProvider);
  final profile = await (db.select(
    db.userProfiles,
  )..where((t) => t.userId.equals(userId))).getSingleOrNull();

  if (profile == null) {
    return KarmaStats(
      xpPoints: 0,
      level: 1,
      title: 'Beginner',
      pointsToNextLevel: 100,
    );
  }

  final xp = profile.xpPoints;
  final level = _calculateLevel(xp);
  final title = _getLevelTitle(level);
  final pointsToNext = _getPointsForLevel(level + 1) - xp;

  return KarmaStats(
    xpPoints: xp,
    level: level,
    title: title,
    pointsToNextLevel: pointsToNext > 0 ? pointsToNext : 0,
  );
});

int _calculateLevel(int xp) {
  // Level formula: each level requires progressively more XP
  // Level 1: 0-99, Level 2: 100-299, Level 3: 300-599, etc.
  if (xp < 100) return 1;
  if (xp < 300) return 2;
  if (xp < 600) return 3;
  if (xp < 1000) return 4;
  if (xp < 1500) return 5;
  if (xp < 2100) return 6;
  if (xp < 2800) return 7;
  if (xp < 3600) return 8;
  if (xp < 4500) return 9;
  return 10 + ((xp - 4500) ~/ 1000);
}

String _getLevelTitle(int level) {
  const titles = [
    'Beginner', // 1
    'Health Seeker', // 2
    'Wellness Warrior', // 3
    'Fitness Enthusiast', // 4
    'Health Champion', // 5
    'Wellness Master', // 6
    'Fitness Legend', // 7
    'Health Guru', // 8
    'Wellness Sage', // 9
    'Ayurveda Expert', // 10
  ];
  if (level <= 0) return titles[0];
  if (level > 10) return 'Ayurveda Master';
  return titles[level - 1];
}

int _getPointsForLevel(int level) {
  // Points needed to reach each level
  if (level <= 1) return 0;
  if (level == 2) return 100;
  if (level == 3) return 300;
  if (level == 4) return 600;
  if (level == 5) return 1000;
  if (level == 6) return 1500;
  if (level == 7) return 2100;
  if (level == 8) return 2800;
  if (level == 9) return 3600;
  if (level == 10) return 4500;
  return 4500 + ((level - 10) * 1000);
}

class KarmaStats {
  final int xpPoints;
  final int level;
  final String title;
  final int pointsToNextLevel;

  KarmaStats({
    required this.xpPoints,
    required this.level,
    required this.title,
    required this.pointsToNextLevel,
  });

  double get progressToNextLevel {
    if (pointsToNextLevel <= 0) return 1.0;
    final currentLevelXp = _getPointsForLevel(level);
    final nextLevelXp = _getPointsForLevel(level + 1);
    final xpInCurrentLevel = xpPoints - currentLevelXp;
    final xpNeeded = nextLevelXp - currentLevelXp;
    return (xpInCurrentLevel / xpNeeded).clamp(0.0, 1.0);
  }
}

// ============================================================================
// Activity Rings Data Provider
// ============================================================================

/// Provider for activity ring data (calories, steps, water, active minutes)
final activityRingsProvider = FutureProvider<ActivityRingsData>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) {
    return ActivityRingsData(
      caloriesProgress: 0.0,
      stepsProgress: 0.0,
      waterProgress: 0.0,
      activeMinutesProgress: 0.0,
      caloriesBurned: 0,
      steps: 0,
      waterGlasses: 0,
      activeMinutes: 0,
    );
  }

  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Get today's step count
  final stepLogs =
      await (db.select(db.stepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.date.isSmallerThanValue(todayEnd)))
          .get();
  final totalSteps = stepLogs.fold<int>(0, (sum, log) => sum + log.steps);
  const stepGoal = 10000;

  // Get today's calories from food logs
  final foodLogs =
      await (db.select(db.foodLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.loggedAt.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.loggedAt.isSmallerThanValue(todayEnd)))
          .get();
  final totalCalories = foodLogs.fold<double>(
    0,
    (sum, log) => sum + log.calories,
  );
  // Assume TDEE of 2000 for now (would come from NutritionGoals)
  const calorieGoal = 2000.0;

  // Get today's water intake
  final waterLogs =
      await (db.select(db.waterLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.date.isSmallerThanValue(todayEnd)))
          .get();
  final totalGlasses = waterLogs.fold<int>(0, (sum, log) => sum + log.glasses);
  const waterGoal = 8; // 8 glasses per day

  // Get active minutes from workout logs
  final workoutLogs =
      await (db.select(db.workoutLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.loggedAt.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.loggedAt.isSmallerThanValue(todayEnd)))
          .get();
  final activeMinutes = workoutLogs.fold<int>(
    0,
    (sum, log) => sum + log.durationMin,
  );
  const activeMinutesGoal = 30; // 30 minutes per day

  return ActivityRingsData(
    caloriesProgress: (totalCalories / calorieGoal).clamp(0.0, 1.0),
    stepsProgress: (totalSteps / stepGoal).clamp(0.0, 1.0),
    waterProgress: (totalGlasses / waterGoal).clamp(0.0, 1.0),
    activeMinutesProgress: (activeMinutes / activeMinutesGoal).clamp(0.0, 1.0),
    caloriesBurned: totalCalories.round(),
    steps: totalSteps,
    waterGlasses: totalGlasses,
    activeMinutes: activeMinutes,
  );
});

class ActivityRingsData {
  final double caloriesProgress;
  final double stepsProgress;
  final double waterProgress;
  final double activeMinutesProgress;
  final int caloriesBurned;
  final int steps;
  final int waterGlasses;
  final int activeMinutes;

  ActivityRingsData({
    required this.caloriesProgress,
    required this.stepsProgress,
    required this.waterProgress,
    required this.activeMinutesProgress,
    required this.caloriesBurned,
    required this.steps,
    required this.waterGlasses,
    required this.activeMinutes,
  });
}

// ============================================================================
// Today's Meals Provider
// ============================================================================

/// Provider for today's food logs grouped by meal type
final todayMealsProvider = FutureProvider<List<MealSummary>>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) return [];

  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  final logs =
      await (db.select(db.foodLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.loggedAt.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.loggedAt.isSmallerThanValue(todayEnd)))
          .get();

  // Group by meal type
  final Map<String, List<FoodLog>> mealsByType = {};
  for (final log in logs) {
    mealsByType.putIfAbsent(log.mealType, () => []).add(log);
  }

  // Convert to MealSummary objects
  final mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];
  return mealTypes.map((type) {
    final meals = mealsByType[type] ?? [];
    final totalCalories = meals.fold<double>(
      0,
      (sum, log) => sum + log.calories,
    );
    final totalProtein = meals.fold<double>(
      0,
      (sum, log) => sum + log.proteinG,
    );
    final totalCarbs = meals.fold<double>(0, (sum, log) => sum + log.carbsG);
    final totalFat = meals.fold<double>(0, (sum, log) => sum + log.fatG);

    return MealSummary(
      mealType: type,
      items: meals.map((l) => l.foodName).toList(),
      totalCalories: totalCalories,
      totalProtein: totalProtein,
      totalCarbs: totalCarbs,
      totalFat: totalFat,
      itemCount: meals.length,
    );
  }).toList();
});

class MealSummary {
  final String mealType;
  final List<String> items;
  final double totalCalories;
  final double totalProtein;
  final double totalCarbs;
  final double totalFat;
  final int itemCount;

  MealSummary({
    required this.mealType,
    required this.items,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.itemCount,
  });
}

// ============================================================================
// Latest Workout Provider
// ============================================================================

/// Provider for the latest workout
final latestWorkoutProvider = FutureProvider<WorkoutLog?>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) return null;

  final db = ref.watch(databaseProvider);

  final workout =
      await (db.select(db.workoutLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
            ..limit(1))
          .getSingleOrNull();

  return workout;
});

// ============================================================================
// Sleep Recovery Provider
// ============================================================================

/// Provider for today's sleep data and recovery score
final sleepRecoveryProvider = FutureProvider<SleepRecoveryData?>((ref) async {
  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) return null;

  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);

  final sleepLog =
      await (db.select(db.sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..limit(1))
          .getSingleOrNull();

  if (sleepLog == null) return null;

  // Calculate recovery score based on sleep quality and duration
  // Ideal: 7-9 hours, quality 80%+
  final durationHours = sleepLog.durationMin / 60;
  final qualityScore = sleepLog.qualityScore;

  // Calculate recovery score (0-100)
  double recoveryScore = 0;
  if (durationHours >= 7 && durationHours <= 9) {
    recoveryScore += 50;
  } else if (durationHours >= 6 && durationHours <= 10) {
    recoveryScore += 30;
  } else {
    recoveryScore += 10;
  }

  recoveryScore += (qualityScore * 0.5).clamp(0, 50).toDouble();

  return SleepRecoveryData(
    durationMin: sleepLog.durationMin,
    qualityScore: sleepLog.qualityScore,
    recoveryScore: recoveryScore.round(),
    deepSleepMin: sleepLog.deepSleepMin,
    bedtime: sleepLog.bedtime,
    wakeTime: sleepLog.wakeTime,
  );
});

class SleepRecoveryData {
  final int durationMin;
  final int qualityScore;
  final int recoveryScore;
  final int? deepSleepMin;
  final String bedtime;
  final String wakeTime;

  SleepRecoveryData({
    required this.durationMin,
    required this.qualityScore,
    required this.recoveryScore,
    required this.deepSleepMin,
    required this.bedtime,
    required this.wakeTime,
  });
}

// ============================================================================
// Insight Card Provider
// ============================================================================

/// Provider for the dashboard insight card
final dashboardInsightProvider = FutureProvider<InsightData?>((ref) async {
  // This would integrate with the Insight Engine from Phase 11
  // For now, we'll return a sample insight based on available data

  final userId = await ref.watch(currentUserIdProvider.future);
  if (userId.isEmpty) return null;

  final db = ref.watch(databaseProvider);
  final today = DateTime.now();
  final todayStart = DateTime(today.year, today.month, today.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  // Check if user has logged water today
  final waterLogs =
      await (db.select(db.waterLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.date.isSmallerThanValue(todayEnd)))
          .get();

  if (waterLogs.isEmpty) {
    return InsightData(
      title: 'Stay Hydrated! 💧',
      message:
          'You haven\'t logged any water today. Aim for 8 glasses to stay hydrated and boost your metabolism.',
    );
  }

  // Check recent mood
  final moodLogs =
      await (db.select(db.moodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)])
            ..limit(1))
          .getSingleOrNull();

  if (moodLogs != null && moodLogs.moodScore < 5) {
    return InsightData(
      title: 'Mood Check 🌤️',
      message:
          'Your recent mood seems low. Consider a 10-minute meditation or a short walk to boost your mood.',
    );
  }

  // Check step count
  final stepLogs =
      await (db.select(db.stepLogs)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.date.isBiggerOrEqualValue(todayStart))
            ..where((t) => t.date.isSmallerThanValue(todayEnd)))
          .get();
  final totalSteps = stepLogs.fold<int>(0, (sum, log) => sum + log.steps);

  if (totalSteps < 5000) {
    return InsightData(
      title: 'Step Challenge 🚶',
      message:
          'You\'re at $totalSteps steps today. Try to reach 10,000 for optimal health benefits!',
    );
  }

  // Default insight
  return InsightData(
    title: 'Great Progress! ⭐',
    message:
        'You\'re doing amazing today! Keep up the good work with your health journey.',
  );
});

class InsightData {
  final String title;
  final String message;

  InsightData({required this.title, required this.message});
}

// ============================================================================
// Database Provider
// ============================================================================

/// Provider for the database instance
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database provider must be overridden in main.dart');
});
