// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_logs_dao.dart';

// ignore_for_file: type=lint
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
