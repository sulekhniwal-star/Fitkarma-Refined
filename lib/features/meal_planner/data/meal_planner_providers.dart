// lib/features/meal_planner/data/meal_planner_providers.dart
// Meal Planner providers and state management

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';
import 'package:fitkarma/features/meal_planner/data/meal_planner_service.dart';
import 'package:fitkarma/features/food/data/food_drift_service.dart';

/// Provider for the meal planner service
final mealPlannerServiceProvider = Provider<MealPlannerService>((ref) {
  final db = ref.watch(databaseProvider);
  return MealPlannerService(db);
});

/// Provider for the grocery list service
final groceryListServiceProvider = Provider<GroceryListService>((ref) {
  final db = ref.watch(databaseProvider);
  return GroceryListService(db);
});

/// Provider for current week's meal plan
final currentWeekMealPlanProvider = FutureProvider<MealPlan?>((ref) async {
  final service = ref.watch(mealPlannerServiceProvider);
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();

  if (userId == null) return null;

  return await service.getOrCreateCurrentWeekPlan(userId);
});

/// Provider for meal plan entries
final mealPlanEntriesProvider =
    FutureProvider.family<List<MealPlanEntry>, String>((ref, mealPlanId) async {
      final service = ref.watch(mealPlannerServiceProvider);
      return await service.getMealPlanEntries(mealPlanId);
    });

/// State for the meal planner
class MealPlannerState {
  final MealPlan? currentPlan;
  final List<MealPlanEntry> entries;
  final Map<String, double> dailyNutrition;
  final bool isLoading;
  final String? error;
  final DateTime selectedDate;
  final String cuisineRegion;

  MealPlannerState({
    this.currentPlan,
    this.entries = const [],
    this.dailyNutrition = const {},
    this.isLoading = false,
    this.error,
    DateTime? selectedDate,
    this.cuisineRegion = 'mixed',
  }) : selectedDate = selectedDate ?? DateTime.now();

  MealPlannerState copyWith({
    MealPlan? currentPlan,
    List<MealPlanEntry>? entries,
    Map<String, double>? dailyNutrition,
    bool? isLoading,
    String? error,
    DateTime? selectedDate,
    String? cuisineRegion,
  }) {
    return MealPlannerState(
      currentPlan: currentPlan ?? this.currentPlan,
      entries: entries ?? this.entries,
      dailyNutrition: dailyNutrition ?? this.dailyNutrition,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      selectedDate: selectedDate ?? this.selectedDate,
      cuisineRegion: cuisineRegion ?? this.cuisineRegion,
    );
  }
}

/// Notifier for meal planner state
class MealPlannerNotifier extends Notifier<MealPlannerState> {
  @override
  MealPlannerState build() {
    _loadCurrentPlan();
    return MealPlannerState();
  }

