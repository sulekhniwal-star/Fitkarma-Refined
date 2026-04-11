import 'package:drift/drift.dart';
import '../storage/app_database.dart';
import '../security/encryption_service.dart';

extension JournalEncryption on JournalEntriesCompanion {
  Future<JournalEntriesCompanion> encryptFields(EncryptionService service) async {
    final encryptedContent = await service.encrypt(content.value);
    return copyWith(content: Value(encryptedContent));
  }
}

extension DoctorAppointmentEncryption on DoctorAppointmentsCompanion {
  Future<DoctorAppointmentsCompanion> encryptFields(EncryptionService service) async {
    String? encryptedReason;
    if (reason.value != null) {
      encryptedReason = await service.encrypt(reason.value!);
    }
    return copyWith(reason: Value(encryptedReason));
  }
}

extension AbhaLinkEncryption on AbhaLinksCompanion {
  Future<AbhaLinksCompanion> encryptFields(EncryptionService service) async {
    final encryptedAddress = await service.encrypt(abhaAddress.value);
    String? encryptedNumber;
    if (abhaNumber.value != null) {
      encryptedNumber = await service.encrypt(abhaNumber.value!);
    }
    return copyWith(
      abhaAddress: Value(encryptedAddress),
      abhaNumber: Value(encryptedNumber),
    );
  }
}

extension LabReportEncryption on LabReportsCompanion {
  Future<LabReportsCompanion> encryptFields(EncryptionService service) async {
    String? encryptedValues;
    if (extractedValues.value != null) {
      encryptedValues = await service.encrypt(extractedValues.value!);
    }
    return copyWith(extractedValues: Value(encryptedValues));
  }
}
