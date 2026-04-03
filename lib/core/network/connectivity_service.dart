import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityProvider = StreamProvider<bool>((ref) {
  return ConnectivityService.instance.isOnlineStream;
});

final isOnlineProvider = FutureProvider<bool>((ref) async {
  return ConnectivityService.instance.isOnline();
});

final shouldSyncProvider = FutureProvider<bool>((ref) async {
  final isOnline = await ConnectivityService.instance.isOnline();
  final isWifi = await ConnectivityService.instance.isOnWifi();
  return isOnline && (isWifi || !kDebugMode);
});

class ConnectivityService {
  ConnectivityService._();

  static final ConnectivityService instance = ConnectivityService._();

  final _connectivity = Connectivity();
  final _controller = StreamController<bool>.broadcast();
  final _previousResults = <ConnectivityResult>[];

  Stream<bool> get isOnlineStream => _controller.stream;

  bool get isOnlineNow => _isConnected(_previousResults);

  Future<bool> isOnline() async {
    final result = await _connectivity.checkConnectivity();
    return _isConnected(result);
  }

  Future<bool> isOnWifi() async {
    final result = await _connectivity.checkConnectivity();
    return result.contains(ConnectivityResult.wifi);
  }

  bool _isConnected(List<ConnectivityResult> results) {
    return results.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet);
  }

  void _onConnectivityChanged(List<ConnectivityResult> results) {
    final hasWifi = results.contains(ConnectivityResult.wifi);
    final hasMobile = results.contains(ConnectivityResult.mobile);

    if (!hasWifi && !hasMobile) {
      _controller.add(false);
      return;
    }

    final connected = _isConnected(results);
    _previousResults.clear();
    _previousResults.addAll(results);
    _controller.add(connected);
  }

  Future<void> initialize() async {
    _connectivity.onConnectivityChanged.listen(_onConnectivityChanged);
    final result = await _connectivity.checkConnectivity();
    _previousResults.addAll(result);
    _onConnectivityChanged(result);
  }

  void dispose() {
    _controller.close();
  }
}