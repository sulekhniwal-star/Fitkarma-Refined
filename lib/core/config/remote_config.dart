// lib/core/config/remote_config.dart
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../constants/app_config.dart';
import '../constants/api_endpoints.dart';
import '../network/appwrite_service.dart';
import '../storage/drift_service.dart';

part 'remote_config.g.dart';

/// Local RemoteConfig model providing type-safe access to flags
class RemoteConfig {
  final Map<String, dynamic> _config;

  RemoteConfig(this._config);

  /// Returns a boolean feature flag.
  bool getBool(String key, {bool defaultValue = false}) {
    final val = _config[key];
    if (val is bool) return val;
    return defaultValue;
  }

  /// Returns an A/B test or rollout configuration.
  Map<String, dynamic>? getExperiment(String key) {
    final val = _config[key];
    if (val is Map<String, dynamic>) return val;
    return null;
  }

  /// Checks if a kill-switch is active for a feature.
  bool isKilled(String featureKey) {
    return getBool('kill_switch.$featureKey', defaultValue: false);
  }

  /// Returns server-delivered insight rules as a JSON array.
  List<Map<String, dynamic>> getServerRules() {
    final val = _config['server_rules'];
    if (val is List) {
      return val.whereType<Map<String, dynamic>>().toList();
    }
    return [];
  }
}

/// Service that manages Appwrite Remote Config and local Drift caching.
@Riverpod(keepAlive: true)
class RemoteConfigService extends _$RemoteConfigService {
  @override
  FutureOr<RemoteConfig> build() async {
    final db = ref.watch(driftDbProvider);
    final dao = db.remoteConfigCacheDao;
    
    // 1. Load cached version from Drift immediately
    final cachedJson = await dao.getValue('remote_config');
    Map<String, dynamic> config = {};
    if (cachedJson != null) {
      try {
        config = json.decode(cachedJson);
      } catch (_) {
        // Handle malformed cache
      }
    }
    
    // 2. Trigger non-blocking refresh from Appwrite
    // We don't await this so the provider returns the cached version ASAP
    _refreshAsync();
    
    return RemoteConfig(config);
  }

  /// Fetches latest config from Appwrite and updates Drift cache.
  Future<void> _refreshAsync() async {
    try {
      final databases = ref.read(appwriteDatabasesProvider);
      
      // Fetch the global config document from the remote_config collection
      final doc = await databases.listDocuments(
        databaseId: AppConfig.appwriteDatabaseId,
        collectionId: AW.remoteConfig,
        queries: [
          // Assuming we use a 'key' field to identify the global config
        ],
      );

      if (doc.documents.isNotEmpty) {
        final remoteData = doc.documents.first.data;
        // The document structure might have a 'config' field containing the JSON
        final String configJson = remoteData['config_json'] ?? json.encode(remoteData);
        
        final db = ref.read(driftDbProvider);
        await db.remoteConfigCacheDao.setValue('remote_config', configJson);
        
        // Update the state with fresh data
        final Map<String, dynamic> newConfig = json.decode(configJson);
        state = AsyncData(RemoteConfig(newConfig));
      }
    } catch (e) {
      // Silent fail - we still have the cached version or empty map
    }
  }
}
