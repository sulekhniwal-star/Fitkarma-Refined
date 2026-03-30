// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_logs_dao.dart';

// ignore_for_file: type=lint
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
