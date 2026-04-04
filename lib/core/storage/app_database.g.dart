// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
mixin _$FoodLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoodLogsTable get foodLogs => attachedDatabase.foodLogs;
  FoodLogsDaoManager get managers => FoodLogsDaoManager(this);
}

class FoodLogsDaoManager {
  final _$FoodLogsDaoMixin _db;
  FoodLogsDaoManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db.attachedDatabase, _db.foodLogs);
}

mixin _$FoodItemsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FoodItemsTable get foodItems => attachedDatabase.foodItems;
  FoodItemsDaoManager get managers => FoodItemsDaoManager(this);
}

class FoodItemsDaoManager {
  final _$FoodItemsDaoMixin _db;
  FoodItemsDaoManager(this._db);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db.attachedDatabase, _db.foodItems);
}

mixin _$WorkoutLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkoutLogsTable get workoutLogs => attachedDatabase.workoutLogs;
  WorkoutLogsDaoManager get managers => WorkoutLogsDaoManager(this);
}

class WorkoutLogsDaoManager {
  final _$WorkoutLogsDaoMixin _db;
  WorkoutLogsDaoManager(this._db);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db.attachedDatabase, _db.workoutLogs);
}

mixin _$StepLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $StepLogsTable get stepLogs => attachedDatabase.stepLogs;
  StepLogsDaoManager get managers => StepLogsDaoManager(this);
}

class StepLogsDaoManager {
  final _$StepLogsDaoMixin _db;
  StepLogsDaoManager(this._db);
  $$StepLogsTableTableManager get stepLogs =>
      $$StepLogsTableTableManager(_db.attachedDatabase, _db.stepLogs);
}

mixin _$SleepLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $SleepLogsTable get sleepLogs => attachedDatabase.sleepLogs;
  SleepLogsDaoManager get managers => SleepLogsDaoManager(this);
}

class SleepLogsDaoManager {
  final _$SleepLogsDaoMixin _db;
  SleepLogsDaoManager(this._db);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db.attachedDatabase, _db.sleepLogs);
}

mixin _$MoodLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MoodLogsTable get moodLogs => attachedDatabase.moodLogs;
  MoodLogsDaoManager get managers => MoodLogsDaoManager(this);
}

class MoodLogsDaoManager {
  final _$MoodLogsDaoMixin _db;
  MoodLogsDaoManager(this._db);
  $$MoodLogsTableTableManager get moodLogs =>
      $$MoodLogsTableTableManager(_db.attachedDatabase, _db.moodLogs);
}

mixin _$HabitsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $HabitCompletionsTable get habitCompletions =>
      attachedDatabase.habitCompletions;
  HabitsDaoManager get managers => HabitsDaoManager(this);
}

class HabitsDaoManager {
  final _$HabitsDaoMixin _db;
  HabitsDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(
        _db.attachedDatabase,
        _db.habitCompletions,
      );
}

mixin _$HabitCompletionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $HabitsTable get habits => attachedDatabase.habits;
  $HabitCompletionsTable get habitCompletions =>
      attachedDatabase.habitCompletions;
  HabitCompletionsDaoManager get managers => HabitCompletionsDaoManager(this);
}

class HabitCompletionsDaoManager {
  final _$HabitCompletionsDaoMixin _db;
  HabitCompletionsDaoManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(
        _db.attachedDatabase,
        _db.habitCompletions,
      );
}

mixin _$BodyMeasurementsDaoMixin on DatabaseAccessor<AppDatabase> {
  $BodyMeasurementsTable get bodyMeasurements =>
      attachedDatabase.bodyMeasurements;
  BodyMeasurementsDaoManager get managers => BodyMeasurementsDaoManager(this);
}

class BodyMeasurementsDaoManager {
  final _$BodyMeasurementsDaoMixin _db;
  BodyMeasurementsDaoManager(this._db);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(
        _db.attachedDatabase,
        _db.bodyMeasurements,
      );
}

mixin _$MedicationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $MedicationsTable get medications => attachedDatabase.medications;
  MedicationsDaoManager get managers => MedicationsDaoManager(this);
}

class MedicationsDaoManager {
  final _$MedicationsDaoMixin _db;
  MedicationsDaoManager(this._db);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db.attachedDatabase, _db.medications);
}

mixin _$FastingLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $FastingLogsTable get fastingLogs => attachedDatabase.fastingLogs;
  FastingLogsDaoManager get managers => FastingLogsDaoManager(this);
}

class FastingLogsDaoManager {
  final _$FastingLogsDaoMixin _db;
  FastingLogsDaoManager(this._db);
  $$FastingLogsTableTableManager get fastingLogs =>
      $$FastingLogsTableTableManager(_db.attachedDatabase, _db.fastingLogs);
}

mixin _$MealPlansDaoMixin on DatabaseAccessor<AppDatabase> {
  $MealPlansTable get mealPlans => attachedDatabase.mealPlans;
  MealPlansDaoManager get managers => MealPlansDaoManager(this);
}

class MealPlansDaoManager {
  final _$MealPlansDaoMixin _db;
  MealPlansDaoManager(this._db);
  $$MealPlansTableTableManager get mealPlans =>
      $$MealPlansTableTableManager(_db.attachedDatabase, _db.mealPlans);
}

mixin _$RecipesDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipesTable get recipes => attachedDatabase.recipes;
  RecipesDaoManager get managers => RecipesDaoManager(this);
}

class RecipesDaoManager {
  final _$RecipesDaoMixin _db;
  RecipesDaoManager(this._db);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db.attachedDatabase, _db.recipes);
}

mixin _$BloodPressureLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $BloodPressureLogsTable get bloodPressureLogs =>
      attachedDatabase.bloodPressureLogs;
  BloodPressureLogsDaoManager get managers => BloodPressureLogsDaoManager(this);
}

class BloodPressureLogsDaoManager {
  final _$BloodPressureLogsDaoMixin _db;
  BloodPressureLogsDaoManager(this._db);
  $$BloodPressureLogsTableTableManager get bloodPressureLogs =>
      $$BloodPressureLogsTableTableManager(
        _db.attachedDatabase,
        _db.bloodPressureLogs,
      );
}

mixin _$GlucoseLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $GlucoseLogsTable get glucoseLogs => attachedDatabase.glucoseLogs;
  GlucoseLogsDaoManager get managers => GlucoseLogsDaoManager(this);
}

class GlucoseLogsDaoManager {
  final _$GlucoseLogsDaoMixin _db;
  GlucoseLogsDaoManager(this._db);
  $$GlucoseLogsTableTableManager get glucoseLogs =>
      $$GlucoseLogsTableTableManager(_db.attachedDatabase, _db.glucoseLogs);
}

mixin _$Spo2LogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $Spo2LogsTable get spo2Logs => attachedDatabase.spo2Logs;
  Spo2LogsDaoManager get managers => Spo2LogsDaoManager(this);
}

class Spo2LogsDaoManager {
  final _$Spo2LogsDaoMixin _db;
  Spo2LogsDaoManager(this._db);
  $$Spo2LogsTableTableManager get spo2Logs =>
      $$Spo2LogsTableTableManager(_db.attachedDatabase, _db.spo2Logs);
}

mixin _$PeriodLogsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PeriodLogsTable get periodLogs => attachedDatabase.periodLogs;
  PeriodLogsDaoManager get managers => PeriodLogsDaoManager(this);
}

class PeriodLogsDaoManager {
  final _$PeriodLogsDaoMixin _db;
  PeriodLogsDaoManager(this._db);
  $$PeriodLogsTableTableManager get periodLogs =>
      $$PeriodLogsTableTableManager(_db.attachedDatabase, _db.periodLogs);
}

mixin _$JournalEntriesDaoMixin on DatabaseAccessor<AppDatabase> {
  $JournalEntriesTable get journalEntries => attachedDatabase.journalEntries;
  JournalEntriesDaoManager get managers => JournalEntriesDaoManager(this);
}

class JournalEntriesDaoManager {
  final _$JournalEntriesDaoMixin _db;
  JournalEntriesDaoManager(this._db);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(
        _db.attachedDatabase,
        _db.journalEntries,
      );
}

mixin _$DoctorAppointmentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DoctorAppointmentsTable get doctorAppointments =>
      attachedDatabase.doctorAppointments;
  DoctorAppointmentsDaoManager get managers =>
      DoctorAppointmentsDaoManager(this);
}

class DoctorAppointmentsDaoManager {
  final _$DoctorAppointmentsDaoMixin _db;
  DoctorAppointmentsDaoManager(this._db);
  $$DoctorAppointmentsTableTableManager get doctorAppointments =>
      $$DoctorAppointmentsTableTableManager(
        _db.attachedDatabase,
        _db.doctorAppointments,
      );
}

mixin _$LabReportsDaoMixin on DatabaseAccessor<AppDatabase> {
  $LabReportsTable get labReports => attachedDatabase.labReports;
  LabReportsDaoManager get managers => LabReportsDaoManager(this);
}

class LabReportsDaoManager {
  final _$LabReportsDaoMixin _db;
  LabReportsDaoManager(this._db);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db.attachedDatabase, _db.labReports);
}

mixin _$AbhaLinksDaoMixin on DatabaseAccessor<AppDatabase> {
  $AbhaLinksTable get abhaLinks => attachedDatabase.abhaLinks;
  AbhaLinksDaoManager get managers => AbhaLinksDaoManager(this);
}

class AbhaLinksDaoManager {
  final _$AbhaLinksDaoMixin _db;
  AbhaLinksDaoManager(this._db);
  $$AbhaLinksTableTableManager get abhaLinks =>
      $$AbhaLinksTableTableManager(_db.attachedDatabase, _db.abhaLinks);
}

mixin _$EmergencyCardDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmergencyCardTable get emergencyCard => attachedDatabase.emergencyCard;
  EmergencyCardDaoManager get managers => EmergencyCardDaoManager(this);
}

class EmergencyCardDaoManager {
  final _$EmergencyCardDaoMixin _db;
  EmergencyCardDaoManager(this._db);
  $$EmergencyCardTableTableManager get emergencyCard =>
      $$EmergencyCardTableTableManager(_db.attachedDatabase, _db.emergencyCard);
}

mixin _$FestivalCalendarDaoMixin on DatabaseAccessor<AppDatabase> {
  $FestivalCalendarTable get festivalCalendar =>
      attachedDatabase.festivalCalendar;
  FestivalCalendarDaoManager get managers => FestivalCalendarDaoManager(this);
}

class FestivalCalendarDaoManager {
  final _$FestivalCalendarDaoMixin _db;
  FestivalCalendarDaoManager(this._db);
  $$FestivalCalendarTableTableManager get festivalCalendar =>
      $$FestivalCalendarTableTableManager(
        _db.attachedDatabase,
        _db.festivalCalendar,
      );
}

mixin _$RemoteConfigCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $RemoteConfigCacheTable get remoteConfigCache =>
      attachedDatabase.remoteConfigCache;
  RemoteConfigCacheDaoManager get managers => RemoteConfigCacheDaoManager(this);
}

class RemoteConfigCacheDaoManager {
  final _$RemoteConfigCacheDaoMixin _db;
  RemoteConfigCacheDaoManager(this._db);
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(
        _db.attachedDatabase,
        _db.remoteConfigCache,
      );
}

mixin _$KarmaTransactionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $KarmaTransactionsTable get karmaTransactions =>
      attachedDatabase.karmaTransactions;
  KarmaTransactionsDaoManager get managers => KarmaTransactionsDaoManager(this);
}

class KarmaTransactionsDaoManager {
  final _$KarmaTransactionsDaoMixin _db;
  KarmaTransactionsDaoManager(this._db);
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.karmaTransactions,
      );
}

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

mixin _$PersonalRecordsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PersonalRecordsTable get personalRecords => attachedDatabase.personalRecords;
  PersonalRecordsDaoManager get managers => PersonalRecordsDaoManager(this);
}

class PersonalRecordsDaoManager {
  final _$PersonalRecordsDaoMixin _db;
  PersonalRecordsDaoManager(this._db);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(
        _db.attachedDatabase,
        _db.personalRecords,
      );
}

mixin _$SyncQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  SyncQueueDaoManager get managers => SyncQueueDaoManager(this);
}

class SyncQueueDaoManager {
  final _$SyncQueueDaoMixin _db;
  SyncQueueDaoManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
}

mixin _$SyncDeadLetterDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncDeadLetterTable get syncDeadLetter => attachedDatabase.syncDeadLetter;
  SyncDeadLetterDaoManager get managers => SyncDeadLetterDaoManager(this);
}

class SyncDeadLetterDaoManager {
  final _$SyncDeadLetterDaoMixin _db;
  SyncDeadLetterDaoManager(this._db);
  $$SyncDeadLetterTableTableManager get syncDeadLetter =>
      $$SyncDeadLetterTableTableManager(
        _db.attachedDatabase,
        _db.syncDeadLetter,
      );
}

class $FoodLogsTable extends FoodLogs with TableInfo<$FoodLogsTable, FoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodNameMeta = const VerificationMeta(
    'foodName',
  );
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
    'food_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityGMeta = const VerificationMeta(
    'quantityG',
  );
  @override
  late final GeneratedColumn<double> quantityG = GeneratedColumn<double>(
    'quantity_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinGMeta = const VerificationMeta(
    'proteinG',
  );
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
    'protein_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
    'carbs_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
    'fat_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vitaminDMcgMeta = const VerificationMeta(
    'vitaminDMcg',
  );
  @override
  late final GeneratedColumn<double> vitaminDMcg = GeneratedColumn<double>(
    'vitamin_d_mcg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vitaminB12McgMeta = const VerificationMeta(
    'vitaminB12Mcg',
  );
  @override
  late final GeneratedColumn<double> vitaminB12Mcg = GeneratedColumn<double>(
    'vitamin_b12_mcg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ironMgMeta = const VerificationMeta('ironMg');
  @override
  late final GeneratedColumn<double> ironMg = GeneratedColumn<double>(
    'iron_mg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _calciumMgMeta = const VerificationMeta(
    'calciumMg',
  );
  @override
  late final GeneratedColumn<double> calciumMg = GeneratedColumn<double>(
    'calcium_mg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    foodName,
    mealType,
    quantityG,
    calories,
    proteinG,
    carbsG,
    fatG,
    vitaminDMcg,
    vitaminB12Mcg,
    ironMg,
    calciumMg,
    loggedAt,
    syncStatus,
    idempotencyKey,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_name')) {
      context.handle(
        _foodNameMeta,
        foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta),
      );
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('quantity_g')) {
      context.handle(
        _quantityGMeta,
        quantityG.isAcceptableOrUnknown(data['quantity_g']!, _quantityGMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityGMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein_g')) {
      context.handle(
        _proteinGMeta,
        proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta),
      );
    } else if (isInserting) {
      context.missing(_proteinGMeta);
    }
    if (data.containsKey('carbs_g')) {
      context.handle(
        _carbsGMeta,
        carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta),
      );
    } else if (isInserting) {
      context.missing(_carbsGMeta);
    }
    if (data.containsKey('fat_g')) {
      context.handle(
        _fatGMeta,
        fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta),
      );
    } else if (isInserting) {
      context.missing(_fatGMeta);
    }
    if (data.containsKey('vitamin_d_mcg')) {
      context.handle(
        _vitaminDMcgMeta,
        vitaminDMcg.isAcceptableOrUnknown(
          data['vitamin_d_mcg']!,
          _vitaminDMcgMeta,
        ),
      );
    }
    if (data.containsKey('vitamin_b12_mcg')) {
      context.handle(
        _vitaminB12McgMeta,
        vitaminB12Mcg.isAcceptableOrUnknown(
          data['vitamin_b12_mcg']!,
          _vitaminB12McgMeta,
        ),
      );
    }
    if (data.containsKey('iron_mg')) {
      context.handle(
        _ironMgMeta,
        ironMg.isAcceptableOrUnknown(data['iron_mg']!, _ironMgMeta),
      );
    }
    if (data.containsKey('calcium_mg')) {
      context.handle(
        _calciumMgMeta,
        calciumMg.isAcceptableOrUnknown(data['calcium_mg']!, _calciumMgMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_syncStatusMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {idempotencyKey},
  ];
  @override
  FoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      foodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_name'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      quantityG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_g'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories'],
      )!,
      proteinG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_g'],
      )!,
      carbsG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_g'],
      )!,
      fatG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_g'],
      )!,
      vitaminDMcg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_d_mcg'],
      )!,
      vitaminB12Mcg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_b12_mcg'],
      )!,
      ironMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}iron_mg'],
      )!,
      calciumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calcium_mg'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
    );
  }

  @override
  $FoodLogsTable createAlias(String alias) {
    return $FoodLogsTable(attachedDatabase, alias);
  }
}

class FoodLog extends DataClass implements Insertable<FoodLog> {
  final int id;
  final String userId;
  final String foodName;
  final String mealType;
  final double quantityG;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
  final double ironMg;
  final double calciumMg;
  final DateTime loggedAt;
  final String syncStatus;
  final String idempotencyKey;
  const FoodLog({
    required this.id,
    required this.userId,
    required this.foodName,
    required this.mealType,
    required this.quantityG,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    required this.vitaminDMcg,
    required this.vitaminB12Mcg,
    required this.ironMg,
    required this.calciumMg,
    required this.loggedAt,
    required this.syncStatus,
    required this.idempotencyKey,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['food_name'] = Variable<String>(foodName);
    map['meal_type'] = Variable<String>(mealType);
    map['quantity_g'] = Variable<double>(quantityG);
    map['calories'] = Variable<double>(calories);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fat_g'] = Variable<double>(fatG);
    map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg);
    map['vitamin_b12_mcg'] = Variable<double>(vitaminB12Mcg);
    map['iron_mg'] = Variable<double>(ironMg);
    map['calcium_mg'] = Variable<double>(calciumMg);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    return map;
  }

  FoodLogsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      foodName: Value(foodName),
      mealType: Value(mealType),
      quantityG: Value(quantityG),
      calories: Value(calories),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      vitaminDMcg: Value(vitaminDMcg),
      vitaminB12Mcg: Value(vitaminB12Mcg),
      ironMg: Value(ironMg),
      calciumMg: Value(calciumMg),
      loggedAt: Value(loggedAt),
      syncStatus: Value(syncStatus),
      idempotencyKey: Value(idempotencyKey),
    );
  }

  factory FoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodName: serializer.fromJson<String>(json['foodName']),
      mealType: serializer.fromJson<String>(json['mealType']),
      quantityG: serializer.fromJson<double>(json['quantityG']),
      calories: serializer.fromJson<double>(json['calories']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatG: serializer.fromJson<double>(json['fatG']),
      vitaminDMcg: serializer.fromJson<double>(json['vitaminDMcg']),
      vitaminB12Mcg: serializer.fromJson<double>(json['vitaminB12Mcg']),
      ironMg: serializer.fromJson<double>(json['ironMg']),
      calciumMg: serializer.fromJson<double>(json['calciumMg']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'foodName': serializer.toJson<String>(foodName),
      'mealType': serializer.toJson<String>(mealType),
      'quantityG': serializer.toJson<double>(quantityG),
      'calories': serializer.toJson<double>(calories),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatG': serializer.toJson<double>(fatG),
      'vitaminDMcg': serializer.toJson<double>(vitaminDMcg),
      'vitaminB12Mcg': serializer.toJson<double>(vitaminB12Mcg),
      'ironMg': serializer.toJson<double>(ironMg),
      'calciumMg': serializer.toJson<double>(calciumMg),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
    };
  }

  FoodLog copyWith({
    int? id,
    String? userId,
    String? foodName,
    String? mealType,
    double? quantityG,
    double? calories,
    double? proteinG,
    double? carbsG,
    double? fatG,
    double? vitaminDMcg,
    double? vitaminB12Mcg,
    double? ironMg,
    double? calciumMg,
    DateTime? loggedAt,
    String? syncStatus,
    String? idempotencyKey,
  }) => FoodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    foodName: foodName ?? this.foodName,
    mealType: mealType ?? this.mealType,
    quantityG: quantityG ?? this.quantityG,
    calories: calories ?? this.calories,
    proteinG: proteinG ?? this.proteinG,
    carbsG: carbsG ?? this.carbsG,
    fatG: fatG ?? this.fatG,
    vitaminDMcg: vitaminDMcg ?? this.vitaminDMcg,
    vitaminB12Mcg: vitaminB12Mcg ?? this.vitaminB12Mcg,
    ironMg: ironMg ?? this.ironMg,
    calciumMg: calciumMg ?? this.calciumMg,
    loggedAt: loggedAt ?? this.loggedAt,
    syncStatus: syncStatus ?? this.syncStatus,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
  );
  FoodLog copyWithCompanion(FoodLogsCompanion data) {
    return FoodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      quantityG: data.quantityG.present ? data.quantityG.value : this.quantityG,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      vitaminDMcg: data.vitaminDMcg.present
          ? data.vitaminDMcg.value
          : this.vitaminDMcg,
      vitaminB12Mcg: data.vitaminB12Mcg.present
          ? data.vitaminB12Mcg.value
          : this.vitaminB12Mcg,
      ironMg: data.ironMg.present ? data.ironMg.value : this.ironMg,
      calciumMg: data.calciumMg.present ? data.calciumMg.value : this.calciumMg,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodName: $foodName, ')
          ..write('mealType: $mealType, ')
          ..write('quantityG: $quantityG, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('vitaminB12Mcg: $vitaminB12Mcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('idempotencyKey: $idempotencyKey')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    foodName,
    mealType,
    quantityG,
    calories,
    proteinG,
    carbsG,
    fatG,
    vitaminDMcg,
    vitaminB12Mcg,
    ironMg,
    calciumMg,
    loggedAt,
    syncStatus,
    idempotencyKey,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodName == this.foodName &&
          other.mealType == this.mealType &&
          other.quantityG == this.quantityG &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.vitaminDMcg == this.vitaminDMcg &&
          other.vitaminB12Mcg == this.vitaminB12Mcg &&
          other.ironMg == this.ironMg &&
          other.calciumMg == this.calciumMg &&
          other.loggedAt == this.loggedAt &&
          other.syncStatus == this.syncStatus &&
          other.idempotencyKey == this.idempotencyKey);
}

class FoodLogsCompanion extends UpdateCompanion<FoodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> foodName;
  final Value<String> mealType;
  final Value<double> quantityG;
  final Value<double> calories;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatG;
  final Value<double> vitaminDMcg;
  final Value<double> vitaminB12Mcg;
  final Value<double> ironMg;
  final Value<double> calciumMg;
  final Value<DateTime> loggedAt;
  final Value<String> syncStatus;
  final Value<String> idempotencyKey;
  const FoodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodName = const Value.absent(),
    this.mealType = const Value.absent(),
    this.quantityG = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.vitaminDMcg = const Value.absent(),
    this.vitaminB12Mcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
  });
  FoodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String foodName,
    required String mealType,
    required double quantityG,
    required double calories,
    required double proteinG,
    required double carbsG,
    required double fatG,
    this.vitaminDMcg = const Value.absent(),
    this.vitaminB12Mcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    required DateTime loggedAt,
    required String syncStatus,
    required String idempotencyKey,
  }) : userId = Value(userId),
       foodName = Value(foodName),
       mealType = Value(mealType),
       quantityG = Value(quantityG),
       calories = Value(calories),
       proteinG = Value(proteinG),
       carbsG = Value(carbsG),
       fatG = Value(fatG),
       loggedAt = Value(loggedAt),
       syncStatus = Value(syncStatus),
       idempotencyKey = Value(idempotencyKey);
  static Insertable<FoodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? foodName,
    Expression<String>? mealType,
    Expression<double>? quantityG,
    Expression<double>? calories,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<double>? vitaminDMcg,
    Expression<double>? vitaminB12Mcg,
    Expression<double>? ironMg,
    Expression<double>? calciumMg,
    Expression<DateTime>? loggedAt,
    Expression<String>? syncStatus,
    Expression<String>? idempotencyKey,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodName != null) 'food_name': foodName,
      if (mealType != null) 'meal_type': mealType,
      if (quantityG != null) 'quantity_g': quantityG,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (vitaminDMcg != null) 'vitamin_d_mcg': vitaminDMcg,
      if (vitaminB12Mcg != null) 'vitamin_b12_mcg': vitaminB12Mcg,
      if (ironMg != null) 'iron_mg': ironMg,
      if (calciumMg != null) 'calcium_mg': calciumMg,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
    });
  }

  FoodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? foodName,
    Value<String>? mealType,
    Value<double>? quantityG,
    Value<double>? calories,
    Value<double>? proteinG,
    Value<double>? carbsG,
    Value<double>? fatG,
    Value<double>? vitaminDMcg,
    Value<double>? vitaminB12Mcg,
    Value<double>? ironMg,
    Value<double>? calciumMg,
    Value<DateTime>? loggedAt,
    Value<String>? syncStatus,
    Value<String>? idempotencyKey,
  }) {
    return FoodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
      quantityG: quantityG ?? this.quantityG,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      vitaminDMcg: vitaminDMcg ?? this.vitaminDMcg,
      vitaminB12Mcg: vitaminB12Mcg ?? this.vitaminB12Mcg,
      ironMg: ironMg ?? this.ironMg,
      calciumMg: calciumMg ?? this.calciumMg,
      loggedAt: loggedAt ?? this.loggedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (quantityG.present) {
      map['quantity_g'] = Variable<double>(quantityG.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (vitaminDMcg.present) {
      map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg.value);
    }
    if (vitaminB12Mcg.present) {
      map['vitamin_b12_mcg'] = Variable<double>(vitaminB12Mcg.value);
    }
    if (ironMg.present) {
      map['iron_mg'] = Variable<double>(ironMg.value);
    }
    if (calciumMg.present) {
      map['calcium_mg'] = Variable<double>(calciumMg.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodName: $foodName, ')
          ..write('mealType: $mealType, ')
          ..write('quantityG: $quantityG, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('vitaminB12Mcg: $vitaminB12Mcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('idempotencyKey: $idempotencyKey')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameLocalMeta = const VerificationMeta(
    'nameLocal',
  );
  @override
  late final GeneratedColumn<String> nameLocal = GeneratedColumn<String>(
    'name_local',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<double> caloriesPer100g = GeneratedColumn<double>(
    'calories_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vitaminDMcgMeta = const VerificationMeta(
    'vitaminDMcg',
  );
  @override
  late final GeneratedColumn<double> vitaminDMcg = GeneratedColumn<double>(
    'vitamin_d_mcg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _vitaminB12McgMeta = const VerificationMeta(
    'vitaminB12Mcg',
  );
  @override
  late final GeneratedColumn<double> vitaminB12Mcg = GeneratedColumn<double>(
    'vitamin_b12_mcg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _ironMgMeta = const VerificationMeta('ironMg');
  @override
  late final GeneratedColumn<double> ironMg = GeneratedColumn<double>(
    'iron_mg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _calciumMgMeta = const VerificationMeta(
    'calciumMg',
  );
  @override
  late final GeneratedColumn<double> calciumMg = GeneratedColumn<double>(
    'calcium_mg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _servingSizesJsonMeta = const VerificationMeta(
    'servingSizesJson',
  );
  @override
  late final GeneratedColumn<String> servingSizesJson = GeneratedColumn<String>(
    'serving_sizes_json',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 512),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    nameLocal,
    region,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    vitaminDMcg,
    vitaminB12Mcg,
    ironMg,
    calciumMg,
    servingSizesJson,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_local')) {
      context.handle(
        _nameLocalMeta,
        nameLocal.isAcceptableOrUnknown(data['name_local']!, _nameLocalMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('vitamin_d_mcg')) {
      context.handle(
        _vitaminDMcgMeta,
        vitaminDMcg.isAcceptableOrUnknown(
          data['vitamin_d_mcg']!,
          _vitaminDMcgMeta,
        ),
      );
    }
    if (data.containsKey('vitamin_b12_mcg')) {
      context.handle(
        _vitaminB12McgMeta,
        vitaminB12Mcg.isAcceptableOrUnknown(
          data['vitamin_b12_mcg']!,
          _vitaminB12McgMeta,
        ),
      );
    }
    if (data.containsKey('iron_mg')) {
      context.handle(
        _ironMgMeta,
        ironMg.isAcceptableOrUnknown(data['iron_mg']!, _ironMgMeta),
      );
    }
    if (data.containsKey('calcium_mg')) {
      context.handle(
        _calciumMgMeta,
        calciumMg.isAcceptableOrUnknown(data['calcium_mg']!, _calciumMgMeta),
      );
    }
    if (data.containsKey('serving_sizes_json')) {
      context.handle(
        _servingSizesJsonMeta,
        servingSizesJson.isAcceptableOrUnknown(
          data['serving_sizes_json']!,
          _servingSizesJsonMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      nameLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name_local'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      vitaminDMcg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_d_mcg'],
      )!,
      vitaminB12Mcg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_b12_mcg'],
      )!,
      ironMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}iron_mg'],
      )!,
      calciumMg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calcium_mg'],
      )!,
      servingSizesJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serving_sizes_json'],
      ),
    );
  }

  @override
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final int id;
  final String name;
  final String? nameLocal;
  final String? region;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double vitaminDMcg;
  final double vitaminB12Mcg;
  final double ironMg;
  final double calciumMg;
  final String? servingSizesJson;
  const FoodItem({
    required this.id,
    required this.name,
    this.nameLocal,
    this.region,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    required this.vitaminDMcg,
    required this.vitaminB12Mcg,
    required this.ironMg,
    required this.calciumMg,
    this.servingSizesJson,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || nameLocal != null) {
      map['name_local'] = Variable<String>(nameLocal);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['calories_per100g'] = Variable<double>(caloriesPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg);
    map['vitamin_b12_mcg'] = Variable<double>(vitaminB12Mcg);
    map['iron_mg'] = Variable<double>(ironMg);
    map['calcium_mg'] = Variable<double>(calciumMg);
    if (!nullToAbsent || servingSizesJson != null) {
      map['serving_sizes_json'] = Variable<String>(servingSizesJson);
    }
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      name: Value(name),
      nameLocal: nameLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(nameLocal),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      vitaminDMcg: Value(vitaminDMcg),
      vitaminB12Mcg: Value(vitaminB12Mcg),
      ironMg: Value(ironMg),
      calciumMg: Value(calciumMg),
      servingSizesJson: servingSizesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(servingSizesJson),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      nameLocal: serializer.fromJson<String?>(json['nameLocal']),
      region: serializer.fromJson<String?>(json['region']),
      caloriesPer100g: serializer.fromJson<double>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      vitaminDMcg: serializer.fromJson<double>(json['vitaminDMcg']),
      vitaminB12Mcg: serializer.fromJson<double>(json['vitaminB12Mcg']),
      ironMg: serializer.fromJson<double>(json['ironMg']),
      calciumMg: serializer.fromJson<double>(json['calciumMg']),
      servingSizesJson: serializer.fromJson<String?>(json['servingSizesJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'nameLocal': serializer.toJson<String?>(nameLocal),
      'region': serializer.toJson<String?>(region),
      'caloriesPer100g': serializer.toJson<double>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'vitaminDMcg': serializer.toJson<double>(vitaminDMcg),
      'vitaminB12Mcg': serializer.toJson<double>(vitaminB12Mcg),
      'ironMg': serializer.toJson<double>(ironMg),
      'calciumMg': serializer.toJson<double>(calciumMg),
      'servingSizesJson': serializer.toJson<String?>(servingSizesJson),
    };
  }

  FoodItem copyWith({
    int? id,
    String? name,
    Value<String?> nameLocal = const Value.absent(),
    Value<String?> region = const Value.absent(),
    double? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
    double? vitaminDMcg,
    double? vitaminB12Mcg,
    double? ironMg,
    double? calciumMg,
    Value<String?> servingSizesJson = const Value.absent(),
  }) => FoodItem(
    id: id ?? this.id,
    name: name ?? this.name,
    nameLocal: nameLocal.present ? nameLocal.value : this.nameLocal,
    region: region.present ? region.value : this.region,
    caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    vitaminDMcg: vitaminDMcg ?? this.vitaminDMcg,
    vitaminB12Mcg: vitaminB12Mcg ?? this.vitaminB12Mcg,
    ironMg: ironMg ?? this.ironMg,
    calciumMg: calciumMg ?? this.calciumMg,
    servingSizesJson: servingSizesJson.present
        ? servingSizesJson.value
        : this.servingSizesJson,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      nameLocal: data.nameLocal.present ? data.nameLocal.value : this.nameLocal,
      region: data.region.present ? data.region.value : this.region,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      vitaminDMcg: data.vitaminDMcg.present
          ? data.vitaminDMcg.value
          : this.vitaminDMcg,
      vitaminB12Mcg: data.vitaminB12Mcg.present
          ? data.vitaminB12Mcg.value
          : this.vitaminB12Mcg,
      ironMg: data.ironMg.present ? data.ironMg.value : this.ironMg,
      calciumMg: data.calciumMg.present ? data.calciumMg.value : this.calciumMg,
      servingSizesJson: data.servingSizesJson.present
          ? data.servingSizesJson.value
          : this.servingSizesJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameLocal: $nameLocal, ')
          ..write('region: $region, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('vitaminB12Mcg: $vitaminB12Mcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('servingSizesJson: $servingSizesJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    nameLocal,
    region,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    vitaminDMcg,
    vitaminB12Mcg,
    ironMg,
    calciumMg,
    servingSizesJson,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.nameLocal == this.nameLocal &&
          other.region == this.region &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.vitaminDMcg == this.vitaminDMcg &&
          other.vitaminB12Mcg == this.vitaminB12Mcg &&
          other.ironMg == this.ironMg &&
          other.calciumMg == this.calciumMg &&
          other.servingSizesJson == this.servingSizesJson);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> nameLocal;
  final Value<String?> region;
  final Value<double> caloriesPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  final Value<double> vitaminDMcg;
  final Value<double> vitaminB12Mcg;
  final Value<double> ironMg;
  final Value<double> calciumMg;
  final Value<String?> servingSizesJson;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.nameLocal = const Value.absent(),
    this.region = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.vitaminDMcg = const Value.absent(),
    this.vitaminB12Mcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.servingSizesJson = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.nameLocal = const Value.absent(),
    this.region = const Value.absent(),
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    this.vitaminDMcg = const Value.absent(),
    this.vitaminB12Mcg = const Value.absent(),
    this.ironMg = const Value.absent(),
    this.calciumMg = const Value.absent(),
    this.servingSizesJson = const Value.absent(),
  }) : name = Value(name),
       caloriesPer100g = Value(caloriesPer100g),
       proteinPer100g = Value(proteinPer100g),
       carbsPer100g = Value(carbsPer100g),
       fatPer100g = Value(fatPer100g);
  static Insertable<FoodItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? nameLocal,
    Expression<String>? region,
    Expression<double>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? vitaminDMcg,
    Expression<double>? vitaminB12Mcg,
    Expression<double>? ironMg,
    Expression<double>? calciumMg,
    Expression<String>? servingSizesJson,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (nameLocal != null) 'name_local': nameLocal,
      if (region != null) 'region': region,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (vitaminDMcg != null) 'vitamin_d_mcg': vitaminDMcg,
      if (vitaminB12Mcg != null) 'vitamin_b12_mcg': vitaminB12Mcg,
      if (ironMg != null) 'iron_mg': ironMg,
      if (calciumMg != null) 'calcium_mg': calciumMg,
      if (servingSizesJson != null) 'serving_sizes_json': servingSizesJson,
    });
  }

  FoodItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? nameLocal,
    Value<String?>? region,
    Value<double>? caloriesPer100g,
    Value<double>? proteinPer100g,
    Value<double>? carbsPer100g,
    Value<double>? fatPer100g,
    Value<double>? vitaminDMcg,
    Value<double>? vitaminB12Mcg,
    Value<double>? ironMg,
    Value<double>? calciumMg,
    Value<String?>? servingSizesJson,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      nameLocal: nameLocal ?? this.nameLocal,
      region: region ?? this.region,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      vitaminDMcg: vitaminDMcg ?? this.vitaminDMcg,
      vitaminB12Mcg: vitaminB12Mcg ?? this.vitaminB12Mcg,
      ironMg: ironMg ?? this.ironMg,
      calciumMg: calciumMg ?? this.calciumMg,
      servingSizesJson: servingSizesJson ?? this.servingSizesJson,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameLocal.present) {
      map['name_local'] = Variable<String>(nameLocal.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (vitaminDMcg.present) {
      map['vitamin_d_mcg'] = Variable<double>(vitaminDMcg.value);
    }
    if (vitaminB12Mcg.present) {
      map['vitamin_b12_mcg'] = Variable<double>(vitaminB12Mcg.value);
    }
    if (ironMg.present) {
      map['iron_mg'] = Variable<double>(ironMg.value);
    }
    if (calciumMg.present) {
      map['calcium_mg'] = Variable<double>(calciumMg.value);
    }
    if (servingSizesJson.present) {
      map['serving_sizes_json'] = Variable<String>(servingSizesJson.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('nameLocal: $nameLocal, ')
          ..write('region: $region, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('vitaminDMcg: $vitaminDMcg, ')
          ..write('vitaminB12Mcg: $vitaminB12Mcg, ')
          ..write('ironMg: $ironMg, ')
          ..write('calciumMg: $calciumMg, ')
          ..write('servingSizesJson: $servingSizesJson')
          ..write(')'))
        .toString();
  }
}

class $WorkoutLogsTable extends WorkoutLogs
    with TableInfo<$WorkoutLogsTable, WorkoutLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesBurnedMeta = const VerificationMeta(
    'caloriesBurned',
  );
  @override
  late final GeneratedColumn<double> caloriesBurned = GeneratedColumn<double>(
    'calories_burned',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutTypeMeta = const VerificationMeta(
    'workoutType',
  );
  @override
  late final GeneratedColumn<String> workoutType = GeneratedColumn<String>(
    'workout_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<int> rpe = GeneratedColumn<int>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _routeJsonMeta = const VerificationMeta(
    'routeJson',
  );
  @override
  late final GeneratedColumn<String> routeJson = GeneratedColumn<String>(
    'route_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _distanceKmMeta = const VerificationMeta(
    'distanceKm',
  );
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
    'distance_km',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    title,
    durationMin,
    caloriesBurned,
    workoutType,
    rpe,
    routeJson,
    distanceKm,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
        _caloriesBurnedMeta,
        caloriesBurned.isAcceptableOrUnknown(
          data['calories_burned']!,
          _caloriesBurnedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesBurnedMeta);
    }
    if (data.containsKey('workout_type')) {
      context.handle(
        _workoutTypeMeta,
        workoutType.isAcceptableOrUnknown(
          data['workout_type']!,
          _workoutTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutTypeMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('route_json')) {
      context.handle(
        _routeJsonMeta,
        routeJson.isAcceptableOrUnknown(data['route_json']!, _routeJsonMeta),
      );
    }
    if (data.containsKey('distance_km')) {
      context.handle(
        _distanceKmMeta,
        distanceKm.isAcceptableOrUnknown(data['distance_km']!, _distanceKmMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      )!,
      caloriesBurned: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_burned'],
      )!,
      workoutType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_type'],
      )!,
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rpe'],
      ),
      routeJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}route_json'],
      ),
      distanceKm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_km'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $WorkoutLogsTable createAlias(String alias) {
    return $WorkoutLogsTable(attachedDatabase, alias);
  }
}

