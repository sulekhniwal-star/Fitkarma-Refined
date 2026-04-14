import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../data/appointments_repository.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../shared/widgets/encryption_badge.dart';

class DoctorAppointmentsScreen extends ConsumerStatefulWidget {
  const DoctorAppointmentsScreen({super.key});

  @override
  ConsumerState<DoctorAppointmentsScreen> createState() => _DoctorAppointmentsScreenState();
}

class _DoctorAppointmentsScreenState extends ConsumerState<DoctorAppointmentsScreen> {
  final _doctorController = TextEditingController();
  final _specialityController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _doctorController.dispose();
    _specialityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _showAddBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('New Appointment', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            TextField(controller: _doctorController, decoration: const InputDecoration(labelText: 'Doctor Name')),
            TextField(controller: _specialityController, decoration: const InputDecoration(labelText: 'Speciality')),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('Date & Time'),
              subtitle: Text(DateFormat('EEE, MMM d, yyyy • h:mm a').format(_selectedDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.fromDateTime(_selectedDate),
                  );
                  if (time != null) {
                    setState(() {
                      _selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                    });
                  }
                }
              },
            ),
            TextField(controller: _notesController, decoration: const InputDecoration(labelText: 'Notes')),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveAppointment,
                child: const Text('SAVE APPOINTMENT'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAppointment() async {
    final userId = ref.read(authStateProvider).value?.id;
    if (userId == null) return;

    final repo = ref.read(appointmentsRepositoryProvider);
    await repo.addAppointment(
      userId,
      AppointmentModel(
        doctorName: _doctorController.text,
        speciality: _specialityController.text,
        appointmentDt: _selectedDate,
        notes: _notesController.text,
      ),
    );

    _doctorController.clear();
    _specialityController.clear();
    _notesController.clear();
    
    if (mounted) {
      Navigator.pop(context);
      setState(() {}); // Refresh list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment saved (Encrypted) 🔒')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(authStateProvider).value?.id;
    final appointmentsFuture = userId != null 
        ? ref.watch(appointmentsRepositoryProvider).getUpcomingAppointments(userId)
        : Future.value(<AppointmentModel>[]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Appointments'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: FutureBuilder<List<AppointmentModel>>(
        future: appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text('No upcoming appointments.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final appt = list[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.person)),
                  title: Text(appt.doctorName, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${appt.speciality ?? 'General'} • ${DateFormat('MMM d, h:mm a').format(appt.appointmentDt)}'),
                  trailing: const Icon(Icons.more_vert),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddBottomSheet,
        child: const Icon(Icons.add),
      ),
    );
  }
}
