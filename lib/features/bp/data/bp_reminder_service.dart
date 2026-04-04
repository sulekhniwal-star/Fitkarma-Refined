import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class BPReminderService {
  BPReminderService._();

  static final BPReminderService instance = BPReminderService._();

  final FlutterLocalNotificationsPlugin _notifications = FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    
    tz_data.initializeTimeZones();
    
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  Future<bool> requestPermission() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return true;
  }

  Future<void> scheduleMorningReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'bp_morning_reminder',
      'Morning BP Check',
      channelDescription: 'Morning blood pressure check reminder',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final scheduledTime = _nextInstanceOf(7, 0);
    
    await _notifications.zonedSchedule(
      1,
      '☀️ Morning BP Check',
      'Start your day with a blood pressure reading',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> scheduleEveningReminder() async {
    const androidDetails = AndroidNotificationDetails(
      'bp_evening_reminder',
      'Evening BP Check',
      channelDescription: 'Evening blood pressure check reminder',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final scheduledTime = _nextInstanceOf(20, 0);
    
    await _notifications.zonedSchedule(
      2,
      '🌙 Evening BP Check',
      'Log your evening blood pressure reading',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelReminders() async {
    await _notifications.cancel(1);
    await _notifications.cancel(2);
  }

  Future<void> scheduleAppointmentReminder(int appointmentId, DateTime appointmentDate, String doctorName) async {
    final reminderTime = appointmentDate.subtract(const Duration(hours: 24));
    
    if (reminderTime.isBefore(DateTime.now())) {
      return;
    }

    const androidDetails = AndroidNotificationDetails(
      'appointment_reminder',
      'Appointment Reminder',
      channelDescription: '24-hour appointment reminder',
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final scheduledTime = tz.TZDateTime(
      tz.local,
      reminderTime.year,
      reminderTime.month,
      reminderTime.day,
      reminderTime.hour,
      reminderTime.minute,
    );

    await _notifications.zonedSchedule(
      100 + appointmentId,
      '🏥 Appointment Tomorrow',
      'You have an appointment with $doctorName tomorrow',
      scheduledTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelAppointmentReminder(int appointmentId) async {
    await _notifications.cancel(100 + appointmentId);
  }

  tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}