class WorkoutLog extends DataClass implements Insertable<WorkoutLog> {
  final int id;
  final String userId;
  final String title;
  final int durationMin;
  final double caloriesBurned;
  final String workoutType;
  final int? rpe;
  final String? routeJson;
  final double? distanceKm;
  final DateTime loggedAt;
  const WorkoutLog({
    required this.id,
    required this.userId,
    required this.title,
    required this.durationMin,
    required this.caloriesBurned,
    required this.workoutType,
    this.rpe,
    this.routeJson,
    this.distanceKm,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    map['duration_min'] = Variable<int>(durationMin);
    map['calories_burned'] = Variable<double>(caloriesBurned);
    map['workout_type'] = Variable<String>(workoutType);
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<int>(rpe);
    }
    if (!nullToAbsent || routeJson != null) {
      map['route_json'] = Variable<String>(routeJson);
    }
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  WorkoutLogsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
      durationMin: Value(durationMin),
      caloriesBurned: Value(caloriesBurned),
      workoutType: Value(workoutType),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      routeJson: routeJson == null && nullToAbsent
          ? const Value.absent()
          : Value(routeJson),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      loggedAt: Value(loggedAt),
    );
  }

  factory WorkoutLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      durationMin: serializer.fromJson<int>(json['durationMin']),
      caloriesBurned: serializer.fromJson<double>(json['caloriesBurned']),
      workoutType: serializer.fromJson<String>(json['workoutType']),
      rpe: serializer.fromJson<int?>(json['rpe']),
      routeJson: serializer.fromJson<String?>(json['routeJson']),
      distanceKm: serializer.fromJson<double?>(json['distanceKm']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
      'durationMin': serializer.toJson<int>(durationMin),
      'caloriesBurned': serializer.toJson<double>(caloriesBurned),
      'workoutType': serializer.toJson<String>(workoutType),
      'rpe': serializer.toJson<int?>(rpe),
      'routeJson': serializer.toJson<String?>(routeJson),
      'distanceKm': serializer.toJson<double?>(distanceKm),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  WorkoutLog copyWith({
    int? id,
    String? userId,
    String? title,
    int? durationMin,
    double? caloriesBurned,
    String? workoutType,
    Value<int?> rpe = const Value.absent(),
    Value<String?> routeJson = const Value.absent(),
    Value<double?> distanceKm = const Value.absent(),
    DateTime? loggedAt,
  }) => WorkoutLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
    durationMin: durationMin ?? this.durationMin,
    caloriesBurned: caloriesBurned ?? this.caloriesBurned,
    workoutType: workoutType ?? this.workoutType,
    rpe: rpe.present ? rpe.value : this.rpe,
    routeJson: routeJson.present ? routeJson.value : this.routeJson,
    distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  WorkoutLog copyWithCompanion(WorkoutLogsCompanion data) {
    return WorkoutLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      workoutType: data.workoutType.present
          ? data.workoutType.value
          : this.workoutType,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      routeJson: data.routeJson.present ? data.routeJson.value : this.routeJson,
      distanceKm: data.distanceKm.present
          ? data.distanceKm.value
          : this.distanceKm,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('durationMin: $durationMin, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('workoutType: $workoutType, ')
          ..write('rpe: $rpe, ')
          ..write('routeJson: $routeJson, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    title,
    durationMin,
    caloriesBurned,
    workoutType,
    rpe,
    routeJson,
    distanceKm,
    loggedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.durationMin == this.durationMin &&
          other.caloriesBurned == this.caloriesBurned &&
          other.workoutType == this.workoutType &&
          other.rpe == this.rpe &&
          other.routeJson == this.routeJson &&
          other.distanceKm == this.distanceKm &&
          other.loggedAt == this.loggedAt);
}

class WorkoutLogsCompanion extends UpdateCompanion<WorkoutLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> title;
  final Value<int> durationMin;
  final Value<double> caloriesBurned;
  final Value<String> workoutType;
  final Value<int?> rpe;
  final Value<String?> routeJson;
  final Value<double?> distanceKm;
  final Value<DateTime> loggedAt;
  const WorkoutLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.workoutType = const Value.absent(),
    this.rpe = const Value.absent(),
    this.routeJson = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  WorkoutLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String title,
    required int durationMin,
    required double caloriesBurned,
    required String workoutType,
    this.rpe = const Value.absent(),
    this.routeJson = const Value.absent(),
    this.distanceKm = const Value.absent(),
    required DateTime loggedAt,
  }) : userId = Value(userId),
       title = Value(title),
       durationMin = Value(durationMin),
       caloriesBurned = Value(caloriesBurned),
       workoutType = Value(workoutType),
       loggedAt = Value(loggedAt);
  static Insertable<WorkoutLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<int>? durationMin,
    Expression<double>? caloriesBurned,
    Expression<String>? workoutType,
    Expression<int>? rpe,
    Expression<String>? routeJson,
    Expression<double>? distanceKm,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (durationMin != null) 'duration_min': durationMin,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (workoutType != null) 'workout_type': workoutType,
      if (rpe != null) 'rpe': rpe,
      if (routeJson != null) 'route_json': routeJson,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  WorkoutLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? title,
    Value<int>? durationMin,
    Value<double>? caloriesBurned,
    Value<String>? workoutType,
    Value<int?>? rpe,
    Value<String?>? routeJson,
    Value<double?>? distanceKm,
    Value<DateTime>? loggedAt,
  }) {
    return WorkoutLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      durationMin: durationMin ?? this.durationMin,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      workoutType: workoutType ?? this.workoutType,
      rpe: rpe ?? this.rpe,
      routeJson: routeJson ?? this.routeJson,
      distanceKm: distanceKm ?? this.distanceKm,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<double>(caloriesBurned.value);
    }
    if (workoutType.present) {
      map['workout_type'] = Variable<String>(workoutType.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<int>(rpe.value);
    }
    if (routeJson.present) {
      map['route_json'] = Variable<String>(routeJson.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('durationMin: $durationMin, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('workoutType: $workoutType, ')
          ..write('rpe: $rpe, ')
          ..write('routeJson: $routeJson, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $StepLogsTable extends StepLogs with TableInfo<$StepLogsTable, StepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, steps, date];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $StepLogsTable createAlias(String alias) {
    return $StepLogsTable(attachedDatabase, alias);
  }
}

class StepLog extends DataClass implements Insertable<StepLog> {
  final int id;
  final String userId;
  final int steps;
  final DateTime date;
  const StepLog({
    required this.id,
    required this.userId,
    required this.steps,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['steps'] = Variable<int>(steps);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  StepLogsCompanion toCompanion(bool nullToAbsent) {
    return StepLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      steps: Value(steps),
      date: Value(date),
    );
  }

  factory StepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      steps: serializer.fromJson<int>(json['steps']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'steps': serializer.toJson<int>(steps),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  StepLog copyWith({int? id, String? userId, int? steps, DateTime? date}) =>
      StepLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        steps: steps ?? this.steps,
        date: date ?? this.date,
      );
  StepLog copyWithCompanion(StepLogsCompanion data) {
    return StepLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      steps: data.steps.present ? data.steps.value : this.steps,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('steps: $steps, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, steps, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.steps == this.steps &&
          other.date == this.date);
}

class StepLogsCompanion extends UpdateCompanion<StepLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> steps;
  final Value<DateTime> date;
  const StepLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.steps = const Value.absent(),
    this.date = const Value.absent(),
  });
  StepLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int steps,
    required DateTime date,
  }) : userId = Value(userId),
       steps = Value(steps),
       date = Value(date);
  static Insertable<StepLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? steps,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (steps != null) 'steps': steps,
      if (date != null) 'date': date,
    });
  }

  StepLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? steps,
    Value<DateTime>? date,
  }) {
    return StepLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      steps: steps ?? this.steps,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('steps: $steps, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinMeta = const VerificationMeta(
    'durationMin',
  );
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
    'duration_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    durationMin,
    quality,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
        _durationMinMeta,
        durationMin.isAcceptableOrUnknown(
          data['duration_min']!,
          _durationMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      durationMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_min'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final int id;
  final String userId;
  final int durationMin;
  final int? quality;
  final DateTime date;
  const SleepLog({
    required this.id,
    required this.userId,
    required this.durationMin,
    this.quality,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['duration_min'] = Variable<int>(durationMin);
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(quality);
    }
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      durationMin: Value(durationMin),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      date: Value(date),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      durationMin: serializer.fromJson<int>(json['durationMin']),
      quality: serializer.fromJson<int?>(json['quality']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'durationMin': serializer.toJson<int>(durationMin),
      'quality': serializer.toJson<int?>(quality),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  SleepLog copyWith({
    int? id,
    String? userId,
    int? durationMin,
    Value<int?> quality = const Value.absent(),
    DateTime? date,
  }) => SleepLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    durationMin: durationMin ?? this.durationMin,
    quality: quality.present ? quality.value : this.quality,
    date: date ?? this.date,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      durationMin: data.durationMin.present
          ? data.durationMin.value
          : this.durationMin,
      quality: data.quality.present ? data.quality.value : this.quality,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('durationMin: $durationMin, ')
          ..write('quality: $quality, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, durationMin, quality, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.durationMin == this.durationMin &&
          other.quality == this.quality &&
          other.date == this.date);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> durationMin;
  final Value<int?> quality;
  final Value<DateTime> date;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.quality = const Value.absent(),
    this.date = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int durationMin,
    this.quality = const Value.absent(),
    required DateTime date,
  }) : userId = Value(userId),
       durationMin = Value(durationMin),
       date = Value(date);
  static Insertable<SleepLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? durationMin,
    Expression<int>? quality,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (durationMin != null) 'duration_min': durationMin,
      if (quality != null) 'quality': quality,
      if (date != null) 'date': date,
    });
  }

  SleepLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? durationMin,
    Value<int?>? quality,
    Value<DateTime>? date,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      durationMin: durationMin ?? this.durationMin,
      quality: quality ?? this.quality,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('durationMin: $durationMin, ')
          ..write('quality: $quality, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $MoodLogsTable extends MoodLogs with TableInfo<$MoodLogsTable, MoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodScoreMeta = const VerificationMeta(
    'moodScore',
  );
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
    'mood_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _screenTimeMinMeta = const VerificationMeta(
    'screenTimeMin',
  );
  @override
  late final GeneratedColumn<int> screenTimeMin = GeneratedColumn<int>(
    'screen_time_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepQualityMeta = const VerificationMeta(
    'sleepQuality',
  );
  @override
  late final GeneratedColumn<int> sleepQuality = GeneratedColumn<int>(
    'sleep_quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    moodScore,
    screenTimeMin,
    sleepQuality,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mood_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoodLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('mood_score')) {
      context.handle(
        _moodScoreMeta,
        moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_moodScoreMeta);
    }
    if (data.containsKey('screen_time_min')) {
      context.handle(
        _screenTimeMinMeta,
        screenTimeMin.isAcceptableOrUnknown(
          data['screen_time_min']!,
          _screenTimeMinMeta,
        ),
      );
    }
    if (data.containsKey('sleep_quality')) {
      context.handle(
        _sleepQualityMeta,
        sleepQuality.isAcceptableOrUnknown(
          data['sleep_quality']!,
          _sleepQualityMeta,
        ),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      moodScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_score'],
      )!,
      screenTimeMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}screen_time_min'],
      ),
      sleepQuality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $MoodLogsTable createAlias(String alias) {
    return $MoodLogsTable(attachedDatabase, alias);
  }
}

class MoodLog extends DataClass implements Insertable<MoodLog> {
  final int id;
  final String userId;
  final int moodScore;
  final int? screenTimeMin;
  final int? sleepQuality;
  final DateTime loggedAt;
  const MoodLog({
    required this.id,
    required this.userId,
    required this.moodScore,
    this.screenTimeMin,
    this.sleepQuality,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['mood_score'] = Variable<int>(moodScore);
    if (!nullToAbsent || screenTimeMin != null) {
      map['screen_time_min'] = Variable<int>(screenTimeMin);
    }
    if (!nullToAbsent || sleepQuality != null) {
      map['sleep_quality'] = Variable<int>(sleepQuality);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  MoodLogsCompanion toCompanion(bool nullToAbsent) {
    return MoodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      moodScore: Value(moodScore),
      screenTimeMin: screenTimeMin == null && nullToAbsent
          ? const Value.absent()
          : Value(screenTimeMin),
      sleepQuality: sleepQuality == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQuality),
      loggedAt: Value(loggedAt),
    );
  }

  factory MoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      moodScore: serializer.fromJson<int>(json['moodScore']),
      screenTimeMin: serializer.fromJson<int?>(json['screenTimeMin']),
      sleepQuality: serializer.fromJson<int?>(json['sleepQuality']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'moodScore': serializer.toJson<int>(moodScore),
      'screenTimeMin': serializer.toJson<int?>(screenTimeMin),
      'sleepQuality': serializer.toJson<int?>(sleepQuality),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  MoodLog copyWith({
    int? id,
    String? userId,
    int? moodScore,
    Value<int?> screenTimeMin = const Value.absent(),
    Value<int?> sleepQuality = const Value.absent(),
    DateTime? loggedAt,
  }) => MoodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    moodScore: moodScore ?? this.moodScore,
    screenTimeMin: screenTimeMin.present
        ? screenTimeMin.value
        : this.screenTimeMin,
    sleepQuality: sleepQuality.present ? sleepQuality.value : this.sleepQuality,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  MoodLog copyWithCompanion(MoodLogsCompanion data) {
    return MoodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      screenTimeMin: data.screenTimeMin.present
          ? data.screenTimeMin.value
          : this.screenTimeMin,
      sleepQuality: data.sleepQuality.present
          ? data.sleepQuality.value
          : this.sleepQuality,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('moodScore: $moodScore, ')
          ..write('screenTimeMin: $screenTimeMin, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, moodScore, screenTimeMin, sleepQuality, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.moodScore == this.moodScore &&
          other.screenTimeMin == this.screenTimeMin &&
          other.sleepQuality == this.sleepQuality &&
          other.loggedAt == this.loggedAt);
}

class MoodLogsCompanion extends UpdateCompanion<MoodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> moodScore;
  final Value<int?> screenTimeMin;
  final Value<int?> sleepQuality;
  final Value<DateTime> loggedAt;
  const MoodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.screenTimeMin = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  MoodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int moodScore,
    this.screenTimeMin = const Value.absent(),
    this.sleepQuality = const Value.absent(),
    required DateTime loggedAt,
  }) : userId = Value(userId),
       moodScore = Value(moodScore),
       loggedAt = Value(loggedAt);
  static Insertable<MoodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? moodScore,
    Expression<int>? screenTimeMin,
    Expression<int>? sleepQuality,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (moodScore != null) 'mood_score': moodScore,
      if (screenTimeMin != null) 'screen_time_min': screenTimeMin,
      if (sleepQuality != null) 'sleep_quality': sleepQuality,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  MoodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? moodScore,
    Value<int?>? screenTimeMin,
    Value<int?>? sleepQuality,
    Value<DateTime>? loggedAt,
  }) {
    return MoodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      moodScore: moodScore ?? this.moodScore,
      screenTimeMin: screenTimeMin ?? this.screenTimeMin,
      sleepQuality: sleepQuality ?? this.sleepQuality,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (screenTimeMin.present) {
      map['screen_time_min'] = Variable<int>(screenTimeMin.value);
    }
    if (sleepQuality.present) {
      map['sleep_quality'] = Variable<int>(sleepQuality.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('moodScore: $moodScore, ')
          ..write('screenTimeMin: $screenTimeMin, ')
          ..write('sleepQuality: $sleepQuality, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $BloodPressureLogsTable extends BloodPressureLogs
    with TableInfo<$BloodPressureLogsTable, BloodPressureLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodPressureLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _systolicMeta = const VerificationMeta(
    'systolic',
  );
  @override
  late final GeneratedColumn<String> systolic = GeneratedColumn<String>(
    'systolic',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1024,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diastolicMeta = const VerificationMeta(
    'diastolic',
  );
  @override
  late final GeneratedColumn<String> diastolic = GeneratedColumn<String>(
    'diastolic',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1024,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  @override
  late final GeneratedColumn<int> pulse = GeneratedColumn<int>(
    'pulse',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEncryptedMeta = const VerificationMeta(
    'isEncrypted',
  );
  @override
  late final GeneratedColumn<bool> isEncrypted = GeneratedColumn<bool>(
    'is_encrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_encrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    systolic,
    diastolic,
    pulse,
    isEncrypted,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_pressure_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodPressureLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('systolic')) {
      context.handle(
        _systolicMeta,
        systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta),
      );
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(
        _diastolicMeta,
        diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta),
      );
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
        _pulseMeta,
        pulse.isAcceptableOrUnknown(data['pulse']!, _pulseMeta),
      );
    }
    if (data.containsKey('is_encrypted')) {
      context.handle(
        _isEncryptedMeta,
        isEncrypted.isAcceptableOrUnknown(
          data['is_encrypted']!,
          _isEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BloodPressureLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodPressureLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      systolic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}systolic'],
      )!,
      diastolic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}diastolic'],
      )!,
      pulse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulse'],
      ),
      isEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_encrypted'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $BloodPressureLogsTable createAlias(String alias) {
    return $BloodPressureLogsTable(attachedDatabase, alias);
  }
}

class BloodPressureLog extends DataClass
    implements Insertable<BloodPressureLog> {
  final int id;
  final String userId;
  final String systolic;
  final String diastolic;
  final int? pulse;
  final bool isEncrypted;
  final DateTime loggedAt;
  const BloodPressureLog({
    required this.id,
    required this.userId,
    required this.systolic,
    required this.diastolic,
    this.pulse,
    required this.isEncrypted,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['systolic'] = Variable<String>(systolic);
    map['diastolic'] = Variable<String>(diastolic);
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    map['is_encrypted'] = Variable<bool>(isEncrypted);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  BloodPressureLogsCompanion toCompanion(bool nullToAbsent) {
    return BloodPressureLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      systolic: Value(systolic),
      diastolic: Value(diastolic),
      pulse: pulse == null && nullToAbsent
          ? const Value.absent()
          : Value(pulse),
      isEncrypted: Value(isEncrypted),
      loggedAt: Value(loggedAt),
    );
  }

  factory BloodPressureLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodPressureLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      systolic: serializer.fromJson<String>(json['systolic']),
      diastolic: serializer.fromJson<String>(json['diastolic']),
      pulse: serializer.fromJson<int?>(json['pulse']),
      isEncrypted: serializer.fromJson<bool>(json['isEncrypted']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'systolic': serializer.toJson<String>(systolic),
      'diastolic': serializer.toJson<String>(diastolic),
      'pulse': serializer.toJson<int?>(pulse),
      'isEncrypted': serializer.toJson<bool>(isEncrypted),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  BloodPressureLog copyWith({
    int? id,
    String? userId,
    String? systolic,
    String? diastolic,
    Value<int?> pulse = const Value.absent(),
    bool? isEncrypted,
    DateTime? loggedAt,
  }) => BloodPressureLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    systolic: systolic ?? this.systolic,
    diastolic: diastolic ?? this.diastolic,
    pulse: pulse.present ? pulse.value : this.pulse,
    isEncrypted: isEncrypted ?? this.isEncrypted,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  BloodPressureLog copyWithCompanion(BloodPressureLogsCompanion data) {
    return BloodPressureLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      pulse: data.pulse.present ? data.pulse.value : this.pulse,
      isEncrypted: data.isEncrypted.present
          ? data.isEncrypted.value
          : this.isEncrypted,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    systolic,
    diastolic,
    pulse,
    isEncrypted,
    loggedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodPressureLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.pulse == this.pulse &&
          other.isEncrypted == this.isEncrypted &&
          other.loggedAt == this.loggedAt);
}

class BloodPressureLogsCompanion extends UpdateCompanion<BloodPressureLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> systolic;
  final Value<String> diastolic;
  final Value<int?> pulse;
  final Value<bool> isEncrypted;
  final Value<DateTime> loggedAt;
  const BloodPressureLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.pulse = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  BloodPressureLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String systolic,
    required String diastolic,
    this.pulse = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    required DateTime loggedAt,
  }) : userId = Value(userId),
       systolic = Value(systolic),
       diastolic = Value(diastolic),
       loggedAt = Value(loggedAt);
  static Insertable<BloodPressureLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? systolic,
    Expression<String>? diastolic,
    Expression<int>? pulse,
    Expression<bool>? isEncrypted,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (pulse != null) 'pulse': pulse,
      if (isEncrypted != null) 'is_encrypted': isEncrypted,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  BloodPressureLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? systolic,
    Value<String>? diastolic,
    Value<int?>? pulse,
    Value<bool>? isEncrypted,
    Value<DateTime>? loggedAt,
  }) {
    return BloodPressureLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (systolic.present) {
      map['systolic'] = Variable<String>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<String>(diastolic.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (isEncrypted.present) {
      map['is_encrypted'] = Variable<bool>(isEncrypted.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $GlucoseLogsTable extends GlucoseLogs
    with TableInfo<$GlucoseLogsTable, GlucoseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlucoseLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _glucoseMgdlMeta = const VerificationMeta(
    'glucoseMgdl',
  );
  @override
  late final GeneratedColumn<String> glucoseMgdl = GeneratedColumn<String>(
    'glucose_mgdl',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1024,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _foodLogIdMeta = const VerificationMeta(
    'foodLogId',
  );
  @override
  late final GeneratedColumn<int> foodLogId = GeneratedColumn<int>(
    'food_log_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isEncryptedMeta = const VerificationMeta(
    'isEncrypted',
  );
  @override
  late final GeneratedColumn<bool> isEncrypted = GeneratedColumn<bool>(
    'is_encrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_encrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    glucoseMgdl,
    mealType,
    foodLogId,
    isEncrypted,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'glucose_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlucoseLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('glucose_mgdl')) {
      context.handle(
        _glucoseMgdlMeta,
        glucoseMgdl.isAcceptableOrUnknown(
          data['glucose_mgdl']!,
          _glucoseMgdlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_glucoseMgdlMeta);
    }
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    }
    if (data.containsKey('food_log_id')) {
      context.handle(
        _foodLogIdMeta,
        foodLogId.isAcceptableOrUnknown(data['food_log_id']!, _foodLogIdMeta),
      );
    }
    if (data.containsKey('is_encrypted')) {
      context.handle(
        _isEncryptedMeta,
        isEncrypted.isAcceptableOrUnknown(
          data['is_encrypted']!,
          _isEncryptedMeta,
        ),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlucoseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlucoseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      glucoseMgdl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}glucose_mgdl'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      ),
      foodLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}food_log_id'],
      ),
      isEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_encrypted'],
      )!,
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $GlucoseLogsTable createAlias(String alias) {
    return $GlucoseLogsTable(attachedDatabase, alias);
  }
}

class GlucoseLog extends DataClass implements Insertable<GlucoseLog> {
  final int id;
  final String userId;
  final String glucoseMgdl;
  final String? mealType;
  final int? foodLogId;
  final bool isEncrypted;
  final DateTime loggedAt;
  const GlucoseLog({
    required this.id,
    required this.userId,
    required this.glucoseMgdl,
    this.mealType,
    this.foodLogId,
    required this.isEncrypted,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['glucose_mgdl'] = Variable<String>(glucoseMgdl);
    if (!nullToAbsent || mealType != null) {
      map['meal_type'] = Variable<String>(mealType);
    }
    if (!nullToAbsent || foodLogId != null) {
      map['food_log_id'] = Variable<int>(foodLogId);
    }
    map['is_encrypted'] = Variable<bool>(isEncrypted);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  GlucoseLogsCompanion toCompanion(bool nullToAbsent) {
    return GlucoseLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      glucoseMgdl: Value(glucoseMgdl),
      mealType: mealType == null && nullToAbsent
          ? const Value.absent()
          : Value(mealType),
      foodLogId: foodLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(foodLogId),
      isEncrypted: Value(isEncrypted),
      loggedAt: Value(loggedAt),
    );
  }

  factory GlucoseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlucoseLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      glucoseMgdl: serializer.fromJson<String>(json['glucoseMgdl']),
      mealType: serializer.fromJson<String?>(json['mealType']),
      foodLogId: serializer.fromJson<int?>(json['foodLogId']),
      isEncrypted: serializer.fromJson<bool>(json['isEncrypted']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'glucoseMgdl': serializer.toJson<String>(glucoseMgdl),
      'mealType': serializer.toJson<String?>(mealType),
      'foodLogId': serializer.toJson<int?>(foodLogId),
      'isEncrypted': serializer.toJson<bool>(isEncrypted),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  GlucoseLog copyWith({
    int? id,
    String? userId,
    String? glucoseMgdl,
    Value<String?> mealType = const Value.absent(),
    Value<int?> foodLogId = const Value.absent(),
    bool? isEncrypted,
    DateTime? loggedAt,
  }) => GlucoseLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    glucoseMgdl: glucoseMgdl ?? this.glucoseMgdl,
    mealType: mealType.present ? mealType.value : this.mealType,
    foodLogId: foodLogId.present ? foodLogId.value : this.foodLogId,
    isEncrypted: isEncrypted ?? this.isEncrypted,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  GlucoseLog copyWithCompanion(GlucoseLogsCompanion data) {
    return GlucoseLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      glucoseMgdl: data.glucoseMgdl.present
          ? data.glucoseMgdl.value
          : this.glucoseMgdl,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      foodLogId: data.foodLogId.present ? data.foodLogId.value : this.foodLogId,
      isEncrypted: data.isEncrypted.present
          ? data.isEncrypted.value
          : this.isEncrypted,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('glucoseMgdl: $glucoseMgdl, ')
          ..write('mealType: $mealType, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    glucoseMgdl,
    mealType,
    foodLogId,
    isEncrypted,
    loggedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlucoseLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.glucoseMgdl == this.glucoseMgdl &&
          other.mealType == this.mealType &&
          other.foodLogId == this.foodLogId &&
          other.isEncrypted == this.isEncrypted &&
          other.loggedAt == this.loggedAt);
}

class GlucoseLogsCompanion extends UpdateCompanion<GlucoseLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> glucoseMgdl;
  final Value<String?> mealType;
  final Value<int?> foodLogId;
  final Value<bool> isEncrypted;
  final Value<DateTime> loggedAt;
  const GlucoseLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.glucoseMgdl = const Value.absent(),
    this.mealType = const Value.absent(),
    this.foodLogId = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  GlucoseLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String glucoseMgdl,
    this.mealType = const Value.absent(),
    this.foodLogId = const Value.absent(),
    this.isEncrypted = const Value.absent(),
    required DateTime loggedAt,
  }) : userId = Value(userId),
       glucoseMgdl = Value(glucoseMgdl),
       loggedAt = Value(loggedAt);
  static Insertable<GlucoseLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? glucoseMgdl,
    Expression<String>? mealType,
    Expression<int>? foodLogId,
    Expression<bool>? isEncrypted,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (glucoseMgdl != null) 'glucose_mgdl': glucoseMgdl,
      if (mealType != null) 'meal_type': mealType,
      if (foodLogId != null) 'food_log_id': foodLogId,
      if (isEncrypted != null) 'is_encrypted': isEncrypted,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  GlucoseLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? glucoseMgdl,
    Value<String?>? mealType,
    Value<int?>? foodLogId,
    Value<bool>? isEncrypted,
    Value<DateTime>? loggedAt,
  }) {
    return GlucoseLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      glucoseMgdl: glucoseMgdl ?? this.glucoseMgdl,
      mealType: mealType ?? this.mealType,
      foodLogId: foodLogId ?? this.foodLogId,
      isEncrypted: isEncrypted ?? this.isEncrypted,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (glucoseMgdl.present) {
      map['glucose_mgdl'] = Variable<String>(glucoseMgdl.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (foodLogId.present) {
      map['food_log_id'] = Variable<int>(foodLogId.value);
    }
    if (isEncrypted.present) {
      map['is_encrypted'] = Variable<bool>(isEncrypted.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('glucoseMgdl: $glucoseMgdl, ')
          ..write('mealType: $mealType, ')
          ..write('foodLogId: $foodLogId, ')
          ..write('isEncrypted: $isEncrypted, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $Spo2LogsTable extends Spo2Logs with TableInfo<$Spo2LogsTable, Spo2Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Spo2LogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spo2PercentageMeta = const VerificationMeta(
    'spo2Percentage',
  );
  @override
  late final GeneratedColumn<String> spo2Percentage = GeneratedColumn<String>(
    'spo2_percentage',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1024,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  @override
  late final GeneratedColumn<int> pulse = GeneratedColumn<int>(
    'pulse',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    spo2Percentage,
    pulse,
    loggedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spo2_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Spo2Log> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('spo2_percentage')) {
      context.handle(
        _spo2PercentageMeta,
        spo2Percentage.isAcceptableOrUnknown(
          data['spo2_percentage']!,
          _spo2PercentageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spo2PercentageMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
        _pulseMeta,
        pulse.isAcceptableOrUnknown(data['pulse']!, _pulseMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spo2Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spo2Log(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      spo2Percentage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spo2_percentage'],
      )!,
      pulse: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pulse'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
    );
  }

  @override
  $Spo2LogsTable createAlias(String alias) {
    return $Spo2LogsTable(attachedDatabase, alias);
  }
}

class Spo2Log extends DataClass implements Insertable<Spo2Log> {
  final int id;
  final String userId;
  final String spo2Percentage;
  final int? pulse;
  final DateTime loggedAt;
  const Spo2Log({
    required this.id,
    required this.userId,
    required this.spo2Percentage,
    this.pulse,
    required this.loggedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['spo2_percentage'] = Variable<String>(spo2Percentage);
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    return map;
  }

  Spo2LogsCompanion toCompanion(bool nullToAbsent) {
    return Spo2LogsCompanion(
      id: Value(id),
      userId: Value(userId),
      spo2Percentage: Value(spo2Percentage),
      pulse: pulse == null && nullToAbsent
          ? const Value.absent()
          : Value(pulse),
      loggedAt: Value(loggedAt),
    );
  }

  factory Spo2Log.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spo2Log(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      spo2Percentage: serializer.fromJson<String>(json['spo2Percentage']),
      pulse: serializer.fromJson<int?>(json['pulse']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'spo2Percentage': serializer.toJson<String>(spo2Percentage),
      'pulse': serializer.toJson<int?>(pulse),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
    };
  }

  Spo2Log copyWith({
    int? id,
    String? userId,
    String? spo2Percentage,
    Value<int?> pulse = const Value.absent(),
    DateTime? loggedAt,
  }) => Spo2Log(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    spo2Percentage: spo2Percentage ?? this.spo2Percentage,
    pulse: pulse.present ? pulse.value : this.pulse,
    loggedAt: loggedAt ?? this.loggedAt,
  );
  Spo2Log copyWithCompanion(Spo2LogsCompanion data) {
    return Spo2Log(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      spo2Percentage: data.spo2Percentage.present
          ? data.spo2Percentage.value
          : this.spo2Percentage,
      pulse: data.pulse.present ? data.pulse.value : this.pulse,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spo2Log(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('pulse: $pulse, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, spo2Percentage, pulse, loggedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spo2Log &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.spo2Percentage == this.spo2Percentage &&
          other.pulse == this.pulse &&
          other.loggedAt == this.loggedAt);
}

class Spo2LogsCompanion extends UpdateCompanion<Spo2Log> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> spo2Percentage;
  final Value<int?> pulse;
  final Value<DateTime> loggedAt;
  const Spo2LogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.spo2Percentage = const Value.absent(),
    this.pulse = const Value.absent(),
    this.loggedAt = const Value.absent(),
  });
  Spo2LogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String spo2Percentage,
    this.pulse = const Value.absent(),
    required DateTime loggedAt,
  }) : userId = Value(userId),
       spo2Percentage = Value(spo2Percentage),
       loggedAt = Value(loggedAt);
  static Insertable<Spo2Log> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? spo2Percentage,
    Expression<int>? pulse,
    Expression<DateTime>? loggedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (spo2Percentage != null) 'spo2_percentage': spo2Percentage,
      if (pulse != null) 'pulse': pulse,
      if (loggedAt != null) 'logged_at': loggedAt,
    });
  }

  Spo2LogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? spo2Percentage,
    Value<int?>? pulse,
    Value<DateTime>? loggedAt,
  }) {
    return Spo2LogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      spo2Percentage: spo2Percentage ?? this.spo2Percentage,
      pulse: pulse ?? this.pulse,
      loggedAt: loggedAt ?? this.loggedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (spo2Percentage.present) {
      map['spo2_percentage'] = Variable<String>(spo2Percentage.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Spo2LogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('pulse: $pulse, ')
          ..write('loggedAt: $loggedAt')
          ..write(')'))
        .toString();
  }
}

class $PeriodLogsTable extends PeriodLogs
    with TableInfo<$PeriodLogsTable, PeriodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPeriodDayMeta = const VerificationMeta(
    'isPeriodDay',
  );
  @override
  late final GeneratedColumn<bool> isPeriodDay = GeneratedColumn<bool>(
    'is_period_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_period_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _flowIntensityMeta = const VerificationMeta(
    'flowIntensity',
  );
  @override
  late final GeneratedColumn<String> flowIntensity = GeneratedColumn<String>(
    'flow_intensity',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1024),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
    'symptoms',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 2048),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPcodPcosMeta = const VerificationMeta(
    'isPcodPcos',
  );
  @override
  late final GeneratedColumn<bool> isPcodPcos = GeneratedColumn<bool>(
    'is_pcod_pcos',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_pcod_pcos" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    date,
    isPeriodDay,
    flowIntensity,
    symptoms,
    isPcodPcos,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'period_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeriodLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('is_period_day')) {
      context.handle(
        _isPeriodDayMeta,
        isPeriodDay.isAcceptableOrUnknown(
          data['is_period_day']!,
          _isPeriodDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isPeriodDayMeta);
    }
    if (data.containsKey('flow_intensity')) {
      context.handle(
        _flowIntensityMeta,
        flowIntensity.isAcceptableOrUnknown(
          data['flow_intensity']!,
          _flowIntensityMeta,
        ),
      );
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    }
    if (data.containsKey('is_pcod_pcos')) {
      context.handle(
        _isPcodPcosMeta,
        isPcodPcos.isAcceptableOrUnknown(
          data['is_pcod_pcos']!,
          _isPcodPcosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isPcodPcosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PeriodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      isPeriodDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_period_day'],
      )!,
      flowIntensity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}flow_intensity'],
      ),
      symptoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms'],
      ),
      isPcodPcos: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_pcod_pcos'],
      )!,
    );
  }

  @override
  $PeriodLogsTable createAlias(String alias) {
    return $PeriodLogsTable(attachedDatabase, alias);
  }
}

