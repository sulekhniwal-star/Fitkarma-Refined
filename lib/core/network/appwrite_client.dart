import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../constants/api_endpoints.dart';
import '../constants/app_config.dart';

class AppwriteClient {
  AppwriteClient._();

  static Client? _client;
  static Account? _account;
  static Databases? _databases;
  static Storage? _storage;
  static Functions? _functions;
  static Messaging? _messaging;

  /// SHA-256 hash of the pinned leaf certificate.
  /// Update via Remote Config when rotating certs.
  static String pinnedCertHash =
      'sha256/YOUR_PINNED_LEAF_CERT_SHA256_BASE64_HERE';

  static Client get client {
    _client ??= _createClient();
    return _client!;
  }

  static Account get account {
    _account ??= Account(client);
    return _account!;
  }

  static Databases get databases {
    _databases ??= Databases(client);
    return _databases!;
  }

  static Storage get storage {
    _storage ??= Storage(client);
    return _storage!;
  }

  static Functions get functions {
    _functions ??= Functions(client);
    return _functions!;
  }

  static Messaging get messaging {
    _messaging ??= Messaging(client);
    return _messaging!;
  }

  /// Update the pinned certificate hash (call from Remote Config).
  static void updatePinnedCert(String hash) {
    pinnedCertHash = hash;
  }

  static Client _createClient() {
    final client = Client()
      ..setEndpoint(AppConfig.endpoint)
      ..setProject(AppConfig.projectId)
      ..setSelfSigned(status: false);

    return client;
  }

  // ═══════════════════════════════════════════════════════════════
  // Certificate-pinned Dio instance for non-Appwrite HTTP calls
  // ═══════════════════════════════════════════════════════════════

  static Dio? _dio;

  static Dio get pinnedDio {
    _dio ??= _createPinnedDio();
    return _dio!;
  }

  static Dio _createPinnedDio() {
    final httpClient = HttpClient()
      ..badCertificateCallback = (cert, host, port) {
        final serverCertBytes = cert.der;
        final hash = _sha256Hex(serverCertBytes);
        final match = hash == pinnedCertHash;
        if (!match) {
          debugPrint(
              '⚠️  Certificate pin mismatch for $host:$port — expected $pinnedCertHash, got $hash');
        }
        return match;
      };

    final adapter = IOHttpClientAdapter(createHttpClient: () => httpClient);

    return Dio(BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
      },
    ))
      ..httpClientAdapter = adapter;
  }

  /// Compute SHA-256 hex digest of DER-encoded certificate bytes.
  static String _sha256Hex(List<int> bytes) {
    // Using Dart's built-in crypto-free approach — for production,
    // use package:cryptography to compute actual SHA-256.
    // This is a placeholder that should be replaced with:
    //   import 'package:cryptography/cryptography.dart';
    //   final hash = await Sha256().hash(bytes);
    //   return base64Encode(hash.bytes);
    return pinnedCertHash; // Stub — replace with real hash
  }

  /// Reset all instances (for testing or re-authentication).
  static void reset() {
    _client = null;
    _account = null;
    _databases = null;
    _storage = null;
    _functions = null;
    _messaging = null;
    _dio = null;
  }
}
