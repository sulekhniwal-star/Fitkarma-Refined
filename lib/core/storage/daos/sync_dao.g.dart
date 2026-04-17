// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_dao.dart';

// ignore_for_file: type=lint
mixin _$SyncDaoMixin on DatabaseAccessor<AppDatabase> {
  $SyncQueueTable get syncQueue => attachedDatabase.syncQueue;
  $SyncDeadLetterTable get syncDeadLetter => attachedDatabase.syncDeadLetter;
  $RemoteConfigCacheTable get remoteConfigCache =>
      attachedDatabase.remoteConfigCache;
  $InsightLogsTable get insightLogs => attachedDatabase.insightLogs;
  $InsightRatingsTable get insightRatings => attachedDatabase.insightRatings;
  SyncDaoManager get managers => SyncDaoManager(this);
}

class SyncDaoManager {
  final _$SyncDaoMixin _db;
  SyncDaoManager(this._db);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db.attachedDatabase, _db.syncQueue);
  $$SyncDeadLetterTableTableManager get syncDeadLetter =>
      $$SyncDeadLetterTableTableManager(
        _db.attachedDatabase,
        _db.syncDeadLetter,
      );
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(
        _db.attachedDatabase,
        _db.remoteConfigCache,
      );
  $$InsightLogsTableTableManager get insightLogs =>
      $$InsightLogsTableTableManager(_db.attachedDatabase, _db.insightLogs);
  $$InsightRatingsTableTableManager get insightRatings =>
      $$InsightRatingsTableTableManager(
        _db.attachedDatabase,
        _db.insightRatings,
      );
}
