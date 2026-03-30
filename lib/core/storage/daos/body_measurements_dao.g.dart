// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_measurements_dao.dart';

// ignore_for_file: type=lint
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
