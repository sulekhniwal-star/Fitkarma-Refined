import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider that exposes the current connectivity status.
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((results) {
    // In connectivity_plus >= 5.0.0, onConnectivityChanged returns a List<ConnectivityResult>.
    // We return the first one or .none if empty.
    if (results.isEmpty) return ConnectivityResult.none;
    return results.first;
  });
});

/// Extension to easily check if the device is online.
extension ConnectivityResultX on ConnectivityResult {
  bool get isOnline => this != ConnectivityResult.none;
}

/// Provider that exposes whether the device is currently online.
final isOnlineProvider = Provider<bool>((ref) {
  final result = ref.watch(connectivityProvider).value ?? ConnectivityResult.none;
  return result.isOnline;
});

