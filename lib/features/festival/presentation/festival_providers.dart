import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:drift/drift.dart';

import 'festival_filter_provider.dart';
import 'package:fitkarma/features/festival/data/festival_repository.dart';
import 'package:fitkarma/features/festival/domain/festival_date_engine.dart';

final festivalDateEngineProvider = Provider<FestivalDateEngine>((ref) {
  return FestivalDateEngine();
});

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return DriftService.db;
});

final festivalRepositoryProvider = Provider<FestivalRepository>((ref) {
  return FestivalRepository(
    db: ref.watch(appDatabaseProvider),
    engine: ref.watch(festivalDateEngineProvider),
  );
});

/// ✅ ACTIVE FESTIVALS
final activeFestivalsProvider = FutureProvider<List<FestivalCalendarEntry>>((ref) async {
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

  return query.get();
});

/// ✅ UPCOMING FESTIVALS
final upcomingFestivalsProvider = FutureProvider<List<FestivalCalendarEntry>>((ref) async {
  final db = ref.watch(appDatabaseProvider);

  final filter = ref.watch(festivalRegionFilterProvider);
  final now = DateTime.now();

  final query = db.select(db.festivalCalendar)
    ..where((t) => t.startDate.isBiggerThanValue(now))
    ..orderBy([(t) => OrderingTerm(expression: t.startDate)]);

  if (filter != 'All') {
    query.where((t) => t.religion.equals(filter.toLowerCase()));
  }

  return query.get();
});

/// ✅ FESTIVAL DETAIL
final festivalDetailProvider = FutureProvider.family<FestivalCalendarEntry?, String>((ref, festivalKey) async {
  final db = ref.watch(appDatabaseProvider);

  final query = db.select(db.festivalCalendar)
    ..where((t) => t.festivalKey.equals(festivalKey));

  return query.getSingleOrNull();
});

/// ✅ CURRENT ACTIVE / UPCOMING FESTIVAL
final currentFestivalProvider = FutureProvider<FestivalCalendarEntry?>((ref) async {
  final repo = ref.watch(festivalRepositoryProvider);
  return repo.getCurrentFestival();
});

/// ✅ SYNC TRIGGER
final syncFestivalsProvider = FutureProvider<void>((ref) async {
  final repo = ref.watch(festivalRepositoryProvider);
  await repo.syncAll();
});
