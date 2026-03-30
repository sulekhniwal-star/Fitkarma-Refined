import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_endpoints.dart';
import '../constants/app_config.dart';
import '../storage/app_database.dart';
import '../storage/daos/remote_config_cache_dao.dart';

// ═══════════════════════════════════════════════════════════════════
// Service
// ═══════════════════════════════════════════════════════════════════

class RemoteConfigService {
  final Databases _databases;
  final RemoteConfigCacheDao _cacheDao;
  final String _projectId;

  Map<String, dynamic> _snapshot = {};
  bool _initialized = false;

  RemoteConfigService({
    required Databases databases,
    required RemoteConfigCacheDao cacheDao,
    required String projectId,
  })  : _databases = databases,
        _cacheDao = cacheDao,
        _projectId = projectId;

  /// Current in-memory snapshot. Always available (defaults on cold start).
  Map<String, dynamic> get snapshot => _snapshot;

  /// Load cached config from Drift, then fetch fresh from Appwrite in background.
  Future<void> init() async {
    await _loadFromCache();
    _initialized = true;
    // Non-blocking refresh
    _fetchFromServer();
  }

  /// Force-refresh from Appwrite (e.g. pull-to-refresh on settings screen).
  Future<void> refresh() async {
    await _fetchFromServer();
  }

  // ── Feature Flags ─────────────────────────────────────────────

  /// Returns `true` if the feature is enabled.
  bool isEnabled(String key) {
    final val = _snapshot[key];
    if (val is bool) return val;
    return false;
  }

  /// Returns `true` if the A/B test bucket includes this user.
  /// [userId] is hashed against the experiment seed to determine bucket.
  bool isInAbTest(String key, String userId) {
    final val = _snapshot[key];
    if (val is! Map) return false;

    final rolloutPct = (val['rollout_pct'] as num?)?.toInt() ?? 0;
    if (rolloutPct <= 0) return false;
    if (rolloutPct >= 100) return true;

    final seed = val['seed'] as String? ?? '';
    final hash = _hashUser(userId, seed);
    return hash % 100 < rolloutPct;
  }

  /// Returns `true` if the kill switch is active (feature should be disabled).
  bool isKilled(String key) {
    final val = _snapshot[key];
    if (val is bool) return val;
    return false;
  }

  /// Generic getter for any config value.
  dynamic getValue(String key) => _snapshot[key];

  /// Get all keys starting with a prefix (e.g. "feature.").
  Map<String, dynamic> getByPrefix(String prefix) {
    final result = <String, dynamic>{};
    for (final entry in _snapshot.entries) {
      if (entry.key.startsWith(prefix)) {
        result[entry.key] = entry.value;
      }
    }
    return result;
  }

  // ── Internals ─────────────────────────────────────────────────

  Future<void> _loadFromCache() async {
    try {
      final entries = await _cacheDao.getAll();
      final map = <String, dynamic>{};
      for (final entry in entries) {
        try {
          map[entry.key] = jsonDecode(entry.value);
        } catch (_) {
          map[entry.key] = entry.value;
        }
      }
      if (map.isNotEmpty) {
        _snapshot = map;
      }
    } catch (_) {
      // Cold start with empty DB — use defaults
    }
  }

  Future<void> _fetchFromServer() async {
    try {
      final doc = await _databases.getDocument(
        databaseId: AW.databaseId,
        collectionId: AW.colRemoteConfig,
        documentId: _projectId,
      );

      final data = doc.data;
      final expiresAt = DateTime.now().add(AppConfig.remoteConfigTtl);
      final map = <String, dynamic>{};

      for (final entry in data.entries) {
        final value = entry.value;
        final encoded = value is Map || value is List
            ? jsonEncode(value)
            : value.toString();

        await _cacheDao.upsertValue(
          entry.key,
          encoded,
          expiresAt: expiresAt,
        );

        // Store in-memory as decoded types
        if (value is Map) {
          map[entry.key] = Map<String, dynamic>.from(value as Map);
        } else if (value is bool) {
          map[entry.key] = value;
        } else if (value is num) {
          map[entry.key] = value;
        } else {
          map[entry.key] = value;
        }
      }

      _snapshot = map;
    } catch (_) {
      // Network failure — keep using cached snapshot
    }
  }

  /// Deterministic hash of userId + seed → 0–99 bucket.
  int _hashUser(String userId, String seed) {
    var hash = 0;
    final input = '$userId:$seed';
    for (var i = 0; i < input.length; i++) {
      hash = ((hash << 5) - hash + input.codeUnitAt(i)) & 0x7FFFFFFF;
    }
    return hash % 100;
  }
}

// ═══════════════════════════════════════════════════════════════════
// Riverpod Providers
// ═══════════════════════════════════════════════════════════════════

final remoteConfigServiceProvider = Provider<RemoteConfigService>((ref) {
  throw UnimplementedError('RemoteConfigService not initialized — '
      'override this provider in the widget tree');
});

/// Convenience provider: check if a feature flag is enabled.
final featureFlagProvider = Provider.family<bool, String>((ref, key) {
  final service = ref.watch(remoteConfigServiceProvider);
  if (key.startsWith('kill_switch.')) {
    return !service.isKilled(key);
  }
  return service.isEnabled(key);
});

/// Convenience provider: check A/B test membership.
final abTestProvider = Provider.family<bool, ({String key, String userId})>(
  (ref, params) {
    final service = ref.watch(remoteConfigServiceProvider);
    return service.isInAbTest(params.key, params.userId);
  },
);

/// Provider that exposes the full remote config snapshot as a map.
final remoteConfigSnapshotProvider = Provider<Map<String, dynamic>>((ref) {
  final service = ref.watch(remoteConfigServiceProvider);
  return service.snapshot;
});
