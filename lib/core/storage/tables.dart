import 'package:drift/drift.dart';

// ═══════════════════════════════════════════════════════════════
// Core Tables
// ═══════════════════════════════════════════════════════════════

class FoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get mealType => text()(); // breakfast, lunch, dinner, snack
  TextColumn get foodName => text()();
  RealColumn get quantity => real()();
  TextColumn get unit => text()(); // grams, ml, pieces, cups
  IntColumn get calories => integer()();
  RealColumn get protein => real().nullable()();
  RealColumn get carbs => real().nullable()();
  RealColumn get fat => real().nullable()();
  RealColumn get fiber => real().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get notes => text().nullable()();
  TextColumn get imageUrl => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class FoodItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get brand => text().nullable()();
  TextColumn get barcode => text().nullable()();
  IntColumn get caloriesPer100g => integer()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  RealColumn get fiberPer100g => real().nullable()();
  RealColumn get servingSize => real().nullable()();
  TextColumn get servingUnit => text().nullable()();
  TextColumn get category => text().nullable()();
  BoolColumn get isUserCreated => boolean().withDefault(const Constant(false))();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class WorkoutLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get workoutType => text()(); // cardio, strength, yoga, sports, etc.
  TextColumn get exerciseName => text()();
  IntColumn get durationMinutes => integer()();
  IntColumn get caloriesBurned => integer().nullable()();
  IntColumn get intensity => integer().nullable()(); // 1-10
  IntColumn get heartRateAvg => integer().nullable()();
  IntColumn get heartRateMax => integer().nullable()();
  IntColumn get sets => integer().nullable()();
  IntColumn get reps => integer().nullable()();
  RealColumn get weight => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class StepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get steps => integer()();
  RealColumn get distanceMeters => real().nullable()();
  IntColumn get caloriesBurned => integer().nullable()();
  IntColumn get activeMinutes => integer().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ═══════════════════════════════════════════════════════════════
// Lifestyle Tables
// ═══════════════════════════════════════════════════════════════

class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  DateTimeColumn get sleepStart => dateTime()();
  DateTimeColumn get sleepEnd => dateTime()();
  IntColumn get durationMinutes => integer()();
  IntColumn get quality => integer().nullable()(); // 1-5
  IntColumn get deepSleepMinutes => integer().nullable()();
  IntColumn get remSleepMinutes => integer().nullable()();
  IntColumn get lightSleepMinutes => integer().nullable()();
  IntColumn get awakeMinutes => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class MoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get moodScore => integer()(); // 1-10
  TextColumn get moodLabel => text().nullable()(); // happy, sad, anxious, etc.
  TextColumn get notes => text().nullable()();
  IntColumn get energyLevel => integer().nullable()(); // 1-5
  IntColumn get stressLevel => integer().nullable()(); // 1-5
  TextColumn get factors => text().nullable()(); // JSON array of contributing factors
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get icon => text().nullable()();
  TextColumn get color => text().nullable()();
  TextColumn get frequency => text()(); // daily, weekly, custom
  IntColumn get targetCount => integer().withDefault(const Constant(1))();
  TextColumn get reminderTime => text().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer()();
  TextColumn get userId => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get count => integer().withDefault(const Constant(1))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class BodyMeasurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get bmi => real().nullable()();
  RealColumn get bodyFatPercent => real().nullable()();
  RealColumn get muscleMassKg => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get chestCm => real().nullable()();
  RealColumn get hipCm => real().nullable()();
  RealColumn get bicepCm => real().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Medications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get dosage => text()();
  TextColumn get frequency => text()(); // daily, twice_daily, weekly, as_needed
  TextColumn get unit => text().nullable()();
  TextColumn get instructions => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get reminderTimes => text().nullable()(); // JSON array of HH:mm strings
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class FastingLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get fastingType => text()(); // 16:8, 18:6, 20:4, OMAD, water_fast, custom
  DateTimeColumn get startTime => dateTime()();
  DateTimeColumn get endTime => dateTime().nullable()();
  IntColumn get durationMinutes => integer().nullable()();
  TextColumn get status => text()(); // active, completed, broken
  IntColumn get caloriesConsumed => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class MealPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get targetCalories => integer().nullable()();
  RealColumn get targetProtein => real().nullable()();
  RealColumn get targetCarbs => real().nullable()();
  RealColumn get targetFat => real().nullable()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get instructions => text()(); // JSON array of steps
  IntColumn get prepTimeMinutes => integer().nullable()();
  IntColumn get cookTimeMinutes => integer().nullable()();
  IntColumn get servings => integer().nullable()();
  IntColumn get caloriesPerServing => integer().nullable()();
  RealColumn get proteinPerServing => real().nullable()();
  RealColumn get carbsPerServing => real().nullable()();
  RealColumn get fatPerServing => real().nullable()();
  TextColumn get ingredients => text()(); // JSON array
  TextColumn get imageUrl => text().nullable()();
  TextColumn get category => text().nullable()();
  BoolColumn get isPublic => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ═══════════════════════════════════════════════════════════════
