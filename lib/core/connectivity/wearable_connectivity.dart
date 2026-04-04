import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WearableConnectivityService {
  static const _channel = MethodChannel('com.fitkarma.wear');
  
  WearableConnectivityService(Ref ref) {
    _channel.setMethodCallHandler(_handleMethod);
  }

  Future<void> _handleMethod(MethodCall call) async {
    switch (call.method) {
      case 'addDailyWater':
        final amount = call.arguments['amount'] as int;
        await _addWaterToDrift(amount);
        break;
      default:
        break;
    }
  }

  Future<void> pushStats({required int steps, required int calories}) async {
    try {
      await _channel.invokeMethod('pushStatsToWatch', {
        'steps': steps,
        'calories': calories,
      });
    } on PlatformException catch (e) {
      print("Failed to push stats to watch: ${e.message}");
    }
  }

  Future<void> _addWaterToDrift(int amount) async {
    // In a real app, this would use ref.read(driftDatabaseProvider)
    // to update the daily water log or corresponding table.
    print("Writing $amount glass(es) of water to Drift from Wear OS update");
  }
}

final wearableConnectivityProvider = Provider<WearableConnectivityService>((ref) {
  return WearableConnectivityService(ref);
});
