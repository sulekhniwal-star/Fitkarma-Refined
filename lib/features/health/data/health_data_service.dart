// lib/features/health/data/health_data_service.dart
// Comprehensive Health Data Service for Health Connect (Android) and HealthKit (iOS)
// Supports: Steps, Sleep, Heart Rate, SpO2, Blood Pressure

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:pedometer/pedometer.dart';

/// Health platform type
enum FitkarmaHealthPlatform { healthConnect, healthKit, pedometer, none }

/// Custom health data type enum (for app-level abstraction)
enum FitkarmaHealthDataType {
  steps,
  sleep,
  heartRate,
  spo2,
  bloodPressure,
  distance,
}

/// Health data point wrapper for unified access
class UnifiedHealthDataPoint {
  final FitkarmaHealthDataType type;
  final DateTime timestamp;
  final double value;
  final double? secondaryValue; // For BP: diastolic
  final Map<String, dynamic>? metadata;

  UnifiedHealthDataPoint({
    required this.type,
    required this.timestamp,
    required this.value,
    this.secondaryValue,
    this.metadata,
  });
}

/// Comprehensive Health Data Service
class HealthDataService {
  static final HealthDataService _instance = HealthDataService._internal();
  factory HealthDataService() => _instance;
  HealthDataService._internal();

  Health? _health;
  bool _isAuthorized = false;
  FitkarmaHealthPlatform _currentPlatform = FitkarmaHealthPlatform.none;
  StreamSubscription<StepCount>? _stepSubscription;

  // Permission states for each data type
  Map<FitkarmaHealthDataType, bool> _permissionStates = {};

  // Step stream controller for real-time updates
  final _stepStreamController = StreamController<int>.broadcast();
  Stream<int> get stepStream => _stepStreamController.stream;

  bool get isAuthorized => _isAuthorized;
  FitkarmaHealthPlatform get currentPlatform => _currentPlatform;

  /// Initialize health platform based on OS
  Future<void> initialize() async {
    if (_health != null) return; // Already initialized

    if (Platform.isAndroid) {
      _health = Health();
      _currentPlatform = FitkarmaHealthPlatform.healthConnect;
      debugPrint('HealthDataService: Initialized Health Connect (Android)');
    } else if (Platform.isIOS) {
      _health = Health();
      _currentPlatform = FitkarmaHealthPlatform.healthKit;
      debugPrint('HealthDataService: Initialized HealthKit (iOS)');
    } else {
      _currentPlatform = FitkarmaHealthPlatform.none;
      debugPrint('HealthDataService: No health platform available');
    }
  }

  /// Request permissions for all health data types
  Future<bool> requestPermissions() async {
    try {
      if (_health == null) {
        await initialize();
      }

      // Use health package types
      final requestedTypes = [
        HealthDataType.STEPS,
        HealthDataType.SLEEP_SESSION,
        HealthDataType.HEART_RATE,
        HealthDataType.BLOOD_OXYGEN,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.DISTANCE_DELTA,
      ];

      // Request permissions
      _isAuthorized = await _health!.requestAuthorization(requestedTypes);

      // Update permission states
      _permissionStates[FitkarmaHealthDataType.steps] = _isAuthorized;
      _permissionStates[FitkarmaHealthDataType.sleep] = _isAuthorized;
      _permissionStates[FitkarmaHealthDataType.heartRate] = _isAuthorized;
      _permissionStates[FitkarmaHealthDataType.spo2] = _isAuthorized;
      _permissionStates[FitkarmaHealthDataType.bloodPressure] = _isAuthorized;
      _permissionStates[FitkarmaHealthDataType.distance] = _isAuthorized;

      if (!_isAuthorized) {
        debugPrint('HealthDataService: Permissions denied, using fallback');
        _currentPlatform = FitkarmaHealthPlatform.pedometer;
      }

      return _isAuthorized;
    } catch (e) {
      debugPrint('HealthDataService: Error requesting permissions: $e');
      _currentPlatform = FitkarmaHealthPlatform.pedometer;
      return false;
    }
  }

  /// Check if we should use pedometer fallback
  bool get shouldUsePedometerFallback =>
      !_isAuthorized || _currentPlatform == FitkarmaHealthPlatform.pedometer;

  // ==================== STEPS ====================

  /// Get today's step count
  Future<int> getTodaySteps() async {
    try {
      if (shouldUsePedometerFallback) {
        return await _getPedometerSteps();
      }

      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      final steps = await _health!.getTotalStepsInInterval(startOfDay, now);
      return steps ?? 0;
    } catch (e) {
      debugPrint('HealthDataService: Error getting today steps: $e');
      return await _getPedometerSteps();
    }
  }

