import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/network/sync_queue.dart';
import '../../../core/constants/api_endpoints.dart';
import '../../auth/data/auth_repository.dart';
import '../../karma/data/karma_service.dart';

part 'health_repository.g.dart';

class HealthRepository {
  final AppDatabase _db;
  final Ref _ref;

  HealthRepository(this._db, this._ref);
  
  Future<Map<String, String>> extractMetricsFromLabReport(String ocrText) async {
    try {
      final functions = _ref.read(functionsProvider);
      final execution = await functions.createExecution(
        functionId: AW.fnLabReportExtractor,
        body: ocrText,
      );
      
      if (execution.status == 'completed') {
        final decoded = jsonDecode(execution.responseBody);
        if (decoded is Map) {
          return decoded.map((k, v) => MapEntry(k.toString(), v.toString()));
        }
      }
      return {};
    } catch (e) {
      return {};
    }
  }

  Future<void> saveLabReport({
    required String title,
    required DateTime date,
    String? labsName,
    Map<String, String>? metrics,
    String? fileUrl,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = _ref.read(encryptionServiceProvider('health'));
    
    // Encrypt extracted values
    final jsonMetrics = metrics != null ? jsonEncode(metrics) : null;
    final encryptedMetrics = jsonMetrics != null ? await encryption.encrypt(jsonMetrics) : null;

    final companion = LabReportsCompanion.insert(
      id: id,
      userId: user.$id,
      reportTitle: title,
      reportDate: date,
      labsName: Value(labsName),
      extractedValues: Value(encryptedMetrics),
      fileUrl: Value(fileUrl),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.labReports).insert(companion);

    // Sync to Appwrite
    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.labReports,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'reportTitle': title,
        'reportDate': date.toIso8601String(),
        'labsName': labsName,
        'extractedValues': encryptedMetrics,
        'fileUrl': fileUrl,
      },
      priority: SyncPriority.normal,
    );

    // If metrics contain glucose, save it to glucose logs as well
    if (metrics != null) {
      if (metrics.containsKey('Blood Glucose')) {
        final val = double.tryParse(metrics['Blood Glucose']!);
        if (val != null) {
          await saveGlucoseLog(
            valueMgDl: val,
            testType: 'random',
            notes: 'Extracted from lab report: $title',
            date: date,
          );
        }
      }
      // Add other metrics mapping here (Hb, Cholesterol etc. could be saved to a different tracker if implemented)
    }

