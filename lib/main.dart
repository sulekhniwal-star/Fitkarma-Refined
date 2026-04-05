import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'app.dart';
import 'core/storage/drift_service.dart';
import 'core/network/sync_background_worker.dart';
import 'features/food/data/food_seed_data.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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
    // Seed initial Indian food database
    await FoodSeedData.seed(DriftService.db);
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

  // 4. Initialize notifications & timezone
  try {
    final notifications = FlutterLocalNotificationsPlugin();
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);
    await notifications.initialize(settings: initSettings);
    tz.initializeTimeZones();
  } catch (e) {
    debugPrint('Notification Initialization Error: $e');
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
