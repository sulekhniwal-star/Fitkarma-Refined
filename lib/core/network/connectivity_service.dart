import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Connectivity service that wraps connectivity_plus and exposes an isOnline stream.
///
/// This service monitors network connectivity and provides:
/// - A stream of connectivity changes
/// - A boolean stream for online/offline status
/// - Current connectivity state
class ConnectivityService {
  static final ConnectivityService instance = ConnectivityService._();
  ConnectivityService._();

  final Connectivity _connectivity = Connectivity();

  /// Stream controller for connectivity changes
  final StreamController<bool> _onlineController =
      StreamController<bool>.broadcast();

  /// Current online status
  bool _isOnline = true;

  /// Subscription to connectivity changes
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  /// Stream of boolean online status (true = online, false = offline)
  Stream<bool> get isOnlineStream => _onlineController.stream;

  /// Current online status
  bool get isOnline => _isOnline;

  /// Initialize the connectivity service and start listening
  Future<void> init() async {
    // Check initial connectivity
    final result = await _connectivity.checkConnectivity();
    _updateOnlineStatus(result);

    // Listen for changes
    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateOnlineStatus,
    );
  }

  /// Update online status based on connectivity result
  void _updateOnlineStatus(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;

    // Consider online if any connectivity is available (wifi, mobile, ethernet)
    _isOnline =
        results.isNotEmpty && !results.contains(ConnectivityResult.none);

    // Emit change only if status changed
    if (wasOnline != _isOnline) {
      _onlineController.add(_isOnline);
    }
  }

  /// Check current connectivity manually
  Future<bool> checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateOnlineStatus(result);
    return _isOnline;
  }

  /// Dispose of resources
  void dispose() {
    _subscription?.cancel();
    _onlineController.close();
  }
}

/// Provider for the connectivity service
final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService.instance;
});

/// Provider for online status stream
final isOnlineStreamProvider = StreamProvider<bool>((ref) {
  return ConnectivityService.instance.isOnlineStream;
});

/// Provider for current online status
///
/// Note: For watching connectivity changes, use [isOnlineStreamProvider] instead.
/// This provider returns the initial value at the time of reading.
final isOnlineProvider = Provider<bool>((ref) {
  return ConnectivityService.instance.isOnline;
});
