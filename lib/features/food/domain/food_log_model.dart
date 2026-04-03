import 'package:fitkarma/core/storage/app_database.dart';

class FoodLogModel {
  final int id;
  final String odUserId;
  final String foodName;
  final String mealType;
  final double quantityG;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
  final double ironMg;
  final double calciumMg;
  final DateTime loggedAt;
  final String syncStatus;
  final String idempotencyKey;

  FoodLogModel({
    required this.id,
    required this.odUserId,
    required this.foodName,
    required this.mealType,
    required this.quantityG,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.vitaminDMcg = 0,
    this.vitaminB12Mcg = 0,
    this.ironMg = 0,
    this.calciumMg = 0,
    required this.loggedAt,
    required this.syncStatus,
    required this.idempotencyKey,
  });

  factory FoodLogModel.fromDrift(FoodLog log) {
    return FoodLogModel(
      id: log.id,
      odUserId: log.userId,
      foodName: log.foodName,
      mealType: log.mealType,
      quantityG: log.quantityG,
      calories: log.calories,
      proteinG: log.proteinG,
      carbsG: log.carbsG,
      fatG: log.fatG,
      vitaminDMcg: log.vitaminDMcg,
      vitaminB12Mcg: log.vitaminB12Mcg,
      ironMg: log.ironMg,
      calciumMg: log.calciumMg,
      loggedAt: log.loggedAt,
      syncStatus: log.syncStatus,
      idempotencyKey: log.idempotencyKey,
    );
  }

  double get micronutrientScore => vitaminDMcg + vitaminB12Mcg + ironMg + calciumMg;

  double get macroScore => proteinG + carbsG + fatG;

  bool get isSynced => syncStatus == 'synced';

  String get mealTypeEmoji {
    switch (mealType) {
      case 'breakfast':
        return '🌅';
      case 'lunch':
        return '☀️';
      case 'dinner':
        return '🌙';
      case 'snack':
        return '🍪';
      default:
        return '🍽️';
    }
  }

  String get formattedCalories => '${calories.toInt()} kcal';
  String get formattedMacros => 'P:${proteinG.toInt()}g C:${carbsG.toInt()}g F:${fatG.toInt()}g';
}

class FoodItemModel {
  final int id;
  final String name;
  final String? nameLocal;
  final String? region;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
  final double ironMg;
  final double calciumMg;
  final String? servingSizesJson;

  FoodItemModel({
    required this.id,
    required this.name,
    this.nameLocal,
    this.region,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    this.vitaminDMcg = 0,
    this.vitaminB12Mcg = 0,
    this.ironMg = 0,
    this.calciumMg = 0,
    this.servingSizesJson,
  });

  factory FoodItemModel.fromDrift(FoodItem item) {
    return FoodItemModel(
      id: item.id,
      name: item.name,
      nameLocal: item.nameLocal,
      region: item.region,
      caloriesPer100g: item.caloriesPer100g,
      proteinPer100g: item.proteinPer100g,
      carbsPer100g: item.carbsPer100g,
      fatPer100g: item.fatPer100g,
      vitaminDMcg: item.vitaminDMcg,
      vitaminB12Mcg: item.vitaminB12Mcg,
      ironMg: item.ironMg,
      calciumMg: item.calciumMg,
      servingSizesJson: item.servingSizesJson,
    );
  }

  double getScore() {
    return proteinPer100g + carbsPer100g + (vitaminDMcg * 10) + (vitaminB12Mcg * 10) + ironMg + calciumMg;
  }

  String get regionEmoji {
    switch (region) {
      case 'north':
        return '� Sikh';
      case 'south':
        return '🕌';
      case 'west':
        return '🏖️';
      case 'east':
        return '🪷';
      case 'northeast':
        return '🏔️';
      case 'central':
        return '🏹';
      default:
        return '🇮🇳';
    }
  }

  String get formattedNutrition =>
      '${caloriesPer100g.toInt()} kcal | P:${proteinPer100g.toInt()}g C:${carbsPer100g.toInt()}g F:${fatPer100g.toInt()}g';
}