import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' hide Table, Column;
import 'package:http/http.dart' as http;

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
  DateTimeColumn get bedTime => dateTime().nullable()();
  DateTimeColumn get wakeTime => dateTime().nullable()();
  DateTimeColumn get date => dateTime()();
}

@TableIndex(name: 'idx_mood_logs_user', columns: {#userId, #loggedAt})
class MoodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  IntColumn get moodScore => integer()();
  IntColumn get energy => integer().nullable()();
  IntColumn get stress => integer().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get voiceNotePath => text().nullable()();
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
  BoolColumn get hasCramps => boolean().nullable()();
  BoolColumn get hasBloating => boolean().nullable()();
  BoolColumn get hasMoodSwings => boolean().nullable()();
  BoolColumn get hasHeadache => boolean().nullable()();
  BoolColumn get hasFatigue => boolean().nullable()();
  BoolColumn get hasSpotting => boolean().nullable()();
  BoolColumn get hasBreastTenderness => boolean().nullable()();
  BoolColumn get hasAcne => boolean().nullable()();
  TextColumn get energyLevel => text().nullable().withLength(max: 16)();
  TextColumn get notes => text().nullable().withLength(max: 1024)();
  BoolColumn get isPcodPcos => boolean().withDefault(const Constant(false))();
  BoolColumn get syncEnabled => boolean().withDefault(const Constant(false))();
}

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get emoji => text().nullable().withLength(max: 4)();
  IntColumn get targetCount => integer().withDefault(const Constant(1))();
  TextColumn get unit => text().nullable().withLength(max: 32)();
  TextColumn get frequency => text().withDefault(const Constant('daily'))();
  BoolColumn get isPreset => boolean().withDefault(const Constant(false))();
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
  RealColumn get heightCm => real().nullable()();
  RealColumn get chestCm => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get hipsCm => real().nullable()();
  RealColumn get leftArmCm => real().nullable()();
  RealColumn get rightArmCm => real().nullable()();
  RealColumn get leftThighCm => real().nullable()();
  RealColumn get rightThighCm => real().nullable()();
  RealColumn get bodyFatPercent => real().nullable()();
  TextColumn get photoPath => text().nullable()();
  RealColumn get bmi => real().nullable()();
  RealColumn get waistToHipRatio => real().nullable()();
  RealColumn get waistToHeightRatio => real().nullable()();
  DateTimeColumn get measuredAt => dateTime()();
}

@TableIndex(name: 'idx_medications_active', columns: {#userId, #isActive})
class Medications extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  TextColumn get dosage => text().nullable().withLength(max: 64)();
  TextColumn get frequency => text().nullable().withLength(max: 32)();
  TextColumn get category => text().nullable().withLength(max: 64)();
  IntColumn get pillsRemaining => integer().nullable()();
  DateTimeColumn get estimatedRefillDate => dateTime().nullable()();
  TextColumn get reminderTime => text().nullable().withLength(max: 8)();
  BoolColumn get reminderEnabled => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean()();
  DateTimeColumn get createdAt => dateTime()();
}

class FastingLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get protocol => text().withLength(min: 1, max: 16)();
  IntColumn get targetHours => integer()();
  DateTimeColumn get fastStart => dateTime()();
  DateTimeColumn get fastEnd => dateTime().nullable()();
  BoolColumn get completed => boolean().nullable()();
  BoolColumn get isRamadan => boolean().withDefault(const Constant(false))();
  DateTimeColumn get sehriTime => dateTime().nullable()();
  DateTimeColumn get iftarTime => dateTime().nullable()();
  BoolColumn get hydrationAlertSent => boolean().withDefault(const Constant(false))();
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
  TextColumn get notes => text().nullable()();
  TextColumn get prescriptionPhotoPath => text().nullable()();
  TextColumn get extractedMedsJson => text().nullable()();
  BoolColumn get reminderSent => boolean().withDefault(const Constant(false))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
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
  TextColumn get extractedDataJson => text().nullable()();
  BoolColumn get isEncrypted => boolean().withDefault(const Constant(false))();
}

class AbhaLinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text().withLength(min: 1, max: 64)();
  TextColumn get abhaNumber => text().withLength(min: 1, max: 20)();
  TextColumn get abhaAddress => text().nullable()();
  TextColumn get firstName => text().nullable()();
  TextColumn get lastName => text().nullable()();
  TextColumn get gender => text().nullable()();
  DateTimeColumn get dateOfBirth => dateTime().nullable()();
  TextColumn get stateCode => text().nullable()();
  TextColumn get districtCode => text().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get linkedAt => dateTime()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
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
  BoolColumn get syncEnabled => boolean().withDefault(const Constant(false))();
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
  TextColumn get medications => text().nullable().withLength(max: 2048)();
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

  static const _sleepTargetMin = 480;
  static const _weekTargetHours = 56;

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

  Future<int> insertLogWithKarma({
    required String userId,
    required int durationMin,
    int? quality,
    DateTime? bedTime,
    DateTime? wakeTime,
    required DateTime date,
  }) async {
    final id = await into(sleepLogs).insert(
      SleepLogsCompanion.insert(
        userId: userId,
        durationMin: durationMin,
        quality: Value(quality),
        bedTime: Value(bedTime),
        wakeTime: Value(wakeTime),
        date: date,
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

  Future<SleepDebtData> calculateSleepDebt(String userId) async {
    final now = DateTime.now();
    final weekStart = DateTime(now.year, now.month, now.day).subtract(const Duration(days: 7));
    
    final logs = await getLogsForUser(userId, from: weekStart);
    
    int totalSleepMin = 0;
    int debtMin = _weekTargetHours * 60;
    
    for (final log in logs) {
      totalSleepMin += log.durationMin;
    }
    
    debtMin = debtMin - totalSleepMin;
    
    final hours = debtMin ~/ 60;
    final mins = debtMin % 60;
    
    return SleepDebtData(
      totalSleepMin: totalSleepMin,
      targetMin: _weekTargetHours * 60,
      debtMin: debtMin > 0 ? debtMin : 0,
      displayString: debtMin > 0 
          ? 'You owe ${hours}h ${mins}m sleep this week'
          : 'On track! You\'ve met your sleep target',
    );
  }

  Future<ChronotypeData> detectChronotype(String userId) async {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final logs = await getLogsForUser(userId, from: thirtyDaysAgo);
    
    if (logs.length < 14) {
      return ChronotypeData(
        type: Chronotype.insufficient,
        medianBedtime: null,
        confidence: 0,
      );
    }
    
    final bedtimes = logs
        .where((l) => l.bedTime != null)
        .map((l) => l.bedTime!)
        .toList()
      ..sort((a, b) => a.compareTo(b));
    
    if (bedtimes.isEmpty) {
      return ChronotypeData(
        type: Chronotype.insufficient,
        medianBedtime: null,
        confidence: logs.length / 30,
      );
    }
    
    final medianIndex = bedtimes.length ~/ 2;
    final medianBedtime = bedtimes[medianIndex];
    
    int hour = medianBedtime.hour;
    if (hour >= 0 && hour < 4) {
      hour += 24;
    }
    
    Chronotype type;
    if (hour < 22) {
      type = Chronotype.earlyBird;
    } else if (hour >= 23 || hour < 1) {
      type = Chronotype.nightOwl;
    } else {
      type = Chronotype.intermediate;
    }
    
    return ChronotypeData(
      type: type,
      medianBedtime: medianBedtime,
      confidence: logs.length / 30,
    );
  }

  Future<List<WeeklySleepData>> getWeeklyData(String userId) async {
    final now = DateTime.now();
    final data = <WeeklySleepData>[];
    
    for (int i = 6; i >= 0; i--) {
      final day = DateTime(now.year, now.month, now.day).subtract(Duration(days: i));
      final dayStart = day;
      final dayEnd = day.add(const Duration(days: 1));
      
      final logs = await getLogsForUser(userId, from: dayStart, to: dayEnd);
      final duration = logs.isEmpty ? 0 : logs.first.durationMin;
      final quality = logs.isEmpty ? null : logs.first.quality;
      
      data.add(WeeklySleepData(
        date: day,
        durationMin: duration,
        quality: quality,
        targetMet: duration >= _sleepTargetMin,
      ));
    }
    
    return data;
  }
}

class SleepDebtData {
  final int totalSleepMin;
  final int targetMin;
  final int debtMin;
  final String displayString;

  SleepDebtData({
    required this.totalSleepMin,
    required this.targetMin,
    required this.debtMin,
    required this.displayString,
  });

  double get targetPercentage => (totalSleepMin / targetMin * 100).clamp(0, 200);
}

class ChronotypeData {
  final Chronotype type;
  final DateTime? medianBedtime;
  final double confidence;

  ChronotypeData({
    required this.type,
    this.medianBedtime,
    required this.confidence,
  });

  String get displayName {
    switch (type) {
      case Chronotype.earlyBird:
        return 'Early Bird 🌅';
      case Chronotype.nightOwl:
        return 'Night Owl 🦉';
      case Chronotype.intermediate:
        return 'Intermediate ⚖️';
      case Chronotype.insufficient:
        return 'Collecting data...';
    }
  }
}

enum Chronotype {
  earlyBird,
  nightOwl,
  intermediate,
  insufficient,
}

class WeeklySleepData {
  final DateTime date;
  final int durationMin;
  final int? quality;
  final bool targetMet;

  WeeklySleepData({
    required this.date,
    required this.durationMin,
    this.quality,
    required this.targetMet,
  });

  int get hours => durationMin ~/ 60;
  int get minutes => durationMin % 60;
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

  Future<int> insertLogWithKarma({
    required String userId,
    required int moodScore,
    int? energy,
    int? stress,
    String? tags,
    String? voiceNotePath,
  }) async {
    final id = await into(moodLogs).insert(
      MoodLogsCompanion.insert(
        userId: userId,
        moodScore: moodScore,
        energy: Value(energy),
        stress: Value(stress),
        tags: Value(tags),
        voiceNotePath: Value(voiceNotePath),
        loggedAt: DateTime.now(),
      ),
    );
    
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: userId,
        amount: 3,
        createdAt: DateTime.now(),
      ),
    );
    
    return id;
  }

  Future<List<MoodHeatmapData>> getMoodHeatmap(String userId, int days) async {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));
    final logs = await getLogsForUser(userId, from: start);
    
    final heatmap = <MoodHeatmapData>[];
    for (int i = 0; i < days; i++) {
      final day = start.add(Duration(days: i));
      final dayLogs = logs.where((l) =>
          l.loggedAt.year == day.year &&
          l.loggedAt.month == day.month &&
          l.loggedAt.day == day.day).toList();
      
      final avgMood = dayLogs.isEmpty
          ? null
          : dayLogs.map((l) => l.moodScore).reduce((a, b) => a + b) ~/ dayLogs.length;
      
      heatmap.add(MoodHeatmapData(date: day, moodScore: avgMood));
    }
    
    return heatmap;
  }

  Future<Map<String, dynamic>> getMoodStatistics(String userId) async {
    final now = DateTime.now();
    final weekStart = now.subtract(const Duration(days: 7));
    final monthStart = now.subtract(const Duration(days: 30));
    
    final weekLogs = await getLogsForUser(userId, from: weekStart);
    final monthLogs = await getLogsForUser(userId, from: monthStart);
    
    double avgMood = 0, avgEnergy = 0, avgStress = 0;
    
    if (weekLogs.isNotEmpty) {
      avgMood = weekLogs.map((l) => l.moodScore).reduce((a, b) => a + b) / weekLogs.length;
    }
    
    final monthWithEnergy = monthLogs.where((l) => l.energy != null).toList();
    if (monthWithEnergy.isNotEmpty) {
      avgEnergy = monthWithEnergy.map((l) => l.energy!).reduce((a, b) => a + b) / monthWithEnergy.length;
    }
    
    final monthWithStress = monthLogs.where((l) => l.stress != null).toList();
    if (monthWithStress.isNotEmpty) {
      avgStress = monthWithStress.map((l) => l.stress!).reduce((a, b) => a + b) / monthWithStress.length;
    }
    
    return {
      'avgMood': avgMood,
      'avgEnergy': avgEnergy,
      'avgStress': avgStress,
      'logCount': monthLogs.length,
    };
  }
}

class MoodHeatmapData {
  final DateTime date;
  final int? moodScore;

  MoodHeatmapData({required this.date, this.moodScore});

  Color? get color {
    if (moodScore == null) return null;
    switch (moodScore!) {
      case 1: return Colors.red.shade300;
      case 2: return Colors.orange.shade300;
      case 3: return Colors.yellow.shade300;
      case 4: return Colors.lightGreen.shade300;
      case 5: return Colors.green.shade400;
      default: return null;
    }
  }
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

  Future<void> seedPresetHabits(String userId) async {
    final presets = [
      ('8 Glasses Water', '💧', 8, 'glasses', 'daily'),
      ('10-min Meditation', '🧘', 10, 'minutes', 'daily'),
      ('30-min Walk', '🚶', 30, 'minutes', 'daily'),
      ('Read 10 Pages', '📖', 10, 'pages', 'daily'),
      ('No Sugar', '🍬', 1, 'times', 'daily'),
    ];
    
    for (final preset in presets) {
      await insertHabit(HabitsCompanion.insert(
        userId: userId,
        name: preset.$1,
        emoji: Value(preset.$2),
        targetCount: Value(preset.$3),
        unit: Value(preset.$4),
        frequency: Value(preset.$5),
        isPreset: const Value(true),
        isActive: const Value(true),
        createdAt: DateTime.now(),
      ));
    }
  }

