// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_calendar_dao.dart';

// ignore_for_file: type=lint
mixin _$FestivalCalendarDaoMixin on DatabaseAccessor<AppDatabase> {
  $FestivalCalendarTable get festivalCalendar =>
      attachedDatabase.festivalCalendar;
  FestivalCalendarDaoManager get managers => FestivalCalendarDaoManager(this);
}

class FestivalCalendarDaoManager {
  final _$FestivalCalendarDaoMixin _db;
  FestivalCalendarDaoManager(this._db);
  $$FestivalCalendarTableTableManager get festivalCalendar =>
      $$FestivalCalendarTableTableManager(
        _db.attachedDatabase,
        _db.festivalCalendar,
      );
}
