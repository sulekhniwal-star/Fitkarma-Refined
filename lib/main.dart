import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/providers.dart';
import 'core/network/appwrite_client.dart';
import 'core/storage/drift_service.dart';

import 'core/initialization/background_tasks.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BackgroundTaskInitializer.init();

  // Load environment variables based on flavor
  // Build with --dart-define=FLAVOR=staging/prod
  const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
  await dotenv.load(fileName: '.env.$flavor');

  // Initialize Core Services
  await DriftService.init();
  await AppwriteClient.initialize();

  runApp(
    ProviderScope(
      overrides: [
        driftDbProvider.overrideWithValue(DriftService.db),
      ],
      child: const FitKarmaApp(),
    ),
  );
}
