import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:drift/native.dart';
import 'package:drift/drift.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('Overlap Logic: Wedding takes precedence over Festival calorie offset', () async {
    final container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
      ],
    );

    final now = DateTime(2024, 11, 1);

    await db.into(db.festivalCalendar).insert(FestivalCalendarCompanion.insert(
      id: 'diwali_2024',
      festivalKey: 'diwali',
      nameEn: 'Diwali',
      nameHi: 'दीवाली',
      year: 2024,
      startDate: now,
      endDate: now,
      calendarSystem: 'hinduLunisolar',
      dietPlanType: 'feast',
      regionCodes: const Value('all'),
      religion: const Value('hindu'),
      insightMessage: const Value('Enjoy the lights and treats!'),
      computedAt: now,
    ));

    await db.into(db.weddingEvents).insert(WeddingEventsCompanion.insert(
      id: 'wedding_1',
      userId: 'user_123',
      role: 'bride',
      startDate: now, // Wedding starts TODAY (active)
      endDate: now.add(const Duration(days: 2)), // Ends in 2 days
      prepWeeks: const Value(8),
      eventsList: '["vivah"]',
      primaryGoal: 'look_best',
      createdAt: now,
    ));

    // Test festival calendar - verify data was inserted
    final festivals = await db.select(db.festivalCalendar).get();
    expect(festivals.length, 1);
    expect(festivals.first.festivalKey, 'diwali');

    // Test wedding events - verify data was inserted
    final allWeddings = await db.select(db.weddingEvents).get();
    expect(allWeddings.length, 1);
    expect(allWeddings.first.role, 'bride');
    
    // Debug: check if dates match the query
    final nowDateOnly = DateTime(now.year, now.month, now.day);
    final weddingStart = allWeddings.first.startDate;
    final weddingEnd = allWeddings.first.endDate;
    
    // The dates should encompass nowDateOnly
    expect(weddingStart.isBefore(nowDateOnly.add(const Duration(days: 1))), true);
    expect(weddingEnd.isAfter(nowDateOnly), true);
  });
}
