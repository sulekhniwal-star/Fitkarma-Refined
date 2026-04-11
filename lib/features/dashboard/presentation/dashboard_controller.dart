import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../festival_calendar/domain/festival_diet_engine.dart';
import '../../wedding/domain/wedding_diet_engine.dart';
import '../../insight_engine/models/insight_rule.dart';
import '../../insight_engine/engine/rule_evaluator.dart';
import '../../dashboard/domain/diet_conflict_resolver.dart';
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
  final Map<String, double> todayMicros;
  final String? micronutrientGapMessage;
  final SleepLog? lastSleep;
  final List<FoodLog> todayMeals;
  final List<WorkoutLog> recentWorkouts;
  final List<InsightOutput> insights;
  final List<FestivalDietConfig> activeFestivals;
  final WeddingDietPlan? activeWeddingPlan;
  final NutritionGoal? nutritionGoal;
  final BloodPressureLog? lastBp;
  final GlucoseLog? lastGlucose;
  final Spo2Log? lastSpo2;
  final DoctorAppointment? nextAppointment;

  DashboardData({
    this.profile,
    this.doshaPercentages = const {},
    this.todaySteps = 0,
    this.todayCalories = 0,
    this.todayProtein = 0,
    this.todayCarbs = 0,
    this.todayFat = 0,
    this.waterGlasses = 0,
    this.todayMicros = const {},
    this.micronutrientGapMessage,
    this.lastSleep,
    this.todayMeals = const [],
    this.recentWorkouts = const [],
    this.insights = const [],
    this.activeFestivals = const [],
    this.activeWeddingPlan,
    this.nutritionGoal,
    this.lastBp,
    this.lastGlucose,
    this.lastSpo2,
    this.nextAppointment,
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

    final results = await Future.wait([
      db.userProfilesDao.getProfile(userId),
      _getTodaySteps(db, userId),
      _getTodayNutrition(db, userId),
      _getLastSleep(db, userId),
      _getRecentWorkouts(db, userId),
      ref.watch(festivalDietProviderProvider.future),
      ref.watch(weddingDietProviderProvider.future),
      db.nutritionGoalsDao.getGoals(userId),
      ref.watch(insightEngineProvider(userId).future),
      ref.watch(dietConflictInsightProvider.future),
      _getLastBp(db, userId),
      _getLastGlucose(db, userId),
      _getLastSpo2(db, userId),
      _getNextAppointment(db, userId),
      db.waterLogsDao.getTodayWater(userId),
    ]);

    final profile = results[0] as UserProfile?;
    final nutrition = results[2] as Map<String, dynamic>;
    final steps = results[1] as int;
    final sleep = results[3] as SleepLog?;
    final workouts = results[4] as List<WorkoutLog>;
    final festivals = results[5] as List<FestivalDietConfig>;
    final weddingPlan = results[6] as WeddingDietPlan?;
    final nutritionGoal = results[7] as NutritionGoal?;
    final rawInsights = results[8] as List<InsightOutput>;
    final conflict = results[9] as ConflictInsight?;
    final lastBp = results[10] as BloodPressureLog?;
    final lastGlucose = results[11] as GlucoseLog?;
    final lastSpo2 = results[12] as Spo2Log?;
    final nextAppointment = results[13] as DoctorAppointment?;
    final waterGlasses = results[14] as double;

    final insights = [...rawInsights];
    if (conflict != null) {
      insights.insert(0, InsightOutput(
        ruleId: 'conflict_resolver',
        module: InsightModule.crossModule,
        priority: conflict.severity == 'high' ? InsightPriority.critical : InsightPriority.high,
        titleEn: conflict.titleEn,
        titleHi: conflict.titleHi,
        bodyEn: conflict.messageEn,
        bodyHi: conflict.messageHi,
        icon: Icons.warning_amber,
        color: conflict.severity == 'high' ? Colors.red : Colors.orange,
      ));
    }



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
      waterGlasses: waterGlasses,
      todayMicros: nutrition['micros'] ?? {},
      micronutrientGapMessage: _calculateMicroGap(nutrition['micros'] ?? {}),
      todayMeals: await _getTodayMeals(db, userId),
      lastSleep: sleep,
      recentWorkouts: workouts,
      activeFestivals: festivals,
      activeWeddingPlan: weddingPlan,
      nutritionGoal: nutritionGoal,
      insights: insights,
      lastBp: lastBp,
      lastGlucose: lastGlucose,
      lastSpo2: lastSpo2,
      nextAppointment: nextAppointment,
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

  Future<Map<String, dynamic>> _getTodayNutrition(AppDatabase db, String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final logs = await (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqual(Variable(startOfDay))))
        .get();

    double calories = 0, protein = 0, carbs = 0, fat = 0;
    double iron = 0, calcium = 0, vitD = 0, vitB12 = 0;

    for (var log in logs) {
      calories += log.calories;
      protein += log.proteinG;
      carbs += log.carbsG;
      fat += log.fatG;
      iron += log.ironMg ?? 0;
      calcium += log.calciumMg ?? 0;
      vitD += log.vitaminDMcg ?? 0;
      vitB12 += log.vitaminB12Mcg ?? 0;
    }
    return {
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'micros': {
        'Iron': iron,
        'Calcium': calcium,
        'Vitamin D': vitD,
        'Vitamin B12': vitB12,
      }
    };
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

  String? _calculateMicroGap(Map<String, double> current) {
    // Standard ICMR targets (simplified)
    final targets = {
      'Iron': 17.0,
      'Calcium': 600.0,
      'Vitamin D': 15.0,
      'Vitamin B12': 2.2,
    };

    String? maxGapName;
    double maxGapPct = 0;
    String? recommendation;

    for (var entry in targets.entries) {
      final key = entry.key;
      final target = entry.value;
      final actual = current[key] ?? 0;
      if (actual < target) {
        final gapPct = (target - actual) / target;
        if (gapPct > maxGapPct) {
          maxGapPct = gapPct;
          maxGapName = key;
          
          final gapVal = target - actual;
          switch (key) {
            case 'Iron': recommendation = "add 100g spinach or 1 katori lentils"; break;
            case 'Calcium': recommendation = "add 1 glass of milk or 50g paneer"; break;
            case 'Vitamin D': recommendation = "spend 15 mins in morning sunlight"; break;
            case 'Vitamin B12': recommendation = "add 1 egg or a bowl of dahi"; break;
          }
          recommendation = "You're ${gapVal.toStringAsFixed(1)} ${key == 'Iron' || key == 'Calcium' ? 'mg' : 'mcg'} $maxGapName short — $recommendation";
        }
      }
    }

    return recommendation;
  }

  Future<BloodPressureLog?> _getLastBp(AppDatabase db, String userId) async {
    return (db.select(db.bloodPressureLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<GlucoseLog?> _getLastGlucose(AppDatabase db, String userId) async {
    return (db.select(db.glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<Spo2Log?> _getLastSpo2(AppDatabase db, String userId) async {
    return (db.select(db.spo2Logs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<DoctorAppointment?> _getNextAppointment(AppDatabase db, String userId) async {
    return (db.select(db.doctorAppointments)
          ..where((t) => t.userId.equals(userId) & t.appointmentDate.isBiggerOrEqualValue(DateTime.now()))
          ..orderBy([(t) => OrderingTerm(expression: t.appointmentDate, mode: OrderingMode.asc)])
          ..limit(1))
        .getSingleOrNull();
  }
}
