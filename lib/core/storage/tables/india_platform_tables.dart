import 'package:drift/drift.dart';
import 'base_table.dart';

@DataClassName('LabReport')
class LabReports extends Table with Syncable {
  DateTimeColumn get reportDate => dateTime()();
  TextColumn get labName => text().nullable()();
  TextColumn get extractedValues => text()(); // JSON string
  TextColumn get rawText => text().nullable()(); // Stored locally only
  BoolColumn get confirmedByUser => boolean().withDefault(const Constant(false))();
  TextColumn get source => text()(); // ocr_photo, ocr_pdf, manual
  TextColumn get importedMetrics => text().nullable()();
}

@DataClassName('AbhaLink')
class AbhaLinks extends Table with Syncable {
  TextColumn get abhaIdEncrypted => text()();
  TextColumn get abhaAddressEncrypted => text().nullable()();
  TextColumn get linkedAtEncrypted => text()();
  BoolColumn get consentGranted => boolean()();
  TextColumn get lastSyncEncrypted => text().nullable()();
}

@DataClassName('EmergencyCard')
class EmergencyCards extends Table with Syncable {
  TextColumn get name => text()();
  TextColumn get bloodGroup => text()();
  TextColumn get allergies => text().nullable()(); // JSON list
  TextColumn get chronicConditions => text().nullable()(); // JSON list
  TextColumn get emergencyContactName => text()();
  TextColumn get emergencyContactPhone => text()();
  TextColumn get doctorName => text().nullable()();
  TextColumn get doctorPhone => text().nullable()();
  TextColumn get insurancePolicy => text().nullable()();
  TextColumn get medicalNotes => text().nullable()();
}

@DataClassName('FestivalCalendarEntry')
class FestivalCalendar extends Table with Syncable {
  TextColumn get festivalKey => text()(); // slug: 'navratri', 'diwali', 'ramadan'
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text()();
  TextColumn get nameLocal => text().nullable()();
  IntColumn get year => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get calendarSystem => text()();
  TextColumn get dietPlanType => text()();
  TextColumn get regionCodes => text()(); // JSON
  TextColumn get religion => text()();
  BoolColumn get isFastingDay => boolean().withDefault(const Constant(false))();
  TextColumn get fastingType => text().nullable()();
  TextColumn get allowedFoods => text().nullable()(); // JSON
  TextColumn get forbiddenFoods => text().nullable()();
  TextColumn get workoutNote => text().nullable()();
  TextColumn get insightMessage => text()();
  TextColumn get karmaChallenge => text().nullable()();
  BoolColumn get computedDynamically => boolean().withDefault(const Constant(true))();
  DateTimeColumn get computedAt => dateTime()();
}

@DataClassName('RemoteConfigCacheEntry')
class RemoteConfigCache extends Table with Syncable {
  TextColumn get key => text()();
  TextColumn get value => text()(); // JSON or primitive string
  TextColumn get type => text()(); // boolean, string, json, integer
  DateTimeColumn get lastUpdated => dateTime()();
}

@DataClassName('WeddingEvent')
class WeddingEvents extends Table with Syncable {
  TextColumn get eventKey => text()();
  TextColumn get eventName => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  BoolColumn get isMainEvent => boolean().withDefault(const Constant(false))();
}
