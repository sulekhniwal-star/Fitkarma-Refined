// lib/features/food/data/recipe_service.dart
// Service for Recipe CRUD operations

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

/// Model class for recipe ingredients
class RecipeIngredient {
  final String foodItemId;
  final String name;
  final double quantityG;

  RecipeIngredient({
    required this.foodItemId,
    required this.name,
    required this.quantityG,
  });

  Map<String, dynamic> toJson() => {
    'foodItemId': foodItemId,
    'name': name,
    'quantityG': quantityG,
  };

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) =>
      RecipeIngredient(
        foodItemId: json['foodItemId'] as String,
        name: json['name'] as String,
        quantityG: (json['quantityG'] as num).toDouble(),
      );
}

/// Service for managing Recipe data in local database
class RecipeService {
  final AppDatabase db;

  RecipeService(this.db);

  /// Create a new recipe
  Future<String> createRecipe({
    required String userId,
    required String title,
    String? description,
    required List<RecipeIngredient> ingredients,
    required List<String> instructions,
    required int servings,
    required double caloriesPerServing,
    required double proteinPerServing,
    required double carbsPerServing,
    required double fatPerServing,
    double? fiberPerServing,
    double? vitaminDPerServing,
    double? vitaminB12PerServing,
    double? ironPerServing,
    double? calciumPerServing,
    bool isPublic = false,
    String? imageUrl,
  }) async {
    final id = 'recipe_${DateTime.now().millisecondsSinceEpoch}';
    final now = DateTime.now();

    await db
        .into(db.recipes)
        .insert(
          RecipesCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            description: Value(description),
            ingredients: jsonEncode(
              ingredients.map((i) => i.toJson()).toList(),
            ),
            instructions: jsonEncode(instructions),
            servings: Value(servings),
            caloriesPerServing: Value(caloriesPerServing),
            proteinPerServing: Value(proteinPerServing),
            carbsPerServing: Value(carbsPerServing),
            fatPerServing: Value(fatPerServing),
            fiberPerServing: Value(fiberPerServing),
            vitaminDPerServing: Value(vitaminDPerServing),
            vitaminB12PerServing: Value(vitaminB12PerServing),
            ironPerServing: Value(ironPerServing),
            calciumPerServing: Value(calciumPerServing),
            isPublic: Value(isPublic),
            imageUrl: Value(imageUrl),
            createdAt: now,
            updatedAt: now,
            syncStatus: 'pending',
          ),
        );

    return id;
  }

  /// Get all recipes for a user
  Future<List<Recipe>> getUserRecipes(String userId) async {
    return await (db.select(db.recipes)
          ..where((r) => r.userId.equals(userId))
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
        .get();
  }

  /// Get public recipes (community recipes)
  Future<List<Recipe>> getPublicRecipes() async {
    return await (db.select(db.recipes)
          ..where((r) => r.isPublic.equals(true))
          ..orderBy([(r) => OrderingTerm.desc(r.createdAt)]))
        .get();
  }

  /// Get a single recipe by ID
  Future<Recipe?> getRecipeById(String id) async {
    return await (db.select(
      db.recipes,
    )..where((r) => r.id.equals(id))).getSingleOrNull();
  }

  /// Update a recipe
  Future<void> updateRecipe({
    required String id,
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
    String? imageUrl,
  }) async {
    final updates = RecipesCompanion(
      title: title != null ? Value(title) : const Value.absent(),
      description: description != null
          ? Value(description)
          : const Value.absent(),
      ingredients: ingredients != null
          ? Value(jsonEncode(ingredients.map((i) => i.toJson()).toList()))
          : const Value.absent(),
      instructions: instructions != null
          ? Value(jsonEncode(instructions))
          : const Value.absent(),
      servings: servings != null ? Value(servings) : const Value.absent(),
      caloriesPerServing: caloriesPerServing != null
          ? Value(caloriesPerServing)
          : const Value.absent(),
      proteinPerServing: proteinPerServing != null
          ? Value(proteinPerServing)
          : const Value.absent(),
      carbsPerServing: carbsPerServing != null
          ? Value(carbsPerServing)
          : const Value.absent(),
      fatPerServing: fatPerServing != null
          ? Value(fatPerServing)
          : const Value.absent(),
      fiberPerServing: fiberPerServing != null
          ? Value(fiberPerServing)
          : const Value.absent(),
      vitaminDPerServing: vitaminDPerServing != null
          ? Value(vitaminDPerServing)
          : const Value.absent(),
      vitaminB12PerServing: vitaminB12PerServing != null
          ? Value(vitaminB12PerServing)
          : const Value.absent(),
      ironPerServing: ironPerServing != null
          ? Value(ironPerServing)
          : const Value.absent(),
      calciumPerServing: calciumPerServing != null
          ? Value(calciumPerServing)
          : const Value.absent(),
      isPublic: isPublic != null ? Value(isPublic) : const Value.absent(),
      imageUrl: imageUrl != null ? Value(imageUrl) : const Value.absent(),
      updatedAt: Value(DateTime.now()),
      syncStatus: const Value('pending'),
    );

    await (db.update(db.recipes)..where((r) => r.id.equals(id))).write(updates);
  }

  /// Delete a recipe
  Future<void> deleteRecipe(String id) async {
    await (db.delete(db.recipes)..where((r) => r.id.equals(id))).go();
  }

  /// Parse ingredients JSON from a recipe
  List<RecipeIngredient> parseIngredients(String ingredientsJson) {
    final List<dynamic> list = jsonDecode(ingredientsJson);
    return list.map((item) => RecipeIngredient.fromJson(item)).toList();
  }

  /// Parse instructions JSON from a recipe
  List<String> parseInstructions(String instructionsJson) {
    final List<dynamic> list = jsonDecode(instructionsJson);
    return list.map((item) => item as String).toList();
  }

  /// Log a recipe as a single food entry
  Future<String> logRecipeAsFoodEntry({
    required String userId,
    required Recipe recipe,
    required String mealType,
    int servingsToLog = 1,
    DateTime? loggedAt,
  }) async {
    final id = 'foodlog_${DateTime.now().millisecondsSinceEpoch}';
    final now = loggedAt ?? DateTime.now();

    // Calculate nutrients based on servings to log
    final multiplier = servingsToLog / recipe.servings;

    await db
        .into(db.foodLogs)
        .insert(
          FoodLogsCompanion.insert(
            id: id,
            userId: userId,
            foodItemId: const Value(null),
            recipeId: Value(recipe.id),
            foodName: recipe.title,
            mealType: mealType,
            quantityG: 0, // Not applicable for recipes
            calories: (recipe.caloriesPerServing ?? 0) * multiplier,
            proteinG: (recipe.proteinPerServing ?? 0) * multiplier,
            carbsG: (recipe.carbsPerServing ?? 0) * multiplier,
            fatG: (recipe.fatPerServing ?? 0) * multiplier,
            fiberG: Value((recipe.fiberPerServing ?? 0) * multiplier),
            vitaminDMcg: Value((recipe.vitaminDPerServing ?? 0) * multiplier),
            vitaminB12Mcg: Value(
              (recipe.vitaminB12PerServing ?? 0) * multiplier,
            ),
            ironMg: Value((recipe.ironPerServing ?? 0) * multiplier),
            calciumMg: Value((recipe.calciumPerServing ?? 0) * multiplier),
            loggedAt: now,
            logMethod: 'recipe',
            syncStatus: 'pending',
            idempotencyKey: id,
          ),
        );

    return id;
  }
}
