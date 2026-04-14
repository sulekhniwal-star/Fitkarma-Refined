import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/drift_service.dart';

class AppointmentModel {
  final int? id;
  final String doctorName;
  final String? speciality;
  final DateTime appointmentDt;
  final String? notes;

  AppointmentModel({
    this.id,
    required this.doctorName,
    this.speciality,
    required this.appointmentDt,
    this.notes,
  });
}

class AppointmentsRepository {
  final AppDatabase db;
  static const String dataClass = 'appointments';

  AppointmentsRepository({required this.db});

  /// Logs a new doctor appointment with encryption.
  Future<void> addAppointment(String userId, AppointmentModel appointment) async {
    final nameEnc = await EncryptionService.encryptField(appointment.doctorName, dataClass);
    final specEnc = appointment.speciality != null 
        ? await EncryptionService.encryptField(appointment.speciality!, dataClass)
        : null;
    final dateEnc = await EncryptionService.encryptField(appointment.appointmentDt.toIso8601String(), dataClass);
    final notesEnc = appointment.notes != null 
        ? await EncryptionService.encryptField(appointment.notes!, dataClass)
        : null;

    await db.into(db.doctorAppointments).insert(
          DoctorAppointmentsCompanion.insert(
            userId: userId,
            doctorNameEncrypted: nameEnc,
            specialityEncrypted: Value(specEnc),
            appointmentDtEncrypted: dateEnc,
            notesEncrypted: Value(notesEnc),
          ),
        );
  }

  /// Fetches and decrypts upcoming appointments.
  Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
    final logs = await (db.select(db.doctorAppointments)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)]))
        .get();

    List<AppointmentModel> decrypted = [];
    for (final log in logs) {
      final name = await EncryptionService.decryptField(log.doctorNameEncrypted, dataClass);
      final spec = log.specialityEncrypted != null 
          ? await EncryptionService.decryptField(log.specialityEncrypted!, dataClass)
          : null;
      final dateStr = await EncryptionService.decryptField(log.appointmentDtEncrypted, dataClass);
      final notes = log.notesEncrypted != null 
          ? await EncryptionService.decryptField(log.notesEncrypted!, dataClass)
          : null;

      decrypted.add(AppointmentModel(
        id: log.id,
        doctorName: name,
        speciality: spec,
        appointmentDt: DateTime.parse(dateStr),
        notes: notes,
      ));
    }
    return decrypted;
  }
}

final appointmentsRepositoryProvider = Provider<AppointmentsRepository>((ref) {
  return AppointmentsRepository(db: DriftService.db);
});