  Future<bool> hasPresetHabits(String userId) async {
    final userHabits = await getActiveHabits(userId);
    return userHabits.any((h) => h.isPreset);
  }

  Future<HabitStreakData> getStreakForHabit(int habitId) async {
    final habit = await (select(habits)..where((t) => t.id.equals(habitId))).getSingle();
    final completions = await (select(habitCompletions)
          ..where((t) => t.habitId.equals(habitId))
          ..orderBy([(t) => OrderingTerm.desc(t.completedAt)]))
        .get();
    
    if (completions.isEmpty) {
      return HabitStreakData(habitId: habitId, currentStreak: 0, longestStreak: 0, totalCompletions: 0);
    }
    
    int currentStreak = 0;
    int longestStreak = 0;
    DateTime? lastDate;
    
    for (final completion in completions) {
      final compDate = DateTime(
        completion.completedAt.year,
        completion.completedAt.month,
        completion.completedAt.day,
      );
      
      if (lastDate == null) {
        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);
        if (compDate == todayDate ||
            compDate == todayDate.subtract(const Duration(days: 1))) {
          currentStreak = 1;
        }
        lastDate = compDate;
        continue;
      }
      
      final diff = lastDate.difference(compDate).inDays;
      if (diff == 1) {
        currentStreak++;
        longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
      } else {
        longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
        currentStreak = 1;
      }
      lastDate = compDate;
    }
    
    longestStreak = currentStreak > longestStreak ? currentStreak : longestStreak;
    
    return HabitStreakData(
      habitId: habitId,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalCompletions: completions.length,
    );
  }

  Future<List<WeeklyHabitHeatmap>> getWeeklyHeatmap(String userId, {int weeks = 12}) async {
    final heatmap = <WeeklyHabitHeatmap>[];
    final now = DateTime.now();
    final startDate = now.subtract(Duration(days: weeks * 7));
    
    final allCompletions = await (select(habitCompletions)
          ..where((t) =>
              t.userId.equals(userId) &
              t.completedAt.isBiggerOrEqualValue(startDate)))
        .get();
    
    for (int i = 0; i < weeks * 7; i++) {
      final day = startDate.add(Duration(days: i));
      final dayStart = DateTime(day.year, day.month, day.day);
      final dayEnd = dayStart.add(const Duration(days: 1));
      
      final dayCompletions = allCompletions.where((c) =>
          c.completedAt.isAfter(dayStart) &
          c.completedAt.isBefore(dayEnd)).toList();
      
      heatmap.add(WeeklyHabitHeatmap(
        date: dayStart,
        completionCount: dayCompletions.length,
        isComplete: dayCompletions.isNotEmpty,
      ));
    }
    
    return heatmap;
  }
}

class HabitStreakData {
  final int habitId;
  final int currentStreak;
  final int longestStreak;
  final int totalCompletions;

  HabitStreakData({
    required this.habitId,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalCompletions,
  });
}

class WeeklyHabitHeatmap {
  final DateTime date;
  final int completionCount;
  final bool isComplete;

  WeeklyHabitHeatmap({
    required this.date,
    required this.completionCount,
    required this.isComplete,
  });
}

@DriftAccessor(tables: [HabitCompletions])
class HabitCompletionsDao extends DatabaseAccessor<AppDatabase>
    with _$HabitCompletionsDaoMixin {
  HabitCompletionsDao(super.db);

  Future<int> markComplete(HabitCompletionsCompanion entry) =>
      into(habitCompletions).insert(entry);

  Future<int> markCompleteWithKarma(String userId, int habitId) async {
    final id = await into(habitCompletions).insert(
      HabitCompletionsCompanion.insert(
        habitId: habitId,
        userId: userId,
        completedAt: DateTime.now(),
      ),
    );
    
    final streak = await db.habitsDao.getStreakForHabit(habitId);
    final xpReward = streak.currentStreak >= 7 ? 10 : 2;
    
    await db.karmaTransactionsDao.insertTransaction(
      KarmaTransactionsCompanion.insert(
        userId: userId,
        amount: xpReward,
        createdAt: DateTime.now(),
      ),
    );
    
    return id;
  }

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

  Stream<List<BodyMeasurement>> watchMeasurementsForUser(String userId) =>
      (select(bodyMeasurements)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)]))
          .watch();

  Future<List<BodyMeasurement>> getMeasurementsInRange(String userId, DateTime from, DateTime to) =>
      (select(bodyMeasurements)
            ..where((t) =>
                t.userId.equals(userId) &
                t.measuredAt.isBiggerOrEqualValue(from) &
                t.measuredAt.isSmallerOrEqualValue(to)))
          .get();

  Future<int> insertMeasurement(BodyMeasurementsCompanion entry) =>
      into(bodyMeasurements).insert(entry);

  Future<int> insertWithCalculations({
    required String userId,
    required double weightKg,
    double? heightCm,
    double? chestCm,
    double? waistCm,
    double? hipsCm,
    double? leftArmCm,
    double? rightArmCm,
    double? leftThighCm,
    double? rightThighCm,
    double? bodyFatPercent,
    String? photoPath,
  }) async {
    double? bmi;
    double? waistToHipRatio;
    double? waistToHeightRatio;
    
    if (weightKg != null && heightCm != null && heightCm > 0) {
      bmi = weightKg / ((heightCm / 100) * (heightCm / 100));
    }
    
    if (waistCm != null && hipsCm != null && hipsCm > 0) {
      waistToHipRatio = waistCm / hipsCm;
    }
    
    if (waistCm != null && heightCm != null && heightCm > 0) {
      waistToHeightRatio = waistCm / heightCm;
    }
    
    return into(bodyMeasurements).insert(
      BodyMeasurementsCompanion.insert(
        userId: userId,
        weightKg: Value(weightKg),
        heightCm: Value(heightCm),
        chestCm: Value(chestCm),
        waistCm: Value(waistCm),
        hipsCm: Value(hipsCm),
        leftArmCm: Value(leftArmCm),
        rightArmCm: Value(rightArmCm),
        leftThighCm: Value(leftThighCm),
        rightThighCm: Value(rightThighCm),
        bodyFatPercent: Value(bodyFatPercent),
        photoPath: Value(photoPath),
        bmi: Value(bmi),
        waistToHipRatio: Value(waistToHipRatio),
        waistToHeightRatio: Value(waistToHeightRatio),
        measuredAt: DateTime.now(),
      ),
    );
  }

  Future<List<MeasurementTrend>> getTrends(String userId, {int days = 30}) async {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: days));
    final measurements = await getMeasurementsInRange(userId, start, now);
    
    return measurements.map((m) => MeasurementTrend(
      date: m.measuredAt,
      weight: m.weightKg,
      bmi: m.bmi,
      waistToHipRatio: m.waistToHipRatio,
      waistToHeightRatio: m.waistToHeightRatio,
      bodyFatPercent: m.bodyFatPercent,
    )).toList();
  }

  Future<BodyMeasurement?> getLatest(String userId) async {
    final results = await (select(bodyMeasurements)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measuredAt)])
          ..limit(1))
        .get();
    return results.isEmpty ? null : results.first;
  }
}

