import 'package:drift/drift.dart';
import '../converters/json_converters.dart';
import 'base_table.dart';

@DataClassName('FoodLog')
class FoodLogs extends Table with Syncable {
  TextColumn get foodItemId => text().nullable()();
  TextColumn get recipeId => text().nullable()();
  TextColumn get foodName => text()();
  TextColumn get mealType => text()(); // breakfast, lunch, dinner, snack
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
  TextColumn get logMethod => text().nullable()();
}

@DataClassName('FoodItem')
class FoodItems extends Table with Syncable {
  IntColumn get localRowId => integer().autoIncrement()(); // For FTS5 rowid
  TextColumn get appwriteId => text().nullable()(); // Extra ref

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
  BoolColumn get isIndian => boolean().withDefault(const Constant(false))();
  TextColumn get servingSizes => text().map(const JsonMapConverter()).nullable()(); // JSON
  TextColumn get source => text()(); // openfoodfacts, manual, etc.
}

@DataClassName('WorkoutLog')
class WorkoutLogs extends Table with Syncable {
  TextColumn get workoutId => text().nullable()();
  TextColumn get title => text()();
  IntColumn get durationMin => integer()();
  RealColumn get caloriesBurned => real().nullable()();
  TextColumn get category => text().nullable()();
  IntColumn get rpe => integer().nullable()();
  IntColumn get hrZone => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@DataClassName('StepLog')
class StepLogs extends Table with Syncable {
  DateTimeColumn get date => dateTime()();
  IntColumn get stepCount => integer()();
  RealColumn get distanceM => real().nullable()();
  RealColumn get caloriesBurned => real().nullable()();
  TextColumn get source => text()();
}

@DataClassName('SleepLog')
class SleepLogs extends Table with Syncable {
  DateTimeColumn get date => dateTime()();
  TextColumn get bedtime => text().withLength(min: 5, max: 5)();
  TextColumn get wakeTime => text().withLength(min: 5, max: 5)();
  IntColumn get durationMin => integer()();
  IntColumn get qualityScore => integer()();
  IntColumn get deepSleepMin => integer().nullable()();
  IntColumn get sleepDebtMin => integer().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get source => text()();
}

@DataClassName('MoodLog')
class MoodLogs extends Table with Syncable {
  IntColumn get moodScore => integer()();
  IntColumn get energyLevel => integer().nullable()();
  IntColumn get stressLevel => integer().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@DataClassName('Medication')
class Medications extends Table with Syncable {
  TextColumn get name => text()();
  TextColumn get dose => text()();
  TextColumn get frequency => text()();
  TextColumn get category => text()(); // prescription, otc, supplement, etc.
  TextColumn get reminderTimes => text().nullable()();
  DateTimeColumn get refillDate => dateTime().nullable()();
  TextColumn get pharmacyLink => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

@DataClassName('Habit')
class Habits extends Table with Syncable {
  TextColumn get name => text()();
  TextColumn get icon => text()();
  IntColumn get targetCount => integer()();
  TextColumn get unit => text()();
  TextColumn get frequency => text()();
  IntColumn get currentStreak => integer().withDefault(const Constant(0))();
  IntColumn get longestStreak => integer().withDefault(const Constant(0))();
  BoolColumn get streakRecoveryUsed => boolean().withDefault(const Constant(false))();
  TextColumn get reminderTime => text().nullable()();
  BoolColumn get isPreset => boolean().withDefault(const Constant(false))();
}

@DataClassName('HabitCompletion')
class HabitCompletions extends Table with Syncable {
  IntColumn get habitId => integer()(); // Local Ref (might need to change to text if habits use text id)
  DateTimeColumn get date => dateTime()();
  IntColumn get count => integer()();
}

@DataClassName('BodyMeasurement')
class BodyMeasurements extends Table with Syncable {
  RealColumn get weightKg => real().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get chestCm => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get hipsCm => real().nullable()();
  RealColumn get armsCm => real().nullable()();
  RealColumn get thighsCm => real().nullable()();
  RealColumn get bodyFatPct => real().nullable()();
  RealColumn get bmi => real().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
}

@DataClassName('FastingLog')
class FastingLogs extends Table with Syncable {
  TextColumn get protocol => text()();
  DateTimeColumn get fastStart => dateTime()();
  DateTimeColumn get fastEnd => dateTime().nullable()();
  RealColumn get targetDurationHours => real()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  DateTimeColumn get brokenAt => dateTime().nullable()();
  TextColumn get notes => text().nullable()();
}

@DataClassName('MealPlan')
class MealPlans extends Table with Syncable {
  DateTimeColumn get weekStart => dateTime()();
  TextColumn get planData => text().map(const JsonMapConverter())(); // JSON
  TextColumn get planType => text()(); // standard, festival, wedding, etc.
  TextColumn get festivalKey => text().nullable()();
  TextColumn get generatedBy => text()(); // ai, user
}

@DataClassName('Recipe')
class Recipes extends Table with Syncable {
  TextColumn get title => text()();
  TextColumn get description => text().nullable()();
  TextColumn get ingredients => text().map(const JsonMapConverter())(); // JSON
  TextColumn get steps => text().map(const JsonMapConverter())(); // JSON
  IntColumn get servings => integer()();
  RealColumn get totalCalories => real()();
  RealColumn get proteinG => real().nullable()();
  RealColumn get carbsG => real().nullable()();
  RealColumn get fatG => real().nullable()();
  RealColumn get ironMg => real().nullable()();
  RealColumn get vitaminDMcg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();
  RealColumn get b12Mcg => real().nullable()();
  TextColumn get cuisineRegion => text().nullable()();
  BoolColumn get isPublic => boolean().withDefault(const Constant(false))();
}

@DataClassName('PersonalRecord')
class PersonalRecords extends Table with Syncable {
  TextColumn get exerciseName => text()();
  RealColumn get recordValue => real()();
  TextColumn get unit => text()();
  DateTimeColumn get achievedAt => dateTime()();
}

@DataClassName('NutritionGoal')
class NutritionGoals extends Table with Syncable {
  RealColumn get tdee => real()();
  RealColumn get calorieGoal => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatG => real()();
  TextColumn get goalType => text()();
  RealColumn get vitDMcg => real().nullable()();
  RealColumn get b12Mcg => real().nullable()();
  RealColumn get ironMg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();
}

@DataClassName('KarmaTransaction')
class KarmaTransactions extends Table with Syncable {
  IntColumn get amount => integer()();
  TextColumn get action => text()();
  TextColumn get description => text().nullable()();
  IntColumn get balanceAfter => integer()();
}

@DataClassName('WaterLog')
class WaterLogs extends Table with Syncable {
  IntColumn get amountMl => integer()();
  DateTimeColumn get loggedAt => dateTime()();
}

@DataClassName('HeartRateLog')
class HeartRateLogs extends Table with Syncable {
  IntColumn get bpm => integer()();
  DateTimeColumn get timestamp => dateTime()();
  TextColumn get source => text()(); // fitbit, garmin, health_connect, etc.
}
