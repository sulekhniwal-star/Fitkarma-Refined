// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_logs_dao.dart';

// ignore_for_file: type=lint
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