class PeriodLog extends DataClass implements Insertable<PeriodLog> {
  final int id;
  final String userId;
  final DateTime date;
  final bool isPeriodDay;
  final String? flowIntensity;
  final String? symptoms;
  final bool isPcodPcos;
  const PeriodLog({
    required this.id,
    required this.userId,
    required this.date,
    required this.isPeriodDay,
    this.flowIntensity,
    this.symptoms,
    required this.isPcodPcos,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['is_period_day'] = Variable<bool>(isPeriodDay);
    if (!nullToAbsent || flowIntensity != null) {
      map['flow_intensity'] = Variable<String>(flowIntensity);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    map['is_pcod_pcos'] = Variable<bool>(isPcodPcos);
    return map;
  }

  PeriodLogsCompanion toCompanion(bool nullToAbsent) {
    return PeriodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      isPeriodDay: Value(isPeriodDay),
      flowIntensity: flowIntensity == null && nullToAbsent
          ? const Value.absent()
          : Value(flowIntensity),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      isPcodPcos: Value(isPcodPcos),
    );
  }

  factory PeriodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      isPeriodDay: serializer.fromJson<bool>(json['isPeriodDay']),
      flowIntensity: serializer.fromJson<String?>(json['flowIntensity']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      isPcodPcos: serializer.fromJson<bool>(json['isPcodPcos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'isPeriodDay': serializer.toJson<bool>(isPeriodDay),
      'flowIntensity': serializer.toJson<String?>(flowIntensity),
      'symptoms': serializer.toJson<String?>(symptoms),
      'isPcodPcos': serializer.toJson<bool>(isPcodPcos),
    };
  }

  PeriodLog copyWith({
    int? id,
    String? userId,
    DateTime? date,
    bool? isPeriodDay,
    Value<String?> flowIntensity = const Value.absent(),
    Value<String?> symptoms = const Value.absent(),
    bool? isPcodPcos,
  }) => PeriodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    isPeriodDay: isPeriodDay ?? this.isPeriodDay,
    flowIntensity: flowIntensity.present
        ? flowIntensity.value
        : this.flowIntensity,
    symptoms: symptoms.present ? symptoms.value : this.symptoms,
    isPcodPcos: isPcodPcos ?? this.isPcodPcos,
  );
  PeriodLog copyWithCompanion(PeriodLogsCompanion data) {
    return PeriodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      isPeriodDay: data.isPeriodDay.present
          ? data.isPeriodDay.value
          : this.isPeriodDay,
      flowIntensity: data.flowIntensity.present
          ? data.flowIntensity.value
          : this.flowIntensity,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      isPcodPcos: data.isPcodPcos.present
          ? data.isPcodPcos.value
          : this.isPcodPcos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('isPeriodDay: $isPeriodDay, ')
          ..write('flowIntensity: $flowIntensity, ')
          ..write('symptoms: $symptoms, ')
          ..write('isPcodPcos: $isPcodPcos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    date,
    isPeriodDay,
    flowIntensity,
    symptoms,
    isPcodPcos,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.isPeriodDay == this.isPeriodDay &&
          other.flowIntensity == this.flowIntensity &&
          other.symptoms == this.symptoms &&
          other.isPcodPcos == this.isPcodPcos);
}

class PeriodLogsCompanion extends UpdateCompanion<PeriodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<bool> isPeriodDay;
  final Value<String?> flowIntensity;
  final Value<String?> symptoms;
  final Value<bool> isPcodPcos;
  const PeriodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.isPeriodDay = const Value.absent(),
    this.flowIntensity = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.isPcodPcos = const Value.absent(),
  });
  PeriodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime date,
    required bool isPeriodDay,
    this.flowIntensity = const Value.absent(),
    this.symptoms = const Value.absent(),
    required bool isPcodPcos,
  }) : userId = Value(userId),
       date = Value(date),
       isPeriodDay = Value(isPeriodDay),
       isPcodPcos = Value(isPcodPcos);
  static Insertable<PeriodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<bool>? isPeriodDay,
    Expression<String>? flowIntensity,
    Expression<String>? symptoms,
    Expression<bool>? isPcodPcos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (isPeriodDay != null) 'is_period_day': isPeriodDay,
      if (flowIntensity != null) 'flow_intensity': flowIntensity,
      if (symptoms != null) 'symptoms': symptoms,
      if (isPcodPcos != null) 'is_pcod_pcos': isPcodPcos,
    });
  }

  PeriodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? date,
    Value<bool>? isPeriodDay,
    Value<String?>? flowIntensity,
    Value<String?>? symptoms,
    Value<bool>? isPcodPcos,
  }) {
    return PeriodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      isPeriodDay: isPeriodDay ?? this.isPeriodDay,
      flowIntensity: flowIntensity ?? this.flowIntensity,
      symptoms: symptoms ?? this.symptoms,
      isPcodPcos: isPcodPcos ?? this.isPcodPcos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (isPeriodDay.present) {
      map['is_period_day'] = Variable<bool>(isPeriodDay.value);
    }
    if (flowIntensity.present) {
      map['flow_intensity'] = Variable<String>(flowIntensity.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (isPcodPcos.present) {
      map['is_pcod_pcos'] = Variable<bool>(isPcodPcos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PeriodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('isPeriodDay: $isPeriodDay, ')
          ..write('flowIntensity: $flowIntensity, ')
          ..write('symptoms: $symptoms, ')
          ..write('isPcodPcos: $isPcodPcos')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, isActive, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String userId;
  final String name;
  final bool isActive;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.userId,
    required this.name,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    int? id,
    String? userId,
    String? name,
    bool? isActive,
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, isActive, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
  }) : userId = Value(userId),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HabitCompletionsTable extends HabitCompletions
    with TableInfo<$HabitCompletionsTable, HabitCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCompletionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, habitId, userId, completedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCompletion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
    );
  }

  @override
  $HabitCompletionsTable createAlias(String alias) {
    return $HabitCompletionsTable(attachedDatabase, alias);
  }
}

class HabitCompletion extends DataClass implements Insertable<HabitCompletion> {
  final int id;
  final int habitId;
  final String userId;
  final DateTime completedAt;
  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['user_id'] = Variable<String>(userId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    return map;
  }

  HabitCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HabitCompletionsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      userId: Value(userId),
      completedAt: Value(completedAt),
    );
  }

  factory HabitCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCompletion(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      userId: serializer.fromJson<String>(json['userId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'userId': serializer.toJson<String>(userId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
    };
  }

  HabitCompletion copyWith({
    int? id,
    int? habitId,
    String? userId,
    DateTime? completedAt,
  }) => HabitCompletion(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    userId: userId ?? this.userId,
    completedAt: completedAt ?? this.completedAt,
  );
  HabitCompletion copyWithCompanion(HabitCompletionsCompanion data) {
    return HabitCompletion(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      userId: data.userId.present ? data.userId.value : this.userId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('userId: $userId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, userId, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCompletion &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.userId == this.userId &&
          other.completedAt == this.completedAt);
}

class HabitCompletionsCompanion extends UpdateCompanion<HabitCompletion> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> userId;
  final Value<DateTime> completedAt;
  const HabitCompletionsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.userId = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  HabitCompletionsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required String userId,
    required DateTime completedAt,
  }) : habitId = Value(habitId),
       userId = Value(userId),
       completedAt = Value(completedAt);
  static Insertable<HabitCompletion> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? userId,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (userId != null) 'user_id': userId,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  HabitCompletionsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<String>? userId,
    Value<DateTime>? completedAt,
  }) {
    return HabitCompletionsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('userId: $userId, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $BodyMeasurementsTable extends BodyMeasurements
    with TableInfo<$BodyMeasurementsTable, BodyMeasurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMeasurementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
    'measured_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, weightKg, measuredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyMeasurement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BodyMeasurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMeasurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      measuredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at'],
      )!,
    );
  }

  @override
  $BodyMeasurementsTable createAlias(String alias) {
    return $BodyMeasurementsTable(attachedDatabase, alias);
  }
}

class BodyMeasurement extends DataClass implements Insertable<BodyMeasurement> {
  final int id;
  final String userId;
  final double? weightKg;
  final DateTime measuredAt;
  const BodyMeasurement({
    required this.id,
    required this.userId,
    this.weightKg,
    required this.measuredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    map['measured_at'] = Variable<DateTime>(measuredAt);
    return map;
  }

  BodyMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BodyMeasurementsCompanion(
      id: Value(id),
      userId: Value(userId),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      measuredAt: Value(measuredAt),
    );
  }

  factory BodyMeasurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMeasurement(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'weightKg': serializer.toJson<double?>(weightKg),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
    };
  }

  BodyMeasurement copyWith({
    int? id,
    String? userId,
    Value<double?> weightKg = const Value.absent(),
    DateTime? measuredAt,
  }) => BodyMeasurement(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    measuredAt: measuredAt ?? this.measuredAt,
  );
  BodyMeasurement copyWithCompanion(BodyMeasurementsCompanion data) {
    return BodyMeasurement(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      measuredAt: data.measuredAt.present
          ? data.measuredAt.value
          : this.measuredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurement(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('measuredAt: $measuredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, weightKg, measuredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMeasurement &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weightKg == this.weightKg &&
          other.measuredAt == this.measuredAt);
}

class BodyMeasurementsCompanion extends UpdateCompanion<BodyMeasurement> {
  final Value<int> id;
  final Value<String> userId;
  final Value<double?> weightKg;
  final Value<DateTime> measuredAt;
  const BodyMeasurementsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.measuredAt = const Value.absent(),
  });
  BodyMeasurementsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.weightKg = const Value.absent(),
    required DateTime measuredAt,
  }) : userId = Value(userId),
       measuredAt = Value(measuredAt);
  static Insertable<BodyMeasurement> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<double>? weightKg,
    Expression<DateTime>? measuredAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weightKg != null) 'weight_kg': weightKg,
      if (measuredAt != null) 'measured_at': measuredAt,
    });
  }

  BodyMeasurementsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<double?>? weightKg,
    Value<DateTime>? measuredAt,
  }) {
    return BodyMeasurementsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weightKg: weightKg ?? this.weightKg,
      measuredAt: measuredAt ?? this.measuredAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('measuredAt: $measuredAt')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, name, isActive];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Medication> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    } else if (isInserting) {
      context.missing(_isActiveMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final int id;
  final String userId;
  final String name;
  final bool isActive;
  const Medication({
    required this.id,
    required this.userId,
    required this.name,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      isActive: Value(isActive),
    );
  }

  factory Medication.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Medication copyWith({
    int? id,
    String? userId,
    String? name,
    bool? isActive,
  }) => Medication(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
  );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.isActive == this.isActive);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<bool> isActive;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
  });
  MedicationsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    required bool isActive,
  }) : userId = Value(userId),
       name = Value(name),
       isActive = Value(isActive);
  static Insertable<Medication> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<bool>? isActive,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
    });
  }

  MedicationsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<bool>? isActive,
  }) {
    return MedicationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }
}

class $FastingLogsTable extends FastingLogs
    with TableInfo<$FastingLogsTable, FastingLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FastingLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fastStartMeta = const VerificationMeta(
    'fastStart',
  );
  @override
  late final GeneratedColumn<DateTime> fastStart = GeneratedColumn<DateTime>(
    'fast_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _fastEndMeta = const VerificationMeta(
    'fastEnd',
  );
  @override
  late final GeneratedColumn<DateTime> fastEnd = GeneratedColumn<DateTime>(
    'fast_end',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    fastStart,
    completed,
    fastEnd,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fasting_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FastingLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('fast_start')) {
      context.handle(
        _fastStartMeta,
        fastStart.isAcceptableOrUnknown(data['fast_start']!, _fastStartMeta),
      );
    } else if (isInserting) {
      context.missing(_fastStartMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('fast_end')) {
      context.handle(
        _fastEndMeta,
        fastEnd.isAcceptableOrUnknown(data['fast_end']!, _fastEndMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FastingLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FastingLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      fastStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fast_start'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      ),
      fastEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fast_end'],
      ),
    );
  }

  @override
  $FastingLogsTable createAlias(String alias) {
    return $FastingLogsTable(attachedDatabase, alias);
  }
}

class FastingLog extends DataClass implements Insertable<FastingLog> {
  final int id;
  final String userId;
  final DateTime fastStart;
  final bool? completed;
  final DateTime? fastEnd;
  const FastingLog({
    required this.id,
    required this.userId,
    required this.fastStart,
    this.completed,
    this.fastEnd,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['fast_start'] = Variable<DateTime>(fastStart);
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<bool>(completed);
    }
    if (!nullToAbsent || fastEnd != null) {
      map['fast_end'] = Variable<DateTime>(fastEnd);
    }
    return map;
  }

  FastingLogsCompanion toCompanion(bool nullToAbsent) {
    return FastingLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      fastStart: Value(fastStart),
      completed: completed == null && nullToAbsent
          ? const Value.absent()
          : Value(completed),
      fastEnd: fastEnd == null && nullToAbsent
          ? const Value.absent()
          : Value(fastEnd),
    );
  }

  factory FastingLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FastingLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fastStart: serializer.fromJson<DateTime>(json['fastStart']),
      completed: serializer.fromJson<bool?>(json['completed']),
      fastEnd: serializer.fromJson<DateTime?>(json['fastEnd']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'fastStart': serializer.toJson<DateTime>(fastStart),
      'completed': serializer.toJson<bool?>(completed),
      'fastEnd': serializer.toJson<DateTime?>(fastEnd),
    };
  }

  FastingLog copyWith({
    int? id,
    String? userId,
    DateTime? fastStart,
    Value<bool?> completed = const Value.absent(),
    Value<DateTime?> fastEnd = const Value.absent(),
  }) => FastingLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fastStart: fastStart ?? this.fastStart,
    completed: completed.present ? completed.value : this.completed,
    fastEnd: fastEnd.present ? fastEnd.value : this.fastEnd,
  );
  FastingLog copyWithCompanion(FastingLogsCompanion data) {
    return FastingLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fastStart: data.fastStart.present ? data.fastStart.value : this.fastStart,
      completed: data.completed.present ? data.completed.value : this.completed,
      fastEnd: data.fastEnd.present ? data.fastEnd.value : this.fastEnd,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FastingLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fastStart: $fastStart, ')
          ..write('completed: $completed, ')
          ..write('fastEnd: $fastEnd')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, fastStart, completed, fastEnd);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FastingLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fastStart == this.fastStart &&
          other.completed == this.completed &&
          other.fastEnd == this.fastEnd);
}

class FastingLogsCompanion extends UpdateCompanion<FastingLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> fastStart;
  final Value<bool?> completed;
  final Value<DateTime?> fastEnd;
  const FastingLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fastStart = const Value.absent(),
    this.completed = const Value.absent(),
    this.fastEnd = const Value.absent(),
  });
  FastingLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime fastStart,
    this.completed = const Value.absent(),
    this.fastEnd = const Value.absent(),
  }) : userId = Value(userId),
       fastStart = Value(fastStart);
  static Insertable<FastingLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? fastStart,
    Expression<bool>? completed,
    Expression<DateTime>? fastEnd,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fastStart != null) 'fast_start': fastStart,
      if (completed != null) 'completed': completed,
      if (fastEnd != null) 'fast_end': fastEnd,
    });
  }

  FastingLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? fastStart,
    Value<bool?>? completed,
    Value<DateTime?>? fastEnd,
  }) {
    return FastingLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fastStart: fastStart ?? this.fastStart,
      completed: completed ?? this.completed,
      fastEnd: fastEnd ?? this.fastEnd,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fastStart.present) {
      map['fast_start'] = Variable<DateTime>(fastStart.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (fastEnd.present) {
      map['fast_end'] = Variable<DateTime>(fastEnd.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FastingLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fastStart: $fastStart, ')
          ..write('completed: $completed, ')
          ..write('fastEnd: $fastEnd')
          ..write(')'))
        .toString();
  }
}

class $MealPlansTable extends MealPlans
    with TableInfo<$MealPlansTable, MealPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekStartDateMeta = const VerificationMeta(
    'weekStartDate',
  );
  @override
  late final GeneratedColumn<DateTime> weekStartDate =
      GeneratedColumn<DateTime>(
        'week_start_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, userId, weekStartDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlan> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('week_start_date')) {
      context.handle(
        _weekStartDateMeta,
        weekStartDate.isAcceptableOrUnknown(
          data['week_start_date']!,
          _weekStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekStartDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      weekStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}week_start_date'],
      )!,
    );
  }

  @override
  $MealPlansTable createAlias(String alias) {
    return $MealPlansTable(attachedDatabase, alias);
  }
}

class MealPlan extends DataClass implements Insertable<MealPlan> {
  final int id;
  final String userId;
  final DateTime weekStartDate;
  const MealPlan({
    required this.id,
    required this.userId,
    required this.weekStartDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['week_start_date'] = Variable<DateTime>(weekStartDate);
    return map;
  }

  MealPlansCompanion toCompanion(bool nullToAbsent) {
    return MealPlansCompanion(
      id: Value(id),
      userId: Value(userId),
      weekStartDate: Value(weekStartDate),
    );
  }

  factory MealPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlan(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      weekStartDate: serializer.fromJson<DateTime>(json['weekStartDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'weekStartDate': serializer.toJson<DateTime>(weekStartDate),
    };
  }

  MealPlan copyWith({int? id, String? userId, DateTime? weekStartDate}) =>
      MealPlan(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        weekStartDate: weekStartDate ?? this.weekStartDate,
      );
  MealPlan copyWithCompanion(MealPlansCompanion data) {
    return MealPlan(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weekStartDate: data.weekStartDate.present
          ? data.weekStartDate.value
          : this.weekStartDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlan(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weekStartDate: $weekStartDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, weekStartDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlan &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weekStartDate == this.weekStartDate);
}

class MealPlansCompanion extends UpdateCompanion<MealPlan> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> weekStartDate;
  const MealPlansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weekStartDate = const Value.absent(),
  });
  MealPlansCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime weekStartDate,
  }) : userId = Value(userId),
       weekStartDate = Value(weekStartDate);
  static Insertable<MealPlan> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? weekStartDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weekStartDate != null) 'week_start_date': weekStartDate,
    });
  }

  MealPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? weekStartDate,
  }) {
    return MealPlansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weekStartDate: weekStartDate ?? this.weekStartDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (weekStartDate.present) {
      map['week_start_date'] = Variable<DateTime>(weekStartDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealPlansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weekStartDate: $weekStartDate')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, title];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String userId;
  final String title;
  const Recipe({required this.id, required this.userId, required this.title});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['title'] = Variable<String>(title);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      userId: Value(userId),
      title: Value(title),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String>(title),
    };
  }

  Recipe copyWith({int? id, String? userId, String? title}) => Recipe(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title ?? this.title,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> title;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String title,
  }) : userId = Value(userId),
       title = Value(title);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? title,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10240,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, content, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final String userId;
  final String content;
  final DateTime createdAt;
  const JournalEntry({
    required this.id,
    required this.userId,
    required this.content,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['content'] = Variable<String>(content);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      content: Value(content),
      createdAt: Value(createdAt),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  JournalEntry copyWith({
    int? id,
    String? userId,
    String? content,
    DateTime? createdAt,
  }) => JournalEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    content: content ?? this.content,
    createdAt: createdAt ?? this.createdAt,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      content: data.content.present ? data.content.value : this.content,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, content, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.content == this.content &&
          other.createdAt == this.createdAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> content;
  final Value<DateTime> createdAt;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String content,
    required DateTime createdAt,
  }) : userId = Value(userId),
       content = Value(content),
       createdAt = Value(createdAt);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? content,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (content != null) 'content': content,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? content,
    Value<DateTime>? createdAt,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $DoctorAppointmentsTable extends DoctorAppointments
    with TableInfo<$DoctorAppointmentsTable, DoctorAppointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorAppointmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _appointmentDateMeta = const VerificationMeta(
    'appointmentDate',
  );
  @override
  late final GeneratedColumn<DateTime> appointmentDate =
      GeneratedColumn<DateTime>(
        'appointment_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prescriptionPhotoPathMeta =
      const VerificationMeta('prescriptionPhotoPath');
  @override
  late final GeneratedColumn<String> prescriptionPhotoPath =
      GeneratedColumn<String>(
        'prescription_photo_path',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _extractedMedsJsonMeta = const VerificationMeta(
    'extractedMedsJson',
  );
  @override
  late final GeneratedColumn<String> extractedMedsJson =
      GeneratedColumn<String>(
        'extracted_meds_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _reminderSentMeta = const VerificationMeta(
    'reminderSent',
  );
  @override
  late final GeneratedColumn<bool> reminderSent = GeneratedColumn<bool>(
    'reminder_sent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_sent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    appointmentDate,
    doctorName,
    notes,
    prescriptionPhotoPath,
    extractedMedsJson,
    reminderSent,
    isCompleted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctor_appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoctorAppointment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('appointment_date')) {
      context.handle(
        _appointmentDateMeta,
        appointmentDate.isAcceptableOrUnknown(
          data['appointment_date']!,
          _appointmentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentDateMeta);
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorNameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('prescription_photo_path')) {
      context.handle(
        _prescriptionPhotoPathMeta,
        prescriptionPhotoPath.isAcceptableOrUnknown(
          data['prescription_photo_path']!,
          _prescriptionPhotoPathMeta,
        ),
      );
    }
    if (data.containsKey('extracted_meds_json')) {
      context.handle(
        _extractedMedsJsonMeta,
        extractedMedsJson.isAcceptableOrUnknown(
          data['extracted_meds_json']!,
          _extractedMedsJsonMeta,
        ),
      );
    }
    if (data.containsKey('reminder_sent')) {
      context.handle(
        _reminderSentMeta,
        reminderSent.isAcceptableOrUnknown(
          data['reminder_sent']!,
          _reminderSentMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DoctorAppointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorAppointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      appointmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}appointment_date'],
      )!,
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      prescriptionPhotoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}prescription_photo_path'],
      ),
      extractedMedsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extracted_meds_json'],
      ),
      reminderSent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_sent'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
    );
  }

  @override
  $DoctorAppointmentsTable createAlias(String alias) {
    return $DoctorAppointmentsTable(attachedDatabase, alias);
  }
}

class DoctorAppointment extends DataClass
    implements Insertable<DoctorAppointment> {
  final int id;
  final String userId;
  final DateTime appointmentDate;
  final String doctorName;
  final String? notes;
  final String? prescriptionPhotoPath;
  final String? extractedMedsJson;
  final bool reminderSent;
  final bool isCompleted;
  const DoctorAppointment({
    required this.id,
    required this.userId,
    required this.appointmentDate,
    required this.doctorName,
    this.notes,
    this.prescriptionPhotoPath,
    this.extractedMedsJson,
    required this.reminderSent,
    required this.isCompleted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['appointment_date'] = Variable<DateTime>(appointmentDate);
    map['doctor_name'] = Variable<String>(doctorName);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || prescriptionPhotoPath != null) {
      map['prescription_photo_path'] = Variable<String>(prescriptionPhotoPath);
    }
    if (!nullToAbsent || extractedMedsJson != null) {
      map['extracted_meds_json'] = Variable<String>(extractedMedsJson);
    }
    map['reminder_sent'] = Variable<bool>(reminderSent);
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  DoctorAppointmentsCompanion toCompanion(bool nullToAbsent) {
    return DoctorAppointmentsCompanion(
      id: Value(id),
      userId: Value(userId),
      appointmentDate: Value(appointmentDate),
      doctorName: Value(doctorName),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      prescriptionPhotoPath: prescriptionPhotoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(prescriptionPhotoPath),
      extractedMedsJson: extractedMedsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(extractedMedsJson),
      reminderSent: Value(reminderSent),
      isCompleted: Value(isCompleted),
    );
  }

  factory DoctorAppointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorAppointment(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      appointmentDate: serializer.fromJson<DateTime>(json['appointmentDate']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      notes: serializer.fromJson<String?>(json['notes']),
      prescriptionPhotoPath: serializer.fromJson<String?>(
        json['prescriptionPhotoPath'],
      ),
      extractedMedsJson: serializer.fromJson<String?>(
        json['extractedMedsJson'],
      ),
      reminderSent: serializer.fromJson<bool>(json['reminderSent']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'appointmentDate': serializer.toJson<DateTime>(appointmentDate),
      'doctorName': serializer.toJson<String>(doctorName),
      'notes': serializer.toJson<String?>(notes),
      'prescriptionPhotoPath': serializer.toJson<String?>(
        prescriptionPhotoPath,
      ),
      'extractedMedsJson': serializer.toJson<String?>(extractedMedsJson),
      'reminderSent': serializer.toJson<bool>(reminderSent),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  DoctorAppointment copyWith({
    int? id,
    String? userId,
    DateTime? appointmentDate,
    String? doctorName,
    Value<String?> notes = const Value.absent(),
    Value<String?> prescriptionPhotoPath = const Value.absent(),
    Value<String?> extractedMedsJson = const Value.absent(),
    bool? reminderSent,
    bool? isCompleted,
  }) => DoctorAppointment(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    appointmentDate: appointmentDate ?? this.appointmentDate,
    doctorName: doctorName ?? this.doctorName,
    notes: notes.present ? notes.value : this.notes,
    prescriptionPhotoPath: prescriptionPhotoPath.present
        ? prescriptionPhotoPath.value
        : this.prescriptionPhotoPath,
    extractedMedsJson: extractedMedsJson.present
        ? extractedMedsJson.value
        : this.extractedMedsJson,
    reminderSent: reminderSent ?? this.reminderSent,
    isCompleted: isCompleted ?? this.isCompleted,
  );
  DoctorAppointment copyWithCompanion(DoctorAppointmentsCompanion data) {
    return DoctorAppointment(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      appointmentDate: data.appointmentDate.present
          ? data.appointmentDate.value
          : this.appointmentDate,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      notes: data.notes.present ? data.notes.value : this.notes,
      prescriptionPhotoPath: data.prescriptionPhotoPath.present
          ? data.prescriptionPhotoPath.value
          : this.prescriptionPhotoPath,
      extractedMedsJson: data.extractedMedsJson.present
          ? data.extractedMedsJson.value
          : this.extractedMedsJson,
      reminderSent: data.reminderSent.present
          ? data.reminderSent.value
          : this.reminderSent,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoctorAppointment(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('doctorName: $doctorName, ')
          ..write('notes: $notes, ')
          ..write('prescriptionPhotoPath: $prescriptionPhotoPath, ')
          ..write('extractedMedsJson: $extractedMedsJson, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    appointmentDate,
    doctorName,
    notes,
    prescriptionPhotoPath,
    extractedMedsJson,
    reminderSent,
    isCompleted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorAppointment &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.appointmentDate == this.appointmentDate &&
          other.doctorName == this.doctorName &&
          other.notes == this.notes &&
          other.prescriptionPhotoPath == this.prescriptionPhotoPath &&
          other.extractedMedsJson == this.extractedMedsJson &&
          other.reminderSent == this.reminderSent &&
          other.isCompleted == this.isCompleted);
}

class DoctorAppointmentsCompanion extends UpdateCompanion<DoctorAppointment> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> appointmentDate;
  final Value<String> doctorName;
  final Value<String?> notes;
  final Value<String?> prescriptionPhotoPath;
  final Value<String?> extractedMedsJson;
  final Value<bool> reminderSent;
  final Value<bool> isCompleted;
  const DoctorAppointmentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.appointmentDate = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.notes = const Value.absent(),
    this.prescriptionPhotoPath = const Value.absent(),
    this.extractedMedsJson = const Value.absent(),
    this.reminderSent = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  DoctorAppointmentsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime appointmentDate,
    required String doctorName,
    this.notes = const Value.absent(),
    this.prescriptionPhotoPath = const Value.absent(),
    this.extractedMedsJson = const Value.absent(),
    this.reminderSent = const Value.absent(),
    this.isCompleted = const Value.absent(),
  }) : userId = Value(userId),
       appointmentDate = Value(appointmentDate),
       doctorName = Value(doctorName);
  static Insertable<DoctorAppointment> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? appointmentDate,
    Expression<String>? doctorName,
    Expression<String>? notes,
    Expression<String>? prescriptionPhotoPath,
    Expression<String>? extractedMedsJson,
    Expression<bool>? reminderSent,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (appointmentDate != null) 'appointment_date': appointmentDate,
      if (doctorName != null) 'doctor_name': doctorName,
      if (notes != null) 'notes': notes,
      if (prescriptionPhotoPath != null)
        'prescription_photo_path': prescriptionPhotoPath,
      if (extractedMedsJson != null) 'extracted_meds_json': extractedMedsJson,
      if (reminderSent != null) 'reminder_sent': reminderSent,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  DoctorAppointmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? appointmentDate,
    Value<String>? doctorName,
    Value<String?>? notes,
    Value<String?>? prescriptionPhotoPath,
    Value<String?>? extractedMedsJson,
    Value<bool>? reminderSent,
    Value<bool>? isCompleted,
  }) {
    return DoctorAppointmentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      doctorName: doctorName ?? this.doctorName,
      notes: notes ?? this.notes,
      prescriptionPhotoPath:
          prescriptionPhotoPath ?? this.prescriptionPhotoPath,
      extractedMedsJson: extractedMedsJson ?? this.extractedMedsJson,
      reminderSent: reminderSent ?? this.reminderSent,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (appointmentDate.present) {
      map['appointment_date'] = Variable<DateTime>(appointmentDate.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (prescriptionPhotoPath.present) {
      map['prescription_photo_path'] = Variable<String>(
        prescriptionPhotoPath.value,
      );
    }
    if (extractedMedsJson.present) {
      map['extracted_meds_json'] = Variable<String>(extractedMedsJson.value);
    }
    if (reminderSent.present) {
      map['reminder_sent'] = Variable<bool>(reminderSent.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DoctorAppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('doctorName: $doctorName, ')
          ..write('notes: $notes, ')
          ..write('prescriptionPhotoPath: $prescriptionPhotoPath, ')
          ..write('extractedMedsJson: $extractedMedsJson, ')
          ..write('reminderSent: $reminderSent, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $KarmaTransactionsTable extends KarmaTransactions
    with TableInfo<$KarmaTransactionsTable, KarmaTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KarmaTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, amount, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'karma_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<KarmaTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KarmaTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KarmaTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $KarmaTransactionsTable createAlias(String alias) {
    return $KarmaTransactionsTable(attachedDatabase, alias);
  }
}

class KarmaTransaction extends DataClass
    implements Insertable<KarmaTransaction> {
  final int id;
  final String userId;
  final int amount;
  final DateTime createdAt;
  const KarmaTransaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['amount'] = Variable<int>(amount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KarmaTransactionsCompanion toCompanion(bool nullToAbsent) {
    return KarmaTransactionsCompanion(
      id: Value(id),
      userId: Value(userId),
      amount: Value(amount),
      createdAt: Value(createdAt),
    );
  }

  factory KarmaTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KarmaTransaction(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      amount: serializer.fromJson<int>(json['amount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'amount': serializer.toJson<int>(amount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KarmaTransaction copyWith({
    int? id,
    String? userId,
    int? amount,
    DateTime? createdAt,
  }) => KarmaTransaction(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    amount: amount ?? this.amount,
    createdAt: createdAt ?? this.createdAt,
  );
  KarmaTransaction copyWithCompanion(KarmaTransactionsCompanion data) {
    return KarmaTransaction(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      amount: data.amount.present ? data.amount.value : this.amount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KarmaTransaction(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, amount, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KarmaTransaction &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.amount == this.amount &&
          other.createdAt == this.createdAt);
}

class KarmaTransactionsCompanion extends UpdateCompanion<KarmaTransaction> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> amount;
  final Value<DateTime> createdAt;
  const KarmaTransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.amount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KarmaTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int amount,
    required DateTime createdAt,
  }) : userId = Value(userId),
       amount = Value(amount),
       createdAt = Value(createdAt);
  static Insertable<KarmaTransaction> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? amount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (amount != null) 'amount': amount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  KarmaTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? amount,
    Value<DateTime>? createdAt,
  }) {
    return KarmaTransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KarmaTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('amount: $amount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NutritionGoalsTable extends NutritionGoals
    with TableInfo<$NutritionGoalsTable, NutritionGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _calorieGoalMeta = const VerificationMeta(
    'calorieGoal',
  );
  @override
  late final GeneratedColumn<double> calorieGoal = GeneratedColumn<double>(
    'calorie_goal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPercentMeta = const VerificationMeta(
    'carbsPercent',
  );
  @override
  late final GeneratedColumn<double> carbsPercent = GeneratedColumn<double>(
    'carbs_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(55),
  );
  static const VerificationMeta _proteinPercentMeta = const VerificationMeta(
    'proteinPercent',
  );
  @override
  late final GeneratedColumn<double> proteinPercent = GeneratedColumn<double>(
    'protein_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  static const VerificationMeta _fatPercentMeta = const VerificationMeta(
    'fatPercent',
  );
  @override
  late final GeneratedColumn<double> fatPercent = GeneratedColumn<double>(
    'fat_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(25),
  );
  static const VerificationMeta _carbsGramsMeta = const VerificationMeta(
    'carbsGrams',
  );
  @override
  late final GeneratedColumn<double> carbsGrams = GeneratedColumn<double>(
    'carbs_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinGramsMeta = const VerificationMeta(
    'proteinGrams',
  );
  @override
  late final GeneratedColumn<double> proteinGrams = GeneratedColumn<double>(
    'protein_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatGramsMeta = const VerificationMeta(
    'fatGrams',
  );
  @override
  late final GeneratedColumn<double> fatGrams = GeneratedColumn<double>(
    'fat_grams',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ironMgRdaMeta = const VerificationMeta(
    'ironMgRda',
  );
  @override
  late final GeneratedColumn<double> ironMgRda = GeneratedColumn<double>(
    'iron_mg_rda',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(18),
  );
  static const VerificationMeta _vitaminDMcgRdaMeta = const VerificationMeta(
    'vitaminDMcgRda',
  );
  @override
  late final GeneratedColumn<double> vitaminDMcgRda = GeneratedColumn<double>(
    'vitamin_d_mcg_rda',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(15),
  );
  static const VerificationMeta _vitaminB12McgRdaMeta = const VerificationMeta(
    'vitaminB12McgRda',
  );
  @override
  late final GeneratedColumn<double> vitaminB12McgRda = GeneratedColumn<double>(
    'vitamin_b12_mcg_rda',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(2.4),
  );
  static const VerificationMeta _calciumMgRdaMeta = const VerificationMeta(
    'calciumMgRda',
  );
  @override
  late final GeneratedColumn<double> calciumMgRda = GeneratedColumn<double>(
    'calcium_mg_rda',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1000),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    calorieGoal,
    carbsPercent,
    proteinPercent,
    fatPercent,
    carbsGrams,
    proteinGrams,
    fatGrams,
    ironMgRda,
    vitaminDMcgRda,
    vitaminB12McgRda,
    calciumMgRda,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionGoal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('calorie_goal')) {
      context.handle(
        _calorieGoalMeta,
        calorieGoal.isAcceptableOrUnknown(
          data['calorie_goal']!,
          _calorieGoalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_calorieGoalMeta);
    }
    if (data.containsKey('carbs_percent')) {
      context.handle(
        _carbsPercentMeta,
        carbsPercent.isAcceptableOrUnknown(
          data['carbs_percent']!,
          _carbsPercentMeta,
        ),
      );
    }
    if (data.containsKey('protein_percent')) {
      context.handle(
        _proteinPercentMeta,
        proteinPercent.isAcceptableOrUnknown(
          data['protein_percent']!,
          _proteinPercentMeta,
        ),
      );
    }
    if (data.containsKey('fat_percent')) {
      context.handle(
        _fatPercentMeta,
        fatPercent.isAcceptableOrUnknown(data['fat_percent']!, _fatPercentMeta),
      );
    }
    if (data.containsKey('carbs_grams')) {
      context.handle(
        _carbsGramsMeta,
        carbsGrams.isAcceptableOrUnknown(data['carbs_grams']!, _carbsGramsMeta),
      );
    }
    if (data.containsKey('protein_grams')) {
      context.handle(
        _proteinGramsMeta,
        proteinGrams.isAcceptableOrUnknown(
          data['protein_grams']!,
          _proteinGramsMeta,
        ),
      );
    }
    if (data.containsKey('fat_grams')) {
      context.handle(
        _fatGramsMeta,
        fatGrams.isAcceptableOrUnknown(data['fat_grams']!, _fatGramsMeta),
      );
    }
    if (data.containsKey('iron_mg_rda')) {
      context.handle(
        _ironMgRdaMeta,
        ironMgRda.isAcceptableOrUnknown(data['iron_mg_rda']!, _ironMgRdaMeta),
      );
    }
    if (data.containsKey('vitamin_d_mcg_rda')) {
      context.handle(
        _vitaminDMcgRdaMeta,
        vitaminDMcgRda.isAcceptableOrUnknown(
          data['vitamin_d_mcg_rda']!,
          _vitaminDMcgRdaMeta,
        ),
      );
    }
    if (data.containsKey('vitamin_b12_mcg_rda')) {
      context.handle(
        _vitaminB12McgRdaMeta,
        vitaminB12McgRda.isAcceptableOrUnknown(
          data['vitamin_b12_mcg_rda']!,
          _vitaminB12McgRdaMeta,
        ),
      );
    }
    if (data.containsKey('calcium_mg_rda')) {
      context.handle(
        _calciumMgRdaMeta,
        calciumMgRda.isAcceptableOrUnknown(
          data['calcium_mg_rda']!,
          _calciumMgRdaMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NutritionGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      calorieGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorie_goal'],
      )!,
      carbsPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_percent'],
      )!,
      proteinPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_percent'],
      )!,
      fatPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_percent'],
      )!,
      carbsGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_grams'],
      ),
      proteinGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_grams'],
      ),
      fatGrams: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_grams'],
      ),
      ironMgRda: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}iron_mg_rda'],
      )!,
      vitaminDMcgRda: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_d_mcg_rda'],
      )!,
      vitaminB12McgRda: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vitamin_b12_mcg_rda'],
      )!,
      calciumMgRda: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calcium_mg_rda'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NutritionGoalsTable createAlias(String alias) {
    return $NutritionGoalsTable(attachedDatabase, alias);
  }
}

