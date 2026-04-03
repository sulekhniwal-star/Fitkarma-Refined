import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/app.dart';
import 'package:fitkarma/core/network/connectivity_service.dart';
import 'package:fitkarma/core/network/background_sync_runner.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    ProviderScope(
      child: const FitKarmaApp(),
      overrides: [],
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