  Future<void> _loadCurrentPlan() async {
    state = state.copyWith(isLoading: true);

    try {
      final service = ref.read(mealPlannerServiceProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) {
        state = state.copyWith(isLoading: false, error: 'User not logged in');
        return;
      }

      final plan = await service.getOrCreateCurrentWeekPlan(userId);
      final entries = await service.getMealPlanEntries(plan.id);

      // Get daily nutrition for selected date
      final dailyNutrition = await service.getDailyNutrition(
        userId,
        state.selectedDate,
      );

      state = state.copyWith(
        currentPlan: plan,
        entries: entries,
        dailyNutrition: dailyNutrition,
        cuisineRegion: plan.cuisineRegion,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Set selected date
  Future<void> setSelectedDate(DateTime date) async {
    state = state.copyWith(selectedDate: date);
    await _loadDailyNutrition();
  }

  Future<void> _loadDailyNutrition() async {
    try {
      final service = ref.read(mealPlannerServiceProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) return;

      final dailyNutrition = await service.getDailyNutrition(
        userId,
        state.selectedDate,
      );

      state = state.copyWith(dailyNutrition: dailyNutrition);
    } catch (e) {
      // Silent fail
    }
  }

  /// Add a meal entry
  Future<void> addMealEntry({
    required String mealType,
    required String foodName,
    String? foodNameLocal,
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
    String? region,
    String? notes,
  }) async {
    if (state.currentPlan == null) return;

    state = state.copyWith(isLoading: true);

    try {
      final service = ref.read(mealPlannerServiceProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) return;

      await service.addMealEntry(
        mealPlanId: state.currentPlan!.id,
        userId: userId,
        date: state.selectedDate,
        mealType: mealType,
        foodName: foodName,
        foodNameLocal: foodNameLocal,
        foodItemId: foodItemId,
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
        region: region,
        notes: notes,
      );

      await _loadCurrentPlan();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Log a planned meal (one-tap log)
  Future<void> logPlannedMeal(MealPlanEntry entry) async {
    state = state.copyWith(isLoading: true);

    try {
      final foodDriftService = ref.read(foodDriftServiceProvider);
      final mealPlannerService = ref.read(mealPlannerServiceProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) return;

      // Create food log
      final logId = await foodDriftService.createFoodLog(
        userId: userId,
        foodItemId: entry.foodItemId,
        foodName: entry.foodName,
        mealType: entry.mealType,
        quantityG: entry.quantityG,
        calories: entry.calories,
        proteinG: entry.proteinG,
        carbsG: entry.carbsG,
        fatG: entry.fatG,
        fiberG: entry.fiberG,
        vitaminDMcg: entry.vitaminDMcg,
        vitaminB12Mcg: entry.vitaminB12Mcg,
        ironMg: entry.ironMg,
        calciumMg: entry.calciumMg,
        loggedAt: state.selectedDate,
        logMethod: 'planner',
      );

      // Update meal entry status
      await mealPlannerService.updateMealEntryStatus(
        entry.id,
        'logged',
        loggedFoodLogId: logId,
      );

      // Award XP
      await _awardXp(15);

      await _loadCurrentPlan();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Skip a planned meal
  Future<void> skipMeal(String entryId) async {
    try {
      final service = ref.read(mealPlannerServiceProvider);
      await service.updateMealEntryStatus(entryId, 'skipped');
      await _loadCurrentPlan();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Delete a meal entry
  Future<void> deleteMealEntry(String entryId) async {
    try {
      final service = ref.read(mealPlannerServiceProvider);
      await service.deleteMealEntry(entryId);
      await _loadCurrentPlan();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Change cuisine region
  Future<void> changeCuisineRegion(String region) async {
    if (state.currentPlan == null) return;

    try {
      final service = ref.read(mealPlannerServiceProvider);
      await service.updateMealPlanRegion(state.currentPlan!.id, region);
      state = state.copyWith(cuisineRegion: region);
      await _loadCurrentPlan();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

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
      // Silent fail
    }
  }

  /// Refresh the plan
  Future<void> refresh() async {
    await _loadCurrentPlan();
  }
}

/// Provider for meal planner state
final mealPlannerProvider =
    NotifierProvider<MealPlannerNotifier, MealPlannerState>(() {
      return MealPlannerNotifier();
    });

/// Provider for grocery lists
final groceryListsProvider = FutureProvider<List<GroceryList>>((ref) async {
  final service = ref.watch(groceryListServiceProvider);
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();

  if (userId == null) return [];

  return await service.getUserGroceryLists(userId);
});

/// Provider for generating grocery list
final generateGroceryListProvider = FutureProvider.family<String, String>((
  ref,
  mealPlanId,
) async {
  final service = ref.watch(groceryListServiceProvider);
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();

  if (userId == null) throw Exception('User not logged in');

  final weekStart = MealPlannerService.getCurrentWeekStart();
  final weekEnd = weekStart.add(const Duration(days: 6));

  return await service.generateGroceryList(
    userId: userId,
    mealPlanId: mealPlanId,
    startDate: weekStart,
    endDate: weekEnd,
  );
});
