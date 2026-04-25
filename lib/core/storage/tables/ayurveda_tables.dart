import 'package:drift/drift.dart';
import 'base_table.dart';

@DataClassName('AyurvedicRitualLog')
class AyurvedicRitualLogs extends Table with Syncable {
  TextColumn get ritualKey => text()();
  DateTimeColumn get completedAt => dateTime()();
  IntColumn get karmaAwarded => integer()();
}
