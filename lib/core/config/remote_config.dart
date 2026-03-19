import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'package:fitkarma/core/storage/drift_service.dart';

part 'remote_config.g.dart';

/// Schema for Remote Configuration
/// { "feature.X": bool, "ab.X": { "rollout_pct": int, "seed": str }, "kill_switch.X": bool }
class RemoteConfigData {
  final Map<String, dynamic> configs;

  RemoteConfigData(this.configs);

  /// Feature toggle
  bool getFeature(String feature) => configs['feature.$feature'] ?? false;

  /// Kill switch
  bool getKillSwitch(String key) => configs['kill.$key'] ?? false;

  /// A/B Test logic with hash-based rollout
  bool getABTest(String key, String userId) {
    final test = configs['ab.$key'];
    if (test == null || test is! Map) return false;
    
    final int rolloutPct = test['rollout_pct'] ?? 0;
    final String seed = test['seed'] ?? key;
    
    // Deterministic hash based on userId and test seed
    final int hash = '$userId:$seed'.hashCode.abs();
    return (hash % 100) < rolloutPct;
  }

  factory RemoteConfigData.defaults() => RemoteConfigData({
    'feature.abha_module': true,
    'kill.whatsapp_bot': false,
  });

  Map<String, dynamic> toJson() => configs;

  @override
  String toString() => json.encode(configs);
}

@Riverpod(keepAlive: true)
class RemoteConfig extends _$RemoteConfig {
  @override
  Future<RemoteConfigData> build() async {
    // 1. Initialise with cached values immediately (sync/async depending on implementation)
    final cached = await _loadFromCache();
    
    // 2. Fetch fresh config in background (non-blocking)
    _refreshInBackground();
    
    return cached ?? RemoteConfigData.defaults();
  }

  /// Loads configuration from local Drift database (RemoteConfigCache table)
  Future<RemoteConfigData?> _loadFromCache() async {
    try {
      final service = ref.read(driftServiceProvider);
      return await service.getRemoteConfig();
    } catch (e) {
      // If service is not initialised yet, return null
      return null;
    }
  }

  /// Fetches from Appwrite and updates the cache
  Future<void> _refreshInBackground() async {
    try {
      final response = await AppwriteClient.databases.listDocuments(
        databaseId: AW.dbId,
        collectionId: AW.remoteConfig,
      );

      final Map<String, dynamic> freshConfigs = {};
      
      for (var doc in response.documents) {
        final key = doc.data['key'] as String;
        final value = doc.data['value'] as String;
        final type = doc.data['type'] as String;

        if (type == 'bool') {
          freshConfigs[key] = value.toLowerCase() == 'true';
        } else if (type == 'json') {
          freshConfigs[key] = json.decode(value);
        } else if (type == 'integer') {
          freshConfigs[key] = int.parse(value);
        } else {
          freshConfigs[key] = value;
        }
      }

      if (freshConfigs.isNotEmpty) {
        final data = RemoteConfigData(freshConfigs);
        
        // 1. Save to Drift cache
        try {
          final service = ref.read(driftServiceProvider);
          await service.saveRemoteConfig(data);
        } catch (e) {
          // Saving to cache failed, but we still update the memory state
        }
        
        // 2. Update state to notify listeners
        state = AsyncValue.data(data);
      }
    } catch (e) {
      // Connection errors handled silently
    }
  }
}
