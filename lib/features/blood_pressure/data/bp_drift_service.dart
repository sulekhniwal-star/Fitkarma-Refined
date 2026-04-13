import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/network/sync_queue.dart';

class BPDriftService {
  final AppDatabase _db;
  static const String _dataClass = 'bp_glucose';

  BPDriftService(this._db);

  /// Inserts an encrypted blood pressure log.
  Future<int> insertBPLog({
    required String userId,
    required int systolic,
    required int diastolic,
    required int pulse,
    String? note,
  }) async {
    final encSystolic = await EncryptionService.encryptField(systolic.toString(), _dataClass);
    final encDiastolic = await EncryptionService.encryptField(diastolic.toString(), _dataClass);
    final encPulse = await EncryptionService.encryptField(pulse.toString(), _dataClass);
    final encNote = note != null ? await EncryptionService.encryptField(note, _dataClass) : null;

    final companion = BloodPressureLogsCompanion.insert(
      userId: userId,
      systolic: encSystolic,
      diastolic: encDiastolic,
      pulse: encPulse,
      note: Value(encNote),
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'bp_log', DateTime.now().toIso8601String()),
    );

    return await _db.into(_db.bloodPressureLogs).insert(companion);
  }

  /// Fetches and decrypts blood pressure logs.
  Future<List<Map<String, dynamic>>> getDecryptedLogs(String userId) async {
    final logs = await (_db.select(_db.bloodPressureLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();

    final List<Map<String, dynamic>> decrypted = [];
    for (final log in logs) {
      decrypted.add({
        'id': log.id,
        'systolic': int.parse(await EncryptionService.decryptField(log.systolic, _dataClass)),
        'diastolic': int.parse(await EncryptionService.decryptField(log.diastolic, _dataClass)),
        'pulse': int.parse(await EncryptionService.decryptField(log.pulse, _dataClass)),
        'note': log.note != null ? await EncryptionService.decryptField(log.note!, _dataClass) : null,
        'loggedAt': log.loggedAt,
      });
    }
    return decrypted;
  }
}
