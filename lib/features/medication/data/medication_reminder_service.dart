import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:fitkarma/core/storage/app_database.dart';

class MedicationReminderService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    tz.initializeTimeZones();
    
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

  static Future<bool> requestPermissions() async {
    final android = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      await android.requestNotificationsPermission();
    }
    return true;
  }

  static Future<void> scheduleMedicationReminder({
    required int id,
    required String medicationName,
    required String dosage,
    required String reminderTime,
  }) async {
    await cancelReminder(id);
    
    final parts = reminderTime.split(':');
    if (parts.length != 2) return;
    
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;
    
    var scheduledDate = tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      hour,
      minute,
    );
    
    if (scheduledDate.isBefore(tz.TZDateTime.now(tz.local))) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    
    await _notifications.zonedSchedule(
      id,
      'Time to take $medicationName',
      'Take $dosage of $medicationName',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'medication_reminders',
          'Medication Reminders',
          channelDescription: 'Reminders to take your medications',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future<void> scheduleRefillReminder({
    required int id,
    required String medicationName,
    required int daysUntilRefill,
  }) async {
    await cancelReminder(1000 + id);
    
    if (daysUntilRefill <= 0) return;
    
    var scheduledDate = tz.TZDateTime(
      tz.local,
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      9,
      0,
    ).add(Duration(days: daysUntilRefill));
    
    await _notifications.zonedSchedule(
      1000 + id,
      'Refill needed: $medicationName',
      'Only $daysUntilRefill days of $medicationName remaining. Time to refill!',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'refill_reminders',
          'Refill Reminders',
          channelDescription: 'Alerts when medications are running low',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelReminder(int id) async {
    await _notifications.cancel(id);
  }

  static Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }

  static Future<void> scheduleAllReminders(String userId, AppDatabase db) async {
    final reminders = await db.medicationsDao.getPendingReminders(userId);
    
    for (final reminder in reminders) {
      await scheduleMedicationReminder(
        id: reminder.id,
        medicationName: reminder.name,
        dosage: reminder.dosage ?? 'your medication',
        reminderTime: reminder.reminderTime,
      );
    }
    
    final refillAlerts = await db.medicationsDao.getMedicationsNeedingRefill(userId);
    for (final alert in refillAlerts) {
      await scheduleRefillReminder(
        id: alert.medication.id,
        medicationName: alert.medication.name,
        daysUntilRefill: alert.daysUntilRefill,
      );
    }
  }
}