import 'dart:async';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/features/steps/data/step_service.dart';

const dailyMidnightTask = 'dailyMidnightSync';
const periodicSyncTask = 'periodicHealthSync';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case dailyMidnightTask:
        await _runMidnightSync();
        break;
      case periodicSyncTask:
        await _runPeriodicSync();
        break;
    }
    return true;
  });
}

Future<void> _runMidnightSync() async {
  // Sync steps from health platform to Drift at midnight
  // Called when device date changes to new day
}

Future<void> _runPeriodicSync() async {
  // Periodic sync every 5 minutes during active hours
}

Future<void> initializeBackgroundSync() async {
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  await Workmanager().registerOneOffTask(
    dailyMidnightTask,
    dailyMidnightTask,
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresCharging: false,
      requiresBatteryNotLow: true,
    ),
    inputData: {'syncType': 'midnight'},
  );

  await Workmanager().registerPeriodicTask(
    periodicSyncTask,
    periodicSyncTask,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.not_required,
      requiresCharging: false,
      requiresBatteryNotLow: false,
    ),
    inputData: {'syncType': 'periodic'},
  );
}

class StepSyncService {
  static final StepSyncService instance = StepSyncService._();
  StepSyncService._();

  Timer? _inactivityTimer;
  DateTime? _lastActivityTime;
  bool _nudgeShown = false;

  void startInactivityMonitor() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer.periodic(
      const Duration(minutes: 1),
      _checkInactivity,
    );
  }

  void stopInactivityMonitor() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  void recordActivity() {
    _lastActivityTime = DateTime.now();
    _nudgeShown = false;
  }

  Future<void> _checkInactivity(Timer timer) async {
    if (_lastActivityTime == null || _nudgeShown) return;

    final now = DateTime.now();
    final inactiveMinutes = now.difference(_lastActivityTime!).inMinutes;

    if (inactiveMinutes > 60 && !_nudgeShown) {
      _nudgeShown = true;
      // Send notification via local notification service
      // await _sendMovementReminder();
    }
  }

  void dispose() {
    stopInactivityMonitor();
  }
}