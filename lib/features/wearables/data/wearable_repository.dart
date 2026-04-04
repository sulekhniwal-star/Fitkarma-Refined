import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/wearables/data/wearable_service.dart';
import 'package:fitkarma/core/network/appwrite_client.dart';
import 'package:fitkarma/core/constants/api_endpoints.dart';

class WearableState {
  final DateTime? lastSyncAt;
  final bool isLowDataMode;
  final bool isSyncing;
  final String? error;
  final Map<WearablePlatform, bool> connectedPlatforms;

  const WearableState({
    this.lastSyncAt,
    this.isLowDataMode = false,
    this.isSyncing = false,
    this.error,
    this.connectedPlatforms = const {},
  });

  WearableState copyWith({
    DateTime? lastSyncAt,
    bool? isLowDataMode,
    bool? isSyncing,
    String? error,
    Map<WearablePlatform, bool>? connectedPlatforms,
  }) {
    return WearableState(
      lastSyncAt: lastSyncAt ?? this.lastSyncAt,
      isLowDataMode: isLowDataMode ?? this.isLowDataMode,
      isSyncing: isSyncing ?? this.isSyncing,
      error: error ?? this.error,
      connectedPlatforms: connectedPlatforms ?? this.connectedPlatforms,
    );
  }
}

class WearableRepository extends Notifier<WearableState> {
  late final WearableService _service;
  late final AppwriteClient _appwrite;

  @override
  WearableState build() {
    _service = ref.read(wearableServiceProvider);
    _appwrite = AppwriteClient.instance;
    return const WearableState();
  }

  /// Connect to Health Connect (Android) or HealthKit (iOS)
  Future<void> connectHealthPlatform() async {
    state = state.copyWith(isSyncing: true, error: null);
    try {
      final success = await _service.requestPermissions();
      if (success) {
        final platform = _service.isPlatformSupported(WearablePlatform.healthConnect)
            ? WearablePlatform.healthConnect
            : WearablePlatform.healthKit;
        
        state = state.copyWith(
          connectedPlatforms: {...state.connectedPlatforms, platform: true},
        );
        await syncData();
      } else {
        state = state.copyWith(error: 'Permissions denied');
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  /// Start OAuth flow for Fitbit or Garmin
  Future<void> connectProvider(WearablePlatform platform) async {
    state = state.copyWith(isSyncing: true, error: null);
    try {
      // In a production environment, this would call AW.fnWearableSync 
      // to initiate the OAuth flow and open the URL in a browser.
      
      state = state.copyWith(
        connectedPlatforms: {...state.connectedPlatforms, platform: true},
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  /// Perform Delta Sync
  Future<void> syncData({bool force = false}) async {
    if (state.isSyncing) return;
    
    // Low Data Mode Check: skip if synced within last 6 hours
    if (state.isLowDataMode && !force && state.lastSyncAt != null) {
      if (DateTime.now().difference(state.lastSyncAt!).inHours < 6) return;
    }

    state = state.copyWith(isSyncing: true, error: null);
    try {
      final lastSync = state.lastSyncAt ?? DateTime.now().subtract(const Duration(days: 1));
      final points = await _service.fetchDelta(lastSync);
      
      if (points.isNotEmpty) {
        // Upload points to Appwrite for aggregation
        await _appwrite.functions.createExecution(
          functionId: AW.fnWearableSync,
          body: jsonEncode({
            'action': 'upload_data',
            'points': points.map((p) => p.toJson()).toList(),
          }),
        );
      }
      
      state = state.copyWith(lastSyncAt: DateTime.now());
    } catch (e) {
      state = state.copyWith(error: 'Sync failed: $e');
    } finally {
      state = state.copyWith(isSyncing: false);
    }
  }

  void toggleLowDataMode(bool value) {
    state = state.copyWith(isLowDataMode: value);
  }
}

final wearableRepositoryProvider = NotifierProvider<WearableRepository, WearableState>(() {
  return WearableRepository();
});
