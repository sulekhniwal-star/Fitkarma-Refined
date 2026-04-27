import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import '../../features/settings/providers/settings_provider.dart';

class BiometricGuard extends ConsumerStatefulWidget {
  final Widget child;
  const BiometricGuard({super.key, required this.child});

  @override
  ConsumerState<BiometricGuard> createState() => _BiometricGuardState();
}

class _BiometricGuardState extends ConsumerState<BiometricGuard> {
  bool _isAuthorized = false;
  final LocalAuthentication _auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final settings = ref.read(biometricLockNotifierProvider);
    if (!settings) {
      setState(() => _isAuthorized = true);
      return;
    }

    try {
      final bool didAuthenticate = await _auth.authenticate(
        localizedReason: 'Please authenticate to access sensitive health data',
        biometricOnly: true,
      );
      if (mounted) {
        setState(() => _isAuthorized = didAuthenticate);
      }
    } catch (e) {
      // Fallback or error handling
      if (mounted) {
        setState(() => _isAuthorized = true); // Fallback for dev or missing hardware
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isAuthorized) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 24),
              const Text('Biometric Authentication Required'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _checkBiometrics,
                child: const Text('RETRY'),
              ),
            ],
          ),
        ),
      );
    }

    return widget.child;
  }
}
