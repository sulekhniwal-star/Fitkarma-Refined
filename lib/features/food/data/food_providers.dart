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
import 'package:fitkarma/features/food/data/recipe_service.dart';

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

// ============== RECIPE PROVIDERS ==============

/// Provider for the recipe service
final recipeServiceProvider = Provider<RecipeService>((ref) {
  final db = ref.watch(databaseProvider);
  return RecipeService(db);
});

/// State for recipe builder
class RecipeBuilderState {
  final String title;
  final String? description;
  final List<RecipeIngredient> ingredients;
  final List<String> instructions;
  final int servings;
  final double caloriesPerServing;
  final double proteinPerServing;
  final double carbsPerServing;
  final double fatPerServing;
  final double? fiberPerServing;
  final double? vitaminDPerServing;
  final double? vitaminB12PerServing;
  final double? ironPerServing;
  final double? calciumPerServing;
  final bool isPublic;
  final bool isLoading;
  final String? error;

  RecipeBuilderState({
    this.title = '',
    this.description,
    this.ingredients = const [],
    this.instructions = const [],
    this.servings = 1,
    this.caloriesPerServing = 0,
    this.proteinPerServing = 0,
    this.carbsPerServing = 0,
    this.fatPerServing = 0,
    this.fiberPerServing,
    this.vitaminDPerServing,
    this.vitaminB12PerServing,
    this.ironPerServing,
    this.calciumPerServing,
    this.isPublic = false,
    this.isLoading = false,
    this.error,
  });

