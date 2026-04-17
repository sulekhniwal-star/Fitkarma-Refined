import '../../../core/storage/app_database.dart';
import '../../../core/storage/daos/food_dao.dart';

/// Thin facade over [FoodDao] kept for backward compatibility.
/// New code should use [FoodDao] directly via the DI providers.
class FoodDriftService {
  final FoodDao _dao;

  FoodDriftService(this._dao);

  Future<List<FoodItem>> searchFoodFts(String query) =>
      _dao.searchFoodFts(query);

  Future<void> bulkInsertFoodItems(List<FoodItemsCompanion> items) =>
      _dao.bulkInsertFoodItems(items);

  Future<List<FoodLog>> getRecentLogs(String userId, int limit) =>
      _dao.getRecentLogs(userId, limit);
}

