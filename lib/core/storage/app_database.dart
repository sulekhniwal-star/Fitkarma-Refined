import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';

import '../security/encryption_service.dart';
import '../security/key_manager.dart';

part 'app_database.g.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// SECURITY REMINDERS — Appwrite Console Configuration
// ═══════════════════════════════════════════════════════════════════════════════
//
// ⚠️ CRITICAL: These settings MUST be configured in Appwrite Console UI:
//
// 1. COLLECTION PERMISSIONS:
//    - Remove `Create: role:users` from ALL collections
//    - Set permissions ONLY at document creation via API:
//      ```dart
//      await tablesDb.createRow(
//        databaseId: 'fitkarma',
//        tableId: 'food_logs',
//        rowId: ID.unique(),
//        data: {...},
//        permissions: [
//          Permission.read(Role.user(uid)),
//          Permission.write(Role.user(uid)),
//        ],
//      );
//      ```
//
// 2. COMPOSITE INDICES (high-frequency queries):
//    - food_logs:       [userId, loggedAt DESC]
//    - step_logs:       [userId, date DESC]
//    - workout_logs:   [userId, loggedAt DESC]
//    - blood_pressure_logs: [userId, measuredAt DESC]
//    - glucose_logs:    [userId, measuredAt DESC]
//    - mood_logs:       [userId, loggedAt DESC]
//    - sleep_logs:      [userId, date DESC]
//    - journal_entries: [userId, createdAt DESC]
//    - habits:         [userId, createdAt DESC]
//
// 3. Enable AUTHORS attribute on userId columns for RLS
//    - Set authors: ["userId"] on collections
//
// ═══════════════════════════════════════════════════════════════════════════════
// TABLE DEFINITIONS
// ═══════════════════════════════════════════════════════════════════════════════