// Health Tables (SQLCipher encrypted at database level)
// ═══════════════════════════════════════════════════════════════

class BloodPressureLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get heartRate => integer().nullable()();
  TextColumn get position => text().nullable()(); // sitting, standing, lying
  TextColumn get arm => text().nullable()(); // left, right
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class GlucoseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  RealColumn get value => real()(); // mg/dL or mmol/L
  TextColumn get unit => text()(); // mg_dl, mmol_l
  TextColumn get measurementType => text()(); // fasting, post_meal, random, bedtime
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class Spo2Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get spo2Percent => integer()();
  IntColumn get heartRate => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class PeriodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  IntColumn get flowLevel => integer().nullable()(); // 1-5
  TextColumn get symptoms => text().nullable()(); // JSON array
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get title => text().nullable()();
  TextColumn get content => text()();
  TextColumn get mood => text().nullable()();
  TextColumn get tags => text().nullable()(); // JSON array
  TextColumn get imageUrls => text().nullable()(); // JSON array
  BoolColumn get isPrivate => boolean().withDefault(const Constant(true))();
  DateTimeColumn get entryDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class DoctorAppointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get doctorName => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get clinicName => text().nullable()();
  TextColumn get address => text().nullable()();
  TextColumn get phone => text().nullable()();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get reason => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get status => text()(); // scheduled, completed, cancelled, no_show
  BoolColumn get reminderSet => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ═══════════════════════════════════════════════════════════════
// India Ecosystem Tables
// ═══════════════════════════════════════════════════════════════

class LabReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get reportName => text()();
  TextColumn get labName => text().nullable()();
  TextColumn get doctorName => text().nullable()();
  DateTimeColumn get reportDate => dateTime()();
  TextColumn get results => text().nullable()(); // JSON array of test results
  TextColumn get fileUrl => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class AbhaLinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get abhaId => text()(); // ABHA health ID
  TextColumn get abhaAddress => text().nullable()();
  TextColumn get linkedName => text().nullable()();
  DateTimeColumn get linkedAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

// ═══════════════════════════════════════════════════════════════
// Platform Tables
// ═══════════════════════════════════════════════════════════════

class EmergencyCard extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get fullName => text()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get bloodType => text().nullable()();
  TextColumn get allergies => text().nullable()(); // JSON array
  TextColumn get conditions => text().nullable()(); // JSON array
  TextColumn get medications => text().nullable()(); // JSON array
  TextColumn get emergencyContactName => text().nullable()();
  TextColumn get emergencyContactPhone => text().nullable()();
  TextColumn get notes => text().nullable()();
  BoolColumn get isVisibleOnLockScreen => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class FestivalCalendar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get date => dateTime()();
  TextColumn get region => text().nullable()();
  TextColumn get category => text().nullable()(); // national, religious, cultural
  TextColumn get fastingRules => text().nullable()();
  TextColumn get dietaryNotes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class RemoteConfigCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get value => text()();
  DateTimeColumn get fetchedAt => dateTime()();
  DateTimeColumn get expiresAt => dateTime().nullable()();
}

// ═══════════════════════════════════════════════════════════════
// Infrastructure Tables
// ═══════════════════════════════════════════════════════════════

class KarmaTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get points => integer()();
  TextColumn get transactionType => text()(); // earned, spent, bonus, penalty
  TextColumn get source => text()(); // workout, food_log, habit, challenge, etc.
  IntColumn get referenceId => integer().nullable()();
  TextColumn get referenceType => text().nullable()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get transactionDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
}

class NutritionGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  IntColumn get dailyCalories => integer().nullable()();
  RealColumn get dailyProtein => real().nullable()();
  RealColumn get dailyCarbs => real().nullable()();
  RealColumn get dailyFat => real().nullable()();
  RealColumn get dailyFiber => real().nullable()();
  RealColumn get dailyWaterMl => real().nullable()();
  TextColumn get goalType => text().nullable()(); // lose_weight, gain_muscle, maintain, custom
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class PersonalRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get exerciseName => text()();
  TextColumn get recordType => text()(); // max_weight, max_reps, fastest_time, longest_distance
  RealColumn get value => real()();
  TextColumn get unit => text()();
  DateTimeColumn get achievedAt => dateTime()();
  IntColumn get workoutLogId => integer().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncTable => text()();
  IntColumn get recordId => integer()();
  TextColumn get operation => text()(); // create, update, delete
  TextColumn get payload => text()(); // JSON of the record data
  TextColumn get status => text().withDefault(const Constant('pending'))(); // pending, processing, completed, failed
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

class SyncDeadLetter extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get syncTable => text()();
  IntColumn get recordId => integer()();
  TextColumn get operation => text()();
  TextColumn get payload => text()();
  TextColumn get errorMessage => text().nullable()();
  IntColumn get originalRetryCount => integer()();
  DateTimeColumn get createdAt => dateTime()();
}
