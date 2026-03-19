// lib/core/widgets/widget_update_task.dart
// Background task to update home widgets after sync

import 'package:workmanager/workmanager.dart';
import 'package:fitkarma/core/widgets/home_widget_service.dart';

const String widgetUpdateTask = 'widgetUpdateTask';
const String widgetUpdateTaskPeriodic = 'widgetUpdateTaskPeriodic';

/// Initialize WorkManager for background widget updates
Future<void> initializeWidgetTasks() async {
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
}

/// Schedule periodic widget update task
Future<void> scheduleWidgetUpdates() async {
  // Register one-off task that runs immediately after sync
  await Workmanager().registerOneOffTask(widgetUpdateTask, widgetUpdateTask);

  // Register periodic task that runs every 15 minutes
  await Workmanager().registerPeriodicTask(
    widgetUpdateTaskPeriodic,
    widgetUpdateTaskPeriodic,
    frequency: const Duration(minutes: 15),
  );
}

/// Cancel all widget update tasks
Future<void> cancelWidgetUpdates() async {
  await Workmanager().cancelByUniqueName(widgetUpdateTask);
  await Workmanager().cancelByUniqueName(widgetUpdateTaskPeriodic);
}

/// WorkManager callback dispatcher - must be top-level function
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case widgetUpdateTask:
      case widgetUpdateTaskPeriodic:
        // Update widget data from database
        await _updateWidgetData();
        return true;
      default:
        return true;
    }
  });
}

/// Update widget data from local database
Future<void> _updateWidgetData() async {
  try {
    // Initialize HomeWidget service
    await HomeWidgetService.initialize();

    // Get activity data from local storage/database
    // For now, we'll use default values or cached values
    // In production, this would query the Drift database

    // Update the activity rings widget
    await HomeWidgetService.updateActivityRingsWidget(
      steps: 0,
      calories: 0,
      waterGlasses: 0,
      activeMinutes: 0,
      stepGoal: 10000,
      calorieGoal: 2000,
      waterGoal: 8,
      activeMinutesGoal: 30,
    );

    // Update water widget
    await HomeWidgetService.updateWaterWidget(glasses: 0);
  } catch (e) {
    // Log error but don't crash
    print('Widget update error: $e');
  }
}