class MeasurementTrend {
  final DateTime date;
  final double? weight;
  final double? bmi;
  final double? waistToHipRatio;
  final double? waistToHeightRatio;
  final double? bodyFatPercent;

  MeasurementTrend({
    required this.date,
    this.weight,
    this.bmi,
    this.waistToHipRatio,
    this.waistToHeightRatio,
    this.bodyFatPercent,
  });
}

@DriftAccessor(tables: [Medications])
class MedicationsDao extends DatabaseAccessor<AppDatabase>
    with _$MedicationsDaoMixin {
  MedicationsDao(super.db);

  Future<List<Medication>> getActiveMedications(String userId) =>
      (select(medications)
            ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
          .get();

  Stream<List<Medication>> watchActiveMedications(String userId) =>
      (select(medications)
            ..where((t) => t.userId.equals(userId) & t.isActive.equals(true)))
          .watch();

  Future<List<Medication>> getAllMedications(String userId) =>
      (select(medications)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .get();

  Future<int> insertMedication(MedicationsCompanion entry) =>
      into(medications).insert(entry);

  Future<bool> updateMedication(MedicationsCompanion entry) =>
      update(medications).replace(entry);

  Future<int> updatePillsRemaining(int id, int remaining) =>
      (update(medications)..where((t) => t.id.equals(id)))
          .write(MedicationsCompanion(pillsRemaining: Value(remaining)));

  Future<int> setEstimatedRefillDate(int id, DateTime date) =>
      (update(medications)..where((t) => t.id.equals(id)))
          .write(MedicationsCompanion(estimatedRefillDate: Value(date)));

  Future<List<MedicationWithRefillAlert>> getMedicationsNeedingRefill(String userId) async {
    final meds = await getActiveMedications(userId);
    final now = DateTime.now();
    final threeDaysFromNow = now.add(const Duration(days: 3));
    return meds.where((m) {
      if (m.estimatedRefillDate == null) return false;
      if (m.estimatedRefillDate!.isBefore(threeDaysFromNow)) return true;
      return false;
    }).map((m) => MedicationWithRefillAlert(
      medication: m,
      daysUntilRefill: m.estimatedRefillDate!.difference(now).inDays,
    )).toList();
  }

  Future<List<MedicationReminder>> getPendingReminders(String userId) async {
    final meds = await getActiveMedications(userId);
    return meds.where((m) => m.reminderEnabled == true && m.reminderTime != null)
        .map((m) => MedicationReminder(
              id: m.id,
              name: m.name,
              dosage: m.dosage,
              frequency: m.frequency,
              reminderTime: m.reminderTime!,
            ))
        .toList();
  }

  Future<List<String>> getActiveMedicationNames(String userId) async {
    final meds = await getActiveMedications(userId);
    return meds.map((m) => '${m.name}${m.dosage != null ? ' ${m.dosage}' : ''}').toList();
  }
}

class MedicationWithRefillAlert {
  final Medication medication;
  final int daysUntilRefill;

  MedicationWithRefillAlert({
    required this.medication,
    required this.daysUntilRefill,
  });
}

class MedicationReminder {
  final int id;
  final String name;
  final String? dosage;
  final String? frequency;
  final String reminderTime;

  MedicationReminder({
    required this.id,
    required this.name,
    this.dosage,
    this.frequency,
    required this.reminderTime,
  });
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

  Stream<List<FastingLog>> watchLogsForUser(String userId) =>
      (select(fastingLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.fastStart)]))
          .watch();

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

  Future<int> startFast({
    required String userId,
    required String protocol,
    required int targetHours,
    bool isRamadan = false,
    DateTime? sehriTime,
    DateTime? iftarTime,
  }) async {
    return into(fastingLogs).insert(
      FastingLogsCompanion.insert(
        userId: userId,
        protocol: protocol,
        targetHours: targetHours,
        fastStart: DateTime.now(),
        isRamadan: Value(isRamadan),
        sehriTime: Value(sehriTime),
        iftarTime: Value(iftarTime),
      ),
    );
  }

  Future<int> endFastWithKarma(String userId) async {
    final activeFast = await getActiveFast(userId);
    if (activeFast == null) return -1;
    
    final now = DateTime.now();
    final duration = now.difference(activeFast.fastStart).inHours;
    
    final completed = duration >= activeFast.targetHours;
    
    await (update(fastingLogs)..where((t) => t.id.equals(activeFast.id)))
        .write(FastingLogsCompanion(
          fastEnd: Value(now),
          completed: Value(completed),
        ));
    
    if (completed) {
      await db.karmaTransactionsDao.insertTransaction(
        KarmaTransactionsCompanion.insert(
          userId: userId,
          amount: 15,
          createdAt: now,
        ),
      );
    }
    
    return activeFast.id;
  }

  Future<FastingState> getFastingState(String userId) async {
    final activeFast = await getActiveFast(userId);
    if (activeFast == null) {
      return FastingState(isActive: false, elapsedMinutes: 0, targetMinutes: 0, stage: FastingStage.idle);
    }
    
    final now = DateTime.now();
    final elapsed = now.difference(activeFast.fastStart);
    final elapsedMinutes = elapsed.inMinutes;
    final targetMinutes = activeFast.targetHours * 60;
    final stage = _getStage(elapsedMinutes, activeFast.targetHours, activeFast.isRamadan);
    final progress = elapsedMinutes / targetMinutes;
    
    return FastingState(
      isActive: true,
      elapsedMinutes: elapsedMinutes,
      targetMinutes: targetMinutes,
      stage: stage,
      progress: progress.clamp(0.0, 1.0),
      protocol: activeFast.protocol,
    );
  }

  FastingStage _getStage(int minutes, int targetHours, bool isRamadan) {
    final targetMinutes = targetHours * 60;
    
    if (minutes < 60) return FastingStage.eatingWindow;
    if (minutes < targetMinutes * 0.25) return FastingStage.fatBurning;
    if (minutes < targetMinutes * 0.5) return FastingStage.ketosis;
    if (minutes < targetMinutes * 0.75) return FastingStage.autophagy;
    return FastingStage.deepAutophagy;
  }

  Future<List<FastingProtocol>> getProtocols() async {
    return [
      const FastingProtocol(name: '16:8', hours: 16, description: '16 hours fasting, 8 hours eating'),
      const FastingProtocol(name: '18:6', hours: 18, description: '18 hours fasting, 6 hours eating'),
      const FastingProtocol(name: '5:2', hours: 24, description: '24 hours fasting, 2 days per week'),
      const FastingProtocol(name: 'OMAD', hours: 23, description: 'One meal a day (23 hours)'),
      const FastingProtocol(name: 'Custom', hours: 16, description: 'Custom duration'),
    ];
  }
}

