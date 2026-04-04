import 'package:drift/drift.dart';

@DataClassName('BloodPressureLog')
class BloodPressureLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get systolic => integer()();
  IntColumn get diastolic => integer()();
  IntColumn get pulse => integer().nullable()();
  TextColumn get classification => text()(); // enum normal/stage1/stage2/crisis
  TextColumn get notes => text().nullable()(); // encrypted manually in service
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GlucoseLog')
class GlucoseLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  RealColumn get valueMgDl => real()();
  TextColumn get testType => text()(); // enum fasting/after_meal/random
  TextColumn get notes => text().nullable()(); // encrypted manually in service
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Spo2Log')
class Spo2Logs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  IntColumn get valuePercent => integer()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('PeriodLog')
class PeriodLogs extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  TextColumn get flowIntensity => text().nullable()(); // light/medium/heavy
  TextColumn get symptoms => text().nullable()(); // JSON encrypted
  TextColumn get notes => text().nullable()(); // encrypted
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('JournalEntry')
class JournalEntries extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get content => text()(); // encrypted manually
  TextColumn get moodTags => text().nullable()(); // JSON
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('DoctorAppointment')
class DoctorAppointments extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get doctorName => text()();
  TextColumn get specialty => text().nullable()();
  TextColumn get reason => text().nullable()(); // encrypted
  DateTimeColumn get appointmentDate => dateTime()();
  TextColumn get location => text().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('LabReport')
class LabReports extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get reportTitle => text()();
  DateTimeColumn get reportDate => dateTime()();
  TextColumn get labsName => text().nullable()();
  TextColumn get extractedValues => text().nullable()(); // JSON
  TextColumn get fileUrl => text().nullable()(); // Appwrite storage ID
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('AbhaLink')
class AbhaLinks extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get abhaAddress => text()();
  TextColumn get abhaNumber => text().nullable()();
  BoolColumn get isVerified => boolean().withDefault(const Constant(false))();
  DateTimeColumn get linkedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
