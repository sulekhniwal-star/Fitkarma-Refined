import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:crypto/crypto.dart';

part 'app_database.g.dart';

// --- Infrastructure Tables ---

@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  TextColumn get id => text()();
  TextColumn get collection => text()();
  TextColumn get operation => text()(); // 'create' | 'update' | 'delete'
  TextColumn get localId => text()();
  TextColumn get appwriteDocId => text().nullable()();
  TextColumn get payload => text()(); // JSON
  TextColumn get idempotencyKey => text()(); // SHA-256(userId + entityType + localId + createdAt)
  TextColumn get fieldVersions => text().nullable()(); // JSON: per-field updatedAt map
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
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

// --- Core Tables ---

class FoodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get foodItemId => text().nullable()();
  TextColumn get recipeId => text().nullable()();
  TextColumn get foodName => text()();
  TextColumn get mealType => text()(); // 'breakfast' | 'lunch' | 'dinner' | 'snack'
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
  TextColumn get syncStatus => text()(); // 'synced' | 'pending' | 'conflict'
  TextColumn get idempotencyKey => text()();
  TextColumn get fieldVersions => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class FoodItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get nameLocal => text()();
  TextColumn get region => text()();
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
  TextColumn get servingSizes => text()(); // JSON
  TextColumn get source => text()();
  TextColumn get restaurantName => text().nullable()();
  TextColumn get swiggyItemId => text().nullable()();
  TextColumn get zomatoItemId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class WorkoutLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get title => text()();
  IntColumn get durationMin => integer()();
  RealColumn get caloriesBurned => real()();
  TextColumn get workoutType => text()();
  TextColumn get rpeLevel => text().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class StepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get steps => integer()();
  RealColumn get distanceKm => real().nullable()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class SleepLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get bedtime => text()(); // HH:MM
  TextColumn get wakeTime => text()(); // HH:MM
  IntColumn get durationMin => integer()();
  IntColumn get qualityScore => integer()();
  IntColumn get deepSleepMin => integer().nullable()();
  IntColumn get sleepDebtMin => integer().withDefault(const Constant(0))();
  TextColumn get source => text()();
  
  @override
  Set<Column> get primaryKey => {id};
}

class MoodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get loggedAt => dateTime()();
  IntColumn get moodScore => integer()();
  IntColumn get energyLevel => integer().nullable()();
  IntColumn get stressLevel => integer().nullable()();
  TextColumn get tags => text().nullable()(); // JSON
  
  @override
  Set<Column> get primaryKey => {id};
}

// --- Lifestyle Tables ---

class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
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

  @override
  Set<Column> get primaryKey => {id};
}

class HabitCompletions extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text()();
  DateTimeColumn get date => dateTime()();
  IntColumn get count => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class BodyMeasurements extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get measuredAt => dateTime()();
  RealColumn get weightKg => real().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get bodyFatPercentage => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get hipCm => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Medications extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get dose => text()();
  TextColumn get frequency => text()();
  TextColumn get category => text()(); // Prescription, OTC, Supplement, Ayurvedic
  DateTimeColumn get nextRefillDate => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class FastingLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get fastStart => dateTime()();
  DateTimeColumn get fastEnd => dateTime().nullable()();
  TextColumn get fastType => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class MealPlans extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get mealType => text()();
  TextColumn get planDetails => text()(); // JSON

  @override
  Set<Column> get primaryKey => {id};
}

class Recipes extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get title => text()();
  TextColumn get ingredients => text()(); // JSON
  TextColumn get instructions => text()(); // JSON
  RealColumn get totalCalories => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- Health (Encrypted) Tables ---

class BloodPressureLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get pulse => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()();
  TextColumn get source => text()();
  TextColumn get idempotencyKey => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class GlucoseLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get glucoseMgdl => real()();
  TextColumn get readingType => text()();
  TextColumn get foodLogId => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()();
  RealColumn get hba1cEstimate => real().nullable()();
  TextColumn get source => text()();
  TextColumn get idempotencyKey => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Spo2Logs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get spo2Percentage => real()();
  IntColumn get pulseRate => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

class PeriodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get symptoms => text().nullable()(); // JSON
  TextColumn get flowType => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get content => text()(); // Encrypted

  @override
  Set<Column> get primaryKey => {id};
}

class DoctorAppointments extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get doctorName => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- India Ecosystem Tables ---

