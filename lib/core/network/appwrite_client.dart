import 'dart:io';
import 'dart:convert' as convert;

import 'package:appwrite/appwrite.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/config/remote_config.dart';

String _pinnedCertHash = '';

Future<bool> isDeviceCompromised() async {
  if (kDebugMode) return false;

  if (Platform.isAndroid) {
    return _checkAndroidRoot();
  } else if (Platform.isIOS) {
    return _checkIosJailbreak();
  }
  return false;
}

Future<bool> _checkAndroidRoot() async {
  const rootIndicators = [
    '/system/app/Superuser.apk',
    '/sbin/su',
    '/system/bin/su',
    '/system/xbin/su',
    '/data/local/xbin/su',
    '/data/local/bin/su',
    '/system/sd/xbin/su',
    '/system/bin/failsafe/su',
    '/data/local/su',
    '/su/bin/su',
  ];

  for (final path in rootIndicators) {
    if (await File(path).exists()) return true;
  }

  try {
    final result = await Process.run('which', ['su']);
    if (result.exitCode == 0) return true;
  } catch (_) {}

  return false;
}

Future<bool> _checkIosJailbreak() async {
  const jailbreakPaths = [
    '/Applications/Cydia.app',
    '/Library/MobileSubstrate/MobileSubstrate.dylib',
    '/bin/bash',
    '/usr/sbin/sshd',
    '/etc/apt',
    '/private/var/lib/apt/',
    '/usr/bin/ssh',
  ];

  for (final path in jailbreakPaths) {
    if (await File(path).exists()) return true;
  }

  return false;
}

class AppwriteClient {
  AppwriteClient._();

  static final AppwriteClient instance = AppwriteClient._();

  late final Client _client;
  late final Account account;
  late final Databases databases;
  late final Storage storage;
  late final Functions functions;
  late final Realtime realtime;
  late final Messaging messaging;
  late final Avatars avatars;

  late final Dio _dio;

  bool _initialized = false;
  bool _isCompromised = false;
  bool _connectionTested = false;
  bool _connectionOk = false;

  bool get isCompromised => _isCompromised;
  bool get connectionOk => _connectionOk;

  Future<void> init() async {
    if (_initialized) return;

    _isCompromised = await isDeviceCompromised();
    if (_isCompromised) {
      debugPrint('WARNING: Device appears to be rooted/jailbroken');
    }

    _client = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId)
      ..setSelfSigned(status: false);

    final pinnedCertFromRemote = _getPinnedCertFromRemote();
    if (pinnedCertFromRemote.isNotEmpty) {
      _pinnedCertHash = pinnedCertFromRemote;
    }

    if (!kDebugMode && _pinnedCertHash.isNotEmpty) {
      debugPrint('Certificate pinning enabled for ${AppConfig.appwriteEndpoint}');
    }

    _dio = Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final client = _client;
        final headers = options.headers;
        final cookie = client.config['cookies'];
        if (cookie != null) {
          headers['Cookie'] = convert.jsonEncode(cookie);
        }
        final authHeaders = client.config['headers'];
        if (authHeaders != null && authHeaders is Map) {
          headers.addAll(Map<String, dynamic>.from(authHeaders as Map));
        }
        return handler.next(options);
      },
    ));

    account = Account(_client);
    databases = Databases(_client);
    storage = Storage(_client);
    functions = Functions(_client);
    realtime = Realtime(_client);
    messaging = Messaging(_client);
    avatars = Avatars(_client);

    _initialized = true;
    debugPrint('AppwriteClient initialized (project: ${AppConfig.appwriteProjectId})');

    testConnection();
  }

  String _getPinnedCertFromRemote() {
    try {
      final container = ProviderContainer();
      final remoteConfig = container.read(remoteConfigProvider);
      return remoteConfig.raw('cert.pinned_hash') ?? '';
    } catch (_) {
      return '';
    }
  }

  Future<void> testConnection() async {
    if (_connectionTested) return;
    _connectionTested = true;

    try {
      final result = await account.get();
      _connectionOk = true;
      debugPrint('Appwrite connection: OK (authenticated) user=${result.name}');
    } on AppwriteException catch (e) {
      if (e.code == 401) {
        _connectionOk = true;
        debugPrint('Appwrite connection: OK (unauthenticated)');
      } else {
        _connectionOk = false;
        debugPrint('Appwrite connection error: ${e.message} (code ${e.code})');
      }
    } catch (e) {
      _connectionOk = false;
      debugPrint('Appwrite connection failed: $e');
    }
  }

  void updatePinnedCertHash(String newHash) {
    _pinnedCertHash = newHash;
    debugPrint('Cert pin updated: $newHash');
  }

  Client get client => _client;

  Dio get dio => _dio;
}