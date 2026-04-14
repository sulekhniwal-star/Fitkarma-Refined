import 'package:drift/drift.dart';

@DataClassName('BloodPressureLog')
class BloodPressureLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get systolic => text()(); // Encrypted TextColumn
  TextColumn get diastolic => text()(); // Encrypted TextColumn
  TextColumn get pulse => text().nullable()(); // Encrypted TextColumn
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()(); // normal, high, etc.
  TextColumn get notes => text().nullable()();
  TextColumn get source => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get idempotencyKey => text()();
}

@DataClassName('GlucoseLog')
class GlucoseLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get glucoseMgdl => text()(); // Encrypted TextColumn
  TextColumn get readingType => text()(); // fasting, post_meal, etc.
  TextColumn get foodLogId => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()();
  TextColumn get hba1cEstimate => text().nullable()(); // Encrypted TextColumn
  TextColumn get notes => text().nullable()();
  TextColumn get source => text()();
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  TextColumn get idempotencyKey => text()();
}

@DataClassName('Spo2Log')
class Spo2Logs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get spo2Percent => text()(); // Encrypted TextColumn
  TextColumn get pulse => text().nullable()(); // Encrypted TextColumn
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get source => text()();
}

@DataClassName('PeriodLog')
class PeriodLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get cycleStartEncrypted => text()(); // Encrypted DateTime string
  TextColumn get cycleEndEncrypted => text().nullable()(); // Encrypted DateTime string
  TextColumn get symptomsEncrypted => text().nullable()(); // Encrypted
  TextColumn get flowIntensityEncrypted => text().nullable()(); // Encrypted
  TextColumn get notesEncrypted => text().nullable()(); // Encrypted
  TextColumn get syncStatus => text().nullable()();
  TextColumn get idempotencyKey => text().nullable()();
}

@DataClassName('JournalEntry')
class JournalEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get contentEncrypted => text()(); // Encrypted TextColumn
  IntColumn get moodScore => integer().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get promptUsed => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get syncStatus => text().nullable()();
}

@DataClassName('DoctorAppointment')
class DoctorAppointments extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get doctorNameEncrypted => text()(); // Encrypted TextColumn
  TextColumn get specialityEncrypted => text().nullable()();
  TextColumn get appointmentDtEncrypted => text()(); // Encrypted ISO string
  TextColumn get notesEncrypted => text().nullable()();
  BoolColumn get reminderSent => boolean().withDefault(const Constant(false))();
}
