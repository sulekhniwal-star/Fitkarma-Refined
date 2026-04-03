import 'package:flutter_riverpod/flutter_riverpod.dart';

final foodAwServiceProvider = Provider<FoodAwService>((ref) {
  return FoodAwService();
});

class FoodAwService {
  Future<List<AwFoodItem>> searchFoodItems(String query) async {
    return [];
  }

  Future<List<AwFoodItem>> getAllFoodItems() async {
    return [];
  }

  Future<void> syncFoodLog(String odUserId, Map<String, dynamic> logData) async {
    // TODO: Implement Appwrite sync when collections are created
  }
}

class AwFoodItem {
  final String id;
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

  AwFoodItem({
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

  factory AwFoodItem.fromJson(Map<String, dynamic> data, String id) {
    return AwFoodItem(
      id: id,
      name: data['name'] as String? ?? '',
      nameLocal: data['nameLocal'] as String?,
      region: data['region'] as String?,
      caloriesPer100g: (data['caloriesPer100g'] as num?)?.toDouble() ?? 0,
      proteinPer100g: (data['proteinPer100g'] as num?)?.toDouble() ?? 0,
      carbsPer100g: (data['carbsPer100g'] as num?)?.toDouble() ?? 0,
      fatPer100g: (data['fatPer100g'] as num?)?.toDouble() ?? 0,
      vitaminDMcg: (data['vitaminDMcg'] as num?)?.toDouble() ?? 0,
      vitaminB12Mcg: (data['vitaminB12Mcg'] as num?)?.toDouble() ?? 0,
      ironMg: (data['ironMg'] as num?)?.toDouble() ?? 0,
      calciumMg: (data['calciumMg'] as num?)?.toDouble() ?? 0,
      servingSizesJson: data['servingSizesJson'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'nameLocal': nameLocal,
    'region': region,
    'caloriesPer100g': caloriesPer100g,
    'proteinPer100g': proteinPer100g,
    'carbsPer100g': carbsPer100g,
    'fatPer100g': fatPer100g,
    'vitaminDMcg': vitaminDMcg,
    'vitaminB12Mcg': vitaminB12Mcg,
    'ironMg': ironMg,
    'calciumMg': calciumMg,
    'servingSizesJson': servingSizesJson,
  };
}