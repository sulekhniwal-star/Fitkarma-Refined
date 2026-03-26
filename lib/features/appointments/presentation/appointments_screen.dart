// lib/features/appointments/presentation/appointments_screen.dart
// Appointments list and management screen

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/appointments/data/appointments_providers.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointments = ref.watch(upcomingAppointmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointments'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(upcomingAppointmentsProvider);
        },
        child: appointments.when(
          data: (list) {
            if (list.isEmpty) {
              return _buildEmptyState();
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              itemBuilder: (context, index) {
                return _AppointmentCard(
                  appointment: list[index],
                  onTap: () =>
                      _showAppointmentDetails(context, ref, list[index]),
                  onCancel: () =>
                      _cancelAppointment(context, ref, list[index].id),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, _) => _buildEmptyState(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAppointmentSheet(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Appointment'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No upcoming appointments',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add a new appointment',
            style: TextStyle(fontSize: 14, color: Colors.grey[400]),
          ),
        ],
      ),
    );
  }

  void _showAddAppointmentSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const _AddAppointmentSheet(),
    );
  }

  void _showAppointmentDetails(
    BuildContext context,
    WidgetRef ref,
    DoctorAppointment appointment,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appointment.doctorName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (appointment.specialty != null)
              Text('Specialty: ${appointment.specialty}'),
            const SizedBox(height: 8),
            Text(
              'Date: ${DateFormat('MMM d, yyyy - h:mm a').format(appointment.appointmentDate)}',
            ),
            if (appointment.notes != null) ...[
              const SizedBox(height: 8),
              Text('Notes: ${appointment.notes}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _cancelAppointment(
    BuildContext context,
    WidgetRef ref,
    String appointmentId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Appointment'),
        content: const Text(
          'Are you sure you want to cancel this appointment?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final helper = ref.read(appointmentsHelperProvider);
      await helper.cancelAppointment(appointmentId);
    }
  }
}

class _AppointmentCard extends StatelessWidget {
  final DoctorAppointment appointment;
  final VoidCallback onTap;
  final VoidCallback onCancel;

  const _AppointmentCard({
    required this.appointment,
    required this.onTap,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM d, yyyy');
    final timeFormat = DateFormat('h:mm a');
    final isToday = _isToday(appointment.appointmentDate);
    final isTomorrow = _isTomorrow(appointment.appointmentDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isToday
                          ? Colors.red[100]
                          : isTomorrow
                          ? Colors.orange[100]
                          : Colors.blue[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.calendar_today,
                      color: isToday
                          ? Colors.red
                          : isTomorrow
                          ? Colors.orange
                          : Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          appointment.doctorName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (appointment.specialty != null)
                          Text(
                            appointment.specialty!,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onCancel,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${dateFormat.format(appointment.appointmentDate)} at ${timeFormat.format(appointment.appointmentDate)}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                ],
              ),
              if (isToday) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'TODAY',
                    style: TextStyle(
                      color: Colors.red[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ] else if (isTomorrow) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'TOMORROW',
                    style: TextStyle(
                      color: Colors.orange[700],
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  bool _isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }
}

class _AddAppointmentSheet extends ConsumerStatefulWidget {
  const _AddAppointmentSheet();

  @override
  ConsumerState<_AddAppointmentSheet> createState() =>
      _AddAppointmentSheetState();
}

class _AddAppointmentSheetState extends ConsumerState<_AddAppointmentSheet> {
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _specialtyController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);
  bool _isLoading = false;
  bool _reminderEnabled = true;

  @override
  void dispose() {
    _doctorNameController.dispose();
    _specialtyController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Add Appointment',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _doctorNameController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _specialtyController,
                decoration: const InputDecoration(
                  labelText: 'Specialty (optional)',
                  prefixIcon: Icon(Icons.medical_services),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today),
                      label: Text(
                        DateFormat('MMM d, yyyy').format(_selectedDate),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _pickTime,
                      icon: const Icon(Icons.access_time),
                      label: Text(_selectedTime.format(context)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('24h Reminder'),
                subtitle: const Text('Get notified 24 hours before'),
                value: _reminderEnabled,
                onChanged: (value) => setState(() => _reminderEnabled = value),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _saveAppointment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Save Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (time != null) {
      setState(() => _selectedTime = time);
    }
  }

  Future<void> _saveAppointment() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final appointmentDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      final helper = ref.read(appointmentsHelperProvider);
      await helper.createAppointment(
        appointmentDate: appointmentDateTime,
        doctorName: _doctorNameController.text,
        specialty: _specialtyController.text.isEmpty
            ? null
            : _specialtyController.text,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        reminderMinutesBefore: _reminderEnabled ? '1440' : null, // 24 hours
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Appointment saved!')));
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
