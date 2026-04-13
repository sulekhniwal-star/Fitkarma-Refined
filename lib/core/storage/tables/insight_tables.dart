import 'package:drift/drift.dart';

class InsightLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get insightId => text()();
  DateTimeColumn get shownAt => dateTime()();
}

class InsightRatings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get insightId => text()();
  IntColumn get rating => integer()(); // 1 = Thumb up, -1 = Thumb down
  DateTimeColumn get ratedAt => dateTime()();
}
