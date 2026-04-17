import 'package:drift/drift.dart';

@DataClassName('SyncQueueEntry')
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get collection => text()();
  TextColumn get operation => text()(); // create, update, delete
  TextColumn get localId => text()();
  TextColumn get appwriteDocId => text().nullable()();
  TextColumn get payload => text()(); // JSON string
  TextColumn get idempotencyKey => text()();
  TextColumn get fieldVersions => text().nullable()(); // JSON string for conflict res
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get retryCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
}

@DataClassName('SyncDeadLetterEntry')
class SyncDeadLetter extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get userId => text()();
  TextColumn get originalItem => text()(); // Original SyncQueue payload
  IntColumn get failCount => integer()();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