class NutritionGoal extends DataClass implements Insertable<NutritionGoal> {
  final int id;
  final String userId;
  final double calorieGoal;
  final double carbsPercent;
  final double proteinPercent;
  final double fatPercent;
  final double? carbsGrams;
  final double? proteinGrams;
  final double? fatGrams;
  final double ironMgRda;
  final double vitaminDMcgRda;
  final double vitaminB12McgRda;
  final double calciumMgRda;
  final DateTime updatedAt;
  const NutritionGoal({
    required this.id,
    required this.userId,
    required this.calorieGoal,
    required this.carbsPercent,
    required this.proteinPercent,
    required this.fatPercent,
    this.carbsGrams,
    this.proteinGrams,
    this.fatGrams,
    required this.ironMgRda,
    required this.vitaminDMcgRda,
    required this.vitaminB12McgRda,
    required this.calciumMgRda,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['calorie_goal'] = Variable<double>(calorieGoal);
    map['carbs_percent'] = Variable<double>(carbsPercent);
    map['protein_percent'] = Variable<double>(proteinPercent);
    map['fat_percent'] = Variable<double>(fatPercent);
    if (!nullToAbsent || carbsGrams != null) {
      map['carbs_grams'] = Variable<double>(carbsGrams);
    }
    if (!nullToAbsent || proteinGrams != null) {
      map['protein_grams'] = Variable<double>(proteinGrams);
    }
    if (!nullToAbsent || fatGrams != null) {
      map['fat_grams'] = Variable<double>(fatGrams);
    }
    map['iron_mg_rda'] = Variable<double>(ironMgRda);
    map['vitamin_d_mcg_rda'] = Variable<double>(vitaminDMcgRda);
    map['vitamin_b12_mcg_rda'] = Variable<double>(vitaminB12McgRda);
    map['calcium_mg_rda'] = Variable<double>(calciumMgRda);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NutritionGoalsCompanion toCompanion(bool nullToAbsent) {
    return NutritionGoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      calorieGoal: Value(calorieGoal),
      carbsPercent: Value(carbsPercent),
      proteinPercent: Value(proteinPercent),
      fatPercent: Value(fatPercent),
      carbsGrams: carbsGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsGrams),
      proteinGrams: proteinGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinGrams),
      fatGrams: fatGrams == null && nullToAbsent
          ? const Value.absent()
          : Value(fatGrams),
      ironMgRda: Value(ironMgRda),
      vitaminDMcgRda: Value(vitaminDMcgRda),
      vitaminB12McgRda: Value(vitaminB12McgRda),
      calciumMgRda: Value(calciumMgRda),
      updatedAt: Value(updatedAt),
    );
  }

  factory NutritionGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionGoal(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      calorieGoal: serializer.fromJson<double>(json['calorieGoal']),
      carbsPercent: serializer.fromJson<double>(json['carbsPercent']),
      proteinPercent: serializer.fromJson<double>(json['proteinPercent']),
      fatPercent: serializer.fromJson<double>(json['fatPercent']),
      carbsGrams: serializer.fromJson<double?>(json['carbsGrams']),
      proteinGrams: serializer.fromJson<double?>(json['proteinGrams']),
      fatGrams: serializer.fromJson<double?>(json['fatGrams']),
      ironMgRda: serializer.fromJson<double>(json['ironMgRda']),
      vitaminDMcgRda: serializer.fromJson<double>(json['vitaminDMcgRda']),
      vitaminB12McgRda: serializer.fromJson<double>(json['vitaminB12McgRda']),
      calciumMgRda: serializer.fromJson<double>(json['calciumMgRda']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'calorieGoal': serializer.toJson<double>(calorieGoal),
      'carbsPercent': serializer.toJson<double>(carbsPercent),
      'proteinPercent': serializer.toJson<double>(proteinPercent),
      'fatPercent': serializer.toJson<double>(fatPercent),
      'carbsGrams': serializer.toJson<double?>(carbsGrams),
      'proteinGrams': serializer.toJson<double?>(proteinGrams),
      'fatGrams': serializer.toJson<double?>(fatGrams),
      'ironMgRda': serializer.toJson<double>(ironMgRda),
      'vitaminDMcgRda': serializer.toJson<double>(vitaminDMcgRda),
      'vitaminB12McgRda': serializer.toJson<double>(vitaminB12McgRda),
      'calciumMgRda': serializer.toJson<double>(calciumMgRda),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NutritionGoal copyWith({
    int? id,
    String? userId,
    double? calorieGoal,
    double? carbsPercent,
    double? proteinPercent,
    double? fatPercent,
    Value<double?> carbsGrams = const Value.absent(),
    Value<double?> proteinGrams = const Value.absent(),
    Value<double?> fatGrams = const Value.absent(),
    double? ironMgRda,
    double? vitaminDMcgRda,
    double? vitaminB12McgRda,
    double? calciumMgRda,
    DateTime? updatedAt,
  }) => NutritionGoal(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    calorieGoal: calorieGoal ?? this.calorieGoal,
    carbsPercent: carbsPercent ?? this.carbsPercent,
    proteinPercent: proteinPercent ?? this.proteinPercent,
    fatPercent: fatPercent ?? this.fatPercent,
    carbsGrams: carbsGrams.present ? carbsGrams.value : this.carbsGrams,
    proteinGrams: proteinGrams.present ? proteinGrams.value : this.proteinGrams,
    fatGrams: fatGrams.present ? fatGrams.value : this.fatGrams,
    ironMgRda: ironMgRda ?? this.ironMgRda,
    vitaminDMcgRda: vitaminDMcgRda ?? this.vitaminDMcgRda,
    vitaminB12McgRda: vitaminB12McgRda ?? this.vitaminB12McgRda,
    calciumMgRda: calciumMgRda ?? this.calciumMgRda,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NutritionGoal copyWithCompanion(NutritionGoalsCompanion data) {
    return NutritionGoal(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      calorieGoal: data.calorieGoal.present
          ? data.calorieGoal.value
          : this.calorieGoal,
      carbsPercent: data.carbsPercent.present
          ? data.carbsPercent.value
          : this.carbsPercent,
      proteinPercent: data.proteinPercent.present
          ? data.proteinPercent.value
          : this.proteinPercent,
      fatPercent: data.fatPercent.present
          ? data.fatPercent.value
          : this.fatPercent,
      carbsGrams: data.carbsGrams.present
          ? data.carbsGrams.value
          : this.carbsGrams,
      proteinGrams: data.proteinGrams.present
          ? data.proteinGrams.value
          : this.proteinGrams,
      fatGrams: data.fatGrams.present ? data.fatGrams.value : this.fatGrams,
      ironMgRda: data.ironMgRda.present ? data.ironMgRda.value : this.ironMgRda,
      vitaminDMcgRda: data.vitaminDMcgRda.present
          ? data.vitaminDMcgRda.value
          : this.vitaminDMcgRda,
      vitaminB12McgRda: data.vitaminB12McgRda.present
          ? data.vitaminB12McgRda.value
          : this.vitaminB12McgRda,
      calciumMgRda: data.calciumMgRda.present
          ? data.calciumMgRda.value
          : this.calciumMgRda,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('carbsPercent: $carbsPercent, ')
          ..write('proteinPercent: $proteinPercent, ')
          ..write('fatPercent: $fatPercent, ')
          ..write('carbsGrams: $carbsGrams, ')
          ..write('proteinGrams: $proteinGrams, ')
          ..write('fatGrams: $fatGrams, ')
          ..write('ironMgRda: $ironMgRda, ')
          ..write('vitaminDMcgRda: $vitaminDMcgRda, ')
          ..write('vitaminB12McgRda: $vitaminB12McgRda, ')
          ..write('calciumMgRda: $calciumMgRda, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    calorieGoal,
    carbsPercent,
    proteinPercent,
    fatPercent,
    carbsGrams,
    proteinGrams,
    fatGrams,
    ironMgRda,
    vitaminDMcgRda,
    vitaminB12McgRda,
    calciumMgRda,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionGoal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.calorieGoal == this.calorieGoal &&
          other.carbsPercent == this.carbsPercent &&
          other.proteinPercent == this.proteinPercent &&
          other.fatPercent == this.fatPercent &&
          other.carbsGrams == this.carbsGrams &&
          other.proteinGrams == this.proteinGrams &&
          other.fatGrams == this.fatGrams &&
          other.ironMgRda == this.ironMgRda &&
          other.vitaminDMcgRda == this.vitaminDMcgRda &&
          other.vitaminB12McgRda == this.vitaminB12McgRda &&
          other.calciumMgRda == this.calciumMgRda &&
          other.updatedAt == this.updatedAt);
}

class NutritionGoalsCompanion extends UpdateCompanion<NutritionGoal> {
  final Value<int> id;
  final Value<String> userId;
  final Value<double> calorieGoal;
  final Value<double> carbsPercent;
  final Value<double> proteinPercent;
  final Value<double> fatPercent;
  final Value<double?> carbsGrams;
  final Value<double?> proteinGrams;
  final Value<double?> fatGrams;
  final Value<double> ironMgRda;
  final Value<double> vitaminDMcgRda;
  final Value<double> vitaminB12McgRda;
  final Value<double> calciumMgRda;
  final Value<DateTime> updatedAt;
  const NutritionGoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.calorieGoal = const Value.absent(),
    this.carbsPercent = const Value.absent(),
    this.proteinPercent = const Value.absent(),
    this.fatPercent = const Value.absent(),
    this.carbsGrams = const Value.absent(),
    this.proteinGrams = const Value.absent(),
    this.fatGrams = const Value.absent(),
    this.ironMgRda = const Value.absent(),
    this.vitaminDMcgRda = const Value.absent(),
    this.vitaminB12McgRda = const Value.absent(),
    this.calciumMgRda = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NutritionGoalsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required double calorieGoal,
    this.carbsPercent = const Value.absent(),
    this.proteinPercent = const Value.absent(),
    this.fatPercent = const Value.absent(),
    this.carbsGrams = const Value.absent(),
    this.proteinGrams = const Value.absent(),
    this.fatGrams = const Value.absent(),
    this.ironMgRda = const Value.absent(),
    this.vitaminDMcgRda = const Value.absent(),
    this.vitaminB12McgRda = const Value.absent(),
    this.calciumMgRda = const Value.absent(),
    required DateTime updatedAt,
  }) : userId = Value(userId),
       calorieGoal = Value(calorieGoal),
       updatedAt = Value(updatedAt);
  static Insertable<NutritionGoal> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<double>? calorieGoal,
    Expression<double>? carbsPercent,
    Expression<double>? proteinPercent,
    Expression<double>? fatPercent,
    Expression<double>? carbsGrams,
    Expression<double>? proteinGrams,
    Expression<double>? fatGrams,
    Expression<double>? ironMgRda,
    Expression<double>? vitaminDMcgRda,
    Expression<double>? vitaminB12McgRda,
    Expression<double>? calciumMgRda,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (calorieGoal != null) 'calorie_goal': calorieGoal,
      if (carbsPercent != null) 'carbs_percent': carbsPercent,
      if (proteinPercent != null) 'protein_percent': proteinPercent,
      if (fatPercent != null) 'fat_percent': fatPercent,
      if (carbsGrams != null) 'carbs_grams': carbsGrams,
      if (proteinGrams != null) 'protein_grams': proteinGrams,
      if (fatGrams != null) 'fat_grams': fatGrams,
      if (ironMgRda != null) 'iron_mg_rda': ironMgRda,
      if (vitaminDMcgRda != null) 'vitamin_d_mcg_rda': vitaminDMcgRda,
      if (vitaminB12McgRda != null) 'vitamin_b12_mcg_rda': vitaminB12McgRda,
      if (calciumMgRda != null) 'calcium_mg_rda': calciumMgRda,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NutritionGoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<double>? calorieGoal,
    Value<double>? carbsPercent,
    Value<double>? proteinPercent,
    Value<double>? fatPercent,
    Value<double?>? carbsGrams,
    Value<double?>? proteinGrams,
    Value<double?>? fatGrams,
    Value<double>? ironMgRda,
    Value<double>? vitaminDMcgRda,
    Value<double>? vitaminB12McgRda,
    Value<double>? calciumMgRda,
    Value<DateTime>? updatedAt,
  }) {
    return NutritionGoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      calorieGoal: calorieGoal ?? this.calorieGoal,
      carbsPercent: carbsPercent ?? this.carbsPercent,
      proteinPercent: proteinPercent ?? this.proteinPercent,
      fatPercent: fatPercent ?? this.fatPercent,
      carbsGrams: carbsGrams ?? this.carbsGrams,
      proteinGrams: proteinGrams ?? this.proteinGrams,
      fatGrams: fatGrams ?? this.fatGrams,
      ironMgRda: ironMgRda ?? this.ironMgRda,
      vitaminDMcgRda: vitaminDMcgRda ?? this.vitaminDMcgRda,
      vitaminB12McgRda: vitaminB12McgRda ?? this.vitaminB12McgRda,
      calciumMgRda: calciumMgRda ?? this.calciumMgRda,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (calorieGoal.present) {
      map['calorie_goal'] = Variable<double>(calorieGoal.value);
    }
    if (carbsPercent.present) {
      map['carbs_percent'] = Variable<double>(carbsPercent.value);
    }
    if (proteinPercent.present) {
      map['protein_percent'] = Variable<double>(proteinPercent.value);
    }
    if (fatPercent.present) {
      map['fat_percent'] = Variable<double>(fatPercent.value);
    }
    if (carbsGrams.present) {
      map['carbs_grams'] = Variable<double>(carbsGrams.value);
    }
    if (proteinGrams.present) {
      map['protein_grams'] = Variable<double>(proteinGrams.value);
    }
    if (fatGrams.present) {
      map['fat_grams'] = Variable<double>(fatGrams.value);
    }
    if (ironMgRda.present) {
      map['iron_mg_rda'] = Variable<double>(ironMgRda.value);
    }
    if (vitaminDMcgRda.present) {
      map['vitamin_d_mcg_rda'] = Variable<double>(vitaminDMcgRda.value);
    }
    if (vitaminB12McgRda.present) {
      map['vitamin_b12_mcg_rda'] = Variable<double>(vitaminB12McgRda.value);
    }
    if (calciumMgRda.present) {
      map['calcium_mg_rda'] = Variable<double>(calciumMgRda.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('calorieGoal: $calorieGoal, ')
          ..write('carbsPercent: $carbsPercent, ')
          ..write('proteinPercent: $proteinPercent, ')
          ..write('fatPercent: $fatPercent, ')
          ..write('carbsGrams: $carbsGrams, ')
          ..write('proteinGrams: $proteinGrams, ')
          ..write('fatGrams: $fatGrams, ')
          ..write('ironMgRda: $ironMgRda, ')
          ..write('vitaminDMcgRda: $vitaminDMcgRda, ')
          ..write('vitaminB12McgRda: $vitaminB12McgRda, ')
          ..write('calciumMgRda: $calciumMgRda, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, recordType, achievedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_recordTypeMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PersonalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      )!,
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
    );
  }

  @override
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecord extends DataClass implements Insertable<PersonalRecord> {
  final int id;
  final String userId;
  final String recordType;
  final DateTime achievedAt;
  const PersonalRecord({
    required this.id,
    required this.userId,
    required this.recordType,
    required this.achievedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['record_type'] = Variable<String>(recordType);
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      id: Value(id),
      userId: Value(userId),
      recordType: Value(recordType),
      achievedAt: Value(achievedAt),
    );
  }

  factory PersonalRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecord(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      recordType: serializer.fromJson<String>(json['recordType']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'recordType': serializer.toJson<String>(recordType),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
    };
  }

  PersonalRecord copyWith({
    int? id,
    String? userId,
    String? recordType,
    DateTime? achievedAt,
  }) => PersonalRecord(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    recordType: recordType ?? this.recordType,
    achievedAt: achievedAt ?? this.achievedAt,
  );
  PersonalRecord copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecord(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecord(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('recordType: $recordType, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, recordType, achievedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecord &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.recordType == this.recordType &&
          other.achievedAt == this.achievedAt);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecord> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> recordType;
  final Value<DateTime> achievedAt;
  const PersonalRecordsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.recordType = const Value.absent(),
    this.achievedAt = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String recordType,
    required DateTime achievedAt,
  }) : userId = Value(userId),
       recordType = Value(recordType),
       achievedAt = Value(achievedAt);
  static Insertable<PersonalRecord> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? recordType,
    Expression<DateTime>? achievedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (recordType != null) 'record_type': recordType,
      if (achievedAt != null) 'achieved_at': achievedAt,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? recordType,
    Value<DateTime>? achievedAt,
  }) {
    return PersonalRecordsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      recordType: recordType ?? this.recordType,
      achievedAt: achievedAt ?? this.achievedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('recordType: $recordType, ')
          ..write('achievedAt: $achievedAt')
          ..write(')'))
        .toString();
  }
}

class $RemoteConfigCacheTable extends RemoteConfigCache
    with TableInfo<$RemoteConfigCacheTable, RemoteConfigCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemoteConfigCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 4096,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, value, type, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_config_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemoteConfigCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {key},
  ];
  @override
  RemoteConfigCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemoteConfigCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      lastUpdated: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_updated'],
      )!,
    );
  }

  @override
  $RemoteConfigCacheTable createAlias(String alias) {
    return $RemoteConfigCacheTable(attachedDatabase, alias);
  }
}

class RemoteConfigCacheData extends DataClass
    implements Insertable<RemoteConfigCacheData> {
  final int id;
  final String key;
  final String value;
  final String type;
  final DateTime lastUpdated;
  const RemoteConfigCacheData({
    required this.id,
    required this.key,
    required this.value,
    required this.type,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['type'] = Variable<String>(type);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  RemoteConfigCacheCompanion toCompanion(bool nullToAbsent) {
    return RemoteConfigCacheCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      type: Value(type),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory RemoteConfigCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemoteConfigCacheData(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      type: serializer.fromJson<String>(json['type']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'type': serializer.toJson<String>(type),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  RemoteConfigCacheData copyWith({
    int? id,
    String? key,
    String? value,
    String? type,
    DateTime? lastUpdated,
  }) => RemoteConfigCacheData(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    type: type ?? this.type,
    lastUpdated: lastUpdated ?? this.lastUpdated,
  );
  RemoteConfigCacheData copyWithCompanion(RemoteConfigCacheCompanion data) {
    return RemoteConfigCacheData(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      type: data.type.present ? data.type.value : this.type,
      lastUpdated: data.lastUpdated.present
          ? data.lastUpdated.value
          : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemoteConfigCacheData(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, type, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemoteConfigCacheData &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.type == this.type &&
          other.lastUpdated == this.lastUpdated);
}

class RemoteConfigCacheCompanion
    extends UpdateCompanion<RemoteConfigCacheData> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<String> type;
  final Value<DateTime> lastUpdated;
  const RemoteConfigCacheCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  RemoteConfigCacheCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    required String type,
    required DateTime lastUpdated,
  }) : key = Value(key),
       value = Value(value),
       type = Value(type),
       lastUpdated = Value(lastUpdated);
  static Insertable<RemoteConfigCacheData> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<String>? type,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  RemoteConfigCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<String>? type,
    Value<DateTime>? lastUpdated,
  }) {
    return RemoteConfigCacheCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      type: type ?? this.type,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemoteConfigCacheCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

class $LabReportsTable extends LabReports
    with TableInfo<$LabReportsTable, LabReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportNameMeta = const VerificationMeta(
    'reportName',
  );
  @override
  late final GeneratedColumn<String> reportName = GeneratedColumn<String>(
    'report_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reportUrlMeta = const VerificationMeta(
    'reportUrl',
  );
  @override
  late final GeneratedColumn<String> reportUrl = GeneratedColumn<String>(
    'report_url',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 512),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _uploadedAtMeta = const VerificationMeta(
    'uploadedAt',
  );
  @override
  late final GeneratedColumn<DateTime> uploadedAt = GeneratedColumn<DateTime>(
    'uploaded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labNameMeta = const VerificationMeta(
    'labName',
  );
  @override
  late final GeneratedColumn<String> labName = GeneratedColumn<String>(
    'lab_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 128),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _summaryJsonMeta = const VerificationMeta(
    'summaryJson',
  );
  @override
  late final GeneratedColumn<String> summaryJson = GeneratedColumn<String>(
    'summary_json',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 8192),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extractedDataJsonMeta = const VerificationMeta(
    'extractedDataJson',
  );
  @override
  late final GeneratedColumn<String> extractedDataJson =
      GeneratedColumn<String>(
        'extracted_data_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _isEncryptedMeta = const VerificationMeta(
    'isEncrypted',
  );
  @override
  late final GeneratedColumn<bool> isEncrypted = GeneratedColumn<bool>(
    'is_encrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_encrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    reportName,
    reportUrl,
    uploadedAt,
    labName,
    summaryJson,
    extractedDataJson,
    isEncrypted,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('report_name')) {
      context.handle(
        _reportNameMeta,
        reportName.isAcceptableOrUnknown(data['report_name']!, _reportNameMeta),
      );
    } else if (isInserting) {
      context.missing(_reportNameMeta);
    }
    if (data.containsKey('report_url')) {
      context.handle(
        _reportUrlMeta,
        reportUrl.isAcceptableOrUnknown(data['report_url']!, _reportUrlMeta),
      );
    }
    if (data.containsKey('uploaded_at')) {
      context.handle(
        _uploadedAtMeta,
        uploadedAt.isAcceptableOrUnknown(data['uploaded_at']!, _uploadedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_uploadedAtMeta);
    }
    if (data.containsKey('lab_name')) {
      context.handle(
        _labNameMeta,
        labName.isAcceptableOrUnknown(data['lab_name']!, _labNameMeta),
      );
    }
    if (data.containsKey('summary_json')) {
      context.handle(
        _summaryJsonMeta,
        summaryJson.isAcceptableOrUnknown(
          data['summary_json']!,
          _summaryJsonMeta,
        ),
      );
    }
    if (data.containsKey('extracted_data_json')) {
      context.handle(
        _extractedDataJsonMeta,
        extractedDataJson.isAcceptableOrUnknown(
          data['extracted_data_json']!,
          _extractedDataJsonMeta,
        ),
      );
    }
    if (data.containsKey('is_encrypted')) {
      context.handle(
        _isEncryptedMeta,
        isEncrypted.isAcceptableOrUnknown(
          data['is_encrypted']!,
          _isEncryptedMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      reportName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_name'],
      )!,
      reportUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_url'],
      ),
      uploadedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}uploaded_at'],
      )!,
      labName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_name'],
      ),
      summaryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}summary_json'],
      ),
      extractedDataJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extracted_data_json'],
      ),
      isEncrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_encrypted'],
      )!,
    );
  }

  @override
  $LabReportsTable createAlias(String alias) {
    return $LabReportsTable(attachedDatabase, alias);
  }
}

class LabReport extends DataClass implements Insertable<LabReport> {
  final int id;
  final String userId;
  final String reportName;
  final String? reportUrl;
  final DateTime uploadedAt;
  final String? labName;
  final String? summaryJson;
  final String? extractedDataJson;
  final bool isEncrypted;
  const LabReport({
    required this.id,
    required this.userId,
    required this.reportName,
    this.reportUrl,
    required this.uploadedAt,
    this.labName,
    this.summaryJson,
    this.extractedDataJson,
    required this.isEncrypted,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['report_name'] = Variable<String>(reportName);
    if (!nullToAbsent || reportUrl != null) {
      map['report_url'] = Variable<String>(reportUrl);
    }
    map['uploaded_at'] = Variable<DateTime>(uploadedAt);
    if (!nullToAbsent || labName != null) {
      map['lab_name'] = Variable<String>(labName);
    }
    if (!nullToAbsent || summaryJson != null) {
      map['summary_json'] = Variable<String>(summaryJson);
    }
    if (!nullToAbsent || extractedDataJson != null) {
      map['extracted_data_json'] = Variable<String>(extractedDataJson);
    }
    map['is_encrypted'] = Variable<bool>(isEncrypted);
    return map;
  }

  LabReportsCompanion toCompanion(bool nullToAbsent) {
    return LabReportsCompanion(
      id: Value(id),
      userId: Value(userId),
      reportName: Value(reportName),
      reportUrl: reportUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(reportUrl),
      uploadedAt: Value(uploadedAt),
      labName: labName == null && nullToAbsent
          ? const Value.absent()
          : Value(labName),
      summaryJson: summaryJson == null && nullToAbsent
          ? const Value.absent()
          : Value(summaryJson),
      extractedDataJson: extractedDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(extractedDataJson),
      isEncrypted: Value(isEncrypted),
    );
  }

  factory LabReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabReport(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      reportName: serializer.fromJson<String>(json['reportName']),
      reportUrl: serializer.fromJson<String?>(json['reportUrl']),
      uploadedAt: serializer.fromJson<DateTime>(json['uploadedAt']),
      labName: serializer.fromJson<String?>(json['labName']),
      summaryJson: serializer.fromJson<String?>(json['summaryJson']),
      extractedDataJson: serializer.fromJson<String?>(
        json['extractedDataJson'],
      ),
      isEncrypted: serializer.fromJson<bool>(json['isEncrypted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'reportName': serializer.toJson<String>(reportName),
      'reportUrl': serializer.toJson<String?>(reportUrl),
      'uploadedAt': serializer.toJson<DateTime>(uploadedAt),
      'labName': serializer.toJson<String?>(labName),
      'summaryJson': serializer.toJson<String?>(summaryJson),
      'extractedDataJson': serializer.toJson<String?>(extractedDataJson),
      'isEncrypted': serializer.toJson<bool>(isEncrypted),
    };
  }

  LabReport copyWith({
    int? id,
    String? userId,
    String? reportName,
    Value<String?> reportUrl = const Value.absent(),
    DateTime? uploadedAt,
    Value<String?> labName = const Value.absent(),
    Value<String?> summaryJson = const Value.absent(),
    Value<String?> extractedDataJson = const Value.absent(),
    bool? isEncrypted,
  }) => LabReport(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    reportName: reportName ?? this.reportName,
    reportUrl: reportUrl.present ? reportUrl.value : this.reportUrl,
    uploadedAt: uploadedAt ?? this.uploadedAt,
    labName: labName.present ? labName.value : this.labName,
    summaryJson: summaryJson.present ? summaryJson.value : this.summaryJson,
    extractedDataJson: extractedDataJson.present
        ? extractedDataJson.value
        : this.extractedDataJson,
    isEncrypted: isEncrypted ?? this.isEncrypted,
  );
  LabReport copyWithCompanion(LabReportsCompanion data) {
    return LabReport(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      reportName: data.reportName.present
          ? data.reportName.value
          : this.reportName,
      reportUrl: data.reportUrl.present ? data.reportUrl.value : this.reportUrl,
      uploadedAt: data.uploadedAt.present
          ? data.uploadedAt.value
          : this.uploadedAt,
      labName: data.labName.present ? data.labName.value : this.labName,
      summaryJson: data.summaryJson.present
          ? data.summaryJson.value
          : this.summaryJson,
      extractedDataJson: data.extractedDataJson.present
          ? data.extractedDataJson.value
          : this.extractedDataJson,
      isEncrypted: data.isEncrypted.present
          ? data.isEncrypted.value
          : this.isEncrypted,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabReport(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('reportName: $reportName, ')
          ..write('reportUrl: $reportUrl, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('labName: $labName, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('extractedDataJson: $extractedDataJson, ')
          ..write('isEncrypted: $isEncrypted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    reportName,
    reportUrl,
    uploadedAt,
    labName,
    summaryJson,
    extractedDataJson,
    isEncrypted,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabReport &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.reportName == this.reportName &&
          other.reportUrl == this.reportUrl &&
          other.uploadedAt == this.uploadedAt &&
          other.labName == this.labName &&
          other.summaryJson == this.summaryJson &&
          other.extractedDataJson == this.extractedDataJson &&
          other.isEncrypted == this.isEncrypted);
}

class LabReportsCompanion extends UpdateCompanion<LabReport> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> reportName;
  final Value<String?> reportUrl;
  final Value<DateTime> uploadedAt;
  final Value<String?> labName;
  final Value<String?> summaryJson;
  final Value<String?> extractedDataJson;
  final Value<bool> isEncrypted;
  const LabReportsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.reportName = const Value.absent(),
    this.reportUrl = const Value.absent(),
    this.uploadedAt = const Value.absent(),
    this.labName = const Value.absent(),
    this.summaryJson = const Value.absent(),
    this.extractedDataJson = const Value.absent(),
    this.isEncrypted = const Value.absent(),
  });
  LabReportsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String reportName,
    this.reportUrl = const Value.absent(),
    required DateTime uploadedAt,
    this.labName = const Value.absent(),
    this.summaryJson = const Value.absent(),
    this.extractedDataJson = const Value.absent(),
    this.isEncrypted = const Value.absent(),
  }) : userId = Value(userId),
       reportName = Value(reportName),
       uploadedAt = Value(uploadedAt);
  static Insertable<LabReport> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? reportName,
    Expression<String>? reportUrl,
    Expression<DateTime>? uploadedAt,
    Expression<String>? labName,
    Expression<String>? summaryJson,
    Expression<String>? extractedDataJson,
    Expression<bool>? isEncrypted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (reportName != null) 'report_name': reportName,
      if (reportUrl != null) 'report_url': reportUrl,
      if (uploadedAt != null) 'uploaded_at': uploadedAt,
      if (labName != null) 'lab_name': labName,
      if (summaryJson != null) 'summary_json': summaryJson,
      if (extractedDataJson != null) 'extracted_data_json': extractedDataJson,
      if (isEncrypted != null) 'is_encrypted': isEncrypted,
    });
  }

  LabReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? reportName,
    Value<String?>? reportUrl,
    Value<DateTime>? uploadedAt,
    Value<String?>? labName,
    Value<String?>? summaryJson,
    Value<String?>? extractedDataJson,
    Value<bool>? isEncrypted,
  }) {
    return LabReportsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reportName: reportName ?? this.reportName,
      reportUrl: reportUrl ?? this.reportUrl,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      labName: labName ?? this.labName,
      summaryJson: summaryJson ?? this.summaryJson,
      extractedDataJson: extractedDataJson ?? this.extractedDataJson,
      isEncrypted: isEncrypted ?? this.isEncrypted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (reportName.present) {
      map['report_name'] = Variable<String>(reportName.value);
    }
    if (reportUrl.present) {
      map['report_url'] = Variable<String>(reportUrl.value);
    }
    if (uploadedAt.present) {
      map['uploaded_at'] = Variable<DateTime>(uploadedAt.value);
    }
    if (labName.present) {
      map['lab_name'] = Variable<String>(labName.value);
    }
    if (summaryJson.present) {
      map['summary_json'] = Variable<String>(summaryJson.value);
    }
    if (extractedDataJson.present) {
      map['extracted_data_json'] = Variable<String>(extractedDataJson.value);
    }
    if (isEncrypted.present) {
      map['is_encrypted'] = Variable<bool>(isEncrypted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabReportsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('reportName: $reportName, ')
          ..write('reportUrl: $reportUrl, ')
          ..write('uploadedAt: $uploadedAt, ')
          ..write('labName: $labName, ')
          ..write('summaryJson: $summaryJson, ')
          ..write('extractedDataJson: $extractedDataJson, ')
          ..write('isEncrypted: $isEncrypted')
          ..write(')'))
        .toString();
  }
}

class $AbhaLinksTable extends AbhaLinks
    with TableInfo<$AbhaLinksTable, AbhaLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbhaLinksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abhaNumberMeta = const VerificationMeta(
    'abhaNumber',
  );
  @override
  late final GeneratedColumn<String> abhaNumber = GeneratedColumn<String>(
    'abha_number',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abhaAddressMeta = const VerificationMeta(
    'abhaAddress',
  );
  @override
  late final GeneratedColumn<String> abhaAddress = GeneratedColumn<String>(
    'abha_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stateCodeMeta = const VerificationMeta(
    'stateCode',
  );
  @override
  late final GeneratedColumn<String> stateCode = GeneratedColumn<String>(
    'state_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtCodeMeta = const VerificationMeta(
    'districtCode',
  );
  @override
  late final GeneratedColumn<String> districtCode = GeneratedColumn<String>(
    'district_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _linkedAtMeta = const VerificationMeta(
    'linkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> linkedAt = GeneratedColumn<DateTime>(
    'linked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedAtMeta = const VerificationMeta(
    'lastSyncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastSyncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    abhaNumber,
    abhaAddress,
    firstName,
    lastName,
    gender,
    dateOfBirth,
    stateCode,
    districtCode,
    isVerified,
    linkedAt,
    lastSyncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'abha_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbhaLink> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('abha_number')) {
      context.handle(
        _abhaNumberMeta,
        abhaNumber.isAcceptableOrUnknown(data['abha_number']!, _abhaNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_abhaNumberMeta);
    }
    if (data.containsKey('abha_address')) {
      context.handle(
        _abhaAddressMeta,
        abhaAddress.isAcceptableOrUnknown(
          data['abha_address']!,
          _abhaAddressMeta,
        ),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('state_code')) {
      context.handle(
        _stateCodeMeta,
        stateCode.isAcceptableOrUnknown(data['state_code']!, _stateCodeMeta),
      );
    }
    if (data.containsKey('district_code')) {
      context.handle(
        _districtCodeMeta,
        districtCode.isAcceptableOrUnknown(
          data['district_code']!,
          _districtCodeMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
      );
    }
    if (data.containsKey('linked_at')) {
      context.handle(
        _linkedAtMeta,
        linkedAt.isAcceptableOrUnknown(data['linked_at']!, _linkedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_linkedAtMeta);
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _lastSyncedAtMeta,
        lastSyncedAt.isAcceptableOrUnknown(
          data['last_synced_at']!,
          _lastSyncedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AbhaLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbhaLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      abhaNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abha_number'],
      )!,
      abhaAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abha_address'],
      ),
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      ),
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      stateCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state_code'],
      ),
      districtCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district_code'],
      ),
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
      )!,
      linkedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}linked_at'],
      )!,
      lastSyncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      ),
    );
  }

  @override
  $AbhaLinksTable createAlias(String alias) {
    return $AbhaLinksTable(attachedDatabase, alias);
  }
}

