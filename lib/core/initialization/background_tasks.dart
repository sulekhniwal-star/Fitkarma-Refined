import 'package:workmanager/workmanager.dart';
import '../../features/home_widgets/data/home_widget_service.dart';
import '../storage/drift_service.dart';
import 'package:flutter/foundation.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    try {
      if (taskName == 'updateActivityRings') {
        await DriftService.init();
        final service = HomeWidgetService(db: DriftService.db);
        // In a real background task, we'd need to fetch current userId from storage
        await service.updateActivityRings('current_user'); 
        await service.updateFestivalCountdown();
      }
      return Future.value(true);
    } catch (e) {
      if (kDebugMode) print('Background task error: $e');
      return Future.value(false);
    }
  });
}

class BackgroundTaskInitializer {
  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: kDebugMode);
    
    await Workmanager().registerPeriodicTask(
      'activity_rings_update',
      'updateActivityRings',
      frequency: const Duration(minutes: 15),
      constraints: Constraints(
        networkType: NetworkType.notRequired,
        requiresBatteryNotLow: true,
      ),
    );
  }
}
