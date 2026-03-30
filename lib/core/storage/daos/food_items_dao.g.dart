// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_items_dao.dart';

// ignore_for_file: type=lint
mixin _$FoodItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoodItemsTable get foodItems => attachedDatabase.foodItems;
  FoodItemsDaoManager get managers => FoodItemsDaoManager(this);
}

class FoodItemsDaoManager {
  final _$FoodItemsDaoMixin _db;
  FoodItemsDaoManager(this._db);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db.attachedDatabase, _db.foodItems);
}