  RecipeBuilderState copyWith({
    String? title,
    String? description,
    List<RecipeIngredient>? ingredients,
    List<String>? instructions,
    int? servings,
    double? caloriesPerServing,
    double? proteinPerServing,
    double? carbsPerServing,
    double? fatPerServing,
    double? fiberPerServing,
    double? vitaminDPerServing,
    double? vitaminB12PerServing,
    double? ironPerServing,
    double? calciumPerServing,
    bool? isPublic,
    bool? isLoading,
    String? error,
  }) {
    return RecipeBuilderState(
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      instructions: instructions ?? this.instructions,
      servings: servings ?? this.servings,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      proteinPerServing: proteinPerServing ?? this.proteinPerServing,
      carbsPerServing: carbsPerServing ?? this.carbsPerServing,
      fatPerServing: fatPerServing ?? this.fatPerServing,
      fiberPerServing: fiberPerServing ?? this.fiberPerServing,
      vitaminDPerServing: vitaminDPerServing ?? this.vitaminDPerServing,
      vitaminB12PerServing: vitaminB12PerServing ?? this.vitaminB12PerServing,
      ironPerServing: ironPerServing ?? this.ironPerServing,
      calciumPerServing: calciumPerServing ?? this.calciumPerServing,
      isPublic: isPublic ?? this.isPublic,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Notifier for recipe builder state
class RecipeBuilderNotifier extends Notifier<RecipeBuilderState> {
  @override
  RecipeBuilderState build() {
    return RecipeBuilderState();
  }

  /// Update recipe title
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  /// Update recipe description
  void setDescription(String? description) {
    state = state.copyWith(description: description);
  }

  /// Add ingredient to recipe
  void addIngredient(RecipeIngredient ingredient) {
    state = state.copyWith(ingredients: [...state.ingredients, ingredient]);
    _calculateNutrients();
  }

  /// Remove ingredient from recipe
  void removeIngredient(int index) {
    final newIngredients = List<RecipeIngredient>.from(state.ingredients);
    newIngredients.removeAt(index);
    state = state.copyWith(ingredients: newIngredients);
    _calculateNutrients();
  }

  /// Update ingredient quantity
  void updateIngredientQuantity(int index, double quantityG) {
    final newIngredients = List<RecipeIngredient>.from(state.ingredients);
    newIngredients[index] = RecipeIngredient(
      foodItemId: newIngredients[index].foodItemId,
      name: newIngredients[index].name,
      quantityG: quantityG,
    );
    state = state.copyWith(ingredients: newIngredients);
    _calculateNutrients();
  }

  /// Add instruction
  void addInstruction(String instruction) {
    state = state.copyWith(instructions: [...state.instructions, instruction]);
  }

  /// Remove instruction
  void removeInstruction(int index) {
    final newInstructions = List<String>.from(state.instructions);
    newInstructions.removeAt(index);
    state = state.copyWith(instructions: newInstructions);
  }

  /// Update instruction
  void updateInstruction(int index, String instruction) {
    final newInstructions = List<String>.from(state.instructions);
    newInstructions[index] = instruction;
    state = state.copyWith(instructions: newInstructions);
  }

  /// Set servings count
  void setServings(int servings) {
    state = state.copyWith(servings: servings);
    _calculateNutrients();
  }

  /// Toggle public/private
  void setPublic(bool isPublic) {
    state = state.copyWith(isPublic: isPublic);
  }

  /// Calculate nutrients per serving based on ingredients
  Future<void> _calculateNutrients() async {
    if (state.ingredients.isEmpty) {
      state = state.copyWith(
        caloriesPerServing: 0,
        proteinPerServing: 0,
        carbsPerServing: 0,
        fatPerServing: 0,
        fiberPerServing: 0,
        vitaminDPerServing: 0,
        vitaminB12PerServing: 0,
        ironPerServing: 0,
        calciumPerServing: 0,
      );
      return;
    }

    try {
      final recipeService = ref.read(recipeServiceProvider);
      final db = await recipeService.db
          .select(recipeService.db.foodItems)
          .get();

      // Create a map for quick lookup
      final foodMap = {for (var f in db) f.id: f};

      double totalCalories = 0;
      double totalProtein = 0;
      double totalCarbs = 0;
      double totalFat = 0;
      double totalFiber = 0;
      double totalVitaminD = 0;
      double totalVitaminB12 = 0;
      double totalIron = 0;
      double totalCalcium = 0;

      for (final ingredient in state.ingredients) {
        final food = foodMap[ingredient.foodItemId];
        if (food != null) {
          final scale = ingredient.quantityG / 100;
          totalCalories += (food.caloriesPer100g ?? 0) * scale;
          totalProtein += (food.proteinPer100g ?? 0) * scale;
          totalCarbs += (food.carbsPer100g ?? 0) * scale;
          totalFat += (food.fatPer100g ?? 0) * scale;
          totalFiber += (food.fiberPer100g ?? 0) * scale;
          totalVitaminD += (food.vitaminDPer100g ?? 0) * scale;
          totalVitaminB12 += (food.vitaminB12Per100g ?? 0) * scale;
          totalIron += (food.ironPer100g ?? 0) * scale;
          totalCalcium += (food.calciumPer100g ?? 0) * scale;
        }
      }

      final servings = state.servings > 0 ? state.servings : 1;

      state = state.copyWith(
        caloriesPerServing: totalCalories / servings,
        proteinPerServing: totalProtein / servings,
        carbsPerServing: totalCarbs / servings,
        fatPerServing: totalFat / servings,
        fiberPerServing: totalFiber / servings,
        vitaminDPerServing: totalVitaminD / servings,
        vitaminB12PerServing: totalVitaminB12 / servings,
        ironPerServing: totalIron / servings,
        calciumPerServing: totalCalcium / servings,
      );
    } catch (e) {
      // Silent fail - keep existing values
    }
  }

  /// Save recipe
  Future<String?> saveRecipe() async {
    if (state.title.isEmpty) {
      state = state.copyWith(error: 'Please enter a recipe title');
      return null;
    }

    if (state.ingredients.isEmpty) {
      state = state.copyWith(error: 'Please add at least one ingredient');
      return null;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final recipeService = ref.read(recipeServiceProvider);
      final authService = AuthAwService();
      final userId = await authService.getStoredUserId();

      if (userId == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'Please login to save recipes',
        );
        return null;
      }

      final recipeId = await recipeService.createRecipe(
        userId: userId,
        title: state.title,
        description: state.description,
        ingredients: state.ingredients,
        instructions: state.instructions,
        servings: state.servings,
        caloriesPerServing: state.caloriesPerServing,
        proteinPerServing: state.proteinPerServing,
        carbsPerServing: state.carbsPerServing,
        fatPerServing: state.fatPerServing,
        fiberPerServing: state.fiberPerServing,
        vitaminDPerServing: state.vitaminDPerServing,
        vitaminB12PerServing: state.vitaminB12PerServing,
        ironPerServing: state.ironPerServing,
        calciumPerServing: state.calciumPerServing,
        isPublic: state.isPublic,
      );

      state = state.copyWith(isLoading: false);
      return recipeId;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  /// Reset builder state
  void reset() {
    state = RecipeBuilderState();
  }
}

/// Provider for recipe builder state
final recipeBuilderProvider =
    NotifierProvider<RecipeBuilderNotifier, RecipeBuilderState>(() {
      return RecipeBuilderNotifier();
    });

/// Provider for user's recipes
final userRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final recipeService = ref.watch(recipeServiceProvider);
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();

  if (userId == null) return [];

  return await recipeService.getUserRecipes(userId);
});

/// Provider for community (public) recipes
final communityRecipesProvider = FutureProvider<List<Recipe>>((ref) async {
  final recipeService = ref.watch(recipeServiceProvider);
  return await recipeService.getPublicRecipes();
});
