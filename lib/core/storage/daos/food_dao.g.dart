// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_dao.dart';

// ignore_for_file: type=lint
mixin _$FoodDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoodLogsTable get foodLogs => attachedDatabase.foodLogs;
  $FoodItemsTable get foodItems => attachedDatabase.foodItems;
  $RecipesTable get recipes => attachedDatabase.recipes;
  $MealPlansTable get mealPlans => attachedDatabase.mealPlans;
  FoodDaoManager get managers => FoodDaoManager(this);
}

class FoodDaoManager {
  final _$FoodDaoMixin _db;
  FoodDaoManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db.attachedDatabase, _db.foodLogs);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db.attachedDatabase, _db.foodItems);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
  $$MealPlansTableTableManager get mealPlans =>
      $$MealPlansTableTableManager(_db.attachedDatabase, _db.mealPlans);
}
