import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/features/festival/domain/festival_date_engine.dart';
import 'package:drift/drift.dart';
import 'package:fitkarma/features/festival/domain/festival_diet_plan.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_service.dart';

class FestivalRepository {
  final AppDatabase db;
  final FestivalDateEngine engine;

  FestivalRepository({required this.db, required this.engine});

  /// The main sync entry point: Computes local and then merges from Appwrite.
  Future<void> syncAll() async {
    final currentYear = DateTime.now().year;
    
    // 1. Local Computation Stage (Primary)
    await syncLocal(currentYear);
    await syncLocal(currentYear + 1);

    // 2. Appwrite Sync Stage (Managed Overrides)
    await syncFromAppwrite();
  }

  /// Computes festivals locally and saves them to the database.
  /// Marked as `computedDynamically: true`.
  Future<void> syncLocal(int year) async {
    final festivals = await engine.computeAllFestivals(year);
    
    final entries = festivals.map((f) {
      // Find diet config if exists
      final dietConfig = festivalDietConfigs[f.festivalKey];
      final id = '${f.festivalKey}_${f.year}';
      
      return FestivalCalendarCompanion(
        id: Value(id),
        userId: const Value('system'), // Global festival
        festivalKey: Value(f.festivalKey),
        nameEn: Value(f.nameEn),
        nameHi: Value(f.nameHi),
        year: Value(f.year),
        startDate: Value(f.startDate),
        endDate: Value(f.endDate),
        calendarSystem: Value(f.system.name),
        dietPlanType: Value(dietConfig?.type.name ?? 'noRestriction'),
        regionCodes: const Value('["ALL"]'), // Default
        religion: const Value('universal'), // Default
        isFastingDay: Value(dietConfig?.type == FestivalDietType.nirjalaFast || 
                          dietConfig?.type == FestivalDietType.phalaharFast || 
                          dietConfig?.type == FestivalDietType.sattvicFast || 
                          dietConfig?.type == FestivalDietType.rozaFast),
        fastingType: Value(dietConfig?.type.name),
        insightMessage: Value(dietConfig?.insightCardMessage ?? 'Enjoy the festive day!'),
        computedDynamically: const Value(true),
        computedAt: Value(DateTime.now()),
        updatedAt: Value(DateTime.now()),
        createdAt: Value(DateTime.now()),
        idempotencyKey: Value('local_$id'),
        syncStatus: const Value('synced'), // Locally computed, no need to sync back
      );
    }).toList();

    // Batch upsert to avoid duplicate IDs
    await db.batch((batch) {
      batch.insertAllOnConflictUpdate(db.festivalCalendar, entries);
    });
  }

  /// Fetches festival overrides from Appwrite and updates the local DB.
  /// Entries from Appwrite set `computedDynamically: false`.
  Future<void> syncFromAppwrite() async {
    try {
      final response = await AppwriteClient.databases.listDocuments(
        databaseId: 'fitkarma-db',
        collectionId: 'festival_calendar',
      );

      final entries = response.documents.map((doc) {
        final data = doc.data;
        return FestivalCalendarCompanion(
          id: Value(doc.$id),
          userId: const Value('system'),
          festivalKey: Value(data['festival_key'] ?? ''),
          nameEn: Value(data['name_en'] ?? ''),
          nameHi: Value(data['name_hi'] ?? ''),
          year: Value(data['year'] ?? DateTime.now().year),
          startDate: Value(DateTime.parse(data['start_date'])),
          endDate: Value(DateTime.parse(data['end_date'])),
          calendarSystem: Value(data['calendar_system'] ?? 'gregorianFixed'),
          dietPlanType: Value(data['diet_plan_type'] ?? 'noRestriction'),
          regionCodes: Value(data['region_codes'] ?? '["ALL"]'),
          religion: Value(data['religion'] ?? 'universal'),
          isFastingDay: Value(data['is_fasting_day'] ?? false),
          insightMessage: Value(data['insight_message'] ?? ''),
          computedDynamically: const Value(false), // It's from the source of truth
          computedAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
          createdAt: Value(DateTime.now()),
          idempotencyKey: Value(doc.$id),
          syncStatus: const Value('synced'),
        );
      }).toList();

      if (entries.isNotEmpty) {
        await db.batch((batch) {
          batch.insertAllOnConflictUpdate(db.festivalCalendar, entries);
        });
      }
    } catch (e) {
      // Log error but don't block app (local computation is already done)
      print('Appwrite Festival Sync Error: $e');
    }
  }

  /// Returns the most relevant active or upcoming festival.
  Future<FestivalCalendarEntry?> getCurrentFestival() async {
    final now = DateTime.now();
    
    // 1. Check for Active Festival
    final active = await (db.select(db.festivalCalendar)
      ..where((t) => t.startDate.isSmallerOrEqualValue(now) & t.endDate.isBiggerOrEqualValue(now))
      ..limit(1))
      .getSingleOrNull();
      
    if (active != null) return active;

    // 2. Check for Upcoming Festival (within 7 days)
    final upcoming = await (db.select(db.festivalCalendar)
      ..where((t) => t.startDate.isBiggerThanValue(now) & t.startDate.isSmallerThanValue(now.add(const Duration(days: 7))))
      ..orderBy([(t) => OrderingTerm(expression: t.startDate)])
      ..limit(1))
      .getSingleOrNull();

    return upcoming;
  }
}
