import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/food/data/food_drift_service.dart';

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  final driftService = ref.watch(foodDriftServiceProvider);
  return FoodRepository(driftService);
});

class FoodRepository {
  final FoodDriftService _driftService;

  FoodRepository(this._driftService);

  Future<int> logFood({
    required String odUserId,
    required String foodName,
    required String mealType,
    required double quantityG,
    required double calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    double vitaminDMcg = 0,
    double vitaminB12Mcg = 0,
    double ironMg = 0,
    double calciumMg = 0,
  }) async {
    return 0;
  }

  Future<List<FoodLog>> getTodayLogs(String odUserId) async {
    return _driftService.getLogsForUser(odUserId);
  }

  Future<Map<String, double>> getTodayMacros(String odUserId) async {
    return _driftService.getDailyMacros(odUserId, DateTime.now());
  }

  Future<double> getTodayCalories(String odUserId) async {
    return _driftService.getTotalCaloriesForDate(odUserId, DateTime.now());
  }

  Future<void> deleteLog(int logId) async {
    await _driftService.deleteFoodLog(logId);
  }

  Future<List<FoodItem>> searchFoods(String query) async {
    return _driftService.searchFoodItems(query);
  }

  Future<List<FoodItem>> getAllFoods() async {
    return _driftService.getAllFoodItems();
  }

  Stream<List<FoodLog>> watchTodayLogs(String odUserId) {
    return _driftService.watchLogsForUser(odUserId, limit: 50);
  }

  Future<void> syncPendingLogs(String odUserId) async {
    final pendingLogs = await _driftService.getPendingSync(odUserId);
    for (final log in pendingLogs) {
      try {
        await _driftService.markSynced(log.id);
      } catch (_) {}
    }
  }
}