// lib/features/appointments/data/appointments_service.dart
// Appointments Service

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';

/// Appointment status
enum AppointmentStatus { scheduled, completed, cancelled, missed }

extension AppointmentStatusExtension on AppointmentStatus {
  String get displayName {
    switch (this) {
      case AppointmentStatus.scheduled:
        return 'Scheduled';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.missed:
        return 'Missed';
    }
  }

  String get dbValue {
    switch (this) {
      case AppointmentStatus.scheduled:
        return 'scheduled';
      case AppointmentStatus.completed:
        return 'completed';
      case AppointmentStatus.cancelled:
        return 'cancelled';
      case AppointmentStatus.missed:
        return 'missed';
    }
  }

  static AppointmentStatus fromDbValue(String value) {
    switch (value) {
      case 'scheduled':
        return AppointmentStatus.scheduled;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'missed':
        return AppointmentStatus.missed;
      default:
        return AppointmentStatus.scheduled;
    }
  }
}

/// Appointments Service
class AppointmentsService {
  final AppDatabase db;
  static const _uuid = Uuid();

  AppointmentsService(this.db);

  /// Create a new appointment
  Future<DoctorAppointment> createAppointment({
    required String userId,
    required DateTime appointmentDate,
    required String doctorName,
    String? specialty,
    String? notes,
    String? location,
    String? reminderMinutesBefore,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    final companion = DoctorAppointmentsCompanion(
      id: Value(id),
      userId: Value(userId),
      appointmentDate: Value(appointmentDate),
      doctorName: Value(doctorName),
      specialty: Value(specialty),
      notes: Value(notes),
    );

    await db.into(db.doctorAppointments).insert(companion);

    // Create reminder notification if specified
    if (reminderMinutesBefore != null) {
      await _scheduleReminder(
        appointmentId: id,
        appointmentDate: appointmentDate,
        doctorName: doctorName,
        reminderMinutesBefore: int.tryParse(reminderMinutesBefore) ?? 60,
      );
    }

    return (await db.select(db.doctorAppointments)
          ..where((t) => t.id.equals(id)))
        .getSingle();
  }

  /// Get appointments for a user
  Future<List<DoctorAppointment>> getAppointments(String userId) async {
    return (db.select(db.doctorAppointments)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
        .get();
  }

  /// Get upcoming appointments
  Future<List<DoctorAppointment>> getUpcomingAppointments(String userId) async {
    final now = DateTime.now();
    return (db.select(db.doctorAppointments)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(now),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)])
          ..limit(10))
        .get();
  }

  /// Get today's appointments
  Future<List<DoctorAppointment>> getTodayAppointments(String userId) async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (db.select(db.doctorAppointments)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(startOfDay) &
                t.appointmentDate.isSmallerThanValue(endOfDay),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
        .get();
  }

  /// Get appointment by ID
  Future<DoctorAppointment?> getAppointmentById(String appointmentId) async {
    return (db.select(
      db.doctorAppointments,
    )..where((t) => t.id.equals(appointmentId))).getSingleOrNull();
  }

  /// Update appointment
  Future<void> updateAppointment({
    required String appointmentId,
    DateTime? appointmentDate,
    String? doctorName,
    String? specialty,
    String? notes,
    String? location,
  }) async {
    await (db.update(
      db.doctorAppointments,
    )..where((t) => t.id.equals(appointmentId))).write(
      DoctorAppointmentsCompanion(
        appointmentDate: appointmentDate != null
            ? Value(appointmentDate)
            : const Value.absent(),
        doctorName: doctorName != null
            ? Value(doctorName)
            : const Value.absent(),
        specialty: Value(specialty),
        notes: Value(notes),
      ),
    );
  }

  /// Cancel appointment
  Future<void> cancelAppointment(String appointmentId) async {
    await (db.update(db.doctorAppointments)
          ..where((t) => t.id.equals(appointmentId)))
        .write(DoctorAppointmentsCompanion(notes: const Value('Cancelled')));
  }

  /// Delete appointment
  Future<void> deleteAppointment(String appointmentId) async {
    await (db.delete(
      db.doctorAppointments,
    )..where((t) => t.id.equals(appointmentId))).go();
  }

  /// Get appointments for a date range
  Future<List<DoctorAppointment>> getAppointmentsInRange(
    String userId,
    DateTime start,
    DateTime end,
  ) async {
    return (db.select(db.doctorAppointments)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(start) &
                t.appointmentDate.isSmallerOrEqualValue(end),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
        .get();
  }

  /// Schedule reminder notification
  Future<void> _scheduleReminder({
    required String appointmentId,
    required DateTime appointmentDate,
    required String doctorName,
    required int reminderMinutesBefore,
  }) async {
    // This would integrate with flutter_local_notifications
    // For now, just log the intention
    // In production, this would schedule a local notification
  }

  /// Get upcoming appointment within specified hours
  Future<DoctorAppointment?> getNextAppointmentWithHours(
    String userId,
    int hours,
  ) async {
    final now = DateTime.now();
    final cutoff = now.add(Duration(hours: hours));

    return (db.select(db.doctorAppointments)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.appointmentDate.isBiggerOrEqualValue(now) &
                t.appointmentDate.isSmallerOrEqualValue(cutoff),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)])
          ..limit(1))
        .getSingleOrNull();
  }
}
