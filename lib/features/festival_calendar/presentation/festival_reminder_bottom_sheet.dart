import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../../core/storage/app_database.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import 'package:timezone/timezone.dart' as tz;

class FestivalReminderBottomSheet extends StatefulWidget {
  final FestivalCalendarEntry festival;

  const FestivalReminderBottomSheet({super.key, required this.festival});

  @override
  State<FestivalReminderBottomSheet> createState() => _FestivalReminderBottomSheetState();
}

class _FestivalReminderBottomSheetState extends State<FestivalReminderBottomSheet> {
  int _daysBefore = 1;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 9, minute: 0);
  bool _isScheduling = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(Icons.notifications_active, color: AppColors.primary),
              const SizedBox(width: 12),
              Expanded(
                child: BilingualText(
                  english: 'Set Reminder: ${widget.festival.nameEn}',
                  hindi: 'अनुस्मारक सेट करें: ${widget.festival.nameHi}',
                  englishStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text('Remind me:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [1, 3, 7].map((days) => ChoiceChip(
              label: Text('$days day${days > 1 ? 's' : ''} before'),
              selected: _daysBefore == days,
              onSelected: (selected) {
                if (selected) setState(() => _daysBefore = days);
              },
            )).toList(),
          ),
          const SizedBox(height: 20),
          const Text('At time:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.access_time),
            title: Text(_reminderTime.format(context)),
            onTap: () async {
              final picked = await showTimePicker(
                context: context,
                initialTime: _reminderTime,
              );
              if (picked != null) setState(() => _reminderTime = picked);
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _isScheduling ? null : _scheduleNotification,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: _isScheduling 
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
              : const Text('CONFIRM REMINDER · पुष्टि करें'),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<void> _scheduleNotification() async {
    setState(() => _isScheduling = true);
    
    try {
      final notifications = FlutterLocalNotificationsPlugin();
      
      // Calculate scheduled date
      final festivalStart = widget.festival.startDate;
      final scheduledDate = festivalStart.subtract(Duration(days: _daysBefore));
      
      // Combine with time
      final finalScheduledDate = DateTime(
        scheduledDate.year,
        scheduledDate.month,
        scheduledDate.day,
        _reminderTime.hour,
        _reminderTime.minute,
      );

      // Check if date is in the future
      if (finalScheduledDate.isBefore(DateTime.now())) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Selected time is in the past! Please choose another.')),
          );
        }
        setState(() => _isScheduling = false);
        return;
      }

      final tzLocation = tz.local;
      final tzScheduledDate = tz.TZDateTime.from(finalScheduledDate, tzLocation);

      const androidDetails = AndroidNotificationDetails(
        'festival_reminders',
        'Festival Reminders',
        channelDescription: 'Notifications for upcoming Indian festivals',
        importance: Importance.high,
        priority: Priority.high,
      );
      
      const details = NotificationDetails(android: androidDetails);

      await notifications.zonedSchedule(
        id: widget.festival.hashCode,
        title: 'Upcoming Festival: ${widget.festival.nameEn}',
        body: '${widget.festival.nameEn} starts in $_daysBefore day${_daysBefore > 1 ? 's' : ''}! Plan your meals now.',
        scheduledDate: tzScheduledDate,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Reminder set for ${finalScheduledDate.toString().split('.')[0]}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error scheduling notification: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isScheduling = false);
    }
  }
}
