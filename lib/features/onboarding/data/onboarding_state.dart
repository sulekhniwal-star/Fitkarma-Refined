import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingStateProvider = NotifierProvider<OnboardingStateNotifier, OnboardingState>(OnboardingStateNotifier.new);

class OnboardingStateNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => OnboardingState();
  
  void updateName(String? name) {
    state.name = name;
  }
  
  void updateGender(String? gender) {
    state.gender = gender;
  }
  
  void updateDateOfBirth(DateTime? dob) {
    state.dateOfBirth = dob;
  }
  
  void updateHeight(double? height) {
    state.heightCm = height;
  }
  
  void updateWeight(double? weight) {
    state.weightKg = weight;
  }
  
  void updateFitnessGoal(String? goal) {
    state.fitnessGoal = goal;
  }
  
  void updateActivityLevel(String? level) {
    state.activityLevel = level;
  }
  
  void updateChronicConditions(List<String> conditions) {
    state.chronicConditions = conditions;
  }
  
  void updateDosha(int vata, int pitta, int kapha) {
    state.vataPercent = vata;
    state.pittaPercent = pitta;
    state.kaphaPercent = kapha;
  }
  
  void updateLanguage(String lang) {
    state.language = lang;
  }
  
  void updatePermissions({
    bool? stepCounter,
    bool? heartRate,
    bool? sleep,
  }) {
    if (stepCounter != null) state.stepCounterPermission = stepCounter;
    if (heartRate != null) state.heartRatePermission = heartRate;
    if (sleep != null) state.sleepPermission = sleep;
  }
  
  void updateAbha(String? abha) {
    state.abhaNumber = abha;
  }
  
  void updateWearable(bool connected) {
    state.wearableConnected = connected;
  }
}

class OnboardingState {
  String? name;
  String? gender;
  DateTime? dateOfBirth;
  
  double? heightCm;
  double? weightKg;
  String? fitnessGoal;
  String? activityLevel;
  
  List<String> chronicConditions = [];
  
  int vataPercent = 33;
  int pittaPercent = 33;
  int kaphaPercent = 33;
  
  String language = 'en';
  bool stepCounterPermission = false;
  bool heartRatePermission = false;
  bool sleepPermission = false;
  
  String? abhaNumber;
  bool wearableConnected = false;
  
  bool get isStep1Complete => name != null && gender != null && dateOfBirth != null;
  bool get isStep2Complete => heightCm != null && weightKg != null && fitnessGoal != null && activityLevel != null;
  bool get isStep3Complete => true;
  bool get isStep4Complete => true;
  bool get isStep5Complete => true;
  bool get isStep6Complete => true;
  bool get isComplete => isStep1Complete && isStep2Complete && isStep3Complete && isStep4Complete && isStep5Complete && isStep6Complete;
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'heightCm': heightCm,
    'weightKg': weightKg,
    'fitnessGoal': fitnessGoal,
    'activityLevel': activityLevel,
    'chronicConditions': chronicConditions,
    'vataPercent': vataPercent,
    'pittaPercent': pittaPercent,
    'kaphaPercent': kaphaPercent,
    'language': language,
    'stepCounterPermission': stepCounterPermission,
    'heartRatePermission': heartRatePermission,
    'sleepPermission': sleepPermission,
    'abhaNumber': abhaNumber,
    'wearableConnected': wearableConnected,
  };
}