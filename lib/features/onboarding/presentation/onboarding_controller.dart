import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/di/providers.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';

part 'onboarding_controller.g.dart';

class OnboardingState {
  final int currentStep;
  final String name;
  final String? gender;
  final DateTime? dob;
  final double? height;
  final double? weight;
  final String? fitnessGoal;
  final String? activityLevel;
  final List<String> chronicConditions;
  final Map<String, int> doshaScores;
  final String? preferredLanguage;
  final bool healthPermissionsGranted;
  final String? abhaId;
  final bool wearableConnected;
  final bool isSaving;

  OnboardingState({
    this.currentStep = 1,
    this.name = '',
    this.gender,
    this.dob,
    this.height,
    this.weight,
    this.fitnessGoal,
    this.activityLevel,
    this.chronicConditions = const [],
    this.doshaScores = const {},
    this.preferredLanguage = 'en',
    this.healthPermissionsGranted = false,
    this.abhaId,
    this.wearableConnected = false,
    this.isSaving = false,
  });

  OnboardingState copyWith({
    int? currentStep,
    String? name,
    String? gender,
    DateTime? dob,
    double? height,
    double? weight,
    String? fitnessGoal,
    String? activityLevel,
    List<String>? chronicConditions,
    Map<String, int>? doshaScores,
    String? preferredLanguage,
    bool? healthPermissionsGranted,
    String? abhaId,
    bool? wearableConnected,
    bool? isSaving,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      dob: dob ?? this.dob,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      fitnessGoal: fitnessGoal ?? this.fitnessGoal,
      activityLevel: activityLevel ?? this.activityLevel,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      doshaScores: doshaScores ?? this.doshaScores,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      healthPermissionsGranted: healthPermissionsGranted ?? this.healthPermissionsGranted,
      abhaId: abhaId ?? this.abhaId,
      wearableConnected: wearableConnected ?? this.wearableConnected,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingState build() => OnboardingState();

  void nextStep() {
    if (state.currentStep < 6) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 1) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void updateName(String name) => state = state.copyWith(name: name);
  
  void updateGender(String gender) => state = state.copyWith(gender: gender);
  
  void updateDob(DateTime dob) => state = state.copyWith(dob: dob);

  void updatePhysicalMetrics({double? height, double? weight, String? goal, String? activity}) {
    state = state.copyWith(
      height: height ?? state.height,
      weight: weight ?? state.weight,
      fitnessGoal: goal ?? state.fitnessGoal,
      activityLevel: activity ?? state.activityLevel,
    );
  }

  void updateConditions(List<String> conditions) {
    state = state.copyWith(chronicConditions: conditions);
  }

  void updateDosha(Map<String, int> scores) {
    state = state.copyWith(doshaScores: scores);
  }

  void updateLanguage(String language) {
    state = state.copyWith(preferredLanguage: language);
  }

  void updatePermissions(bool granted) {
    state = state.copyWith(healthPermissionsGranted: granted);
  }

  void updateAbha(String? id) {
    state = state.copyWith(abhaId: id);
  }

  void updateWearable(bool connected) {
    state = state.copyWith(wearableConnected: connected);
  }

  Future<void> completeOnboarding() async {
    state = state.copyWith(isSaving: true);
    try {
      final db = ref.read(databaseProvider);
      final user = await ref.read(currentUserProvider.future);
      if (user == null) throw Exception("No authenticated user found for onboarding save.");

      // 1. Save User Profile to Drift
      await db.userProfilesDao.upsertProfile(
        UserProfilesCompanion.insert(
          id: user.$id,
          name: state.name,
          gender: Value(state.gender),
          dob: Value(state.dob),
          height: Value(state.height),
          weight: Value(state.weight),
          fitnessGoal: Value(state.fitnessGoal),
          activityLevel: Value(state.activityLevel),
          doshaScores: Value(json.encode(state.doshaScores)),
          preferredLanguage: Value(state.preferredLanguage ?? 'en'),
          onboardingComplete: const Value(true),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
        ),
      );

      // 2. Save Initial Body Metrics as the first BodyMeasurement log
      if (state.weight != null || state.height != null) {
        await db.bodyMeasurementsDao.into(db.bodyMeasurements).insert(
          BodyMeasurementsCompanion.insert(
            id: DateTime.now().toIso8601String(),
            userId: user.$id,
            weight: state.weight ?? 0.0,
            height: Value(state.height),
            measuredAt: DateTime.now(),
            syncStatus: const Value('pending'),
          ),
        );
      }

      // 3. Mark Emergency Card (Chronic Conditions)
      if (state.chronicConditions.isNotEmpty && !state.chronicConditions.contains("None")) {
        await db.emergencyCardDao.into(db.emergencyCards).insert(
          EmergencyCardsCompanion.insert(
            id: user.$id,
            userId: user.$id,
            chronicConditions: Value(state.chronicConditions.join(", ")),
            updatedAt: DateTime.now(),
          ),
        );
      }

      // 4. Record Initial Karma XP (+50 XP for onboarding)
      await db.karmaTransactionsDao.into(db.karmaTransactions).insert(
        KarmaTransactionsCompanion.insert(
          id: DateTime.now().toIso8601String(),
          userId: user.$id,
          amount: 50,
          activityType: 'onboarding_completion',
          createdAt: DateTime.now(),
          syncStatus: const Value('pending'),
        ),
      );

      // Final: Invalidate user related providers to refresh state
      ref.invalidate(currentUserProvider);
    } finally {
      state = state.copyWith(isSaving: false);
    }
  }
}

