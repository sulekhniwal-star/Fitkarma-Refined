// lib/features/wearables/data/wearable_sync_service.dart
// Wearable device sync service for Fitbit, Garmin, and Health Connect bridges

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:fitkarma/features/health/data/health_data_service.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';

/// Wearable device types supported by Fitkarma
enum WearableType {
  healthConnect, // Android Health Connect (also bridges Mi Band, boAt)
  healthKit, // iOS HealthKit
  fitbit, // Fitbit Web API
  garmin, // Garmin Connect IQ
  none,
}

/// Connection status for wearable devices
enum WearableConnectionStatus {
  disconnected,
  connecting,
  connected,
  error,
  syncing,
}

/// Wearable device model
class WearableDevice {
  final String id;
  final String name;
  final WearableType type;
  final WearableConnectionStatus status;
  final DateTime? lastSyncAt;
  final Map<String, dynamic>? metadata;

  WearableDevice({
    required this.id,
    required this.name,
    required this.type,
    this.status = WearableConnectionStatus.disconnected,
    this.lastSyncAt,
    this.metadata,
  });

  WearableDevice copyWith({
    String? id,
    String? name,
    WearableType? type,
    WearableConnectionStatus? status,
    DateTime? lastSyncAt,
    Map<String, dynamic>? metadata,
  }) {
    return WearableDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

/// Sync interval configuration
class SyncIntervalConfig {
  /// Normal sync interval in minutes
  final int normalIntervalMinutes;

  /// Low data mode sync interval in minutes (default 6 hours = 360 minutes)
  final int lowDataIntervalMinutes;

  /// Background sync enabled
  final bool backgroundSyncEnabled;

  const SyncIntervalConfig({
    this.normalIntervalMinutes = 15,
    this.lowDataIntervalMinutes = 360, // 6 hours
    this.backgroundSyncEnabled = true,
  });

  /// Get current interval based on data saver mode
  int getInterval(bool isLowDataMode) {
    return isLowDataMode ? lowDataIntervalMinutes : normalIntervalMinutes;
  }
}

/// Wearable sync service
class WearableSyncService {
  static final WearableSyncService _instance = WearableSyncService._internal();
  factory WearableSyncService() => _instance;
  WearableSyncService._internal();

  // Current connected devices
  final List<WearableDevice> _connectedDevices = [];

  // Sync settings
  bool _isLowDataMode = false;
  DateTime? _lastSyncTimestamp;
  bool _isSyncing = false;

  // Timer for periodic sync
  Timer? _syncTimer;

  // Subscriptions
  StreamSubscription<bool>? _connectivitySubscription;

  // Configuration
  static const SyncIntervalConfig defaultConfig = SyncIntervalConfig();

  // Getters
  List<WearableDevice> get connectedDevices =>
      List.unmodifiable(_connectedDevices);
  bool get isLowDataMode => _isLowDataMode;
  DateTime? get lastSyncTimestamp => _lastSyncTimestamp;
  bool get isSyncing => _isSyncing;

  /// Initialize the wearable sync service
  Future<void> initialize() async {
    // Load saved settings
    await _loadSettings();

    // Listen for connectivity changes
    _connectivitySubscription = ConnectivityService.instance.isOnlineStream
        .listen((isOnline) {
          if (isOnline) {
            _triggerSync();
          }
        });

    // Start periodic sync
    _startPeriodicSync();

    debugPrint('WearableSyncService: Initialized');
  }

  /// Load saved settings from storage
  Future<void> _loadSettings() async {
    // TODO: Load from secure storage or Drift
    // For now, use defaults
    _isLowDataMode = false;
  }

  /// Save settings to storage
  Future<void> _saveSettings() async {
    // TODO: Save to secure storage or Drift
  }

  /// Start periodic sync timer
  void _startPeriodicSync() {
    _syncTimer?.cancel();
    final interval = defaultConfig.getInterval(_isLowDataMode);

    _syncTimer = Timer.periodic(
      Duration(minutes: interval),
      (_) => _triggerSync(),
    );

    debugPrint(
      'WearableSyncService: Periodic sync started (interval: ${interval}min)',
    );
  }

  /// Trigger a sync if not already syncing and online
  Future<void> _triggerSync() async {
    if (_isSyncing) return;
    if (!ConnectivityService.instance.isOnline) return;
    if (_connectedDevices.isEmpty) return;

    await performSync();
  }

  /// Perform sync for all connected devices
  Future<void> performSync() async {
    if (_isSyncing) return;
    if (!ConnectivityService.instance.isOnline) {
      debugPrint('WearableSyncService: Offline, skipping sync');
      return;
    }

    _isSyncing = true;
    final syncStartTime = DateTime.now();

    try {
      debugPrint('WearableSyncService: Starting sync...');

      // Sync each connected device
      for (final device in _connectedDevices) {
        if (device.status == WearableConnectionStatus.connected) {
          await _syncDevice(device);
        }
      }

      _lastSyncTimestamp = syncStartTime;
      debugPrint('WearableSyncService: Sync completed');
    } catch (e) {
      debugPrint('WearableSyncService: Sync error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync data from a specific device
  Future<void> _syncDevice(WearableDevice device) async {
    debugPrint('WearableSyncService: Syncing device: ${device.name}');

    final healthService = healthDataServiceProvider;
    final lastSync =
        _lastSyncTimestamp ?? DateTime.now().subtract(const Duration(days: 7));
    final now = DateTime.now();

    try {
      switch (device.type) {
        case WearableType.healthConnect:
        case WearableType.healthKit:
          // Sync from Health Connect / HealthKit
          await _syncHealthData(healthService, lastSync, now);
          break;

        case WearableType.fitbit:
          // Sync from Fitbit API (via Appwrite Function)
          await _syncFitbitData(lastSync, now);
          break;

        case WearableType.garmin:
          // Sync from Garmin API (via Appwrite Function)
          await _syncGarminData(lastSync, now);
          break;

        case WearableType.none:
          break;
      }

      // Update device last sync time
      final index = _connectedDevices.indexWhere((d) => d.id == device.id);
      if (index >= 0) {
        _connectedDevices[index] = device.copyWith(lastSyncAt: now);
      }
    } catch (e) {
      debugPrint(
        'WearableSyncService: Error syncing device ${device.name}: $e',
      );
    }
  }

  /// Sync health data from Health Connect / HealthKit
  Future<void> _syncHealthData(
    HealthDataService healthService,
    DateTime lastSync,
    DateTime now,
  ) async {
    // Get all data types
    final steps = await healthService.getStepsInRange(lastSync, now);
    final sleep = await healthService.getSleepData(lastSync, now);
    final heartRate = await healthService.getHeartRateData(lastSync, now);
    final spo2 = await healthService.getSpo2Data(lastSync, now);
    final bloodPressure = await healthService.getBloodPressureData(
      lastSync,
      now,
    );

    debugPrint(
      'WearableSyncService: Synced ${steps.length} step records, '
      '${sleep.length} sleep records, ${heartRate.length} HR records, '
      '${spo2.length} SpO2 records, ${bloodPressure.length} BP records',
    );

    // TODO: Save to local database and queue for sync
    // For now, just log the counts
  }

  /// Sync data from Fitbit API (via Appwrite Function)
  Future<void> _syncFitbitData(DateTime lastSync, DateTime now) async {
    // Fitbit sync would be done via Appwrite Functions
    // The client_secret is kept server-side
    debugPrint(
      'WearableSyncService: Fitbit sync would be done via Appwrite Function',
    );

    // TODO: Call Appwrite Function for Fitbit data
    // This will be implemented when the Appwrite Functions are created
  }

  /// Sync data from Garmin API (via Appwrite Function)
  Future<void> _syncGarminData(DateTime lastSync, DateTime now) async {
    // Garmin sync would be done via Appwrite Functions
    // The client_secret is kept server-side
    debugPrint(
      'WearableSyncService: Garmin sync would be done via Appwrite Function',
    );

    // TODO: Call Appwrite Function for Garmin data
    // This will be implemented when the Appwrite Functions are created
  }

  /// Connect to Health Connect / HealthKit
  Future<bool> connectHealthPlatform() async {
    final healthService = healthDataServiceProvider;
    await healthService.initialize();

    final authorized = await healthService.requestPermissions();

    if (authorized) {
      final platform = healthService.currentPlatform;
      final device = WearableDevice(
        id: 'health_platform',
        name: platform == FitkarmaHealthPlatform.healthConnect
            ? 'Health Connect'
            : 'Apple Health',
        type: platform == FitkarmaHealthPlatform.healthConnect
            ? WearableType.healthConnect
            : WearableType.healthKit,
        status: WearableConnectionStatus.connected,
        lastSyncAt: DateTime.now(),
      );

      // Add or update device
      final index = _connectedDevices.indexWhere((d) => d.type == device.type);
      if (index >= 0) {
        _connectedDevices[index] = device;
      } else {
        _connectedDevices.add(device);
      }
    }

    return authorized;
  }

  /// Connect to Fitbit (starts OAuth2 flow)
  Future<void> connectFitbit() async {
    // Add device in connecting state
    final device = WearableDevice(
      id: 'fitbit_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Fitbit',
      type: WearableType.fitbit,
      status: WearableConnectionStatus.connecting,
    );
    _connectedDevices.add(device);

    // TODO: Start OAuth2 flow - redirect to Appwrite OAuth
    // The actual OAuth is handled by Appwrite's OAuth provider
    // This is just for tracking connection state

    debugPrint('WearableSyncService: Fitbit OAuth flow initiated');
  }

  /// Connect to Garmin (starts OAuth1 flow)
  Future<void> connectGarmin() async {
    // Add device in connecting state
    final device = WearableDevice(
      id: 'garmin_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Garmin',
      type: WearableType.garmin,
      status: WearableConnectionStatus.connecting,
    );
    _connectedDevices.add(device);

    // TODO: Start OAuth1 flow - redirect to Appwrite OAuth
    // The actual OAuth is handled by Appwrite's OAuth provider

    debugPrint('WearableSyncService: Garmin OAuth1 flow initiated');
  }

  /// Handle OAuth callback for Fitbit/Garmin
  Future<void> handleOAuthCallback(String deviceId, bool success) async {
    final index = _connectedDevices.indexWhere((d) => d.id == deviceId);
    if (index < 0) return;

    final device = _connectedDevices[index];
    _connectedDevices[index] = device.copyWith(
      status: success
          ? WearableConnectionStatus.connected
          : WearableConnectionStatus.error,
      lastSyncAt: success ? DateTime.now() : null,
    );

    if (success) {
      await performSync();
    }
  }

  /// Disconnect a wearable device
  Future<void> disconnectDevice(String deviceId) async {
    _connectedDevices.removeWhere((d) => d.id == deviceId);
    debugPrint('WearableSyncService: Disconnected device: $deviceId');
  }

  /// Set low data mode
  Future<void> setLowDataMode(bool enabled) async {
    _isLowDataMode = enabled;
    await _saveSettings();

    // Restart periodic sync with new interval
    _startPeriodicSync();

    debugPrint(
      'WearableSyncService: Low data mode ${enabled ? "enabled" : "disabled"}',
    );
  }

  /// Get current sync interval in minutes
  int get currentSyncInterval {
    return defaultConfig.getInterval(_isLowDataMode);
  }

  /// Manually trigger a sync
  Future<void> triggerManualSync() async {
    await performSync();
  }

  /// Dispose resources
  void dispose() {
    _syncTimer?.cancel();
    _connectivitySubscription?.cancel();
  }
}

/// Provider for WearableSyncService
final wearableSyncServiceProvider = WearableSyncService();
