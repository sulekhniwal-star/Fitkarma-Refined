import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter/material.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();
    
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await _notificationsPlugin.initialize(settings: initializationSettings);
  }

  /// Schedules a medication reminder
  static Future<void> scheduleMedicationReminder({
    required int id,
    required String title,
    required String body,
    required TimeOfDay time,
  }) async {
    await _notificationsPlugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: _nextInstanceOfTime(time),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_reminders',
          'Medication Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Daily BP Reminder
  static Future<void> scheduleBPReminder(TimeOfDay time) async {
    await _notificationsPlugin.zonedSchedule(
      id: 1001,
      title: 'Blood Pressure Check',
      body: 'Time to log your morning BP reading for better accuracy.',
      scheduledDate: _nextInstanceOfTime(time),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'health_checks',
          'Health Checks',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Daily Morning Briefing
  static Future<void> scheduleMorningBriefing(TimeOfDay time, int calorieGoal) async {
    await _notificationsPlugin.zonedSchedule(
      id: 1002,
      title: 'Morning Briefing',
      body: 'Good morning! Your calorie goal for today is $calorieGoal kcal. Let\'s stay active!',
      scheduledDate: _nextInstanceOfTime(time),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_briefing',
          'Daily Briefing',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Habit Reminder
  static Future<void> scheduleHabitReminder(int id, String name, TimeOfDay time) async {
    await _notificationsPlugin.zonedSchedule(
      id: id + 2000,
      title: 'Habit Reminder',
      body: 'Don\'t forget your habit: $name',
      scheduledDate: _nextInstanceOfTime(time),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails('habit_reminders', 'Habit Reminders'),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// One-off inactivity nudge
  static Future<void> showInactivityNudge() async {
    await _notificationsPlugin.show(
      id: 3001,
      title: 'Time to Move!',
      body: 'You\'ve been inactive for over an hour. How about a 5-minute stretch?',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails('activity_nudges', 'Activity Nudges'),
      ),
    );
  }

  /// Cancel all scheduled notifications
  static Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  static tz.TZDateTime _nextInstanceOfTime(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, time.hour, time.minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
