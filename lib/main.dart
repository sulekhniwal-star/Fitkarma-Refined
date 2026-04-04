import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/app.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';
import 'package:fitkarma/core/network/background_sync_runner.dart';
import 'package:fitkarma/core/security/biometric_service.dart';
import 'package:fitkarma/core/connectivity/wearable_connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await BiometricService.instance.initialize();
  final isFirstLaunch = await BiometricService.instance.isFirstLaunch();
  
  final container = ProviderContainer();
  // Initialize Wearable Connectivity
  container.read(wearableConnectivityProvider);
  
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: BiometricLockScreen(
        isFirstLaunch: isFirstLaunch,
        child: const FitKarmaApp(),
      ),
    ),
  );

  _initializeBackgroundSync();
}

Future<void> _initializeBackgroundSync() async {
  await ConnectivityService.instance.initialize();
}

@pragma('vm:entry-point')
void mainBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  BackgroundSyncRunner.start();
}

class BiometricLockScreen extends StatefulWidget {
  final bool isFirstLaunch;
  final Widget child;

  const BiometricLockScreen({
    super.key,
    required this.isFirstLaunch,
    required this.child,
  });

  @override
  State<BiometricLockScreen> createState() => _BiometricLockScreenState();
}

class _BiometricLockScreenState extends State<BiometricLockScreen> with WidgetsBindingObserver {
  bool _isLocked = false;

  @override
  void initState() {
    super.initState();
    _initBiometric();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initBiometric() async {
    if (!widget.isFirstLaunch) {
      final enabled = await BiometricService.instance.isBiometricEnabled();
      if (enabled) {
        _isLocked = true;
      }
    } else {
      await BiometricService.instance.markFirstLaunchComplete();
    }
  }

  Future<void> _checkBiometric() async {
    if (_isLocked || widget.isFirstLaunch) return;
    
    final enabled = await BiometricService.instance.isBiometricEnabled();
    if (!enabled) return;

    final authenticated = await BiometricService.instance.authenticate(
      reason: 'Authenticate to unlock FitKarma',
    );
    
    if (!authenticated && mounted) {
      _checkBiometric();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _isLocked = true;
    } else if (state == AppLifecycleState.resumed) {
      _checkBiometric();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}