import 'package:drift/drift.dart';

@DataClassName('FestivalCalendar')
class FestivalCalendars extends Table {
  TextColumn get id => text()();
  TextColumn get festivalKey => text()(); // navratri, diwali, holi, ramadan, etc.
  TextColumn get nameEn => text()();
  TextColumn get nameHi => text()();
  TextColumn get nameLocal => text().nullable()();
  IntColumn get year => integer()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime()();
  TextColumn get calendarSystem => text()(); // hindu, islamic, gregorian
  TextColumn get dietPlanType => text().nullable()(); // phalahar, nirjala, feast, sattvic
  TextColumn get regionCodes => text().nullable()(); // JSON list
  TextColumn get religion => text().nullable()();
  BoolColumn get isFastingDay => boolean().withDefault(const Constant(false))();
  TextColumn get fastingType => text().nullable()(); // nirjala, phalahar, roza
  TextColumn get allowedFoods => text().nullable()(); // JSON list
  TextColumn get forbiddenFoods => text().nullable()(); // JSON list
  TextColumn get workoutNote => text().nullable()();
  TextColumn get insightMessage => text().nullable()();
  IntColumn get karmaChallenge => integer().nullable()();
  BoolColumn get computedDynamically => boolean().withDefault(const Constant(true))();
  DateTimeColumn get computedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('WeddingEvent')
class WeddingEvents extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text()();
  TextColumn get role => text()(); // bride, groom, guest, relative
  TextColumn get relationType => text().nullable()(); // if relative
  DateTimeColumn get weddingStartDate => dateTime()();
  DateTimeColumn get weddingEndDate => dateTime()();
  IntColumn get prepWeeks => integer()();
  TextColumn get events => text().nullable()(); // JSON list of event keys
  TextColumn get primaryGoal => text().nullable()(); // look_best, feel_energized, manage_stress
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}