class FastingState {
  final bool isActive;
  final int elapsedMinutes;
  final int targetMinutes;
  final FastingStage stage;
  final double progress;
  final String? protocol;

  FastingState({
    required this.isActive,
    required this.elapsedMinutes,
    required this.targetMinutes,
    required this.stage,
    this.progress = 0,
    this.protocol,
  });

  String get remainingTime {
    final remaining = targetMinutes - elapsedMinutes;
    if (remaining <= 0) return 'Complete';
    final hours = remaining ~/ 60;
    final mins = remaining % 60;
    return '${hours}h ${mins}m';
  }

  String get elapsedTime {
    final hours = elapsedMinutes ~/ 60;
    final mins = elapsedMinutes % 60;
    return '${hours}h ${mins}m';
  }
}

enum FastingStage {
  eatingWindow,
  fatBurning,
  ketosis,
  autophagy,
  deepAutophagy,
  idle,
}

class FastingProtocol {
  final String name;
  final int hours;
  final String description;

  const FastingProtocol({
    required this.name,
    required this.hours,
    required this.description,
  });
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

  Stream<List<PeriodLog>> watchLogsForUser(String userId) =>
      (select(periodLogs)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Future<int> insertLog(PeriodLogsCompanion entry) =>
      into(periodLogs).insert(entry);

  Future<int> insertLogEncrypted({
    required String userId,
    required DateTime date,
    required bool isPeriodDay,
    String? flowIntensity,
    String? symptoms,
    bool? hasCramps,
    bool? hasBloating,
    bool? hasMoodSwings,
    bool? hasHeadache,
    bool? hasFatigue,
    bool? hasSpotting,
    bool? hasBreastTenderness,
    bool? hasAcne,
    String? energyLevel,
    String? notes,
    bool isPcodPcos = false,
    bool syncEnabled = false,
  }) async {
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.period);
    
    String? encryptedNotes;
    if (notes != null && notes.isNotEmpty) {
      final encNotes = await EncryptionHelper.encryptField(notes, key);
      encryptedNotes = base64Encode(encNotes);
    }
    
    String? encryptedSymptoms;
    if (symptoms != null && symptoms.isNotEmpty) {
      final encSymptoms = await EncryptionHelper.encryptField(symptoms, key);
      encryptedSymptoms = base64Encode(encSymptoms);
    }
    
    return into(periodLogs).insert(
      PeriodLogsCompanion.insert(
        userId: userId,
        date: date,
        isPeriodDay: isPeriodDay,
        flowIntensity: Value(flowIntensity),
        symptoms: Value(encryptedSymptoms),
        hasCramps: Value(hasCramps),
        hasBloating: Value(hasBloating),
        hasMoodSwings: Value(hasMoodSwings),
        hasHeadache: Value(hasHeadache),
        hasFatigue: Value(hasFatigue),
        hasSpotting: Value(hasSpotting),
        hasBreastTenderness: Value(hasBreastTenderness),
        hasAcne: Value(hasAcne),
        energyLevel: Value(energyLevel),
        notes: Value(encryptedNotes),
        isPcodPcos: Value(isPcodPcos),
        syncEnabled: Value(syncEnabled),
      ),
    );
  }

  Future<PeriodLog?> getLogForDate(String userId, DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    final logs = await (select(periodLogs)
          ..where((t) =>
              t.userId.equals(userId) &
              t.date.isBiggerOrEqualValue(startOfDay) &
              t.date.isSmallerThanValue(endOfDay)))
        .get();
    return logs.isEmpty ? null : logs.first;
  }

  Future<CyclePrediction> predictCycle(String userId) async {
    final allLogs = await getLogsForUser(userId);
    final periodDays = allLogs.where((l) => l.isPeriodDay).toList();
    
    if (periodDays.length < 2) {
      return CyclePrediction(
        nextPeriodStart: null,
        cycleLengthDays: 28,
        ovulationDate: null,
        fertileWindowStart: null,
        fertileWindowEnd: null,
        confidence: 0,
      );
    }
    
    final cycles = <int>[];
    final periodDates = periodDays.map((l) => DateTime(l.date.year, l.date.month, l.date.day)).toList()
      ..sort();
    
    for (int i = 1; i < periodDates.length; i++) {
      cycles.add(periodDates[i].difference(periodDates[i - 1]).inDays);
    }
    
    final avgCycleLength = cycles.isEmpty
        ? 28
        : cycles.reduce((a, b) => a + b) ~/ cycles.length;
    
    final lastPeriod = periodDates.last;
    final nextPeriod = lastPeriod.add(Duration(days: avgCycleLength));
    final ovulation = nextPeriod.subtract(const Duration(days: 14));
    final fertileStart = ovulation.subtract(const Duration(days: 5));
    final fertileEnd = ovulation.add(const Duration(days: 1));
    
    return CyclePrediction(
      nextPeriodStart: nextPeriod,
      cycleLengthDays: avgCycleLength,
      ovulationDate: ovulation,
      fertileWindowStart: fertileStart,
      fertileWindowEnd: fertileEnd,
      confidence: cycles.length >= 3 ? 80 : 50,
    );
  }

  Future<List<WorkoutSuggestion>> getWorkoutSuggestions(String userId) async {
    final prediction = await predictCycle(userId);
    if (prediction.nextPeriodStart == null) {
      return [
        const WorkoutSuggestion(
          phase: CyclePhase.follicular,
          workouts: ['Light walking', 'Yoga', 'Swimming'],
          reason: 'Start tracking to get personalized suggestions',
        ),
      ];
    }
    
    final today = DateTime.now();
    final daysUntilNext = prediction.nextPeriodStart!.difference(today).inDays;
    final dayOfCycle = 28 - daysUntilNext;
    
    final suggestions = <WorkoutSuggestion>[];
    
    if (dayOfCycle <= 5 || daysUntilNext <= 5) {
      suggestions.add(const WorkoutSuggestion(
        phase: CyclePhase.menstruation,
        workouts: ['Gentle yoga', 'Light stretching', 'Short walks'],
        reason: 'Menstrual phase - opt for restful activities',
      ));
      if (dayOfCycle <= 2) {
        suggestions.add(const WorkoutSuggestion(
          phase: CyclePhase.menstruation,
          workouts: ['Rest', 'Meditation', 'Gentle foam rolling'],
          reason: 'Heavy flow days - prioritize rest',
        ));
      }
    } else if (dayOfCycle <= 14) {
      suggestions.add(const WorkoutSuggestion(
        phase: CyclePhase.follicular,
        workouts: ['Running', 'Strength training', 'HIIT'],
        reason: 'Rising estrogen - great for building strength',
      ));
    } else if (dayOfCycle <= 21) {
      suggestions.add(const WorkoutSuggestion(
        phase: CyclePhase.luteal,
        workouts: ['Moderate cardio', 'Pilates', 'Cycling'],
        reason: 'Stable energy - maintain moderate intensity',
      ));
    } else {
      suggestions.add(const WorkoutSuggestion(
        phase: CyclePhase.preMenstrual,
        workouts: ['Yoga', 'Low-impact cardio', 'Walking'],
        reason: 'Energy decline - focus on relaxing exercises',
      ));
    }
    
    return suggestions;
  }