  /// Get steps for a specific date
  Future<int> getStepsForDate(DateTime date) async {
    try {
      if (shouldUsePedometerFallback) {
        return 0;
      }

      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final steps = await _health!.getTotalStepsInInterval(
        startOfDay,
        endOfDay,
      );
      return steps ?? 0;
    } catch (e) {
      debugPrint('HealthDataService: Error getting steps for date: $e');
      return 0;
    }
  }

  /// Get steps for a date range (for delta sync)
  Future<List<UnifiedHealthDataPoint>> getStepsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.STEPS],
      );

      return points
          .map(
            (p) => UnifiedHealthDataPoint(
              type: FitkarmaHealthDataType.steps,
              timestamp: p.dateFrom,
              value: (p.value as num).toDouble(),
              metadata: {
                'source': p.sourceId,
                'sourceName': p.sourceName,
                'unit': p.unit.toString(),
              },
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting steps in range: $e');
      return [];
    }
  }

  /// Calculate distance from steps
  double calculateDistanceKm(int steps) {
    // Average stride length ~0.762m (adult)
    return (steps * 0.762) / 1000;
  }

  /// Start real-time step counting
  void startStepCounting() {
    if (_stepSubscription != null) return;

    try {
      _stepSubscription = Pedometer.stepCountStream.listen(
        (StepCount event) {
          _stepStreamController.add(event.steps);
        },
        onError: (error) {
          debugPrint('HealthDataService: Pedometer error: $error');
        },
      );
    } catch (e) {
      debugPrint('HealthDataService: Error starting step counting: $e');
    }
  }

  /// Stop real-time step counting
  void stopStepCounting() {
    _stepSubscription?.cancel();
    _stepSubscription = null;
  }

  // ==================== SLEEP ====================

  /// Get sleep data for a date range
  Future<List<UnifiedHealthDataPoint>> getSleepData(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.SLEEP_SESSION],
      );

      return points
          .map(
            (p) => UnifiedHealthDataPoint(
              type: FitkarmaHealthDataType.sleep,
              timestamp: p.dateFrom,
              value: (p.value as num).toDouble(),
              metadata: {
                'source': p.sourceId,
                'sourceName': p.sourceName,
                'endTime': p.dateTo.toIso8601String(),
                'unit': p.unit.toString(),
              },
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting sleep data: $e');
      return [];
    }
  }

  /// Get last night's sleep data
  Future<UnifiedHealthDataPoint?> getLastNightSleep() async {
    final now = DateTime.now();
    final lastNight = now.subtract(const Duration(hours: 24));

    final sleepData = await getSleepData(lastNight, now);
    if (sleepData.isEmpty) return null;

    // Return the most recent sleep session
    sleepData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sleepData.first;
  }

  // ==================== HEART RATE ====================

  /// Get heart rate data for a date range
  Future<List<UnifiedHealthDataPoint>> getHeartRateData(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.HEART_RATE],
      );

      return points
          .map(
            (p) => UnifiedHealthDataPoint(
              type: FitkarmaHealthDataType.heartRate,
              timestamp: p.dateFrom,
              value: (p.value as num).toDouble(),
              metadata: {
                'source': p.sourceId,
                'sourceName': p.sourceName,
                'unit': p.unit.toString(),
              },
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting heart rate data: $e');
      return [];
    }
  }

  /// Get latest heart rate
  Future<double?> getLatestHeartRate() async {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));

    final hrData = await getHeartRateData(oneHourAgo, now);
    if (hrData.isEmpty) return null;

    // Return the most recent reading
    hrData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return hrData.first.value;
  }

  // ==================== SpO2 ====================

  /// Get SpO2 data for a date range
  Future<List<UnifiedHealthDataPoint>> getSpo2Data(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.BLOOD_OXYGEN],
      );

      return points
          .map(
            (p) => UnifiedHealthDataPoint(
              type: FitkarmaHealthDataType.spo2,
              timestamp: p.dateFrom,
              value: (p.value as num).toDouble(),
              metadata: {
                'source': p.sourceId,
                'sourceName': p.sourceName,
                'unit': p.unit.toString(),
              },
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting SpO2 data: $e');
      return [];
    }
  }

  /// Get latest SpO2 reading
  Future<double?> getLatestSpo2() async {
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));

    final spo2Data = await getSpo2Data(oneHourAgo, now);
    if (spo2Data.isEmpty) return null;

    spo2Data.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return spo2Data.first.value;
  }

  // ==================== BLOOD PRESSURE ====================

  /// Get blood pressure data for a date range
  Future<List<UnifiedHealthDataPoint>> getBloodPressureData(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [
          HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
          HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        ],
      );

      // Group systolic and diastolic readings by timestamp
      final Map<int, UnifiedHealthDataPoint> bpReadings = {};

      for (final point in points) {
        final key = point.dateFrom.millisecondsSinceEpoch;
        if (point.type == HealthDataType.BLOOD_PRESSURE_SYSTOLIC) {
          bpReadings[key] = UnifiedHealthDataPoint(
            type: FitkarmaHealthDataType.bloodPressure,
            timestamp: point.dateFrom,
            value: (point.value as num).toDouble(),
            metadata: {
              'source': point.sourceId,
              'sourceName': point.sourceName,
            },
          );
        } else if (point.type == HealthDataType.BLOOD_PRESSURE_DIASTOLIC) {
          if (bpReadings.containsKey(key)) {
            final existing = bpReadings[key]!;
            bpReadings[key] = UnifiedHealthDataPoint(
              type: existing.type,
              timestamp: existing.timestamp,
              value: existing.value,
              secondaryValue: (point.value as num).toDouble(),
              metadata: existing.metadata,
            );
          }
        }
      }

      return bpReadings.values.toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting BP data: $e');
      return [];
    }
  }

  /// Get latest blood pressure reading
  Future<({int systolic, int diastolic})?> getLatestBloodPressure() async {
    final now = DateTime.now();
    final oneDayAgo = now.subtract(const Duration(days: 1));

    final bpData = await getBloodPressureData(oneDayAgo, now);
    if (bpData.isEmpty) return null;

    bpData.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    final latest = bpData.first;

    return (
      systolic: latest.value.toInt(),
      diastolic: latest.secondaryValue?.toInt() ?? 0,
    );
  }

  // ==================== DISTANCE ====================

  /// Get distance data for a date range
  Future<List<UnifiedHealthDataPoint>> getDistanceData(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      final points = await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.DISTANCE_DELTA],
      );

      return points
          .map(
            (p) => UnifiedHealthDataPoint(
              type: FitkarmaHealthDataType.distance,
              timestamp: p.dateFrom,
              value: (p.value as num).toDouble(),
              metadata: {
                'source': p.sourceId,
                'sourceName': p.sourceName,
                'unit': p.unit.toString(),
              },
            ),
          )
          .toList();
    } catch (e) {
      debugPrint('HealthDataService: Error getting distance data: $e');
      return [];
    }
  }

  /// Get today's total distance in km
  Future<double> getTodayDistanceKm() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);

    final distanceData = await getDistanceData(startOfDay, now);

    double totalDistance = 0;
    for (final point in distanceData) {
      // HealthKit returns distance in meters
      totalDistance += point.value / 1000;
    }

    return totalDistance;
  }

  // ==================== FALLBACK METHODS ====================

  /// Get pedometer steps as fallback
  Future<int> _getPedometerSteps() async {
    try {
      final completer = Completer<int>();
      int stepCount = 0;

      final stream = Pedometer.stepCountStream;
      final subscription = stream.listen(
        (StepCount event) {
          stepCount = event.steps;
          if (!completer.isCompleted) {
            completer.complete(stepCount);
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.complete(0);
          }
        },
      );

      final result = await completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () => stepCount,
      );

      await subscription.cancel();
      return result;
    } catch (e) {
      debugPrint('HealthDataService: Error getting pedometer steps: $e');
      return 0;
    }
  }

  // ==================== UTILITY METHODS ====================

  /// Check if health platform is available
  bool get isHealthPlatformAvailable =>
      _currentPlatform == FitkarmaHealthPlatform.healthConnect ||
      _currentPlatform == FitkarmaHealthPlatform.healthKit;

  /// Get permission status for a specific data type
  bool hasPermission(FitkarmaHealthDataType type) {
    return _permissionStates[type] ?? false;
  }

  /// Get all available data types on current platform
  List<FitkarmaHealthDataType> getAvailableDataTypes() {
    if (!isHealthPlatformAvailable) {
      return [FitkarmaHealthDataType.steps]; // Only steps via pedometer
    }

    // Health Connect / Health Kit support all types
    return [
      FitkarmaHealthDataType.steps,
      FitkarmaHealthDataType.sleep,
      FitkarmaHealthDataType.heartRate,
      FitkarmaHealthDataType.spo2,
      FitkarmaHealthDataType.bloodPressure,
      FitkarmaHealthDataType.distance,
    ];
  }

  /// Dispose resources
  void dispose() {
    stopStepCounting();
    _stepStreamController.close();
    _health = null;
  }
}

/// Provider for HealthDataService
final healthDataServiceProvider = HealthDataService();
