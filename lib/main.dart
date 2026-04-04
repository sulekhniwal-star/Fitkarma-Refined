import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/storage/drift_service.dart';
import 'core/network/sync_background_worker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    // In dev, sometimes .env might be missing or wrongly named
    debugPrint('Dotenv Error: $e');
  }

  // 2. Initialize Drift database with SQLCipher (Master Key)
  try {
    await DriftService.init();
  } catch (e) {
    debugPrint('Drift Initialization Error: $e');
  }

  // 3. Initialize background sync worker
  try {
    await SyncBackgroundWorker.init();
    await SyncBackgroundWorker.scheduleSync();
  } catch (e) {
    debugPrint('Worker Initialization Error: $e');
  }
  
  runApp(
    ProviderScope(
      overrides: [
        // Provide the initialized DB singleton
        driftDbProvider.overrideWithValue(DriftService.db),
      ],
      child: const FitKarmaApp(),
    ),
  );
}
