// lib/features/reports/data/report_storage_service.dart
// Local file storage service for PDF reports

import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// Local storage service for PDF reports
class ReportStorageService {
  static final ReportStorageService _instance =
      ReportStorageService._internal();
  factory ReportStorageService() => _instance;
  ReportStorageService._internal();

  String? _reportsDirectory;

  /// Get or create the reports directory
  Future<String> get reportsDirectory async {
    if (_reportsDirectory != null) return _reportsDirectory!;

    final appDir = await getApplicationDocumentsDirectory();
    final reportsDir = Directory(path.join(appDir.path, 'health_reports'));

    if (!await reportsDir.exists()) {
      await reportsDir.create(recursive: true);
    }

    _reportsDirectory = reportsDir.path;
    return _reportsDirectory!;
  }

  /// Save PDF report to local storage
  Future<String> savePdfReport(Uint8List pdfBytes, String fileName) async {
    final dir = await reportsDirectory;
    final filePath = path.join(dir, fileName);
    final file = File(filePath);
    await file.writeAsBytes(pdfBytes);
    return filePath;
  }

  /// Get list of saved report files
  Future<List<ReportFileInfo>> getSavedReports() async {
    final dir = await reportsDirectory;
    final reportsDir = Directory(dir);

    if (!await reportsDir.exists()) {
      return [];
    }

    final files = await reportsDir.list().toList();
    final reports = <ReportFileInfo>[];

    for (var entity in files) {
      if (entity is File && entity.path.endsWith('.pdf')) {
        final stat = await entity.stat();
        final fileName = path.basename(entity.path);

        // Parse filename to get date and period
        // Format: health_report_weekly_2024-01-01_2024-01-07.pdf
        final nameWithoutExt = fileName.replaceAll('.pdf', '');
        final parts = nameWithoutExt.split('_');
        final period = parts.length >= 3 ? parts[2] : 'unknown';
        final dateStr = parts.length >= 5 ? '${parts[3]}_${parts[4]}' : '';

        reports.add(
          ReportFileInfo(
            filePath: entity.path,
            fileName: fileName,
            createdAt: stat.modified,
            period: period,
            dateRange: dateStr,
          ),
        );
      }
    }

    // Sort by date, newest first
    reports.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return reports;
  }

  /// Read PDF bytes from file
  Future<Uint8List?> readPdfReport(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.readAsBytes();
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  /// Delete a PDF report
  Future<bool> deletePdfReport(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
    } catch (e) {
      // Handle error
    }
    return false;
  }

  /// Delete old reports (older than specified days)
  Future<int> deleteOldReports({int olderThanDays = 90}) async {
    final dir = await reportsDirectory;
    final reportsDir = Directory(dir);
    final cutoffDate = DateTime.now().subtract(Duration(days: olderThanDays));

    int deletedCount = 0;
    if (await reportsDir.exists()) {
      final files = await reportsDir.list().toList();
      for (var entity in files) {
        if (entity is File) {
          final stat = await entity.stat();
          if (stat.modified.isBefore(cutoffDate)) {
            await entity.delete();
            deletedCount++;
          }
        }
      }
    }
    return deletedCount;
  }

  /// Generate a unique filename for a report
  String generateFileName({
    required String userId,
    required String period,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final startStr =
        '${startDate.year}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}';
    final endStr =
        '${endDate.year}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}';
    return 'health_report_${period}_${startStr}_${endStr}_$userId.pdf';
  }
}

/// Information about a saved report file
class ReportFileInfo {
  final String filePath;
  final String fileName;
  final DateTime createdAt;
  final String period;
  final String dateRange;

  ReportFileInfo({
    required this.filePath,
    required this.fileName,
    required this.createdAt,
    required this.period,
    required this.dateRange,
  });
}
