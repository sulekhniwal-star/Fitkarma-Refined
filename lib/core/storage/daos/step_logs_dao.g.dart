// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_logs_dao.dart';

// ignore_for_file: type=lint
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