@TableIndex(name: 'idx_food_logs_user', columns: {#userId, #loggedAt})
class FoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get foodName => text().withLength(min: 1, max: 255)();
  TextColumn get mealType => text().withLength(min: 1, max: 32)();
  RealColumn get quantityG => real()();
  RealColumn get calories => real()();
  RealColumn get proteinG => real()();
  RealColumn get carbsG => real()();
  RealColumn get fatG => real()();
  RealColumn get vitaminDMcg => real().withDefault(const Constant(0))();
  RealColumn get vitaminB12Mcg => real().withDefault(const Constant(0))();
  RealColumn get ironMg => real().withDefault(const Constant(0))();
  RealColumn get calciumMg => real().withDefault(const Constant(0))();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().withLength(min: 1, max: 16)();
  TextColumn get idempotencyKey => text().withLength(min: 1, max: 64)();

  @override
  List<Set<Column>> get uniqueKeys => [{idempotencyKey}];
}

@TableIndex(name: 'idx_food_items_name', columns: {#name})
class FoodItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get nameLocal => text().nullable().withLength(max: 255)();
  TextColumn get region => text().nullable().withLength(max: 32)();
  RealColumn get caloriesPer100g => real()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();
  RealColumn get vitaminDMcg => real().withDefault(const Constant(0))();
  RealColumn get vitaminB12Mcg => real().withDefault(const Constant(0))();
  RealColumn get ironMg => real().withDefault(const Constant(0))();
  RealColumn get calciumMg => real().withDefault(const Constant(0))();
  TextColumn get servingSizesJson => text().nullable().withLength(max: 512)();
}

@TableIndex(name: 'idx_workout_logs_user', columns: {#userId, #loggedAt})
class WorkoutLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  IntColumn get durationMin => integer()();
  RealColumn get caloriesBurned => real()();
  TextColumn get workoutType => text().withLength(min: 1, max: 64)();
  IntColumn get rpe => integer().nullable()();
  TextColumn get routeJson => text().nullable()();
  RealColumn get distanceKm => real().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@TableIndex(name: 'idx_step_logs_user', columns: {#userId, #date})
class StepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get steps => integer()();
  DateTimeColumn get date => dateTime()();
}

@TableIndex(name: 'idx_sleep_logs_user', columns: {#userId, #date})
class SleepLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get durationMin => integer()();
  IntColumn get quality => integer().nullable()();
  DateTimeColumn get date => dateTime()();
}

@TableIndex(name: 'idx_mood_logs_user', columns: {#userId, #loggedAt})
class MoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get moodScore => integer()();
  IntColumn get screenTimeMin => integer().nullable()();
  IntColumn get sleepQuality => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@TableIndex(name: 'idx_bp_logs_user', columns: {#userId, #loggedAt})
class BloodPressureLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get systolic => text().withLength(min: 1, max: 1024)();
  TextColumn get diastolic => text().withLength(min: 1, max: 1024)();
  IntColumn get pulse => integer().nullable()();
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get loggedAt => dateTime()();
}

@TableIndex(name: 'idx_glucose_logs_user', columns: {#userId, #loggedAt})
class GlucoseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get glucoseMgdl => text().withLength(min: 1, max: 1024)();
  TextColumn get mealType => text().nullable()();
  IntColumn get foodLogId => integer().nullable()();
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get loggedAt => dateTime()();
}

class Spo2Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get spo2Percentage => text().withLength(min: 1, max: 1024)();
  IntColumn get pulse => integer().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@TableIndex(name: 'idx_period_logs_user', columns: {#userId, #date})
class PeriodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get date => dateTime()();
  BoolColumn get isPeriodDay => boolean()();
  TextColumn get flowIntensity => text().nullable().withLength(max: 1024)();
  TextColumn get symptoms => text().nullable().withLength(max: 2048)();
  BoolColumn get isPcodPcos => boolean()();
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();
}

@TableIndex(name: 'idx_habit_comp_user', columns: {#userId, #completedAt})
class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer().references(Habits, #id)();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get completedAt => dateTime()();
}

class BodyMeasurements extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  RealColumn get weightKg => real().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
}

@TableIndex(name: 'idx_medications_active', columns: {#userId, #isActive})
class Medications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  BoolColumn get isActive => boolean()();
}

class FastingLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get fastStart => dateTime()();
  BoolColumn get completed => boolean().nullable()();
  DateTimeColumn get fastEnd => dateTime().nullable()();
}

@TableIndex(name: 'idx_meal_plans_user', columns: {#userId, #weekStartDate})
class MealPlans extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get weekStartDate => dateTime()();
}

class Recipes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get title => text().withLength(min: 1, max: 255)();
}

class CustomWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get category => text().withLength(min: 1, max: 64)();
  IntColumn get estimatedDurationMin => integer()();
  TextColumn get exercisesJson => text()();
  DateTimeColumn get createdAt => dateTime()();
}

class ScheduledWorkouts extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get title => text().withLength(min: 1, max: 255)();
  TextColumn get workoutType => text().withLength(min: 1, max: 64)();
  DateTimeColumn get scheduledDate => dateTime()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isRestDay => boolean().withDefault(const Constant(false))();
}

@TableIndex(name: 'idx_journal_user', columns: {#userId, #createdAt})
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get content => text().withLength(min: 1, max: 10240)();
  DateTimeColumn get createdAt => dateTime()();
}

class DoctorAppointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get doctorName => text().withLength(min: 1, max: 128)();
}

@TableIndex(name: 'idx_karma_user', columns: {#userId, #createdAt})
class KarmaTransactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get amount => integer()();
  DateTimeColumn get createdAt => dateTime()();
}

class NutritionGoals extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  RealColumn get calorieGoal => real()();
  RealColumn get carbsPercent => real().withDefault(const Constant(55))();
  RealColumn get proteinPercent => real().withDefault(const Constant(20))();
  RealColumn get fatPercent => real().withDefault(const Constant(25))();
  RealColumn get carbsGrams => real().nullable()();
  RealColumn get proteinGrams => real().nullable()();
  RealColumn get fatGrams => real().nullable()();
  RealColumn get ironMgRda => real().withDefault(const Constant(18))();
  RealColumn get vitaminDMcgRda => real().withDefault(const Constant(15))();
  RealColumn get vitaminB12McgRda => real().withDefault(const Constant(2.4))();
  RealColumn get calciumMgRda => real().withDefault(const Constant(1000))();
  DateTimeColumn get updatedAt => dateTime()();
}

@TableIndex(name: 'idx_pr_user_type', columns: {#userId, #recordType})
class PersonalRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get recordType => text().withLength(min: 1, max: 32)();
  DateTimeColumn get achievedAt => dateTime()();
}

class RemoteConfigCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().withLength(min: 1, max: 128)();
  TextColumn get value => text().withLength(min: 1, max: 4096)();
  TextColumn get type => text().withLength(min: 1, max: 16)();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [{key}];
}

class InsightFeedback extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get odUserId => text().withLength(min: 1, max: 64)();
  TextColumn get ruleId => text().withLength(min: 1, max: 64)();
  BoolColumn get thumbsUp => boolean().withDefault(const Constant(false))();
  BoolColumn get thumbsDown => boolean().withDefault(const Constant(false))();
  DateTimeColumn get generatedAt => dateTime()();
}

class LabReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get reportName => text().withLength(min: 1, max: 255)();
  TextColumn get reportUrl => text().nullable().withLength(max: 512)();
  DateTimeColumn get uploadedAt => dateTime()();
  TextColumn get labName => text().nullable().withLength(max: 128)();
  TextColumn get summaryJson => text().nullable().withLength(max: 8192)();
}

class AbhaLinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get abhaNumber => text().withLength(min: 1, max: 20)();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get linkedAt => dateTime()();
}

class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get odUserId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get gender => text().withLength(min: 1, max: 16)();
  DateTimeColumn get dateOfBirth => dateTime()();
  RealColumn get heightCm => real()();
  RealColumn get weightKg => real()();
  TextColumn get fitnessGoal => text().withLength(min: 1, max: 32)();
  TextColumn get activityLevel => text().withLength(min: 1, max: 32)();
  TextColumn get chronicConditions => text().withLength(max: 512)();
  IntColumn get vataPercent => integer()();
  IntColumn get pittaPercent => integer()();
  IntColumn get kaphaPercent => integer()();
  TextColumn get language => text().withLength(min: 2, max: 10)();
  BoolColumn get stepCounterPermission => boolean().withDefault(const Constant(false))();
  BoolColumn get heartRatePermission => boolean().withDefault(const Constant(false))();
  BoolColumn get sleepPermission => boolean().withDefault(const Constant(false))();
  TextColumn get abhaNumber => text().nullable().withLength(max: 20)();
  BoolColumn get wearableConnected => boolean().withDefault(const Constant(false))();
  IntColumn get karmaXp => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [{odUserId}];
}

class EmergencyCard extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get bloodGroup => text().nullable().withLength(max: 8)();
  TextColumn get allergies => text().nullable().withLength(max: 1024)();
  TextColumn get emergencyContact => text().nullable().withLength(max: 20)();
  TextColumn get conditions => text().nullable().withLength(max: 1024)();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [{userId}];
}

@TableIndex(name: 'idx_festival_date', columns: {#date})
class FestivalCalendar extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  DateTimeColumn get date => dateTime()();
  TextColumn get region => text().nullable().withLength(max: 64)();
  TextColumn get type => text().nullable().withLength(max: 32)();
}

@TableIndex(name: 'idx_sync_queue_status', columns: {#status})
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recordTable => text().withLength(min: 1, max: 64)();
  IntColumn get recordId => integer()();
  TextColumn get operation => text().withLength(min: 1, max: 16)();
  TextColumn get payloadJson => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withLength(min: 1, max: 16)();
  IntColumn get priority => integer().withDefault(const Constant(2))();
  TextColumn get idempotencyKey => text().withLength(min: 1, max: 64)();
  TextColumn get errorMessage => text().nullable().withLength(max: 512)();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

class SyncDeadLetter extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get recordTable => text().withLength(min: 1, max: 64)();
  IntColumn get recordId => integer()();
  TextColumn get operation => text().withLength(min: 1, max: 16)();
  TextColumn get payloadJson => text()();
  TextColumn get error => text()();
  DateTimeColumn get failedAt => dateTime()();
}

// FTS5 virtual table reference
class FoodItemsFts extends Table {
  IntColumn get rowid => integer()();
  TextColumn get name => text()();
  RealColumn get caloriesPer100g => real()();
  RealColumn get proteinPer100g => real()();
  RealColumn get carbsPer100g => real()();
  RealColumn get fatPer100g => real()();

  @override
  String? get tableName => 'food_items_fts';

  @override
  Set<Column> get primaryKey => {rowid};
}

// ═══════════════════════════════════════════════════════════════════════════════
// DAOs
// ═══════════════════════════════════════════════════════════════════════════════

// --- Core DAOs ---

@DriftAccessor(tables: [FoodLogs])
class FoodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$FoodLogsDaoMixin {
  FoodLogsDao(super.db);

  Future<List<FoodLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(foodLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<FoodLog>> watchLogsForUser(String userId) {
    return (select(foodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();
  }

  Future<int> insertLog(FoodLogsCompanion entry) =>
      into(foodLogs).insert(entry);

  Future<bool> updateLog(FoodLogsCompanion entry) =>
      update(foodLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(foodLogs)..where((t) => t.id.equals(id))).go();

  Future<List<FoodLog>> getPendingSync(String userId) =>
      (select(foodLogs)
            ..where((t) =>
                t.userId.equals(userId) & t.syncStatus.equals('pending')))
          .get();
}

@DriftAccessor(tables: [FoodItems])
class FoodItemsDao extends DatabaseAccessor<AppDatabase>
    with _$FoodItemsDaoMixin {
  FoodItemsDao(super.db);

  Future<List<FoodItem>> searchByName(String query) =>
      (select(foodItems)..where((t) => t.name.like('%$query%'))).get();

  Future<List<FoodItem>> getAll() => select(foodItems).get();

  Future<int> insertItem(FoodItemsCompanion entry) =>
      into(foodItems).insert(entry);
}

@DriftAccessor(tables: [WorkoutLogs])
class WorkoutLogsDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutLogsDaoMixin {
  WorkoutLogsDao(super.db);

  Future<List<WorkoutLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(workoutLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<WorkoutLog>> watchLogsForUser(String userId) =>
      (select(workoutLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();

  Future<int> insertLog(WorkoutLogsCompanion entry) =>
      into(workoutLogs).insert(entry);

  Future<bool> updateLog(WorkoutLogsCompanion entry) =>
      update(workoutLogs).replace(entry);

  Future<int> deleteLog(int id) =>
      (delete(workoutLogs)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [StepLogs])
class StepLogsDao extends DatabaseAccessor<AppDatabase>
    with _$StepLogsDaoMixin {
  StepLogsDao(super.db);

  Future<List<StepLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(stepLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<StepLog>> watchLogsForUser(String userId) =>
      (select(stepLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  Future<int> insertLog(StepLogsCompanion entry) =>
      into(stepLogs).insert(entry);

  Future<int> getTotalStepsForDate(String userId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final result = await (selectOnly(stepLogs)
          ..addColumns([stepLogs.steps.sum()])
          ..where(stepLogs.userId.equals(userId) &
              stepLogs.date.isBiggerOrEqualValue(dayStart) &
              stepLogs.date.isSmallerThanValue(dayEnd)))
        .getSingle();
    return result.read(stepLogs.steps.sum()) ?? 0;
  }
}

@DriftAccessor(tables: [SleepLogs])
class SleepLogsDao extends DatabaseAccessor<AppDatabase>
    with _$SleepLogsDaoMixin {
  SleepLogsDao(super.db);

  Future<List<SleepLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(sleepLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<SleepLog>> watchLogsForUser(String userId) =>
      (select(sleepLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
        .watch();

  Future<int> insertLog(SleepLogsCompanion entry) =>
      into(sleepLogs).insert(entry);
}

@DriftAccessor(tables: [MoodLogs])
class MoodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$MoodLogsDaoMixin {
  MoodLogsDao(super.db);

  Future<List<MoodLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(moodLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<MoodLog>> watchLogsForUser(String userId) =>
      (select(moodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
        .watch();

  Future<int> insertLog(MoodLogsCompanion entry) =>
      into(moodLogs).insert(entry);
}

// --- Lifestyle DAOs ---

@DriftAccessor(tables: [Habits, HabitCompletions])
class HabitsDao extends DatabaseAccessor<AppDatabase>
    with _$HabitsDaoMixin {
  HabitsDao(super.db);

  Future<List<Habit>> getActiveHabits(String userId) =>
      (select(habits)
            ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
          .get();

  Stream<List<Habit>> watchActiveHabits(String userId) =>
      (select(habits)
            ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
        .watch();

  Future<int> insertHabit(HabitsCompanion entry) =>
      into(habits).insert(entry);

  Future<int> deleteHabit(int id) =>
      (delete(habits)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [HabitCompletions])
class HabitCompletionsDao extends DatabaseAccessor<AppDatabase>
    with _$HabitCompletionsDaoMixin {
  HabitCompletionsDao(super.db);

  Future<int> markComplete(HabitCompletionsCompanion entry) =>
      into(habitCompletions).insert(entry);

  Future<List<HabitCompletion>> getCompletionsForDate(
      String userId, DateTime date) {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    return (select(habitCompletions)
          ..where((t) =>
              t.userId.equals(userId) &
              t.completedAt.isBiggerOrEqualValue(dayStart) &
              t.completedAt.isSmallerThanValue(dayEnd)))
        .get();
  }

  Future<bool> isCompletedToday(int habitId, DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final result = await (select(habitCompletions)
          ..where((t) =>
              t.habitId.equals(habitId) &
              t.completedAt.isBiggerOrEqualValue(dayStart) &
              t.completedAt.isSmallerThanValue(dayEnd)))
        .get();
    return result.isNotEmpty;
  }
}

@DriftAccessor(tables: [BodyMeasurements])
class BodyMeasurementsDao extends DatabaseAccessor<AppDatabase>
    with _$BodyMeasurementsDaoMixin {
  BodyMeasurementsDao(super.db);

  Future<List<BodyMeasurement>> getMeasurementsForUser(String userId) =>
      (select(bodyMeasurements)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
          .get();

  Future<int> insertMeasurement(BodyMeasurementsCompanion entry) =>
      into(bodyMeasurements).insert(entry);
}

@DriftAccessor(tables: [Medications])
class MedicationsDao extends DatabaseAccessor<AppDatabase>
    with _$MedicationsDaoMixin {
  MedicationsDao(super.db);

  Future<List<Medication>> getActiveMedications(String userId) =>
      (select(medications)
            ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
          .get();

  Future<int> insertMedication(MedicationsCompanion entry) =>
      into(medications).insert(entry);

  Future<bool> updateMedication(MedicationsCompanion entry) =>
      update(medications).replace(entry);
}

@DriftAccessor(tables: [FastingLogs])
class FastingLogsDao extends DatabaseAccessor<AppDatabase>
    with _$FastingLogsDaoMixin {
  FastingLogsDao(super.db);

  Future<List<FastingLog>> getLogsForUser(String userId) =>
      (select(fastingLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.fastStart)]))
          .get();

  Future<int> insertLog(FastingLogsCompanion entry) =>
      into(fastingLogs).insert(entry);

  Future<bool> updateLog(FastingLogsCompanion entry) =>
      update(fastingLogs).replace(entry);

  Future<FastingLog?> getActiveFast(String userId) async {
    final results = await (select(fastingLogs)
          ..where((t) => t.userId.equals(userId) & t.fastEnd.isNull())
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }
}

@DriftAccessor(tables: [MealPlans])
class MealPlansDao extends DatabaseAccessor<AppDatabase>
    with _$MealPlansDaoMixin {
  MealPlansDao(super.db);

  Future<List<MealPlan>> getPlansForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(mealPlans)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.weekStartDate)]);
    if (from != null) {
      query.where((t) => t.weekStartDate.isBiggerOrEqualValue(from));
    }
    if (to != null) {
      query.where((t) => t.weekStartDate.isSmallerOrEqualValue(to));
    }
    return query.get();
  }

  Future<int> insertPlan(MealPlansCompanion entry) =>
      into(mealPlans).insert(entry);
}

@DriftAccessor(tables: [Recipes])
class RecipesDao extends DatabaseAccessor<AppDatabase>
    with _$RecipesDaoMixin {
  RecipesDao(super.db);

  Future<List<Recipe>> getRecipesForUser(String userId) =>
      (select(recipes)..where((t) => t.userId.equals(userId))).get();

  Future<int> insertRecipe(RecipesCompanion entry) =>
      into(recipes).insert(entry);

  Future<int> deleteRecipe(int id) =>
      (delete(recipes)..where((t) => t.id.equals(id))).go();
}

// --- Health (Encrypted) DAOs ---

@DriftAccessor(tables: [BloodPressureLogs])
class BloodPressureLogsDao extends DatabaseAccessor<AppDatabase>
    with _$BloodPressureLogsDaoMixin {
  BloodPressureLogsDao(super.db);

  Future<List<BloodPressureLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(bloodPressureLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<BloodPressureLog>> watchLogsForUser(String userId) =>
      (select(bloodPressureLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .watch();

  Future<int> insertLog(BloodPressureLogsCompanion entry) =>
      into(bloodPressureLogs).insert(entry);

  Future<int> insertLogEncrypted({
    required String userId,
    required int systolic,
    required int diastolic,
    int? pulse,
  }) async {
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bp);
    
    final encSys = await EncryptionHelper.encryptField(systolic.toString(), key);
    final encDia = await EncryptionHelper.encryptField(diastolic.toString(), key);
    
    return into(bloodPressureLogs).insert(
      BloodPressureLogsCompanion.insert(
        userId: userId,
        systolic: base64Encode(encSys),
        diastolic: base64Encode(encDia),
        pulse: Value(pulse),
        isEncrypted: const Value(true),
        loggedAt: DateTime.now(),
      ),
    );
  }

  Future<int> insertLogWithKarma({
    required String userId,
    required int systolic,
    required int diastolic,
    int? pulse,
  }) async {
    final id = await insertLogEncrypted(
      userId: userId,
      systolic: systolic,
      diastolic: diastolic,
      pulse: pulse,
    );
    
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: userId,
        amount: 5,
        createdAt: DateTime.now(),
      ),
    );
    
    return id;
  }

  Future<List<DecryptedBPLog>> getLogsForUserDecrypted(String userId,
      {DateTime? from, DateTime? to}) async {
    final logs = await getLogsForUser(userId, from: from, to: to);
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bp);
    
    final decryptedLogs = <DecryptedBPLog>[];
    for (final l in logs) {
      String sys = l.systolic;
      String dia = l.diastolic;
      
      if (l.isEncrypted) {
        try {
          final sysBytes = base64Decode(l.systolic);
          final diaBytes = base64Decode(l.diastolic);
          sys = await EncryptionHelper.decryptField(sysBytes, key);
          dia = await EncryptionHelper.decryptField(diaBytes, key);
        } catch (e) {
          debugPrint('BP decryption failed: $e');
        }
      }
      
      decryptedLogs.add(DecryptedBPLog(
        id: l.id,
        userId: l.userId,
        systolic: sys,
        diastolic: dia,
        pulse: l.pulse,
        isEncrypted: l.isEncrypted,
        loggedAt: l.loggedAt,
      ));
    }
    
    return decryptedLogs;
  }

  Future<Map<String, dynamic>> getStatistics(String userId) async {
    final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final ninetyDaysAgo = DateTime.now().subtract(const Duration(days: 90));

    final logs7 = await getLogsForUser(userId, from: sevenDaysAgo);
    final logs30 = await getLogsForUser(userId, from: thirtyDaysAgo);
    final logs90 = await getLogsForUser(userId, from: ninetyDaysAgo);

    double avg7Sys = 0, avg7Dia = 0;
    double avg30Sys = 0, avg30Dia = 0;
    double avg90Sys = 0, avg90Dia = 0;

    if (logs7.isNotEmpty) {
      final sys7 = logs7.map((l) => int.tryParse(l.systolic) ?? 0).where((s) => s > 0);
      final dia7 = logs7.map((l) => int.tryParse(l.diastolic) ?? 0).where((d) => d > 0);
      if (sys7.isNotEmpty) avg7Sys = sys7.reduce((a, b) => a + b) / sys7.length;
      if (dia7.isNotEmpty) avg7Dia = dia7.reduce((a, b) => a + b) / dia7.length;
    }

    if (logs30.isNotEmpty) {
      final sys30 = logs30.map((l) => int.tryParse(l.systolic) ?? 0).where((s) => s > 0);
      final dia30 = logs30.map((l) => int.tryParse(l.diastolic) ?? 0).where((d) => d > 0);
      if (sys30.isNotEmpty) avg30Sys = sys30.reduce((a, b) => a + b) / sys30.length;
      if (dia30.isNotEmpty) avg30Dia = dia30.reduce((a, b) => a + b) / dia30.length;
    }

    if (logs90.isNotEmpty) {
      final sys90 = logs90.map((l) => int.tryParse(l.systolic) ?? 0).where((s) => s > 0);
      final dia90 = logs90.map((l) => int.tryParse(l.diastolic) ?? 0).where((d) => d > 0);
      if (sys90.isNotEmpty) avg90Sys = sys90.reduce((a, b) => a + b) / sys90.length;
      if (dia90.isNotEmpty) avg90Dia = dia90.reduce((a, b) => a + b) / dia90.length;
    }

    return {
      'avg7Sys': avg7Sys,
      'avg7Dia': avg7Dia,
      'avg30Sys': avg30Sys,
      'avg30Dia': avg30Dia,
      'avg90Sys': avg90Sys,
      'avg90Dia': avg90Dia,
      'count7': logs7.length,
      'count30': logs30.length,
      'count90': logs90.length,
    };
  }
}

class DecryptedBPLog {
  final int id;
  final String userId;
  final String systolic;
  final String diastolic;
  final int? pulse;
  final bool isEncrypted;
  final DateTime loggedAt;

  DecryptedBPLog({
    required this.id,
    required this.userId,
    required this.systolic,
    required this.diastolic,
    this.pulse,
    this.isEncrypted = false,
    required this.loggedAt,
  });

  int get sys => int.tryParse(systolic) ?? 0;
  int get dia => int.tryParse(diastolic) ?? 0;

  BPClassification get classification => classify(sys, dia);

  static BPClassification classify(int systolic, int diastolic) {
    if (systolic >= 180 || diastolic >= 120) {
      return BPClassification.crisis;
    } else if (systolic >= 140 || diastolic >= 90) {
      return BPClassification.stage2;
    } else if (systolic >= 130 || diastolic >= 80) {
      return BPClassification.stage1;
    } else if (systolic >= 120 && systolic < 130 || diastolic >= 80 && diastolic < 90) {
      return BPClassification.elevated;
    } else if (systolic < 120 && diastolic < 80) {
      return BPClassification.normal;
    }
    return BPClassification.normal;
  }

  bool get isCrisis => sys >= 180 || dia >= 120;
  bool get isStage2 => sys >= 140 || dia >= 90;
  bool get isStage1 => sys >= 130 || dia >= 80;
}

enum BPClassification {
  normal,
  elevated,
  stage1,
  stage2,
  crisis,
}

@DriftAccessor(tables: [GlucoseLogs])
class GlucoseLogsDao extends DatabaseAccessor<AppDatabase>
    with _$GlucoseLogsDaoMixin {
  GlucoseLogsDao(super.db);

  Future<List<GlucoseLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(glucoseLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<GlucoseLog>> watchLogsForUser(String userId) =>
      (select(glucoseLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .watch();

  Future<int> insertLog(GlucoseLogsCompanion entry) =>
      into(glucoseLogs).insert(entry);

  Future<int> insertLogEncrypted({
    required String userId,
    required int glucoseMgdl,
    String? mealType,
    int? foodLogId,
  }) async {
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bpGlucose);
    
    final encGlucose = await EncryptionHelper.encryptField(glucoseMgdl.toString(), key);
    
    return into(glucoseLogs).insert(
      GlucoseLogsCompanion.insert(
        userId: userId,
        glucoseMgdl: base64Encode(encGlucose),
        mealType: Value(mealType),
        foodLogId: Value(foodLogId),
        isEncrypted: const Value(true),
        loggedAt: DateTime.now(),
      ),
    );
  }

  Future<int> insertLogWithKarma({
    required String userId,
    required int glucoseMgdl,
    String? mealType,
    int? foodLogId,
  }) async {
    final id = await insertLogEncrypted(
      userId: userId,
      glucoseMgdl: glucoseMgdl,
      mealType: mealType,
      foodLogId: foodLogId,
    );
    
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: userId,
        amount: 5,
        createdAt: DateTime.now(),
      ),
    );
    
    return id;
  }

  Future<List<DecryptedGlucoseLog>> getLogsForUserDecrypted(String userId,
      {DateTime? from, DateTime? to}) async {
    final logs = await getLogsForUser(userId, from: from, to: to);
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bpGlucose);
    
    final decryptedLogs = <DecryptedGlucoseLog>[];
    for (final l in logs) {
      String glucose = l.glucoseMgdl;
      
      if (l.isEncrypted) {
        try {
          final glucoseBytes = base64Decode(l.glucoseMgdl);
          glucose = await EncryptionHelper.decryptField(glucoseBytes, key);
        } catch (e) {
          debugPrint('Glucose decryption failed: $e');
        }
      }
      
      decryptedLogs.add(DecryptedGlucoseLog(
        id: l.id,
        userId: l.userId,
        glucoseMgdl: glucose,
        mealType: l.mealType,
        foodLogId: l.foodLogId,
        isEncrypted: l.isEncrypted,
        loggedAt: l.loggedAt,
      ));
    }
    
    return decryptedLogs;
  }

  Future<Map<String, dynamic>> getStatistics(String userId) async {
    final ninetyDaysAgo = DateTime.now().subtract(const Duration(days: 90));
    final logs = await getLogsForUser(userId, from: ninetyDaysAgo);
    
    double avgGlucose = 0;
    double avgFasting = 0;
    double avgPostMeal = 0;
    double estimatedHbA1c = 0;
    
    final fastingLogs = <int>[];
    final postMealLogs = <int>[];
    final allLogs = <int>[];
    
    for (final log in logs) {
      final g = int.tryParse(log.glucoseMgdl) ?? 0;
      if (g > 0) {
        allLogs.add(g);
        if (log.mealType == 'fasting') {
          fastingLogs.add(g);
        } else if (log.mealType == 'post_meal') {
          postMealLogs.add(g);
        }
      }
    }
    
    if (allLogs.isNotEmpty) {
      avgGlucose = allLogs.reduce((a, b) => a + b) / allLogs.length;
      estimatedHbA1c = (avgGlucose + 46.7) / 28.7;
    }
    if (fastingLogs.isNotEmpty) {
      avgFasting = fastingLogs.reduce((a, b) => a + b) / fastingLogs.length;
    }
    if (postMealLogs.isNotEmpty) {
      avgPostMeal = postMealLogs.reduce((a, b) => a + b) / postMealLogs.length;
    }
    
    return {
      'avgGlucose': avgGlucose,
      'avgFasting': avgFasting,
      'avgPostMeal': avgPostMeal,
      'estimatedHbA1c': estimatedHbA1c,
      'count': logs.length,
    };
  }
}

class DecryptedGlucoseLog {
  final int id;
  final String userId;
  final String glucoseMgdl;
  final String? mealType;
  final int? foodLogId;
  final bool isEncrypted;
  final DateTime loggedAt;

  DecryptedGlucoseLog({
    required this.id,
    required this.userId,
    required this.glucoseMgdl,
    this.mealType,
    this.foodLogId,
    this.isEncrypted = false,
    required this.loggedAt,
  });

  int get glucose => int.tryParse(glucoseMgdl) ?? 0;

  GlucoseClassification get classification {
    if (mealType == 'fasting') {
      return classifyFasting(glucose);
    } else if (mealType == 'post_meal') {
      return classifyPostMeal2h(glucose);
    }
    return classifyRandom(glucose);
  }

  static GlucoseClassification classifyFasting(int glucose) {
    if (glucose < 70) return GlucoseClassification.low;
    if (glucose <= 99) return GlucoseClassification.normal;
    if (glucose <= 125) return GlucoseClassification.prediabetes;
    return GlucoseClassification.diabetes;
  }

  static GlucoseClassification classifyPostMeal2h(int glucose) {
    if (glucose < 70) return GlucoseClassification.low;
    if (glucose <= 139) return GlucoseClassification.normal;
    if (glucose <= 199) return GlucoseClassification.prediabetes;
    return GlucoseClassification.diabetes;
  }

  static GlucoseClassification classifyRandom(int glucose) {
    if (glucose < 70) return GlucoseClassification.low;
    if (glucose <= 139) return GlucoseClassification.normal;
    if (glucose <= 199) return GlucoseClassification.prediabetes;
    return GlucoseClassification.diabetes;
  }

  static double estimateHbA1c(int avgGlucose) {
    return (avgGlucose + 46.7) / 28.7;
  }
}

enum GlucoseClassification {
  low,
  normal,
  prediabetes,
  diabetes,
}

@DriftAccessor(tables: [Spo2Logs])
class Spo2LogsDao extends DatabaseAccessor<AppDatabase>
    with _$Spo2LogsDaoMixin {
  Spo2LogsDao(super.db);

  Future<List<Spo2Log>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(spo2Logs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]);
    if (from != null) query.where((t) => t.loggedAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.loggedAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<Spo2Log>> watchLogsForUser(String userId) =>
      (select(spo2Logs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.loggedAt)]))
          .watch();

  Future<int> insertLog(Spo2LogsCompanion entry) =>
      into(spo2Logs).insert(entry);

  Future<int> insertLogWithKarma({
    required String userId,
    required int spo2Percentage,
    int? pulse,
  }) async {
    final id = await into(spo2Logs).insert(
      Spo2LogsCompanion.insert(
        userId: userId,
        spo2Percentage: spo2Percentage.toString(),
        pulse: Value(pulse),
        loggedAt: DateTime.now(),
      ),
    );
    
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: userId,
        amount: 5,
        createdAt: DateTime.now(),
      ),
    );
    
    return id;
  }

  Future<List<DecryptedSpo2Log>> getLogsForUserDecrypted(String userId,
      {DateTime? from, DateTime? to}) async {
    final logs = await getLogsForUser(userId, from: from, to: to);
    return logs.map((l) => DecryptedSpo2Log(
      id: l.id,
      userId: l.userId,
      spo2Percentage: l.spo2Percentage,
      pulse: l.pulse,
      loggedAt: l.loggedAt,
    )).toList();
  }
}

class DecryptedSpo2Log {
  final int id;
  final String userId;
  final String spo2Percentage;
  final int? pulse;
  final DateTime loggedAt;

  DecryptedSpo2Log({
    required this.id,
    required this.userId,
    required this.spo2Percentage,
    this.pulse,
    required this.loggedAt,
  });

  int get spo2 => int.tryParse(spo2Percentage) ?? 0;

  Spo2Classification get classification {
    if (spo2 < 90) return Spo2Classification.critical;
    if (spo2 < 95) return Spo2Classification.low;
    return Spo2Classification.normal;
  }

  bool get isLow => spo2 < 95;
  bool get isCritical => spo2 < 90;
}

enum Spo2Classification {
  normal,
  low,
  critical,
}

@DriftAccessor(tables: [PeriodLogs])
class PeriodLogsDao extends DatabaseAccessor<AppDatabase>
    with _$PeriodLogsDaoMixin {
  PeriodLogsDao(super.db);

  Future<List<PeriodLog>> getLogsForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(periodLogs)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.date)]);
    if (from != null) query.where((t) => t.date.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.date.isSmallerOrEqualValue(to));
    return query.get();
  }

  Future<int> insertLog(PeriodLogsCompanion entry) =>
      into(periodLogs).insert(entry);
}

@DriftAccessor(tables: [JournalEntries])
class JournalEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$JournalEntriesDaoMixin {
  JournalEntriesDao(super.db);

  Future<List<JournalEntry>> getEntriesForUser(String userId,
      {DateTime? from, DateTime? to}) {
    final query = select(journalEntries)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (from != null) query.where((t) => t.createdAt.isBiggerOrEqualValue(from));
    if (to != null) query.where((t) => t.createdAt.isSmallerOrEqualValue(to));
    return query.get();
  }

  Stream<List<JournalEntry>> watchEntriesForUser(String userId) =>
      (select(journalEntries)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();

  Future<int> insertEntry(JournalEntriesCompanion entry) =>
      into(journalEntries).insert(entry);

  Future<bool> updateEntry(JournalEntriesCompanion entry) =>
      update(journalEntries).replace(entry);

  Future<int> deleteEntry(int id) =>
      (delete(journalEntries)..where((t) => t.id.equals(id))).go();

  Future<int> insertEntryEncrypted(JournalEntriesCompanion entry) {
    return into(journalEntries).insert(entry);
  }

  Future<List<JournalEntry>> getEntriesForUserDecrypted(String userId,
      {DateTime? from, DateTime? to}) async {
    return getEntriesForUser(userId, from: from, to: to);
  }
}

@DriftAccessor(tables: [DoctorAppointments])
class DoctorAppointmentsDao extends DatabaseAccessor<AppDatabase>
    with _$DoctorAppointmentsDaoMixin {
  DoctorAppointmentsDao(super.db);

  Future<List<DoctorAppointment>> getUpcomingForUser(String userId) =>
      (select(doctorAppointments)
            ..where((t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(DateTime.now()))
            ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
          .get();

  Future<int> insertAppointment(DoctorAppointmentsCompanion entry) =>
      into(doctorAppointments).insert(entry);

  Future<int> deleteAppointment(int id) =>
      (delete(doctorAppointments)..where((t) => t.id.equals(id))).go();
}

// --- India Ecosystem DAOs ---

@DriftAccessor(tables: [LabReports])
class LabReportsDao extends DatabaseAccessor<AppDatabase>
    with _$LabReportsDaoMixin {
  LabReportsDao(super.db);

  Future<List<LabReport>> getReportsForUser(String userId) =>
      (select(labReports)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.uploadedAt)]))
          .get();

  Future<int> insertReport(LabReportsCompanion entry) =>
      into(labReports).insert(entry);

  Future<int> deleteReport(int id) =>
      (delete(labReports)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [AbhaLinks])
class AbhaLinksDao extends DatabaseAccessor<AppDatabase>
    with _$AbhaLinksDaoMixin {
  AbhaLinksDao(super.db);

  Future<AbhaLink?> getLinkForUser(String userId) async {
    final results = await (select(abhaLinks)
          ..where((t) => t.userId.equals(userId))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> insertLink(AbhaLinksCompanion entry) =>
      into(abhaLinks).insert(entry);

  Future<bool> updateLink(AbhaLinksCompanion entry) =>
      update(abhaLinks).replace(entry);
}

// UserProfiles table is defined above (line ~262)
// TODO: Add DAO when Drift generates the mixin properly

// --- Platform DAOs ---

@DriftAccessor(tables: [EmergencyCard])
class EmergencyCardDao extends DatabaseAccessor<AppDatabase>
    with _$EmergencyCardDaoMixin {
  EmergencyCardDao(super.db);

  Future<EmergencyCardData?> getCardForUser(String userId) async {
    final results = await (select(emergencyCard)
          ..where((t) => t.userId.equals(userId))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> insertCard(EmergencyCardCompanion entry) =>
      into(emergencyCard).insert(entry);

  Future<bool> updateCard(EmergencyCardCompanion entry) =>
      update(emergencyCard).replace(entry);

  Future<int> insertCardEncrypted(EmergencyCardCompanion entry) {
    return into(emergencyCard).insert(entry);
  }

  Future<EmergencyCardData?> getCardForUserDecrypted(String userId) async {
    return getCardForUser(userId);
  }
}

@DriftAccessor(tables: [FestivalCalendar])
class FestivalCalendarDao extends DatabaseAccessor<AppDatabase>
    with _$FestivalCalendarDaoMixin {
  FestivalCalendarDao(super.db);

  Future<List<FestivalCalendarData>> getFestivalsForMonth(
      DateTime monthStart) {
    final monthEnd = DateTime(monthStart.year, monthStart.month + 1);
    return (select(festivalCalendar)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(monthStart) &
              t.date.isSmallerThanValue(monthEnd))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  Future<int> insertFestival(FestivalCalendarCompanion entry) =>
      into(festivalCalendar).insert(entry);
}

@DriftAccessor(tables: [RemoteConfigCache])
class RemoteConfigCacheDao extends DatabaseAccessor<AppDatabase>
    with _$RemoteConfigCacheDaoMixin {
  RemoteConfigCacheDao(super.db);

  Future<RemoteConfigCacheData?> getByKey(String key) async {
    final results = await (select(remoteConfigCache)
          ..where((t) => t.key.equals(key))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> upsertConfig(RemoteConfigCacheCompanion entry) =>
      into(remoteConfigCache).insertOnConflictUpdate(entry);

  Future<List<RemoteConfigCacheData>> getAll() =>
      select(remoteConfigCache).get();
}

// --- Infrastructure DAOs ---

@DriftAccessor(tables: [KarmaTransactions])
class KarmaTransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$KarmaTransactionsDaoMixin {
  KarmaTransactionsDao(super.db);

  Future<List<KarmaTransaction>> getTransactionsForUser(String userId,
      {int? limit}) {
    final query = select(karmaTransactions)
      ..where((t) => t.userId.equals(userId))
      ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
    if (limit != null) query.limit(limit);
    return query.get();
  }

  Future<int> getTotalKarma(String userId) async {
    final result = await (selectOnly(karmaTransactions)
          ..addColumns([karmaTransactions.amount.sum()])
          ..where(karmaTransactions.userId.equals(userId)))
        .getSingle();
    return result.read(karmaTransactions.amount.sum()) ?? 0;
  }

  Future<int> insertTransaction(KarmaTransactionsCompanion entry) =>
      into(karmaTransactions).insert(entry);
}

@DriftAccessor(tables: [NutritionGoals])
class NutritionGoalsDao extends DatabaseAccessor<AppDatabase>
    with _$NutritionGoalsDaoMixin {
  NutritionGoalsDao(super.db);

  Future<NutritionGoal?> getGoalForUser(String userId) async {
    final results = await (select(nutritionGoals)
          ..where((t) => t.userId.equals(userId))
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }

  Future<int> upsertGoal(NutritionGoalsCompanion entry) =>
      into(nutritionGoals).insertOnConflictUpdate(entry);
}

@DriftAccessor(tables: [PersonalRecords])
class PersonalRecordsDao extends DatabaseAccessor<AppDatabase>
    with _$PersonalRecordsDaoMixin {
  PersonalRecordsDao(super.db);

  Future<List<PersonalRecord>> getRecordsForUser(String userId) =>
      (select(personalRecords)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.achievedAt)]))
          .get();

  Future<int> insertRecord(PersonalRecordsCompanion entry) =>
      into(personalRecords).insert(entry);
}

@DriftAccessor(tables: [SyncQueue])
class SyncQueueDao extends DatabaseAccessor<AppDatabase>
    with _$SyncQueueDaoMixin {
  SyncQueueDao(super.db);

  Future<List<SyncQueueData>> getPending({int limit = 50}) =>
      (select(syncQueue)
            ..where((t) => t.status.equals('pending'))
            ..orderBy([
              (t) => OrderingTerm.asc(t.priority),
              (t) => OrderingTerm.asc(t.createdAt)
            ])
            ..limit(limit))
          .get();

  Future<int> getPendingCount() async {
    final result = await (selectOnly(syncQueue)
          ..addColumns([syncQueue.id.count()])
          ..where(syncQueue.status.equals('pending')))
        .getSingle();
    return result.read(syncQueue.id.count()) ?? 0;
  }

  Future<int> enqueue(SyncQueueCompanion entry) =>
      into(syncQueue).insert(entry);

  Future<void> markDone(int id) =>
      (update(syncQueue)..where((t) => t.id.equals(id)))
          .write(const SyncQueueCompanion(status: Value('done')));

  Future<void> markFailed(int id, String error, DateTime now) =>
      (update(syncQueue)..where((t) => t.id.equals(id))).write(
        SyncQueueCompanion(
          status: Value('failed'),
          errorMessage: Value(error),
          lastAttemptAt: Value(now),
        ),
      );

  Future<void> incrementRetry(int id) async {
    final current = await (select(syncQueue)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    await (update(syncQueue)..where((t) => t.id.equals(id))).write(
        SyncQueueCompanion(
          retryCount: Value(current.retryCount + 1),
          lastAttemptAt: Value(DateTime.now()),
        ),
      );
  }
}

@DriftAccessor(tables: [SyncDeadLetter])
class SyncDeadLetterDao extends DatabaseAccessor<AppDatabase>
    with _$SyncDeadLetterDaoMixin {
  SyncDeadLetterDao(super.db);

  Future<List<SyncDeadLetterData>> getAll() =>
      (select(syncDeadLetter)
            ..orderBy([(t) => OrderingTerm.desc(t.failedAt)]))
          .get();

  Future<int> insertDeadLetter(SyncDeadLetterCompanion entry) =>
      into(syncDeadLetter).insert(entry);

  Future<int> retryAndRemove(int id) =>
      (delete(syncDeadLetter)..where((t) => t.id.equals(id))).go();
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN DATABASE
// ═══════════════════════════════════════════════════════════════════════════════

@DriftDatabase(
  tables: [
    FoodLogs,
    FoodItems,
    WorkoutLogs,
    StepLogs,
    SleepLogs,
    MoodLogs,
    BloodPressureLogs,
    GlucoseLogs,
    Spo2Logs,
    PeriodLogs,
    Habits,
    HabitCompletions,
    BodyMeasurements,
    Medications,
    FastingLogs,
    MealPlans,
    Recipes,
    JournalEntries,
    DoctorAppointments,
    KarmaTransactions,
    NutritionGoals,
    PersonalRecords,
    RemoteConfigCache,
    LabReports,
    AbhaLinks,
    UserProfiles,
    EmergencyCard,
    FestivalCalendar,
    SyncQueue,
    SyncDeadLetter,
    FoodItemsFts,
    InsightFeedback,
  ],
  daos: [
    FoodLogsDao,
    FoodItemsDao,
    WorkoutLogsDao,
    StepLogsDao,
    SleepLogsDao,
    MoodLogsDao,
    BloodPressureLogsDao,
    GlucoseLogsDao,
    Spo2LogsDao,
    PeriodLogsDao,
    HabitsDao,
    HabitCompletionsDao,
    BodyMeasurementsDao,
    MedicationsDao,
    FastingLogsDao,
    MealPlansDao,
    RecipesDao,
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
    SyncDeadLetterDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 5;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _createFts5(m);
          await _createFts5Triggers(m);
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from < 2) {
            await m.createTable(habits);
            await m.createTable(habitCompletions);
          }
          if (from < 3) {
            await m.createTable(labReports);
            await m.createTable(abhaLinks);
          }
          if (from < 4) {
            await m.createTable(emergencyCard);
            await m.createTable(festivalCalendar);
            await _createFts5(m);
            await _createFts5Triggers(m);
          }
          if (from < 5) {
            await m.createTable(syncQueue);
            await m.createTable(syncDeadLetter);
          }
        },
      );

  Future<void> _createFts5(Migrator m) async {
    await customStatement('''
      CREATE VIRTUAL TABLE IF NOT EXISTS food_items_fts
      USING fts5(name, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g,
        content='food_items',
        content_rowid='id')
    ''');
  }

  Future<void> _createFts5Triggers(Migrator m) async {
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_ai AFTER INSERT ON food_items BEGIN
        INSERT INTO food_items_fts(rowid, name, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g)
        VALUES (new.id, new.name, new.caloriesPer100g, new.proteinPer100g, new.carbsPer100g, new.fatPer100g);
      END
    ''');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_ad AFTER DELETE ON food_items BEGIN
        INSERT INTO food_items_fts(food_items_fts, rowid, name, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g)
        VALUES ('delete', old.id, old.name, old.caloriesPer100g, old.proteinPer100g, old.carbsPer100g, old.fatPer100g);
      END
    ''');
    await customStatement('''
      CREATE TRIGGER IF NOT EXISTS food_items_au AFTER UPDATE ON food_items BEGIN
        INSERT INTO food_items_fts(food_items_fts, rowid, name, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g)
        VALUES ('delete', old.id, old.name, old.caloriesPer100g, old.proteinPer100g, old.carbsPer100g, old.fatPer100g);
        INSERT INTO food_items_fts(rowid, name, caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g)
        VALUES (new.id, new.name, new.caloriesPer100g, new.proteinPer100g, new.carbsPer100g, new.fatPer100g);
      END
    ''');
  }

  Future<List<FoodItem>> searchFoodItemsFts(String query) async {
    final results = await customSelect(
      '''SELECT food_items.* FROM food_items
         JOIN food_items_fts ON food_items.id = food_items_fts.rowid
         WHERE food_items_fts MATCH ?
         ORDER BY rank''',
      variables: [Variable.withString(query)],
      readsFrom: {foodItems, foodItemsFts},
    ).get();
    return results
        .map((row) => FoodItem(
              id: row.read<int>('id'),
              name: row.read<String>('name'),
              caloriesPer100g: row.read<double>('caloriesPer100g'),
              proteinPer100g: row.read<double>('proteinPer100g'),
              carbsPer100g: row.read<double>('carbsPer100g'),
              fatPer100g: row.read<double>('fatPer100g'),
              vitaminDMcg: row.read<double?>('vitaminDMcg') ?? 0,
              vitaminB12Mcg: row.read<double?>('vitaminB12Mcg') ?? 0,
              ironMg: row.read<double?>('ironMg') ?? 0,
              calciumMg: row.read<double?>('calciumMg') ?? 0,
            ))
        .toList();
  }

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'fitkarma.db');
  }
}