    // Award XP
    await _ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.labReport);
  }

  Future<void> saveBloodPressureLog({
    required int systolic,
    required int diastolic,
    int? pulse,
    required String classification,
    String? notes,
    DateTime? date,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = _ref.read(encryptionServiceProvider('bp'));
    final encryptedNotes = notes != null ? await encryption.encrypt(notes) : null;

    final companion = BloodPressureLogsCompanion.insert(
      id: id,
      userId: user.$id,
      systolic: systolic,
      diastolic: diastolic,
      pulse: Value(pulse),
      classification: classification,
      notes: Value(encryptedNotes),
      loggedAt: date ?? DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.bloodPressureLogs).insert(companion);

    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.bloodPressureLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'systolic': systolic,
        'diastolic': diastolic,
        'pulse': pulse,
        'classification': classification,
        'notes': encryptedNotes,
        'loggedAt': (date ?? DateTime.now()).toIso8601String(),
      },
      priority: systolic >= 180 || diastolic >= 120 ? SyncPriority.critical : SyncPriority.normal,
    );

    await _ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.bpLog);
  }

  Future<void> saveGlucoseLog({
    required double valueMgDl,
    required String testType,
    String? notes,
    DateTime? date,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = _ref.read(encryptionServiceProvider('glucose'));
    final encryptedNotes = notes != null ? await encryption.encrypt(notes) : null;

    final companion = GlucoseLogsCompanion.insert(
      id: id,
      userId: user.$id,
      valueMgDl: valueMgDl,
      testType: testType,
      notes: Value(encryptedNotes),
      loggedAt: date ?? DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.glucoseLogs).insert(companion);

    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.glucoseLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'valueMgDl': valueMgDl,
        'testType': testType,
        'notes': encryptedNotes,
        'loggedAt': (date ?? DateTime.now()).toIso8601String(),
      },
      priority: SyncPriority.normal,
    );

    await _ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.glucoseLog);
  }

  Future<void> saveSpo2Log({
    required int valuePercent,
    DateTime? date,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();

    final companion = Spo2LogsCompanion.insert(
      id: id,
      userId: user.$id,
      valuePercent: valuePercent,
      loggedAt: date ?? DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.spo2Logs).insert(companion);

    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.spo2Logs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'valuePercent': valuePercent,
        'loggedAt': (date ?? DateTime.now()).toIso8601String(),
      },
      priority: valuePercent < 95 ? SyncPriority.high : SyncPriority.normal,
    );
  }

  Future<void> saveWaterIntake(double glasses) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final companion = WaterLogsCompanion.insert(
      id: id,
      userId: user.$id,
      amountGlasses: glasses,
      loggedAt: DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.waterLogs).insert(companion);

    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.waterLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'amountGlasses': glasses,
        'loggedAt': DateTime.now().toIso8601String(),
      },
      priority: SyncPriority.normal,
    );
    
    // Check if daily goal reached (e.g., 8 glasses) to grant XP
    final todayWater = await _db.waterLogsDao.getTodayWater(user.$id);
    if (todayWater >= 8.0) {
      await _ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.waterGoal);
    }
  }

  Future<void> savePeriodLog({
    required DateTime startDate,
    DateTime? endDate,
    String? flowIntensity,
    List<String>? symptoms,
    String? notes,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = _ref.read(encryptionServiceProvider('period'));
    
    final encryptedSymptoms = symptoms != null ? await encryption.encrypt(jsonEncode(symptoms)) : null;
    final encryptedNotes = notes != null ? await encryption.encrypt(notes) : null;

    final companion = PeriodLogsCompanion.insert(
      id: id,
      userId: user.$id,
      startDate: startDate,
      endDate: Value(endDate),
      flowIntensity: Value(flowIntensity),
      symptoms: Value(encryptedSymptoms),
      notes: Value(encryptedNotes),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.periodLogs).insert(companion);

    // Sync is opt-in normally, but here we follow sync queue if user has it enabled (handled by sync queue globally)
    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.periodLogs,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate?.toIso8601String(),
        'flowIntensity': flowIntensity,
        'symptoms': encryptedSymptoms,
        'notes': encryptedNotes,
      },
      priority: SyncPriority.normal,
    );

    await _ref.read(karmaServiceProvider.notifier).grantXP(KarmaAction.periodLog);
  }

  Future<void> saveAppointment({
    required String doctorName,
    String? specialty,
    DateTime? date,
    String? location,
    String? reason,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final encryption = _ref.read(encryptionServiceProvider('appointment'));
    final encryptedReason = reason != null ? await encryption.encrypt(reason) : null;

    final companion = DoctorAppointmentsCompanion.insert(
      id: id,
      userId: user.$id,
      doctorName: doctorName,
      specialty: Value(specialty),
      location: Value(location),
      reason: Value(encryptedReason),
      appointmentDate: date ?? DateTime.now().add(const Duration(days: 1)),
      isCompleted: const Value(false),
      syncStatus: const Value('pending'),
    );

    await _db.into(_db.doctorAppointments).insert(companion);

    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.doctorAppointments,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'doctorName': doctorName,
        'specialty': specialty,
        'location': location,
        'reason': encryptedReason,
        'appointmentDate': (date ?? DateTime.now().add(const Duration(days: 1))).toIso8601String(),
        'isCompleted': false,
      },
      priority: SyncPriority.normal,
    );
  }

  Future<void> linkAbha({
    required String abhaAddress,
    String? abhaNumber,
    bool isVerified = true,
  }) async {
    final user = _ref.read(currentUserProvider).asData?.value;
    if (user == null) return;

    final id = const Uuid().v4();
    final companion = AbhaLinksCompanion.insert(
      id: id,
      userId: user.$id,
      abhaAddress: abhaAddress,
      abhaNumber: Value(abhaNumber),
      isVerified: Value(isVerified),
      linkedAt: DateTime.now(),
    );

    await _db.into(_db.abhaLinks).insert(companion);
    
    // Note: ABHA link data might be sensitive and not synced to general collection 
    // depending on privacy requirements, but here we follow standard sync pattern
    await _ref.read(syncQueueRepositoryProvider.notifier).addToQueue(
      collectionId: AW.abhaLinks,
      operation: 'create',
      localId: id,
      payload: {
        'userId': user.$id,
        'abhaAddress': abhaAddress,
        'abhaNumber': abhaNumber,
        'isVerified': isVerified,
        'linkedAt': DateTime.now().toIso8601String(),
      },
      priority: SyncPriority.normal,
    );
  }
}

@riverpod
HealthRepository healthRepository(Ref ref) {
  return HealthRepository(ref.watch(databaseProvider), ref);
}
