// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_cache_dao.dart';

// ignore_for_file: type=lint
mixin _$RemoteConfigCacheDaoMixin on DatabaseAccessor<AppDatabase> {
  $RemoteConfigCacheTable get remoteConfigCache =>
      attachedDatabase.remoteConfigCache;
  RemoteConfigCacheDaoManager get managers => RemoteConfigCacheDaoManager(this);
}

class RemoteConfigCacheDaoManager {
  final _$RemoteConfigCacheDaoMixin _db;
  RemoteConfigCacheDaoManager(this._db);
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(
        _db.attachedDatabase,
        _db.remoteConfigCache,
      );
}
