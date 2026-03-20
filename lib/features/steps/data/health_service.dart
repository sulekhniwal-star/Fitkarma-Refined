// lib/features/steps/data/health_service.dart
// Health platform service for Health Connect (Android) and HealthKit (iOS)

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:pedometer/pedometer.dart';

enum HealthPlatform { healthConnect, healthKit, pedometer, none }

class HealthService {
  static final HealthService _instance = HealthService._internal();
  factory HealthService() => _instance;
  HealthService._internal();

  Health? _health;
  bool _isAuthorized = false;
  HealthPlatform _currentPlatform = HealthPlatform.none;
  StreamSubscription<dynamic>? _pedometerSubscription;

  bool get isAuthorized => _isAuthorized;
  HealthPlatform get currentPlatform => _currentPlatform;

  /// Initialize health platform based on OS
  Future<void> initialize() async {
    if (Platform.isAndroid) {
      _health = Health();
      _currentPlatform = HealthPlatform.healthConnect;
    } else if (Platform.isIOS) {
      _health = Health();
      _currentPlatform = HealthPlatform.healthKit;
    } else {
      _currentPlatform = HealthPlatform.none;
    }
  }

  /// Request permissions for step count
  Future<bool> requestPermissions() async {
    try {
      if (_health == null) {
        await initialize();
      }

      // Define the types we want to read
      final types = [HealthDataType.STEPS, HealthDataType.DISTANCE_DELTA];

      // Request permissions
      _isAuthorized = await _health!.requestAuthorization(types);

      if (!_isAuthorized) {
        // Fall back to pedometer if health platform permissions denied
        debugPrint(
          'Health platform permissions denied, falling back to pedometer',
        );
        _currentPlatform = HealthPlatform.pedometer;
      }

      return _isAuthorized;
    } catch (e) {
      debugPrint('Error requesting health permissions: $e');
      _currentPlatform = HealthPlatform.pedometer;
      return false;
    }
  }

  /// Check if we should use pedometer fallback
  bool get shouldUsePedometerFallback =>
      !_isAuthorized || _currentPlatform == HealthPlatform.pedometer;

  /// Get today's step count from health platform
  Future<int> getTodaySteps() async {
    try {
      if (shouldUsePedometerFallback) {
        return await _getPedometerSteps();
      }

      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);

      // Fetch steps from health platform
      final steps = await _health!.getTotalStepsInInterval(startOfDay, now);

      return steps ?? 0;
    } catch (e) {
      debugPrint('Error getting today steps from health: $e');
      return await _getPedometerSteps();
    }
  }

  /// Get steps for a specific date
  Future<int> getStepsForDate(DateTime date) async {
    try {
      if (shouldUsePedometerFallback) {
        // Pedometer doesn't support historical data easily
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
      debugPrint('Error getting steps for date: $e');
      return 0;
    }
  }

  /// Get steps for a date range
  Future<List<HealthDataPoint>> getStepsInRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      if (shouldUsePedometerFallback) {
        return [];
      }

      return await _health!.getHealthDataFromTypes(
        startTime: startDate,
        endTime: endDate,
        types: [HealthDataType.STEPS],
      );
    } catch (e) {
      debugPrint('Error getting steps in range: $e');
      return [];
    }
  }

  /// Get pedometer steps as fallback
  Future<int> _getPedometerSteps() async {
    try {
      final completer = Completer<int>();
      int stepCount = 0;

      final stream = Pedometer.stepCountStream;
      final subscription = stream.listen(
        (dynamic event) {
          if (event is StepCount) {
            stepCount = event.steps;
            if (!completer.isCompleted) {
              completer.complete(stepCount);
            }
          }
        },
        onError: (error) {
          if (!completer.isCompleted) {
            completer.complete(0);
          }
        },
      );

      // Wait for first reading with timeout
      final result = await completer.future.timeout(
        const Duration(seconds: 5),
        onTimeout: () => stepCount,
      );

      await subscription.cancel();
      return result;
    } catch (e) {
      debugPrint('Error getting pedometer steps: $e');
      return 0;
    }
  }

  /// Stream step count from pedometer (real-time)
  Stream<int>? getPedometerStream() {
    try {
      return Pedometer.stepCountStream.map((dynamic event) {
        if (event is StepCount) {
          return event.steps;
        }
        return 0;
      });
    } catch (e) {
      debugPrint('Error creating pedometer stream: $e');
      return null;
    }
  }

  /// Calculate distance from steps (approximate)
  double calculateDistanceKm(int steps) {
    // Average stride length ~0.762m (adult)
    return (steps * 0.762) / 1000;
  }

  /// Dispose resources
  void dispose() {
    _pedometerSubscription?.cancel();
  }
}
