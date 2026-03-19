import 'package:drift/drift.dart';
import 'package:fitkarma/core/security/encryption_service.dart';

/// Encrypted text converter for journal entries and sensitive text.
/// Uses per-data-class encryption via HKDF.
class EncryptedTextConverter extends TypeConverter<String?, String?> {
  final EncryptionDataClass dataClass;

  const EncryptedTextConverter({required this.dataClass});

  @override
  String? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      return EncryptionService.instance.decryptDataClass(fromDb, dataClass);
    } catch (e) {
      return '[DECRYPT ERROR]';
    }
  }

  @override
  String? toSql(String? value) {
    if (value == null) return null;
    return EncryptionService.instance.encryptDataClass(value, dataClass);
  }
}

/// Encrypted integer converter for BP, pulse, and other integer values.
/// Uses per-data-class encryption via HKDF.
class EncryptedIntConverter extends TypeConverter<int?, String?> {
  final EncryptionDataClass dataClass;

  const EncryptedIntConverter({required this.dataClass});

  @override
  int? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      final decrypted = EncryptionService.instance.decryptDataClass(
        fromDb,
        dataClass,
      );
      return int.tryParse(decrypted);
    } catch (e) {
      return -1;
    }
  }

  @override
  String? toSql(int? value) {
    if (value == null) return null;
    return EncryptionService.instance.encryptDataClass(
      value.toString(),
      dataClass,
    );
  }
}

/// Encrypted double converter for glucose, SpO2, and other decimal values.
/// Uses per-data-class encryption via HKDF.
class EncryptedDoubleConverter extends TypeConverter<double?, String?> {
  final EncryptionDataClass dataClass;

  const EncryptedDoubleConverter({required this.dataClass});

  @override
  double? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      final decrypted = EncryptionService.instance.decryptDataClass(
        fromDb,
        dataClass,
      );
      return double.tryParse(decrypted);
    } catch (e) {
      return -1.0;
    }
  }

  @override
  String? toSql(double? value) {
    if (value == null) return null;
    return EncryptionService.instance.encryptDataClass(
      value.toString(),
      dataClass,
    );
  }
}

// =============================================================================
// Pre-defined converters for each data class
// =============================================================================

/// BP (Blood Pressure) data class converters.
/// Used for: blood_pressure_logs, blood_glucose_logs, spo2_logs
class BpDataClassConverters {
  static const text = EncryptedTextConverter(dataClass: EncryptionDataClass.bp);
  static const intConverter = EncryptedIntConverter(
    dataClass: EncryptionDataClass.bp,
  );
  static const doubleConverter = EncryptedDoubleConverter(
    dataClass: EncryptionDataClass.bp,
  );
}

/// Period/Menstrual data class converters.
/// Used for: period_logs
class PeriodDataClassConverters {
  static const text = EncryptedTextConverter(
    dataClass: EncryptionDataClass.period,
  );
  static const intConverter = EncryptedIntConverter(
    dataClass: EncryptionDataClass.period,
  );
  static const doubleConverter = EncryptedDoubleConverter(
    dataClass: EncryptionDataClass.period,
  );
}

/// Journal data class converters.
/// Used for: journal_entries
class JournalDataClassConverters {
  static const text = EncryptedTextConverter(
    dataClass: EncryptionDataClass.journal,
  );
  static const intConverter = EncryptedIntConverter(
    dataClass: EncryptionDataClass.journal,
  );
  static const doubleConverter = EncryptedDoubleConverter(
    dataClass: EncryptionDataClass.journal,
  );
}

/// Appointments data class converters.
/// Used for: doctor_appointments
class AppointmentsDataClassConverters {
  static const text = EncryptedTextConverter(
    dataClass: EncryptionDataClass.appointments,
  );
  static const intConverter = EncryptedIntConverter(
    dataClass: EncryptionDataClass.appointments,
  );
  static const doubleConverter = EncryptedDoubleConverter(
    dataClass: EncryptionDataClass.appointments,
  );
}

/// Lab Reports data class converters.
/// Used for: lab_reports
class LabReportsDataClassConverters {
  static const text = EncryptedTextConverter(
    dataClass: EncryptionDataClass.labReports,
  );
  static const intConverter = EncryptedIntConverter(
    dataClass: EncryptionDataClass.labReports,
  );
  static const doubleConverter = EncryptedDoubleConverter(
    dataClass: EncryptionDataClass.labReports,
  );
}

// =============================================================================
// Legacy converters for backward compatibility (uses master key)
// =============================================================================

/// Legacy encrypted text converter - uses master key.
/// Deprecated: Use data class specific converters instead.
class EncryptedTextConverterLegacy extends TypeConverter<String?, String?> {
  const EncryptedTextConverterLegacy();

  @override
  String? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      return EncryptionService.instance.decrypt(fromDb);
    } catch (e) {
      return '[DECRYPT ERROR]';
    }
  }

  @override
  String? toSql(String? value) {
    if (value == null) return null;
    return EncryptionService.instance.encrypt(value);
  }
}

/// Legacy encrypted integer converter - uses master key.
/// Deprecated: Use data class specific converters instead.
class EncryptedIntConverterLegacy extends TypeConverter<int?, String?> {
  const EncryptedIntConverterLegacy();

  @override
  int? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      final decrypted = EncryptionService.instance.decrypt(fromDb);
      return int.tryParse(decrypted);
    } catch (e) {
      return -1;
    }
  }

  @override
  String? toSql(int? value) {
    if (value == null) return null;
    return EncryptionService.instance.encrypt(value.toString());
  }
}

/// Legacy encrypted double converter - uses master key.
/// Deprecated: Use data class specific converters instead.
class EncryptedDoubleConverterLegacy extends TypeConverter<double?, String?> {
  const EncryptedDoubleConverterLegacy();

  @override
  double? fromSql(String? fromDb) {
    if (fromDb == null) return null;
    try {
      final decrypted = EncryptionService.instance.decrypt(fromDb);
      return double.tryParse(decrypted);
    } catch (e) {
      return -1.0;
    }
  }

  @override
  String? toSql(double? value) {
    if (value == null) return null;
    return EncryptionService.instance.encrypt(value.toString());
  }
}
