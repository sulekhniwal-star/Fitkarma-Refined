// lib/features/emergency_card/data/emergency_card_providers.dart
// Riverpod providers for Emergency Card feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/core/storage/drift_service.dart';
import 'package:fitkarma/features/emergency_card/data/emergency_card_service.dart';
import 'package:fitkarma/features/auth/data/auth_aw_service.dart';

/// Provider for database via DriftService
final emergencyCardDatabaseProvider = Provider<AppDatabase>((ref) {
  final driftService = ref.watch(driftServiceProvider);
  return driftService.db;
});

/// Provider for user ID
final emergencyCardUserIdProvider = FutureProvider<String>((ref) async {
  final authService = AuthAwService();
  final userId = await authService.getStoredUserId();
  if (userId == null) {
    throw Exception('User not logged in');
  }
  return userId;
});

/// Provider for Emergency Card service
final emergencyCardServiceProvider = Provider<EmergencyCardService>((ref) {
  final db = ref.watch(emergencyCardDatabaseProvider);
  return EmergencyCardService(db);
});

/// State for Emergency Card
class EmergencyCardState {
  final String? bloodGroup;
  final String? allergies;
  final String? chronicConditions;
  final String? emergencyContact;
  final List<Map<String, String>> medications;
  final bool isLoading;
  final String? error;
  final bool isSaving;

  EmergencyCardState({
    this.bloodGroup,
    this.allergies,
    this.chronicConditions,
    this.emergencyContact,
    this.medications = const [],
    this.isLoading = false,
    this.error,
    this.isSaving = false,
  });

  EmergencyCardState copyWith({
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? emergencyContact,
    List<Map<String, String>>? medications,
    bool? isLoading,
    String? error,
    bool? isSaving,
  }) {
    return EmergencyCardState(
      bloodGroup: bloodGroup ?? this.bloodGroup,
      allergies: allergies ?? this.allergies,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      medications: medications ?? this.medications,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  /// Check if the card has any data
  bool get hasData =>
      bloodGroup != null ||
      allergies != null ||
      chronicConditions != null ||
      emergencyContact != null ||
      medications.isNotEmpty;
}

/// Notifier for Emergency Card state
class EmergencyCardNotifier extends Notifier<EmergencyCardState> {
  @override
  EmergencyCardState build() {
    loadEmergencyCard();
    return EmergencyCardState();
  }

  /// Load emergency card from database
  Future<void> loadEmergencyCard() async {
    state = state.copyWith(isLoading: true);
    try {
      final service = ref.read(emergencyCardServiceProvider);
      final userId = await ref.read(emergencyCardUserIdProvider.future);
      final card = await service.getEmergencyCard(userId);

      if (card != null) {
        state = state.copyWith(
          bloodGroup: card.bloodGroup,
          allergies: card.allergies,
          chronicConditions: card.chronicConditions,
          emergencyContact: card.emergencyContact,
          medications: service.parseMedications(card.medications),
          isLoading: false,
        );
      } else {
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Save emergency card to database
  Future<void> saveEmergencyCard({
    String? bloodGroup,
    String? allergies,
    String? chronicConditions,
    String? emergencyContact,
    List<Map<String, String>>? medications,
  }) async {
    state = state.copyWith(isSaving: true);
    try {
      final service = ref.read(emergencyCardServiceProvider);
      final userId = await ref.read(emergencyCardUserIdProvider.future);

      await service.saveEmergencyCard(
        userId: userId,
        bloodGroup: bloodGroup,
        allergies: allergies,
        chronicConditions: chronicConditions,
        emergencyContact: emergencyContact,
        medications: medications,
      );

      state = state.copyWith(
        bloodGroup: bloodGroup,
        allergies: allergies,
        chronicConditions: chronicConditions,
        emergencyContact: emergencyContact,
        medications: medications ?? [],
        isSaving: false,
      );
    } catch (e) {
      state = state.copyWith(isSaving: false, error: e.toString());
    }
  }

  /// Update blood group
  void setBloodGroup(String? bloodGroup) {
    state = state.copyWith(bloodGroup: bloodGroup);
  }

  /// Update allergies
  void setAllergies(String? allergies) {
    state = state.copyWith(allergies: allergies);
  }

  /// Update chronic conditions
  void setChronicConditions(String? conditions) {
    state = state.copyWith(chronicConditions: conditions);
  }

  /// Update emergency contact
  void setEmergencyContact(String? contact) {
    state = state.copyWith(emergencyContact: contact);
  }

  /// Add a medication
  void addMedication(String name, String dose, String frequency) {
    final newMedications = [
      ...state.medications,
      {'name': name, 'dose': dose, 'frequency': frequency},
    ];
    state = state.copyWith(medications: newMedications);
  }

  /// Remove a medication
  void removeMedication(int index) {
    final newMedications = List<Map<String, String>>.from(state.medications);
    newMedications.removeAt(index);
    state = state.copyWith(medications: newMedications);
  }
}

/// Provider for Emergency Card state
final emergencyCardProvider =
    NotifierProvider<EmergencyCardNotifier, EmergencyCardState>(
      EmergencyCardNotifier.new,
    );
