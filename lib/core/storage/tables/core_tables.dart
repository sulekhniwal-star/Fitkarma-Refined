import 'package:drift/drift.dart';

@DataClassName('FoodLog')
class FoodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get foodItemId => text().nullable()();
  TextColumn get recipeId => text().nullable()();
  TextColumn get foodName => text()();
  TextColumn get mealType => text()(); // enum breakfast/lunch/dinner/snack
  RealColumn get quantityG => real()();
  RealColumn get calories => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatG => real()();
  RealColumn get fiberG => real().nullable()();
  RealColumn get vitaminDMcg => real().nullable()();
  RealColumn get vitaminB12Mcg => real().nullable()();
  RealColumn get ironMg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get logMethod => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get idempotencyKey => text()();
  TextColumn get fieldVersions => text().nullable()(); // JSON

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FoodItem')
class FoodItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameLocal => text().nullable()();
  TextColumn get region => text().nullable()();
  TextColumn get barcode => text().nullable()();
  RealColumn get caloriesPer100g => real()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  RealColumn get fiberPer100g => real().nullable()();
  RealColumn get vitaminDPer100g => real().nullable()();
  RealColumn get vitaminB12Per100g => real().nullable()();
  RealColumn get ironPer100g => real().nullable()();
  RealColumn get calciumPer100g => real().nullable()();
  BoolColumn get isIndian => boolean().withDefault(const Constant(true))();
  TextColumn get servingSizes => text().nullable()(); // JSON
  TextColumn get source => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WorkoutLog')
class WorkoutLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get workoutId => text().nullable()();
  TextColumn get title => text()();
  IntColumn get durationMin => integer()();
  IntColumn get caloriesBurned => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  RealColumn get rpeLevel => real().nullable()();
  TextColumn get source => text()(); // manual/gps/wearable
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get idempotencyKey => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('StepLog')
class StepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get count => integer()();
  RealColumn get distanceKm => real().nullable()();
  IntColumn get calories => integer().nullable()();
  TextColumn get source => text()(); // sensor/health_connect/manual
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SleepLog')
class SleepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get bedtime => text()(); // HH:MM
  TextColumn get wakeTime => text()(); // HH:MM
  IntColumn get durationMin => integer()();
  IntColumn get qualityScore => integer()(); // 1-5
  IntColumn get deepSleepMin => integer().nullable()();
  IntColumn get sleepDebtMin => integer().nullable()();
  TextColumn get source => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MoodLog')
class MoodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get score => integer()(); // 1-5
  IntColumn get energyLevel => integer().nullable()();
  IntColumn get stressLevel => integer().nullable()();
  TextColumn get tags => text().nullable()(); // JSON list
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}
