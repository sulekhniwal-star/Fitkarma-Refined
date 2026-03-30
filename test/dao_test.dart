import 'package:drift/drift.dart' hide isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:fitkarma/core/storage/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    // In-memory SQLite for tests
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  group('FoodLogsDao', () {
    test('insert and retrieve a food log', () async {
      final now = DateTime.now();
      final id = await db.foodLogs.insert(FoodLogsCompanion.insert(
        userId: 'test-user',
        mealType: 'breakfast',
        foodName: 'Oats',
        quantity: 100,
        unit: 'grams',
        calories: 389,
        loggedAt: now,
        createdAt: now,
        updatedAt: now,
      ));

      expect(id, greaterThan(0));

      final logs = await (db.select(db.foodLogs)
            ..where((t) => t.userId.equals('test-user')))
          .get();
      expect(logs, hasLength(1));
      expect(logs.first.foodName, 'Oats');
      expect(logs.first.calories, 389);
    });
  });

  group('StepLogsDao', () {
    test('insert and retrieve step log', () async {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      await db.into(db.stepLogs).insert(StepLogsCompanion.insert(
            userId: 'test-user',
            steps: 5000,
            date: today,
            createdAt: now,
            updatedAt: now,
          ));

      final logs = await (db.select(db.stepLogs)
            ..where((t) => t.userId.equals('test-user')))
          .get();
      expect(logs, hasLength(1));
      expect(logs.first.steps, 5000);
    });
  });

  group('FoodItemsDao', () {
    test('insert and search by barcode', () async {
      final now = DateTime.now();
      await db.into(db.foodItems).insert(FoodItemsCompanion.insert(
            name: 'Banana',
            caloriesPer100g: 89,
            proteinPer100g: 1.1,
            carbsPer100g: 22.8,
            fatPer100g: 0.3,
            barcode: const Value('123456789'),
            createdAt: now,
            updatedAt: now,
          ));

      final items = await (db.select(db.foodItems)
            ..where((t) => t.barcode.equals('123456789')))
          .get();
      expect(items, hasLength(1));
      expect(items.first.name, 'Banana');
    });
  });

  group('RemoteConfigCache', () {
    test('insert and retrieve config value', () async {
      final now = DateTime.now();
      await db.into(db.remoteConfigCache).insert(
            RemoteConfigCacheCompanion.insert(
              key: 'feature.food_scan',
              value: 'true',
              fetchedAt: now,
            ),
          );

      final rows = await (db.select(db.remoteConfigCache)
            ..where((t) => t.key.equals('feature.food_scan')))
          .get();
      expect(rows, hasLength(1));
      expect(rows.first.value, 'true');
    });
  });

  group('KarmaTransactions', () {
    test('insert and retrieve karma transaction', () async {
      final now = DateTime.now();
      await db.into(db.karmaTransactions).insert(
            KarmaTransactionsCompanion.insert(
              userId: 'test-user',
              points: 10,
              transactionType: 'earned',
              source: 'workout',
              transactionDate: now,
              createdAt: now,
            ),
          );

      final txns = await (db.select(db.karmaTransactions)
            ..where((t) => t.userId.equals('test-user')))
          .get();
      expect(txns, hasLength(1));
      expect(txns.first.points, 10);
    });
  });
}
