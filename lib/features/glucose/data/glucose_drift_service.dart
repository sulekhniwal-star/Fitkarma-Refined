import 'package:drift/drift.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/network/sync_queue.dart';

class GlucoseDriftService {
  final AppDatabase _db;
  static const String _dataClass = 'bp_glucose';

  GlucoseDriftService(this._db);

  /// Inserts an encrypted glucose log.
  Future<int> insertGlucoseLog({
    required String userId,
    required double value,
    required String type, // Fasting, Post-meal, etc.
    String? mealId,
    String? note,
  }) async {
    final encValue = await EncryptionService.encryptField(value.toString(), _dataClass);
    final encNote = note != null ? await EncryptionService.encryptField(note, _dataClass) : null;

    final companion = GlucoseLogsCompanion.insert(
      userId: userId,
      value: encValue,
      type: Value(type),
      mealId: Value(mealId),
      note: Value(encNote),
      loggedAt: DateTime.now(),
      idempotencyKey: generateIdempotencyKey(userId, 'glucose_log', DateTime.now().toIso8601String()),
    );

    return await _db.into(_db.glucoseLogs).insert(companion);
  }

  /// Fetches and decrypts glucose logs.
  Future<List<Map<String, dynamic>>> getDecryptedLogs(String userId) async {
    final logs = await (_db.select(_db.glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();

    final List<Map<String, dynamic>> decrypted = [];
    for (final log in logs) {
      decrypted.add({
        'id': log.id,
        'value': double.parse(await EncryptionService.decryptField(log.value, _dataClass)),
        'type': log.type,
        'mealId': log.mealId,
        'note': log.note != null ? await EncryptionService.decryptField(log.note!, _dataClass) : null,
        'loggedAt': log.loggedAt,
      });
    }
    return decrypted;
  }
}
