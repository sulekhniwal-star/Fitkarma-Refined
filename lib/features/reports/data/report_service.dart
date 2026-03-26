// lib/features/reports/data/report_service.dart
// Report service - aggregates health data for PDF generation

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/reports/data/report_data.dart';
import 'package:fitkarma/features/reports/data/pdf_report_service.dart';
import 'package:fitkarma/features/reports/data/report_storage_service.dart';

/// Provider for the report service
final reportServiceProvider = Provider<ReportService>((ref) {
  return ReportService();
});

/// Report Service - aggregates health data and generates PDFs
class ReportService {
  final _pdfService = PdfReportService();
  final _storageService = ReportStorageService();

  /// Generate a health report for the specified period
  Future<HealthReportData> generateReport({
    required String userId,
    required String userName,
    required ReportPeriod period,
    required AppDatabase db,
  }) async {
    final now = DateTime.now();
    late DateTime startDate;
    late DateTime endDate;

    // Calculate date range based on period
    if (period == ReportPeriod.weekly) {
      startDate = now.subtract(const Duration(days: 7));
      endDate = now;
    } else {
      startDate = DateTime(now.year, now.month, 1);
      // End of last month for monthly report
      endDate = DateTime(now.year, now.month, 0);
    }

    // Fetch data for the period
    final bpReadings = await _getBloodPressureReadings(
      db,
      userId,
      startDate,
      endDate,
    );
    final glucoseReadings = await _getGlucoseReadings(
      db,
      userId,
      startDate,
      endDate,
    );
    final weightReadings = await _getWeightReadings(
      db,
      userId,
      startDate,
      endDate,
    );
    final labValues = await _getLabValues(db, userId);

    // Calculate statistics
    double? avgSystolic;
    double? avgDiastolic;
    if (bpReadings.isNotEmpty) {
      final systolicSum = bpReadings.fold<int>(
        0,
        (sum, bp) => sum + bp.systolic,
      );
      final diastolicSum = bpReadings.fold<int>(
        0,
        (sum, bp) => sum + bp.diastolic,
      );
      avgSystolic = systolicSum / bpReadings.length;
      avgDiastolic = diastolicSum / bpReadings.length;
    }

    double? avgGlucose;
    double? minGlucose;
    double? maxGlucose;
    if (glucoseReadings.isNotEmpty) {
      final glucoseValues = glucoseReadings.map((g) => g.glucoseMgdl).toList();
      avgGlucose = glucoseValues.reduce((a, b) => a + b) / glucoseValues.length;
      minGlucose = glucoseValues.reduce((a, b) => a < b ? a : b);
      maxGlucose = glucoseValues.reduce((a, b) => a > b ? a : b);
    }

    double? currentWeight;
    double? weightChange;
    double? avgWeight;
    if (weightReadings.isNotEmpty) {
      currentWeight = weightReadings.last.weightKg;
      avgWeight =
          weightReadings.map((w) => w.weightKg).reduce((a, b) => a + b) /
          weightReadings.length;
      if (weightReadings.length > 1) {
        weightChange =
            weightReadings.last.weightKg - weightReadings.first.weightKg;
      }
    }

    return HealthReportData(
      userName: userName,
      generatedAt: now,
      period: period,
      startDate: startDate,
      endDate: endDate,
      bpReadings: bpReadings,
      avgSystolic: avgSystolic,
      avgDiastolic: avgDiastolic,
      bpReadingsCount: bpReadings.length,
      glucoseReadings: glucoseReadings,
      avgGlucose: avgGlucose,
      minGlucose: minGlucose,
      maxGlucose: maxGlucose,
      glucoseReadingsCount: glucoseReadings.length,
      weightReadings: weightReadings,
      currentWeight: currentWeight,
      weightChange: weightChange,
      avgWeight: avgWeight,
      labValues: labValues,
    );
  }

  /// Generate and save PDF report
  Future<String> generateAndSavePdf({
    required String userId,
    required String userName,
    required ReportPeriod period,
    required AppDatabase db,
  }) async {
    final reportData = await generateReport(
      userId: userId,
      userName: userName,
      period: period,
      db: db,
    );

    // Generate PDF in isolate
    final pdfBytes = await _pdfService.generatePdfInIsolate(reportData);

    // Save locally
    final fileName = _storageService.generateFileName(
      userId: userId,
      period: period.name,
      startDate: reportData.startDate,
      endDate: reportData.endDate,
    );

    final filePath = await _storageService.savePdfReport(pdfBytes, fileName);
    return filePath;
  }

