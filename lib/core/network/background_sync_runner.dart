import 'dart:async';
import 'dart:isolate';
import 'package:appwrite/appwrite.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';
import 'package:fitkarma/core/storage/app_database.dart';

@pragma('vm:entry-point')
class BackgroundSyncRunner {
  static final _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  AppDatabase? _database;
  Client? _appwriteClient;
  TablesDB? _tablesDb;
  bool _isInitialized = false;

  @pragma('vm:entry-point')
  static Future<void> start() async {
    final runner = BackgroundSyncRunner();
    await runner.initialize();
  }

  Future<void> initialize() async {
    if (_isInitialized) return;
    _isInitialized = true;

    await _initDatabase();
    await _initAppwrite();
    await _startListening();
  }

  Future<void> _initDatabase() async {
    _database = AppDatabase();
  }

  Future<void> _initAppwrite() async {
    _appwriteClient = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId);
    _tablesDb = TablesDB(_appwriteClient!);
  }

  Future<void> _startListening() async {
    final connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((results) async {
      if (_isOnline(results)) {
        await _processQueue();
      }
    });

    final current = await connectivity.checkConnectivity();
    if (_isOnline(current)) {
      await _processQueue();
    }
  }

  bool _isOnline(List<ConnectivityResult> results) {
    return results.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet);
  }

  Future<void> _processQueue() async {
    if (_database == null) return;

    final items = await _database!.syncQueueDao.getPending(limit: 20);
    if (items.isEmpty) return;

    for (final item in items) {
      if (!_isOnline(await Connectivity().checkConnectivity())) break;

      try {
        await _processItem(item);
      } catch (e) {
        await _handleRetry(item);
      }
    }
  }

  Future<void> _processItem(dynamic item) async {
    final payload = _parsePayload(item.payloadJson);
    final tableId = item.recordTable as String;

    try {
      switch (item.operation) {
        case 'create':
          await _tablesDb!.createRow(
            databaseId: AW.dbFitkarma,
            tableId: tableId,
            rowId: item.recordId.toString(),
            data: Map<String, dynamic>.from(payload),
          );
          break;
        case 'update':
          await _tablesDb!.updateRow(
            databaseId: AW.dbFitkarma,
            tableId: tableId,
            rowId: item.recordId.toString(),
            data: Map<String, dynamic>.from(payload),
          );
          break;
        case 'delete':
          await _tablesDb!.deleteRow(
            databaseId: AW.dbFitkarma,
            tableId: tableId,
            rowId: item.recordId.toString(),
          );
          break;
      }

      await _database!.syncQueueDao.markDone(item.id as int);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _parsePayload(String json) {
    try {
      return json.isEmpty ? {} : {}..addAll(_jsonDecode(json));
    } catch (_) {
      return {};
    }
  }

  Map<String, dynamic> _jsonDecode(String source) {
    final result = <String, dynamic>{};
    var index = 0;

    void addPair(String key, dynamic value) {
      if (key.isNotEmpty) result[key] = value;
    }

    while (index < source.length) {
      final char = source[index];
      if (char == '{' || char == '}' || char == ',' || char == ':') {
        index++;
        continue;
      }
      if (char == '"') {
        final keyEnd = source.indexOf('"', index + 1);
        if (keyEnd > index + 1) {
          final key = source.substring(index + 1, keyEnd);
          index = keyEnd + 1;
          while (index < source.length && (source[index] == ':' || source[index] == ' ')) {
            index++;
          }
          if (source[index] == '"') {
            final valueEnd = source.indexOf('"', index + 1);
            if (valueEnd > index + 1) {
              addPair(key, source.substring(index + 1, valueEnd));
              index = valueEnd + 1;
            }
          } else if (source.startsWith('null', index)) {
            addPair(key, null);
            index += 4;
          } else if (source.startsWith('true', index)) {
            addPair(key, true);
            index += 4;
          } else if (source.startsWith('false', index)) {
            addPair(key, false);
            index += 5;
          } else {
            final numEnd = source.indexOf(',', index);
            final end = numEnd > 0 ? numEnd : source.length;
            final numStr = source.substring(index, end).trim();
            if (numStr.contains('.')) {
              addPair(key, double.tryParse(numStr) ?? 0.0);
            } else {
              addPair(key, int.tryParse(numStr) ?? 0);
            }
            index = end;
          }
        } else {
          index++;
        }
      } else {
        index++;
      }
    }

    return result;
  }

  Future<void> _handleRetry(dynamic item) async {
    await _database!.syncQueueDao.incrementRetry(item.id as int);
  }

  void dispose() {
    _database?.close();
  }
}

@pragma('vm:entry-point')
void backgroundSyncEntry() {
  BackgroundSyncRunner.start();
}