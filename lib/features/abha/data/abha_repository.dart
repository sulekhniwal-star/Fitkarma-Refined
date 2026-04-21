import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../core/network/appwrite_client.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../blood_pressure/domain/bp_classifier.dart';
import '../domain/abha_health_record.dart';
import '../../lab_reports/domain/models/extraction_result.dart'; // For LabMarker

class AbhaRepository {
  final AppDatabase db;
  final FlutterSecureStorage secureStorage;
  static const String dataClass = 'abha';

  AbhaRepository({required this.db, required this.secureStorage});

  /// Links ABHA account by exchanging ID+OTP for an OAuth token via Appwrite Function.
  Future<void> linkABHA({
    required String userId,
    required String abhaId,
    required String otp,
  }) async {
    final functions = AppwriteClient.functions;

    final response = await functions.createExecution(
      functionId: 'core-engine',
      body: jsonEncode({
        'action': 'abha-token-exchange',
        'abha_id': abhaId,
        'otp': otp,
      }),
    );

    if (response.status != 'completed') {
      throw Exception('ABHA token exchange failed: ${response.responseBody}');
    }

    final data = jsonDecode(response.responseBody);
    final oauthToken = data['token'];
    final abhaAddress = data['abha_address'];

    // 1. Store OAuth token safely in FlutterSecureStorage
    await secureStorage.write(key: 'abha_token_$userId', value: oauthToken);

    // 2. Encrypt and store metadata in Drift
    final idEnc = await EncryptionService.encryptField(abhaId, dataClass);
    final addrEnc = abhaAddress != null
        ? await EncryptionService.encryptField(abhaAddress, dataClass)
        : null;
    final nowEnc = await EncryptionService.encryptField(
      DateTime.now().toIso8601String(),
      dataClass,
    );

    await db
        .into(db.abhaLinks)
        .insert(
          AbhaLinksCompanion.insert(
            userId: userId,
            abhaIdEncrypted: idEnc,
            abhaAddressEncrypted: addrEnc != null
                ? Value(addrEnc)
                : const Value.absent(),
            linkedAtEncrypted: nowEnc,
            consentGranted: true,
          ),
        );
  }

  /// Fetches health records from ABHA via Appwrite Function.
  Future<List<AbhaHealthRecord>> fetchHealthRecords(String userId) async {
    final functions = AppwriteClient.functions;

    final response = await functions.createExecution(
      functionId: 'core-engine',
      body: jsonEncode({'action': 'abha-fetch-records', 'user_id': userId}),
    );

    if (response.status != 'completed') {
      throw Exception('Failed to fetch ABHA records: ${response.responseBody}');
    }

    final List<dynamic> data = jsonDecode(response.responseBody);
    return data.map((json) => AbhaHealthRecord.fromJson(json)).toList();
  }

  /// High-level method for startup sync.
  Future<int> syncRecentRecords(String userId) async {
    final records = await fetchHealthRecords(userId);
    int importedCount = 0;

    // Filter for unimported records (in a real app, track sync timestamps)
    final newRecords = records.where((r) => !r.isImported).toList();

    for (final record in newRecords) {
      try {
        await importHealthRecord(userId, record);
        importedCount++;
      } catch (e) {
        // Log individual import failures but continue
        print('Failed to auto-import ABHA record ${record.id}: $e');
      }
    }

    if (importedCount > 0) {
      // Update last sync time
      final nowEnc = await EncryptionService.encryptField(
        DateTime.now().toIso8601String(),
        dataClass,
      );
      await (db.update(db.abhaLinks)..where((t) => t.userId.equals(userId)))
          .write(AbhaLinksCompanion(lastSyncEncrypted: Value(nowEnc)));
    }

    return importedCount;
  }

  /// Maps an ABHA record to the local health log tables.
  Future<void> importHealthRecord(
    String userId,
    AbhaHealthRecord record,
  ) async {
    switch (record.type) {
      case AbhaRecordType.bloodPressure:
        await _importBloodPressure(userId, record);
        break;
      case AbhaRecordType.glucose:
        await _importGlucose(userId, record);
        break;
      case AbhaRecordType.labReport:
        await _importLabReport(userId, record);
        break;
      default:
        // Prescription is just viewable, not auto-loggable yet
        break;
    }
  }

