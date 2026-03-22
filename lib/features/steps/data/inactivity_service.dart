// lib/features/steps/data/inactivity_service.dart
// Service to detect phone inactivity and send reminders

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class InactivityService {
  static final InactivityService _instance = InactivityService._internal();
  factory InactivityService() => _instance;
  InactivityService._internal();

  Timer? _inactivityTimer;
  Timer? _checkTimer;
  DateTime? _lastActivityTime;

  static const Duration inactivityThreshold = Duration(minutes: 60);
  static const Duration checkInterval = Duration(minutes: 5);

  bool _isMonitoring = false;
  Function()? onInactivityDetected;

  bool get isMonitoring => _isMonitoring;

  /// Start monitoring for inactivity
  void startMonitoring({Function()? onInactivityDetected}) {
    if (_isMonitoring) return;

    this.onInactivityDetected = onInactivityDetected;
    _lastActivityTime = DateTime.now();
    _isMonitoring = true;

    // Set up a timer to check for inactivity periodically
    _checkTimer = Timer.periodic(checkInterval, (_) {
      _checkInactivity();
    });

    // Listen to system channels for user activity
    _setupActivityListener();

    debugPrint('Inactivity monitoring started');
  }

  /// Stop monitoring for inactivity
  void stopMonitoring() {
    _checkTimer?.cancel();
    _inactivityTimer?.cancel();
    _isMonitoring = false;
    _lastActivityTime = null;
    debugPrint('Inactivity monitoring stopped');
  }

  /// Record user activity
  void recordActivity() {
    _lastActivityTime = DateTime.now();
    debugPrint('Activity recorded at $_lastActivityTime');
  }

  /// Check for inactivity
  void _checkInactivity() {
    if (_lastActivityTime == null) return;

    final now = DateTime.now();
    final inactiveDuration = now.difference(_lastActivityTime!);

    if (inactiveDuration >= inactivityThreshold) {
      debugPrint('Inactivity detected! ${inactiveDuration.inMinutes} minutes');
      _onInactivityDetected();
    }
  }

  /// Handle inactivity detected
  void _onInactivityDetected() {
    // Cancel any existing timer
    _inactivityTimer?.cancel();

    // Trigger the callback
    onInactivityDetected?.call();

    // Reset the last activity time to avoid repeated triggers
    _lastActivityTime = DateTime.now();
  }

  /// Set up activity listener using Flutter's system channel
  void _setupActivityListener() {
    // Listen for lifecycle changes
    // This is a simplified implementation
    // In production, you'd use a more sophisticated method
  }

  /// Get the duration of current inactivity
  Duration? get inactivityDuration {
    if (_lastActivityTime == null) return null;
    return DateTime.now().difference(_lastActivityTime!);
  }

  /// Get whether user is currently inactive
  bool get isInactive {
    if (_lastActivityTime == null) return false;
    return DateTime.now().difference(_lastActivityTime!) >= inactivityThreshold;
  }

  /// Dispose resources
  void dispose() {
    stopMonitoring();
  }
}

/// Mixin for widgets that want to track activity
mixin InactivityMixin<T extends StatefulWidget>
    on State<T>, WidgetsBindingObserver {
  final InactivityService _inactivityService = InactivityService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityService.stopMonitoring();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // User came back to the app
        _inactivityService.recordActivity();
        break;
      case AppLifecycleState.paused:
        // User left the app - could start inactivity timer here
        break;
      default:
        break;
    }
  }

  /// Start monitoring for inactivity
  void startInactivityMonitoring({Function()? onInactivityDetected}) {
    _inactivityService.startMonitoring(
      onInactivityDetected: onInactivityDetected,
    );
  }

  /// Record activity (call this on user interactions)
  void recordUserActivity() {
    _inactivityService.recordActivity();
  }
}
