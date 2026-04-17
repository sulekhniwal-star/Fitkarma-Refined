// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health_dao.dart';

// ignore_for_file: type=lint
mixin _$HealthDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkoutLogsTable get workoutLogs => attachedDatabase.workoutLogs;
  $StepLogsTable get stepLogs => attachedDatabase.stepLogs;
  $SleepLogsTable get sleepLogs => attachedDatabase.sleepLogs;
  $MoodLogsTable get moodLogs => attachedDatabase.moodLogs;
  $MedicationsTable get medications => attachedDatabase.medications;
  $HabitsTable get habits => attachedDatabase.habits;
  $HabitCompletionsTable get habitCompletions =>
      attachedDatabase.habitCompletions;
  $BodyMeasurementsTable get bodyMeasurements =>
      attachedDatabase.bodyMeasurements;
  $FastingLogsTable get fastingLogs => attachedDatabase.fastingLogs;
  $HeartRateLogsTable get heartRateLogs => attachedDatabase.heartRateLogs;
  $BloodPressureLogsTable get bloodPressureLogs =>
      attachedDatabase.bloodPressureLogs;
  $GlucoseLogsTable get glucoseLogs => attachedDatabase.glucoseLogs;
  $Spo2LogsTable get spo2Logs => attachedDatabase.spo2Logs;
  $PeriodLogsTable get periodLogs => attachedDatabase.periodLogs;
  HealthDaoManager get managers => HealthDaoManager(this);
}

class HealthDaoManager {
  final _$HealthDaoMixin _db;
  HealthDaoManager(this._db);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db.attachedDatabase, _db.workoutLogs);
  $$StepLogsTableTableManager get stepLogs =>
      $$StepLogsTableTableManager(_db.attachedDatabase, _db.stepLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db.attachedDatabase, _db.sleepLogs);
  $$MoodLogsTableTableManager get moodLogs =>
      $$MoodLogsTableTableManager(_db.attachedDatabase, _db.moodLogs);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db.attachedDatabase, _db.medications);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db.attachedDatabase, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(
        _db.attachedDatabase,
        _db.habitCompletions,
      );
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(
        _db.attachedDatabase,
        _db.bodyMeasurements,
      );
  $$FastingLogsTableTableManager get fastingLogs =>
      $$FastingLogsTableTableManager(_db.attachedDatabase, _db.fastingLogs);
  $$HeartRateLogsTableTableManager get heartRateLogs =>
      $$HeartRateLogsTableTableManager(_db.attachedDatabase, _db.heartRateLogs);
  $$BloodPressureLogsTableTableManager get bloodPressureLogs =>
      $$BloodPressureLogsTableTableManager(
        _db.attachedDatabase,
        _db.bloodPressureLogs,
      );
  $$GlucoseLogsTableTableManager get glucoseLogs =>
      $$GlucoseLogsTableTableManager(_db.attachedDatabase, _db.glucoseLogs);
  $$Spo2LogsTableTableManager get spo2Logs =>
      $$Spo2LogsTableTableManager(_db.attachedDatabase, _db.spo2Logs);
  $$PeriodLogsTableTableManager get periodLogs =>
      $$PeriodLogsTableTableManager(_db.attachedDatabase, _db.periodLogs);
}
