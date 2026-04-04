import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    this.preferredLanguage,
    this.healthPermissionsGranted = false,
    this.abhaId,
    this.wearableConnected = false,
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
  
  void updatePersonalInfo({String? gender, DateTime? dob}) {
    state = state.copyWith(gender: gender, dob: dob);
  }

  void updatePhysicalMetrics({double? height, double? weight, String? goal, String? activity}) {
    state = state.copyWith(
      height: height,
      weight: weight,
      fitnessGoal: goal,
      activityLevel: activity,
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
    // Logic to save to Drift and Appwrite will go here
    // For now, it's a placeholder
  }
}
