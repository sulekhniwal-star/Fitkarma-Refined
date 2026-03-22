// lib/features/health/data/delta_sync_service.dart
// Delta sync service for fetching data since last_sync_at

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fitkarma/features/health/data/health_data_service.dart';
import 'package:fitkarma/features/wearables/data/wearable_sync_service.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';

/// Delta sync service that handles incremental data sync on app resume
class DeltaSyncService extends WidgetsBindingObserver {
  static final DeltaSyncService _instance = DeltaSyncService._internal();
  factory DeltaSyncService() => _instance;
  DeltaSyncService._internal();

  // Last sync timestamp (persisted in storage)
  DateTime? _lastSyncAt;

  // Whether sync is in progress
  bool _isSyncing = false;

  // Connectivity subscription
  StreamSubscription<bool>? _connectivitySubscription;

  // Callback for sync completion
  void Function(DateTime syncStartTime, DateTime syncEndTime)? _onSyncComplete;

  // Getters
  DateTime? get lastSyncAt => _lastSyncAt;
  bool get isSyncing => _isSyncing;

  /// Initialize the delta sync service
  Future<void> initialize() async {
    // Load last sync timestamp from storage
    await _loadLastSyncTimestamp();

    // Register as lifecycle observer
    WidgetsBinding.instance.addObserver(this);

    // Listen for connectivity changes
    _connectivitySubscription = ConnectivityService.instance.isOnlineStream
        .listen((isOnline) {
          if (isOnline && _shouldSyncOnConnect()) {
            triggerDeltaSync();
          }
        });

    debugPrint('DeltaSyncService: Initialized, last sync: $_lastSyncAt');
  }

  /// Load last sync timestamp from storage
  Future<void> _loadLastSyncTimestamp() async {
    // TODO: Load from secure storage or Drift database
    // For now, use a default of 7 days ago
    _lastSyncAt = DateTime.now().subtract(const Duration(days: 7));
  }

  /// Save last sync timestamp to storage
  Future<void> _saveLastSyncTimestamp() async {
    // TODO: Save to secure storage or Drift database
  }

  /// Check if we should sync when connectivity is restored
  bool _shouldSyncOnConnect() {
    if (_lastSyncAt == null) return true;

    final timeSinceLastSync = DateTime.now().difference(_lastSyncAt!);

    // Sync if it's been more than 1 hour since last sync
    return timeSinceLastSync.inHours >= 1;
  }

  // ======= WidgetsBindingObserver Implementation =======

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint('DeltaSyncService: App resumed');

      // Trigger delta sync if:
      // 1. We have a last sync timestamp
      // 2. We're not already syncing
      // 3. We have network connectivity

      if (_lastSyncAt != null && !_isSyncing) {
        if (ConnectivityService.instance.isOnline) {
          triggerDeltaSync();
        } else {
          debugPrint('DeltaSyncService: No network, skipping sync');
        }
      }
    }
  }

  /// Trigger delta sync - fetch data since last_sync_at
  Future<void> triggerDeltaSync() async {
    if (_isSyncing) {
      debugPrint('DeltaSyncService: Sync already in progress');
      return;
    }

    if (!ConnectivityService.instance.isOnline) {
      debugPrint('DeltaSyncService: Offline, skipping sync');
      return;
    }

    _isSyncing = true;
    final syncStartTime = DateTime.now();

    try {
      debugPrint('DeltaSyncService: Starting delta sync from $_lastSyncAt');

      // Use last sync time or default to 7 days ago
      final startTime =
          _lastSyncAt ?? DateTime.now().subtract(const Duration(days: 7));
      final endTime = DateTime.now();

      // Sync from Health Connect / HealthKit
      await _syncHealthData(startTime, endTime);

      // Sync from wearable devices (Fitbit, Garmin)
      await _syncWearableData(startTime, endTime);

      // Update last sync timestamp
      _lastSyncAt = syncStartTime;
      await _saveLastSyncTimestamp();

      // Notify completion
      _onSyncComplete?.call(syncStartTime, endTime);

      debugPrint('DeltaSyncService: Delta sync completed successfully');
    } catch (e) {
      debugPrint('DeltaSyncService: Delta sync error: $e');
    } finally {
      _isSyncing = false;
    }
  }

  /// Sync data from Health Connect / HealthKit
  Future<void> _syncHealthData(DateTime startTime, DateTime endTime) async {
    final healthService = healthDataServiceProvider;

    // Check if health platform is available
    if (!healthService.isHealthPlatformAvailable) {
      debugPrint('DeltaSyncService: Health platform not available');
      return;
    }

    try {
      // Fetch data for all types
      final results = await Future.wait([
        healthService.getStepsInRange(startTime, endTime),
        healthService.getSleepData(startTime, endTime),
        healthService.getHeartRateData(startTime, endTime),
        healthService.getSpo2Data(startTime, endTime),
        healthService.getBloodPressureData(startTime, endTime),
      ]);

      final steps = results[0];
      final sleep = results[1];
      final heartRate = results[2];
      final spo2 = results[3];
      final bloodPressure = results[4];

      debugPrint(
        'DeltaSyncService: Health data - '
        '${steps.length} steps, '
        '${sleep.length} sleep, '
        '${heartRate.length} HR, '
        '${spo2.length} SpO2, '
        '${bloodPressure.length} BP records',
      );

      // TODO: Save to local database and queue for cloud sync
      // For now, just log the counts
    } catch (e) {
      debugPrint('DeltaSyncService: Error syncing health data: $e');
    }
  }

  /// Sync data from wearable devices
  Future<void> _syncWearableData(DateTime startTime, DateTime endTime) async {
    final wearableService = wearableSyncServiceProvider;
    final devices = wearableService.connectedDevices;

    if (devices.isEmpty) {
      debugPrint('DeltaSyncService: No wearable devices connected');
      return;
    }

    try {
      await wearableService.performSync();
      debugPrint('DeltaSyncService: Wearable sync completed');
    } catch (e) {
      debugPrint('DeltaSyncService: Error syncing wearable data: $e');
    }
  }

  /// Force a full sync (ignoring last_sync_at)
  Future<void> triggerFullSync() async {
    _lastSyncAt = null; // Reset to trigger full sync
    await triggerDeltaSync();
  }

  /// Set callback for sync completion
  void setOnSyncComplete(void Function(DateTime, DateTime)? callback) {
    _onSyncComplete = callback;
  }

  /// Get time since last sync
  Duration? getTimeSinceLastSync() {
    if (_lastSyncAt == null) return null;
    return DateTime.now().difference(_lastSyncAt!);
  }

  /// Check if sync is due (more than interval since last sync)
  bool isSyncDue({int intervalMinutes = 60}) {
    final timeSince = getTimeSinceLastSync();
    if (timeSince == null) return true;
    return timeSince.inMinutes >= intervalMinutes;
  }

  /// Dispose resources
  void dispose() {
    _connectivitySubscription?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }
}

/// Provider for DeltaSyncService
final deltaSyncServiceProvider = DeltaSyncService();
