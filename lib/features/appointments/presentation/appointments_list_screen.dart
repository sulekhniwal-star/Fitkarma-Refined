import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/features/bp/data/bp_reminder_service.dart';

final appointmentsProvider = FutureProvider.family<List<DecryptedAppointment>, String>((ref, userId) async {
  final db = ref.read(appDatabaseProvider);
  return db.doctorAppointmentsDao.getUpcomingForUserDecrypted(userId);
});

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class AppointmentsListScreen extends ConsumerWidget {
  final String userId;

  const AppointmentsListScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync = ref.watch(appointmentsProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/appointments/add', extra: userId),
          ),
        ],
      ),
      body: appointmentsAsync.when(
        data: (appointments) => appointments.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_today, size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('No upcoming appointments'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () => context.push('/appointments/add', extra: userId),
                      child: const Text('Book Now'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  final apt = appointments[index];
                  return _buildAppointmentCard(context, ref, apt);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildAppointmentCard(BuildContext context, WidgetRef ref, DecryptedAppointment apt) {
    final isToday = apt.isToday;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _showAppointmentOptions(context, ref, apt),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: isToday ? AppColors.primary.withValues(alpha: 0.2) : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      isToday ? 'Today' : '${apt.appointmentDate.day}/${apt.appointmentDate.month}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isToday ? AppColors.primary : Colors.grey.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${apt.appointmentDate.hour}:${apt.appointmentDate.minute.toString().padLeft(2, '0')}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  if (apt.isCompleted)
                    const Icon(Icons.check_circle, color: Colors.green, size: 20),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                apt.doctorName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (apt.notes != null && apt.notes!.isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  apt.notes!,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showAppointmentOptions(BuildContext context, WidgetRef ref, DecryptedAppointment apt) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: const Text('Mark as Completed'),
              onTap: () async {
                Navigator.pop(context);
                final db = ref.read(appDatabaseProvider);
                await db.doctorAppointmentsDao.markCompleted(apt.id);
                ref.invalidate(appointmentsProvider(userId));
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Add Prescription Photo'),
              onTap: () {
                Navigator.pop(context);
                context.push('/appointments/prescription/${apt.id}', extra: userId);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('24h Reminder'),
              onTap: () async {
                Navigator.pop(context);
                _scheduleReminder(context, apt);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete', style: TextStyle(color: Colors.red)),
              onTap: () async {
                Navigator.pop(context);
                final db = ref.read(appDatabaseProvider);
                await db.doctorAppointmentsDao.deleteAppointment(apt.id);
                ref.invalidate(appointmentsProvider(userId));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _scheduleReminder(BuildContext context, DecryptedAppointment apt) async {
    final reminderService = BPReminderService.instance;
    await reminderService.initialize();
    await reminderService.requestPermission();
    await reminderService.scheduleAppointmentReminder(apt.id, apt.appointmentDate, apt.doctorName);
    
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('24h reminder set!')),
      );
    }
  }
}