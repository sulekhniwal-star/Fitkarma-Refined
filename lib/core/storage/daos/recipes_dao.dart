import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'recipes_dao.g.dart';


@DriftDatabase(tables: [Recipes])
class RecipesDao extends DatabaseAccessor<AppDatabase>
    with _$RecipesDaoMixin {
  RecipesDao(super.db);

  Future<List<Recipe>> getByUser(String userId) =>
      (select(recipes)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<List<Recipe>> getPublic({String? category}) {
    final query = select(recipes)
      ..where((t) => t.isPublic.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (category != null) {
      query.where((t) => t.category.equals(category));
    }
    return query.get();
  }

  Future<Recipe?> getById(int id) =>
      (select(recipes)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<int> insertRecipe(RecipesCompanion entry) =>
      into(recipes).insert(entry);

  Future<bool> updateRecipe(RecipesCompanion entry) =>
      update(recipes).replace(entry);

  Future<int> deleteRecipe(int id) =>
      (delete(recipes)..where((t) => t.id.equals(id))).go();
}
