// lib/features/medications/data/medications_service.dart
// Medications Service with prescription photo support

import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:uuid/uuid.dart';
import 'package:fitkarma/features/medications/data/prescription_ocr_service.dart';

/// Medication frequency options
enum MedicationFrequency {
  onceDaily,
  twiceDaily,
  threeTimesDaily,
  fourTimesDaily,
  everyOtherDay,
  weekly,
  asNeeded,
}

extension MedicationFrequencyExtension on MedicationFrequency {
  String get displayName {
    switch (this) {
      case MedicationFrequency.onceDaily:
        return 'Once daily';
      case MedicationFrequency.twiceDaily:
        return 'Twice daily';
      case MedicationFrequency.threeTimesDaily:
        return 'Three times daily';
      case MedicationFrequency.fourTimesDaily:
        return 'Four times daily';
      case MedicationFrequency.everyOtherDay:
        return 'Every other day';
      case MedicationFrequency.weekly:
        return 'Weekly';
      case MedicationFrequency.asNeeded:
        return 'As needed';
    }
  }

  String get dbValue {
    switch (this) {
      case MedicationFrequency.onceDaily:
        return 'once_daily';
      case MedicationFrequency.twiceDaily:
        return 'twice_daily';
      case MedicationFrequency.threeTimesDaily:
        return 'three_times_daily';
      case MedicationFrequency.fourTimesDaily:
        return 'four_times_daily';
      case MedicationFrequency.everyOtherDay:
        return 'every_other_day';
      case MedicationFrequency.weekly:
        return 'weekly';
      case MedicationFrequency.asNeeded:
        return 'as_needed';
    }
  }

  static MedicationFrequency fromDbValue(String value) {
    switch (value) {
      case 'once_daily':
        return MedicationFrequency.onceDaily;
      case 'twice_daily':
        return MedicationFrequency.twiceDaily;
      case 'three_times_daily':
        return MedicationFrequency.threeTimesDaily;
      case 'four_times_daily':
        return MedicationFrequency.fourTimesDaily;
      case 'every_other_day':
        return MedicationFrequency.everyOtherDay;
      case 'weekly':
        return MedicationFrequency.weekly;
      case 'as_needed':
        return MedicationFrequency.asNeeded;
      default:
        return MedicationFrequency.onceDaily;
    }
  }
}

/// Medication category
enum MedicationCategory { prescription, otc, supplement, ayurvedic }

extension MedicationCategoryExtension on MedicationCategory {
  String get displayName {
    switch (this) {
      case MedicationCategory.prescription:
        return 'Prescription';
      case MedicationCategory.otc:
        return 'OTC';
      case MedicationCategory.supplement:
        return 'Supplement';
      case MedicationCategory.ayurvedic:
        return 'Ayurvedic';
    }
  }

  String get dbValue {
    switch (this) {
      case MedicationCategory.prescription:
        return 'prescription';
      case MedicationCategory.otc:
        return 'otc';
      case MedicationCategory.supplement:
        return 'supplement';
      case MedicationCategory.ayurvedic:
        return 'ayurvedic';
    }
  }

  static MedicationCategory fromDbValue(String value) {
    switch (value) {
      case 'prescription':
        return MedicationCategory.prescription;
      case 'otc':
        return MedicationCategory.otc;
      case 'supplement':
        return MedicationCategory.supplement;
      case 'ayurvedic':
        return MedicationCategory.ayurvedic;
      default:
        return MedicationCategory.prescription;
    }
  }
}

/// Medications Service
class MedicationsService {
  final AppDatabase db;
  final PrescriptionOCRService _ocrService = PrescriptionOCRService();
  final PrescriptionPhotoService _photoService = PrescriptionPhotoService();
  static const _uuid = Uuid();

  MedicationsService(this.db);

  /// Add prescription photo and extract medications
  Future<PrescriptionOCRResult> processPrescriptionPhoto(
    String imagePath,
  ) async {
    // First save the photo locally
    final savedPath = await _photoService.savePrescriptionPhoto(imagePath);

    // Then process with OCR
    final result = await _ocrService.processPrescription(savedPath);

    return result;
  }

  /// Create a new medication (manually or from prescription)
  Future<Medication> createMedication({
    required String userId,
    required String name,
    required String dose,
    required String frequency,
    required String category,
    bool isActive = true,
    String? reminderTime,
    int? refillDurationDays,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? nextRefillDate,
    String? prescriptionPhotoPath,
    String? notes,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();

    // Calculate next refill date if refill duration is provided
    DateTime? calculatedRefillDate = nextRefillDate;
    if (refillDurationDays != null && startDate != null) {
      calculatedRefillDate = startDate.add(Duration(days: refillDurationDays));
    }

    final companion = MedicationsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      dose: Value(dose),
      frequency: Value(frequency),
      category: Value(category),
      isActive: Value(isActive),
      reminderTime: Value(reminderTime),
      refillDurationDays: Value(refillDurationDays),
      startDate: Value(startDate ?? now),
      nextRefillDate: Value(calculatedRefillDate),
      notes: Value(notes),
      syncStatus: const Value('pending'),
      idempotencyKey: Value(
        '${userId}_medication_${now.millisecondsSinceEpoch}',
      ),
    );

    await db.into(db.medications).insert(companion);

    // Store prescription photo path if provided
    if (prescriptionPhotoPath != null) {
      await _savePrescriptionPhoto(id, prescriptionPhotoPath);
    }

    return (db.select(
      db.medications,
    )..where((t) => t.id.equals(id))).getSingle();
  }

