import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables_db.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

class HealthRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  HealthRepository(this._db, this._tables);

  Future<void> pushBpToRemote(String localId) async {
    try {
      final reading = await (_db.select(_db.bpReadings)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.bpReadingsCol,
        rowId: reading.id,
        data: {
          'userId': reading.userId,
          'systolic': reading.systolic,
          'diastolic': reading.diastolic,
          'pulse': reading.pulse,
          'measuredAt': reading.measuredAt.toIso8601String(),
          'notes': reading.notes,
          'classification': reading.classification,
        },
      );

      await _db.markSynced(localId, reading.id, 'bp_readings');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'bp_readings');
      rethrow;
    }
  }

  Future<void> pushGlucoseToRemote(String localId) async {
    try {
      final reading = await (_db.select(_db.glucoseReadings)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.glucoseReadingsCol,
        rowId: reading.id,
        data: {
          'userId': reading.userId,
          'valueMgDl': reading.valueMgDl,
          'readingType': reading.readingType,
          'measuredAt': reading.measuredAt.toIso8601String(),
          'classification': reading.classification,
          'linkedFoodLogId': reading.linkedFoodLogId,
        },
      );

      await _db.markSynced(localId, reading.id, 'glucose_readings');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'glucose_readings');
      rethrow;
    }
  }

  Future<void> pushSleepToRemote(String localId) async {
    try {
      final log = await (_db.select(_db.sleepLogs)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.sleepLogsCol,
        rowId: log.id,
        data: {
          'userId': log.userId,
          'sleepStart': log.sleepStart.toIso8601String(),
          'sleepEnd': log.sleepEnd.toIso8601String(),
          'durationMinutes': log.durationMinutes,
          'qualityScore': log.qualityScore,
          'source': log.source,
        },
      );

      await _db.markSynced(localId, log.id, 'sleep_logs');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'sleep_logs');
      rethrow;
    }
  }

  Future<void> pushSpo2ToRemote(String localId) async {
    try {
      final reading = await (_db.select(_db.spo2Readings)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.spo2ReadingsCol,
        rowId: reading.id,
        data: {
          'userId': reading.userId,
          'spo2Percentage': reading.spo2Percentage,
          'pulse': reading.pulse,
          'measuredAt': reading.measuredAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, reading.id, 'spo2_readings');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'spo2_readings');
      rethrow;
    }
  }

  Future<void> pushStepsToRemote(String localId) async {
    try {
      final log = await (_db.select(_db.stepCounts)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.stepLogsCol,
        rowId: log.id,
        data: {
          'userId': log.userId,
          'count': log.count,
          'date': log.date.toIso8601String(),
        },
      );

      await _db.markSynced(localId, log.id, 'step_logs');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'step_logs');
      rethrow;
    }
  }

  Future<void> pushWeightToRemote(String localId) async {
    try {
      final log = await (_db.select(_db.weightLogs)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.weightLogsCol,
        rowId: log.id,
        data: {
          'userId': log.userId,
          'weightKg': log.weightKg,
          'measuredAt': log.measuredAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, log.id, 'weight_logs');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'weight_logs');
      rethrow;
    }
  }
}

final healthRepositoryProvider = Provider<HealthRepository>((ref) {
  return HealthRepository(
    ref.read(appDatabaseProvider),
    ref.read(appwriteTablesDBProvider),
  );
});
