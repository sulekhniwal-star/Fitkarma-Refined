// lib/core/seed/seed_service.dart
// Service to seed the local database with initial data

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/seed/indian_food_seed_data.dart';

class SeedService {
  final AppDatabase db;

  SeedService(this.db);

  /// Check if seed data already exists
  Future<bool> needsSeeding() async {
    final count = await (db.select(
      db.foodItems,
    )..where((t) => t.source.equals('fitkarma_seed'))).get();
    return count.isEmpty;
  }

  /// Seed the database with Indian food data
  Future<void> seedIndianFoods() async {
    // Check if already seeded
    if (!await needsSeeding()) {
      return;
    }

    final foods = IndianFoodSeedData.getAllFoods();

    await db.batch((batch) {
      for (final food in foods) {
        batch.insert(
          db.foodItems,
          FoodItemsCompanion.insert(
            id: food['id'] as String,
            name: food['name'] as String,
            nameLocal: food['name_local'] as String,
            region: food['region'] as String,
            barcode: Value(food['barcode'] as String?),
            caloriesPer100g: food['calories_per_100g'] as double,
            proteinPer100g: food['protein_per_100g'] as double,
            carbsPer100g: food['carbs_per_100g'] as double,
            fatPer100g: food['fat_per_100g'] as double,
            fiberPer100g: Value(food['fiber_per_100g'] as double),
            vitaminDPer100g: Value(food['vitamin_d_per_100g'] as double),
            vitaminB12Per100g: Value(food['vitamin_b12_per_100g'] as double),
            ironPer100g: Value(food['iron_per_100g'] as double),
            calciumPer100g: Value(food['calcium_per_100g'] as double),
            isIndian: Value(food['is_indian'] as bool),
            servingSizes: food['serving_sizes'] as String,
            source: food['source'] as String,
          ),
        );
      }
    });
  }

  /// Get all food items
  Future<List<FoodItem>> getAllFoods() async {
    return await db.select(db.foodItems).get();
  }

  /// Get foods by region
  Future<List<FoodItem>> getFoodsByRegion(String region) async {
    return await (db.select(
      db.foodItems,
    )..where((t) => t.region.equals(region))).get();
  }

  /// Search foods by name
  Future<List<FoodItem>> searchFoods(String query) async {
    final lowercaseQuery = query.toLowerCase();
    return await (db.select(db.foodItems)..where(
          (t) =>
              t.name.lower().contains(lowercaseQuery) |
              t.nameLocal.lower().contains(lowercaseQuery),
        ))
        .get();
  }

  /// Get unique regions
  Future<List<String>> getUniqueRegions() async {
    final foods = await db.select(db.foodItems).get();
    final regions = foods.map((f) => f.region).toSet().toList();
    regions.sort();
    return regions;
  }
}
