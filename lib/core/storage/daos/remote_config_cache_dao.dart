import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'remote_config_cache_dao.g.dart';


@DriftDatabase(tables: [RemoteConfigCache])
class RemoteConfigCacheDao extends DatabaseAccessor<AppDatabase>
    with _$RemoteConfigCacheDaoMixin {
  RemoteConfigCacheDao(super.db);

  Future<RemoteConfigCacheData?> getByKey(String key) =>
      (select(remoteConfigCache)..where((t) => t.key.equals(key)))
          .getSingleOrNull();

  Future<String?> getValue(String key) async {
    final entry = await getByKey(key);
    if (entry == null) return null;
    if (entry.expiresAt != null && entry.expiresAt!.isBefore(DateTime.now())) {
      return null;
    }
    return entry.value;
  }

  Future<int> upsertValue(String key, String value, {DateTime? expiresAt}) =>
      into(remoteConfigCache).insertOnConflictUpdate(
        RemoteConfigCacheCompanion.insert(
          key: key,
          value: value,
          fetchedAt: DateTime.now(),
          expiresAt: Value(expiresAt),
        ),
      );

  Future<int> deleteExpired() =>
      (delete(remoteConfigCache)
            ..where((t) =>
                t.expiresAt.isNotNull() &
                t.expiresAt.isSmallerThanValue(DateTime.now())))
          .go();

  Future<int> clear() => delete(remoteConfigCache).go();
}
