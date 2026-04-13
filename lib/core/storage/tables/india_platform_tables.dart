import 'package:drift/drift.dart';

@DataClassName('LabReport')
class LabReports extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  DateTimeColumn get reportDate => dateTime()();
  TextColumn get labName => text().nullable()();
  TextColumn get extractedValues => text()(); // JSON string
  TextColumn get rawText => text().nullable()(); // Stored locally only
  BoolColumn get confirmedByUser => boolean().withDefault(const Constant(false))();
  TextColumn get source => text()(); // ocr_photo, ocr_pdf, manual
  TextColumn get importedMetrics => text().nullable()();
}

@DataClassName('AbhaLink')
class AbhaLinks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get abhaId => text()();
  TextColumn get abhaAddress => text().nullable()();
  DateTimeColumn get linkedAt => dateTime()();
  BoolColumn get consentGranted => boolean()();
  DateTimeColumn get lastSync => dateTime().nullable()();
}

@DataClassName('EmergencyCard')
class EmergencyCard extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get name => text()();
  TextColumn get bloodGroup => text()();
  TextColumn get phone => text()();
  TextColumn get relation => text()();
  TextColumn get medicalNotes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

@DataClassName('FestivalCalendarEntry')
class FestivalCalendar extends Table {
  TextColumn get id => text()(); // e.g. 'navratri_2025_1'
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

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('RemoteConfigCacheEntry')
class RemoteConfigCache extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text()();
  TextColumn get value => text()(); // JSON or primitive string
  TextColumn get type => text()(); // boolean, string, json, integer
  DateTimeColumn get lastUpdated => dateTime()();
}

@DataClassName('WeddingEvent')
class WeddingEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get eventKey => text()();
  TextColumn get eventName => text()();
  DateTimeColumn get date => dateTime()();
  TextColumn get description => text().nullable()();
  BoolColumn get isMainEvent => boolean().withDefault(const Constant(false))();
}
