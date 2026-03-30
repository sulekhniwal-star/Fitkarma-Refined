// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_queue_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncQueueDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  $SyncDeadLetterTable get syncDeadLetter => attachedDatabase.syncDeadLetter;
  SyncQueueDaoManager get managers => SyncQueueDaoManager(this);
}

class SyncQueueDaoManager {
  final _$SyncQueueDaoMixin _db;
  SyncQueueDaoManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
  $$SyncDeadLetterTableTableManager get syncDeadLetter =>
      $$SyncDeadLetterTableTableManager(
        _db.attachedDatabase,
        _db.syncDeadLetter,
      );
}
