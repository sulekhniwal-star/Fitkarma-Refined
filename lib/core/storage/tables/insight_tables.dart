import 'package:drift/drift.dart';
import 'base_table.dart';

class InsightLogs extends Table with Syncable {
  TextColumn get insightId => text()();
  DateTimeColumn get shownAt => dateTime()();
}

class InsightRatings extends Table with Syncable {
  TextColumn get insightId => text()();
  IntColumn get rating => integer()(); // 1 = Thumb up, -1 = Thumb down
  DateTimeColumn get ratedAt => dateTime()();
}
