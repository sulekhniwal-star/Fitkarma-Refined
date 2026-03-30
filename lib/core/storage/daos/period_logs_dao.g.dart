// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'period_logs_dao.dart';

// ignore_for_file: type=lint
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
