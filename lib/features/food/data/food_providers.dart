// lib/features/food/data/food_providers.dart
// Food feature providers and state management

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/dashboard/data/dashboard_providers.dart';
import 'package:fitkarma/features/food/data/food_drift_service.dart';
import 'package:fitkarma/features/food/data/food_aw_service.dart';
import 'package:fitkarma/features/food/data/food_repository.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';

/// Provider for the food drift service
final foodDriftServiceProvider = Provider<FoodDriftService>((ref) {
  final db = ref.watch(databaseProvider);
  return FoodDriftService(db);
});

/// Provider for the food Appwrite service
final foodAwServiceProvider = Provider<FoodAwService>((ref) {
  return FoodAwService();
});

/// Provider for the food repository
final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepository(
    driftService: ref.watch(foodDriftServiceProvider),
    awService: ref.watch(foodAwServiceProvider),
    authService: AuthAwService(),
    connectivityService: ConnectivityService.instance,
  );
});

/// Meal types enum
enum MealType { breakfast, lunch, dinner, snack }

extension MealTypeExtension on MealType {
  String get displayName {
    switch (this) {
      case MealType.breakfast:
        return 'Breakfast';
      case MealType.lunch:
        return 'Lunch';
      case MealType.dinner:
        return 'Dinner';
      case MealType.snack:
        return 'Snack';
    }
  }

  String get hindiName {
    switch (this) {
      case MealType.breakfast:
        return 'नाश्ता';
      case MealType.lunch:
        return 'दोपहर का भोजन';
      case MealType.dinner:
        return 'रात का खाना';
      case MealType.snack:
        return 'स्नैक';
    }
  }

  String get emoji {
    switch (this) {
      case MealType.breakfast:
        return '🌅';
      case MealType.lunch:
        return '☀️';
      case MealType.dinner:
        return '🌙';
      case MealType.snack:
        return '🍿';
    }
  }
}

/// State for the food log screen
class FoodLogState {
  final List<FoodLog> todayLogs;
  final List<FoodLog> frequentItems;
  final bool isLoading;
  final String? error;
  final MealType selectedMealType;
  final String searchQuery;
  final Map<String, double> dailyNutrition;
  final bool isSearching;

  FoodLogState({
    this.todayLogs = const [],
    this.frequentItems = const [],
    this.isLoading = false,
    this.error,
    this.selectedMealType = MealType.breakfast,
    this.searchQuery = '',
    this.dailyNutrition = const {},
    this.isSearching = false,
  });

