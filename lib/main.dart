import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'app.dart';
import 'core/storage/drift_service.dart';
import 'core/network/sync_background_worker.dart';
import 'features/food/data/food_seed_data.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Root detection
  try {
    final bool jailbroken = await FlutterJailbreakDetection.jailbroken;
    final bool devMode = await FlutterJailbreakDetection.developerMode;
    if (jailbroken || devMode) {
      debugPrint('SECURITY WARNING: Device is jailbroken/rooted or in Developer Mode.');
    }
  } catch (_) {}
  
  // 1. Load environment variables
  try {
    await dotenv.load(fileName: '.env');
  } catch (e) {
    debugPrint('Dotenv Error: $e');
  }

  // 2. Initialize Drift database with SQLCipher (Master Key)
  try {
    await DriftService.init();
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
    await NotificationService.init();
    tz.initializeTimeZones();
  } catch (e) {
    debugPrint('Notification Initialization Error: $e');
  }
  
  runApp(
    ProviderScope(
      overrides: [
        driftDbProvider.overrideWithValue(DriftService.db),
      ],
      child: const FitKarmaApp(),
    ),
  );
}