  Future<SymptomAnalysis> analyzeSymptoms(String userId, {int days = 90}) async {
    final start = DateTime.now().subtract(Duration(days: days));
    final logs = await getLogsForUser(userId, from: start);
    
    int crampsCount = 0, bloatingCount = 0, moodSwingsCount = 0;
    int headacheCount = 0, fatigueCount = 0, spottingCount = 0;
    int breastTendernessCount = 0, acneCount = 0;
    
    for (final log in logs) {
      if (log.hasCramps == true) crampsCount++;
      if (log.hasBloating == true) bloatingCount++;
      if (log.hasMoodSwings == true) moodSwingsCount++;
      if (log.hasHeadache == true) headacheCount++;
      if (log.hasFatigue == true) fatigueCount++;
      if (log.hasSpotting == true) spottingCount++;
      if (log.hasBreastTenderness == true) breastTendernessCount++;
      if (log.hasAcne == true) acneCount++;
    }
    
    final totalDays = logs.length;
    return SymptomAnalysis(
      crampsFrequency: totalDays > 0 ? (crampsCount / totalDays * 100).round() : 0,
      bloatingFrequency: totalDays > 0 ? (bloatingCount / totalDays * 100).round() : 0,
      moodSwingsFrequency: totalDays > 0 ? (moodSwingsCount / totalDays * 100).round() : 0,
      headacheFrequency: totalDays > 0 ? (headacheCount / totalDays * 100).round() : 0,
      fatigueFrequency: totalDays > 0 ? (fatigueCount / totalDays * 100).round() : 0,
      spottingFrequency: totalDays > 0 ? (spottingCount / totalDays * 100).round() : 0,
      breastTendernessFrequency: totalDays > 0 ? (breastTendernessCount / totalDays * 100).round() : 0,
      acneFrequency: totalDays > 0 ? (acneCount / totalDays * 100).round() : 0,
      totalLogs: totalDays,
    );
  }

  Future<PcodPcosData> getPcodPcosManagement(String userId) async {
    final allLogs = await getLogsForUser(userId);
    final pcodLogs = allLogs.where((l) => l.isPcodPcos).toList();
    
    if (pcodLogs.isEmpty) {
      return PcodPcosData(
        isActive: false,
        averageCycleLength: 28,
        irregularCyclesCount: 0,
        lastRecordedWeight: null,
        symptomsList: [],
      );
    }
    
    final periodDates = pcodLogs
        .where((l) => l.isPeriodDay)
        .map((l) => DateTime(l.date.year, l.date.month, l.date.day))
        .toList()
      ..sort();
    
    final cycles = <int>[];
    for (int i = 1; i < periodDates.length; i++) {
      cycles.add(periodDates[i].difference(periodDates[i - 1]).inDays);
    }
    
    final irregularCycles = cycles.where((c) => c < 21 || c > 35).length;
    final avgCycle = cycles.isEmpty ? 28 : cycles.reduce((a, b) => a + b) ~/ cycles.length;
    
    final recentSymptoms = <String>[];
    for (final log in pcodLogs.take(30)) {
      if (log.hasCramps == true) recentSymptoms.add('Cramps');
      if (log.hasBloating == true) recentSymptoms.add('Bloating');
      if (log.hasMoodSwings == true) recentSymptoms.add('Mood Swings');
      if (log.hasAcne == true) recentSymptoms.add('Acne');
    }
    
    return PcodPcosData(
      isActive: true,
      averageCycleLength: avgCycle,
      irregularCyclesCount: irregularCycles,
      lastRecordedWeight: null,
      symptomsList: recentSymptoms.toSet().toList(),
    );
  }
}

class CyclePrediction {
  final DateTime? nextPeriodStart;
  final int cycleLengthDays;
  final DateTime? ovulationDate;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final int confidence;

  CyclePrediction({
    this.nextPeriodStart,
    required this.cycleLengthDays,
    this.ovulationDate,
    this.fertileWindowStart,
    this.fertileWindowEnd,
    required this.confidence,
  });
}

class WorkoutSuggestion {
  final CyclePhase phase;
  final List<String> workouts;
  final String reason;

  const WorkoutSuggestion({
    required this.phase,
    required this.workouts,
    required this.reason,
  });
}

enum CyclePhase {
  menstruation,
  follicular,
  ovulation,
  luteal,
  preMenstrual,
}

class SymptomAnalysis {
  final int crampsFrequency;
  final int bloatingFrequency;
  final int moodSwingsFrequency;
  final int headacheFrequency;
  final int fatigueFrequency;
  final int spottingFrequency;
  final int breastTendernessFrequency;
  final int acneFrequency;
  final int totalLogs;

  SymptomAnalysis({
    required this.crampsFrequency,
    required this.bloatingFrequency,
    required this.moodSwingsFrequency,
    required this.headacheFrequency,
    required this.fatigueFrequency,
    required this.spottingFrequency,
    required this.breastTendernessFrequency,
    required this.acneFrequency,
    required this.totalLogs,
  });

  String get mostCommonSymptom {
    final frequencies = {
      'Cramps': crampsFrequency,
      'Bloating': bloatingFrequency,
      'Mood Swings': moodSwingsFrequency,
      'Headache': headacheFrequency,
      'Fatigue': fatigueFrequency,
      'Spotting': spottingFrequency,
      'Breast Tenderness': breastTendernessFrequency,
      'Acne': acneFrequency,
    };
    return frequencies.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }
}

class PcodPcosData {
  final bool isActive;
  final int averageCycleLength;
  final int irregularCyclesCount;
  final double? lastRecordedWeight;
  final List<String> symptomsList;

  PcodPcosData({
    required this.isActive,
    required this.averageCycleLength,
    required this.irregularCyclesCount,
    this.lastRecordedWeight,
    required this.symptomsList,
  });

  bool get needsMedicalAttention => irregularCyclesCount > 2 || averageCycleLength > 35;
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

