import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables_db.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

class ReportsRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  ReportsRepository(this._db, this._tables);

  Future<void> pushReportToRemote(String localId) async {
    try {
      final report = await (_db.select(_db.labReports)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.labReportsCol,
        rowId: report.id,
        data: {
          'userId': report.userId,
          'fileName': report.fileName,
          'fileId': report.fileId,
          'reportType': report.reportType,
          'extractedDataJson': report.extractedDataJson,
          'reportDate': report.reportDate?.toIso8601String(),
          'createdAt': report.createdAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, report.id, 'lab_reports');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'lab_reports');
      rethrow;
    }
  }
}

final reportsRepositoryProvider = Provider<ReportsRepository>((ref) {
  return ReportsRepository(
    ref.read(appDatabaseProvider),
    ref.read(appwriteTablesDBProvider),
  );
});
