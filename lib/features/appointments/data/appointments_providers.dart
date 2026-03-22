// lib/features/appointments/data/appointments_providers.dart
// Appointments providers

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/appointments/data/appointments_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for database instance
final appointmentsDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Appointments database provider must be overridden');
});

/// Provider for user ID
final appointmentsUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for appointments service
final appointmentsServiceProvider = Provider<AppointmentsService>((ref) {
  final db = ref.watch(appointmentsDatabaseProvider);
  return AppointmentsService(db);
});

/// Provider for all appointments
final appointmentsProvider =
    FutureProvider.autoDispose<List<DoctorAppointment>>((ref) async {
      try {
        final userId = await ref.watch(appointmentsUserIdProvider.future);
        final service = ref.watch(appointmentsServiceProvider);
        return service.getAppointments(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for upcoming appointments
final upcomingAppointmentsProvider =
    FutureProvider.autoDispose<List<DoctorAppointment>>((ref) async {
      try {
        final userId = await ref.watch(appointmentsUserIdProvider.future);
        final service = ref.watch(appointmentsServiceProvider);
        return service.getUpcomingAppointments(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for today's appointments
final todayAppointmentsProvider =
    FutureProvider.autoDispose<List<DoctorAppointment>>((ref) async {
      try {
        final userId = await ref.watch(appointmentsUserIdProvider.future);
        final service = ref.watch(appointmentsServiceProvider);
        return service.getTodayAppointments(userId);
      } catch (e) {
        return [];
      }
    });

/// Provider for next 24h appointment (for notification)
final nextAppointment24hProvider =
    FutureProvider.autoDispose<DoctorAppointment?>((ref) async {
      try {
        final userId = await ref.watch(appointmentsUserIdProvider.future);
        final service = ref.watch(appointmentsServiceProvider);
        return service.getNextAppointmentWithHours(userId, 24);
      } catch (e) {
        return null;
      }
    });

/// Helper class for appointment actions
class AppointmentsHelper {
  final Ref ref;

  AppointmentsHelper(this.ref);

  /// Create a new appointment
  Future<DoctorAppointment?> createAppointment({
    required DateTime appointmentDate,
    required String doctorName,
    String? specialty,
    String? notes,
    String? location,
    String? reminderMinutesBefore,
  }) async {
    try {
      final userId = await ref.read(appointmentsUserIdProvider.future);
      final service = ref.read(appointmentsServiceProvider);

      final appointment = await service.createAppointment(
        userId: userId,
        appointmentDate: appointmentDate,
        doctorName: doctorName,
        specialty: specialty,
        notes: notes,
        location: location,
        reminderMinutesBefore: reminderMinutesBefore,
      );

      // Invalidate providers
      ref.invalidate(appointmentsProvider);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(todayAppointmentsProvider);
      ref.invalidate(nextAppointment24hProvider);

      return appointment;
    } catch (e) {
      return null;
    }
  }

  /// Update appointment
  Future<void> updateAppointment({
    required String appointmentId,
    DateTime? appointmentDate,
    String? doctorName,
    String? specialty,
    String? notes,
  }) async {
    try {
      final service = ref.read(appointmentsServiceProvider);
      await service.updateAppointment(
        appointmentId: appointmentId,
        appointmentDate: appointmentDate,
        doctorName: doctorName,
        specialty: specialty,
        notes: notes,
      );

      ref.invalidate(appointmentsProvider);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(todayAppointmentsProvider);
    } catch (e) {
      // Silent fail
    }
  }

  /// Cancel appointment
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      final service = ref.read(appointmentsServiceProvider);
      await service.cancelAppointment(appointmentId);

      ref.invalidate(appointmentsProvider);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(todayAppointmentsProvider);
    } catch (e) {
      // Silent fail
    }
  }

  /// Delete appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      final service = ref.read(appointmentsServiceProvider);
      await service.deleteAppointment(appointmentId);

      ref.invalidate(appointmentsProvider);
      ref.invalidate(upcomingAppointmentsProvider);
      ref.invalidate(todayAppointmentsProvider);
    } catch (e) {
      // Silent fail
    }
  }
}

/// Provider for appointments helper
final appointmentsHelperProvider = Provider<AppointmentsHelper>((ref) {
  return AppointmentsHelper(ref);
});
