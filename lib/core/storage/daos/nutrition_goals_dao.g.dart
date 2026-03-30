// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goals_dao.dart';

// ignore_for_file: type=lint
mixin _$NutritionGoalsDaoMixin on DatabaseAccessor<AppDatabase> {
  $NutritionGoalsTable get nutritionGoals => attachedDatabase.nutritionGoals;
  NutritionGoalsDaoManager get managers => NutritionGoalsDaoManager(this);
}

class NutritionGoalsDaoManager {
  final _$NutritionGoalsDaoMixin _db;
  NutritionGoalsDaoManager(this._db);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(
        _db.attachedDatabase,
        _db.nutritionGoals,
      );
}
