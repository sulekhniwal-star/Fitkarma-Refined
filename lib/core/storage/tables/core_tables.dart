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

@DataClassName('UserProfile')
class UserProfiles extends Table {
  TextColumn get id => text()(); // Appwrite UID
  TextColumn get name => text()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get dob => dateTime().nullable()();
  RealColumn get height => real().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get fitnessGoal => text().nullable()();
  TextColumn get activityLevel => text().nullable()();
  TextColumn get doshaScores => text().nullable()(); // JSON
  TextColumn get preferredLanguage => text().withDefault(const Constant('en'))();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();
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

@DataClassName('Exercise')
class Exercises extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get muscleGroup => text()(); // Chest, Back, Legs, etc.
  TextColumn get equipment => text().nullable()(); // Barbell, Dumbbell, Bodyweight
  TextColumn get description => text().nullable()();
  TextColumn get gifUrl => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('ExerciseSet')
class ExerciseSets extends Table {
  TextColumn get id => text()();
  TextColumn get workoutLogId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get setNumber => integer()();
  RealColumn get weight => real().nullable()();
  IntColumn get reps => integer().nullable()();
  IntColumn get rpe => integer().nullable()(); // 1-10
  BoolColumn get isWarmup => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Workout')
class Workouts extends Table {
  TextColumn get id => text()(); 
  TextColumn get title => text()();
  TextColumn get youtubeId => text().nullable()();
  IntColumn get durationMin => integer()();
  TextColumn get difficulty => text()(); // Beginner, Intermediate, Advanced
  TextColumn get category => text()(); // Yoga, HIIT, Strength, Dance, Bollywood, Pranayama
  TextColumn get language => text().withDefault(const Constant('en'))();
  BoolColumn get isPremium => boolean().withDefault(const Constant(false))();
  RealColumn get rpeLevel => real().nullable()();
  TextColumn get thumbnailUrl => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}
