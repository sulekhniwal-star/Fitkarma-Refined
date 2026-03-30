// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glucose_logs_dao.dart';

// ignore_for_file: type=lint
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