class LabReports extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get reportDate => dateTime()();
  TextColumn get labName => text()();
  TextColumn get extractedValues => text()(); // JSON
  TextColumn get rawText => text().nullable()();
  BoolColumn get confirmedByUser => boolean().withDefault(const Constant(false))();
  TextColumn get source => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class AbhaLinks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get abhaId => text()();
  TextColumn get abhaAddress => text()();
  DateTimeColumn get linkedAt => dateTime()();
  BoolColumn get consentGranted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- Platform Tables ---

class EmergencyCard extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get bloodGroup => text().nullable()();
  TextColumn get allergies => text().nullable()();
  TextColumn get chronicConditions => text().nullable()();
  TextColumn get emergencyContact => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class FestivalCalendar extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  TextColumn get festivalTag => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class RemoteConfigCache extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();
  TextColumn get type => text()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {key};
}

// --- Infrastructure (Continued) ---

class KarmaTransactions extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get amount => integer()();
  TextColumn get action => text()();
  TextColumn get description => text().nullable()();
  IntColumn get balanceAfter => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

class NutritionGoals extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get tdee => real().nullable()();
  RealColumn get calorieGoal => real().nullable()();
  RealColumn get proteinG => real().nullable()();
  RealColumn get carbsG => real().nullable()();
  RealColumn get fatG => real().nullable()();
  RealColumn get vitaminDMcg => real().nullable()();
  RealColumn get vitaminB12Mcg => real().nullable()();
  RealColumn get ironMg => real().nullable()();
  RealColumn get calciumMg => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class PersonalRecords extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get exerciseName => text()();
  RealColumn get value => real()();
  TextColumn get unit => text()();
  DateTimeColumn get achievedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- DAOs ---

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase> with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);
}

@DriftAccessor(tables: [SyncDeadLetter])
class SyncDeadLetterDao extends DatabaseAccessor<AppDatabase> with _$SyncDeadLetterDaoMixin {
  SyncDeadLetterDao(super.db);
}

@DriftAccessor(tables: [FoodLogs])
class FoodLogsDao extends DatabaseAccessor<AppDatabase> with _$FoodLogsDaoMixin {
  FoodLogsDao(super.db);
}

@DriftAccessor(tables: [FoodItems])
class FoodItemsDao extends DatabaseAccessor<AppDatabase> with _$FoodItemsDaoMixin {
  FoodItemsDao(super.db);
}

@DriftAccessor(tables: [WorkoutLogs])
class WorkoutLogsDao extends DatabaseAccessor<AppDatabase> with _$WorkoutLogsDaoMixin {
  WorkoutLogsDao(super.db);
}

@DriftAccessor(tables: [StepLogs])
class StepLogsDao extends DatabaseAccessor<AppDatabase> with _$StepLogsDaoMixin {
  StepLogsDao(super.db);
}

@DriftAccessor(tables: [SleepLogs])
class SleepLogsDao extends DatabaseAccessor<AppDatabase> with _$SleepLogsDaoMixin {
  SleepLogsDao(super.db);
}

@DriftAccessor(tables: [MoodLogs])
class MoodLogsDao extends DatabaseAccessor<AppDatabase> with _$MoodLogsDaoMixin {
  MoodLogsDao(super.db);
}

@DriftAccessor(tables: [Habits])
class HabitsDao extends DatabaseAccessor<AppDatabase> with _$HabitsDaoMixin {
  HabitsDao(super.db);
}

@DriftAccessor(tables: [HabitCompletions])
class HabitCompletionsDao extends DatabaseAccessor<AppDatabase> with _$HabitCompletionsDaoMixin {
  HabitCompletionsDao(super.db);
}

@DriftAccessor(tables: [BodyMeasurements])
class BodyMeasurementsDao extends DatabaseAccessor<AppDatabase> with _$BodyMeasurementsDaoMixin {
  BodyMeasurementsDao(super.db);
}

@DriftAccessor(tables: [Medications])
class MedicationsDao extends DatabaseAccessor<AppDatabase> with _$MedicationsDaoMixin {
  MedicationsDao(super.db);
}

@DriftAccessor(tables: [FastingLogs])
class FastingLogsDao extends DatabaseAccessor<AppDatabase> with _$FastingLogsDaoMixin {
  FastingLogsDao(super.db);
}

@DriftAccessor(tables: [MealPlans])
class MealPlansDao extends DatabaseAccessor<AppDatabase> with _$MealPlansDaoMixin {
  MealPlansDao(super.db);
}

@DriftAccessor(tables: [Recipes])
class RecipesDao extends DatabaseAccessor<AppDatabase> with _$RecipesDaoMixin {
  RecipesDao(super.db);
}

