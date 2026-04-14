import 'package:drift/drift.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/storage/drift_service.dart';

enum CyclePhase { menstrual, follicular, ovulatory, luteal }

class PeriodLogModel {
  final DateTime cycleStart;
  final DateTime? cycleEnd;
  final String? symptoms;
  final String? flowIntensity;
  final String? notes;

  PeriodLogModel({
    required this.cycleStart,
    this.cycleEnd,
    this.symptoms,
    this.flowIntensity,
    this.notes,
  });
}

class PeriodDriftService {
  final AppDatabase db;
  static const String dataClass = 'period';

  PeriodDriftService({required this.db});

  /// Logs a cycle entry with full field-level encryption.
  Future<void> logCycle(String userId, PeriodLogModel log) async {
    final startEnc = await EncryptionService.encryptField(log.cycleStart.toIso8601String(), dataClass);
    final endEnc = log.cycleEnd != null 
        ? await EncryptionService.encryptField(log.cycleEnd!.toIso8601String(), dataClass)
        : null;
    final sxEnc = log.symptoms != null 
        ? await EncryptionService.encryptField(log.symptoms!, dataClass)
        : null;
    final flowEnc = log.flowIntensity != null 
        ? await EncryptionService.encryptField(log.flowIntensity!, dataClass)
        : null;
    final notesEnc = log.notes != null 
        ? await EncryptionService.encryptField(log.notes!, dataClass)
        : null;

    await db.into(db.periodLogs).insert(
          PeriodLogsCompanion.insert(
            userId: userId,
            cycleStartEncrypted: startEnc,
            cycleEndEncrypted: Value(endEnc),
            symptomsEncrypted: Value(sxEnc),
            flowIntensityEncrypted: Value(flowEnc),
            notesEncrypted: Value(notesEnc),
          ),
        );
    // Sync to Appwrite is OPT-IN, so we don't enqueue here by default.
  }

  /// Fetches and decrypts the last N cycle logs.
  Future<List<PeriodLogModel>> getRecentCycles(String userId, {int limit = 5}) async {
    final logs = await (db.select(db.periodLogs)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc)])
          ..limit(limit))
        .get();

    List<PeriodLogModel> decryptedLogs = [];
    for (final log in logs) {
      final startStr = await EncryptionService.decryptField(log.cycleStartEncrypted, dataClass);
      final endStr = log.cycleEndEncrypted != null 
          ? await EncryptionService.decryptField(log.cycleEndEncrypted!, dataClass)
          : null;
      final sx = log.symptomsEncrypted != null 
          ? await EncryptionService.decryptField(log.symptomsEncrypted!, dataClass)
          : null;
      final flow = log.flowIntensityEncrypted != null 
          ? await EncryptionService.decryptField(log.flowIntensityEncrypted!, dataClass)
          : null;
      final notes = log.notesEncrypted != null 
          ? await EncryptionService.decryptField(log.notesEncrypted!, dataClass)
          : null;

      decryptedLogs.add(PeriodLogModel(
        cycleStart: DateTime.parse(startStr),
        cycleEnd: endStr != null ? DateTime.parse(endStr) : null,
        symptoms: sx,
        flowIntensity: flow,
        notes: notes,
      ));
    }
    return decryptedLogs;
  }

  /// Predicts the next cycle start based on the average of last 3 cycles.
  Future<DateTime?> predictNextCycle(String userId) async {
    final recent = await getRecentCycles(userId, limit: 4);
    if (recent.length < 2) return null;

    List<int> lengths = [];
    for (int i = 0; i < recent.length - 1; i++) {
      // difference between start of cycle N and start of cycle N-1
      lengths.add(recent[i].cycleStart.difference(recent[i + 1].cycleStart).inDays);
    }

    if (lengths.isEmpty) return null;
    final avgLength = lengths.reduce((a, b) => a + b) ~/ lengths.length;
    return recent.first.cycleStart.add(Duration(days: avgLength));
  }

  /// Determines the current cycle phase based on days since start.
  CyclePhase getCurrentPhase(DateTime cycleStart, {int avgCycleLength = 28}) {
    final day = DateTime.now().difference(cycleStart).inDays + 1;

    if (day <= 5) return CyclePhase.menstrual;
    if (day <= 13) return CyclePhase.follicular;
    if (day <= 15) return CyclePhase.ovulatory;
    return CyclePhase.luteal;
  }
  
  /// Get workout suggestion based on phase
  String getWorkoutSuggestion(CyclePhase phase) {
    switch (phase) {
      case CyclePhase.menstrual:
        return 'Yoga & Gentle Stretching (Focus on relaxation)';
      case CyclePhase.follicular:
        return 'Light Cardio & Strength Training (Energy is rising)';
      case CyclePhase.ovulatory:
        return 'HIIT & Heavy Lifting (Peak strength & endurance)';
      case CyclePhase.luteal:
        return 'Steady-state Cardio (Early) → Walking (Late)';
    }
  }
}
