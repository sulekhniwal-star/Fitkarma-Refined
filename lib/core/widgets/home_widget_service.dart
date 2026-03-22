// lib/core/widgets/home_widget_service.dart
// Home Widget service for Android/iOS widgets

import 'package:home_widget/home_widget.dart';

class HomeWidgetService {
  static const String appGroupId = 'com.fitkarma.fitkarma';
  static const String androidWidgetName = 'HomeWidgetProvider';

  /// Initialize home widget service
  static Future<void> initialize() async {
    // Set the app group ID for iOS
    await HomeWidget.setAppGroupId(appGroupId);
  }

  /// Update the activity rings widget with today's data
  static Future<void> updateActivityRingsWidget({
    required int steps,
    required int calories,
    required int waterGlasses,
    required int activeMinutes,
    required int stepGoal,
    required int calorieGoal,
    required int waterGoal,
    required int activeMinutesGoal,
  }) async {
    // Calculate progress percentages
    final stepsProgress = (steps / stepGoal * 100).clamp(0, 100).round();
    final caloriesProgress = (calories / calorieGoal * 100)
        .clamp(0, 100)
        .round();
    final waterProgress = (waterGlasses / waterGoal * 100)
        .clamp(0, 100)
        .round();
    final activeProgress = (activeMinutes / activeMinutesGoal * 100)
        .clamp(0, 100)
        .round();

    // Save data to home widget storage
    await HomeWidget.saveWidgetData<int>('steps', steps);
    await HomeWidget.saveWidgetData<int>('steps_progress', stepsProgress);
    await HomeWidget.saveWidgetData<int>('calories', calories);
    await HomeWidget.saveWidgetData<int>('calories_progress', caloriesProgress);
    await HomeWidget.saveWidgetData<int>('water', waterGlasses);
    await HomeWidget.saveWidgetData<int>('water_progress', waterProgress);
    await HomeWidget.saveWidgetData<int>('active', activeMinutes);
    await HomeWidget.saveWidgetData<int>('active_progress', activeProgress);

    // Update the widget
    await HomeWidget.updateWidget(
      name: androidWidgetName,
      androidName: androidWidgetName,
      iOSName: 'ActivityRingsWidget',
    );
  }

  /// Update the water intake for lock screen widget (Android 13+)
  static Future<void> updateWaterWidget({required int glasses}) async {
    await HomeWidget.saveWidgetData<int>('water_glasses', glasses);

    // Update the widget
    await HomeWidget.updateWidget(
      name: 'WaterWidgetProvider',
      androidName: 'WaterWidgetProvider',
      iOSName: 'WaterWidget',
    );
  }

  /// Increment water count (called when user taps lock screen widget)
  static Future<void> incrementWater() async {
    final currentGlasses =
        await HomeWidget.getWidgetData<int>('water_glasses', defaultValue: 0) ??
        0;
    await updateWaterWidget(glasses: currentGlasses + 1);
  }

  /// Get widget data
  static Future<Map<String, dynamic>> getWidgetData() async {
    final steps = await HomeWidget.getWidgetData<int>('steps', defaultValue: 0);
    final calories = await HomeWidget.getWidgetData<int>(
      'calories',
      defaultValue: 0,
    );
    final water = await HomeWidget.getWidgetData<int>('water', defaultValue: 0);
    final active = await HomeWidget.getWidgetData<int>(
      'active',
      defaultValue: 0,
    );

    return {
      'steps': steps,
      'calories': calories,
      'water': water,
      'active': active,
    };
  }

  /// Register callback for widget clicks
  static Future<void> registerBackgroundCallback(
    Function(Uri?) callback,
  ) async {
    await HomeWidget.registerInteractivityCallback(callback);
  }
}

/// Background callback handler for widget interactions
Future<void> widgetBackgroundCallback(Uri? uri) async {
  if (uri == null) return;

  final host = uri.host;

  switch (host) {
    case 'log_water':
      // Increment water count
      await HomeWidgetService.incrementWater();
      break;
    case 'log_food':
      // Navigate to food log - handled by the app
      break;
  }
}
