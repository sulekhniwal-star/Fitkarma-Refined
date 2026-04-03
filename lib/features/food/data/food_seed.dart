import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/storage/app_database.dart';

final seedFoodDatabaseProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(driftDatabaseProvider);
  final existing = await db.select(db.foodItems).get();
  
  if (existing.isNotEmpty) {
    return;
  }

  await _seedFoodItems(db);
});

Future<void> _seedFoodItems(AppDatabase db) async {
  final foods = _indianFoods;
  
  for (final food in foods) {
    await db.into(db.foodItems).insert(
      FoodItemsCompanion.insert(
        name: food['name'] as String,
        caloriesPer100g: food['calories'] as double,
        proteinPer100g: food['protein'] as double,
        carbsPer100g: food['carbs'] as double,
        fatPer100g: food['fat'] as double,
      ),
    );
  }
}

const _indianFoods = [
  // North Indian
  {'name': 'Sarson Da Saag', 'calories': 146, 'protein': 6.8, 'carbs': 14.3, 'fat': 7.0},
  {'name': 'Makki Di Roti', 'calories': 140, 'protein': 3.2, 'carbs': 28.0, 'fat': 1.5},
  {'name': 'Dal Makhani', 'calories': 183, 'protein': 9.4, 'carbs': 22.0, 'fat': 7.8},
  {'name': 'Paneer Tikka', 'calories': 265, 'protein': 14.5, 'carbs': 6.5, 'fat': 21.0},
  {'name': 'Butter Chicken', 'calories': 289, 'protein': 16.8, 'carbs': 8.0, 'fat': 22.5},
  {'name': 'Naan', 'calories': 244, 'protein': 7.7, 'carbs': 45.0, 'fat': 3.5},
  {'name': 'Amritsari Kulcha', 'calories': 260, 'protein': 8.5, 'carbs': 48.0, 'fat': 4.2},
  {'name': 'Chole', 'calories': 212, 'protein': 11.0, 'carbs': 36.0, 'fat': 4.8},
  {'name': 'Lassi', 'calories': 121, 'protein': 3.6, 'carbs': 17.0, 'fat': 4.5},
  {'name': 'Tandoori Roti', 'calories': 120, 'protein': 3.5, 'carbs': 24.0, 'fat': 1.2},

  // South Indian
  {'name': 'Idli', 'calories': 133, 'protein': 4.0, 'carbs': 28.0, 'fat': 0.4},
  {'name': 'Dosa', 'calories': 187, 'protein': 3.5, 'carbs': 38.0, 'fat': 1.5},
  {'name': 'Sambar', 'calories': 94, 'protein': 4.0, 'carbs': 14.0, 'fat': 2.5},
  {'name': 'Rasam', 'calories': 34, 'protein': 1.5, 'carbs': 5.5, 'fat': 0.8},
  {'name': 'Vada', 'calories': 278, 'protein': 6.0, 'carbs': 40.0, 'fat': 11.0},
  {'name': 'Pongal', 'calories': 203, 'protein': 5.8, 'carbs': 36.0, 'fat': 4.2},
  {'name': 'Bisi Bele Bath', 'calories': 168, 'protein': 5.5, 'carbs': 28.0, 'fat': 4.0},
  {'name': 'Appam', 'calories': 142, 'protein': 3.0, 'carbs': 30.0, 'fat': 0.8},
  {'name': 'Avial', 'calories': 78, 'protein': 2.2, 'carbs': 10.0, 'fat': 3.5},
  {'name': 'Payasam', 'calories': 196, 'protein': 4.5, 'carbs': 32.0, 'fat': 5.2},
  {'name': 'Coconut Milk', 'calories': 230, 'protein': 2.3, 'carbs': 6.0, 'fat': 24.0},

  // West Indian
  {'name': 'Puran Poli', 'calories': 295, 'protein': 5.5, 'carbs': 55.0, 'fat': 6.5},
  {'name': 'Vada Pav', 'calories': 298, 'protein': 5.8, 'carbs': 45.0, 'fat': 10.5},
  {'name': 'Pav Bhaji', 'calories': 245, 'protein': 5.5, 'carbs': 32.0, 'fat': 11.5},
  {'name': 'Bhakri', 'calories': 118, 'protein': 2.5, 'carbs': 25.0, 'fat': 1.0},
  {'name': 'Thepla', 'calories': 198, 'protein': 5.0, 'carbs': 35.0, 'fat': 4.2},
  {'name': 'Khandvi', 'calories': 175, 'protein': 4.5, 'carbs': 28.0, 'fat': 5.5},
  {'name': 'Dhokla', 'calories': 95, 'protein': 3.5, 'carbs': 16.0, 'fat': 2.0},
  {'name': 'Misal Pav', 'calories': 275, 'protein': 8.0, 'carbs': 38.0, 'fat': 10.0},
  {'name': 'Sol Kadhi', 'calories': 42, 'protein': 1.0, 'carbs': 8.0, 'fat': 0.5},
  {'name': 'Modak', 'calories': 225, 'protein': 3.0, 'carbs': 48.0, 'fat': 3.5},

  // East Indian
  {'name': 'Rasgulla', 'calories': 186, 'protein': 5.0, 'carbs': 40.0, 'fat': 0.5},
  {'name': 'Sandesh', 'calories': 218, 'protein': 4.5, 'carbs': 44.0, 'fat': 2.8},
  {'name': 'Luchi', 'calories': 262, 'protein': 5.2, 'carbs': 48.0, 'fat': 5.5},
  {'name': 'Machher Jhol', 'calories': 145, 'protein': 16.0, 'carbs': 5.0, 'fat': 7.5},
  {'name': 'Biryani', 'calories': 198, 'protein': 6.5, 'carbs': 30.0, 'fat': 5.5},
  {'name': 'Chhena Poda', 'calories': 265, 'protein': 8.5, 'carbs': 32.0, 'fat': 11.0},
  {'name': 'Rasamalai', 'calories': 165, 'protein': 4.0, 'carbs': 35.0, 'fat': 1.0},

  // Northeast
  {'name': 'Khar', 'calories': 95, 'protein': 4.5, 'carbs': 12.0, 'fat': 3.5},
  {'name': 'Masor Tenga', 'calories': 58, 'protein': 5.5, 'carbs': 4.5, 'fat': 2.8},
  {'name': 'Pitha', 'calories': 185, 'protein': 3.5, 'carbs': 38.0, 'fat': 2.2},

  // Central
  {'name': 'Bhutte Ka Kees', 'calories': 68, 'protein': 2.5, 'carbs': 11.0, 'fat': 1.5},
  {'name': 'Dal Bafla', 'calories': 218, 'protein': 8.5, 'carbs': 35.0, 'fat': 5.2},
  {'name': 'Poha', 'calories': 162, 'protein': 3.5, 'carbs': 30.0, 'fat': 3.0},

  // Common Staples
  {'name': 'Basmati Rice', 'calories': 130, 'protein': 2.7, 'carbs': 28.0, 'fat': 0.3},
  {'name': 'Roti', 'calories': 106, 'protein': 3.1, 'carbs': 22.0, 'fat': 1.5},
  {'name': 'Daal (Toor)', 'calories': 116, 'protein': 7.7, 'carbs': 20.0, 'fat': 0.8},
  {'name': 'Daal (Mong)', 'calories': 103, 'protein': 6.0, 'carbs': 19.0, 'fat': 0.4},
  {'name': 'Daal (Chana)', 'calories': 127, 'protein': 7.5, 'carbs': 22.0, 'fat': 2.0},
  {'name': 'Milk', 'calories': 42, 'protein': 2.1, 'carbs': 3.4, 'fat': 1.0},
  {'name': 'Curd', 'calories': 63, 'protein': 3.5, 'carbs': 4.5, 'fat': 3.2},
  {'name': 'Ghee', 'calories': 876, 'protein': 0.3, 'carbs': 0, 'fat': 99.0},
  {'name': 'Coconut Oil', 'calories': 862, 'protein': 0, 'carbs': 0, 'fat': 100.0},
  {'name': 'Besan', 'calories': 356, 'protein': 22.0, 'carbs': 12.0, 'fat': 18.0},
  {'name': 'Sugar', 'calories': 387, 'protein': 0, 'carbs': 100.0, 'fat': 0},
  {'name': 'Jaggery', 'calories': 375, 'protein': 0.4, 'carbs': 98.0, 'fat': 0.1},
  {'name': 'Cashew Nuts', 'calories': 553, 'protein': 18.0, 'carbs': 30.0, 'fat': 44.0},
  {'name': 'Almonds', 'calories': 579, 'protein': 21.0, 'carbs': 22.0, 'fat': 50.0},
  {'name': 'Peanuts', 'calories': 567, 'protein': 26.0, 'carbs': 16.0, 'fat': 49.0},
  {'name': ' Ging', 'calories': 333, 'protein': 4.0, 'carbs': 18.0, 'fat': 28.0},

  // Fruits & Vegetables
  {'name': 'Banana', 'calories': 89, 'protein': 1.1, 'carbs': 23.0, 'fat': 0.3, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.3, 'calcium': 5},
  {'name': 'Mango', 'calories': 60, 'protein': 0.8, 'carbs': 15.0, 'fat': 0.4, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.2, 'calcium': 11},
  {'name': 'Apple', 'calories': 52, 'protein': 0.3, 'carbs': 14.0, 'fat': 0.2, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.1, 'calcium': 6},
  {'name': 'Orange', 'calories': 47, 'protein': 0.9, 'carbs': 12.0, 'fat': 0.1, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.1, 'calcium': 40},
  {'name': 'Papaya', 'calories': 43, 'protein': 0.5, 'carbs': 11.0, 'fat': 0.3, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.3, 'calcium': 20},
  {'name': 'Guava', 'calories': 68, 'protein': 2.6, 'carbs': 14.0, 'fat': 1.0, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.3, 'calcium': 18},
  {'name': 'Spinach', 'calories': 23, 'protein': 2.9, 'carbs': 3.6, 'fat': 0.4, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 2.7, 'calcium': 99},
  {'name': 'Cauliflower', 'calories': 25, 'protein': 1.9, 'carbs': 5.0, 'fat': 0.3, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.4, 'calcium': 22},
  {'name': 'Potato', 'calories': 77, 'protein': 2.0, 'carbs': 17.0, 'fat': 0.1, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.8, 'calcium': 12},
  {'name': 'Onion', 'calories': 40, 'protein': 1.1, 'carbs': 9.0, 'fat': 0.1, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.2, 'calcium': 23},
  {'name': 'Tomato', 'calories': 18, 'protein': 0.9, 'carbs': 3.9, 'fat': 0.2, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.3, 'calcium': 10},
  {'name': 'Carrot', 'calories': 41, 'protein': 0.9, 'carbs': 10.0, 'fat': 0.2, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 0.3, 'calcium': 33},
  {'name': 'Green Peas', 'calories': 81, 'protein': 5.4, 'carbs': 14.0, 'fat': 0.4, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 1.5, 'calcium': 25},
  {'name': 'Paneer', 'calories': 265, 'protein': 14.0, 'carbs': 3.5, 'fat': 22.0, 'vitaminD': 0.2, 'vitaminB12': 0.4, 'iron': 1.2, 'calcium': 310},
  {'name': 'Egg', 'calories': 155, 'protein': 13.0, 'carbs': 1.1, 'fat': 11.0, 'vitaminD': 2.0, 'vitaminB12': 0.9, 'iron': 1.2, 'calcium': 50},
  {'name': 'Chicken Breast', 'calories': 165, 'protein': 31.0, 'carbs': 0, 'fat': 3.6, 'vitaminD': 0.1, 'vitaminB12': 0.3, 'iron': 1.0, 'calcium': 15},
  {'name': 'Fish (Rohu)', 'calories': 128, 'protein': 18.0, 'carbs': 0, 'fat': 6.0, 'vitaminD': 3.0, 'vitaminB12': 1.5, 'iron': 0.8, 'calcium': 35},
  {'name': 'Fish (Mackerel)', 'calories': 205, 'protein': 19.0, 'carbs': 0, 'fat': 14.0, 'vitaminD': 7.5, 'vitaminB12': 7.3, 'iron': 1.6, 'calcium': 12},
  {'name': 'Egg White', 'calories': 52, 'protein': 11.0, 'carbs': 0.7, 'fat': 0.2, 'vitaminD': 0, 'vitaminB12': 0.1, 'iron': 0.1, 'calcium': 7},
  {'name': 'Soybeans', 'calories': 173, 'protein': 17.0, 'carbs': 10.0, 'fat': 9.0, 'vitaminD': 0, 'vitaminB12': 0, 'iron': 5.0, 'calcium': 102},
];