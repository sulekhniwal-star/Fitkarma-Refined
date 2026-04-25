// lib/core/storage/tables/base_table.dart

import 'package:drift/drift.dart';

mixin Syncable on Table {
  TextColumn get id => text()(); // Appwrite Document ID or Local UUID
  TextColumn get userId => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  
  // Sync Status: pending, synced, failed
  TextColumn get syncStatus => text().withDefault(const Constant('pending'))();
  
  // For conflict resolution and deduplication
  TextColumn get idempotencyKey => text()();
  TextColumn get fieldVersions => text().nullable()(); // JSON map: { "field": version }

  @override
  Set<Column> get primaryKey => {id};
}
