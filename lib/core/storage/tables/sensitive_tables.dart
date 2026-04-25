import 'package:drift/drift.dart';
import '../converters/encryption_converters.dart';
import 'base_table.dart';

@DataClassName('BloodPressureLog')
class BloodPressureLogs extends Table with Syncable {
  TextColumn get systolic => text().map(const EncryptedStringConverter('bp_glucose'))(); 
  TextColumn get diastolic => text().map(const EncryptedStringConverter('bp_glucose'))(); 
  TextColumn get pulse => text().map(const EncryptedStringConverter('bp_glucose')).nullable()(); 
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()(); // normal, high, etc.
  TextColumn get notes => text().nullable()();
  TextColumn get source => text()();
}

@DataClassName('GlucoseLog')
class GlucoseLogs extends Table with Syncable {
  TextColumn get glucoseMgdl => text().map(const EncryptedStringConverter('bp_glucose'))(); 
  TextColumn get readingType => text()(); // fasting, post_meal, etc.
  TextColumn get foodLogId => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get classification => text()();
  TextColumn get hba1cEstimate => text().map(const EncryptedStringConverter('bp_glucose')).nullable()(); 
  TextColumn get notes => text().nullable()();
  TextColumn get source => text()();
}

@DataClassName('Spo2Log')
class Spo2Logs extends Table with Syncable {
  TextColumn get spo2Percent => text().map(const EncryptedStringConverter('bp_glucose'))(); 
  TextColumn get pulse => text().map(const EncryptedStringConverter('bp_glucose')).nullable()(); 
  DateTimeColumn get loggedAt => dateTime()();
  TextColumn get source => text()();
}

@DataClassName('PeriodLog')
class PeriodLogs extends Table with Syncable {
  TextColumn get cycleStartEncrypted => text().map(const EncryptedStringConverter('period'))(); 
  TextColumn get cycleEndEncrypted => text().map(const EncryptedStringConverter('period')).nullable()(); 
  TextColumn get symptomsEncrypted => text().map(const EncryptedStringConverter('period')).nullable()(); 
  TextColumn get flowIntensityEncrypted => text().map(const EncryptedStringConverter('period')).nullable()(); 
  TextColumn get notesEncrypted => text().map(const EncryptedStringConverter('period')).nullable()(); 
}

@DataClassName('JournalEntry')
class JournalEntries extends Table with Syncable {
  TextColumn get contentEncrypted => text().map(const EncryptedStringConverter('journal'))(); 
  IntColumn get moodScore => integer().nullable()();
  TextColumn get tags => text().nullable()();
  TextColumn get promptUsed => text().nullable()();
  DateTimeColumn get loggedAt => dateTime()();
}

@DataClassName('DoctorAppointment')
class DoctorAppointments extends Table with Syncable {
  TextColumn get doctorNameEncrypted => text().map(const EncryptedStringConverter('appointments'))(); 
  TextColumn get specialityEncrypted => text().map(const EncryptedStringConverter('appointments')).nullable()();
  TextColumn get appointmentDtEncrypted => text().map(const EncryptedStringConverter('appointments'))(); 
  TextColumn get notesEncrypted => text().map(const EncryptedStringConverter('appointments')).nullable()();
  BoolColumn get reminderSent => boolean().withDefault(const Constant(false))();
}
