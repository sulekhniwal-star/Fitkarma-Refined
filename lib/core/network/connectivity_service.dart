import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();

  bool _isOnline = true;

  ConnectivityService() {
    _connectivity.onConnectivityChanged.listen(_handleConnectivity);
    _checkInitial();
  }

  bool get isOnline => _isOnline;

  /// Stream of online/offline state changes.
  Stream<bool> get isOnlineStream => _controller.stream;

  Future<void> _checkInitial() async {
    final result = await _connectivity.checkConnectivity();
    _handleConnectivity(result);
  }

  void _handleConnectivity(List<ConnectivityResult> results) {
    final wasOnline = _isOnline;
    _isOnline = results.any(
      (r) => r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet,
    );
    if (wasOnline != _isOnline) {
      _controller.add(_isOnline);
    }
  }

  void dispose() {
    _controller.close();
  }
}

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(service.dispose);
  return service;
});

final isOnlineProvider = StreamProvider<bool>((ref) {
  final service = ref.watch(connectivityServiceProvider);
  return service.isOnlineStream;
});
