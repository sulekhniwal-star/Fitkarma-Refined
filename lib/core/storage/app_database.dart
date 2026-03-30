import 'package:drift/drift.dart';

import 'drift_database.dart';
import 'tables.dart';
import 'daos/food_logs_dao.dart';
import 'daos/food_items_dao.dart';
import 'daos/workout_logs_dao.dart';
import 'daos/step_logs_dao.dart';
import 'daos/sleep_logs_dao.dart';
import 'daos/mood_logs_dao.dart';
import 'daos/habits_dao.dart';
import 'daos/body_measurements_dao.dart';
import 'daos/medications_dao.dart';
import 'daos/fasting_logs_dao.dart';
import 'daos/meal_plans_dao.dart';
import 'daos/recipes_dao.dart';
import 'daos/blood_pressure_logs_dao.dart';
import 'daos/glucose_logs_dao.dart';
import 'daos/spo2_logs_dao.dart';
import 'daos/period_logs_dao.dart';
import 'daos/journal_entries_dao.dart';
import 'daos/doctor_appointments_dao.dart';
import 'daos/lab_reports_dao.dart';
import 'daos/abha_links_dao.dart';
import 'daos/emergency_card_dao.dart';
import 'daos/festival_calendar_dao.dart';
import 'daos/remote_config_cache_dao.dart';
import 'daos/karma_transactions_dao.dart';
import 'daos/nutrition_goals_dao.dart';
import 'daos/personal_records_dao.dart';
import 'daos/sync_queue_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    // Core
    FoodLogs,
    FoodItems,
    WorkoutLogs,
    StepLogs,
    // Lifestyle
    SleepLogs,
    MoodLogs,
    Habits,
    HabitCompletions,
    BodyMeasurements,
    Medications,
    FastingLogs,
    MealPlans,
    Recipes,
    // Health (encrypted at DB level via SQLCipher)
    BloodPressureLogs,
    GlucoseLogs,
    Spo2Logs,
    PeriodLogs,
    JournalEntries,
    DoctorAppointments,
    // India ecosystem
    LabReports,
    AbhaLinks,
    // Platform
    EmergencyCard,
    FestivalCalendar,
    RemoteConfigCache,
    // Infrastructure
    KarmaTransactions,
    NutritionGoals,
    PersonalRecords,
    SyncQueue,
    SyncDeadLetter,
  ],
  daos: [
    FoodLogsDao,
    FoodItemsDao,
    WorkoutLogsDao,
    StepLogsDao,
    SleepLogsDao,
    MoodLogsDao,
    HabitsDao,
    BodyMeasurementsDao,
    MedicationsDao,
    FastingLogsDao,
    MealPlansDao,
    RecipesDao,
    BloodPressureLogsDao,
    GlucoseLogsDao,
    Spo2LogsDao,
    PeriodLogsDao,
    JournalEntriesDao,
    DoctorAppointmentsDao,
    LabReportsDao,
    AbhaLinksDao,
    EmergencyCardDao,
    FestivalCalendarDao,
    RemoteConfigCacheDao,
    KarmaTransactionsDao,
    NutritionGoalsDao,
    PersonalRecordsDao,
    SyncQueueDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.executor);

  static Future<AppDatabase> create() async {
    final executor = await _openConnection();
    return AppDatabase._(executor);
  }

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createFtsTables();
        await _createFtsTriggers();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(sleepLogs);
          await m.createTable(moodLogs);
        }
        if (from < 3) {
          await m.createTable(habits);
          await m.createTable(habitCompletions);
          await m.createTable(bodyMeasurements);
          await m.createTable(medications);
        }
        if (from < 4) {
          await m.createTable(bloodPressureLogs);
          await m.createTable(glucoseLogs);
          await m.createTable(spo2Logs);
          await m.createTable(periodLogs);
          await m.createTable(journalEntries);
          await m.createTable(doctorAppointments);
          await m.createTable(labReports);
          await m.createTable(abhaLinks);
        }
        if (from < 5) {
          await m.createTable(fastingLogs);
          await m.createTable(mealPlans);
          await m.createTable(recipes);
          await m.createTable(emergencyCard);
          await m.createTable(festivalCalendar);
          await m.createTable(remoteConfigCache);
          await m.createTable(karmaTransactions);
          await m.createTable(nutritionGoals);
          await m.createTable(personalRecords);
          await m.createTable(syncQueue);
          await m.createTable(syncDeadLetter);
          await _createFtsTables();
          await _createFtsTriggers();
        }
      },
    );
  }

  Future<void> _createFtsTables() async {
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS food_items_fts USING fts5(
        food_item_id UNINDEXED,
        name,
        brand,
        category,
        content='food_items',
        content_rowid='id'
      )
    ''');
  }

  Future<void> _createFtsTriggers() async {
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_ai AFTER INSERT ON food_items BEGIN
        INSERT INTO food_items_fts(food_item_id, name, brand, category)
        VALUES (new.id, new.name, new.brand, new.category);
      END
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_ad AFTER DELETE ON food_items BEGIN
        INSERT INTO food_items_fts(food_items_fts, food_item_id, name, brand, category)
        VALUES ('delete', old.id, old.name, old.brand, old.category);
      END
    ''');

    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_au AFTER UPDATE ON food_items BEGIN
        INSERT INTO food_items_fts(food_items_fts, food_item_id, name, brand, category)
        VALUES ('delete', old.id, old.name, old.brand, old.category);
        INSERT INTO food_items_fts(food_item_id, name, brand, category)
        VALUES (new.id, new.name, new.brand, new.category);
      END
    ''');
  }

  static Future<QueryExecutor> _openConnection() {
    return EncryptedDriftDatabase.open(databaseName: 'fitkarma.db');
  }
}
