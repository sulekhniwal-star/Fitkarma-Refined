import 'package:drift/drift.dart';

@DataClassName('KarmaTransaction')
class KarmaTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get amount => integer()(); // positive (earned) or negative (spent)
  TextColumn get activityType => text()(); // enum: food_log/workout/fasting
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get collection => text()();
  TextColumn get operation => text()(); // create | update | delete
  TextColumn get localId => text()();
  TextColumn get appwriteDocId => text().nullable()();
  TextColumn get payload => text()(); // JSON
  TextColumn get idempotencyKey => text()();
  TextColumn get fieldVersions => text().nullable()(); // JSON
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  IntColumn get priority => integer().withDefault(const Constant(2))(); // SyncPriority.normal.value
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('SyncDeadLetterEntry')
class SyncDeadLetter extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get originalItem => text()(); // JSON snapshot of failed SyncQueueEntry
  IntColumn get failCount => integer()();
  TextColumn get lastError => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Medication')
class Medications extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get dosage => text().nullable()();
  TextColumn get frequency => text().nullable()(); // JSON schedule
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Habit')
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get iconEmoji => text()();
  IntColumn get targetCount => integer().withDefault(const Constant(1))();
  TextColumn get frequency => text()(); // daily/weekly
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('HabitCompletion')
class HabitCompletions extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text()();
  DateTimeColumn get completedDate => dateTime()();
  IntColumn get count => integer().withDefault(const Constant(1))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('BodyMeasurement')
class BodyMeasurements extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get weight => real()();
  RealColumn get height => real().nullable()();
  RealColumn get chest => real().nullable()();
  RealColumn get waist => real().nullable()();
  RealColumn get hips => real().nullable()();
  RealColumn get bodyFatPercent => real().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FastingLog')
class FastingLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  TextColumn get fastingType => text()(); // 16:8, roza, nirjala
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('MealPlan')
class MealPlans extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get meals => text()(); // JSON list of meal items
  DateTimeColumn get date => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Recipe')
class Recipes extends Table {
  TextColumn get id => text()();
  TextColumn get creatorId => text()();
  TextColumn get title => text()();
  TextColumn get ingredients => text()(); // JSON
  TextColumn get steps => text()(); // JSON
  RealColumn get calories => real().nullable()();
  RealColumn get protein => real().nullable()();
  RealColumn get carbs => real().nullable()();
  RealColumn get fat => real().nullable()();
  BoolColumn get isIndian => boolean().withDefault(const Constant(true))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PersonalRecord')
class PersonalRecords extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get exerciseName => text()();
  RealColumn get value => real()();
  IntColumn get reps => integer().nullable()();
  TextColumn get unit => text()();
  DateTimeColumn get achievedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('NutritionGoal')
class NutritionGoals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get calorieTarget => integer()();
  IntColumn get proteinTarget => integer().nullable()();
  IntColumn get carbsTarget => integer().nullable()();
  IntColumn get fatTarget => integer().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class EmergencyCards extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get bloodGroup => text().nullable()();
  TextColumn get allergies => text().nullable()();
  TextColumn get chronicConditions => text().nullable()();
  TextColumn get medications => text().nullable()();
  TextColumn get emergencyContact => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('FestivalCalendarEntry')
class FestivalCalendar extends Table {
  TextColumn get id => text()();
  TextColumn get festivalKey => text()();
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text()();
  TextColumn get nameLocal => text().nullable()();
  IntColumn get year => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get calendarSystem => text()(); // hindu, hijri, sikh, gregorian
  TextColumn get dietPlanType => text()(); // fasting, feast, sattvic, normal
  TextColumn get regionCodes => text().nullable()(); // JSON list (KA, TN, UP...)
  TextColumn get religion => text().nullable()();
  BoolColumn get isFastingDay => boolean().withDefault(const Constant(false))();
  TextColumn get fastingType => text().nullable()(); // nirjala, phalahar, roza
  TextColumn get allowedFoods => text().nullable()(); // JSON list
  TextColumn get forbiddenFoods => text().nullable()(); // JSON list
  TextColumn get workoutNote => text().nullable()();
  TextColumn get insightMessage => text().nullable()();
  TextColumn get karmaChallenge => text().nullable()();
  BoolColumn get computedDynamically => boolean().withDefault(const Constant(true))();
  DateTimeColumn get computedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WeddingEventEntry')
class WeddingEvents extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get role => text()(); // bride, groom, guest, relative
  TextColumn get relationType => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  IntColumn get prepWeeks => integer().withDefault(const Constant(4))();
  TextColumn get eventsList => text()(); // JSON list of Haldi, Mehendi...
  TextColumn get primaryGoal => text()(); // look_best, energy, stress_manage
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

class RemoteConfigCaches extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {key};
}

@DataClassName('UserStreak')
class UserStreaks extends Table {
  TextColumn get userId => text()();
  TextColumn get activityType => text()(); // food, steps, workout, water
  IntColumn get streakCount => integer().withDefault(const Constant(0))();
  IntColumn get previousStreakCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastActivityDate => dateTime().nullable()();
  DateTimeColumn get lastRecoveryDate => dateTime().nullable()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {userId, activityType};
}

@DataClassName('InsightFeedback')
class InsightFeedbacks extends Table {
  TextColumn get userId => text()();
  TextColumn get ruleId => text()();
  BoolColumn get isPositive => boolean()(); // true for 👍, false for 👎
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {userId, ruleId};
}
