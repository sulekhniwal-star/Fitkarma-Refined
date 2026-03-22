import 'dart:async';
import 'package:flutter/services.dart';

/// Service to communicate with watchOS app via WatchConnectivity
///
/// This service uses the platform channel to communicate with the iOS AppDelegate
/// which handles the actual WatchConnectivity (WCSession) communication.
class WatchConnectivityService {
  static const MethodChannel _channel = MethodChannel('com.fitkarma.app/watch');

  static WatchConnectivityService? _instance;
  static WatchConnectivityService get instance =>
      _instance ??= WatchConnectivityService._();

  WatchConnectivityService._();

  // Stream controllers for receiving data from watch
  final _waterLogController = StreamController<int>.broadcast();
  final _heartRateController = StreamController<int>.broadcast();
  final _connectionController = StreamController<bool>.broadcast();

  // Streams
  Stream<int> get onWaterLogged => _waterLogController.stream;
  Stream<int> get onHeartRateReceived => _heartRateController.stream;
  Stream<bool> get onConnectionChanged => _connectionController.stream;

  // MARK: - Real-time Communication (sendMessage)

  /// Send real-time message to watch using WCSession.sendMessage
  /// Requires watch to be reachable
  Future<bool> sendRealTimeData({required Map<String, dynamic> data}) async {
    try {
      final result = await _channel.invokeMethod('sendRealTimeDataToWatch', {
        'data': data,
      });
      return result == true;
    } on PlatformException catch (e) {
      print('Error sending real-time data to watch: ${e.message}');
      return false;
    }
  }

  /// Log water intake on watch - sends real-time message
  Future<bool> logWaterFromWatch(int glasses) async {
    return sendRealTimeData(
      data: {
        'action': 'waterLogged',
        'amount': glasses,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  /// Handle live heart rate received from watch workout
  Future<bool> sendHeartRateAcknowledgment(int heartRate) async {
    return sendRealTimeData(
      data: {
        'action': 'heartRateAcknowledged',
        'heartRate': heartRate,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // MARK: - Background Transfer (transferUserInfo)

  /// Send background data to watch using WCSession.transferUserInfo
  /// Battery-efficient, not real-time but works even when watch is not reachable
  Future<bool> sendBackgroundData({required Map<String, dynamic> data}) async {
    try {
      final result = await _channel.invokeMethod('sendBackgroundDataToWatch', {
        'data': data,
      });
      return result == true;
    } on PlatformException catch (e) {
      print('Error sending background data to watch: ${e.message}');
      return false;
    }
  }

  /// Push step count complication data to watch
  Future<bool> pushStepCountToWatch({
    required int stepCount,
    required int goal,
  }) async {
    return sendBackgroundData(
      data: {
        'stepCount': stepCount,
        'dailyGoal': goal,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  /// Push health stats to watch for background update
  Future<bool> pushHealthStatsToWatch({
    required int steps,
    required int waterIntake,
    required double calories,
    required int activeMinutes,
  }) async {
    return sendBackgroundData(
      data: {
        'stepCount': steps,
        'waterIntake': waterIntake,
        'calories': calories,
        'activeMinutes': activeMinutes,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // MARK: - Data Reception

  /// Handle data received from watch (called from platform channel)
  void handleReceivedData(Map<String, dynamic> data) {
    final action = data['action'] as String?;

    switch (action) {
      case 'logWater':
        final amount = data['amount'] as int? ?? 1;
        _waterLogController.add(amount);
        break;
      case 'liveHeartRate':
        final heartRate = data['heartRate'] as int? ?? 0;
        _heartRateController.add(heartRate);
        break;
    }
  }

  /// Handle connection status change
  void handleConnectionStatus(bool isConnected) {
    _connectionController.add(isConnected);
  }

  // MARK: - Cleanup

  void dispose() {
    _waterLogController.close();
    _heartRateController.close();
    _connectionController.close();
  }
}

/// Extension to add watch connectivity methods to the MethodChannel handler
extension WatchConnectivityChannelHandler on MethodChannel {
  /// Set up method call handler for watch connectivity
  void setupWatchConnectivityHandler() {
    setMethodCallHandler((call) async {
      switch (call.method) {
        case 'onWaterLogged':
          WatchConnectivityService.instance.handleReceivedData(
            Map<String, dynamic>.from(call.arguments as Map),
          );
          break;
        case 'onHeartRateReceived':
          WatchConnectivityService.instance.handleReceivedData(
            Map<String, dynamic>.from(call.arguments as Map),
          );
          break;
        case 'onConnectionChanged':
          WatchConnectivityService.instance.handleConnectionStatus(
            call.arguments as bool,
          );
          break;
      }
      return null;
    });
  }
}
