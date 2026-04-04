import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import 'package:uuid/uuid.dart';

part 'food_repository.g.dart';

class FoodRepository {
  final AppDatabase db;

  FoodRepository(this.db);

  Future<List<FoodItem>> searchFood(String query) async {
    return db.searchFoodFts(query);
  }

  Future<void> logFood({
    required String userId,
    required FoodItem item,
    required double quantityG,
    required String mealType,
    required String logMethod,
  }) async {
    final scale = quantityG / 100.0;
    
    await db.into(db.foodLogs).insert(
      FoodLogsCompanion.insert(
        id: const Uuid().v4(),
        userId: userId,
        foodName: item.name,
        foodItemId: Value(item.id),
        mealType: mealType,
        quantityG: quantityG,
        calories: item.caloriesPer100g * scale,
        proteinG: item.proteinPer100g * scale,
        carbsG: item.carbsPer100g * scale,
        fatG: item.fatPer100g * scale,
        fiberG: Value(item.fiberPer100g != null ? item.fiberPer100g! * scale : null),
        vitaminDMcg: Value(item.vitaminDPer100g != null ? item.vitaminDPer100g! * scale : null),
        vitaminB12Mcg: Value(item.vitaminB12Per100g != null ? item.vitaminB12Per100g! * scale : null),
        ironMg: Value(item.ironPer100g != null ? item.ironPer100g! * scale : null),
        calciumMg: Value(item.calciumPer100g != null ? item.calciumPer100g! * scale : null),
        loggedAt: DateTime.now(),
        logMethod: logMethod,
        idempotencyKey: const Uuid().v4(),
      ),
    );
  }

  Stream<List<FoodLog>> watchTodayLogs(String userId) {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    return (db.select(db.foodLogs)
          ..where((t) => t.userId.equals(userId) & t.loggedAt.isBiggerOrEqual(Variable(startOfDay)))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .watch();
  }

  Future<void> deleteLog(String logId) async {
    await (db.delete(db.foodLogs)..where((t) => t.id.equals(logId))).go();
  }
}

@riverpod
FoodRepository foodRepository(Ref ref) {
  return FoodRepository(ref.watch(databaseProvider));
}