  Future<void> _importBloodPressure(
    String userId,
    AbhaHealthRecord record,
  ) async {
    final sys = record.rawData['systolic'] as double?;
    final dia = record.rawData['diastolic'] as double?;
    final pulse = record.rawData['pulse'] as double?;

    if (sys != null && dia != null) {
      final sysEnc = await EncryptionService.encryptField(
        sys.toString(),
        'bp_glucose',
      );
      final diaEnc = await EncryptionService.encryptField(
        dia.toString(),
        'bp_glucose',
      );
      final pulseEnc = pulse != null
          ? await EncryptionService.encryptField(pulse.toString(), 'bp_glucose')
          : null;

      final classification = BPClassifier.classify(
        sys!.toInt(),
        dia!.toInt(),
      ).name;
      await db
          .into(db.bloodPressureLogs)
          .insert(
            BloodPressureLogsCompanion.insert(
              userId: userId,
              systolic: sysEnc,
              diastolic: diaEnc,
              pulse: pulseEnc != null ? Value(pulseEnc) : const Value.absent(),
              loggedAt: record.date,
              classification: classification,
              source: 'abha',
              idempotencyKey: '${userId}_bp_${record.date.toIso8601String()}',
            ),
          );
    }
  }

  Future<void> _importGlucose(String userId, AbhaHealthRecord record) async {
    final value = record.rawData['value'] as double?;
    final type = record.rawData['type'] as String? ?? 'fasting';

    if (value != null) {
      final valEnc = await EncryptionService.encryptField(
        value.toString(),
        'bp_glucose',
      );

      String classification;
      if (type.toLowerCase().contains('fasting')) {
        if (value < 70) {
          classification = 'low';
        } else if (value <= 100) {
          classification = 'normal';
        } else if (value <= 125) {
          classification = 'prediabetic';
        } else {
          classification = 'diabetic';
        }
      } else {
        if (value < 70) {
          classification = 'low';
        } else if (value <= 140) {
          classification = 'normal';
        } else if (value <= 180) {
          classification = 'prediabetic';
        } else {
          classification = 'diabetic';
        }
      }

      await db
          .into(db.glucoseLogs)
          .insert(
            GlucoseLogsCompanion.insert(
              userId: userId,
              glucoseMgdl: valEnc,
              readingType: type,
              loggedAt: record.date,
              classification: classification,
              source: 'abha',
              idempotencyKey:
                  '${userId}_glucose_${record.date.toIso8601String()}',
            ),
          );
    }
  }

  Future<void> _importLabReport(String userId, AbhaHealthRecord record) async {
    // Lab reports from ABHA are imported as a summary in the LabReports table
    final metrics = Map<String, dynamic>.from(record.rawData['metrics'] ?? {});

    await db
        .into(db.labReports)
        .insert(
          LabReportsCompanion.insert(
            userId: userId,
            reportDate: record.date,
            labName: Value(record.source),
            extractedValues: jsonEncode(metrics),
            confirmedByUser: const Value(true), // ABHA records are pre-verified
            source: 'abha',
            importedMetrics: Value(jsonEncode(metrics.keys.toList())),
          ),
        );
  }

  /// Fetches Linked ABHA metadata.
  Future<AbhaLinkData?> getLink(String userId) async {
    final link = await (db.select(
      db.abhaLinks,
    )..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (link == null) return null;

    final id = await EncryptionService.decryptField(
      link.abhaIdEncrypted,
      dataClass,
    );
    final addr = link.abhaAddressEncrypted != null
        ? await EncryptionService.decryptField(
            link.abhaAddressEncrypted!,
            dataClass,
          )
        : null;
    final date = await EncryptionService.decryptField(
      link.linkedAtEncrypted,
      dataClass,
    );
    final lastSyncStr = link.lastSyncEncrypted != null
        ? await EncryptionService.decryptField(
            link.lastSyncEncrypted!,
            dataClass,
          )
        : null;

    return AbhaLinkData(
      id: id,
      address: addr,
      linkedAt: DateTime.parse(date),
      lastSync: lastSyncStr != null ? DateTime.parse(lastSyncStr) : null,
    );
  }
}

class AbhaLinkData {
  final String id;
  final String? address;
  final DateTime linkedAt;
  final DateTime? lastSync;

  AbhaLinkData({
    required this.id,
    this.address,
    required this.linkedAt,
    this.lastSync,
  });
}

final abhaRepositoryProvider = Provider<AbhaRepository>((ref) {
  return AbhaRepository(
    db: DriftService.db,
    secureStorage: const FlutterSecureStorage(),
  );
});

final abhaStatusProvider = FutureProvider<AbhaLinkData?>((ref) async {
  final repo = ref.watch(abhaRepositoryProvider);
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id;
  if (userId == null) return null;
  return repo.getLink(userId);
});

final abhaRecordsProvider = FutureProvider.autoDispose<List<AbhaHealthRecord>>((
  ref,
) async {
  final repo = ref.watch(abhaRepositoryProvider);
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id;
  if (userId == null) return [];
  return repo.fetchHealthRecords(userId);
});
