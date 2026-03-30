// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_logs_dao.dart';

// ignore_for_file: type=lint
mixin _$FoodLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoodLogsTable get foodLogs => attachedDatabase.foodLogs;
  FoodLogsDaoManager get managers => FoodLogsDaoManager(this);
}

class FoodLogsDaoManager {
  final _$FoodLogsDaoMixin _db;
  FoodLogsDaoManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db.attachedDatabase, _db.foodLogs);
}
