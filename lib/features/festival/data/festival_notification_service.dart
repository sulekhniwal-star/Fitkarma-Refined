// lib/features/festival/data/festival_notification_service.dart
// Festival Notification Service for scheduling push notifications

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:fitkarma/features/festival/data/festival_data.dart';

class FestivalNotificationService {
  static final FestivalNotificationService _instance =
      FestivalNotificationService._internal();
  factory FestivalNotificationService() => _instance;
  FestivalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  /// Initialize the notification service
  Future<void> init() async {
    if (_isInitialized) return;

    // Initialize timezone
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationResponse,
    );
    _isInitialized = true;
  }

  void _onNotificationResponse(NotificationResponse response) {
    // Handle notification tap
    debugPrint('Notification tapped: ${response.payload}');
  }

  /// Request notification permissions
  Future<bool> requestPermissions() async {
    final androidPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    final iosPlugin = _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();

    if (iosPlugin != null) {
      final granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  /// Schedule festival reminder notifications
  /// Schedules notifications 3 days before each festival
  Future<void> scheduleFestivalReminders() async {
    final festivalDb = FestivalDatabase();
    final upcomingFestivals = festivalDb.getUpcomingFestivals(limit: 10);

    // Cancel existing festival notifications first
    await cancelAllFestivalNotifications();

    int notificationId = 1000; // Starting ID for festival notifications

    for (final festival in upcomingFestivals) {
      // Schedule notification 3 days before
      final reminderDate = festival.startDate.subtract(
        Duration(days: festival.notificationDaysBefore),
      );

      // Only schedule if the reminder date is in the future
      if (reminderDate.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      )) {
        await _scheduleFestivalNotification(
          id: notificationId++,
          festival: festival,
          daysBefore: festival.notificationDaysBefore,
          scheduledDate: reminderDate,
        );
      }

      // Schedule notification on the day of the festival
      if (festival.startDate.isAfter(
        DateTime.now().subtract(const Duration(days: 1)),
      )) {
        await _scheduleFestivalNotification(
          id: notificationId++,
          festival: festival,
          daysBefore: 0,
          scheduledDate: festival.startDate,
        );
      }
    }
  }

  Future<void> _scheduleFestivalNotification({
    required int id,
    required Festival festival,
    required int daysBefore,
    required DateTime scheduledDate,
  }) async {
    String title;
    String body;

    if (daysBefore > 0) {
      title = '${festival.type.displayName} in $daysBefore days!';
      body = _getReminderBody(festival.type);
    } else {
      title = 'Happy ${festival.type.displayName}!';
      body = _getDayOfBody(festival.type);
    }

    // Set time to 9 AM for the reminder
    final scheduledTime = DateTime(
      scheduledDate.year,
      scheduledDate.month,
      scheduledDate.day,
      9,
      0,
    );

    // Only schedule if in the future
    if (scheduledTime.isAfter(DateTime.now())) {
      final tzScheduledTime = tz.TZDateTime.from(scheduledTime, tz.local);

      await _notifications.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: tzScheduledTime,
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'festival_reminders',
            'Festival Reminders',
            channelDescription: 'Reminders for Indian festivals',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            color: festival.type.color,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
      );
    }
  }

  String _getReminderBody(FestivalType type) {
    switch (type) {
      case FestivalType.navratri:
        return 'Prepare for 9 days of fasting. Check our Navratri guide for meal plans!';
      case FestivalType.ramadan:
        return 'Ramadan is approaching. Set up your Sehri and Iftar reminders!';
      case FestivalType.diwali:
        return 'Diwali is coming! Track your sweets and try our healthy alternatives.';
      case FestivalType.karwaChauth:
        return 'Karwa Chauth fast is approaching. Get tips for a healthy fast!';
      case FestivalType.holi:
        return 'Holi is around the corner! Stay healthy with our tips.';
    }
  }

  String _getDayOfBody(FestivalType type) {
    switch (type) {
      case FestivalType.navratri:
        return 'Start your Navratri journey with our day 1 fasting guide!';
      case FestivalType.ramadan:
        return 'Ramadan Mubarak! Track your fasting with our Sehri/Iftar planner.';
      case FestivalType.diwali:
        return 'Happy Diwali! Enjoy sweets in moderation with our calorie tracker.';
      case FestivalType.karwaChauth:
        return 'Karwa Chauth Mubarak! Stay hydrated during your fast.';
      case FestivalType.holi:
        return 'Happy Holi! Play with colors and stay healthy!';
    }
  }

  /// Cancel a specific festival notification
  Future<void> cancelFestivalNotification(int id) async {
    await _notifications.cancel(id: id);
  }

  /// Cancel all festival notifications
  Future<void> cancelAllFestivalNotifications() async {
    // Cancel all notifications with IDs starting from 1000
    for (int i = 1000; i < 2000; i++) {
      await _notifications.cancel(id: i);
    }
  }

  /// Show immediate festival notification (for testing)
  Future<void> showImmediateNotification({
    required String title,
    required String body,
    FestivalType? type,
  }) async {
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'festival_immediate',
        'Festival Updates',
        channelDescription: 'Immediate festival notifications',
        importance: Importance.high,
        priority: Priority.high,
        icon: '@mipmap/ic_launcher',
        color: type?.color ?? const Color(0xFFE91E63),
      ),
      iOS: const DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _notifications.show(
      id: 999, // Special ID for immediate notifications
      title: title,
      body: body,
      notificationDetails: details,
    );
  }
}
