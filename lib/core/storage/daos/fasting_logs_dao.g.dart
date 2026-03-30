// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fasting_logs_dao.dart';

// ignore_for_file: type=lint
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
