// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plans_dao.dart';

// ignore_for_file: type=lint
mixin _$MealPlansDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealPlansTable get mealPlans => attachedDatabase.mealPlans;
  MealPlansDaoManager get managers => MealPlansDaoManager(this);
}

class MealPlansDaoManager {
  final _$MealPlansDaoMixin _db;
  MealPlansDaoManager(this._db);
  $$MealPlansTableTableManager get mealPlans =>
      $$MealPlansTableTableManager(_db.attachedDatabase, _db.mealPlans);
}
