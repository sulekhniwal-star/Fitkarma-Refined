import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:drift/drift.dart';

import 'festival_filter_provider.dart';

part 'festival_providers.g.dart';

/// ✅ DATABASE PROVIDER
@riverpod
AppDatabase appDatabase(Ref ref) {
  return DriftService.db;
}

/// ✅ ACTIVE FESTIVALS
@riverpod
Future activeFestivals(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);

  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

  final query = db.select(db.festivalCalendar)
    ..where(
      (t) =>
          t.startDate.isSmallerOrEqualValue(todayEnd) &
          t.endDate.isBiggerOrEqualValue(todayStart),
    );

  return query.get(); // List<FestivalCalendarEntry>
}

/// ✅ UPCOMING FESTIVALS
@riverpod
Future upcomingFestivals(Ref ref) async {
  final db = ref.watch(appDatabaseProvider);

  final filter = ref.watch(festivalRegionFilterProvider);
  final now = DateTime.now();

  final query = db.select(db.festivalCalendar)
    ..where((t) => t.startDate.isBiggerThanValue(now))
    ..orderBy([(t) => OrderingTerm(expression: t.startDate)]);

  if (filter != 'All') {
    query.where((t) => t.religion.equals(filter.toLowerCase()));
  }

  return query.get(); // List<FestivalCalendarEntry>
}

/// ✅ FESTIVAL DETAIL
@riverpod
Future festivalDetail(
  Ref ref,
  String festivalKey,
) async {
  final db = ref.watch(appDatabaseProvider);

  final query = db.select(db.festivalCalendar)
    ..where((t) => t.festivalKey.equals(festivalKey));

  return query.getSingleOrNull(); // FestivalCalendarEntry?
}