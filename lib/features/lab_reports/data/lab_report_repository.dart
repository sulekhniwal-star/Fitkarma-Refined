import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/di/providers.dart';
import '../domain/models/extraction_result.dart';

class LabReportRepository {
  final AppDatabase _db;
  final _uuid = const Uuid();

  LabReportRepository(this._db);

  /// Saves the extraction results and propagates values to health logs.
  Future<void> saveExtraction({
    required String userId,
    required LabReportExtraction extraction,
    required bool shouldRetainRawText,
  }) async {
    // 1. Save to LabReports table (metadata)
    final confirmedMetrics = extraction.markers
        .where((m) => m.isConfirmed)
        .map((m) => m.name)
        .toList();

    await _db.into(_db.labReports).insert(
      LabReportsCompanion.insert(
        userId: userId,
        reportDate: extraction.reportDate,
        labName: Value(extraction.labName),
        extractedValues: jsonEncode(extraction.markers.map((m) => m.toJson()).toList()),
        rawText: Value(shouldRetainRawText ? extraction.rawText : null),
        confirmedByUser: const Value(true),
        source: extraction.source,
        importedMetrics: Value(confirmedMetrics.join(', ')),
      ),
    );

    // 2. Propagate to specific health logs
    for (final marker in extraction.markers) {
      if (!marker.isConfirmed) continue;

      if (marker.name.contains('Glucose')) {
        await _saveGlucoseLog(userId, marker);
      } else if (marker.name.contains('BP')) {
        // We'll handle BP in the next step (needs pairing systolic/diastolic)
      } else if (marker.name == 'HbA1c') {
         await _saveGlucoseLog(userId, marker);
      } else {
        // Other markers could go to a generic "LabValues" table if implemented
      }
    }

    // Special handling for BP (pair systolic and diastolic)
    final sys = extraction.markers.firstWhere(
      (m) => m.name == 'Systolic BP' && m.isConfirmed, 
      orElse: () => LabMarker(name: '', nameHi: '', value: 0, unit: '', isConfirmed: false)
    );
    final dia = extraction.markers.firstWhere(
      (m) => m.name == 'Diastolic BP' && m.isConfirmed, 
      orElse: () => LabMarker(name: '', nameHi: '', value: 0, unit: '', isConfirmed: false)
    );

    if (sys.isConfirmed && dia.isConfirmed) {
      await _db.into(_db.bloodPressureLogs).insert(
        BloodPressureLogsCompanion.insert(
          userId: userId,
          systolic: sys.value.toInt().toString(),
          diastolic: dia.value.toInt().toString(),
          loggedAt: extraction.reportDate,
          classification: _classifyBP(sys.value.toInt(), dia.value.toInt()),
          source: 'ocr',
          idempotencyKey: _uuid.v4(),
        ),
      );
    }
  }

  Future<void> _saveGlucoseLog(String userId, LabMarker marker) async {
    String type = 'random';
    if (marker.name.toLowerCase().contains('fasting')) type = 'fasting';
    if (marker.name.toLowerCase().contains('pp')) type = 'post_meal';
    
    await _db.into(_db.glucoseLogs).insert(
      GlucoseLogsCompanion.insert(
        userId: userId,
        glucoseMgdl: marker.name == 'HbA1c' ? '0' : marker.value.toString(),
        readingType: marker.name == 'HbA1c' ? 'hba1c' : type,
        loggedAt: DateTime.now(),
        classification: 'normal', // Should use a classifier utility
        source: 'ocr',
        idempotencyKey: _uuid.v4(),
        hba1cEstimate: marker.name == 'HbA1c' ? Value(marker.value.toString()) : const Value.absent(),
      ),
    );
  }

  String _classifyBP(int sys, int dia) {
    if (sys >= 180 || dia >= 120) return 'crisis';
    if (sys >= 140 || dia >= 90) return 'stage2';
    if (sys >= 130 || dia >= 80) return 'stage1';
    if (sys >= 120 && dia < 80) return 'elevated';
    return 'normal';
  }
}

final labReportRepositoryProvider = Provider<LabReportRepository>((ref) {
  final db = ref.watch(driftDbProvider);
  return LabReportRepository(db);
});
