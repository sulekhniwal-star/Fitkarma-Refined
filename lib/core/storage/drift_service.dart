import 'dart:convert';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fitkarma/core/config/remote_config.dart';

part 'drift_service.g.dart';

class DriftService {
  final AppDatabase db;
  
  DriftService(this.db);

  /// Load RemoteConfig from local Drift database (RemoteConfigCache table)
  Future<RemoteConfigData?> getRemoteConfig() async {
    final results = await db.select(db.remoteConfigCache).get();
    if (results.isEmpty) return null;
    
    final Map<String, dynamic> configs = {};
    for (var row in results) {
      final key = row.key;
      final value = row.value;
      final type = row.type;
      
      if (type == 'bool') {
        configs[key] = value.toLowerCase() == 'true';
      } else if (type == 'json') {
        configs[key] = json.decode(value);
      } else if (type == 'int') {
        configs[key] = int.parse(value);
      } else {
        configs[key] = value;
      }
    }
    return RemoteConfigData(configs);
  }

  /// Upsert RemoteConfig data into local Drift cache
  Future<void> saveRemoteConfig(RemoteConfigData data) async {
    await db.batch((batch) {
      for (var entry in data.configs.entries) {
        final key = entry.key;
        final value = entry.value;
        String type = 'string';
        String stringValue = '';
        
        if (value is bool) {
          type = 'bool';
          stringValue = value.toString();
        } else if (value is Map || value is List) {
          type = 'json';
          stringValue = json.encode(value);
        } else if (value is int) {
          type = 'int';
          stringValue = value.toString();
        } else {
          stringValue = value.toString();
        }

        batch.insert(
          db.remoteConfigCache,
          RemoteConfigCacheCompanion.insert(
            key: key,
            value: stringValue,
            type: type,
            lastUpdated: DateTime.now(),
          ),
          mode: InsertMode.insertOrReplace,
        );
      }
    });
  }
}

@Riverpod(keepAlive: true)
DriftService driftService(DriftServiceRef ref) {
  // This provider expects to be overridden in main.dart with a real DriftService instance,
  // or it could instantiate one if we had the encryption key ready.
  // For now, it throws to ensure the developer provides the actual initialised service.
  throw UnimplementedError('DriftService needs to be initialised with master key and provided in main.dart');
}
