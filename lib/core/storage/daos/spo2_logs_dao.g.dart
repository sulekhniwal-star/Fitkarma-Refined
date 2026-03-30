// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spo2_logs_dao.dart';

// ignore_for_file: type=lint
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
