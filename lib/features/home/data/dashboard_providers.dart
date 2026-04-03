import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final dashboardDataProvider = FutureProvider.autoDispose<DashboardData>((ref) async {
  final db = ref.watch(driftDatabaseProvider);
  final userId = await _getUserId(db);
  
  if (userId == null) {
    return DashboardData.empty();
  }

  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final todayEnd = todayStart.add(const Duration(days: 1));

  final results = await Future.wait([
    _getUserProfile(db, userId),
    _getTodaySteps(db, userId, todayStart),
    _getTodayCalories(db, userId, todayStart),
    _getTodaySleep(db, userId, todayStart),
    _getTodayMeals(db, userId, todayStart, todayEnd),
    _getTodayWorkouts(db, userId, todayStart, todayEnd),
    _getKarmaTotal(db, userId),
  ]);

  return DashboardData(
    userProfile: results[0] as UserProfile?,
    todaySteps: results[1] as int,
    todayCalories: results[2] as double,
    todaySleepMin: results[3] as int,
    todayMeals: results[4] as List<FoodLog>,
    todayWorkouts: results[5] as List<WorkoutLog>,
    totalKarma: results[6] as int,
  );
});

Future<String?> _getUserId(AppDatabase db) async {
  final profiles = await db.select(db.userProfiles).get();
  return profiles.isEmpty ? null : profiles.first.odUserId;
}

Future<UserProfile?> _getUserProfile(AppDatabase db, String userId) async {
  final query = db.select(db.userProfiles)
    ..where((tbl) => tbl.odUserId.equals(userId));
  final results = await query.get();
  return results.isEmpty ? null : results.first;
}

Future<int> _getTodaySteps(AppDatabase db, String userId, DateTime date) async {
  final query = db.select(db.stepLogs)
    ..where((tbl) => tbl.userId.equals(userId) & tbl.date.isBiggerOrEqualValue(date));
  final logs = await query.get();
  int total = 0;
  for (final log in logs) {
    total += log.steps;
  }
  return total;
}

Future<double> _getTodayCalories(AppDatabase db, String userId, DateTime date) async {
  final query = db.select(db.foodLogs)
    ..where((tbl) => tbl.userId.equals(userId) & tbl.loggedAt.isBiggerOrEqualValue(date));
  final logs = await query.get();
  double total = 0;
  for (final log in logs) {
    total += log.calories;
  }
  return total;
}

Future<int> _getTodaySleep(AppDatabase db, String userId, DateTime date) async {
  final query = db.select(db.sleepLogs)
    ..where((tbl) => tbl.userId.equals(userId) & tbl.date.isBiggerOrEqualValue(date))
    ..orderBy([(tbl) => OrderingTerm.desc(tbl.date)])
    ..limit(1);
  final logs = await query.get();
  return logs.isEmpty ? 0 : logs.first.durationMin;
}

Future<List<FoodLog>> _getTodayMeals(AppDatabase db, String userId, DateTime start, DateTime end) {
  return (db.select(db.foodLogs)
    ..where((tbl) => tbl.userId.equals(userId) & tbl.loggedAt.isBiggerOrEqualValue(start) & tbl.loggedAt.isSmallerThanValue(end)))
    .get();
}

Future<List<WorkoutLog>> _getTodayWorkouts(AppDatabase db, String userId, DateTime start, DateTime end) {
  return (db.select(db.workoutLogs)
    ..where((tbl) => tbl.userId.equals(userId) & tbl.loggedAt.isBiggerOrEqualValue(start) & tbl.loggedAt.isSmallerThanValue(end)))
    .get();
}

Future<int> _getKarmaTotal(AppDatabase db, String userId) async {
  final query = db.select(db.karmaTransactions)
    ..where((tbl) => tbl.userId.equals(userId));
  final transactions = await query.get();
  int total = 0;
  for (final t in transactions) {
    total += t.amount;
  }
  return total;
}

class DashboardData {
  final UserProfile? userProfile;
  final int todaySteps;
  final double todayCalories;
  final int todaySleepMin;
  final List<FoodLog> todayMeals;
  final List<WorkoutLog> todayWorkouts;
  final int totalKarma;

  DashboardData({
    this.userProfile,
    required this.todaySteps,
    required this.todayCalories,
    required this.todaySleepMin,
    required this.todayMeals,
    required this.todayWorkouts,
    required this.totalKarma,
  });

  factory DashboardData.empty() => DashboardData(
    userProfile: null,
    todaySteps: 0,
    todayCalories: 0,
    todaySleepMin: 0,
    todayMeals: [],
    todayWorkouts: [],
    totalKarma: 0,
  );

  String get userName => userProfile?.name ?? 'User';

  int get karmaLevel => (totalKarma / 100).floor() + 1;
  int get karmaXP => totalKarma % 100;
  int get karmaToNextLevel => 100 - karmaXP;

  double get stepsGoal => 10000.0;
  double get caloriesGoal => 2000.0;
  double get sleepGoal => 480.0;
  double get stepsProgress => (todaySteps / stepsGoal).clamp(0.0, 1.0);
  double get caloriesProgress => (todayCalories / caloriesGoal).clamp(0.0, 1.0);
  double get sleepProgress => (todaySleepMin / sleepGoal).clamp(0.0, 1.0);

  List<FoodLog> get breakfast => todayMeals.where((m) => m.mealType == 'breakfast').toList();
  List<FoodLog> get lunch => todayMeals.where((m) => m.mealType == 'lunch').toList();
  List<FoodLog> get dinner => todayMeals.where((m) => m.mealType == 'dinner').toList();
  List<FoodLog> get snacks => todayMeals.where((m) => m.mealType == 'snack').toList();

  double get totalMealCalories {
    double total = 0;
    for (final meal in todayMeals) {
      total += meal.calories;
    }
    return total;
  }

  int get totalWorkoutMinutes {
    int total = 0;
    for (final wo in todayWorkouts) {
      total += wo.durationMin;
    }
    return total;
  }

  double get totalCaloriesBurned {
    double total = 0;
    for (final wo in todayWorkouts) {
      total += wo.caloriesBurned;
    }
    return total;
  }
}