  /// Get saved reports
  Future<List<ReportFileInfo>> getSavedReports() async {
    return _storageService.getSavedReports();
  }

  /// Delete a saved report
  Future<bool> deleteReport(String filePath) async {
    return _storageService.deletePdfReport(filePath);
  }

  /// Read PDF bytes
  Future<Uint8List?> readReport(String filePath) async {
    return _storageService.readPdfReport(filePath);
  }

  // Private methods to fetch data from database

  Future<List<BpDataPoint>> _getBloodPressureReadings(
    AppDatabase db,
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = db.select(db.bloodPressureLogs)
      ..where(
        (t) =>
            t.userId.equals(userId) &
            t.loggedAt.isBiggerOrEqualValue(startDate) &
            t.loggedAt.isSmallerOrEqualValue(endDate),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);

    final results = await query.get();
    return results.map((row) {
      // systolic and diastolic are stored as text but converted via BpDataClassConverters
      // They should return int
      return BpDataPoint(
        timestamp: row.loggedAt,
        systolic: row.systolic is int
            ? row.systolic
            : int.tryParse(row.systolic.toString()) ?? 0,
        diastolic: row.diastolic is int
            ? row.diastolic
            : int.tryParse(row.diastolic.toString()) ?? 0,
        pulse: row.pulse is int
            ? row.pulse
            : (row.pulse != null ? int.tryParse(row.pulse.toString()) : null),
        classification: row.classification,
      );
    }).toList();
  }

  Future<List<GlucoseDataPoint>> _getGlucoseReadings(
    AppDatabase db,
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = db.select(db.glucoseLogs)
      ..where(
        (t) =>
            t.userId.equals(userId) &
            t.loggedAt.isBiggerOrEqualValue(startDate) &
            t.loggedAt.isSmallerOrEqualValue(endDate),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.loggedAt)]);

    final results = await query.get();
    return results.map((row) {
      // glucoseMgdl is stored as text but converted to double
      return GlucoseDataPoint(
        timestamp: row.loggedAt,
        glucoseMgdl: row.glucoseMgdl is double
            ? row.glucoseMgdl
            : double.tryParse(row.glucoseMgdl.toString()) ?? 0.0,
        readingType: row.readingType,
        classification: row.classification,
      );
    }).toList();
  }

  Future<List<WeightDataPoint>> _getWeightReadings(
    AppDatabase db,
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final query = db.select(db.bodyMeasurements)
      ..where(
        (t) =>
            t.userId.equals(userId) &
            t.measuredAt.isBiggerOrEqualValue(startDate) &
            t.measuredAt.isSmallerOrEqualValue(endDate) &
            t.weightKg.isNotNull(),
      )
      ..orderBy([(t) => OrderingTerm.asc(t.measuredAt)]);

    final results = await query.get();
    return results
        .where((row) => row.weightKg != null)
        .map(
          (row) => WeightDataPoint(
            timestamp: row.measuredAt,
            weightKg: row.weightKg is double
                ? row.weightKg
                : (row.weightKg ?? 0.0).toDouble(),
            bodyFatPercentage: row.bodyFatPercentage,
          ),
        )
        .toList();
  }

  Future<List<LabValue>> _getLabValues(AppDatabase db, String userId) async {
    // Get the most recent lab report
    final query = db.select(db.labReports)
      ..where((t) => t.userId.equals(userId) & t.confirmedByUser.equals(true))
      ..orderBy([(t) => OrderingTerm.desc(t.reportDate)])
      ..limit(1);

    final results = await query.get();
    if (results.isEmpty) return [];

    final labReport = results.first;
    try {
      final extractedValues = jsonDecode(labReport.extractedValues);
      final List<LabValue> labValues = [];

      // Parse extracted values - this depends on the structure in the database
      extractedValues.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          labValues.add(
            LabValue(
              name: value['name'] ?? key,
              value: value['value']?.toString() ?? '',
              unit: value['unit'] ?? '',
              referenceRange: value['referenceRange'],
              isHigh: value['isHigh'] == true,
              isLow: value['isLow'] == true,
            ),
          );
        }
      });

      return labValues;
    } catch (e) {
      return [];
    }
  }
}