@DriftAccessor(tables: [BloodPressureLogs])
class BloodPressureLogsDao extends DatabaseAccessor<AppDatabase> with _$BloodPressureLogsDaoMixin {
  BloodPressureLogsDao(super.db);
}

@DriftAccessor(tables: [GlucoseLogs])
class GlucoseLogsDao extends DatabaseAccessor<AppDatabase> with _$GlucoseLogsDaoMixin {
  GlucoseLogsDao(super.db);
}

@DriftAccessor(tables: [Spo2Logs])
class Spo2LogsDao extends DatabaseAccessor<AppDatabase> with _$Spo2LogsDaoMixin {
  Spo2LogsDao(super.db);
}

@DriftAccessor(tables: [PeriodLogs])
class PeriodLogsDao extends DatabaseAccessor<AppDatabase> with _$PeriodLogsDaoMixin {
  PeriodLogsDao(super.db);
}

@DriftAccessor(tables: [JournalEntries])
class JournalEntriesDao extends DatabaseAccessor<AppDatabase> with _$JournalEntriesDaoMixin {
  JournalEntriesDao(super.db);
}

@DriftAccessor(tables: [DoctorAppointments])
class DoctorAppointmentsDao extends DatabaseAccessor<AppDatabase> with _$DoctorAppointmentsDaoMixin {
  DoctorAppointmentsDao(super.db);
}

@DriftAccessor(tables: [LabReports])
class LabReportsDao extends DatabaseAccessor<AppDatabase> with _$LabReportsDaoMixin {
  LabReportsDao(super.db);
}

@DriftAccessor(tables: [AbhaLinks])
class AbhaLinksDao extends DatabaseAccessor<AppDatabase> with _$AbhaLinksDaoMixin {
  AbhaLinksDao(super.db);
}

@DriftAccessor(tables: [EmergencyCard])
class EmergencyCardDao extends DatabaseAccessor<AppDatabase> with _$EmergencyCardDaoMixin {
  EmergencyCardDao(super.db);
}

@DriftAccessor(tables: [FestivalCalendar])
class FestivalCalendarDao extends DatabaseAccessor<AppDatabase> with _$FestivalCalendarDaoMixin {
  FestivalCalendarDao(super.db);
}

@DriftAccessor(tables: [RemoteConfigCache])
class RemoteConfigCacheDao extends DatabaseAccessor<AppDatabase> with _$RemoteConfigCacheDaoMixin {
  RemoteConfigCacheDao(super.db);
}

@DriftAccessor(tables: [KarmaTransactions])
class KarmaTransactionsDao extends DatabaseAccessor<AppDatabase> with _$KarmaTransactionsDaoMixin {
  KarmaTransactionsDao(super.db);
}

@DriftAccessor(tables: [NutritionGoals])
class NutritionGoalsDao extends DatabaseAccessor<AppDatabase> with _$NutritionGoalsDaoMixin {
  NutritionGoalsDao(super.db);
}

@DriftAccessor(tables: [PersonalRecords])
class PersonalRecordsDao extends DatabaseAccessor<AppDatabase> with _$PersonalRecordsDaoMixin {
  PersonalRecordsDao(super.db);
}

// --- Database Class ---

