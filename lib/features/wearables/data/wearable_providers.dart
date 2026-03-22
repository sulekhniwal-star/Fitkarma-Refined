// lib/features/wearables/data/wearable_providers.dart
// Providers for wearable sync service

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/wearables/data/wearable_sync_service.dart';

/// Provider for wearable sync service singleton
final wearableSyncServiceProvider = Provider<WearableSyncService>((ref) {
  return WearableSyncService();
});

/// Provider for connected wearable devices
final wearableDevicesProvider = Provider<List<WearableDevice>>((ref) {
  final service = ref.watch(wearableSyncServiceProvider);
  return service.connectedDevices;
});

/// Provider for low data mode setting
final lowDataModeProvider = Provider<bool>((ref) {
  final service = ref.watch(wearableSyncServiceProvider);
  return service.isLowDataMode;
});

/// Provider for sync status
final syncStatusProvider = Provider<WearableSyncStatus>((ref) {
  final service = ref.watch(wearableSyncServiceProvider);

  return WearableSyncStatus(
    isSyncing: service.isSyncing,
    lastSyncAt: service.lastSyncTimestamp,
    syncIntervalMinutes: service.currentSyncInterval,
  );
});

class WearableSyncStatus {
  final bool isSyncing;
  final DateTime? lastSyncAt;
  final int syncIntervalMinutes;

  WearableSyncStatus({
    required this.isSyncing,
    this.lastSyncAt,
    required this.syncIntervalMinutes,
  });
}
