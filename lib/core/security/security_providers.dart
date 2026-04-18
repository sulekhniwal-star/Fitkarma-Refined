import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'biometric_service.dart';

part 'security_providers.g.dart';

enum SecurityLevel {
  uninitialized,
  unlocked,
  locked,
  compromised, // Rooted/Jailbroken
}

class SecurityState {
  final SecurityLevel level;
  final bool isBiometricEnabled;
  final bool isCompromised;
  final DateTime? lastActive;

  SecurityState({
    required this.level,
    this.isBiometricEnabled = false,
    this.isCompromised = false,
    this.lastActive,
  });

  SecurityState copyWith({
    SecurityLevel? level,
    bool? isBiometricEnabled,
    bool? isCompromised,
    DateTime? lastActive,
  }) {
    return SecurityState(
      level: level ?? this.level,
      isBiometricEnabled: isBiometricEnabled ?? this.isBiometricEnabled,
      isCompromised: isCompromised ?? this.isCompromised,
      lastActive: lastActive ?? this.lastActive,
    );
  }
}

final biometricServiceProvider = Provider((ref) => BiometricService());

@riverpod
class SecurityNotifier extends _$SecurityNotifier {
  static const _biometricKey = 'security_biometric_enabled';
  static const _storage = FlutterSecureStorage();
  static const _gracePeriod = Duration(seconds: 30);

  @override
  Future<SecurityState> build() async {
    final biometricService = ref.watch(biometricServiceProvider);
    
    // 1. Check integrity
    final isCompromised = await biometricService.isDeviceCompromised();
    
    // 2. Load settings
    final enabledStr = await _storage.read(key: _biometricKey);
    final isBiometricEnabled = enabledStr == 'true';

    return SecurityState(
      level: isBiometricEnabled ? SecurityLevel.locked : SecurityLevel.unlocked,
      isBiometricEnabled: isBiometricEnabled,
      isCompromised: isCompromised,
      lastActive: DateTime.now(),
    );
  }

  /// Toggles biometric lock setting.
  Future<void> setBiometricEnabled(bool enabled) async {
    final currentState = state.value;
    if (currentState == null) return;

    await _storage.write(key: _biometricKey, value: enabled.toString());
    state = AsyncData(currentState.copyWith(isBiometricEnabled: enabled));
  }

  /// Called when the app is resumed (from background to foreground).
  void handleAppResumed() {
    final currentState = state.value;
    if (currentState == null || !currentState.isBiometricEnabled) return;

    final lastActive = currentState.lastActive;
    if (lastActive != null) {
      final diff = DateTime.now().difference(lastActive);
      if (diff > _gracePeriod) {
        // Exceeded grace period, lock the app
        state = AsyncData(currentState.copyWith(level: SecurityLevel.locked));
      } else {
        // Within grace period, keep unlocked but update last active
        state = AsyncData(currentState.copyWith(level: SecurityLevel.unlocked, lastActive: DateTime.now()));
      }
    }
  }

  /// Called when the app is paused (sent to background).
  void handleAppPaused() {
    final currentState = state.value;
    if (currentState == null) return;
    
    state = AsyncData(currentState.copyWith(lastActive: DateTime.now()));
  }

  /// Unlocks the app after successful biometric authentication.
  void unlock() {
    final currentState = state.value;
    if (currentState == null) return;
    
    state = AsyncData(currentState.copyWith(
      level: SecurityLevel.unlocked,
      lastActive: DateTime.now(),
    ));
  }

  /// Force locks the app (e.g., manual lock).
  void lock() {
    final currentState = state.value;
    if (currentState == null || !currentState.isBiometricEnabled) return;
    
    state = AsyncData(currentState.copyWith(level: SecurityLevel.locked));
  }
}

