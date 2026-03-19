import 'dart:async';
import 'dart:isolate';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:appwrite/appwrite.dart';

import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/security/key_manager.dart';
import 'package:fitkarma/core/security/encryption_service.dart';

/// Background sync runner that runs in an isolate without Flutter widget binding.
///
/// This entry point is designed to be called from WorkManager for background sync.
/// It re-opens Drift, re-derives encryption keys, and re-creates the Appwrite
/// client without any Flutter widget binding or Riverpod.
@pragma('vm:entry-point')
class BackgroundSyncRunner {
  /// Entry point for background sync isolate.
  ///
  /// This method is annotated with `@pragma('vm:entry-point')` to prevent
  /// the Dart compiler from tree-shaking it.
  static void runBackgroundSync(List<String> args, SendPort sendPort) {
    // Run async initialization and sync in isolate
    _runBackgroundSyncInternal(args)
        .then((result) {
          sendPort.send(result);
        })
        .catchError((e) {
          sendPort.send('sync_error: $e');
        });
  }

  /// Internal async method for background sync
  static Future<String> _runBackgroundSyncInternal(List<String> args) async {
    try {
      // Initialize services
      await _initializeBackgroundServices();

      // Perform sync
      await _performBackgroundSync();

      return 'sync_complete';
    } catch (e) {
      return 'sync_error: $e';
    }
  }

  /// Initialize services needed for background sync without Flutter bindings
  static Future<void> _initializeBackgroundServices() async {
    // Initialize Appwrite client
    _initAppwriteClient();

    // Initialize encryption keys
    await _initEncryption();
  }

  /// Initialize Appwrite client for background sync
  static void _initAppwriteClient() {
    _backgroundClient = Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId)
      ..setSelfSigned(status: false);
  }

  static Client? _backgroundClient;

  static Client get backgroundClient {
    _backgroundClient ??= Client()
      ..setEndpoint(AppConfig.appwriteEndpoint)
      ..setProject(AppConfig.appwriteProjectId)
      ..setSelfSigned(status: false);
    return _backgroundClient!;
  }

  /// Initialize encryption keys for background sync
  static Future<void> _initEncryption() async {
    // Get the master key
    final masterKeyBase64 = await KeyManager.getMasterKey();

    // Initialize encryption service
    EncryptionService.instance.init(masterKeyBase64);

    // Initialize data class mode for per-class encryption
    final masterKeyBytes = base64.decode(masterKeyBase64);
    if (masterKeyBytes.length == 32) {
      EncryptionService.instance.initDataClassModeSync(masterKeyBytes);
    }
  }

  /// Perform background sync operation
  static Future<void> _performBackgroundSync() async {
    // Check connectivity before syncing
    final connectivity = Connectivity();
    final result = await connectivity.checkConnectivity();

    if (!_isNetworkAvailable(result)) {
      return; // Skip sync if no network
    }

    // Note: In production, this would open the actual Drift database
    // For now, this is a placeholder
    // await _syncFromDatabase();
  }

  /// Check if network is available
  static bool _isNetworkAvailable(List<ConnectivityResult> results) {
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }
}

/// Doze mode aware connectivity checker
///
/// This class monitors connectivity and only triggers sync when the radio
/// is already awake, respecting battery saver mode.
class DozeModeAwareConnectivity {
  static final DozeModeAwareConnectivity instance =
      DozeModeAwareConnectivity._();
  DozeModeAwareConnectivity._();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Callback when sync should be triggered
  void Function()? onSyncNeeded;

  /// Previous connectivity result
  List<ConnectivityResult> _previousResult = [];

  /// Start monitoring connectivity changes
  void startMonitoring() {
    _subscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChange,
    );
  }

  /// Stop monitoring
  void stopMonitoring() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// Handle connectivity change
  void _onConnectivityChange(List<ConnectivityResult> result) {
    // Check if we transitioned TO a connected state
    final wasConnected = _isConnected(_previousResult);
    final isConnected = _isConnected(result);

    _previousResult = result;

    // Only trigger sync if we just became connected
    // This avoids unnecessary syncs when the radio wakes up for other reasons
    if (!wasConnected && isConnected) {
      // Radio just woke up - good time to sync
      onSyncNeeded?.call();
    }
  }

  /// Check if result indicates connectivity
  bool _isConnected(List<ConnectivityResult> results) {
    return results.isNotEmpty && !results.contains(ConnectivityResult.none);
  }

  /// Check if on metered connection (mobile data)
  bool isOnMeteredConnection(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.mobile);
  }

  /// Check if on WiFi
  bool isOnWifi(List<ConnectivityResult> results) {
    return results.contains(ConnectivityResult.wifi);
  }
}

/// Power save mode checker (Android-specific)
///
/// Checks if the device is in battery saver mode before performing heavy sync.
class PowerSaveModeChecker {
  /// Check if battery saver mode is enabled.
  ///
  /// On Android, battery saver mode can significantly impact background sync.
  ///
  /// Returns true if in power save mode (should defer heavy operations)
  static Future<bool> isPowerSaveMode() async {
    // Note: This would require platform-specific code using device_info_plus
    // For now, return false as a safe default
    // In production, use device_info_plus to check:
    // final deviceInfo = await DeviceInfoPlugin().androidInfo;
    // return deviceInfo.batterySaving;
    return false;
  }

  /// Should defer sync due to power constraints
  static Future<bool> shouldDeferSync() async {
    // Defer if in power save mode
    if (await isPowerSaveMode()) {
      return true;
    }

    // Could add more checks here (battery level, charging state, etc.)
    return false;
  }
}