  Future<List<DoctorAppointment>> getAllForUser(String userId) =>
      (select(doctorAppointments)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.appointmentDate)]))
          .get();

  Stream<List<DoctorAppointment>> watchUpcomingForUser(String userId) =>
      (select(doctorAppointments)
            ..where((t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(DateTime.now()))
            ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
          .watch();

  Future<int> insertAppointment(DoctorAppointmentsCompanion entry) =>
      into(doctorAppointments).insert(entry);

  Future<int> insertWithEncryption({
    required String userId,
    required DateTime appointmentDate,
    required String doctorName,
    String? notes,
  }) async {
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.appointments);
    
    String? encryptedNotes;
    if (notes != null && notes.isNotEmpty) {
      final encNotes = await EncryptionHelper.encryptField(notes, key);
      encryptedNotes = base64Encode(encNotes);
    }
    
    return into(doctorAppointments).insert(
      DoctorAppointmentsCompanion.insert(
        userId: userId,
        appointmentDate: appointmentDate,
        doctorName: doctorName,
        notes: Value(encryptedNotes),
      ),
    );
  }

  Future<DecryptedAppointment> getAppointmentDecrypted(int id) async {
    final appointments = await (select(doctorAppointments)
          ..where((t) => t.id.equals(id)))
        .get();
    
    if (appointments.isEmpty) {
      throw Exception('Appointment not found');
    }
    
    final apt = appointments.first;
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.appointments);
    
    String notes = apt.notes ?? '';
    if (apt.notes != null && apt.notes!.isNotEmpty) {
      try {
        final notesBytes = base64Decode(apt.notes!);
        notes = await EncryptionHelper.decryptField(notesBytes, key);
      } catch (e) {
        debugPrint('Notes decryption failed: $e');
      }
    }
    
    return DecryptedAppointment(
      id: apt.id,
      userId: apt.userId,
      appointmentDate: apt.appointmentDate,
      doctorName: apt.doctorName,
      notes: notes,
      prescriptionPhotoPath: apt.prescriptionPhotoPath,
      extractedMedsJson: apt.extractedMedsJson,
      reminderSent: apt.reminderSent,
      isCompleted: apt.isCompleted,
    );
  }

  Future<List<DecryptedAppointment>> getUpcomingForUserDecrypted(String userId) async {
    final appointments = await getUpcomingForUser(userId);
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.appointments);
    
    final decrypted = <DecryptedAppointment>[];
    for (final apt in appointments) {
      String notes = apt.notes ?? '';
      if (apt.notes != null && apt.notes!.isNotEmpty) {
        try {
          final notesBytes = base64Decode(apt.notes!);
          notes = await EncryptionHelper.decryptField(notesBytes, key);
        } catch (e) {
          debugPrint('Notes decryption failed: $e');
        }
      }
      
      decrypted.add(DecryptedAppointment(
        id: apt.id,
        userId: apt.userId,
        appointmentDate: apt.appointmentDate,
        doctorName: apt.doctorName,
        notes: notes,
        prescriptionPhotoPath: apt.prescriptionPhotoPath,
        extractedMedsJson: apt.extractedMedsJson,
        reminderSent: apt.reminderSent,
        isCompleted: apt.isCompleted,
      ));
    }
    
    return decrypted;
  }

  Future<int> markCompleted(int id) =>
      (update(doctorAppointments)..where((t) => t.id.equals(id)))
          .write(const DoctorAppointmentsCompanion(isCompleted: Value(true)));

  Future<int> markReminderSent(int id) =>
      (update(doctorAppointments)..where((t) => t.id.equals(id)))
          .write(const DoctorAppointmentsCompanion(reminderSent: Value(true)));

  Future<int> updateExtractedMeds(int id, String medsJson) =>
      (update(doctorAppointments)..where((t) => t.id.equals(id)))
          .write(DoctorAppointmentsCompanion(extractedMedsJson: Value(medsJson)));

  Future<int> savePrescriptionPhoto(int id, String photoPath) =>
      (update(doctorAppointments)..where((t) => t.id.equals(id)))
          .write(DoctorAppointmentsCompanion(prescriptionPhotoPath: Value(photoPath)));

  Future<int> deleteAppointment(int id) =>
      (delete(doctorAppointments)..where((t) => t.id.equals(id))).go();
}

class DecryptedAppointment {
  final int id;
  final String userId;
  final DateTime appointmentDate;
  final String doctorName;
  final String? notes;
  final String? prescriptionPhotoPath;
  final String? extractedMedsJson;
  final bool reminderSent;
  final bool isCompleted;

  DecryptedAppointment({
    required this.id,
    required this.userId,
    required this.appointmentDate,
    required this.doctorName,
    this.notes,
    this.prescriptionPhotoPath,
    this.extractedMedsJson,
    this.reminderSent = false,
    this.isCompleted = false,
  });

  bool get isUpcoming => appointmentDate.isAfter(DateTime.now());
  bool get isToday {
    final now = DateTime.now();
    return appointmentDate.year == now.year &&
        appointmentDate.month == now.month &&
        appointmentDate.day == now.day;
  }

  bool get isPast => appointmentDate.isBefore(DateTime.now()) && !isToday;
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

  Future<int> insertWithExtraction({
    required String userId,
    required String reportName,
    String? reportUrl,
    String? labName,
    required String extractedDataJson,
  }) async {
    final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bpGlucose);
    
    final encSummary = await EncryptionHelper.encryptField(extractedDataJson, key);
    
