import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/network/sync_queue.dart';

class GlucoseDriftService {
  final AppDatabase _db;
  static const String _dataClass = 'bp_glucose';
  final _uuid = const Uuid();

  GlucoseDriftService(this._db);

  Future<void> insertGlucoseLog({
    required String userId,
    required double value,
    required String readingType,
    String? mealId,
    String? note,
  }) async {
    final encValue = await EncryptionService.encryptField(value.toString(), _dataClass);
    final encNote = note != null ? await EncryptionService.encryptField(note, _dataClass) : null;
    
    final classification = _classifyGlucose(value, readingType);
    
    final companion = GlucoseLogsCompanion.insert(
      id: _uuid.v4(),
      userId: userId,
      glucoseMgdl: encValue,
      readingType: readingType,
      foodLogId: Value(mealId),
      loggedAt: DateTime.now(),
      classification: classification,
      notes: Value(encNote),
      source: 'manual',
      idempotencyKey: generateIdempotencyKey(userId, 'glucose_log', DateTime.now().toIso8601String()),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.glucoseLogs).insert(companion);
  }

  String _classifyGlucose(double value, String readingType) {
    if (readingType.toLowerCase().contains('fasting')) {
      if (value < 70) return 'low';
      if (value <= 100) return 'normal';
      if (value <= 125) return 'prediabetic';
      return 'diabetic';
    } else {
      if (value < 70) return 'low';
      if (value <= 140) return 'normal';
      if (value <= 180) return 'prediabetic';
      return 'diabetic';
    }
  }

  Future<List<Map<String, dynamic>>> getDecryptedLogs(String userId) async {
    final logs = await (_db.select(_db.glucoseLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.loggedAt, mode: OrderingMode.desc)]))
        .get();

    final List<Map<String, dynamic>> decrypted = [];
    for (final log in logs) {
      decrypted.add({
        'id': log.id,
        'value': double.parse(await EncryptionService.decryptField(log.glucoseMgdl, _dataClass)),
        'readingType': log.readingType,
        'foodLogId': log.foodLogId,
        'notes': log.notes != null ? await EncryptionService.decryptField(log.notes!, _dataClass) : null,
        'loggedAt': log.loggedAt,
        'classification': log.classification,
      });
    }
    return decrypted;
  }
}
