import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../auth/domain/auth_providers.dart';
import '../../../core/network/appwrite_client.dart';
import '../../../core/security/encryption_service.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    final nowEnc = await EncryptionService.encryptField(DateTime.now().toIso8601String(), dataClass);

    await db.into(db.abhaLinks).insert(
          AbhaLinksCompanion.insert(
            userId: userId,
            abhaIdEncrypted: idEnc,
            abhaAddressEncrypted: addrEnc != null ? Value(addrEnc) : const Value.absent(),
            linkedAtEncrypted: nowEnc,
            consentGranted: true,
          ),
        );
  }

  /// Fetches Linked ABHA metadata.
  Future<AbhaLinkData?> getLink(String userId) async {
    final link = await (db.select(db.abhaLinks)..where((t) => t.userId.equals(userId))).getSingleOrNull();
    if (link == null) return null;

    final id = await EncryptionService.decryptField(link.abhaIdEncrypted, dataClass);
    final addr = link.abhaAddressEncrypted != null 
        ? await EncryptionService.decryptField(link.abhaAddressEncrypted!, dataClass)
        : null;
    final date = await EncryptionService.decryptField(link.linkedAtEncrypted, dataClass);
    final lastSyncStr = link.lastSyncEncrypted != null 
        ? await EncryptionService.decryptField(link.lastSyncEncrypted!, dataClass)
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

  AbhaLinkData({required this.id, this.address, required this.linkedAt, this.lastSync});
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
