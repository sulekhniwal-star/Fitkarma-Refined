import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';

class FoodSeedData {
  static final List<FoodItemsCompanion> initialFoods = [
    FoodItemsCompanion.insert(
      id: 'dal_tadka',
      name: 'Dal Tadka',
      nameLocal: const Value('दाल तड़का'),
      region: const Value('North India'),
      caloriesPer100g: 110,
      proteinPer100g: 5.5,
      carbsPer100g: 14.0,
      fatPer100g: 4.2,
      ironPer100g: const Value(1.5),
      vitaminB12Per100g: const Value(0.0),
      isIndian: const Value(true),
      servingSizes: const Value('[{"name": "bowl", "grams": 250}, {"name": "katori", "grams": 150}]'),
    ),
    FoodItemsCompanion.insert(
      id: 'idli',
      name: 'Idli',
      nameLocal: const Value('इडली'),
      region: const Value('South India'),
      caloriesPer100g: 96,
      proteinPer100g: 2.1,
      carbsPer100g: 19.5,
      fatPer100g: 0.2,
      calciumPer100g: const Value(5.0),
      isIndian: const Value(true),
      servingSizes: const Value('[{"name": "piece", "grams": 40}]'),
    ),
    FoodItemsCompanion.insert(
      id: 'paneer_tikka',
      name: 'Paneer Tikka',
      nameLocal: const Value('पनीर टिक्का'),
      region: const Value('North India'),
      caloriesPer100g: 265,
      proteinPer100g: 18.0,
      carbsPer100g: 6.0,
      fatPer100g: 20.0,
      calciumPer100g: const Value(480.0),
      isIndian: const Value(true),
      servingSizes: const Value('[{"name": "plate", "grams": 200}, {"name": "piece", "grams": 30}]'),
    ),
    FoodItemsCompanion.insert(
      id: 'chicken_biryani',
      name: 'Chicken Biryani',
      nameLocal: const Value('चिकन बिरयानी'),
      region: const Value('Hyderabad'),
      caloriesPer100g: 180,
      proteinPer100g: 9.0,
      carbsPer100g: 22.0,
      fatPer100g: 6.5,
      vitaminB12Per100g: const Value(0.4),
      isIndian: const Value(true),
      servingSizes: const Value('[{"name": "plate", "grams": 350}, {"name": "bowl", "grams": 200}]'),
    ),
    FoodItemsCompanion.insert(
      id: 'roti',
      name: 'Roti / Chapati',
      nameLocal: const Value('रोटी'),
      region: const Value('All India'),
      caloriesPer100g: 264,
      proteinPer100g: 9.0,
      carbsPer100g: 50.0,
      fatPer100g: 3.5,
      ironPer100g: const Value(2.5),
      isIndian: const Value(true),
      servingSizes: const Value('[{"name": "medium", "grams": 40}, {"name": "large", "grams": 60}]'),
    ),
  ];

  static Future<void> seed(AppDatabase db) async {
    // Only seed if empty
    final count = await db.select(db.foodItems).get();
    if (count.isEmpty) {
      for (final food in initialFoods) {
        await db.into(db.foodItems).insert(food);
      }
    }
  }
}