    return into(labReports).insert(
      LabReportsCompanion.insert(
        userId: userId,
        reportName: reportName,
        reportUrl: Value(reportUrl),
        labName: Value(labName),
        summaryJson: Value(base64Encode(encSummary)),
        extractedDataJson: Value(extractedDataJson),
        isEncrypted: const Value(true),
        uploadedAt: DateTime.now(),
      ),
    );
  }

  Future<int> autoPopulateTrackers(String userId, String extractedDataJson) async {
    int logsCreated = 0;
    
    try {
      final params = Uri.splitQueryString(extractedDataJson);
      final data = <String, double>{};
      for (final entry in params.entries) {
        final value = double.tryParse(entry.value);
        if (value != null) data[entry.key] = value;
      }
      
      if (data.containsKey('glucose_fasting') && data['glucose_fasting'] != null) {
        await db.glucoseLogsDao.insertLogWithKarma(
          userId: userId,
          glucoseMgdl: data['glucose_fasting']!.toInt(),
          mealType: 'fasting',
        );
        logsCreated++;
      }
      
      if (data.containsKey('vitamin_d') && data['vitamin_d'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('vitamin_b12') && data['vitamin_b12'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('vitamin_b12') && data['vitamin_b12'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('tsh') && data['tsh'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('creatinine') && data['creatinine'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('ldl') && data['ldl'] != null) {
        logsCreated++;
      }
      
      if (data.containsKey('hdl') && data['hdl'] != null) {
        logsCreated++;
      }
    } catch (e) {
      debugPrint('Auto-populate failed: $e');
    }
    
    return logsCreated;
  }

  Future<DecryptedLabReport?> getReportDecrypted(int id) async {
    final reports = await (select(labReports)
          ..where((t) => t.id.equals(id)))
        .get();
    
    if (reports.isEmpty) return null;
    
    final r = reports.first;
    String dataJson = r.extractedDataJson ?? '';
    
    if (r.isEncrypted && r.summaryJson != null) {
      try {
        final key = await KeyManager.instance.getKeyForDataClass(DataClassKeys.bpGlucose);
        final dataBytes = base64Decode(r.summaryJson!);
        dataJson = await EncryptionHelper.decryptField(dataBytes, key);
      } catch (e) {
        debugPrint('Lab report decryption failed: $e');
      }
    }
    
    return DecryptedLabReport(
      id: r.id,
      userId: r.userId,
      reportName: r.reportName,
      reportUrl: r.reportUrl,
      labName: r.labName,
      extractedDataJson: dataJson,
      uploadedAt: r.uploadedAt,
    );
  }

  Future<int> deleteReport(int id) =>
      (delete(labReports)..where((t) => t.id.equals(id))).go();
}

class DecryptedLabReport {
  final int id;
  final String userId;
  final String reportName;
  final String? reportUrl;
  final String? labName;
  final String extractedDataJson;
  final DateTime uploadedAt;

  DecryptedLabReport({
    required this.id,
    required this.userId,
    required this.reportName,
    this.reportUrl,
    this.labName,
    required this.extractedDataJson,
    required this.uploadedAt,
  });

  Map<String, double?> get values {
    final map = <String, double?>{};
    for (final entry in Uri.splitQueryString(extractedDataJson).entries) {
      map[entry.key] = double.tryParse(entry.value);
    }
    return map;
  }
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

  Future<List<AbhaLink>> getAllLinksForUser(String userId) =>
      (select(abhaLinks)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.linkedAt)]))
          .get();

  Future<int> linkAbha(AbhaLinksCompanion entry) =>
      into(abhaLinks).insert(entry);

  Future<int> linkAbhaOrUpdate(AbhaLinksCompanion entry) =>
      into(abhaLinks).insertOnConflictUpdate(entry);

  Future<int> unlinkAbha(String userId) =>
      (delete(abhaLinks)..where((t) => t.userId.equals(userId))).go();

  Future<int> updateLastSynced(String userId) async {
    final existing = await getLinkForUser(userId);
    if (existing == null) return 0;
    
    return (update(abhaLinks)..where((t) => t.userId.equals(userId)))
        .write(AbhaLinksCompanion(lastSyncedAt: Value(DateTime.now())));
  }

  Future<bool> isLinked(String userId) async {
    final link = await getLinkForUser(userId);
    return link != null;
  }

  Future<AbhaProfile?> fetchAndCacheProfile(String userId, String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('https://api.abdm.gov.in/v1/profile'),
        headers: {'Authorization': 'Bearer $accessToken'},
      ).timeout(const Duration(seconds: 15));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final profile = AbhaProfile(
          abhaNumber: data['healthIdNumber'] ?? '',
          firstName: data['firstName'] ?? '',
          lastName: data['lastName'] ?? '',
          gender: data['gender'] ?? '',
          dateOfBirth: data['dateOfBirth'] != null 
              ? DateTime.tryParse(data['dateOfBirth']) 
              : null,
          stateCode: data['stateCode'] ?? '',
          districtCode: data['districtCode'] ?? '',
        );
        
        await linkAbhaOrUpdate(AbhaLinksCompanion.insert(
          userId: userId,
          abhaNumber: profile.abhaNumber,
          firstName: Value(profile.firstName),
          lastName: Value(profile.lastName),
          gender: Value(profile.gender),
          dateOfBirth: Value(profile.dateOfBirth),
          stateCode: Value(profile.stateCode),
          districtCode: Value(profile.districtCode),
          isVerified: const Value(true),
          linkedAt: DateTime.now(),
        ));
        
        return profile;
      }
    } catch (e) {
      debugPrint('ABHA profile fetch failed: $e');
    }
    return null;
  }

  Future<List<PrescriptionRecord>> fetchPrescriptions(String userId, String accessToken) async {
    final prescriptions = <PrescriptionRecord>[];
    
    try {
      final response = await http.get(
        Uri.parse('https://api.abdm.gov.in/v1/prescriptions'),
        headers: {'Authorization': 'Bearer $accessToken'},
      ).timeout(const Duration(seconds: 30));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final records = data['prescriptions'] as List<dynamic>? ?? [];
        
        for (final r in records) {
          prescriptions.add(PrescriptionRecord(
            id: r['prescriptionId'] ?? '',
            date: DateTime.tryParse(r['prescriptionDate'] ?? ''),
            doctorName: r['consultation']['doctorName'] ?? '',
            facilityName: r['consultation']['facility']['name'] ?? '',
            diagnosis: r['consultation']['diagnosis'] ?? '',
          ));
        }
      }
    } catch (e) {
      debugPrint('ABHA prescriptions fetch failed: $e');
    }
    
    return prescriptions;
  }
}

class AbhaProfile {
  final String abhaNumber;
  final String firstName;
  final String lastName;
  final String gender;
  final DateTime? dateOfBirth;
  final String stateCode;
  final String districtCode;

  AbhaProfile({
    required this.abhaNumber,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.dateOfBirth,
    required this.stateCode,
    required this.districtCode,
  });

  String get fullName => '$firstName $lastName'.trim();
  String get displayId => 'ABHA-${abhaNumber.substring(abhaNumber.length - 4)}';
}

class PrescriptionRecord {
  final String id;
  final DateTime? date;
  final String doctorName;
  final String facilityName;
  final String diagnosis;

  PrescriptionRecord({
    required this.id,
    this.date,
    required this.doctorName,
    required this.facilityName,
    required this.diagnosis,
  });
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

  Future<int> autoPopulateMedications(String userId) async {
    final activeMeds = await db.medicationsDao.getActiveMedicationNames(userId);
    final medsString = activeMeds.join(', ');
    
    final existingCard = await getCardForUser(userId);
    final now = DateTime.now();
    
    if (existingCard != null) {
      return (update(emergencyCard)..where((t) => t.userId.equals(userId)))
          .write(EmergencyCardCompanion(
            medications: Value(medsString),
            updatedAt: Value(now),
          ));
    } else {
      return into(emergencyCard).insert(EmergencyCardCompanion.insert(
        userId: userId,
        medications: Value(medsString),
        updatedAt: now,
      ));
    }
  }

  Future<String?> getActiveMedicationsList(String userId) async {
    final activeMeds = await db.medicationsDao.getActiveMedicationNames(userId);
    return activeMeds.isEmpty ? null : activeMeds.join(', ');
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
