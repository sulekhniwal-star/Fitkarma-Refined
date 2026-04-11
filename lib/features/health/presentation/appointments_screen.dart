import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../core/security/encryption_service.dart';

import '../data/health_providers.dart';
import '../data/health_repository.dart';

class AppointmentsScreen extends ConsumerWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider).asData?.value;
    final appointmentsAsync = ref.watch(appointmentsProvider(user?.$id ?? ''));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Appointments · अपॉइंटमेंट', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.indigo[700],
        foregroundColor: Colors.white,
      ),
      body: appointmentsAsync.when(
        data: (list) => list.isEmpty
            ? const _EmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final appt = list[index];
                  return _AppointmentTile(appointment: appt);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddAppointment(context),
        backgroundColor: Colors.indigo[700],
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('New Appointment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showAddAppointment(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _AddAppointmentSheet(),
    );
  }
}

class _AppointmentTile extends ConsumerWidget {
  final DoctorAppointment appointment;
  const _AppointmentTile({required this.appointment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateStr = DateFormat('EEE, MMM d, yyyy').format(appointment.appointmentDate);
    final timeStr = DateFormat('h:mm a').format(appointment.appointmentDate);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: appointment.isCompleted ? Colors.green.withOpacity(0.1) : Colors.indigo.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            appointment.isCompleted ? Icons.check : Icons.local_hospital,
            color: appointment.isCompleted ? Colors.green : Colors.indigo,
          ),
        ),
        title: Text(appointment.doctorName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$dateStr at $timeStr', style: const TextStyle(fontSize: 12)),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appointment.specialty != null)
                  _DetailRow(Icons.medical_services_outlined, appointment.specialty!),
                if (appointment.location != null)
                  _DetailRow(Icons.location_on_outlined, appointment.location!),
                const SizedBox(height: 8),
                FutureBuilder<String>(
                  future: ref.read(encryptionServiceProvider('appointment')).decrypt(appointment.reason ?? ''),
                  builder: (context, snapshot) {
                    return _DetailRow(Icons.notes, snapshot.data ?? 'Decrypting...');
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (!appointment.isCompleted)
                      TextButton.icon(
                        onPressed: () => _markCompleted(ref, appointment),
                        icon: const Icon(Icons.check),
                        label: const Text('Mark Completed'),
                        style: TextButton.styleFrom(foregroundColor: Colors.green),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _markCompleted(WidgetRef ref, DoctorAppointment appt) async {
    final db = ref.read(databaseProvider);
    await db.update(db.doctorAppointments).replace(
      appt.copyWith(isCompleted: true),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _DetailRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 13, color: Colors.grey))),
        ],
      ),
    );
  }
}

class _AddAppointmentSheet extends ConsumerStatefulWidget {
  const _AddAppointmentSheet();
  @override
  ConsumerState<_AddAppointmentSheet> createState() => _AddAppointmentSheetState();
}

class _AddAppointmentSheetState extends ConsumerState<_AddAppointmentSheet> {
  final _doctorCtrl = TextEditingController();
  final _specialtyCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _selectedTime = const TimeOfDay(hour: 10, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('New Appointment · नया अपॉइंटमेंट', 
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: _doctorCtrl,
              decoration: const InputDecoration(labelText: 'Doctor Name', prefixIcon: Icon(Icons.person)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _specialtyCtrl,
              decoration: const InputDecoration(labelText: 'Specialty (e.g. Cardiologist)', prefixIcon: Icon(Icons.medical_services)),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Date', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(DateFormat('MMM d, yyyy').format(_selectedDate)),
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Time', style: TextStyle(fontSize: 12, color: Colors.grey)),
                    subtitle: Text(_selectedTime.format(context)),
                    onTap: () async {
                      final picked = await showTimePicker(context: context, initialTime: _selectedTime);
                      if (picked != null) setState(() => _selectedTime = picked);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _locationCtrl,
              decoration: const InputDecoration(labelText: 'Location / Hospital', prefixIcon: Icon(Icons.location_on)),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonCtrl,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Notes / Reason (Encrypted) 🔒', prefixIcon: Icon(Icons.notes)),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[700],
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('SAVE APPOINTMENT', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (_doctorCtrl.text.isEmpty) return;

    final repo = ref.read(healthRepositoryProvider);
    
    final fullDate = DateTime(
      _selectedDate.year, _selectedDate.month, _selectedDate.day,
      _selectedTime.hour, _selectedTime.minute,
    );

    await repo.saveAppointment(
      doctorName: _doctorCtrl.text,
      specialty: _specialtyCtrl.text.isNotEmpty ? _specialtyCtrl.text : null,
      location: _locationCtrl.text.isNotEmpty ? _locationCtrl.text : null,
      reason: _reasonCtrl.text.isNotEmpty ? _reasonCtrl.text : null,
      date: fullDate,
    );

    if (mounted) Navigator.pop(context);
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.calendar_today, size: 64, color: Colors.indigo[100]),
          const SizedBox(height: 16),
          const Text('No appointments scheduled', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const Text('Track your upcoming visits to the doctor.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
