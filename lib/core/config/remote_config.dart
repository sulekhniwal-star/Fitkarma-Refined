import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_endpoints.dart';
import '../network/appwrite_client.dart';
import '../storage/app_database.dart';
import '../storage/drift_service.dart';

/// Container for remote configuration values with typed accessors.
class RemoteConfigData {
  final Map<String, dynamic> _config;

  RemoteConfigData(this._config);

  /// Provides system default values for all configuration keys.
  static Map<String, dynamic> defaults() => {
        'feature.abha_module': true,
        'insight.ml_model_enabled': false,
        'sync.batch_size': 20,
        'ui.theme_mode': 'system',
        'social.feeds_enabled': true,
      };

  bool getBool(String key) => _config[key] ?? defaults()[key] ?? false;
  String getString(String key) => _config[key]?.toString() ?? defaults()[key]?.toString() ?? '';
  int getInt(String key) => int.tryParse(_config[key]?.toString() ?? '') ?? defaults()[key] ?? 0;
  
  dynamic getJson(String key) {
    final val = _config[key] ?? defaults()[key];
    if (val is String) {
      try {
        return jsonDecode(val);
      } catch (_) {
        return null;
      }
    }
    return val;
  }
}

/// Provider for the RemoteConfig system.
/// Loads from Drift cache immediately, then refreshes from Appwrite in the background.
class RemoteConfig extends AsyncNotifier<RemoteConfigData> {
  @override
  Future<RemoteConfigData> build() async {
    // 1. Load from Drift remoteConfigCache first (immediate)
    final db = DriftService.db;
    final cachedItems = await db.select(db.remoteConfigCache).get();

    final configMap = <String, dynamic>{};
    for (final item in cachedItems) {
      configMap[item.key] = _parseValue(item.value, item.type);
    }

    // 2. Trigger background refresh from Appwrite
    // Note: We don't await this to ensure immediate UI availability
    _refreshInBackground();

    return RemoteConfigData(configMap);
  }

  dynamic _parseValue(String value, String type) {
    switch (type) {
      case 'boolean':
        return value == 'true';
      case 'integer':
        return int.tryParse(value) ?? 0;
      case 'json':
        try {
          return jsonDecode(value);
        } catch (_) {
          return null;
        }
      default:
        return value;
    }
  }

  Future<void> _refreshInBackground() async {
    try {
      final response = await AppwriteClient.databases.listDocuments(
        databaseId: AW.dbId,
        collectionId: AW.remoteConfig,
      );

      final db = DriftService.db;
      
      // Update local cache
      await db.batch((batch) {
        for (final doc in response.documents) {
          final key = doc.data['key'] as String;
          final value = doc.data['value'].toString();
          final type = doc.data['type'] as String;

          batch.insert(
            db.remoteConfigCache,
            RemoteConfigCacheCompanion.insert(
              id: 'system_config_$key',
              userId: 'system',
              key: key,
              value: value,
              type: type,
              lastUpdated: DateTime.now(),
              idempotencyKey: 'system_config_$key',
              syncStatus: const Value('synced'),
            ),
            mode: InsertMode.insertOrReplace,
          );
        }
      });
      
    } catch (e) {
      // Fail silently for background refresh to avoid UI error states
    }
  }
}

/// Global provider for the RemoteConfig service.
final remoteConfigProvider = AsyncNotifierProvider<RemoteConfig, RemoteConfigData>(RemoteConfig.new);
