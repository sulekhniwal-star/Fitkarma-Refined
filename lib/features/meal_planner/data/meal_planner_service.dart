// lib/features/meal_planner/data/meal_planner_service.dart
// Meal Planner Service - handles CRUD operations for meal plans

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

/// Service for managing meal plans and entries
class MealPlannerService {
  final AppDatabase db;

  MealPlannerService(this.db);

  /// Get the current week's start date (Monday)
  static DateTime getCurrentWeekStart() {
    final now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(Duration(days: now.weekday - 1));
  }

  /// Create a new meal plan for a week
  Future<String> createMealPlan({
    required String userId,
    required String cuisineRegion,
    DateTime? weekStartDate,
  }) async {
    final id = 'mealplan_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();
    final weekStart = weekStartDate ?? getCurrentWeekStart();

    await db
        .into(db.mealPlans)
        .insert(
          MealPlansCompanion.insert(
            id: id,
            userId: userId,
            weekStartDate: weekStart,
            cuisineRegion: cuisineRegion,
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  /// Get meal plan for a specific week
  Future<MealPlan?> getMealPlan(String userId, DateTime weekStartDate) async {
    return await (db.select(db.mealPlans)..where(
          (t) =>
              t.userId.equals(userId) & t.weekStartDate.equals(weekStartDate),
        ))
        .getSingleOrNull();
  }

  /// Get all meal plan entries for a plan
  Future<List<MealPlanEntry>> getMealPlanEntries(String mealPlanId) async {
    return await (db.select(db.mealPlanEntries)
          ..where((t) => t.mealPlanId.equals(mealPlanId))
          ..orderBy([
            (t) => OrderingTerm.asc(t.date),
            (t) => OrderingTerm.asc(t.mealType),
          ]))
        .get();
  }

  /// Get entries for a specific date
  Future<List<MealPlanEntry>> getEntriesForDate(
    String userId,
    DateTime date,
  ) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return await (db.select(db.mealPlanEntries)..where(
          (t) =>
              t.userId.equals(userId) &
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay),
        ))
        .get();
  }

  /// Add a meal entry to a plan
  Future<String> addMealEntry({
    required String mealPlanId,
    required String userId,
    required DateTime date,
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
    final id = 'mealentry_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    await db
        .into(db.mealPlanEntries)
        .insert(
          MealPlanEntriesCompanion.insert(
            id: id,
            mealPlanId: mealPlanId,
            userId: userId,
            date: date,
            mealType: mealType,
            foodName: foodName,
            foodNameLocal: Value(foodNameLocal),
            foodItemId: Value(foodItemId),
            quantityG: quantityG,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            fiberG: Value(fiberG),
            vitaminDMcg: Value(vitaminDMcg),
            vitaminB12Mcg: Value(vitaminB12Mcg),
            ironMg: Value(ironMg),
            calciumMg: Value(calciumMg),
            region: Value(region),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  /// Update meal entry status (planned, logged, skipped)
  Future<void> updateMealEntryStatus(
    String entryId,
    String status, {
    String? loggedFoodLogId,
  }) async {
    await (db.update(
      db.mealPlanEntries,
    )..where((t) => t.id.equals(entryId))).write(
      MealPlanEntriesCompanion(
        status: Value(status),
        loggedFoodLogId: Value(loggedFoodLogId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Delete a meal entry
  Future<void> deleteMealEntry(String entryId) async {
    await (db.delete(
      db.mealPlanEntries,
    )..where((t) => t.id.equals(entryId))).go();
  }

  /// Get nutrition summary for a meal plan
  Future<Map<String, double>> getPlanNutritionSummary(String mealPlanId) async {
    final entries = await getMealPlanEntries(mealPlanId);

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;
    double totalFiber = 0;
    double totalVitaminD = 0;
    double totalVitaminB12 = 0;
    double totalIron = 0;
    double totalCalcium = 0;

    for (final entry in entries) {
      totalCalories += entry.calories;
      totalProtein += entry.proteinG;
      totalCarbs += entry.carbsG;
      totalFat += entry.fatG;
      totalFiber += entry.fiberG ?? 0;
      totalVitaminD += entry.vitaminDMcg ?? 0;
      totalVitaminB12 += entry.vitaminB12Mcg ?? 0;
      totalIron += entry.ironMg ?? 0;
      totalCalcium += entry.calciumMg ?? 0;
    }

    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
      'fiber': totalFiber,
      'vitaminD': totalVitaminD,
      'vitaminB12': totalVitaminB12,
      'iron': totalIron,
      'calcium': totalCalcium,
    };
  }

  /// Get daily nutrition from a specific date
  Future<Map<String, double>> getDailyNutrition(
    String userId,
    DateTime date,
  ) async {
    final entries = await getEntriesForDate(userId, date);

    double totalCalories = 0;
    double totalProtein = 0;
    double totalCarbs = 0;
    double totalFat = 0;

    for (final entry in entries) {
      totalCalories += entry.calories;
      totalProtein += entry.proteinG;
      totalCarbs += entry.carbsG;
      totalFat += entry.fatG;
    }

    return {
      'calories': totalCalories,
      'protein': totalProtein,
      'carbs': totalCarbs,
      'fat': totalFat,
    };
  }

  /// Delete entire meal plan and its entries
  Future<void> deleteMealPlan(String mealPlanId) async {
    await (db.delete(
      db.mealPlanEntries,
    )..where((t) => t.mealPlanId.equals(mealPlanId))).go();
    await (db.delete(db.mealPlans)..where((t) => t.id.equals(mealPlanId))).go();
  }

  /// Update meal plan cuisine region
  Future<void> updateMealPlanRegion(
    String mealPlanId,
    String cuisineRegion,
  ) async {
    await (db.update(
      db.mealPlans,
    )..where((t) => t.id.equals(mealPlanId))).write(
      MealPlansCompanion(
        cuisineRegion: Value(cuisineRegion),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Get or create current week's meal plan
  Future<MealPlan> getOrCreateCurrentWeekPlan(String userId) async {
    final weekStart = getCurrentWeekStart();
    var plan = await getMealPlan(userId, weekStart);

    if (plan == null) {
      // Get user's preferred cuisine from profile
      final userProfile = await (db.select(
        db.userProfiles,
      )..where((t) => t.userId.equals(userId))).getSingleOrNull();

      final cuisineRegion = userProfile?.dominantDosha ?? 'mixed';
      final planId = await createMealPlan(
        userId: userId,
        cuisineRegion: _getCuisineForDosha(cuisineRegion),
        weekStartDate: weekStart,
      );
      plan = await db.mealPlans.watch().firstWhere((p) => p.id == planId);
    }

    return plan;
  }

  String _getCuisineForDosha(String dosha) {
    switch (dosha.toLowerCase()) {
      case 'vata':
        return 'north_indian'; // Warm, moist foods
      case 'pitta':
        return 'south_indian'; // Cooling foods
      case 'kapha':
        return 'gujarati'; // Light, spicy foods
      default:
        return 'mixed';
    }
  }
}

/// Grocery List Service
class GroceryListService {
  final AppDatabase db;

  GroceryListService(this.db);

  /// Generate grocery list from meal plan
  Future<String> generateGroceryList({
    required String userId,
    String? mealPlanId,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final id = 'grocery_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    // Get all meal entries in the date range
    List<MealPlanEntry> entries;
    if (mealPlanId != null) {
      entries =
          await (db.select(db.mealPlanEntries)..where(
                (t) =>
                    t.mealPlanId.equals(mealPlanId) &
                    t.date.isBiggerOrEqualValue(startDate) &
                    t.date.isSmallerOrEqualValue(endDate),
              ))
              .get();
    } else {
      entries =
          await (db.select(db.mealPlanEntries)..where(
                (t) =>
                    t.userId.equals(userId) &
                    t.date.isBiggerOrEqualValue(startDate) &
                    t.date.isSmallerOrEqualValue(endDate),
              ))
              .get();
    }

    // Aggregate ingredients
    final Map<String, Map<String, dynamic>> ingredientMap = {};
    for (final entry in entries) {
      final key = entry.foodName.toLowerCase();
      if (ingredientMap.containsKey(key)) {
        ingredientMap[key]!['quantityG'] += entry.quantityG;
      } else {
        ingredientMap[key] = {
          'foodName': entry.foodName,
          'foodItemId': entry.foodItemId,
          'quantityG': entry.quantityG,
          'unit': 'g',
          'isPurchased': false,
        };
      }
    }

    final items = jsonEncode(ingredientMap.values.toList());

    await db
        .into(db.groceryLists)
        .insert(
          GroceryListsCompanion.insert(
            id: id,
            userId: userId,
            mealPlanId: Value(mealPlanId),
            name: 'Weekly Grocery List',
            items: items,
            startDate: startDate,
            endDate: endDate,
            createdAt: now,
            updatedAt: now,
          ),
        );

    return id;
  }

  /// Get grocery lists for user
  Future<List<GroceryList>> getUserGroceryLists(String userId) async {
    return await (db.select(db.groceryLists)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Get grocery list items
  Future<List<Map<String, dynamic>>> getGroceryListItems(String listId) async {
    final list = await (db.select(
      db.groceryLists,
    )..where((t) => t.id.equals(listId))).getSingleOrNull();

    if (list == null) return [];

    final itemsJson = list.items;
    return List<Map<String, dynamic>>.from(jsonDecode(itemsJson));
  }

  /// Toggle item purchased status
  Future<void> toggleItemPurchased(String listId, int itemIndex) async {
    final list = await (db.select(
      db.groceryLists,
    )..where((t) => t.id.equals(listId))).getSingleOrNull();

    if (list == null) return;

    final items = List<Map<String, dynamic>>.from(jsonDecode(list.items));
    if (itemIndex >= 0 && itemIndex < items.length) {
      items[itemIndex]['isPurchased'] = !items[itemIndex]['isPurchased'];

      await (db.update(
        db.groceryLists,
      )..where((t) => t.id.equals(listId))).write(
        GroceryListsCompanion(
          items: Value(jsonEncode(items)),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  /// Delete grocery list
  Future<void> deleteGroceryList(String listId) async {
    await (db.delete(db.groceryLists)..where((t) => t.id.equals(listId))).go();
  }
}
