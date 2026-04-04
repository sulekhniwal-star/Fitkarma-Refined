import 'package:workmanager/workmanager.dart';

import 'background_sync_runner.dart';
import 'sync_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    // 1. Initialize standalone runner
    final runner = BackgroundSyncRunner();
    await runner.init();

    try {
      // 2. Process Sync Queue
      await SyncService.processManual(runner.db, runner.databases);
    } finally {
      // 3. Cleanup
      await runner.dispose();
    }
    
    return Future.value(true);
  });
}

class SyncBackgroundWorker {
  static Future<void> init() async {
    await Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false,
    );
  }

  static Future<void> scheduleSync() async {
    await Workmanager().registerPeriodicTask(
      "com.fitkarma.sync_task",
      "periodicSync",
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.connected,
        requiresBatteryNotLow: true,
      ),
    );
  }
}
