import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'doctor_appointments_dao.g.dart';


@DriftAccessor(tables: [DoctorAppointments])
class DoctorAppointmentsDao extends DatabaseAccessor<AppDatabase>
    with _$DoctorAppointmentsDaoMixin {
  DoctorAppointmentsDao(super.db);

  Future<List<DoctorAppointment>> getUpcoming(String userId) =>
      (select(doctorAppointments)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.status.equals('scheduled'))
            ..where((t) => t.appointmentDate.isBiggerOrEqualValue(DateTime.now()))
            ..orderBy([(t) => OrderingTerm.asc(t.appointmentDate)]))
          .get();

  Future<List<DoctorAppointment>> getAll(String userId) =>
      (select(doctorAppointments)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.appointmentDate)]))
          .get();

  Future<int> insertAppointment(DoctorAppointmentsCompanion entry) =>
      into(doctorAppointments).insert(entry);

  Future<bool> updateAppointment(DoctorAppointmentsCompanion entry) =>
      update(doctorAppointments).replace(entry);

  Future<int> deleteAppointment(int id) =>
      (delete(doctorAppointments)..where((t) => t.id.equals(id))).go();
}
