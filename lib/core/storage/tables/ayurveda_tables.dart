import 'package:drift/drift.dart';

@DataClassName('AyurvedicRitualLog')
class AyurvedicRitualLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get ritualKey => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get karmaAwarded => integer()();
}

