// lib/features/emergency_card/data/emergency_card_service.dart
// Service for managing Emergency Card data in local database
// Data is stored locally only - no cloud sync

import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:fitkarma/core/storage/drift_database.dart';

/// Service for managing Emergency Card data locally
class EmergencyCardService {
  final AppDatabase db;

  EmergencyCardService(this.db);

  /// Get emergency card for a user
  Future<EmergencyCardData?> getEmergencyCard(String userId) async {
    final cardId = 'emergency_card_$userId';
    return await (db.select(
      db.emergencyCard,
    )..where((t) => t.id.equals(cardId))).getSingleOrNull();
  }

  /// Save or update emergency card
  Future<void> saveEmergencyCard({
    required String userId,
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? emergencyContact,
    List<Map<String, String>>? medications,
  }) async {
    final cardId = 'emergency_card_$userId';
    final medicationsJson = medications != null
        ? json.encode(medications)
        : null;

    // Check if card exists
    final existingCard = await getEmergencyCard(userId);

    if (existingCard != null) {
      // Update existing card
      await (db.update(
        db.emergencyCard,
      )..where((t) => t.id.equals(cardId))).write(
        EmergencyCardCompanion(
          bloodGroup: Value(bloodGroup),
          allergies: Value(allergies),
          chronicConditions: Value(chronicConditions),
          emergencyContact: Value(emergencyContact),
          medications: Value(medicationsJson),
        ),
      );
    } else {
      // Insert new card
      await db
          .into(db.emergencyCard)
          .insert(
            EmergencyCardCompanion.insert(
              id: cardId,
              userId: userId,
              bloodGroup: Value(bloodGroup),
              allergies: Value(allergies),
              chronicConditions: Value(chronicConditions),
              emergencyContact: Value(emergencyContact),
              medications: Value(medicationsJson),
            ),
          );
    }
  }

  /// Delete emergency card
  Future<void> deleteEmergencyCard(String userId) async {
    final cardId = 'emergency_card_$userId';
    await (db.delete(db.emergencyCard)..where((t) => t.id.equals(cardId))).go();
  }

  /// Parse medications JSON to list
  List<Map<String, String>> parseMedications(String? medicationsJson) {
    if (medicationsJson == null || medicationsJson.isEmpty) {
      return [];
    }
    try {
      final List<dynamic> decoded = json.decode(medicationsJson);
      return decoded.map((e) => Map<String, String>.from(e)).toList();
    } catch (e) {
      return [];
    }
  }
}

/// Blood group options
class BloodGroups {
  static const List<String> values = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
    'Unknown',
  ];
}
