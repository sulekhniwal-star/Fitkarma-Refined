import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'package:fitkarma/core/storage/app_database.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// MODEL
// ═══════════════════════════════════════════════════════════════════════════════

/// In-memory cache entry for remote config.
class RemoteConfigCacheEntry {
  final int id;
  final String key;
  final String value;
  final String type;
  final DateTime lastUpdated;

  const RemoteConfigCacheEntry({
    required this.id,
    required this.key,
    required this.value,
    required this.type,
    required this.lastUpdated,
  });
}

/// A/B experiment descriptor.
class AbConfig {
  final int rolloutPct;
  final String seed;

  const AbConfig({required this.rolloutPct, required this.seed});

  factory AbConfig.fromJson(Map<String, dynamic> json) => AbConfig(
        rolloutPct: (json['rollout_pct'] as num).toInt(),
        seed: json['seed'] as String,
      );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SERVICE
// ═══════════════════════════════════════════════════════════════════════════════

/// Reads remote-config from Appwrite, caches in Drift, and exposes typed
/// getters.  All reads hit the local cache — only [refresh] talks to the
/// network.
class RemoteConfigService {
  final TablesDB _tablesDb;
  final RemoteConfigCacheDao _cacheDao;

  /// In-memory mirror of the Drift cache (populated on first [refresh] or
  /// [loadFromCache]).
  final Map<String, RemoteConfigCacheEntry> _memCache = {};

  RemoteConfigService({
    required TablesDB tablesDb,
    required RemoteConfigCacheDao cacheDao,
  })  : _tablesDb = tablesDb,
        _cacheDao = cacheDao;

  // ─── lifecycle ─────────────────────────────────────────────────────────────

  /// Hydrates the in-memory cache from Drift.  Call once at app start before
  /// any reads so the UI never blocks.
  Future<void> loadFromCache() async {
    final rows = await _cacheDao.getAll();
    for (final row in rows) {
      _memCache[row.key] = RemoteConfigCacheEntry(
        id: row.id,
        key: row.key,
        value: row.value,
        type: row.type,
        lastUpdated: row.lastUpdated,
      );
    }
  }

  /// Fetches the latest config document from Appwrite, writes each key into
  /// Drift, and refreshes the in-memory cache.  Safe to call frequently —
  /// throws are swallowed so the caller always has the last-known-good cache.
  Future<void> refresh() async {
    try {
      final row = await _tablesDb.getRow(
        databaseId: AW.dbFitkarma,
        tableId: AW.remoteConfig,
        rowId: 'app_config',
      );

      final data = row.data;
      final now = DateTime.now();

      for (final entry in data.entries) {
        final key = entry.key;
        final raw = entry.value;
        final encoded = raw is String ? raw : jsonEncode(raw);
        final type = _classify(key);

        final companion = RemoteConfigCacheCompanion(
          key: Value(key),
          value: Value(encoded),
          type: Value(type),
          lastUpdated: Value(now),
        );

        await _cacheDao.upsertConfig(companion);
        _memCache[key] = RemoteConfigCacheEntry(
          id: 0,
          key: key,
          value: encoded,
          type: type,
          lastUpdated: now,
        );
      }
    } catch (_) {
      // Network failure — keep serving from cache.
    }
  }

  // ─── typed getters ─────────────────────────────────────────────────────────

  /// Returns a feature flag (bool).  Defaults to `false` when absent.
  bool feature(String name) {
    final entry = _memCache['feature.$name'];
    if (entry == null) return false;
    return entry.value.toLowerCase() == 'true';
  }

  /// Returns an A/B config, or `null` when the experiment is not defined.
  AbConfig? ab(String name) {
    final entry = _memCache['ab.$name'];
    if (entry == null) return null;
    try {
      final map = jsonDecode(entry.value) as Map<String, dynamic>;
      return AbConfig.fromJson(map);
    } catch (_) {
      return null;
    }
  }

  /// Returns `true` when the kill-switch is **engaged** (i.e., the feature
  /// should be disabled).  Defaults to `false` (safe — feature stays on)
  /// when absent.
  bool killSwitch(String name) {
    final entry = _memCache['kill_switch.$name'];
    if (entry == null) return false;
    return entry.value.toLowerCase() == 'true';
  }

  /// Raw value lookup for anything that doesn't fit the three patterns above.
  String? raw(String key) => _memCache[key]?.value;

  // ─── helpers ───────────────────────────────────────────────────────────────

  static String _classify(String key) {
    if (key.startsWith('feature.')) return 'feature';
    if (key.startsWith('ab.')) return 'ab';
    if (key.startsWith('kill_switch.')) return 'kill_switch';
    return 'raw';
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
// RIVERPOD PROVIDERS
// ═══════════════════════════════════════════════════════════════════════════════

/// The Appwrite [TablesDB] client.
final appwriteTablesDbProvider = Provider<TablesDB>((ref) {
  final client = Client()
    ..setEndpoint(AppConfig.appwriteEndpoint)
    ..setProject(AppConfig.appwriteProjectId);
  return TablesDB(client);
});

/// The Drift [AppDatabase] singleton.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// The [RemoteConfigService] — use [remoteConfigReadyProvider] to await
/// initial cache hydration before reading flags.
final remoteConfigServiceProvider = Provider<RemoteConfigService>((ref) {
  final tablesDb = ref.watch(appwriteTablesDbProvider);
  final db = ref.watch(appDatabaseProvider);
  return RemoteConfigService(
    tablesDb: tablesDb,
    cacheDao: db.remoteConfigCacheDao,
  );
});

/// Completes once the local Drift cache has been loaded into memory.
/// UI should await this (or use `AsyncValue.guard`) before reading flags.
final remoteConfigReadyProvider = FutureProvider<void>((ref) async {
  final service = ref.watch(remoteConfigServiceProvider);
  await service.loadFromCache();
  // Fire-and-forget network refresh — UI doesn't wait for it.
  unawaited(service.refresh());
});

/// Convenience: exposes the hydrated [RemoteConfigService] directly.
/// Throws if [remoteConfigReadyProvider] hasn't completed yet.
final remoteConfigProvider = Provider<RemoteConfigService>((ref) {
  // Ensure the ready future has been listened to.
  ref.watch(remoteConfigReadyProvider);
  return ref.watch(remoteConfigServiceProvider);
});
