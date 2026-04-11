import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';

final abhaLinkProvider = StreamProvider.family<AbhaLink?, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.abhaLinks)..where((t) => t.userId.equals(userId))..limit(1))
      .watchSingleOrNull();
});

final recentLabReportsProvider = StreamProvider.family<List<LabReport>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.labReports)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.reportDate, mode: OrderingMode.desc)])
    ..limit(10))
      .watch();
});

final appointmentsProvider = StreamProvider.family<List<DoctorAppointment>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.doctorAppointments)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.appointmentDate, mode: OrderingMode.desc)]))
      .watch();
});

final periodLogsProvider = StreamProvider.family<List<PeriodLog>, String>((ref, userId) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.periodLogs)
    ..where((t) => t.userId.equals(userId))
    ..orderBy([(t) => OrderingTerm(expression: t.startDate, mode: OrderingMode.desc)]))
      .watch();
});