  FoodLogState copyWith({
    List<FoodLog>? todayLogs,
    List<FoodLog>? frequentItems,
    bool? isLoading,
    String? error,
    MealType? selectedMealType,
    String? searchQuery,
    Map<String, double>? dailyNutrition,
    bool? isSearching,
  }) {
    return FoodLogState(
      todayLogs: todayLogs ?? this.todayLogs,
      frequentItems: frequentItems ?? this.frequentItems,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedMealType: selectedMealType ?? this.selectedMealType,
      searchQuery: searchQuery ?? this.searchQuery,
      dailyNutrition: dailyNutrition ?? this.dailyNutrition,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}

/// Notifier for food log state - using Riverpod 3.x Notifier
class FoodLogNotifier extends Notifier<FoodLogState> {
  @override
  FoodLogState build() {
    // Load initial data
    loadTodayLogs();
    loadFrequentItems();
    return FoodLogState();
  }

  /// Load today's food logs
  Future<void> loadTodayLogs() async {
    state = state.copyWith(isLoading: true);
    try {
      final repository = ref.read(foodRepositoryProvider);
      final logs = await repository.getFoodLogsByDate(DateTime.now());

      // Get daily nutrition summary
      final nutrition = await repository.getDailyNutritionSummary(
        DateTime.now(),
      );

      state = state.copyWith(
        todayLogs: logs,
        dailyNutrition: nutrition,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Load frequent items for the user
  Future<void> loadFrequentItems() async {
    try {
      final repository = ref.read(foodRepositoryProvider);
      final logs = await repository.getUserFoodLogs();

      state = state.copyWith(frequentItems: logs.take(10).toList());
    } catch (e) {
      // Silent fail for frequent items
    }
  }

  /// Set selected meal type
  void setMealType(MealType mealType) {
    state = state.copyWith(selectedMealType: mealType);
  }

  /// Log a food item
  Future<void> logFood({
    required String foodName,
    String? foodItemId,
    required double quantityG,
    required double calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    double? fiberG,
    double? vitaminDMcg,
    double? vitaminB12Mcg,
    double? ironMg,
    double? calciumMg,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(foodRepositoryProvider);
      await repository.createFoodLog(
        foodName: foodName,
        foodItemId: foodItemId,
        mealType: state.selectedMealType.displayName.toLowerCase(),
        quantityG: quantityG,
        calories: calories,
        proteinG: proteinG,
        carbsG: carbsG,
        fatG: fatG,
        fiberG: fiberG,
        vitaminDMcg: vitaminDMcg,
        vitaminB12Mcg: vitaminB12Mcg,
        ironMg: ironMg,
        calciumMg: calciumMg,
        logMethod: 'manual',
      );

      // Award XP
      await _awardXp(10);

      // Reload logs
      await loadTodayLogs();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Award XP to user
  Future<void> _awardXp(int xpAmount) async {
    try {
      final db = ref.read(databaseProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) return;

      final profile = await (db.select(
        db.userProfiles,
      )..where((t) => t.userId.equals(userId))).getSingleOrNull();

      if (profile != null) {
        final newXp = profile.xpPoints + xpAmount;
        await (db.update(db.userProfiles)
              ..where((t) => t.userId.equals(userId)))
            .write(UserProfilesCompanion(xpPoints: Value(newXp)));
      }
    } catch (e) {
      // Silent fail for XP
    }
  }

  /// Delete a food log
  Future<void> deleteLog(String logId) async {
    try {
      final repository = ref.read(foodRepositoryProvider);
      await repository.deleteFoodLog(logId);
      await loadTodayLogs();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Copy yesterday's meals
  Future<void> copyYesterdayMeals() async {
    state = state.copyWith(isLoading: true);

    try {
      final repository = ref.read(foodRepositoryProvider);
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      final yesterdayLogs = await repository.getFoodLogsByDate(yesterday);

      for (final log in yesterdayLogs) {
        await repository.createFoodLog(
          foodName: log.foodName,
          foodItemId: log.foodItemId,
          mealType: log.mealType,
          quantityG: log.quantityG,
          calories: log.calories,
          proteinG: log.proteinG,
          carbsG: log.carbsG,
          fatG: log.fatG,
          fiberG: log.fiberG,
          vitaminDMcg: log.vitaminDMcg,
          vitaminB12Mcg: log.vitaminB12Mcg,
          ironMg: log.ironMg,
          calciumMg: log.calciumMg,
          logMethod: 'copied',
        );
      }

      // Award extra XP for copying meals
      await _awardXp(5);

      await loadTodayLogs();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

/// Provider for food log state
final foodLogProvider = NotifierProvider<FoodLogNotifier, FoodLogState>(() {
  return FoodLogNotifier();
});

/// Provider for daily nutrition goals
final nutritionGoalsProvider = FutureProvider<NutritionGoal?>((ref) async {
  final db = ref.watch(databaseProvider);
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();

  if (userId == null) return null;

  return await (db.select(
    db.nutritionGoals,
  )..where((t) => t.userId.equals(userId))).getSingleOrNull();
});

/// Calculate scaled nutrients based on portion
Map<String, double> calculateScaledNutrients({
  required double portionGrams,
  required double baseCaloriesPer100g,
  required double baseProteinPer100g,
  required double baseCarbsPer100g,
  required double baseFatPer100g,
  double? baseFiberPer100g,
  double? baseVitaminDPer100g,
  double? baseVitaminB12Per100g,
  double? baseIronPer100g,
  double? baseCalciumPer100g,
}) {
  final scale = portionGrams / 100;

  return {
    'calories': baseCaloriesPer100g * scale,
    'protein': baseProteinPer100g * scale,
    'carbs': baseCarbsPer100g * scale,
    'fat': baseFatPer100g * scale,
    'fiber': (baseFiberPer100g ?? 0) * scale,
    'vitaminD': (baseVitaminDPer100g ?? 0) * scale,
    'vitaminB12': (baseVitaminB12Per100g ?? 0) * scale,
    'iron': (baseIronPer100g ?? 0) * scale,
    'calcium': (baseCalciumPer100g ?? 0) * scale,
  };
}
