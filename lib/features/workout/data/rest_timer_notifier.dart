import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

part 'rest_timer_notifier.g.dart';

class RestTimerState {
  final int secondsRemaining;
  final int totalSeconds;
  final bool isActive;

  RestTimerState({
    this.secondsRemaining = 0,
    this.totalSeconds = 0,
    this.isActive = false,
  });

  RestTimerState copyWith({
    int? secondsRemaining,
    int? totalSeconds,
    bool? isActive,
  }) {
    return RestTimerState(
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      isActive: isActive ?? this.isActive,
    );
  }
}

@riverpod
class RestTimerNotifier extends _$RestTimerNotifier {
  Timer? _timer;
  final _notifications = FlutterLocalNotificationsPlugin();

  @override
  RestTimerState build() {
    ref.onDispose(() => _timer?.cancel());
    return RestTimerState();
  }

  Future<void> start(int seconds) async {
    _timer?.cancel();
    state = RestTimerState(
      secondsRemaining: seconds,
      totalSeconds: seconds,
      isActive: true,
    );

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsRemaining <= 1) {
        timer.cancel();
        state = state.copyWith(secondsRemaining: 0, isActive: false);
        _notifyEnd();
      } else {
        state = state.copyWith(secondsRemaining: state.secondsRemaining - 1);
      }
    });

    // Schedule notification for background
    await _scheduleNotification(seconds);
  }

  void stop() {
    _timer?.cancel();
    _notifications.cancel(id: 888); // Unique ID for rest timer
    state = state.copyWith(isActive: false);
  }

  Future<void> _scheduleNotification(int seconds) async {
    const androidDetails = AndroidNotificationDetails(
      'workout_rest_timer',
      'Workout Rest Timer',
      channelDescription: 'Notifications for gym rest intervals',
      importance: Importance.max,
      priority: Priority.high,
    );
    
    const notificationDetails = NotificationDetails(android: androidDetails);

    await _notifications.zonedSchedule(
      id: 888,
      title: 'Rest Over! · विश्राम समाप्त!',
      body: 'Time for your next set. Let\'s go!',
      scheduledDate: tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      notificationDetails: notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  Future<void> _notifyEnd() async {
    // Immediate notification if app is in foreground
    const androidDetails = AndroidNotificationDetails(
      'workout_rest_timer',
      'Workout Rest Timer',
      importance: Importance.max,
      priority: Priority.high,
      sound: RawResourceAndroidNotificationSound('notification_sound'), // Assuming sound asset exists
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await _notifications.show(id: 888, title: 'Rest Over!', body: 'Time to lift!', notificationDetails: notificationDetails);
  }
}
