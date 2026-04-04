import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../../core/utils/ayur_utils.dart';

part 'dashboard_controller.g.dart';

class DashboardData {
  final UserProfile? profile;
  final Map<String, double> doshaPercentages;
  final int todaySteps;
  final double todayCalories;
  final double todayProtein;
  final double todayCarbs;
  final double todayFat;
  final double waterGlasses;
  final SleepLog? lastSleep;
  final List<FoodLog> todayMeals;
  final List<WorkoutLog> recentWorkouts;

  DashboardData({
    this.profile,
    this.doshaPercentages = const {},
    this.todaySteps = 0,
    this.todayCalories = 0,
    this.todayProtein = 0,
    this.todayCarbs = 0,
    this.todayFat = 0,
    this.waterGlasses = 0,
    this.lastSleep,
    this.todayMeals = const [],
    this.recentWorkouts = const [],
  });
}

@riverpod
class DashboardController extends _$DashboardController {
  @override
  Future<DashboardData> build() async {
    final user = await ref.watch(currentUserProvider.future);
    if (user == null) return DashboardData();

    final db = ref.read(databaseProvider);
    final userId = user.$id;

    // Fetch in parallel for <1s load
    final results = await Future.wait([
      db.userProfilesDao.getProfile(userId),
      _getTodaySteps(db, userId),
      _getTodayNutrition(db, userId),
      _getLastSleep(db, userId),
      _getRecentWorkouts(db, userId),
    ]);

    final profile = results[0] as UserProfile?;
    final steps = results[1] as int;
    final nutrition = results[2] as Map<String, double>;
    final sleep = results[3] as SleepLog?;
    final workouts = results[4] as List<WorkoutLog>;

    Map<String, double> doshaPercentages = {};
    if (profile?.doshaScores != null) {
      try {
        final scores = AyurUtils.decodeScores(profile!.doshaScores!);
        doshaPercentages = AyurUtils.calculateDoshaPercentages(scores);
      } catch (_) {}
    }

    return DashboardData(
      profile: profile,
      doshaPercentages: doshaPercentages,
      todaySteps: steps,
      todayCalories: nutrition['calories'] ?? 0,
      todayProtein: nutrition['protein'] ?? 0,
      todayCarbs: nutrition['carbs'] ?? 0,
      todayFat: nutrition['fat'] ?? 0,
      todayMeals: await _getTodayMeals(db, userId),
      lastSleep: sleep,
      recentWorkouts: workouts,
    );
  }

  Future<int> _getTodaySteps(AppDatabase db, String userId) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final log = await (db.select(db.stepLogs)
          ..where((t) => t.userId.equals(userId) & t.date.equals(today)))
        .getSingleOrNull();
    return log?.count ?? 0;
  }

  Future<Map<String, double>> _getTodayNutrition(AppDatabase db, String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final logs = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqual(Variable(startOfDay))))
        .get();

    double calories = 0, protein = 0, carbs = 0, fat = 0;
    for (var log in logs) {
      calories += log.calories;
      protein += log.proteinG;
      carbs += log.carbsG;
      fat += log.fatG;
    }
    return {'calories': calories, 'protein': protein, 'carbs': carbs, 'fat': fat};
  }

  Future<List<FoodLog>> _getTodayMeals(AppDatabase db, String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqual(Variable(startOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();
  }

  Future<SleepLog?> _getLastSleep(AppDatabase db, String userId) async {
    return (db.select(db.sleepLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.date)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<WorkoutLog>> _getRecentWorkouts(AppDatabase db, String userId) async {
    return (db.select(db.workoutLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(3))
        .get();
  }
}