class AbhaLink extends DataClass implements Insertable<AbhaLink> {
  final int id;
  final String userId;
  final String abhaNumber;
  final String? abhaAddress;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? stateCode;
  final String? districtCode;
  final bool isVerified;
  final DateTime linkedAt;
  final DateTime? lastSyncedAt;
  const AbhaLink({
    required this.id,
    required this.userId,
    required this.abhaNumber,
    this.abhaAddress,
    this.firstName,
    this.lastName,
    this.gender,
    this.dateOfBirth,
    this.stateCode,
    this.districtCode,
    required this.isVerified,
    required this.linkedAt,
    this.lastSyncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['abha_number'] = Variable<String>(abhaNumber);
    if (!nullToAbsent || abhaAddress != null) {
      map['abha_address'] = Variable<String>(abhaAddress);
    }
    if (!nullToAbsent || firstName != null) {
      map['first_name'] = Variable<String>(firstName);
    }
    if (!nullToAbsent || lastName != null) {
      map['last_name'] = Variable<String>(lastName);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || stateCode != null) {
      map['state_code'] = Variable<String>(stateCode);
    }
    if (!nullToAbsent || districtCode != null) {
      map['district_code'] = Variable<String>(districtCode);
    }
    map['is_verified'] = Variable<bool>(isVerified);
    map['linked_at'] = Variable<DateTime>(linkedAt);
    if (!nullToAbsent || lastSyncedAt != null) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt);
    }
    return map;
  }

  AbhaLinksCompanion toCompanion(bool nullToAbsent) {
    return AbhaLinksCompanion(
      id: Value(id),
      userId: Value(userId),
      abhaNumber: Value(abhaNumber),
      abhaAddress: abhaAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(abhaAddress),
      firstName: firstName == null && nullToAbsent
          ? const Value.absent()
          : Value(firstName),
      lastName: lastName == null && nullToAbsent
          ? const Value.absent()
          : Value(lastName),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      stateCode: stateCode == null && nullToAbsent
          ? const Value.absent()
          : Value(stateCode),
      districtCode: districtCode == null && nullToAbsent
          ? const Value.absent()
          : Value(districtCode),
      isVerified: Value(isVerified),
      linkedAt: Value(linkedAt),
      lastSyncedAt: lastSyncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSyncedAt),
    );
  }

  factory AbhaLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbhaLink(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      abhaNumber: serializer.fromJson<String>(json['abhaNumber']),
      abhaAddress: serializer.fromJson<String?>(json['abhaAddress']),
      firstName: serializer.fromJson<String?>(json['firstName']),
      lastName: serializer.fromJson<String?>(json['lastName']),
      gender: serializer.fromJson<String?>(json['gender']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      stateCode: serializer.fromJson<String?>(json['stateCode']),
      districtCode: serializer.fromJson<String?>(json['districtCode']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      linkedAt: serializer.fromJson<DateTime>(json['linkedAt']),
      lastSyncedAt: serializer.fromJson<DateTime?>(json['lastSyncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'abhaNumber': serializer.toJson<String>(abhaNumber),
      'abhaAddress': serializer.toJson<String?>(abhaAddress),
      'firstName': serializer.toJson<String?>(firstName),
      'lastName': serializer.toJson<String?>(lastName),
      'gender': serializer.toJson<String?>(gender),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'stateCode': serializer.toJson<String?>(stateCode),
      'districtCode': serializer.toJson<String?>(districtCode),
      'isVerified': serializer.toJson<bool>(isVerified),
      'linkedAt': serializer.toJson<DateTime>(linkedAt),
      'lastSyncedAt': serializer.toJson<DateTime?>(lastSyncedAt),
    };
  }

  AbhaLink copyWith({
    int? id,
    String? userId,
    String? abhaNumber,
    Value<String?> abhaAddress = const Value.absent(),
    Value<String?> firstName = const Value.absent(),
    Value<String?> lastName = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<DateTime?> dateOfBirth = const Value.absent(),
    Value<String?> stateCode = const Value.absent(),
    Value<String?> districtCode = const Value.absent(),
    bool? isVerified,
    DateTime? linkedAt,
    Value<DateTime?> lastSyncedAt = const Value.absent(),
  }) => AbhaLink(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    abhaNumber: abhaNumber ?? this.abhaNumber,
    abhaAddress: abhaAddress.present ? abhaAddress.value : this.abhaAddress,
    firstName: firstName.present ? firstName.value : this.firstName,
    lastName: lastName.present ? lastName.value : this.lastName,
    gender: gender.present ? gender.value : this.gender,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    stateCode: stateCode.present ? stateCode.value : this.stateCode,
    districtCode: districtCode.present ? districtCode.value : this.districtCode,
    isVerified: isVerified ?? this.isVerified,
    linkedAt: linkedAt ?? this.linkedAt,
    lastSyncedAt: lastSyncedAt.present ? lastSyncedAt.value : this.lastSyncedAt,
  );
  AbhaLink copyWithCompanion(AbhaLinksCompanion data) {
    return AbhaLink(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      abhaNumber: data.abhaNumber.present
          ? data.abhaNumber.value
          : this.abhaNumber,
      abhaAddress: data.abhaAddress.present
          ? data.abhaAddress.value
          : this.abhaAddress,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      stateCode: data.stateCode.present ? data.stateCode.value : this.stateCode,
      districtCode: data.districtCode.present
          ? data.districtCode.value
          : this.districtCode,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      linkedAt: data.linkedAt.present ? data.linkedAt.value : this.linkedAt,
      lastSyncedAt: data.lastSyncedAt.present
          ? data.lastSyncedAt.value
          : this.lastSyncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbhaLink(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('abhaNumber: $abhaNumber, ')
          ..write('abhaAddress: $abhaAddress, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('stateCode: $stateCode, ')
          ..write('districtCode: $districtCode, ')
          ..write('isVerified: $isVerified, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    abhaNumber,
    abhaAddress,
    firstName,
    lastName,
    gender,
    dateOfBirth,
    stateCode,
    districtCode,
    isVerified,
    linkedAt,
    lastSyncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbhaLink &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.abhaNumber == this.abhaNumber &&
          other.abhaAddress == this.abhaAddress &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.stateCode == this.stateCode &&
          other.districtCode == this.districtCode &&
          other.isVerified == this.isVerified &&
          other.linkedAt == this.linkedAt &&
          other.lastSyncedAt == this.lastSyncedAt);
}

class AbhaLinksCompanion extends UpdateCompanion<AbhaLink> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> abhaNumber;
  final Value<String?> abhaAddress;
  final Value<String?> firstName;
  final Value<String?> lastName;
  final Value<String?> gender;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> stateCode;
  final Value<String?> districtCode;
  final Value<bool> isVerified;
  final Value<DateTime> linkedAt;
  final Value<DateTime?> lastSyncedAt;
  const AbhaLinksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.abhaNumber = const Value.absent(),
    this.abhaAddress = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.stateCode = const Value.absent(),
    this.districtCode = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.linkedAt = const Value.absent(),
    this.lastSyncedAt = const Value.absent(),
  });
  AbhaLinksCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String abhaNumber,
    this.abhaAddress = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.stateCode = const Value.absent(),
    this.districtCode = const Value.absent(),
    this.isVerified = const Value.absent(),
    required DateTime linkedAt,
    this.lastSyncedAt = const Value.absent(),
  }) : userId = Value(userId),
       abhaNumber = Value(abhaNumber),
       linkedAt = Value(linkedAt);
  static Insertable<AbhaLink> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? abhaNumber,
    Expression<String>? abhaAddress,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? stateCode,
    Expression<String>? districtCode,
    Expression<bool>? isVerified,
    Expression<DateTime>? linkedAt,
    Expression<DateTime>? lastSyncedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (abhaNumber != null) 'abha_number': abhaNumber,
      if (abhaAddress != null) 'abha_address': abhaAddress,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (stateCode != null) 'state_code': stateCode,
      if (districtCode != null) 'district_code': districtCode,
      if (isVerified != null) 'is_verified': isVerified,
      if (linkedAt != null) 'linked_at': linkedAt,
      if (lastSyncedAt != null) 'last_synced_at': lastSyncedAt,
    });
  }

  AbhaLinksCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? abhaNumber,
    Value<String?>? abhaAddress,
    Value<String?>? firstName,
    Value<String?>? lastName,
    Value<String?>? gender,
    Value<DateTime?>? dateOfBirth,
    Value<String?>? stateCode,
    Value<String?>? districtCode,
    Value<bool>? isVerified,
    Value<DateTime>? linkedAt,
    Value<DateTime?>? lastSyncedAt,
  }) {
    return AbhaLinksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      abhaNumber: abhaNumber ?? this.abhaNumber,
      abhaAddress: abhaAddress ?? this.abhaAddress,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      stateCode: stateCode ?? this.stateCode,
      districtCode: districtCode ?? this.districtCode,
      isVerified: isVerified ?? this.isVerified,
      linkedAt: linkedAt ?? this.linkedAt,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (abhaNumber.present) {
      map['abha_number'] = Variable<String>(abhaNumber.value);
    }
    if (abhaAddress.present) {
      map['abha_address'] = Variable<String>(abhaAddress.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (stateCode.present) {
      map['state_code'] = Variable<String>(stateCode.value);
    }
    if (districtCode.present) {
      map['district_code'] = Variable<String>(districtCode.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
    }
    if (linkedAt.present) {
      map['linked_at'] = Variable<DateTime>(linkedAt.value);
    }
    if (lastSyncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(lastSyncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AbhaLinksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('abhaNumber: $abhaNumber, ')
          ..write('abhaAddress: $abhaAddress, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('stateCode: $stateCode, ')
          ..write('districtCode: $districtCode, ')
          ..write('isVerified: $isVerified, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('lastSyncedAt: $lastSyncedAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odUserIdMeta = const VerificationMeta(
    'odUserId',
  );
  @override
  late final GeneratedColumn<String> odUserId = GeneratedColumn<String>(
    'od_user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fitnessGoalMeta = const VerificationMeta(
    'fitnessGoal',
  );
  @override
  late final GeneratedColumn<String> fitnessGoal = GeneratedColumn<String>(
    'fitness_goal',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityLevelMeta = const VerificationMeta(
    'activityLevel',
  );
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
    'activity_level',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 32,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chronicConditionsMeta = const VerificationMeta(
    'chronicConditions',
  );
  @override
  late final GeneratedColumn<String> chronicConditions =
      GeneratedColumn<String>(
        'chronic_conditions',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 512),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _vataPercentMeta = const VerificationMeta(
    'vataPercent',
  );
  @override
  late final GeneratedColumn<int> vataPercent = GeneratedColumn<int>(
    'vata_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pittaPercentMeta = const VerificationMeta(
    'pittaPercent',
  );
  @override
  late final GeneratedColumn<int> pittaPercent = GeneratedColumn<int>(
    'pitta_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kaphaPercentMeta = const VerificationMeta(
    'kaphaPercent',
  );
  @override
  late final GeneratedColumn<int> kaphaPercent = GeneratedColumn<int>(
    'kapha_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 2,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepCounterPermissionMeta =
      const VerificationMeta('stepCounterPermission');
  @override
  late final GeneratedColumn<bool> stepCounterPermission =
      GeneratedColumn<bool>(
        'step_counter_permission',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("step_counter_permission" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _heartRatePermissionMeta =
      const VerificationMeta('heartRatePermission');
  @override
  late final GeneratedColumn<bool> heartRatePermission = GeneratedColumn<bool>(
    'heart_rate_permission',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("heart_rate_permission" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sleepPermissionMeta = const VerificationMeta(
    'sleepPermission',
  );
  @override
  late final GeneratedColumn<bool> sleepPermission = GeneratedColumn<bool>(
    'sleep_permission',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sleep_permission" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _abhaNumberMeta = const VerificationMeta(
    'abhaNumber',
  );
  @override
  late final GeneratedColumn<String> abhaNumber = GeneratedColumn<String>(
    'abha_number',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wearableConnectedMeta = const VerificationMeta(
    'wearableConnected',
  );
  @override
  late final GeneratedColumn<bool> wearableConnected = GeneratedColumn<bool>(
    'wearable_connected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("wearable_connected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _karmaXpMeta = const VerificationMeta(
    'karmaXp',
  );
  @override
  late final GeneratedColumn<int> karmaXp = GeneratedColumn<int>(
    'karma_xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    odUserId,
    name,
    gender,
    dateOfBirth,
    heightCm,
    weightKg,
    fitnessGoal,
    activityLevel,
    chronicConditions,
    vataPercent,
    pittaPercent,
    kaphaPercent,
    language,
    stepCounterPermission,
    heartRatePermission,
    sleepPermission,
    abhaNumber,
    wearableConnected,
    karmaXp,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('od_user_id')) {
      context.handle(
        _odUserIdMeta,
        odUserId.isAcceptableOrUnknown(data['od_user_id']!, _odUserIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odUserIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('fitness_goal')) {
      context.handle(
        _fitnessGoalMeta,
        fitnessGoal.isAcceptableOrUnknown(
          data['fitness_goal']!,
          _fitnessGoalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fitnessGoalMeta);
    }
    if (data.containsKey('activity_level')) {
      context.handle(
        _activityLevelMeta,
        activityLevel.isAcceptableOrUnknown(
          data['activity_level']!,
          _activityLevelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityLevelMeta);
    }
    if (data.containsKey('chronic_conditions')) {
      context.handle(
        _chronicConditionsMeta,
        chronicConditions.isAcceptableOrUnknown(
          data['chronic_conditions']!,
          _chronicConditionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_chronicConditionsMeta);
    }
    if (data.containsKey('vata_percent')) {
      context.handle(
        _vataPercentMeta,
        vataPercent.isAcceptableOrUnknown(
          data['vata_percent']!,
          _vataPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_vataPercentMeta);
    }
    if (data.containsKey('pitta_percent')) {
      context.handle(
        _pittaPercentMeta,
        pittaPercent.isAcceptableOrUnknown(
          data['pitta_percent']!,
          _pittaPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pittaPercentMeta);
    }
    if (data.containsKey('kapha_percent')) {
      context.handle(
        _kaphaPercentMeta,
        kaphaPercent.isAcceptableOrUnknown(
          data['kapha_percent']!,
          _kaphaPercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kaphaPercentMeta);
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('step_counter_permission')) {
      context.handle(
        _stepCounterPermissionMeta,
        stepCounterPermission.isAcceptableOrUnknown(
          data['step_counter_permission']!,
          _stepCounterPermissionMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_permission')) {
      context.handle(
        _heartRatePermissionMeta,
        heartRatePermission.isAcceptableOrUnknown(
          data['heart_rate_permission']!,
          _heartRatePermissionMeta,
        ),
      );
    }
    if (data.containsKey('sleep_permission')) {
      context.handle(
        _sleepPermissionMeta,
        sleepPermission.isAcceptableOrUnknown(
          data['sleep_permission']!,
          _sleepPermissionMeta,
        ),
      );
    }
    if (data.containsKey('abha_number')) {
      context.handle(
        _abhaNumberMeta,
        abhaNumber.isAcceptableOrUnknown(data['abha_number']!, _abhaNumberMeta),
      );
    }
    if (data.containsKey('wearable_connected')) {
      context.handle(
        _wearableConnectedMeta,
        wearableConnected.isAcceptableOrUnknown(
          data['wearable_connected']!,
          _wearableConnectedMeta,
        ),
      );
    }
    if (data.containsKey('karma_xp')) {
      context.handle(
        _karmaXpMeta,
        karmaXp.isAcceptableOrUnknown(data['karma_xp']!, _karmaXpMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {odUserId},
  ];
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      odUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}od_user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      fitnessGoal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fitness_goal'],
      )!,
      activityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_level'],
      )!,
      chronicConditions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chronic_conditions'],
      )!,
      vataPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vata_percent'],
      )!,
      pittaPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pitta_percent'],
      )!,
      kaphaPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kapha_percent'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      stepCounterPermission: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}step_counter_permission'],
      )!,
      heartRatePermission: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}heart_rate_permission'],
      )!,
      sleepPermission: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sleep_permission'],
      )!,
      abhaNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abha_number'],
      ),
      wearableConnected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}wearable_connected'],
      )!,
      karmaXp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}karma_xp'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String odUserId;
  final String name;
  final String gender;
  final DateTime dateOfBirth;
  final double heightCm;
  final double weightKg;
  final String fitnessGoal;
  final String activityLevel;
  final String chronicConditions;
  final int vataPercent;
  final int pittaPercent;
  final int kaphaPercent;
  final String language;
  final bool stepCounterPermission;
  final bool heartRatePermission;
  final bool sleepPermission;
  final String? abhaNumber;
  final bool wearableConnected;
  final int karmaXp;
  final DateTime createdAt;
  final DateTime updatedAt;
  const UserProfile({
    required this.id,
    required this.odUserId,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.heightCm,
    required this.weightKg,
    required this.fitnessGoal,
    required this.activityLevel,
    required this.chronicConditions,
    required this.vataPercent,
    required this.pittaPercent,
    required this.kaphaPercent,
    required this.language,
    required this.stepCounterPermission,
    required this.heartRatePermission,
    required this.sleepPermission,
    this.abhaNumber,
    required this.wearableConnected,
    required this.karmaXp,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['od_user_id'] = Variable<String>(odUserId);
    map['name'] = Variable<String>(name);
    map['gender'] = Variable<String>(gender);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['height_cm'] = Variable<double>(heightCm);
    map['weight_kg'] = Variable<double>(weightKg);
    map['fitness_goal'] = Variable<String>(fitnessGoal);
    map['activity_level'] = Variable<String>(activityLevel);
    map['chronic_conditions'] = Variable<String>(chronicConditions);
    map['vata_percent'] = Variable<int>(vataPercent);
    map['pitta_percent'] = Variable<int>(pittaPercent);
    map['kapha_percent'] = Variable<int>(kaphaPercent);
    map['language'] = Variable<String>(language);
    map['step_counter_permission'] = Variable<bool>(stepCounterPermission);
    map['heart_rate_permission'] = Variable<bool>(heartRatePermission);
    map['sleep_permission'] = Variable<bool>(sleepPermission);
    if (!nullToAbsent || abhaNumber != null) {
      map['abha_number'] = Variable<String>(abhaNumber);
    }
    map['wearable_connected'] = Variable<bool>(wearableConnected);
    map['karma_xp'] = Variable<int>(karmaXp);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      odUserId: Value(odUserId),
      name: Value(name),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      fitnessGoal: Value(fitnessGoal),
      activityLevel: Value(activityLevel),
      chronicConditions: Value(chronicConditions),
      vataPercent: Value(vataPercent),
      pittaPercent: Value(pittaPercent),
      kaphaPercent: Value(kaphaPercent),
      language: Value(language),
      stepCounterPermission: Value(stepCounterPermission),
      heartRatePermission: Value(heartRatePermission),
      sleepPermission: Value(sleepPermission),
      abhaNumber: abhaNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(abhaNumber),
      wearableConnected: Value(wearableConnected),
      karmaXp: Value(karmaXp),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      odUserId: serializer.fromJson<String>(json['odUserId']),
      name: serializer.fromJson<String>(json['name']),
      gender: serializer.fromJson<String>(json['gender']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      fitnessGoal: serializer.fromJson<String>(json['fitnessGoal']),
      activityLevel: serializer.fromJson<String>(json['activityLevel']),
      chronicConditions: serializer.fromJson<String>(json['chronicConditions']),
      vataPercent: serializer.fromJson<int>(json['vataPercent']),
      pittaPercent: serializer.fromJson<int>(json['pittaPercent']),
      kaphaPercent: serializer.fromJson<int>(json['kaphaPercent']),
      language: serializer.fromJson<String>(json['language']),
      stepCounterPermission: serializer.fromJson<bool>(
        json['stepCounterPermission'],
      ),
      heartRatePermission: serializer.fromJson<bool>(
        json['heartRatePermission'],
      ),
      sleepPermission: serializer.fromJson<bool>(json['sleepPermission']),
      abhaNumber: serializer.fromJson<String?>(json['abhaNumber']),
      wearableConnected: serializer.fromJson<bool>(json['wearableConnected']),
      karmaXp: serializer.fromJson<int>(json['karmaXp']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'odUserId': serializer.toJson<String>(odUserId),
      'name': serializer.toJson<String>(name),
      'gender': serializer.toJson<String>(gender),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'heightCm': serializer.toJson<double>(heightCm),
      'weightKg': serializer.toJson<double>(weightKg),
      'fitnessGoal': serializer.toJson<String>(fitnessGoal),
      'activityLevel': serializer.toJson<String>(activityLevel),
      'chronicConditions': serializer.toJson<String>(chronicConditions),
      'vataPercent': serializer.toJson<int>(vataPercent),
      'pittaPercent': serializer.toJson<int>(pittaPercent),
      'kaphaPercent': serializer.toJson<int>(kaphaPercent),
      'language': serializer.toJson<String>(language),
      'stepCounterPermission': serializer.toJson<bool>(stepCounterPermission),
      'heartRatePermission': serializer.toJson<bool>(heartRatePermission),
      'sleepPermission': serializer.toJson<bool>(sleepPermission),
      'abhaNumber': serializer.toJson<String?>(abhaNumber),
      'wearableConnected': serializer.toJson<bool>(wearableConnected),
      'karmaXp': serializer.toJson<int>(karmaXp),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith({
    int? id,
    String? odUserId,
    String? name,
    String? gender,
    DateTime? dateOfBirth,
    double? heightCm,
    double? weightKg,
    String? fitnessGoal,
    String? activityLevel,
    String? chronicConditions,
    int? vataPercent,
    int? pittaPercent,
    int? kaphaPercent,
    String? language,
    bool? stepCounterPermission,
    bool? heartRatePermission,
    bool? sleepPermission,
    Value<String?> abhaNumber = const Value.absent(),
    bool? wearableConnected,
    int? karmaXp,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => UserProfile(
    id: id ?? this.id,
    odUserId: odUserId ?? this.odUserId,
    name: name ?? this.name,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    heightCm: heightCm ?? this.heightCm,
    weightKg: weightKg ?? this.weightKg,
    fitnessGoal: fitnessGoal ?? this.fitnessGoal,
    activityLevel: activityLevel ?? this.activityLevel,
    chronicConditions: chronicConditions ?? this.chronicConditions,
    vataPercent: vataPercent ?? this.vataPercent,
    pittaPercent: pittaPercent ?? this.pittaPercent,
    kaphaPercent: kaphaPercent ?? this.kaphaPercent,
    language: language ?? this.language,
    stepCounterPermission: stepCounterPermission ?? this.stepCounterPermission,
    heartRatePermission: heartRatePermission ?? this.heartRatePermission,
    sleepPermission: sleepPermission ?? this.sleepPermission,
    abhaNumber: abhaNumber.present ? abhaNumber.value : this.abhaNumber,
    wearableConnected: wearableConnected ?? this.wearableConnected,
    karmaXp: karmaXp ?? this.karmaXp,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      odUserId: data.odUserId.present ? data.odUserId.value : this.odUserId,
      name: data.name.present ? data.name.value : this.name,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      fitnessGoal: data.fitnessGoal.present
          ? data.fitnessGoal.value
          : this.fitnessGoal,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
      chronicConditions: data.chronicConditions.present
          ? data.chronicConditions.value
          : this.chronicConditions,
      vataPercent: data.vataPercent.present
          ? data.vataPercent.value
          : this.vataPercent,
      pittaPercent: data.pittaPercent.present
          ? data.pittaPercent.value
          : this.pittaPercent,
      kaphaPercent: data.kaphaPercent.present
          ? data.kaphaPercent.value
          : this.kaphaPercent,
      language: data.language.present ? data.language.value : this.language,
      stepCounterPermission: data.stepCounterPermission.present
          ? data.stepCounterPermission.value
          : this.stepCounterPermission,
      heartRatePermission: data.heartRatePermission.present
          ? data.heartRatePermission.value
          : this.heartRatePermission,
      sleepPermission: data.sleepPermission.present
          ? data.sleepPermission.value
          : this.sleepPermission,
      abhaNumber: data.abhaNumber.present
          ? data.abhaNumber.value
          : this.abhaNumber,
      wearableConnected: data.wearableConnected.present
          ? data.wearableConnected.value
          : this.wearableConnected,
      karmaXp: data.karmaXp.present ? data.karmaXp.value : this.karmaXp,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('odUserId: $odUserId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('fitnessGoal: $fitnessGoal, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('chronicConditions: $chronicConditions, ')
          ..write('vataPercent: $vataPercent, ')
          ..write('pittaPercent: $pittaPercent, ')
          ..write('kaphaPercent: $kaphaPercent, ')
          ..write('language: $language, ')
          ..write('stepCounterPermission: $stepCounterPermission, ')
          ..write('heartRatePermission: $heartRatePermission, ')
          ..write('sleepPermission: $sleepPermission, ')
          ..write('abhaNumber: $abhaNumber, ')
          ..write('wearableConnected: $wearableConnected, ')
          ..write('karmaXp: $karmaXp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    odUserId,
    name,
    gender,
    dateOfBirth,
    heightCm,
    weightKg,
    fitnessGoal,
    activityLevel,
    chronicConditions,
    vataPercent,
    pittaPercent,
    kaphaPercent,
    language,
    stepCounterPermission,
    heartRatePermission,
    sleepPermission,
    abhaNumber,
    wearableConnected,
    karmaXp,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.odUserId == this.odUserId &&
          other.name == this.name &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.fitnessGoal == this.fitnessGoal &&
          other.activityLevel == this.activityLevel &&
          other.chronicConditions == this.chronicConditions &&
          other.vataPercent == this.vataPercent &&
          other.pittaPercent == this.pittaPercent &&
          other.kaphaPercent == this.kaphaPercent &&
          other.language == this.language &&
          other.stepCounterPermission == this.stepCounterPermission &&
          other.heartRatePermission == this.heartRatePermission &&
          other.sleepPermission == this.sleepPermission &&
          other.abhaNumber == this.abhaNumber &&
          other.wearableConnected == this.wearableConnected &&
          other.karmaXp == this.karmaXp &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> odUserId;
  final Value<String> name;
  final Value<String> gender;
  final Value<DateTime> dateOfBirth;
  final Value<double> heightCm;
  final Value<double> weightKg;
  final Value<String> fitnessGoal;
  final Value<String> activityLevel;
  final Value<String> chronicConditions;
  final Value<int> vataPercent;
  final Value<int> pittaPercent;
  final Value<int> kaphaPercent;
  final Value<String> language;
  final Value<bool> stepCounterPermission;
  final Value<bool> heartRatePermission;
  final Value<bool> sleepPermission;
  final Value<String?> abhaNumber;
  final Value<bool> wearableConnected;
  final Value<int> karmaXp;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.odUserId = const Value.absent(),
    this.name = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.fitnessGoal = const Value.absent(),
    this.activityLevel = const Value.absent(),
    this.chronicConditions = const Value.absent(),
    this.vataPercent = const Value.absent(),
    this.pittaPercent = const Value.absent(),
    this.kaphaPercent = const Value.absent(),
    this.language = const Value.absent(),
    this.stepCounterPermission = const Value.absent(),
    this.heartRatePermission = const Value.absent(),
    this.sleepPermission = const Value.absent(),
    this.abhaNumber = const Value.absent(),
    this.wearableConnected = const Value.absent(),
    this.karmaXp = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String odUserId,
    required String name,
    required String gender,
    required DateTime dateOfBirth,
    required double heightCm,
    required double weightKg,
    required String fitnessGoal,
    required String activityLevel,
    required String chronicConditions,
    required int vataPercent,
    required int pittaPercent,
    required int kaphaPercent,
    required String language,
    this.stepCounterPermission = const Value.absent(),
    this.heartRatePermission = const Value.absent(),
    this.sleepPermission = const Value.absent(),
    this.abhaNumber = const Value.absent(),
    this.wearableConnected = const Value.absent(),
    this.karmaXp = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : odUserId = Value(odUserId),
       name = Value(name),
       gender = Value(gender),
       dateOfBirth = Value(dateOfBirth),
       heightCm = Value(heightCm),
       weightKg = Value(weightKg),
       fitnessGoal = Value(fitnessGoal),
       activityLevel = Value(activityLevel),
       chronicConditions = Value(chronicConditions),
       vataPercent = Value(vataPercent),
       pittaPercent = Value(pittaPercent),
       kaphaPercent = Value(kaphaPercent),
       language = Value(language),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? odUserId,
    Expression<String>? name,
    Expression<String>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<String>? fitnessGoal,
    Expression<String>? activityLevel,
    Expression<String>? chronicConditions,
    Expression<int>? vataPercent,
    Expression<int>? pittaPercent,
    Expression<int>? kaphaPercent,
    Expression<String>? language,
    Expression<bool>? stepCounterPermission,
    Expression<bool>? heartRatePermission,
    Expression<bool>? sleepPermission,
    Expression<String>? abhaNumber,
    Expression<bool>? wearableConnected,
    Expression<int>? karmaXp,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (odUserId != null) 'od_user_id': odUserId,
      if (name != null) 'name': name,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (fitnessGoal != null) 'fitness_goal': fitnessGoal,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (chronicConditions != null) 'chronic_conditions': chronicConditions,
      if (vataPercent != null) 'vata_percent': vataPercent,
      if (pittaPercent != null) 'pitta_percent': pittaPercent,
      if (kaphaPercent != null) 'kapha_percent': kaphaPercent,
      if (language != null) 'language': language,
      if (stepCounterPermission != null)
        'step_counter_permission': stepCounterPermission,
      if (heartRatePermission != null)
        'heart_rate_permission': heartRatePermission,
      if (sleepPermission != null) 'sleep_permission': sleepPermission,
      if (abhaNumber != null) 'abha_number': abhaNumber,
      if (wearableConnected != null) 'wearable_connected': wearableConnected,
      if (karmaXp != null) 'karma_xp': karmaXp,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? odUserId,
    Value<String>? name,
    Value<String>? gender,
    Value<DateTime>? dateOfBirth,
    Value<double>? heightCm,
    Value<double>? weightKg,
    Value<String>? fitnessGoal,
    Value<String>? activityLevel,
    Value<String>? chronicConditions,
    Value<int>? vataPercent,
    Value<int>? pittaPercent,
    Value<int>? kaphaPercent,
    Value<String>? language,
    Value<bool>? stepCounterPermission,
    Value<bool>? heartRatePermission,
    Value<bool>? sleepPermission,
    Value<String?>? abhaNumber,
    Value<bool>? wearableConnected,
    Value<int>? karmaXp,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      odUserId: odUserId ?? this.odUserId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      activityLevel: activityLevel ?? this.activityLevel,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      vataPercent: vataPercent ?? this.vataPercent,
      pittaPercent: pittaPercent ?? this.pittaPercent,
      kaphaPercent: kaphaPercent ?? this.kaphaPercent,
      language: language ?? this.language,
      stepCounterPermission:
          stepCounterPermission ?? this.stepCounterPermission,
      heartRatePermission: heartRatePermission ?? this.heartRatePermission,
      sleepPermission: sleepPermission ?? this.sleepPermission,
      abhaNumber: abhaNumber ?? this.abhaNumber,
      wearableConnected: wearableConnected ?? this.wearableConnected,
      karmaXp: karmaXp ?? this.karmaXp,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (odUserId.present) {
      map['od_user_id'] = Variable<String>(odUserId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (fitnessGoal.present) {
      map['fitness_goal'] = Variable<String>(fitnessGoal.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    if (chronicConditions.present) {
      map['chronic_conditions'] = Variable<String>(chronicConditions.value);
    }
    if (vataPercent.present) {
      map['vata_percent'] = Variable<int>(vataPercent.value);
    }
    if (pittaPercent.present) {
      map['pitta_percent'] = Variable<int>(pittaPercent.value);
    }
    if (kaphaPercent.present) {
      map['kapha_percent'] = Variable<int>(kaphaPercent.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (stepCounterPermission.present) {
      map['step_counter_permission'] = Variable<bool>(
        stepCounterPermission.value,
      );
    }
    if (heartRatePermission.present) {
      map['heart_rate_permission'] = Variable<bool>(heartRatePermission.value);
    }
    if (sleepPermission.present) {
      map['sleep_permission'] = Variable<bool>(sleepPermission.value);
    }
    if (abhaNumber.present) {
      map['abha_number'] = Variable<String>(abhaNumber.value);
    }
    if (wearableConnected.present) {
      map['wearable_connected'] = Variable<bool>(wearableConnected.value);
    }
    if (karmaXp.present) {
      map['karma_xp'] = Variable<int>(karmaXp.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('odUserId: $odUserId, ')
          ..write('name: $name, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('fitnessGoal: $fitnessGoal, ')
          ..write('activityLevel: $activityLevel, ')
          ..write('chronicConditions: $chronicConditions, ')
          ..write('vataPercent: $vataPercent, ')
          ..write('pittaPercent: $pittaPercent, ')
          ..write('kaphaPercent: $kaphaPercent, ')
          ..write('language: $language, ')
          ..write('stepCounterPermission: $stepCounterPermission, ')
          ..write('heartRatePermission: $heartRatePermission, ')
          ..write('sleepPermission: $sleepPermission, ')
          ..write('abhaNumber: $abhaNumber, ')
          ..write('wearableConnected: $wearableConnected, ')
          ..write('karmaXp: $karmaXp, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $EmergencyCardTable extends EmergencyCard
    with TableInfo<$EmergencyCardTable, EmergencyCardData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyCardTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bloodGroupMeta = const VerificationMeta(
    'bloodGroup',
  );
  @override
  late final GeneratedColumn<String> bloodGroup = GeneratedColumn<String>(
    'blood_group',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 8),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1024),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyContactMeta = const VerificationMeta(
    'emergencyContact',
  );
  @override
  late final GeneratedColumn<String> emergencyContact = GeneratedColumn<String>(
    'emergency_contact',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionsMeta = const VerificationMeta(
    'conditions',
  );
  @override
  late final GeneratedColumn<String> conditions = GeneratedColumn<String>(
    'conditions',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1024),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    bloodGroup,
    allergies,
    emergencyContact,
    conditions,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_card';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyCardData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('blood_group')) {
      context.handle(
        _bloodGroupMeta,
        bloodGroup.isAcceptableOrUnknown(data['blood_group']!, _bloodGroupMeta),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('emergency_contact')) {
      context.handle(
        _emergencyContactMeta,
        emergencyContact.isAcceptableOrUnknown(
          data['emergency_contact']!,
          _emergencyContactMeta,
        ),
      );
    }
    if (data.containsKey('conditions')) {
      context.handle(
        _conditionsMeta,
        conditions.isAcceptableOrUnknown(data['conditions']!, _conditionsMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {userId},
  ];
  @override
  EmergencyCardData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyCardData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      bloodGroup: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_group'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      emergencyContact: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact'],
      ),
      conditions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conditions'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EmergencyCardTable createAlias(String alias) {
    return $EmergencyCardTable(attachedDatabase, alias);
  }
}

class EmergencyCardData extends DataClass
    implements Insertable<EmergencyCardData> {
  final int id;
  final String userId;
  final String? bloodGroup;
  final String? allergies;
  final String? emergencyContact;
  final String? conditions;
  final DateTime updatedAt;
  const EmergencyCardData({
    required this.id,
    required this.userId,
    this.bloodGroup,
    this.allergies,
    this.emergencyContact,
    this.conditions,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || bloodGroup != null) {
      map['blood_group'] = Variable<String>(bloodGroup);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || emergencyContact != null) {
      map['emergency_contact'] = Variable<String>(emergencyContact);
    }
    if (!nullToAbsent || conditions != null) {
      map['conditions'] = Variable<String>(conditions);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmergencyCardCompanion toCompanion(bool nullToAbsent) {
    return EmergencyCardCompanion(
      id: Value(id),
      userId: Value(userId),
      bloodGroup: bloodGroup == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodGroup),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      emergencyContact: emergencyContact == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContact),
      conditions: conditions == null && nullToAbsent
          ? const Value.absent()
          : Value(conditions),
      updatedAt: Value(updatedAt),
    );
  }

  factory EmergencyCardData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyCardData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      bloodGroup: serializer.fromJson<String?>(json['bloodGroup']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      emergencyContact: serializer.fromJson<String?>(json['emergencyContact']),
      conditions: serializer.fromJson<String?>(json['conditions']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'bloodGroup': serializer.toJson<String?>(bloodGroup),
      'allergies': serializer.toJson<String?>(allergies),
      'emergencyContact': serializer.toJson<String?>(emergencyContact),
      'conditions': serializer.toJson<String?>(conditions),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EmergencyCardData copyWith({
    int? id,
    String? userId,
    Value<String?> bloodGroup = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> emergencyContact = const Value.absent(),
    Value<String?> conditions = const Value.absent(),
    DateTime? updatedAt,
  }) => EmergencyCardData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    bloodGroup: bloodGroup.present ? bloodGroup.value : this.bloodGroup,
    allergies: allergies.present ? allergies.value : this.allergies,
    emergencyContact: emergencyContact.present
        ? emergencyContact.value
        : this.emergencyContact,
    conditions: conditions.present ? conditions.value : this.conditions,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EmergencyCardData copyWithCompanion(EmergencyCardCompanion data) {
    return EmergencyCardData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      bloodGroup: data.bloodGroup.present
          ? data.bloodGroup.value
          : this.bloodGroup,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      emergencyContact: data.emergencyContact.present
          ? data.emergencyContact.value
          : this.emergencyContact,
      conditions: data.conditions.present
          ? data.conditions.value
          : this.conditions,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyCardData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('allergies: $allergies, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('conditions: $conditions, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    bloodGroup,
    allergies,
    emergencyContact,
    conditions,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyCardData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.bloodGroup == this.bloodGroup &&
          other.allergies == this.allergies &&
          other.emergencyContact == this.emergencyContact &&
          other.conditions == this.conditions &&
          other.updatedAt == this.updatedAt);
}

class EmergencyCardCompanion extends UpdateCompanion<EmergencyCardData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String?> bloodGroup;
  final Value<String?> allergies;
  final Value<String?> emergencyContact;
  final Value<String?> conditions;
  final Value<DateTime> updatedAt;
  const EmergencyCardCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.bloodGroup = const Value.absent(),
    this.allergies = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.conditions = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmergencyCardCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.bloodGroup = const Value.absent(),
    this.allergies = const Value.absent(),
    this.emergencyContact = const Value.absent(),
    this.conditions = const Value.absent(),
    required DateTime updatedAt,
  }) : userId = Value(userId),
       updatedAt = Value(updatedAt);
  static Insertable<EmergencyCardData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? bloodGroup,
    Expression<String>? allergies,
    Expression<String>? emergencyContact,
    Expression<String>? conditions,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (bloodGroup != null) 'blood_group': bloodGroup,
      if (allergies != null) 'allergies': allergies,
      if (emergencyContact != null) 'emergency_contact': emergencyContact,
      if (conditions != null) 'conditions': conditions,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmergencyCardCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String?>? bloodGroup,
    Value<String?>? allergies,
    Value<String?>? emergencyContact,
    Value<String?>? conditions,
    Value<DateTime>? updatedAt,
  }) {
    return EmergencyCardCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      conditions: conditions ?? this.conditions,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (bloodGroup.present) {
      map['blood_group'] = Variable<String>(bloodGroup.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (emergencyContact.present) {
      map['emergency_contact'] = Variable<String>(emergencyContact.value);
    }
    if (conditions.present) {
      map['conditions'] = Variable<String>(conditions.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyCardCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('bloodGroup: $bloodGroup, ')
          ..write('allergies: $allergies, ')
          ..write('emergencyContact: $emergencyContact, ')
          ..write('conditions: $conditions, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FestivalCalendarTable extends FestivalCalendar
    with TableInfo<$FestivalCalendarTable, FestivalCalendarData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FestivalCalendarTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 128,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 64),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 32),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, date, region, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'festival_calendar';
  @override
  VerificationContext validateIntegrity(
    Insertable<FestivalCalendarData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FestivalCalendarData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FestivalCalendarData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
    );
  }

  @override
  $FestivalCalendarTable createAlias(String alias) {
    return $FestivalCalendarTable(attachedDatabase, alias);
  }
}

class FestivalCalendarData extends DataClass
    implements Insertable<FestivalCalendarData> {
  final int id;
  final String name;
  final DateTime date;
  final String? region;
  final String? type;
  const FestivalCalendarData({
    required this.id,
    required this.name,
    required this.date,
    this.region,
    this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    return map;
  }

  FestivalCalendarCompanion toCompanion(bool nullToAbsent) {
    return FestivalCalendarCompanion(
      id: Value(id),
      name: Value(name),
      date: Value(date),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
    );
  }

  factory FestivalCalendarData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FestivalCalendarData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime>(json['date']),
      region: serializer.fromJson<String?>(json['region']),
      type: serializer.fromJson<String?>(json['type']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime>(date),
      'region': serializer.toJson<String?>(region),
      'type': serializer.toJson<String?>(type),
    };
  }

  FestivalCalendarData copyWith({
    int? id,
    String? name,
    DateTime? date,
    Value<String?> region = const Value.absent(),
    Value<String?> type = const Value.absent(),
  }) => FestivalCalendarData(
    id: id ?? this.id,
    name: name ?? this.name,
    date: date ?? this.date,
    region: region.present ? region.value : this.region,
    type: type.present ? type.value : this.type,
  );
  FestivalCalendarData copyWithCompanion(FestivalCalendarCompanion data) {
    return FestivalCalendarData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      date: data.date.present ? data.date.value : this.date,
      region: data.region.present ? data.region.value : this.region,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FestivalCalendarData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('region: $region, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, date, region, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FestivalCalendarData &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.region == this.region &&
          other.type == this.type);
}

class FestivalCalendarCompanion extends UpdateCompanion<FestivalCalendarData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> date;
  final Value<String?> region;
  final Value<String?> type;
  const FestivalCalendarCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.region = const Value.absent(),
    this.type = const Value.absent(),
  });
  FestivalCalendarCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime date,
    this.region = const Value.absent(),
    this.type = const Value.absent(),
  }) : name = Value(name),
       date = Value(date);
  static Insertable<FestivalCalendarData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? date,
    Expression<String>? region,
    Expression<String>? type,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (region != null) 'region': region,
      if (type != null) 'type': type,
    });
  }

  FestivalCalendarCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? date,
    Value<String?>? region,
    Value<String?>? type,
  }) {
    return FestivalCalendarCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      region: region ?? this.region,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FestivalCalendarCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('region: $region, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recordTableMeta = const VerificationMeta(
    'recordTable',
  );
  @override
  late final GeneratedColumn<String> recordTable = GeneratedColumn<String>(
    'record_table',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 512),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordTable,
    recordId,
    operation,
    payloadJson,
    createdAt,
    retryCount,
    status,
    priority,
    idempotencyKey,
    errorMessage,
    lastAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_table')) {
      context.handle(
        _recordTableMeta,
        recordTable.isAcceptableOrUnknown(
          data['record_table']!,
          _recordTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recordTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String recordTable;
  final int recordId;
  final String operation;
  final String payloadJson;
  final DateTime createdAt;
  final int retryCount;
  final String status;
  final int priority;
  final String idempotencyKey;
  final String? errorMessage;
  final DateTime? lastAttemptAt;
  const SyncQueueData({
    required this.id,
    required this.recordTable,
    required this.recordId,
    required this.operation,
    required this.payloadJson,
    required this.createdAt,
    required this.retryCount,
    required this.status,
    required this.priority,
    required this.idempotencyKey,
    this.errorMessage,
    this.lastAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_table'] = Variable<String>(recordTable);
    map['record_id'] = Variable<int>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<int>(priority);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      recordTable: Value(recordTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      status: Value(status),
      priority: Value(priority),
      idempotencyKey: Value(idempotencyKey),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      recordTable: serializer.fromJson<String>(json['recordTable']),
      recordId: serializer.fromJson<int>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<int>(json['priority']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordTable': serializer.toJson<String>(recordTable),
      'recordId': serializer.toJson<int>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<int>(priority),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? recordTable,
    int? recordId,
    String? operation,
    String? payloadJson,
    DateTime? createdAt,
    int? retryCount,
    String? status,
    int? priority,
    String? idempotencyKey,
    Value<String?> errorMessage = const Value.absent(),
    Value<DateTime?> lastAttemptAt = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    recordTable: recordTable ?? this.recordTable,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      recordTable: data.recordTable.present
          ? data.recordTable.value
          : this.recordTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordTable,
    recordId,
    operation,
    payloadJson,
    createdAt,
    retryCount,
    status,
    priority,
    idempotencyKey,
    errorMessage,
    lastAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.recordTable == this.recordTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.idempotencyKey == this.idempotencyKey &&
          other.errorMessage == this.errorMessage &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> recordTable;
  final Value<int> recordId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<String> status;
  final Value<int> priority;
  final Value<String> idempotencyKey;
  final Value<String?> errorMessage;
  final Value<DateTime?> lastAttemptAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.recordTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String recordTable,
    required int recordId,
    required String operation,
    required String payloadJson,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    required String status,
    this.priority = const Value.absent(),
    required String idempotencyKey,
    this.errorMessage = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  }) : recordTable = Value(recordTable),
       recordId = Value(recordId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt),
       status = Value(status),
       idempotencyKey = Value(idempotencyKey);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? recordTable,
    Expression<int>? recordId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? status,
    Expression<int>? priority,
    Expression<String>? idempotencyKey,
    Expression<String>? errorMessage,
    Expression<DateTime>? lastAttemptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordTable != null) 'record_table': recordTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (errorMessage != null) 'error_message': errorMessage,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? recordTable,
    Value<int>? recordId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<String>? status,
    Value<int>? priority,
    Value<String>? idempotencyKey,
    Value<String?>? errorMessage,
    Value<DateTime?>? lastAttemptAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      recordTable: recordTable ?? this.recordTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      errorMessage: errorMessage ?? this.errorMessage,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordTable.present) {
      map['record_table'] = Variable<String>(recordTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }
}

class $SyncDeadLetterTable extends SyncDeadLetter
    with TableInfo<$SyncDeadLetterTable, SyncDeadLetterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncDeadLetterTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _recordTableMeta = const VerificationMeta(
    'recordTable',
  );
  @override
  late final GeneratedColumn<String> recordTable = GeneratedColumn<String>(
    'record_table',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 16,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMeta = const VerificationMeta('error');
  @override
  late final GeneratedColumn<String> error = GeneratedColumn<String>(
    'error',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _failedAtMeta = const VerificationMeta(
    'failedAt',
  );
  @override
  late final GeneratedColumn<DateTime> failedAt = GeneratedColumn<DateTime>(
    'failed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordTable,
    recordId,
    operation,
    payloadJson,
    error,
    failedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_dead_letter';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncDeadLetterData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('record_table')) {
      context.handle(
        _recordTableMeta,
        recordTable.isAcceptableOrUnknown(
          data['record_table']!,
          _recordTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('error')) {
      context.handle(
        _errorMeta,
        error.isAcceptableOrUnknown(data['error']!, _errorMeta),
      );
    } else if (isInserting) {
      context.missing(_errorMeta);
    }
    if (data.containsKey('failed_at')) {
      context.handle(
        _failedAtMeta,
        failedAt.isAcceptableOrUnknown(data['failed_at']!, _failedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_failedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncDeadLetterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncDeadLetterData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      recordTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      error: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error'],
      )!,
      failedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}failed_at'],
      )!,
    );
  }

  @override
  $SyncDeadLetterTable createAlias(String alias) {
    return $SyncDeadLetterTable(attachedDatabase, alias);
  }
}

class SyncDeadLetterData extends DataClass
    implements Insertable<SyncDeadLetterData> {
  final int id;
  final String recordTable;
  final int recordId;
  final String operation;
  final String payloadJson;
  final String error;
  final DateTime failedAt;
  const SyncDeadLetterData({
    required this.id,
    required this.recordTable,
    required this.recordId,
    required this.operation,
    required this.payloadJson,
    required this.error,
    required this.failedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['record_table'] = Variable<String>(recordTable);
    map['record_id'] = Variable<int>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload_json'] = Variable<String>(payloadJson);
    map['error'] = Variable<String>(error);
    map['failed_at'] = Variable<DateTime>(failedAt);
    return map;
  }

  SyncDeadLetterCompanion toCompanion(bool nullToAbsent) {
    return SyncDeadLetterCompanion(
      id: Value(id),
      recordTable: Value(recordTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payloadJson: Value(payloadJson),
      error: Value(error),
      failedAt: Value(failedAt),
    );
  }

  factory SyncDeadLetterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncDeadLetterData(
      id: serializer.fromJson<int>(json['id']),
      recordTable: serializer.fromJson<String>(json['recordTable']),
      recordId: serializer.fromJson<int>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      error: serializer.fromJson<String>(json['error']),
      failedAt: serializer.fromJson<DateTime>(json['failedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'recordTable': serializer.toJson<String>(recordTable),
      'recordId': serializer.toJson<int>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'error': serializer.toJson<String>(error),
      'failedAt': serializer.toJson<DateTime>(failedAt),
    };
  }

  SyncDeadLetterData copyWith({
    int? id,
    String? recordTable,
    int? recordId,
    String? operation,
    String? payloadJson,
    String? error,
    DateTime? failedAt,
  }) => SyncDeadLetterData(
    id: id ?? this.id,
    recordTable: recordTable ?? this.recordTable,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payloadJson: payloadJson ?? this.payloadJson,
    error: error ?? this.error,
    failedAt: failedAt ?? this.failedAt,
  );
  SyncDeadLetterData copyWithCompanion(SyncDeadLetterCompanion data) {
    return SyncDeadLetterData(
      id: data.id.present ? data.id.value : this.id,
      recordTable: data.recordTable.present
          ? data.recordTable.value
          : this.recordTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      error: data.error.present ? data.error.value : this.error,
      failedAt: data.failedAt.present ? data.failedAt.value : this.failedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncDeadLetterData(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('error: $error, ')
          ..write('failedAt: $failedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordTable,
    recordId,
    operation,
    payloadJson,
    error,
    failedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncDeadLetterData &&
          other.id == this.id &&
          other.recordTable == this.recordTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payloadJson == this.payloadJson &&
          other.error == this.error &&
          other.failedAt == this.failedAt);
}

class SyncDeadLetterCompanion extends UpdateCompanion<SyncDeadLetterData> {
  final Value<int> id;
  final Value<String> recordTable;
  final Value<int> recordId;
  final Value<String> operation;
  final Value<String> payloadJson;
  final Value<String> error;
  final Value<DateTime> failedAt;
  const SyncDeadLetterCompanion({
    this.id = const Value.absent(),
    this.recordTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.error = const Value.absent(),
    this.failedAt = const Value.absent(),
  });
  SyncDeadLetterCompanion.insert({
    this.id = const Value.absent(),
    required String recordTable,
    required int recordId,
    required String operation,
    required String payloadJson,
    required String error,
    required DateTime failedAt,
  }) : recordTable = Value(recordTable),
       recordId = Value(recordId),
       operation = Value(operation),
       payloadJson = Value(payloadJson),
       error = Value(error),
       failedAt = Value(failedAt);
  static Insertable<SyncDeadLetterData> custom({
    Expression<int>? id,
    Expression<String>? recordTable,
    Expression<int>? recordId,
    Expression<String>? operation,
    Expression<String>? payloadJson,
    Expression<String>? error,
    Expression<DateTime>? failedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordTable != null) 'record_table': recordTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (error != null) 'error': error,
      if (failedAt != null) 'failed_at': failedAt,
    });
  }

  SyncDeadLetterCompanion copyWith({
    Value<int>? id,
    Value<String>? recordTable,
    Value<int>? recordId,
    Value<String>? operation,
    Value<String>? payloadJson,
    Value<String>? error,
    Value<DateTime>? failedAt,
  }) {
    return SyncDeadLetterCompanion(
      id: id ?? this.id,
      recordTable: recordTable ?? this.recordTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payloadJson: payloadJson ?? this.payloadJson,
      error: error ?? this.error,
      failedAt: failedAt ?? this.failedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (recordTable.present) {
      map['record_table'] = Variable<String>(recordTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (error.present) {
      map['error'] = Variable<String>(error.value);
    }
    if (failedAt.present) {
      map['failed_at'] = Variable<DateTime>(failedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncDeadLetterCompanion(')
          ..write('id: $id, ')
          ..write('recordTable: $recordTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('error: $error, ')
          ..write('failedAt: $failedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsFtsTable extends FoodItemsFts
    with TableInfo<$FoodItemsFtsTable, FoodItemsFt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsFtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _rowidMeta = const VerificationMeta('rowid');
  @override
  late final GeneratedColumn<int> rowid = GeneratedColumn<int>(
    'rowid',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<double> caloriesPer100g = GeneratedColumn<double>(
    'calories_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    rowid,
    name,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items_fts';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItemsFt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('rowid')) {
      context.handle(
        _rowidMeta,
        rowid.isAcceptableOrUnknown(data['rowid']!, _rowidMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {rowid};
  @override
  FoodItemsFt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItemsFt(
      rowid: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rowid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calories_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
    );
  }

  @override
  $FoodItemsFtsTable createAlias(String alias) {
    return $FoodItemsFtsTable(attachedDatabase, alias);
  }
}

class FoodItemsFt extends DataClass implements Insertable<FoodItemsFt> {
  final int rowid;
  final String name;
  final double caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  const FoodItemsFt({
    required this.rowid,
    required this.name,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['rowid'] = Variable<int>(rowid);
    map['name'] = Variable<String>(name);
    map['calories_per100g'] = Variable<double>(caloriesPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    return map;
  }

  FoodItemsFtsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsFtsCompanion(
      rowid: Value(rowid),
      name: Value(name),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
    );
  }

  factory FoodItemsFt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItemsFt(
      rowid: serializer.fromJson<int>(json['rowid']),
      name: serializer.fromJson<String>(json['name']),
      caloriesPer100g: serializer.fromJson<double>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'rowid': serializer.toJson<int>(rowid),
      'name': serializer.toJson<String>(name),
      'caloriesPer100g': serializer.toJson<double>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
    };
  }

  FoodItemsFt copyWith({
    int? rowid,
    String? name,
    double? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
  }) => FoodItemsFt(
    rowid: rowid ?? this.rowid,
    name: name ?? this.name,
    caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
  );
  FoodItemsFt copyWithCompanion(FoodItemsFtsCompanion data) {
    return FoodItemsFt(
      rowid: data.rowid.present ? data.rowid.value : this.rowid,
      name: data.name.present ? data.name.value : this.name,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsFt(')
          ..write('rowid: $rowid, ')
          ..write('name: $name, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    rowid,
    name,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItemsFt &&
          other.rowid == this.rowid &&
          other.name == this.name &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g);
}

class FoodItemsFtsCompanion extends UpdateCompanion<FoodItemsFt> {
  final Value<int> rowid;
  final Value<String> name;
  final Value<double> caloriesPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  const FoodItemsFtsCompanion({
    this.rowid = const Value.absent(),
    this.name = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
  });
  FoodItemsFtsCompanion.insert({
    this.rowid = const Value.absent(),
    required String name,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
  }) : name = Value(name),
       caloriesPer100g = Value(caloriesPer100g),
       proteinPer100g = Value(proteinPer100g),
       carbsPer100g = Value(carbsPer100g),
       fatPer100g = Value(fatPer100g);
  static Insertable<FoodItemsFt> custom({
    Expression<int>? rowid,
    Expression<String>? name,
    Expression<double>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
  }) {
    return RawValuesInsertable({
      if (rowid != null) 'rowid': rowid,
      if (name != null) 'name': name,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
    });
  }

  FoodItemsFtsCompanion copyWith({
    Value<int>? rowid,
    Value<String>? name,
    Value<double>? caloriesPer100g,
    Value<double>? proteinPer100g,
    Value<double>? carbsPer100g,
    Value<double>? fatPer100g,
  }) {
    return FoodItemsFtsCompanion(
      rowid: rowid ?? this.rowid,
      name: name ?? this.name,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodItemsFtsCompanion(')
          ..write('rowid: $rowid, ')
          ..write('name: $name, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g')
          ..write(')'))
        .toString();
  }
}

class $InsightFeedbackTable extends InsightFeedback
    with TableInfo<$InsightFeedbackTable, InsightFeedbackData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InsightFeedbackTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _odUserIdMeta = const VerificationMeta(
    'odUserId',
  );
  @override
  late final GeneratedColumn<String> odUserId = GeneratedColumn<String>(
    'od_user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ruleIdMeta = const VerificationMeta('ruleId');
  @override
  late final GeneratedColumn<String> ruleId = GeneratedColumn<String>(
    'rule_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 64,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _thumbsUpMeta = const VerificationMeta(
    'thumbsUp',
  );
  @override
  late final GeneratedColumn<bool> thumbsUp = GeneratedColumn<bool>(
    'thumbs_up',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("thumbs_up" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _thumbsDownMeta = const VerificationMeta(
    'thumbsDown',
  );
  @override
  late final GeneratedColumn<bool> thumbsDown = GeneratedColumn<bool>(
    'thumbs_down',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("thumbs_down" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    odUserId,
    ruleId,
    thumbsUp,
    thumbsDown,
    generatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'insight_feedback';
  @override
  VerificationContext validateIntegrity(
    Insertable<InsightFeedbackData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('od_user_id')) {
      context.handle(
        _odUserIdMeta,
        odUserId.isAcceptableOrUnknown(data['od_user_id']!, _odUserIdMeta),
      );
    } else if (isInserting) {
      context.missing(_odUserIdMeta);
    }
    if (data.containsKey('rule_id')) {
      context.handle(
        _ruleIdMeta,
        ruleId.isAcceptableOrUnknown(data['rule_id']!, _ruleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ruleIdMeta);
    }
    if (data.containsKey('thumbs_up')) {
      context.handle(
        _thumbsUpMeta,
        thumbsUp.isAcceptableOrUnknown(data['thumbs_up']!, _thumbsUpMeta),
      );
    }
    if (data.containsKey('thumbs_down')) {
      context.handle(
        _thumbsDownMeta,
        thumbsDown.isAcceptableOrUnknown(data['thumbs_down']!, _thumbsDownMeta),
      );
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InsightFeedbackData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InsightFeedbackData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      odUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}od_user_id'],
      )!,
      ruleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rule_id'],
      )!,
      thumbsUp: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}thumbs_up'],
      )!,
      thumbsDown: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}thumbs_down'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
    );
  }

  @override
  $InsightFeedbackTable createAlias(String alias) {
    return $InsightFeedbackTable(attachedDatabase, alias);
  }
}

class InsightFeedbackData extends DataClass
    implements Insertable<InsightFeedbackData> {
  final int id;
  final String odUserId;
  final String ruleId;
  final bool thumbsUp;
  final bool thumbsDown;
  final DateTime generatedAt;
  const InsightFeedbackData({
    required this.id,
    required this.odUserId,
    required this.ruleId,
    required this.thumbsUp,
    required this.thumbsDown,
    required this.generatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['od_user_id'] = Variable<String>(odUserId);
    map['rule_id'] = Variable<String>(ruleId);
    map['thumbs_up'] = Variable<bool>(thumbsUp);
    map['thumbs_down'] = Variable<bool>(thumbsDown);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    return map;
  }

  InsightFeedbackCompanion toCompanion(bool nullToAbsent) {
    return InsightFeedbackCompanion(
      id: Value(id),
      odUserId: Value(odUserId),
      ruleId: Value(ruleId),
      thumbsUp: Value(thumbsUp),
      thumbsDown: Value(thumbsDown),
      generatedAt: Value(generatedAt),
    );
  }

  factory InsightFeedbackData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InsightFeedbackData(
      id: serializer.fromJson<int>(json['id']),
      odUserId: serializer.fromJson<String>(json['odUserId']),
      ruleId: serializer.fromJson<String>(json['ruleId']),
      thumbsUp: serializer.fromJson<bool>(json['thumbsUp']),
      thumbsDown: serializer.fromJson<bool>(json['thumbsDown']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'odUserId': serializer.toJson<String>(odUserId),
      'ruleId': serializer.toJson<String>(ruleId),
      'thumbsUp': serializer.toJson<bool>(thumbsUp),
      'thumbsDown': serializer.toJson<bool>(thumbsDown),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
    };
  }

  InsightFeedbackData copyWith({
    int? id,
    String? odUserId,
    String? ruleId,
    bool? thumbsUp,
    bool? thumbsDown,
    DateTime? generatedAt,
  }) => InsightFeedbackData(
    id: id ?? this.id,
    odUserId: odUserId ?? this.odUserId,
    ruleId: ruleId ?? this.ruleId,
    thumbsUp: thumbsUp ?? this.thumbsUp,
    thumbsDown: thumbsDown ?? this.thumbsDown,
    generatedAt: generatedAt ?? this.generatedAt,
  );
  InsightFeedbackData copyWithCompanion(InsightFeedbackCompanion data) {
    return InsightFeedbackData(
      id: data.id.present ? data.id.value : this.id,
      odUserId: data.odUserId.present ? data.odUserId.value : this.odUserId,
      ruleId: data.ruleId.present ? data.ruleId.value : this.ruleId,
      thumbsUp: data.thumbsUp.present ? data.thumbsUp.value : this.thumbsUp,
      thumbsDown: data.thumbsDown.present
          ? data.thumbsDown.value
          : this.thumbsDown,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InsightFeedbackData(')
          ..write('id: $id, ')
          ..write('odUserId: $odUserId, ')
          ..write('ruleId: $ruleId, ')
          ..write('thumbsUp: $thumbsUp, ')
          ..write('thumbsDown: $thumbsDown, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, odUserId, ruleId, thumbsUp, thumbsDown, generatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InsightFeedbackData &&
          other.id == this.id &&
          other.odUserId == this.odUserId &&
          other.ruleId == this.ruleId &&
          other.thumbsUp == this.thumbsUp &&
          other.thumbsDown == this.thumbsDown &&
          other.generatedAt == this.generatedAt);
}

class InsightFeedbackCompanion extends UpdateCompanion<InsightFeedbackData> {
  final Value<int> id;
  final Value<String> odUserId;
  final Value<String> ruleId;
  final Value<bool> thumbsUp;
  final Value<bool> thumbsDown;
  final Value<DateTime> generatedAt;
  const InsightFeedbackCompanion({
    this.id = const Value.absent(),
    this.odUserId = const Value.absent(),
    this.ruleId = const Value.absent(),
    this.thumbsUp = const Value.absent(),
    this.thumbsDown = const Value.absent(),
    this.generatedAt = const Value.absent(),
  });
  InsightFeedbackCompanion.insert({
    this.id = const Value.absent(),
    required String odUserId,
    required String ruleId,
    this.thumbsUp = const Value.absent(),
    this.thumbsDown = const Value.absent(),
    required DateTime generatedAt,
  }) : odUserId = Value(odUserId),
       ruleId = Value(ruleId),
       generatedAt = Value(generatedAt);
  static Insertable<InsightFeedbackData> custom({
    Expression<int>? id,
    Expression<String>? odUserId,
    Expression<String>? ruleId,
    Expression<bool>? thumbsUp,
    Expression<bool>? thumbsDown,
    Expression<DateTime>? generatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (odUserId != null) 'od_user_id': odUserId,
      if (ruleId != null) 'rule_id': ruleId,
      if (thumbsUp != null) 'thumbs_up': thumbsUp,
      if (thumbsDown != null) 'thumbs_down': thumbsDown,
      if (generatedAt != null) 'generated_at': generatedAt,
    });
  }

  InsightFeedbackCompanion copyWith({
    Value<int>? id,
    Value<String>? odUserId,
    Value<String>? ruleId,
    Value<bool>? thumbsUp,
    Value<bool>? thumbsDown,
    Value<DateTime>? generatedAt,
  }) {
    return InsightFeedbackCompanion(
      id: id ?? this.id,
      odUserId: odUserId ?? this.odUserId,
      ruleId: ruleId ?? this.ruleId,
      thumbsUp: thumbsUp ?? this.thumbsUp,
      thumbsDown: thumbsDown ?? this.thumbsDown,
      generatedAt: generatedAt ?? this.generatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (odUserId.present) {
      map['od_user_id'] = Variable<String>(odUserId.value);
    }
    if (ruleId.present) {
      map['rule_id'] = Variable<String>(ruleId.value);
    }
    if (thumbsUp.present) {
      map['thumbs_up'] = Variable<bool>(thumbsUp.value);
    }
    if (thumbsDown.present) {
      map['thumbs_down'] = Variable<bool>(thumbsDown.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InsightFeedbackCompanion(')
          ..write('id: $id, ')
          ..write('odUserId: $odUserId, ')
          ..write('ruleId: $ruleId, ')
          ..write('thumbsUp: $thumbsUp, ')
          ..write('thumbsDown: $thumbsDown, ')
          ..write('generatedAt: $generatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodLogsTable foodLogs = $FoodLogsTable(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $WorkoutLogsTable workoutLogs = $WorkoutLogsTable(this);
  late final $StepLogsTable stepLogs = $StepLogsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $MoodLogsTable moodLogs = $MoodLogsTable(this);
  late final $BloodPressureLogsTable bloodPressureLogs =
      $BloodPressureLogsTable(this);
  late final $GlucoseLogsTable glucoseLogs = $GlucoseLogsTable(this);
  late final $Spo2LogsTable spo2Logs = $Spo2LogsTable(this);
  late final $PeriodLogsTable periodLogs = $PeriodLogsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitCompletionsTable habitCompletions = $HabitCompletionsTable(
    this,
  );
  late final $BodyMeasurementsTable bodyMeasurements = $BodyMeasurementsTable(
    this,
  );
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $FastingLogsTable fastingLogs = $FastingLogsTable(this);
  late final $MealPlansTable mealPlans = $MealPlansTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $DoctorAppointmentsTable doctorAppointments =
      $DoctorAppointmentsTable(this);
  late final $KarmaTransactionsTable karmaTransactions =
      $KarmaTransactionsTable(this);
  late final $NutritionGoalsTable nutritionGoals = $NutritionGoalsTable(this);
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  late final $RemoteConfigCacheTable remoteConfigCache =
      $RemoteConfigCacheTable(this);
  late final $LabReportsTable labReports = $LabReportsTable(this);
  late final $AbhaLinksTable abhaLinks = $AbhaLinksTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $EmergencyCardTable emergencyCard = $EmergencyCardTable(this);
  late final $FestivalCalendarTable festivalCalendar = $FestivalCalendarTable(
    this,
  );
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SyncDeadLetterTable syncDeadLetter = $SyncDeadLetterTable(this);
  late final $FoodItemsFtsTable foodItemsFts = $FoodItemsFtsTable(this);
  late final $InsightFeedbackTable insightFeedback = $InsightFeedbackTable(
    this,
  );
  late final Index idxFoodLogsUser = Index(
    'idx_food_logs_user',
    'CREATE INDEX idx_food_logs_user ON food_logs (user_id, logged_at)',
  );
  late final Index idxFoodItemsName = Index(
    'idx_food_items_name',
    'CREATE INDEX idx_food_items_name ON food_items (name)',
  );
  late final Index idxWorkoutLogsUser = Index(
    'idx_workout_logs_user',
    'CREATE INDEX idx_workout_logs_user ON workout_logs (user_id, logged_at)',
  );
  late final Index idxStepLogsUser = Index(
    'idx_step_logs_user',
    'CREATE INDEX idx_step_logs_user ON step_logs (user_id, date)',
  );
  late final Index idxSleepLogsUser = Index(
    'idx_sleep_logs_user',
    'CREATE INDEX idx_sleep_logs_user ON sleep_logs (user_id, date)',
  );
  late final Index idxMoodLogsUser = Index(
    'idx_mood_logs_user',
    'CREATE INDEX idx_mood_logs_user ON mood_logs (user_id, logged_at)',
  );
  late final Index idxBpLogsUser = Index(
    'idx_bp_logs_user',
    'CREATE INDEX idx_bp_logs_user ON blood_pressure_logs (user_id, logged_at)',
  );
  late final Index idxGlucoseLogsUser = Index(
    'idx_glucose_logs_user',
    'CREATE INDEX idx_glucose_logs_user ON glucose_logs (user_id, logged_at)',
  );
  late final Index idxPeriodLogsUser = Index(
    'idx_period_logs_user',
    'CREATE INDEX idx_period_logs_user ON period_logs (user_id, date)',
  );
  late final Index idxHabitCompUser = Index(
    'idx_habit_comp_user',
    'CREATE INDEX idx_habit_comp_user ON habit_completions (user_id, completed_at)',
  );
  late final Index idxMedicationsActive = Index(
    'idx_medications_active',
    'CREATE INDEX idx_medications_active ON medications (user_id, is_active)',
  );
  late final Index idxMealPlansUser = Index(
    'idx_meal_plans_user',
    'CREATE INDEX idx_meal_plans_user ON meal_plans (user_id, week_start_date)',
  );
  late final Index idxJournalUser = Index(
    'idx_journal_user',
    'CREATE INDEX idx_journal_user ON journal_entries (user_id, created_at)',
  );
  late final Index idxKarmaUser = Index(
    'idx_karma_user',
    'CREATE INDEX idx_karma_user ON karma_transactions (user_id, created_at)',
  );
  late final Index idxPrUserType = Index(
    'idx_pr_user_type',
    'CREATE INDEX idx_pr_user_type ON personal_records (user_id, record_type)',
  );
  late final Index idxFestivalDate = Index(
    'idx_festival_date',
    'CREATE INDEX idx_festival_date ON festival_calendar (date)',
  );
  late final Index idxSyncQueueStatus = Index(
    'idx_sync_queue_status',
    'CREATE INDEX idx_sync_queue_status ON sync_queue (status)',
  );
  late final FoodLogsDao foodLogsDao = FoodLogsDao(this as AppDatabase);
  late final FoodItemsDao foodItemsDao = FoodItemsDao(this as AppDatabase);
  late final WorkoutLogsDao workoutLogsDao = WorkoutLogsDao(
    this as AppDatabase,
  );
  late final StepLogsDao stepLogsDao = StepLogsDao(this as AppDatabase);
  late final SleepLogsDao sleepLogsDao = SleepLogsDao(this as AppDatabase);
  late final MoodLogsDao moodLogsDao = MoodLogsDao(this as AppDatabase);
  late final BloodPressureLogsDao bloodPressureLogsDao = BloodPressureLogsDao(
    this as AppDatabase,
  );
  late final GlucoseLogsDao glucoseLogsDao = GlucoseLogsDao(
    this as AppDatabase,
  );
  late final Spo2LogsDao spo2LogsDao = Spo2LogsDao(this as AppDatabase);
  late final PeriodLogsDao periodLogsDao = PeriodLogsDao(this as AppDatabase);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final HabitCompletionsDao habitCompletionsDao = HabitCompletionsDao(
    this as AppDatabase,
  );
  late final BodyMeasurementsDao bodyMeasurementsDao = BodyMeasurementsDao(
    this as AppDatabase,
  );
  late final MedicationsDao medicationsDao = MedicationsDao(
    this as AppDatabase,
  );
  late final FastingLogsDao fastingLogsDao = FastingLogsDao(
    this as AppDatabase,
  );
  late final MealPlansDao mealPlansDao = MealPlansDao(this as AppDatabase);
  late final RecipesDao recipesDao = RecipesDao(this as AppDatabase);
  late final JournalEntriesDao journalEntriesDao = JournalEntriesDao(
    this as AppDatabase,
  );
  late final DoctorAppointmentsDao doctorAppointmentsDao =
      DoctorAppointmentsDao(this as AppDatabase);
  late final LabReportsDao labReportsDao = LabReportsDao(this as AppDatabase);
  late final AbhaLinksDao abhaLinksDao = AbhaLinksDao(this as AppDatabase);
  late final EmergencyCardDao emergencyCardDao = EmergencyCardDao(
    this as AppDatabase,
  );
  late final FestivalCalendarDao festivalCalendarDao = FestivalCalendarDao(
    this as AppDatabase,
  );
  late final RemoteConfigCacheDao remoteConfigCacheDao = RemoteConfigCacheDao(
    this as AppDatabase,
  );
  late final KarmaTransactionsDao karmaTransactionsDao = KarmaTransactionsDao(
    this as AppDatabase,
  );
  late final NutritionGoalsDao nutritionGoalsDao = NutritionGoalsDao(
    this as AppDatabase,
  );
  late final PersonalRecordsDao personalRecordsDao = PersonalRecordsDao(
    this as AppDatabase,
  );
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  late final SyncDeadLetterDao syncDeadLetterDao = SyncDeadLetterDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    foodLogs,
    foodItems,
    workoutLogs,
    stepLogs,
    sleepLogs,
    moodLogs,
    bloodPressureLogs,
    glucoseLogs,
    spo2Logs,
    periodLogs,
    habits,
    habitCompletions,
    bodyMeasurements,
    medications,
    fastingLogs,
    mealPlans,
    recipes,
    journalEntries,
    doctorAppointments,
    karmaTransactions,
    nutritionGoals,
    personalRecords,
    remoteConfigCache,
    labReports,
    abhaLinks,
    userProfiles,
    emergencyCard,
    festivalCalendar,
    syncQueue,
    syncDeadLetter,
    foodItemsFts,
    insightFeedback,
    idxFoodLogsUser,
    idxFoodItemsName,
    idxWorkoutLogsUser,
    idxStepLogsUser,
    idxSleepLogsUser,
    idxMoodLogsUser,
    idxBpLogsUser,
    idxGlucoseLogsUser,
    idxPeriodLogsUser,
    idxHabitCompUser,
    idxMedicationsActive,
    idxMealPlansUser,
    idxJournalUser,
    idxKarmaUser,
    idxPrUserType,
    idxFestivalDate,
    idxSyncQueueStatus,
  ];
}

typedef $$FoodLogsTableCreateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String foodName,
      required String mealType,
      required double quantityG,
      required double calories,
      required double proteinG,
      required double carbsG,
      required double fatG,
      Value<double> vitaminDMcg,
      Value<double> vitaminB12Mcg,
      Value<double> ironMg,
      Value<double> calciumMg,
      required DateTime loggedAt,
      required String syncStatus,
      required String idempotencyKey,
    });
typedef $$FoodLogsTableUpdateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> foodName,
      Value<String> mealType,
      Value<double> quantityG,
      Value<double> calories,
      Value<double> proteinG,
      Value<double> carbsG,
      Value<double> fatG,
      Value<double> vitaminDMcg,
      Value<double> vitaminB12Mcg,
      Value<double> ironMg,
      Value<double> calciumMg,
      Value<DateTime> loggedAt,
      Value<String> syncStatus,
      Value<String> idempotencyKey,
    });

class $$FoodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantityG => $composableBuilder(
    column: $table.quantityG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ironMg => $composableBuilder(
    column: $table.ironMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calciumMg => $composableBuilder(
    column: $table.calciumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantityG => $composableBuilder(
    column: $table.quantityG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinG => $composableBuilder(
    column: $table.proteinG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsG => $composableBuilder(
    column: $table.carbsG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatG => $composableBuilder(
    column: $table.fatG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ironMg => $composableBuilder(
    column: $table.ironMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calciumMg => $composableBuilder(
    column: $table.calciumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<double> get quantityG =>
      $composableBuilder(column: $table.quantityG, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ironMg =>
      $composableBuilder(column: $table.ironMg, builder: (column) => column);

  GeneratedColumn<double> get calciumMg =>
      $composableBuilder(column: $table.calciumMg, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );
}

class $$FoodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogsTable,
          FoodLog,
          $$FoodLogsTableFilterComposer,
          $$FoodLogsTableOrderingComposer,
          $$FoodLogsTableAnnotationComposer,
          $$FoodLogsTableCreateCompanionBuilder,
          $$FoodLogsTableUpdateCompanionBuilder,
          (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
          FoodLog,
          PrefetchHooks Function()
        > {
  $$FoodLogsTableTableManager(_$AppDatabase db, $FoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> foodName = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<double> quantityG = const Value.absent(),
                Value<double> calories = const Value.absent(),
                Value<double> proteinG = const Value.absent(),
                Value<double> carbsG = const Value.absent(),
                Value<double> fatG = const Value.absent(),
                Value<double> vitaminDMcg = const Value.absent(),
                Value<double> vitaminB12Mcg = const Value.absent(),
                Value<double> ironMg = const Value.absent(),
                Value<double> calciumMg = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
              }) => FoodLogsCompanion(
                id: id,
                userId: userId,
                foodName: foodName,
                mealType: mealType,
                quantityG: quantityG,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                vitaminDMcg: vitaminDMcg,
                vitaminB12Mcg: vitaminB12Mcg,
                ironMg: ironMg,
                calciumMg: calciumMg,
                loggedAt: loggedAt,
                syncStatus: syncStatus,
                idempotencyKey: idempotencyKey,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String foodName,
                required String mealType,
                required double quantityG,
                required double calories,
                required double proteinG,
                required double carbsG,
                required double fatG,
                Value<double> vitaminDMcg = const Value.absent(),
                Value<double> vitaminB12Mcg = const Value.absent(),
                Value<double> ironMg = const Value.absent(),
                Value<double> calciumMg = const Value.absent(),
                required DateTime loggedAt,
                required String syncStatus,
                required String idempotencyKey,
              }) => FoodLogsCompanion.insert(
                id: id,
                userId: userId,
                foodName: foodName,
                mealType: mealType,
                quantityG: quantityG,
                calories: calories,
                proteinG: proteinG,
                carbsG: carbsG,
                fatG: fatG,
                vitaminDMcg: vitaminDMcg,
                vitaminB12Mcg: vitaminB12Mcg,
                ironMg: ironMg,
                calciumMg: calciumMg,
                loggedAt: loggedAt,
                syncStatus: syncStatus,
                idempotencyKey: idempotencyKey,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogsTable,
      FoodLog,
      $$FoodLogsTableFilterComposer,
      $$FoodLogsTableOrderingComposer,
      $$FoodLogsTableAnnotationComposer,
      $$FoodLogsTableCreateCompanionBuilder,
      $$FoodLogsTableUpdateCompanionBuilder,
      (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
      FoodLog,
      PrefetchHooks Function()
    >;
typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> nameLocal,
      Value<String?> region,
      required double caloriesPer100g,
      required double proteinPer100g,
      required double carbsPer100g,
      required double fatPer100g,
      Value<double> vitaminDMcg,
      Value<double> vitaminB12Mcg,
      Value<double> ironMg,
      Value<double> calciumMg,
      Value<String?> servingSizesJson,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> nameLocal,
      Value<String?> region,
      Value<double> caloriesPer100g,
      Value<double> proteinPer100g,
      Value<double> carbsPer100g,
      Value<double> fatPer100g,
      Value<double> vitaminDMcg,
      Value<double> vitaminB12Mcg,
      Value<double> ironMg,
      Value<double> calciumMg,
      Value<String?> servingSizesJson,
    });

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nameLocal => $composableBuilder(
    column: $table.nameLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ironMg => $composableBuilder(
    column: $table.ironMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calciumMg => $composableBuilder(
    column: $table.calciumMg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get servingSizesJson => $composableBuilder(
    column: $table.servingSizesJson,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nameLocal => $composableBuilder(
    column: $table.nameLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ironMg => $composableBuilder(
    column: $table.ironMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calciumMg => $composableBuilder(
    column: $table.calciumMg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get servingSizesJson => $composableBuilder(
    column: $table.servingSizesJson,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameLocal =>
      $composableBuilder(column: $table.nameLocal, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vitaminDMcg => $composableBuilder(
    column: $table.vitaminDMcg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vitaminB12Mcg => $composableBuilder(
    column: $table.vitaminB12Mcg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ironMg =>
      $composableBuilder(column: $table.ironMg, builder: (column) => column);

  GeneratedColumn<double> get calciumMg =>
      $composableBuilder(column: $table.calciumMg, builder: (column) => column);

  GeneratedColumn<String> get servingSizesJson => $composableBuilder(
    column: $table.servingSizesJson,
    builder: (column) => column,
  );
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
          FoodItem,
          PrefetchHooks Function()
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> nameLocal = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<double> caloriesPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double> vitaminDMcg = const Value.absent(),
                Value<double> vitaminB12Mcg = const Value.absent(),
                Value<double> ironMg = const Value.absent(),
                Value<double> calciumMg = const Value.absent(),
                Value<String?> servingSizesJson = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                name: name,
                nameLocal: nameLocal,
                region: region,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                vitaminDMcg: vitaminDMcg,
                vitaminB12Mcg: vitaminB12Mcg,
                ironMg: ironMg,
                calciumMg: calciumMg,
                servingSizesJson: servingSizesJson,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> nameLocal = const Value.absent(),
                Value<String?> region = const Value.absent(),
                required double caloriesPer100g,
                required double proteinPer100g,
                required double carbsPer100g,
                required double fatPer100g,
                Value<double> vitaminDMcg = const Value.absent(),
                Value<double> vitaminB12Mcg = const Value.absent(),
                Value<double> ironMg = const Value.absent(),
                Value<double> calciumMg = const Value.absent(),
                Value<String?> servingSizesJson = const Value.absent(),
              }) => FoodItemsCompanion.insert(
                id: id,
                name: name,
                nameLocal: nameLocal,
                region: region,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                vitaminDMcg: vitaminDMcg,
                vitaminB12Mcg: vitaminB12Mcg,
                ironMg: ironMg,
                calciumMg: calciumMg,
                servingSizesJson: servingSizesJson,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
      FoodItem,
      PrefetchHooks Function()
    >;
typedef $$WorkoutLogsTableCreateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String title,
      required int durationMin,
      required double caloriesBurned,
      required String workoutType,
      Value<int?> rpe,
      Value<String?> routeJson,
      Value<double?> distanceKm,
      required DateTime loggedAt,
    });
typedef $$WorkoutLogsTableUpdateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> title,
      Value<int> durationMin,
      Value<double> caloriesBurned,
      Value<String> workoutType,
      Value<int?> rpe,
      Value<String?> routeJson,
      Value<double?> distanceKm,
      Value<DateTime> loggedAt,
    });

class $$WorkoutLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get routeJson => $composableBuilder(
    column: $table.routeJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get routeJson => $composableBuilder(
    column: $table.routeJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<String> get routeJson =>
      $composableBuilder(column: $table.routeJson, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
    column: $table.distanceKm,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$WorkoutLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutLogsTable,
          WorkoutLog,
          $$WorkoutLogsTableFilterComposer,
          $$WorkoutLogsTableOrderingComposer,
          $$WorkoutLogsTableAnnotationComposer,
          $$WorkoutLogsTableCreateCompanionBuilder,
          $$WorkoutLogsTableUpdateCompanionBuilder,
          (
            WorkoutLog,
            BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>,
          ),
          WorkoutLog,
          PrefetchHooks Function()
        > {
  $$WorkoutLogsTableTableManager(_$AppDatabase db, $WorkoutLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> durationMin = const Value.absent(),
                Value<double> caloriesBurned = const Value.absent(),
                Value<String> workoutType = const Value.absent(),
                Value<int?> rpe = const Value.absent(),
                Value<String?> routeJson = const Value.absent(),
                Value<double?> distanceKm = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => WorkoutLogsCompanion(
                id: id,
                userId: userId,
                title: title,
                durationMin: durationMin,
                caloriesBurned: caloriesBurned,
                workoutType: workoutType,
                rpe: rpe,
                routeJson: routeJson,
                distanceKm: distanceKm,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String title,
                required int durationMin,
                required double caloriesBurned,
                required String workoutType,
                Value<int?> rpe = const Value.absent(),
                Value<String?> routeJson = const Value.absent(),
                Value<double?> distanceKm = const Value.absent(),
                required DateTime loggedAt,
              }) => WorkoutLogsCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                durationMin: durationMin,
                caloriesBurned: caloriesBurned,
                workoutType: workoutType,
                rpe: rpe,
                routeJson: routeJson,
                distanceKm: distanceKm,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutLogsTable,
      WorkoutLog,
      $$WorkoutLogsTableFilterComposer,
      $$WorkoutLogsTableOrderingComposer,
      $$WorkoutLogsTableAnnotationComposer,
      $$WorkoutLogsTableCreateCompanionBuilder,
      $$WorkoutLogsTableUpdateCompanionBuilder,
      (
        WorkoutLog,
        BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>,
      ),
      WorkoutLog,
      PrefetchHooks Function()
    >;
typedef $$StepLogsTableCreateCompanionBuilder =
    StepLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int steps,
      required DateTime date,
    });
typedef $$StepLogsTableUpdateCompanionBuilder =
    StepLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> steps,
      Value<DateTime> date,
    });

class $$StepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $StepLogsTable> {
  $$StepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $StepLogsTable> {
  $$StepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepLogsTable> {
  $$StepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$StepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StepLogsTable,
          StepLog,
          $$StepLogsTableFilterComposer,
          $$StepLogsTableOrderingComposer,
          $$StepLogsTableAnnotationComposer,
          $$StepLogsTableCreateCompanionBuilder,
          $$StepLogsTableUpdateCompanionBuilder,
          (StepLog, BaseReferences<_$AppDatabase, $StepLogsTable, StepLog>),
          StepLog,
          PrefetchHooks Function()
        > {
  $$StepLogsTableTableManager(_$AppDatabase db, $StepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => StepLogsCompanion(
                id: id,
                userId: userId,
                steps: steps,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int steps,
                required DateTime date,
              }) => StepLogsCompanion.insert(
                id: id,
                userId: userId,
                steps: steps,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StepLogsTable,
      StepLog,
      $$StepLogsTableFilterComposer,
      $$StepLogsTableOrderingComposer,
      $$StepLogsTableAnnotationComposer,
      $$StepLogsTableCreateCompanionBuilder,
      $$StepLogsTableUpdateCompanionBuilder,
      (StepLog, BaseReferences<_$AppDatabase, $StepLogsTable, StepLog>),
      StepLog,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int durationMin,
      Value<int?> quality,
      required DateTime date,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> durationMin,
      Value<int?> quality,
      Value<DateTime> date,
    });

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
    column: $table.durationMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> durationMin = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                userId: userId,
                durationMin: durationMin,
                quality: quality,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int durationMin,
                Value<int?> quality = const Value.absent(),
                required DateTime date,
              }) => SleepLogsCompanion.insert(
                id: id,
                userId: userId,
                durationMin: durationMin,
                quality: quality,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
typedef $$MoodLogsTableCreateCompanionBuilder =
    MoodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int moodScore,
      Value<int?> screenTimeMin,
      Value<int?> sleepQuality,
      required DateTime loggedAt,
    });
typedef $$MoodLogsTableUpdateCompanionBuilder =
    MoodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> moodScore,
      Value<int?> screenTimeMin,
      Value<int?> sleepQuality,
      Value<DateTime> loggedAt,
    });

class $$MoodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MoodLogsTable> {
  $$MoodLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get screenTimeMin => $composableBuilder(
    column: $table.screenTimeMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MoodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MoodLogsTable> {
  $$MoodLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get screenTimeMin => $composableBuilder(
    column: $table.screenTimeMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MoodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MoodLogsTable> {
  $$MoodLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get moodScore =>
      $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<int> get screenTimeMin => $composableBuilder(
    column: $table.screenTimeMin,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sleepQuality => $composableBuilder(
    column: $table.sleepQuality,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$MoodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MoodLogsTable,
          MoodLog,
          $$MoodLogsTableFilterComposer,
          $$MoodLogsTableOrderingComposer,
          $$MoodLogsTableAnnotationComposer,
          $$MoodLogsTableCreateCompanionBuilder,
          $$MoodLogsTableUpdateCompanionBuilder,
          (MoodLog, BaseReferences<_$AppDatabase, $MoodLogsTable, MoodLog>),
          MoodLog,
          PrefetchHooks Function()
        > {
  $$MoodLogsTableTableManager(_$AppDatabase db, $MoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> moodScore = const Value.absent(),
                Value<int?> screenTimeMin = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => MoodLogsCompanion(
                id: id,
                userId: userId,
                moodScore: moodScore,
                screenTimeMin: screenTimeMin,
                sleepQuality: sleepQuality,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int moodScore,
                Value<int?> screenTimeMin = const Value.absent(),
                Value<int?> sleepQuality = const Value.absent(),
                required DateTime loggedAt,
              }) => MoodLogsCompanion.insert(
                id: id,
                userId: userId,
                moodScore: moodScore,
                screenTimeMin: screenTimeMin,
                sleepQuality: sleepQuality,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MoodLogsTable,
      MoodLog,
      $$MoodLogsTableFilterComposer,
      $$MoodLogsTableOrderingComposer,
      $$MoodLogsTableAnnotationComposer,
      $$MoodLogsTableCreateCompanionBuilder,
      $$MoodLogsTableUpdateCompanionBuilder,
      (MoodLog, BaseReferences<_$AppDatabase, $MoodLogsTable, MoodLog>),
      MoodLog,
      PrefetchHooks Function()
    >;
typedef $$BloodPressureLogsTableCreateCompanionBuilder =
    BloodPressureLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String systolic,
      required String diastolic,
      Value<int?> pulse,
      Value<bool> isEncrypted,
      required DateTime loggedAt,
    });
typedef $$BloodPressureLogsTableUpdateCompanionBuilder =
    BloodPressureLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> systolic,
      Value<String> diastolic,
      Value<int?> pulse,
      Value<bool> isEncrypted,
      Value<DateTime> loggedAt,
    });

class $$BloodPressureLogsTableFilterComposer
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BloodPressureLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BloodPressureLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<String> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get pulse =>
      $composableBuilder(column: $table.pulse, builder: (column) => column);

  GeneratedColumn<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$BloodPressureLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BloodPressureLogsTable,
          BloodPressureLog,
          $$BloodPressureLogsTableFilterComposer,
          $$BloodPressureLogsTableOrderingComposer,
          $$BloodPressureLogsTableAnnotationComposer,
          $$BloodPressureLogsTableCreateCompanionBuilder,
          $$BloodPressureLogsTableUpdateCompanionBuilder,
          (
            BloodPressureLog,
            BaseReferences<
              _$AppDatabase,
              $BloodPressureLogsTable,
              BloodPressureLog
            >,
          ),
          BloodPressureLog,
          PrefetchHooks Function()
        > {
  $$BloodPressureLogsTableTableManager(
    _$AppDatabase db,
    $BloodPressureLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodPressureLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodPressureLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodPressureLogsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> systolic = const Value.absent(),
                Value<String> diastolic = const Value.absent(),
                Value<int?> pulse = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => BloodPressureLogsCompanion(
                id: id,
                userId: userId,
                systolic: systolic,
                diastolic: diastolic,
                pulse: pulse,
                isEncrypted: isEncrypted,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String systolic,
                required String diastolic,
                Value<int?> pulse = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                required DateTime loggedAt,
              }) => BloodPressureLogsCompanion.insert(
                id: id,
                userId: userId,
                systolic: systolic,
                diastolic: diastolic,
                pulse: pulse,
                isEncrypted: isEncrypted,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BloodPressureLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BloodPressureLogsTable,
      BloodPressureLog,
      $$BloodPressureLogsTableFilterComposer,
      $$BloodPressureLogsTableOrderingComposer,
      $$BloodPressureLogsTableAnnotationComposer,
      $$BloodPressureLogsTableCreateCompanionBuilder,
      $$BloodPressureLogsTableUpdateCompanionBuilder,
      (
        BloodPressureLog,
        BaseReferences<
          _$AppDatabase,
          $BloodPressureLogsTable,
          BloodPressureLog
        >,
      ),
      BloodPressureLog,
      PrefetchHooks Function()
    >;
typedef $$GlucoseLogsTableCreateCompanionBuilder =
    GlucoseLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String glucoseMgdl,
      Value<String?> mealType,
      Value<int?> foodLogId,
      Value<bool> isEncrypted,
      required DateTime loggedAt,
    });
typedef $$GlucoseLogsTableUpdateCompanionBuilder =
    GlucoseLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> glucoseMgdl,
      Value<String?> mealType,
      Value<int?> foodLogId,
      Value<bool> isEncrypted,
      Value<DateTime> loggedAt,
    });

class $$GlucoseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get glucoseMgdl => $composableBuilder(
    column: $table.glucoseMgdl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get foodLogId => $composableBuilder(
    column: $table.foodLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GlucoseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get glucoseMgdl => $composableBuilder(
    column: $table.glucoseMgdl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get foodLogId => $composableBuilder(
    column: $table.foodLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GlucoseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get glucoseMgdl => $composableBuilder(
    column: $table.glucoseMgdl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<int> get foodLogId =>
      $composableBuilder(column: $table.foodLogId, builder: (column) => column);

  GeneratedColumn<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$GlucoseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlucoseLogsTable,
          GlucoseLog,
          $$GlucoseLogsTableFilterComposer,
          $$GlucoseLogsTableOrderingComposer,
          $$GlucoseLogsTableAnnotationComposer,
          $$GlucoseLogsTableCreateCompanionBuilder,
          $$GlucoseLogsTableUpdateCompanionBuilder,
          (
            GlucoseLog,
            BaseReferences<_$AppDatabase, $GlucoseLogsTable, GlucoseLog>,
          ),
          GlucoseLog,
          PrefetchHooks Function()
        > {
  $$GlucoseLogsTableTableManager(_$AppDatabase db, $GlucoseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlucoseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlucoseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlucoseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> glucoseMgdl = const Value.absent(),
                Value<String?> mealType = const Value.absent(),
                Value<int?> foodLogId = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => GlucoseLogsCompanion(
                id: id,
                userId: userId,
                glucoseMgdl: glucoseMgdl,
                mealType: mealType,
                foodLogId: foodLogId,
                isEncrypted: isEncrypted,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String glucoseMgdl,
                Value<String?> mealType = const Value.absent(),
                Value<int?> foodLogId = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
                required DateTime loggedAt,
              }) => GlucoseLogsCompanion.insert(
                id: id,
                userId: userId,
                glucoseMgdl: glucoseMgdl,
                mealType: mealType,
                foodLogId: foodLogId,
                isEncrypted: isEncrypted,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GlucoseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlucoseLogsTable,
      GlucoseLog,
      $$GlucoseLogsTableFilterComposer,
      $$GlucoseLogsTableOrderingComposer,
      $$GlucoseLogsTableAnnotationComposer,
      $$GlucoseLogsTableCreateCompanionBuilder,
      $$GlucoseLogsTableUpdateCompanionBuilder,
      (
        GlucoseLog,
        BaseReferences<_$AppDatabase, $GlucoseLogsTable, GlucoseLog>,
      ),
      GlucoseLog,
      PrefetchHooks Function()
    >;
typedef $$Spo2LogsTableCreateCompanionBuilder =
    Spo2LogsCompanion Function({
      Value<int> id,
      required String userId,
      required String spo2Percentage,
      Value<int?> pulse,
      required DateTime loggedAt,
    });
typedef $$Spo2LogsTableUpdateCompanionBuilder =
    Spo2LogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> spo2Percentage,
      Value<int?> pulse,
      Value<DateTime> loggedAt,
    });

class $$Spo2LogsTableFilterComposer
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
  $$Spo2LogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spo2Percentage => $composableBuilder(
    column: $table.spo2Percentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$Spo2LogsTableOrderingComposer
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
  $$Spo2LogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spo2Percentage => $composableBuilder(
    column: $table.spo2Percentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pulse => $composableBuilder(
    column: $table.pulse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$Spo2LogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
  $$Spo2LogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get spo2Percentage => $composableBuilder(
    column: $table.spo2Percentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pulse =>
      $composableBuilder(column: $table.pulse, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);
}

class $$Spo2LogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $Spo2LogsTable,
          Spo2Log,
          $$Spo2LogsTableFilterComposer,
          $$Spo2LogsTableOrderingComposer,
          $$Spo2LogsTableAnnotationComposer,
          $$Spo2LogsTableCreateCompanionBuilder,
          $$Spo2LogsTableUpdateCompanionBuilder,
          (Spo2Log, BaseReferences<_$AppDatabase, $Spo2LogsTable, Spo2Log>),
          Spo2Log,
          PrefetchHooks Function()
        > {
  $$Spo2LogsTableTableManager(_$AppDatabase db, $Spo2LogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Spo2LogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Spo2LogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Spo2LogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> spo2Percentage = const Value.absent(),
                Value<int?> pulse = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
              }) => Spo2LogsCompanion(
                id: id,
                userId: userId,
                spo2Percentage: spo2Percentage,
                pulse: pulse,
                loggedAt: loggedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String spo2Percentage,
                Value<int?> pulse = const Value.absent(),
                required DateTime loggedAt,
              }) => Spo2LogsCompanion.insert(
                id: id,
                userId: userId,
                spo2Percentage: spo2Percentage,
                pulse: pulse,
                loggedAt: loggedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$Spo2LogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $Spo2LogsTable,
      Spo2Log,
      $$Spo2LogsTableFilterComposer,
      $$Spo2LogsTableOrderingComposer,
      $$Spo2LogsTableAnnotationComposer,
      $$Spo2LogsTableCreateCompanionBuilder,
      $$Spo2LogsTableUpdateCompanionBuilder,
      (Spo2Log, BaseReferences<_$AppDatabase, $Spo2LogsTable, Spo2Log>),
      Spo2Log,
      PrefetchHooks Function()
    >;
typedef $$PeriodLogsTableCreateCompanionBuilder =
    PeriodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime date,
      required bool isPeriodDay,
      Value<String?> flowIntensity,
      Value<String?> symptoms,
      required bool isPcodPcos,
    });
typedef $$PeriodLogsTableUpdateCompanionBuilder =
    PeriodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> date,
      Value<bool> isPeriodDay,
      Value<String?> flowIntensity,
      Value<String?> symptoms,
      Value<bool> isPcodPcos,
    });

class $$PeriodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPeriodDay => $composableBuilder(
    column: $table.isPeriodDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get flowIntensity => $composableBuilder(
    column: $table.flowIntensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPcodPcos => $composableBuilder(
    column: $table.isPcodPcos,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PeriodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPeriodDay => $composableBuilder(
    column: $table.isPeriodDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get flowIntensity => $composableBuilder(
    column: $table.flowIntensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPcodPcos => $composableBuilder(
    column: $table.isPcodPcos,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PeriodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<bool> get isPeriodDay => $composableBuilder(
    column: $table.isPeriodDay,
    builder: (column) => column,
  );

  GeneratedColumn<String> get flowIntensity => $composableBuilder(
    column: $table.flowIntensity,
    builder: (column) => column,
  );

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<bool> get isPcodPcos => $composableBuilder(
    column: $table.isPcodPcos,
    builder: (column) => column,
  );
}

class $$PeriodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PeriodLogsTable,
          PeriodLog,
          $$PeriodLogsTableFilterComposer,
          $$PeriodLogsTableOrderingComposer,
          $$PeriodLogsTableAnnotationComposer,
          $$PeriodLogsTableCreateCompanionBuilder,
          $$PeriodLogsTableUpdateCompanionBuilder,
          (
            PeriodLog,
            BaseReferences<_$AppDatabase, $PeriodLogsTable, PeriodLog>,
          ),
          PeriodLog,
          PrefetchHooks Function()
        > {
  $$PeriodLogsTableTableManager(_$AppDatabase db, $PeriodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeriodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeriodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeriodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<bool> isPeriodDay = const Value.absent(),
                Value<String?> flowIntensity = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                Value<bool> isPcodPcos = const Value.absent(),
              }) => PeriodLogsCompanion(
                id: id,
                userId: userId,
                date: date,
                isPeriodDay: isPeriodDay,
                flowIntensity: flowIntensity,
                symptoms: symptoms,
                isPcodPcos: isPcodPcos,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime date,
                required bool isPeriodDay,
                Value<String?> flowIntensity = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                required bool isPcodPcos,
              }) => PeriodLogsCompanion.insert(
                id: id,
                userId: userId,
                date: date,
                isPeriodDay: isPeriodDay,
                flowIntensity: flowIntensity,
                symptoms: symptoms,
                isPcodPcos: isPcodPcos,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PeriodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PeriodLogsTable,
      PeriodLog,
      $$PeriodLogsTableFilterComposer,
      $$PeriodLogsTableOrderingComposer,
      $$PeriodLogsTableAnnotationComposer,
      $$PeriodLogsTableCreateCompanionBuilder,
      $$PeriodLogsTableUpdateCompanionBuilder,
      (PeriodLog, BaseReferences<_$AppDatabase, $PeriodLogsTable, PeriodLog>),
      PeriodLog,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      Value<bool> isActive,
      required DateTime createdAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<bool> isActive,
      Value<DateTime> createdAt,
    });

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitCompletionsTable, List<HabitCompletion>>
  _habitCompletionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitCompletions,
    aliasName: $_aliasNameGenerator(db.habits.id, db.habitCompletions.habitId),
  );

  $$HabitCompletionsTableProcessedTableManager get habitCompletionsRefs {
    final manager = $$HabitCompletionsTableTableManager(
      $_db,
      $_db.habitCompletions,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _habitCompletionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitCompletionsRefs(
    Expression<bool> Function($$HabitCompletionsTableFilterComposer f) f,
  ) {
    final $$HabitCompletionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableFilterComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitCompletionsRefs<T extends Object>(
    Expression<T> Function($$HabitCompletionsTableAnnotationComposer a) f,
  ) {
    final $$HabitCompletionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitCompletions,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitCompletionsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitCompletions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({bool habitCompletionsRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                userId: userId,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
              }) => HabitsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                isActive: isActive,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HabitsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({habitCompletionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (habitCompletionsRefs) db.habitCompletions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitCompletionsRefs)
                    await $_getPrefetchedData<
                      Habit,
                      $HabitsTable,
                      HabitCompletion
                    >(
                      currentTable: table,
                      referencedTable: $$HabitsTableReferences
                          ._habitCompletionsRefsTable(db),
                      managerFromTypedResult: (p0) => $$HabitsTableReferences(
                        db,
                        table,
                        p0,
                      ).habitCompletionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.habitId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({bool habitCompletionsRefs})
    >;
typedef $$HabitCompletionsTableCreateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      required int habitId,
      required String userId,
      required DateTime completedAt,
    });
typedef $$HabitCompletionsTableUpdateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<String> userId,
      Value<DateTime> completedAt,
    });

final class $$HabitCompletionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $HabitCompletionsTable, HabitCompletion> {
  $$HabitCompletionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits.createAlias(
    $_aliasNameGenerator(db.habitCompletions.habitId, db.habits.id),
  );

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<int>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletion,
          $$HabitCompletionsTableFilterComposer,
          $$HabitCompletionsTableOrderingComposer,
          $$HabitCompletionsTableAnnotationComposer,
          $$HabitCompletionsTableCreateCompanionBuilder,
          $$HabitCompletionsTableUpdateCompanionBuilder,
          (HabitCompletion, $$HabitCompletionsTableReferences),
          HabitCompletion,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitCompletionsTableTableManager(
    _$AppDatabase db,
    $HabitCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
              }) => HabitCompletionsCompanion(
                id: id,
                habitId: habitId,
                userId: userId,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required String userId,
                required DateTime completedAt,
              }) => HabitCompletionsCompanion.insert(
                id: id,
                habitId: habitId,
                userId: userId,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$HabitCompletionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (habitId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.habitId,
                                referencedTable:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db),
                                referencedColumn:
                                    $$HabitCompletionsTableReferences
                                        ._habitIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$HabitCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitCompletionsTable,
      HabitCompletion,
      $$HabitCompletionsTableFilterComposer,
      $$HabitCompletionsTableOrderingComposer,
      $$HabitCompletionsTableAnnotationComposer,
      $$HabitCompletionsTableCreateCompanionBuilder,
      $$HabitCompletionsTableUpdateCompanionBuilder,
      (HabitCompletion, $$HabitCompletionsTableReferences),
      HabitCompletion,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$BodyMeasurementsTableCreateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      required String userId,
      Value<double?> weightKg,
      required DateTime measuredAt,
    });
typedef $$BodyMeasurementsTableUpdateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<double?> weightKg,
      Value<DateTime> measuredAt,
    });

class $$BodyMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BodyMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BodyMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );
}

class $$BodyMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyMeasurementsTable,
          BodyMeasurement,
          $$BodyMeasurementsTableFilterComposer,
          $$BodyMeasurementsTableOrderingComposer,
          $$BodyMeasurementsTableAnnotationComposer,
          $$BodyMeasurementsTableCreateCompanionBuilder,
          $$BodyMeasurementsTableUpdateCompanionBuilder,
          (
            BodyMeasurement,
            BaseReferences<
              _$AppDatabase,
              $BodyMeasurementsTable,
              BodyMeasurement
            >,
          ),
          BodyMeasurement,
          PrefetchHooks Function()
        > {
  $$BodyMeasurementsTableTableManager(
    _$AppDatabase db,
    $BodyMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime> measuredAt = const Value.absent(),
              }) => BodyMeasurementsCompanion(
                id: id,
                userId: userId,
                weightKg: weightKg,
                measuredAt: measuredAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                Value<double?> weightKg = const Value.absent(),
                required DateTime measuredAt,
              }) => BodyMeasurementsCompanion.insert(
                id: id,
                userId: userId,
                weightKg: weightKg,
                measuredAt: measuredAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BodyMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyMeasurementsTable,
      BodyMeasurement,
      $$BodyMeasurementsTableFilterComposer,
      $$BodyMeasurementsTableOrderingComposer,
      $$BodyMeasurementsTableAnnotationComposer,
      $$BodyMeasurementsTableCreateCompanionBuilder,
      $$BodyMeasurementsTableUpdateCompanionBuilder,
      (
        BodyMeasurement,
        BaseReferences<_$AppDatabase, $BodyMeasurementsTable, BodyMeasurement>,
      ),
      BodyMeasurement,
      PrefetchHooks Function()
    >;
typedef $$MedicationsTableCreateCompanionBuilder =
    MedicationsCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      required bool isActive,
    });
typedef $$MedicationsTableUpdateCompanionBuilder =
    MedicationsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<bool> isActive,
    });

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);
}

class $$MedicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicationsTable,
          Medication,
          $$MedicationsTableFilterComposer,
          $$MedicationsTableOrderingComposer,
          $$MedicationsTableAnnotationComposer,
          $$MedicationsTableCreateCompanionBuilder,
          $$MedicationsTableUpdateCompanionBuilder,
          (
            Medication,
            BaseReferences<_$AppDatabase, $MedicationsTable, Medication>,
          ),
          Medication,
          PrefetchHooks Function()
        > {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
              }) => MedicationsCompanion(
                id: id,
                userId: userId,
                name: name,
                isActive: isActive,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                required bool isActive,
              }) => MedicationsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                isActive: isActive,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MedicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicationsTable,
      Medication,
      $$MedicationsTableFilterComposer,
      $$MedicationsTableOrderingComposer,
      $$MedicationsTableAnnotationComposer,
      $$MedicationsTableCreateCompanionBuilder,
      $$MedicationsTableUpdateCompanionBuilder,
      (
        Medication,
        BaseReferences<_$AppDatabase, $MedicationsTable, Medication>,
      ),
      Medication,
      PrefetchHooks Function()
    >;
typedef $$FastingLogsTableCreateCompanionBuilder =
    FastingLogsCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime fastStart,
      Value<bool?> completed,
      Value<DateTime?> fastEnd,
    });
typedef $$FastingLogsTableUpdateCompanionBuilder =
    FastingLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> fastStart,
      Value<bool?> completed,
      Value<DateTime?> fastEnd,
    });

class $$FastingLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fastStart => $composableBuilder(
    column: $table.fastStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fastEnd => $composableBuilder(
    column: $table.fastEnd,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FastingLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fastStart => $composableBuilder(
    column: $table.fastStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fastEnd => $composableBuilder(
    column: $table.fastEnd,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FastingLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get fastStart =>
      $composableBuilder(column: $table.fastStart, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<DateTime> get fastEnd =>
      $composableBuilder(column: $table.fastEnd, builder: (column) => column);
}

class $$FastingLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FastingLogsTable,
          FastingLog,
          $$FastingLogsTableFilterComposer,
          $$FastingLogsTableOrderingComposer,
          $$FastingLogsTableAnnotationComposer,
          $$FastingLogsTableCreateCompanionBuilder,
          $$FastingLogsTableUpdateCompanionBuilder,
          (
            FastingLog,
            BaseReferences<_$AppDatabase, $FastingLogsTable, FastingLog>,
          ),
          FastingLog,
          PrefetchHooks Function()
        > {
  $$FastingLogsTableTableManager(_$AppDatabase db, $FastingLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FastingLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FastingLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FastingLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> fastStart = const Value.absent(),
                Value<bool?> completed = const Value.absent(),
                Value<DateTime?> fastEnd = const Value.absent(),
              }) => FastingLogsCompanion(
                id: id,
                userId: userId,
                fastStart: fastStart,
                completed: completed,
                fastEnd: fastEnd,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime fastStart,
                Value<bool?> completed = const Value.absent(),
                Value<DateTime?> fastEnd = const Value.absent(),
              }) => FastingLogsCompanion.insert(
                id: id,
                userId: userId,
                fastStart: fastStart,
                completed: completed,
                fastEnd: fastEnd,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FastingLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FastingLogsTable,
      FastingLog,
      $$FastingLogsTableFilterComposer,
      $$FastingLogsTableOrderingComposer,
      $$FastingLogsTableAnnotationComposer,
      $$FastingLogsTableCreateCompanionBuilder,
      $$FastingLogsTableUpdateCompanionBuilder,
      (
        FastingLog,
        BaseReferences<_$AppDatabase, $FastingLogsTable, FastingLog>,
      ),
      FastingLog,
      PrefetchHooks Function()
    >;
typedef $$MealPlansTableCreateCompanionBuilder =
    MealPlansCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime weekStartDate,
    });
typedef $$MealPlansTableUpdateCompanionBuilder =
    MealPlansCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> weekStartDate,
    });

class $$MealPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MealPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MealPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStartDate => $composableBuilder(
    column: $table.weekStartDate,
    builder: (column) => column,
  );
}

class $$MealPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlansTable,
          MealPlan,
          $$MealPlansTableFilterComposer,
          $$MealPlansTableOrderingComposer,
          $$MealPlansTableAnnotationComposer,
          $$MealPlansTableCreateCompanionBuilder,
          $$MealPlansTableUpdateCompanionBuilder,
          (MealPlan, BaseReferences<_$AppDatabase, $MealPlansTable, MealPlan>),
          MealPlan,
          PrefetchHooks Function()
        > {
  $$MealPlansTableTableManager(_$AppDatabase db, $MealPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> weekStartDate = const Value.absent(),
              }) => MealPlansCompanion(
                id: id,
                userId: userId,
                weekStartDate: weekStartDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime weekStartDate,
              }) => MealPlansCompanion.insert(
                id: id,
                userId: userId,
                weekStartDate: weekStartDate,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MealPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlansTable,
      MealPlan,
      $$MealPlansTableFilterComposer,
      $$MealPlansTableOrderingComposer,
      $$MealPlansTableAnnotationComposer,
      $$MealPlansTableCreateCompanionBuilder,
      $$MealPlansTableUpdateCompanionBuilder,
      (MealPlan, BaseReferences<_$AppDatabase, $MealPlansTable, MealPlan>),
      MealPlan,
      PrefetchHooks Function()
    >;
typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      required String userId,
      required String title,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> title,
    });

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
          Recipe,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> title = const Value.absent(),
              }) => RecipesCompanion(id: id, userId: userId, title: title),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String title,
              }) =>
                  RecipesCompanion.insert(id: id, userId: userId, title: title),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
      Recipe,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      required String userId,
      required String content,
      required DateTime createdAt,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> content,
      Value<DateTime> createdAt,
    });

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (
            JournalEntry,
            BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
          ),
          JournalEntry,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                userId: userId,
                content: content,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String content,
                required DateTime createdAt,
              }) => JournalEntriesCompanion.insert(
                id: id,
                userId: userId,
                content: content,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (
        JournalEntry,
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
      ),
      JournalEntry,
      PrefetchHooks Function()
    >;
typedef $$DoctorAppointmentsTableCreateCompanionBuilder =
    DoctorAppointmentsCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime appointmentDate,
      required String doctorName,
      Value<String?> notes,
      Value<String?> prescriptionPhotoPath,
      Value<String?> extractedMedsJson,
      Value<bool> reminderSent,
      Value<bool> isCompleted,
    });
typedef $$DoctorAppointmentsTableUpdateCompanionBuilder =
    DoctorAppointmentsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> appointmentDate,
      Value<String> doctorName,
      Value<String?> notes,
      Value<String?> prescriptionPhotoPath,
      Value<String?> extractedMedsJson,
      Value<bool> reminderSent,
      Value<bool> isCompleted,
    });

class $$DoctorAppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get prescriptionPhotoPath => $composableBuilder(
    column: $table.prescriptionPhotoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractedMedsJson => $composableBuilder(
    column: $table.extractedMedsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DoctorAppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get prescriptionPhotoPath => $composableBuilder(
    column: $table.prescriptionPhotoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractedMedsJson => $composableBuilder(
    column: $table.extractedMedsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DoctorAppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get prescriptionPhotoPath => $composableBuilder(
    column: $table.prescriptionPhotoPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extractedMedsJson => $composableBuilder(
    column: $table.extractedMedsJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get reminderSent => $composableBuilder(
    column: $table.reminderSent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );
}

class $$DoctorAppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoctorAppointmentsTable,
          DoctorAppointment,
          $$DoctorAppointmentsTableFilterComposer,
          $$DoctorAppointmentsTableOrderingComposer,
          $$DoctorAppointmentsTableAnnotationComposer,
          $$DoctorAppointmentsTableCreateCompanionBuilder,
          $$DoctorAppointmentsTableUpdateCompanionBuilder,
          (
            DoctorAppointment,
            BaseReferences<
              _$AppDatabase,
              $DoctorAppointmentsTable,
              DoctorAppointment
            >,
          ),
          DoctorAppointment,
          PrefetchHooks Function()
        > {
  $$DoctorAppointmentsTableTableManager(
    _$AppDatabase db,
    $DoctorAppointmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoctorAppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoctorAppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoctorAppointmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> appointmentDate = const Value.absent(),
                Value<String> doctorName = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> prescriptionPhotoPath = const Value.absent(),
                Value<String?> extractedMedsJson = const Value.absent(),
                Value<bool> reminderSent = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => DoctorAppointmentsCompanion(
                id: id,
                userId: userId,
                appointmentDate: appointmentDate,
                doctorName: doctorName,
                notes: notes,
                prescriptionPhotoPath: prescriptionPhotoPath,
                extractedMedsJson: extractedMedsJson,
                reminderSent: reminderSent,
                isCompleted: isCompleted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime appointmentDate,
                required String doctorName,
                Value<String?> notes = const Value.absent(),
                Value<String?> prescriptionPhotoPath = const Value.absent(),
                Value<String?> extractedMedsJson = const Value.absent(),
                Value<bool> reminderSent = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
              }) => DoctorAppointmentsCompanion.insert(
                id: id,
                userId: userId,
                appointmentDate: appointmentDate,
                doctorName: doctorName,
                notes: notes,
                prescriptionPhotoPath: prescriptionPhotoPath,
                extractedMedsJson: extractedMedsJson,
                reminderSent: reminderSent,
                isCompleted: isCompleted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DoctorAppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoctorAppointmentsTable,
      DoctorAppointment,
      $$DoctorAppointmentsTableFilterComposer,
      $$DoctorAppointmentsTableOrderingComposer,
      $$DoctorAppointmentsTableAnnotationComposer,
      $$DoctorAppointmentsTableCreateCompanionBuilder,
      $$DoctorAppointmentsTableUpdateCompanionBuilder,
      (
        DoctorAppointment,
        BaseReferences<
          _$AppDatabase,
          $DoctorAppointmentsTable,
          DoctorAppointment
        >,
      ),
      DoctorAppointment,
      PrefetchHooks Function()
    >;
typedef $$KarmaTransactionsTableCreateCompanionBuilder =
    KarmaTransactionsCompanion Function({
      Value<int> id,
      required String userId,
      required int amount,
      required DateTime createdAt,
    });
typedef $$KarmaTransactionsTableUpdateCompanionBuilder =
    KarmaTransactionsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> amount,
      Value<DateTime> createdAt,
    });

class $$KarmaTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KarmaTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KarmaTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KarmaTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $KarmaTransactionsTable,
          KarmaTransaction,
          $$KarmaTransactionsTableFilterComposer,
          $$KarmaTransactionsTableOrderingComposer,
          $$KarmaTransactionsTableAnnotationComposer,
          $$KarmaTransactionsTableCreateCompanionBuilder,
          $$KarmaTransactionsTableUpdateCompanionBuilder,
          (
            KarmaTransaction,
            BaseReferences<
              _$AppDatabase,
              $KarmaTransactionsTable,
              KarmaTransaction
            >,
          ),
          KarmaTransaction,
          PrefetchHooks Function()
        > {
  $$KarmaTransactionsTableTableManager(
    _$AppDatabase db,
    $KarmaTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KarmaTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KarmaTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KarmaTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => KarmaTransactionsCompanion(
                id: id,
                userId: userId,
                amount: amount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int amount,
                required DateTime createdAt,
              }) => KarmaTransactionsCompanion.insert(
                id: id,
                userId: userId,
                amount: amount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KarmaTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $KarmaTransactionsTable,
      KarmaTransaction,
      $$KarmaTransactionsTableFilterComposer,
      $$KarmaTransactionsTableOrderingComposer,
      $$KarmaTransactionsTableAnnotationComposer,
      $$KarmaTransactionsTableCreateCompanionBuilder,
      $$KarmaTransactionsTableUpdateCompanionBuilder,
      (
        KarmaTransaction,
        BaseReferences<
          _$AppDatabase,
          $KarmaTransactionsTable,
          KarmaTransaction
        >,
      ),
      KarmaTransaction,
      PrefetchHooks Function()
    >;
typedef $$NutritionGoalsTableCreateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      required String userId,
      required double calorieGoal,
      Value<double> carbsPercent,
      Value<double> proteinPercent,
      Value<double> fatPercent,
      Value<double?> carbsGrams,
      Value<double?> proteinGrams,
      Value<double?> fatGrams,
      Value<double> ironMgRda,
      Value<double> vitaminDMcgRda,
      Value<double> vitaminB12McgRda,
      Value<double> calciumMgRda,
      required DateTime updatedAt,
    });
typedef $$NutritionGoalsTableUpdateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<double> calorieGoal,
      Value<double> carbsPercent,
      Value<double> proteinPercent,
      Value<double> fatPercent,
      Value<double?> carbsGrams,
      Value<double?> proteinGrams,
      Value<double?> fatGrams,
      Value<double> ironMgRda,
      Value<double> vitaminDMcgRda,
      Value<double> vitaminB12McgRda,
      Value<double> calciumMgRda,
      Value<DateTime> updatedAt,
    });

class $$NutritionGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPercent => $composableBuilder(
    column: $table.carbsPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPercent => $composableBuilder(
    column: $table.proteinPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPercent => $composableBuilder(
    column: $table.fatPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsGrams => $composableBuilder(
    column: $table.carbsGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinGrams => $composableBuilder(
    column: $table.proteinGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatGrams => $composableBuilder(
    column: $table.fatGrams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ironMgRda => $composableBuilder(
    column: $table.ironMgRda,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminDMcgRda => $composableBuilder(
    column: $table.vitaminDMcgRda,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vitaminB12McgRda => $composableBuilder(
    column: $table.vitaminB12McgRda,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calciumMgRda => $composableBuilder(
    column: $table.calciumMgRda,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NutritionGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPercent => $composableBuilder(
    column: $table.carbsPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPercent => $composableBuilder(
    column: $table.proteinPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPercent => $composableBuilder(
    column: $table.fatPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsGrams => $composableBuilder(
    column: $table.carbsGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinGrams => $composableBuilder(
    column: $table.proteinGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatGrams => $composableBuilder(
    column: $table.fatGrams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ironMgRda => $composableBuilder(
    column: $table.ironMgRda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminDMcgRda => $composableBuilder(
    column: $table.vitaminDMcgRda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vitaminB12McgRda => $composableBuilder(
    column: $table.vitaminB12McgRda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calciumMgRda => $composableBuilder(
    column: $table.calciumMgRda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NutritionGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
  $$NutritionGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get calorieGoal => $composableBuilder(
    column: $table.calorieGoal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPercent => $composableBuilder(
    column: $table.carbsPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPercent => $composableBuilder(
    column: $table.proteinPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPercent => $composableBuilder(
    column: $table.fatPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsGrams => $composableBuilder(
    column: $table.carbsGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinGrams => $composableBuilder(
    column: $table.proteinGrams,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatGrams =>
      $composableBuilder(column: $table.fatGrams, builder: (column) => column);

  GeneratedColumn<double> get ironMgRda =>
      $composableBuilder(column: $table.ironMgRda, builder: (column) => column);

  GeneratedColumn<double> get vitaminDMcgRda => $composableBuilder(
    column: $table.vitaminDMcgRda,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vitaminB12McgRda => $composableBuilder(
    column: $table.vitaminB12McgRda,
    builder: (column) => column,
  );

  GeneratedColumn<double> get calciumMgRda => $composableBuilder(
    column: $table.calciumMgRda,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NutritionGoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NutritionGoalsTable,
          NutritionGoal,
          $$NutritionGoalsTableFilterComposer,
          $$NutritionGoalsTableOrderingComposer,
          $$NutritionGoalsTableAnnotationComposer,
          $$NutritionGoalsTableCreateCompanionBuilder,
          $$NutritionGoalsTableUpdateCompanionBuilder,
          (
            NutritionGoal,
            BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
          ),
          NutritionGoal,
          PrefetchHooks Function()
        > {
  $$NutritionGoalsTableTableManager(
    _$AppDatabase db,
    $NutritionGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double> calorieGoal = const Value.absent(),
                Value<double> carbsPercent = const Value.absent(),
                Value<double> proteinPercent = const Value.absent(),
                Value<double> fatPercent = const Value.absent(),
                Value<double?> carbsGrams = const Value.absent(),
                Value<double?> proteinGrams = const Value.absent(),
                Value<double?> fatGrams = const Value.absent(),
                Value<double> ironMgRda = const Value.absent(),
                Value<double> vitaminDMcgRda = const Value.absent(),
                Value<double> vitaminB12McgRda = const Value.absent(),
                Value<double> calciumMgRda = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NutritionGoalsCompanion(
                id: id,
                userId: userId,
                calorieGoal: calorieGoal,
                carbsPercent: carbsPercent,
                proteinPercent: proteinPercent,
                fatPercent: fatPercent,
                carbsGrams: carbsGrams,
                proteinGrams: proteinGrams,
                fatGrams: fatGrams,
                ironMgRda: ironMgRda,
                vitaminDMcgRda: vitaminDMcgRda,
                vitaminB12McgRda: vitaminB12McgRda,
                calciumMgRda: calciumMgRda,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required double calorieGoal,
                Value<double> carbsPercent = const Value.absent(),
                Value<double> proteinPercent = const Value.absent(),
                Value<double> fatPercent = const Value.absent(),
                Value<double?> carbsGrams = const Value.absent(),
                Value<double?> proteinGrams = const Value.absent(),
                Value<double?> fatGrams = const Value.absent(),
                Value<double> ironMgRda = const Value.absent(),
                Value<double> vitaminDMcgRda = const Value.absent(),
                Value<double> vitaminB12McgRda = const Value.absent(),
                Value<double> calciumMgRda = const Value.absent(),
                required DateTime updatedAt,
              }) => NutritionGoalsCompanion.insert(
                id: id,
                userId: userId,
                calorieGoal: calorieGoal,
                carbsPercent: carbsPercent,
                proteinPercent: proteinPercent,
                fatPercent: fatPercent,
                carbsGrams: carbsGrams,
                proteinGrams: proteinGrams,
                fatGrams: fatGrams,
                ironMgRda: ironMgRda,
                vitaminDMcgRda: vitaminDMcgRda,
                vitaminB12McgRda: vitaminB12McgRda,
                calciumMgRda: calciumMgRda,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NutritionGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NutritionGoalsTable,
      NutritionGoal,
      $$NutritionGoalsTableFilterComposer,
      $$NutritionGoalsTableOrderingComposer,
      $$NutritionGoalsTableAnnotationComposer,
      $$NutritionGoalsTableCreateCompanionBuilder,
      $$NutritionGoalsTableUpdateCompanionBuilder,
      (
        NutritionGoal,
        BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
      ),
      NutritionGoal,
      PrefetchHooks Function()
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      required String userId,
      required String recordType,
      required DateTime achievedAt,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> recordType,
      Value<DateTime> achievedAt,
    });

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecord,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (
            PersonalRecord,
            BaseReferences<
              _$AppDatabase,
              $PersonalRecordsTable,
              PersonalRecord
            >,
          ),
          PersonalRecord,
          PrefetchHooks Function()
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> recordType = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
              }) => PersonalRecordsCompanion(
                id: id,
                userId: userId,
                recordType: recordType,
                achievedAt: achievedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String recordType,
                required DateTime achievedAt,
              }) => PersonalRecordsCompanion.insert(
                id: id,
                userId: userId,
                recordType: recordType,
                achievedAt: achievedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecord,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (
        PersonalRecord,
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecord>,
      ),
      PersonalRecord,
      PrefetchHooks Function()
    >;
typedef $$RemoteConfigCacheTableCreateCompanionBuilder =
    RemoteConfigCacheCompanion Function({
      Value<int> id,
      required String key,
      required String value,
      required String type,
      required DateTime lastUpdated,
    });
typedef $$RemoteConfigCacheTableUpdateCompanionBuilder =
    RemoteConfigCacheCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<String> type,
      Value<DateTime> lastUpdated,
    });

class $$RemoteConfigCacheTableFilterComposer
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemoteConfigCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemoteConfigCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$RemoteConfigCacheTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemoteConfigCacheTable,
          RemoteConfigCacheData,
          $$RemoteConfigCacheTableFilterComposer,
          $$RemoteConfigCacheTableOrderingComposer,
          $$RemoteConfigCacheTableAnnotationComposer,
          $$RemoteConfigCacheTableCreateCompanionBuilder,
          $$RemoteConfigCacheTableUpdateCompanionBuilder,
          (
            RemoteConfigCacheData,
            BaseReferences<
              _$AppDatabase,
              $RemoteConfigCacheTable,
              RemoteConfigCacheData
            >,
          ),
          RemoteConfigCacheData,
          PrefetchHooks Function()
        > {
  $$RemoteConfigCacheTableTableManager(
    _$AppDatabase db,
    $RemoteConfigCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemoteConfigCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemoteConfigCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemoteConfigCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => RemoteConfigCacheCompanion(
                id: id,
                key: key,
                value: value,
                type: type,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                required String type,
                required DateTime lastUpdated,
              }) => RemoteConfigCacheCompanion.insert(
                id: id,
                key: key,
                value: value,
                type: type,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemoteConfigCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemoteConfigCacheTable,
      RemoteConfigCacheData,
      $$RemoteConfigCacheTableFilterComposer,
      $$RemoteConfigCacheTableOrderingComposer,
      $$RemoteConfigCacheTableAnnotationComposer,
      $$RemoteConfigCacheTableCreateCompanionBuilder,
      $$RemoteConfigCacheTableUpdateCompanionBuilder,
      (
        RemoteConfigCacheData,
        BaseReferences<
          _$AppDatabase,
          $RemoteConfigCacheTable,
          RemoteConfigCacheData
        >,
      ),
      RemoteConfigCacheData,
      PrefetchHooks Function()
    >;
typedef $$LabReportsTableCreateCompanionBuilder =
    LabReportsCompanion Function({
      Value<int> id,
      required String userId,
      required String reportName,
      Value<String?> reportUrl,
      required DateTime uploadedAt,
      Value<String?> labName,
      Value<String?> summaryJson,
      Value<String?> extractedDataJson,
      Value<bool> isEncrypted,
    });
typedef $$LabReportsTableUpdateCompanionBuilder =
    LabReportsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> reportName,
      Value<String?> reportUrl,
      Value<DateTime> uploadedAt,
      Value<String?> labName,
      Value<String?> summaryJson,
      Value<String?> extractedDataJson,
      Value<bool> isEncrypted,
    });

class $$LabReportsTableFilterComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportUrl => $composableBuilder(
    column: $table.reportUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get summaryJson => $composableBuilder(
    column: $table.summaryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractedDataJson => $composableBuilder(
    column: $table.extractedDataJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LabReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportUrl => $composableBuilder(
    column: $table.reportUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get summaryJson => $composableBuilder(
    column: $table.summaryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractedDataJson => $composableBuilder(
    column: $table.extractedDataJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LabReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reportUrl =>
      $composableBuilder(column: $table.reportUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get uploadedAt => $composableBuilder(
    column: $table.uploadedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labName =>
      $composableBuilder(column: $table.labName, builder: (column) => column);

  GeneratedColumn<String> get summaryJson => $composableBuilder(
    column: $table.summaryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extractedDataJson => $composableBuilder(
    column: $table.extractedDataJson,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isEncrypted => $composableBuilder(
    column: $table.isEncrypted,
    builder: (column) => column,
  );
}

class $$LabReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LabReportsTable,
          LabReport,
          $$LabReportsTableFilterComposer,
          $$LabReportsTableOrderingComposer,
          $$LabReportsTableAnnotationComposer,
          $$LabReportsTableCreateCompanionBuilder,
          $$LabReportsTableUpdateCompanionBuilder,
          (
            LabReport,
            BaseReferences<_$AppDatabase, $LabReportsTable, LabReport>,
          ),
          LabReport,
          PrefetchHooks Function()
        > {
  $$LabReportsTableTableManager(_$AppDatabase db, $LabReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> reportName = const Value.absent(),
                Value<String?> reportUrl = const Value.absent(),
                Value<DateTime> uploadedAt = const Value.absent(),
                Value<String?> labName = const Value.absent(),
                Value<String?> summaryJson = const Value.absent(),
                Value<String?> extractedDataJson = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
              }) => LabReportsCompanion(
                id: id,
                userId: userId,
                reportName: reportName,
                reportUrl: reportUrl,
                uploadedAt: uploadedAt,
                labName: labName,
                summaryJson: summaryJson,
                extractedDataJson: extractedDataJson,
                isEncrypted: isEncrypted,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String reportName,
                Value<String?> reportUrl = const Value.absent(),
                required DateTime uploadedAt,
                Value<String?> labName = const Value.absent(),
                Value<String?> summaryJson = const Value.absent(),
                Value<String?> extractedDataJson = const Value.absent(),
                Value<bool> isEncrypted = const Value.absent(),
              }) => LabReportsCompanion.insert(
                id: id,
                userId: userId,
                reportName: reportName,
                reportUrl: reportUrl,
                uploadedAt: uploadedAt,
                labName: labName,
                summaryJson: summaryJson,
                extractedDataJson: extractedDataJson,
                isEncrypted: isEncrypted,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LabReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LabReportsTable,
      LabReport,
      $$LabReportsTableFilterComposer,
      $$LabReportsTableOrderingComposer,
      $$LabReportsTableAnnotationComposer,
      $$LabReportsTableCreateCompanionBuilder,
      $$LabReportsTableUpdateCompanionBuilder,
      (LabReport, BaseReferences<_$AppDatabase, $LabReportsTable, LabReport>),
      LabReport,
      PrefetchHooks Function()
    >;
typedef $$AbhaLinksTableCreateCompanionBuilder =
    AbhaLinksCompanion Function({
      Value<int> id,
      required String userId,
      required String abhaNumber,
      Value<String?> abhaAddress,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> gender,
      Value<DateTime?> dateOfBirth,
      Value<String?> stateCode,
      Value<String?> districtCode,
      Value<bool> isVerified,
      required DateTime linkedAt,
      Value<DateTime?> lastSyncedAt,
    });
typedef $$AbhaLinksTableUpdateCompanionBuilder =
    AbhaLinksCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> abhaNumber,
      Value<String?> abhaAddress,
      Value<String?> firstName,
      Value<String?> lastName,
      Value<String?> gender,
      Value<DateTime?> dateOfBirth,
      Value<String?> stateCode,
      Value<String?> districtCode,
      Value<bool> isVerified,
      Value<DateTime> linkedAt,
      Value<DateTime?> lastSyncedAt,
    });

class $$AbhaLinksTableFilterComposer
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
  $$AbhaLinksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AbhaLinksTableOrderingComposer
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
  $$AbhaLinksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stateCode => $composableBuilder(
    column: $table.stateCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AbhaLinksTableAnnotationComposer
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
  $$AbhaLinksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stateCode =>
      $composableBuilder(column: $table.stateCode, builder: (column) => column);

  GeneratedColumn<String> get districtCode => $composableBuilder(
    column: $table.districtCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get linkedAt =>
      $composableBuilder(column: $table.linkedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSyncedAt => $composableBuilder(
    column: $table.lastSyncedAt,
    builder: (column) => column,
  );
}

class $$AbhaLinksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AbhaLinksTable,
          AbhaLink,
          $$AbhaLinksTableFilterComposer,
          $$AbhaLinksTableOrderingComposer,
          $$AbhaLinksTableAnnotationComposer,
          $$AbhaLinksTableCreateCompanionBuilder,
          $$AbhaLinksTableUpdateCompanionBuilder,
          (AbhaLink, BaseReferences<_$AppDatabase, $AbhaLinksTable, AbhaLink>),
          AbhaLink,
          PrefetchHooks Function()
        > {
  $$AbhaLinksTableTableManager(_$AppDatabase db, $AbhaLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbhaLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbhaLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbhaLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> abhaNumber = const Value.absent(),
                Value<String?> abhaAddress = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> stateCode = const Value.absent(),
                Value<String?> districtCode = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime> linkedAt = const Value.absent(),
                Value<DateTime?> lastSyncedAt = const Value.absent(),
              }) => AbhaLinksCompanion(
                id: id,
                userId: userId,
                abhaNumber: abhaNumber,
                abhaAddress: abhaAddress,
                firstName: firstName,
                lastName: lastName,
                gender: gender,
                dateOfBirth: dateOfBirth,
                stateCode: stateCode,
                districtCode: districtCode,
                isVerified: isVerified,
                linkedAt: linkedAt,
                lastSyncedAt: lastSyncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String abhaNumber,
                Value<String?> abhaAddress = const Value.absent(),
                Value<String?> firstName = const Value.absent(),
                Value<String?> lastName = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> stateCode = const Value.absent(),
                Value<String?> districtCode = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                required DateTime linkedAt,
                Value<DateTime?> lastSyncedAt = const Value.absent(),
              }) => AbhaLinksCompanion.insert(
                id: id,
                userId: userId,
                abhaNumber: abhaNumber,
                abhaAddress: abhaAddress,
                firstName: firstName,
                lastName: lastName,
                gender: gender,
                dateOfBirth: dateOfBirth,
                stateCode: stateCode,
                districtCode: districtCode,
                isVerified: isVerified,
                linkedAt: linkedAt,
                lastSyncedAt: lastSyncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AbhaLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AbhaLinksTable,
      AbhaLink,
      $$AbhaLinksTableFilterComposer,
      $$AbhaLinksTableOrderingComposer,
      $$AbhaLinksTableAnnotationComposer,
      $$AbhaLinksTableCreateCompanionBuilder,
      $$AbhaLinksTableUpdateCompanionBuilder,
      (AbhaLink, BaseReferences<_$AppDatabase, $AbhaLinksTable, AbhaLink>),
      AbhaLink,
      PrefetchHooks Function()
    >;
typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      required String odUserId,
      required String name,
      required String gender,
      required DateTime dateOfBirth,
      required double heightCm,
      required double weightKg,
      required String fitnessGoal,
      required String activityLevel,
      required String chronicConditions,
      required int vataPercent,
      required int pittaPercent,
      required int kaphaPercent,
      required String language,
      Value<bool> stepCounterPermission,
      Value<bool> heartRatePermission,
      Value<bool> sleepPermission,
      Value<String?> abhaNumber,
      Value<bool> wearableConnected,
      Value<int> karmaXp,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> odUserId,
      Value<String> name,
      Value<String> gender,
      Value<DateTime> dateOfBirth,
      Value<double> heightCm,
      Value<double> weightKg,
      Value<String> fitnessGoal,
      Value<String> activityLevel,
      Value<String> chronicConditions,
      Value<int> vataPercent,
      Value<int> pittaPercent,
      Value<int> kaphaPercent,
      Value<String> language,
      Value<bool> stepCounterPermission,
      Value<bool> heartRatePermission,
      Value<bool> sleepPermission,
      Value<String?> abhaNumber,
      Value<bool> wearableConnected,
      Value<int> karmaXp,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get odUserId => $composableBuilder(
    column: $table.odUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fitnessGoal => $composableBuilder(
    column: $table.fitnessGoal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chronicConditions => $composableBuilder(
    column: $table.chronicConditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get vataPercent => $composableBuilder(
    column: $table.vataPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pittaPercent => $composableBuilder(
    column: $table.pittaPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kaphaPercent => $composableBuilder(
    column: $table.kaphaPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get stepCounterPermission => $composableBuilder(
    column: $table.stepCounterPermission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get heartRatePermission => $composableBuilder(
    column: $table.heartRatePermission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get sleepPermission => $composableBuilder(
    column: $table.sleepPermission,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get wearableConnected => $composableBuilder(
    column: $table.wearableConnected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get karmaXp => $composableBuilder(
    column: $table.karmaXp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get odUserId => $composableBuilder(
    column: $table.odUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fitnessGoal => $composableBuilder(
    column: $table.fitnessGoal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chronicConditions => $composableBuilder(
    column: $table.chronicConditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get vataPercent => $composableBuilder(
    column: $table.vataPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pittaPercent => $composableBuilder(
    column: $table.pittaPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kaphaPercent => $composableBuilder(
    column: $table.kaphaPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get stepCounterPermission => $composableBuilder(
    column: $table.stepCounterPermission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get heartRatePermission => $composableBuilder(
    column: $table.heartRatePermission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get sleepPermission => $composableBuilder(
    column: $table.sleepPermission,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get wearableConnected => $composableBuilder(
    column: $table.wearableConnected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get karmaXp => $composableBuilder(
    column: $table.karmaXp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get odUserId =>
      $composableBuilder(column: $table.odUserId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get fitnessGoal => $composableBuilder(
    column: $table.fitnessGoal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityLevel => $composableBuilder(
    column: $table.activityLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get chronicConditions => $composableBuilder(
    column: $table.chronicConditions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get vataPercent => $composableBuilder(
    column: $table.vataPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pittaPercent => $composableBuilder(
    column: $table.pittaPercent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kaphaPercent => $composableBuilder(
    column: $table.kaphaPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<bool> get stepCounterPermission => $composableBuilder(
    column: $table.stepCounterPermission,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get heartRatePermission => $composableBuilder(
    column: $table.heartRatePermission,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get sleepPermission => $composableBuilder(
    column: $table.sleepPermission,
    builder: (column) => column,
  );

  GeneratedColumn<String> get abhaNumber => $composableBuilder(
    column: $table.abhaNumber,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get wearableConnected => $composableBuilder(
    column: $table.wearableConnected,
    builder: (column) => column,
  );

  GeneratedColumn<int> get karmaXp =>
      $composableBuilder(column: $table.karmaXp, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> odUserId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<String> fitnessGoal = const Value.absent(),
                Value<String> activityLevel = const Value.absent(),
                Value<String> chronicConditions = const Value.absent(),
                Value<int> vataPercent = const Value.absent(),
                Value<int> pittaPercent = const Value.absent(),
                Value<int> kaphaPercent = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<bool> stepCounterPermission = const Value.absent(),
                Value<bool> heartRatePermission = const Value.absent(),
                Value<bool> sleepPermission = const Value.absent(),
                Value<String?> abhaNumber = const Value.absent(),
                Value<bool> wearableConnected = const Value.absent(),
                Value<int> karmaXp = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                odUserId: odUserId,
                name: name,
                gender: gender,
                dateOfBirth: dateOfBirth,
                heightCm: heightCm,
                weightKg: weightKg,
                fitnessGoal: fitnessGoal,
                activityLevel: activityLevel,
                chronicConditions: chronicConditions,
                vataPercent: vataPercent,
                pittaPercent: pittaPercent,
                kaphaPercent: kaphaPercent,
                language: language,
                stepCounterPermission: stepCounterPermission,
                heartRatePermission: heartRatePermission,
                sleepPermission: sleepPermission,
                abhaNumber: abhaNumber,
                wearableConnected: wearableConnected,
                karmaXp: karmaXp,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String odUserId,
                required String name,
                required String gender,
                required DateTime dateOfBirth,
                required double heightCm,
                required double weightKg,
                required String fitnessGoal,
                required String activityLevel,
                required String chronicConditions,
                required int vataPercent,
                required int pittaPercent,
                required int kaphaPercent,
                required String language,
                Value<bool> stepCounterPermission = const Value.absent(),
                Value<bool> heartRatePermission = const Value.absent(),
                Value<bool> sleepPermission = const Value.absent(),
                Value<String?> abhaNumber = const Value.absent(),
                Value<bool> wearableConnected = const Value.absent(),
                Value<int> karmaXp = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => UserProfilesCompanion.insert(
                id: id,
                odUserId: odUserId,
                name: name,
                gender: gender,
                dateOfBirth: dateOfBirth,
                heightCm: heightCm,
                weightKg: weightKg,
                fitnessGoal: fitnessGoal,
                activityLevel: activityLevel,
                chronicConditions: chronicConditions,
                vataPercent: vataPercent,
                pittaPercent: pittaPercent,
                kaphaPercent: kaphaPercent,
                language: language,
                stepCounterPermission: stepCounterPermission,
                heartRatePermission: heartRatePermission,
                sleepPermission: sleepPermission,
                abhaNumber: abhaNumber,
                wearableConnected: wearableConnected,
                karmaXp: karmaXp,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$EmergencyCardTableCreateCompanionBuilder =
    EmergencyCardCompanion Function({
      Value<int> id,
      required String userId,
      Value<String?> bloodGroup,
      Value<String?> allergies,
      Value<String?> emergencyContact,
      Value<String?> conditions,
      required DateTime updatedAt,
    });
typedef $$EmergencyCardTableUpdateCompanionBuilder =
    EmergencyCardCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String?> bloodGroup,
      Value<String?> allergies,
      Value<String?> emergencyContact,
      Value<String?> conditions,
      Value<DateTime> updatedAt,
    });

class $$EmergencyCardTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyCardTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyCardTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get bloodGroup => $composableBuilder(
    column: $table.bloodGroup,
    builder: (column) => column,
  );

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get emergencyContact => $composableBuilder(
    column: $table.emergencyContact,
    builder: (column) => column,
  );

  GeneratedColumn<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmergencyCardTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyCardTable,
          EmergencyCardData,
          $$EmergencyCardTableFilterComposer,
          $$EmergencyCardTableOrderingComposer,
          $$EmergencyCardTableAnnotationComposer,
          $$EmergencyCardTableCreateCompanionBuilder,
          $$EmergencyCardTableUpdateCompanionBuilder,
          (
            EmergencyCardData,
            BaseReferences<
              _$AppDatabase,
              $EmergencyCardTable,
              EmergencyCardData
            >,
          ),
          EmergencyCardData,
          PrefetchHooks Function()
        > {
  $$EmergencyCardTableTableManager(_$AppDatabase db, $EmergencyCardTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyCardTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyCardTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyCardTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> bloodGroup = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> emergencyContact = const Value.absent(),
                Value<String?> conditions = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EmergencyCardCompanion(
                id: id,
                userId: userId,
                bloodGroup: bloodGroup,
                allergies: allergies,
                emergencyContact: emergencyContact,
                conditions: conditions,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                Value<String?> bloodGroup = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> emergencyContact = const Value.absent(),
                Value<String?> conditions = const Value.absent(),
                required DateTime updatedAt,
              }) => EmergencyCardCompanion.insert(
                id: id,
                userId: userId,
                bloodGroup: bloodGroup,
                allergies: allergies,
                emergencyContact: emergencyContact,
                conditions: conditions,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyCardTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyCardTable,
      EmergencyCardData,
      $$EmergencyCardTableFilterComposer,
      $$EmergencyCardTableOrderingComposer,
      $$EmergencyCardTableAnnotationComposer,
      $$EmergencyCardTableCreateCompanionBuilder,
      $$EmergencyCardTableUpdateCompanionBuilder,
      (
        EmergencyCardData,
        BaseReferences<_$AppDatabase, $EmergencyCardTable, EmergencyCardData>,
      ),
      EmergencyCardData,
      PrefetchHooks Function()
    >;
typedef $$FestivalCalendarTableCreateCompanionBuilder =
    FestivalCalendarCompanion Function({
      Value<int> id,
      required String name,
      required DateTime date,
      Value<String?> region,
      Value<String?> type,
    });
typedef $$FestivalCalendarTableUpdateCompanionBuilder =
    FestivalCalendarCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> date,
      Value<String?> region,
      Value<String?> type,
    });

class $$FestivalCalendarTableFilterComposer
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
  $$FestivalCalendarTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FestivalCalendarTableOrderingComposer
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
  $$FestivalCalendarTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FestivalCalendarTableAnnotationComposer
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
  $$FestivalCalendarTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$FestivalCalendarTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FestivalCalendarTable,
          FestivalCalendarData,
          $$FestivalCalendarTableFilterComposer,
          $$FestivalCalendarTableOrderingComposer,
          $$FestivalCalendarTableAnnotationComposer,
          $$FestivalCalendarTableCreateCompanionBuilder,
          $$FestivalCalendarTableUpdateCompanionBuilder,
          (
            FestivalCalendarData,
            BaseReferences<
              _$AppDatabase,
              $FestivalCalendarTable,
              FestivalCalendarData
            >,
          ),
          FestivalCalendarData,
          PrefetchHooks Function()
        > {
  $$FestivalCalendarTableTableManager(
    _$AppDatabase db,
    $FestivalCalendarTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FestivalCalendarTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FestivalCalendarTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FestivalCalendarTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> type = const Value.absent(),
              }) => FestivalCalendarCompanion(
                id: id,
                name: name,
                date: date,
                region: region,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime date,
                Value<String?> region = const Value.absent(),
                Value<String?> type = const Value.absent(),
              }) => FestivalCalendarCompanion.insert(
                id: id,
                name: name,
                date: date,
                region: region,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FestivalCalendarTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FestivalCalendarTable,
      FestivalCalendarData,
      $$FestivalCalendarTableFilterComposer,
      $$FestivalCalendarTableOrderingComposer,
      $$FestivalCalendarTableAnnotationComposer,
      $$FestivalCalendarTableCreateCompanionBuilder,
      $$FestivalCalendarTableUpdateCompanionBuilder,
      (
        FestivalCalendarData,
        BaseReferences<
          _$AppDatabase,
          $FestivalCalendarTable,
          FestivalCalendarData
        >,
      ),
      FestivalCalendarData,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String recordTable,
      required int recordId,
      required String operation,
      required String payloadJson,
      required DateTime createdAt,
      Value<int> retryCount,
      required String status,
      Value<int> priority,
      required String idempotencyKey,
      Value<String?> errorMessage,
      Value<DateTime?> lastAttemptAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> recordTable,
      Value<int> recordId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<String> status,
      Value<int> priority,
      Value<String> idempotencyKey,
      Value<String?> errorMessage,
      Value<DateTime?> lastAttemptAt,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recordTable = const Value.absent(),
                Value<int> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                recordTable: recordTable,
                recordId: recordId,
                operation: operation,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                status: status,
                priority: priority,
                idempotencyKey: idempotencyKey,
                errorMessage: errorMessage,
                lastAttemptAt: lastAttemptAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recordTable,
                required int recordId,
                required String operation,
                required String payloadJson,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                required String status,
                Value<int> priority = const Value.absent(),
                required String idempotencyKey,
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                recordTable: recordTable,
                recordId: recordId,
                operation: operation,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                status: status,
                priority: priority,
                idempotencyKey: idempotencyKey,
                errorMessage: errorMessage,
                lastAttemptAt: lastAttemptAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$SyncDeadLetterTableCreateCompanionBuilder =
    SyncDeadLetterCompanion Function({
      Value<int> id,
      required String recordTable,
      required int recordId,
      required String operation,
      required String payloadJson,
      required String error,
      required DateTime failedAt,
    });
typedef $$SyncDeadLetterTableUpdateCompanionBuilder =
    SyncDeadLetterCompanion Function({
      Value<int> id,
      Value<String> recordTable,
      Value<int> recordId,
      Value<String> operation,
      Value<String> payloadJson,
      Value<String> error,
      Value<DateTime> failedAt,
    });

class $$SyncDeadLetterTableFilterComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get failedAt => $composableBuilder(
    column: $table.failedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncDeadLetterTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get error => $composableBuilder(
    column: $table.error,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get failedAt => $composableBuilder(
    column: $table.failedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncDeadLetterTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordTable => $composableBuilder(
    column: $table.recordTable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get error =>
      $composableBuilder(column: $table.error, builder: (column) => column);

  GeneratedColumn<DateTime> get failedAt =>
      $composableBuilder(column: $table.failedAt, builder: (column) => column);
}

class $$SyncDeadLetterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncDeadLetterTable,
          SyncDeadLetterData,
          $$SyncDeadLetterTableFilterComposer,
          $$SyncDeadLetterTableOrderingComposer,
          $$SyncDeadLetterTableAnnotationComposer,
          $$SyncDeadLetterTableCreateCompanionBuilder,
          $$SyncDeadLetterTableUpdateCompanionBuilder,
          (
            SyncDeadLetterData,
            BaseReferences<
              _$AppDatabase,
              $SyncDeadLetterTable,
              SyncDeadLetterData
            >,
          ),
          SyncDeadLetterData,
          PrefetchHooks Function()
        > {
  $$SyncDeadLetterTableTableManager(
    _$AppDatabase db,
    $SyncDeadLetterTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncDeadLetterTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncDeadLetterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncDeadLetterTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> recordTable = const Value.absent(),
                Value<int> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<String> error = const Value.absent(),
                Value<DateTime> failedAt = const Value.absent(),
              }) => SyncDeadLetterCompanion(
                id: id,
                recordTable: recordTable,
                recordId: recordId,
                operation: operation,
                payloadJson: payloadJson,
                error: error,
                failedAt: failedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String recordTable,
                required int recordId,
                required String operation,
                required String payloadJson,
                required String error,
                required DateTime failedAt,
              }) => SyncDeadLetterCompanion.insert(
                id: id,
                recordTable: recordTable,
                recordId: recordId,
                operation: operation,
                payloadJson: payloadJson,
                error: error,
                failedAt: failedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncDeadLetterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncDeadLetterTable,
      SyncDeadLetterData,
      $$SyncDeadLetterTableFilterComposer,
      $$SyncDeadLetterTableOrderingComposer,
      $$SyncDeadLetterTableAnnotationComposer,
      $$SyncDeadLetterTableCreateCompanionBuilder,
      $$SyncDeadLetterTableUpdateCompanionBuilder,
      (
        SyncDeadLetterData,
        BaseReferences<_$AppDatabase, $SyncDeadLetterTable, SyncDeadLetterData>,
      ),
      SyncDeadLetterData,
      PrefetchHooks Function()
    >;
typedef $$FoodItemsFtsTableCreateCompanionBuilder =
    FoodItemsFtsCompanion Function({
      Value<int> rowid,
      required String name,
      required double caloriesPer100g,
      required double proteinPer100g,
      required double carbsPer100g,
      required double fatPer100g,
    });
typedef $$FoodItemsFtsTableUpdateCompanionBuilder =
    FoodItemsFtsCompanion Function({
      Value<int> rowid,
      Value<String> name,
      Value<double> caloriesPer100g,
      Value<double> proteinPer100g,
      Value<double> carbsPer100g,
      Value<double> fatPer100g,
    });

class $$FoodItemsFtsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsFtsTable> {
  $$FoodItemsFtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get rowid => $composableBuilder(
    column: $table.rowid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodItemsFtsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsFtsTable> {
  $$FoodItemsFtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get rowid => $composableBuilder(
    column: $table.rowid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodItemsFtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsFtsTable> {
  $$FoodItemsFtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get rowid =>
      $composableBuilder(column: $table.rowid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );
}

class $$FoodItemsFtsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsFtsTable,
          FoodItemsFt,
          $$FoodItemsFtsTableFilterComposer,
          $$FoodItemsFtsTableOrderingComposer,
          $$FoodItemsFtsTableAnnotationComposer,
          $$FoodItemsFtsTableCreateCompanionBuilder,
          $$FoodItemsFtsTableUpdateCompanionBuilder,
          (
            FoodItemsFt,
            BaseReferences<_$AppDatabase, $FoodItemsFtsTable, FoodItemsFt>,
          ),
          FoodItemsFt,
          PrefetchHooks Function()
        > {
  $$FoodItemsFtsTableTableManager(_$AppDatabase db, $FoodItemsFtsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsFtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsFtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsFtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> rowid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> caloriesPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
              }) => FoodItemsFtsCompanion(
                rowid: rowid,
                name: name,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
              ),
          createCompanionCallback:
              ({
                Value<int> rowid = const Value.absent(),
                required String name,
                required double caloriesPer100g,
                required double proteinPer100g,
                required double carbsPer100g,
                required double fatPer100g,
              }) => FoodItemsFtsCompanion.insert(
                rowid: rowid,
                name: name,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodItemsFtsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsFtsTable,
      FoodItemsFt,
      $$FoodItemsFtsTableFilterComposer,
      $$FoodItemsFtsTableOrderingComposer,
      $$FoodItemsFtsTableAnnotationComposer,
      $$FoodItemsFtsTableCreateCompanionBuilder,
      $$FoodItemsFtsTableUpdateCompanionBuilder,
      (
        FoodItemsFt,
        BaseReferences<_$AppDatabase, $FoodItemsFtsTable, FoodItemsFt>,
      ),
      FoodItemsFt,
      PrefetchHooks Function()
    >;
typedef $$InsightFeedbackTableCreateCompanionBuilder =
    InsightFeedbackCompanion Function({
      Value<int> id,
      required String odUserId,
      required String ruleId,
      Value<bool> thumbsUp,
      Value<bool> thumbsDown,
      required DateTime generatedAt,
    });
typedef $$InsightFeedbackTableUpdateCompanionBuilder =
    InsightFeedbackCompanion Function({
      Value<int> id,
      Value<String> odUserId,
      Value<String> ruleId,
      Value<bool> thumbsUp,
      Value<bool> thumbsDown,
      Value<DateTime> generatedAt,
    });

class $$InsightFeedbackTableFilterComposer
    extends Composer<_$AppDatabase, $InsightFeedbackTable> {
  $$InsightFeedbackTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get odUserId => $composableBuilder(
    column: $table.odUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get thumbsUp => $composableBuilder(
    column: $table.thumbsUp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get thumbsDown => $composableBuilder(
    column: $table.thumbsDown,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InsightFeedbackTableOrderingComposer
    extends Composer<_$AppDatabase, $InsightFeedbackTable> {
  $$InsightFeedbackTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get odUserId => $composableBuilder(
    column: $table.odUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruleId => $composableBuilder(
    column: $table.ruleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get thumbsUp => $composableBuilder(
    column: $table.thumbsUp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get thumbsDown => $composableBuilder(
    column: $table.thumbsDown,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InsightFeedbackTableAnnotationComposer
    extends Composer<_$AppDatabase, $InsightFeedbackTable> {
  $$InsightFeedbackTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get odUserId =>
      $composableBuilder(column: $table.odUserId, builder: (column) => column);

  GeneratedColumn<String> get ruleId =>
      $composableBuilder(column: $table.ruleId, builder: (column) => column);

  GeneratedColumn<bool> get thumbsUp =>
      $composableBuilder(column: $table.thumbsUp, builder: (column) => column);

  GeneratedColumn<bool> get thumbsDown => $composableBuilder(
    column: $table.thumbsDown,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );
}

class $$InsightFeedbackTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InsightFeedbackTable,
          InsightFeedbackData,
          $$InsightFeedbackTableFilterComposer,
          $$InsightFeedbackTableOrderingComposer,
          $$InsightFeedbackTableAnnotationComposer,
          $$InsightFeedbackTableCreateCompanionBuilder,
          $$InsightFeedbackTableUpdateCompanionBuilder,
          (
            InsightFeedbackData,
            BaseReferences<
              _$AppDatabase,
              $InsightFeedbackTable,
              InsightFeedbackData
            >,
          ),
          InsightFeedbackData,
          PrefetchHooks Function()
        > {
  $$InsightFeedbackTableTableManager(
    _$AppDatabase db,
    $InsightFeedbackTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InsightFeedbackTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InsightFeedbackTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InsightFeedbackTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> odUserId = const Value.absent(),
                Value<String> ruleId = const Value.absent(),
                Value<bool> thumbsUp = const Value.absent(),
                Value<bool> thumbsDown = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
              }) => InsightFeedbackCompanion(
                id: id,
                odUserId: odUserId,
                ruleId: ruleId,
                thumbsUp: thumbsUp,
                thumbsDown: thumbsDown,
                generatedAt: generatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String odUserId,
                required String ruleId,
                Value<bool> thumbsUp = const Value.absent(),
                Value<bool> thumbsDown = const Value.absent(),
                required DateTime generatedAt,
              }) => InsightFeedbackCompanion.insert(
                id: id,
                odUserId: odUserId,
                ruleId: ruleId,
                thumbsUp: thumbsUp,
                thumbsDown: thumbsDown,
                generatedAt: generatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InsightFeedbackTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InsightFeedbackTable,
      InsightFeedbackData,
      $$InsightFeedbackTableFilterComposer,
      $$InsightFeedbackTableOrderingComposer,
      $$InsightFeedbackTableAnnotationComposer,
      $$InsightFeedbackTableCreateCompanionBuilder,
      $$InsightFeedbackTableUpdateCompanionBuilder,
      (
        InsightFeedbackData,
        BaseReferences<
          _$AppDatabase,
          $InsightFeedbackTable,
          InsightFeedbackData
        >,
      ),
      InsightFeedbackData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db, _db.foodLogs);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db, _db.workoutLogs);
  $$StepLogsTableTableManager get stepLogs =>
      $$StepLogsTableTableManager(_db, _db.stepLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$MoodLogsTableTableManager get moodLogs =>
      $$MoodLogsTableTableManager(_db, _db.moodLogs);
  $$BloodPressureLogsTableTableManager get bloodPressureLogs =>
      $$BloodPressureLogsTableTableManager(_db, _db.bloodPressureLogs);
  $$GlucoseLogsTableTableManager get glucoseLogs =>
      $$GlucoseLogsTableTableManager(_db, _db.glucoseLogs);
  $$Spo2LogsTableTableManager get spo2Logs =>
      $$Spo2LogsTableTableManager(_db, _db.spo2Logs);
  $$PeriodLogsTableTableManager get periodLogs =>
      $$PeriodLogsTableTableManager(_db, _db.periodLogs);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(_db, _db.habitCompletions);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(_db, _db.bodyMeasurements);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$FastingLogsTableTableManager get fastingLogs =>
      $$FastingLogsTableTableManager(_db, _db.fastingLogs);
  $$MealPlansTableTableManager get mealPlans =>
      $$MealPlansTableTableManager(_db, _db.mealPlans);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$DoctorAppointmentsTableTableManager get doctorAppointments =>
      $$DoctorAppointmentsTableTableManager(_db, _db.doctorAppointments);
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(_db, _db.karmaTransactions);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(_db, _db.nutritionGoals);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(_db, _db.remoteConfigCache);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db, _db.labReports);
  $$AbhaLinksTableTableManager get abhaLinks =>
      $$AbhaLinksTableTableManager(_db, _db.abhaLinks);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$EmergencyCardTableTableManager get emergencyCard =>
      $$EmergencyCardTableTableManager(_db, _db.emergencyCard);
  $$FestivalCalendarTableTableManager get festivalCalendar =>
      $$FestivalCalendarTableTableManager(_db, _db.festivalCalendar);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SyncDeadLetterTableTableManager get syncDeadLetter =>
      $$SyncDeadLetterTableTableManager(_db, _db.syncDeadLetter);
  $$FoodItemsFtsTableTableManager get foodItemsFts =>
      $$FoodItemsFtsTableTableManager(_db, _db.foodItemsFts);
  $$InsightFeedbackTableTableManager get insightFeedback =>
      $$InsightFeedbackTableTableManager(_db, _db.insightFeedback);
}