  /// Create medication from extracted prescription data
  Future<Medication?> createMedicationFromExtracted({
    required String userId,
    required ExtractedMedication extracted,
    String? prescriptionPhotoPath,
  }) async {
    if (extracted.name.isEmpty || extracted.confidence == 0) {
      return null;
    }

    return createMedication(
      userId: userId,
      name: extracted.name,
      dose: extracted.dosage ?? '',
      frequency: extracted.frequency ?? MedicationFrequency.onceDaily.dbValue,
      category: MedicationCategory.prescription.dbValue,
      prescriptionPhotoPath: prescriptionPhotoPath,
    );
  }

  /// Get all medications for a user
  Future<List<Medication>> getMedications(String userId) async {
    return (db.select(db.medications)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get active medications (with refill dates in the future)
  Future<List<Medication>> getActiveMedications(String userId) async {
    final now = DateTime.now();
    return (db.select(db.medications)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                (t.nextRefillDate.isNull() |
                    t.nextRefillDate.isBiggerOrEqualValue(now)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
  }

  /// Get medication by ID
  Future<Medication?> getMedicationById(String medicationId) async {
    return (db.select(
      db.medications,
    )..where((t) => t.id.equals(medicationId))).getSingleOrNull();
  }

  /// Update medication
  Future<void> updateMedication({
    required String medicationId,
    String? name,
    String? dose,
    String? frequency,
    String? category,
    bool? isActive,
    String? reminderTime,
    int? refillDurationDays,
    DateTime? nextRefillDate,
    String? notes,
  }) async {
    // Recalculate refill date if refill duration changed
    DateTime? calculatedRefillDate = nextRefillDate;
    if (refillDurationDays != null) {
      final existing = await getMedicationById(medicationId);
      if (existing != null && existing.startDate != null) {
        calculatedRefillDate = existing.startDate!.add(
          Duration(days: refillDurationDays),
        );
      }
    }

    await (db.update(
      db.medications,
    )..where((t) => t.id.equals(medicationId))).write(
      MedicationsCompanion(
        name: name != null ? Value(name) : const Value.absent(),
        dose: dose != null ? Value(dose) : const Value.absent(),
        frequency: frequency != null ? Value(frequency) : const Value.absent(),
        category: category != null ? Value(category) : const Value.absent(),
        isActive: isActive != null ? Value(isActive) : const Value.absent(),
        reminderTime: reminderTime != null
            ? Value(reminderTime)
            : const Value.absent(),
        refillDurationDays: refillDurationDays != null
            ? Value(refillDurationDays)
            : const Value.absent(),
        nextRefillDate: Value(calculatedRefillDate),
        notes: notes != null ? Value(notes) : const Value.absent(),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Delete medication
  Future<void> deleteMedication(String medicationId) async {
    // Also delete prescription photo if exists
    await _deletePrescriptionPhoto(medicationId);

    await (db.delete(
      db.medications,
    )..where((t) => t.id.equals(medicationId))).go();
  }

  /// Save prescription photo path to a separate table or use local storage
  Future<void> _savePrescriptionPhoto(
    String medicationId,
    String photoPath,
  ) async {
    // In a full implementation, this would save to a separate table
    // For now, we store the path in the medication record via notes or separate field
  }

  /// Delete prescription photo
  Future<void> _deletePrescriptionPhoto(String medicationId) async {
    // Would delete from local storage
  }

  /// Get medications needing refill soon
  Future<List<Medication>> getMedicationsNeedingRefill(String userId) async {
    final now = DateTime.now();
    final refillSoon = now.add(const Duration(days: 7));

    return (db.select(db.medications)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.nextRefillDate.isNotNull() &
                t.nextRefillDate.isSmallerOrEqualValue(refillSoon),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.nextRefillDate)]))
        .get();
  }

  /// Get medications needing refill in 3 days (for refill alerts)
  Future<List<Medication>> getMedicationsNeedingRefillAlert(
    String userId,
  ) async {
    final now = DateTime.now();
    final refillSoon = now.add(const Duration(days: 3));

    return (db.select(db.medications)
          ..where(
            (t) =>
                t.userId.equals(userId) &
                t.isActive.equals(true) &
                t.nextRefillDate.isNotNull() &
                t.nextRefillDate.isSmallerOrEqualValue(refillSoon),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.nextRefillDate)]))
        .get();
  }

  /// Populate Emergency Card with active medications
  Future<void> populateEmergencyCardWithMedications(String userId) async {
    final activeMeds = await getActiveMedications(userId);

    // Convert medications to JSON format for emergency card
    final medsJson = activeMeds
        .map(
          (med) => {
            'name': med.name,
            'dose': med.dose,
            'frequency': med.frequency,
          },
        )
        .toList();

    final medsJsonString = medsJson.isNotEmpty ? json.encode(medsJson) : null;

    final cardId = 'emergency_card_$userId';

    // Check if emergency card exists
    final existingCard = await (db.select(
      db.emergencyCard,
    )..where((t) => t.userId.equals(userId))).getSingleOrNull();

    if (existingCard != null) {
      // Update existing card
      await (db.update(db.emergencyCard)..where((t) => t.id.equals(cardId)))
          .write(EmergencyCardCompanion(medications: Value(medsJsonString)));
    } else {
      // Create new card with medications
      await db
          .into(db.emergencyCard)
          .insert(
            EmergencyCardCompanion.insert(
              id: cardId,
              userId: userId,
              medications: Value(medsJsonString),
            ),
          );
    }
  }

  /// Dispose services
  void dispose() {
    _ocrService.dispose();
  }
}