@DriftDatabase(
  tables: [
    FoodLogs, FoodItems, WorkoutLogs, StepLogs, SleepLogs, MoodLogs,
    Habits, HabitCompletions, BodyMeasurements, Medications, FastingLogs, MealPlans, Recipes,
    BloodPressureLogs, GlucoseLogs, Spo2Logs, PeriodLogs, JournalEntries, DoctorAppointments,
    LabReports, AbhaLinks,
    EmergencyCard, FestivalCalendar, RemoteConfigCache,
    KarmaTransactions, NutritionGoals, PersonalRecords, SyncQueue, SyncDeadLetter,
  ],
  daos: [
    FoodLogsDao, FoodItemsDao, WorkoutLogsDao, StepLogsDao, SleepLogsDao, MoodLogsDao,
    HabitsDao, HabitCompletionsDao, BodyMeasurementsDao, MedicationsDao, FastingLogsDao, MealPlansDao, RecipesDao,
    BloodPressureLogsDao, GlucoseLogsDao, Spo2LogsDao, PeriodLogsDao, JournalEntriesDao, DoctorAppointmentsDao,
    LabReportsDao, AbhaLinksDao,
    EmergencyCardDao, FestivalCalendarDao, RemoteConfigCacheDao,
    KarmaTransactionsDao, NutritionGoalsDao, PersonalRecordsDao, SyncQueueDao, SyncDeadLetterDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(String encryptionKey) : super(_openConnection(encryptionKey));

  @override
  int get schemaVersion => 6;

  static QueryExecutor _openConnection(String encryptionKey) {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'fitkarma.db'));
      
      return NativeDatabase.createInBackground(
        file,
        setup: (rawDb) {
          rawDb.execute("PRAGMA key = '$encryptionKey'");
          rawDb.execute("PRAGMA cipher_page_size = 4096");
        },
      );
    });
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();

        // FTS5 Implementation from Section 7.4
        await customStatement('''
          CREATE VIRTUAL TABLE food_items_fts USING fts5(
            name,
            name_local,
            content="food_items",
            content_rowid="rowid"
          )
        ''');

        // FTS Triggers
        await customStatement('''
          CREATE TRIGGER food_items_ai AFTER INSERT ON food_items BEGIN
            INSERT INTO food_items_fts(rowid, name, name_local)
            VALUES (new.rowid, new.name, new.name_local);
          END
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_ad AFTER DELETE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
            VALUES ('delete', old.rowid, old.name, old.name_local);
          END
        ''');
        await customStatement('''
          CREATE TRIGGER food_items_au AFTER UPDATE ON food_items BEGIN
            INSERT INTO food_items_fts(food_items_fts, rowid, name, name_local)
            VALUES ('delete', old.rowid, old.name, old.name_local);
            INSERT INTO food_items_fts(rowid, name, name_local)
            VALUES (new.rowid, new.name, new.name_local);
          END
        ''');

        // Composite Indices for Performance
        await customStatement('CREATE INDEX IF NOT EXISTS food_logs_user_logged_at ON food_logs (user_id, logged_at DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS step_logs_user_date ON step_logs (user_id, "date" DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS workout_logs_user_logged_at ON workout_logs (user_id, logged_at DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS mood_logs_user_logged_at ON mood_logs (user_id, logged_at DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS sleep_logs_user_date ON sleep_logs (user_id, "date" DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS blood_pressure_logs_user_logged_at ON blood_pressure_logs (user_id, logged_at DESC);');
        await customStatement('CREATE INDEX IF NOT EXISTS glucose_logs_user_logged_at ON glucose_logs (user_id, logged_at DESC);');
      },
      onUpgrade: (m, from, to) async {
        if (from < 2) {
          await m.addColumn(foodLogs, foodLogs.idempotencyKey);
          await m.addColumn(foodLogs, foodLogs.fieldVersions);
        }
        if (from < 3) {
          await m.addColumn(sleepLogs, sleepLogs.sleepDebtMin);
          await m.createTable(labReports);
        }
        if (from < 4) {
          await m.createTable(bloodPressureLogs);
          await m.createTable(glucoseLogs);
          await m.createTable(spo2Logs);
          await m.createTable(periodLogs);
          await m.createTable(journalEntries);
          await m.createTable(doctorAppointments);
        }
        if (from < 5) {
          await m.createTable(abhaLinks);
          await m.createTable(emergencyCard);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCache);
        }

        if (from < 6) {
          await customStatement('CREATE INDEX IF NOT EXISTS food_logs_user_logged_at ON food_logs (user_id, logged_at DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS step_logs_user_date ON step_logs (user_id, "date" DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS workout_logs_user_logged_at ON workout_logs (user_id, logged_at DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS mood_logs_user_logged_at ON mood_logs (user_id, logged_at DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS sleep_logs_user_date ON sleep_logs (user_id, "date" DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS blood_pressure_logs_user_logged_at ON blood_pressure_logs (user_id, logged_at DESC);');
          await customStatement('CREATE INDEX IF NOT EXISTS glucose_logs_user_logged_at ON glucose_logs (user_id, logged_at DESC);');
        }
      },
    );
  }

  // FTS5 Search Query
  Future<List<FoodItem>> searchFoodFts(String query) {
    final ftsQuery = query.trim().split(' ').map((t) => '$t*').join(' ');
    return customSelect(
      '''
      SELECT fi.* FROM food_items fi
      JOIN food_items_fts fts ON fi.rowid = fts.rowid
      WHERE food_items_fts MATCH ?
      ORDER BY bm25(food_items_fts)
      LIMIT 50
      ''',
      variables: [Variable.withString(ftsQuery)],
    ).map((row) => FoodItem.fromData(row.data)).get();
  }
}
