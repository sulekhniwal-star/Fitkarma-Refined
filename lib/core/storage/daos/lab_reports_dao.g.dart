// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_reports_dao.dart';

// ignore_for_file: type=lint
mixin _$LabReportsDaoMixin on DatabaseAccessor<AppDatabase> {
  $LabReportsTable get labReports => attachedDatabase.labReports;
  LabReportsDaoManager get managers => LabReportsDaoManager(this);
}

class LabReportsDaoManager {
  final _$LabReportsDaoMixin _db;
  LabReportsDaoManager(this._db);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db.attachedDatabase, _db.labReports);
}
