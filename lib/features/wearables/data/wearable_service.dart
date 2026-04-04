import 'dart:io';
import 'package:health/health.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum WearablePlatform { healthConnect, healthKit, fitbit, garmin }

class WearableService {
  final Health _health = Health();

  /// Types of data we want to sync
  final List<HealthDataType> _dataTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.BLOOD_OXYGEN,
    HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
    HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
    HealthDataType.SLEEP_ASLEEP,
    HealthDataType.SLEEP_AWAKE,
    HealthDataType.SLEEP_IN_BED,
  ];

  /// Initialize and request permissions
  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(_dataTypes);
  }

  /// Sync data since last sync date
  Future<List<HealthDataPoint>> fetchDelta(DateTime lastSyncAt) async {
    final now = DateTime.now();
    
    // Safety check for first sync (max 7 days back)
    final fromDate = now.difference(lastSyncAt).inDays > 7 
        ? now.subtract(const Duration(days: 7)) 
        : lastSyncAt;

    try {
      return await _health.getHealthDataFromTypes(
        startTime: fromDate,
        endTime: now,
        types: _dataTypes,
      );
    } catch (e) {
      return [];
    }
  }

  /// Check if the platform is supported
  bool isPlatformSupported(WearablePlatform platform) {
    if (platform == WearablePlatform.healthConnect) return Platform.isAndroid;
    if (platform == WearablePlatform.healthKit) return Platform.isIOS;
    return true; // Fitbit/Garmin are web-based
  }
}

final wearableServiceProvider = Provider<WearableService>((ref) => WearableService());
