import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final appointmentProvider = NotifierProvider<AppointmentNotifier, AppointmentState>(AppointmentNotifier.new);

class AppointmentState {
  final DateTime appointmentDate;
  final String doctorName;
  final String notes;
  final bool isLoading;
  final String? error;
  final bool saved;

  AppointmentState({
    DateTime? appointmentDate,
    this.doctorName = '',
    this.notes = '',
    this.isLoading = false,
    this.error,
    this.saved = false,
  }) : appointmentDate = appointmentDate ?? DateTime.now().add(const Duration(days: 1));

  AppointmentState copyWith({
    DateTime? appointmentDate,
    String? doctorName,
    String? notes,
    bool? isLoading,
    String? error,
    bool? saved,
  }) {
    return AppointmentState(
      appointmentDate: appointmentDate ?? this.appointmentDate,
      doctorName: doctorName ?? this.doctorName,
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      saved: saved ?? this.saved,
    );
  }
}

class AppointmentNotifier extends Notifier<AppointmentState> {
  @override
  AppointmentState build() => AppointmentState();

  void setDate(DateTime v) => state = state.copyWith(appointmentDate: v);
  void setDoctorName(String v) => state = state.copyWith(doctorName: v);
  void setNotes(String v) => state = state.copyWith(notes: v);

  Future<void> save(String userId) async {
    if (state.doctorName.isEmpty) {
      state = state.copyWith(error: 'Doctor name is required');
      return;
    }
    
    state = state.copyWith(isLoading: true, error: null);
    try {
      final db = ref.read(appDatabaseProvider);
      await db.doctorAppointmentsDao.insertWithEncryption(
        userId: userId,
        appointmentDate: state.appointmentDate,
        doctorName: state.doctorName,
        notes: state.notes.isEmpty ? null : state.notes,
      );
      state = state.copyWith(isLoading: false, saved: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void reset() => state = AppointmentState();
}

class AppointmentScreen extends ConsumerStatefulWidget {
  final String userId;

  const AppointmentScreen({super.key, required this.userId});

  @override
  ConsumerState<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends ConsumerState<AppointmentScreen> {
  late TextEditingController _doctorController;
  late TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _doctorController = TextEditingController();
    _notesController = TextEditingController();
  }

  @override
  void dispose() {
    _doctorController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(appointmentProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Appointment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDatePicker(state),
              const SizedBox(height: 24),
              _buildDoctorInput(state),
              const SizedBox(height: 16),
              _buildNotesInput(state),
              const SizedBox(height: 32),
              _buildSaveButton(state),
              if (state.error != null) ...[
                const SizedBox(height: 16),
                Text(state.error!, style: const TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Appointment Date & Time',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: state.appointmentDate,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (date != null && mounted) {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(state.appointmentDate),
              );
              if (time != null) {
                final dateTime = DateTime(
                  date.year, date.month, date.day,
                  time.hour, time.minute,
                );
                ref.read(appointmentProvider.notifier).setDate(dateTime);
              }
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.lightSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 12),
                Text(
                  '${state.appointmentDate.day}/${state.appointmentDate.month}/${state.appointmentDate.year} at ${state.appointmentDate.hour}:${state.appointmentDate.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorInput(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Doctor Name',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _doctorController,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            hintText: 'Dr. Smith',
            prefixIcon: const Icon(Icons.person, color: Colors.grey),
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (v) => ref.read(appointmentProvider.notifier).setDoctorName(v),
        ),
      ],
    );
  }

  Widget _buildNotesInput(AppointmentState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Notes (optional, encrypted)',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _notesController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Reason for visit...',
            filled: true,
            fillColor: AppColors.lightSurface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: (v) => ref.read(appointmentProvider.notifier).setNotes(v),
        ),
      ],
    );
  }

  Widget _buildSaveButton(AppointmentState state) {
    return ElevatedButton(
      onPressed: state.isLoading ? null : () async {
        final notifier = ref.read(appointmentProvider.notifier);
        await notifier.save(widget.userId);
        if (mounted && ref.read(appointmentProvider).saved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Appointment booked!'),
              backgroundColor: Colors.green,
            ),
          );
          context.pop();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: state.isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : const Text('Book Appointment', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }
}