// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointments_dao.dart';

// ignore_for_file: type=lint
mixin _$DoctorAppointmentsDaoMixin on DatabaseAccessor<AppDatabase> {
  $DoctorAppointmentsTable get doctorAppointments =>
      attachedDatabase.doctorAppointments;
  DoctorAppointmentsDaoManager get managers =>
      DoctorAppointmentsDaoManager(this);
}

class DoctorAppointmentsDaoManager {
  final _$DoctorAppointmentsDaoMixin _db;
  DoctorAppointmentsDaoManager(this._db);
  $$DoctorAppointmentsTableTableManager get doctorAppointments =>
      $$DoctorAppointmentsTableTableManager(
        _db.attachedDatabase,
        _db.doctorAppointments,
      );
}
