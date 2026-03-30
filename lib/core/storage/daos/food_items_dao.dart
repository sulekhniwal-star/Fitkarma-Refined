import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'food_items_dao.g.dart';


@DriftDatabase(tables: [FoodItems])
class FoodItemsDao extends DatabaseAccessor<AppDatabase>
    with _$FoodItemsDaoMixin {
  FoodItemsDao(super.db);

  Future<List<FoodItem>> getAll() => select(foodItems).get();

  Future<FoodItem?> getById(int id) =>
      (select(foodItems)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<FoodItem?> getByBarcode(String barcode) =>
      (select(foodItems)..where((t) => t.barcode.equals(barcode)))
          .getSingleOrNull();

  Future<List<FoodItem>> searchByName(String query) =>
      (select(foodItems)..where((t) => t.name.like('%$query%'))).get();

  Future<List<FoodItem>> getByCategory(String category) =>
      (select(foodItems)..where((t) => t.category.equals(category))).get();

  Future<int> insertItem(FoodItemsCompanion entry) =>
      into(foodItems).insert(entry);

  Future<bool> updateItem(FoodItemsCompanion entry) =>
      update(foodItems).replace(entry);

  Future<int> deleteItem(int id) =>
      (delete(foodItems)..where((t) => t.id.equals(id))).go();

  // FTS5 search integration
  Future<List<Map<String, dynamic>>> searchFts(String query) async {
    try {
      return await customSelect(
        'SELECT fi.* FROM food_items fi '
        'JOIN food_items_fts fts ON fi.id = fts.food_item_id '
        'WHERE food_items_fts MATCH ? '
        'ORDER BY rank',
        variables: [Variable.withString(query)],
        readsFrom: {foodItems},
      ).map((row) => row.data).get();
    } catch (_) {
      // Fallback to LIKE search if FTS5 unavailable
      return await customSelect(
        'SELECT * FROM food_items WHERE name LIKE ? OR brand LIKE ?',
        variables: [
          Variable.withString('%$query%'),
          Variable.withString('%$query%'),
        ],
        readsFrom: {foodItems},
      ).map((row) => row.data).get();
    }
  }

  Future<void> syncFtsIndex() async {
    await customStatement('DELETE FROM food_items_fts');
    await customInsert(
      'INSERT INTO food_items_fts (food_item_id, name, brand, category) '
      'SELECT id, name, brand, category FROM food_items',
    );
  }
}
