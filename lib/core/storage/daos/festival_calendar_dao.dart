import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'festival_calendar_dao.g.dart';


@DriftDatabase(tables: [FestivalCalendar])
class FestivalCalendarDao extends DatabaseAccessor<AppDatabase>
    with _$FestivalCalendarDaoMixin {
  FestivalCalendarDao(super.db);

  Future<List<FestivalCalendarData>> getUpcoming() =>
      (select(festivalCalendar)
            ..where((t) => t.date.isBiggerOrEqualValue(DateTime.now()))
            ..orderBy([(t) => OrderingTerm.asc(t.date)]))
          .get();

  Future<List<FestivalCalendarData>> getByMonth(int year, int month) {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    return (select(festivalCalendar)
          ..where((t) => t.date.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  Future<int> insertEntry(FestivalCalendarCompanion entry) =>
      into(festivalCalendar).insert(entry);

  Future<int> deleteEntry(int id) =>
      (delete(festivalCalendar)..where((t) => t.id.equals(id))).go();
}
