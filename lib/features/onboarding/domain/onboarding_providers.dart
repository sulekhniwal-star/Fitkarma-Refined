import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';

// Riverpod v3: Use NotifierProvider instead of deprecated StateNotifierProvider
final onboardingProvider = NotifierProvider<OnboardingNotifier, OnboardingState>(() {
  return OnboardingNotifier();
});

class OnboardingNotifier extends Notifier<OnboardingState> {
  @override
  OnboardingState build() => const OnboardingState();

  void nextStep() {
    if (state.currentStep < 5) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 5) {
      state = state.copyWith(currentStep: step);
    }
  }

  void setDisplayName(String name) {
    state = state.copyWith(displayName: name);
  }

  void setGoal(OnboardingGoal goal) {
    state = state.copyWith(goal: goal);
  }

  void setHeight(double height) {
    state = state.copyWith(
      heightCm: height,
      tdee: _calculateTdee(height, state.weightKg, state.gender, state.activityLevel),
    );
  }

  void setWeight(double weight) {
    state = state.copyWith(
      weightKg: weight,
      tdee: _calculateTdee(state.heightCm, weight, state.gender, state.activityLevel),
    );
  }

  void setDateOfBirth(DateTime dob) {
    state = state.copyWith(
      dateOfBirth: dob,
      tdee: _calculateTdee(state.heightCm, state.weightKg, state.gender, state.activityLevel),
    );
  }

  void setGender(Gender gender) {
    state = state.copyWith(
      gender: gender,
      tdee: _calculateTdee(state.heightCm, state.weightKg, gender, state.activityLevel),
    );
  }

  void setBloodGroup(BloodGroup group) {
    state = state.copyWith(bloodGroup: group);
  }

  void setActivityLevel(ActivityLevel level) {
    state = state.copyWith(
      activityLevel: level,
      tdee: _calculateTdee(state.heightCm, state.weightKg, state.gender, level),
    );
  }

  void setDoshaAnswer(int questionIndex, int answer) {
    final answers = List<int>.from(state.doshaAnswers);
    if (answers.length <= questionIndex) {
      answers.add(answer);
    } else {
      answers[questionIndex] = answer;
    }
    state = state.copyWith(doshaAnswers: answers);
  }

  void calculateDosha() {
    if (state.doshaAnswers.length < 12) return;

    int vata = 0, pitta = 0, kapha = 0;

    for (int i = 0; i < 12; i++) {
      final answer = state.doshaAnswers[i];
      final scores = doshaScores[i][answer];
      vata += scores[0];
      pitta += scores[1];
      kapha += scores[2];
    }

    final dosha = _determineDosha(vata, pitta, kapha);
    state = state.copyWith(determinedDosha: dosha);
  }

  void toggleChronicCondition(ChronicCondition condition) {
    final conditions = Set<ChronicCondition>.from(state.chronicConditions);
    if (condition == ChronicCondition.none) {
      state = state.copyWith(chronicConditions: {ChronicCondition.none});
    } else {
      conditions.remove(ChronicCondition.none);
      if (conditions.contains(condition)) {
        conditions.remove(condition);
      } else {
        conditions.add(condition);
      }
      state = state.copyWith(
        chronicConditions: conditions.isEmpty ? {ChronicCondition.none} : conditions,
      );
    }
  }

  void addPermission(String permission) {
    if (!state.requestedPermissions.contains(permission)) {
      state = state.copyWith(
        requestedPermissions: [...state.requestedPermissions, permission],
      );
    }
  }

  void setAbhaId(String id) {
    state = state.copyWith(abhaId: id);
  }

  void setAbhaLinked(bool linked) {
    state = state.copyWith(abhaLinked: linked);
  }

  void setWearableConnected(bool connected, [String? deviceType]) {
    state = state.copyWith(
      wearableConnected: connected,
      connectedWearableType: deviceType,
    );
  }

  void complete() {
    state = state.copyWith(isComplete: true);
  }

  double _calculateTdee(double height, double weight, Gender gender, ActivityLevel level) {
    if (height <= 0 || weight <= 0) return 2000;

    int age = state.dateOfBirth != null
        ? DateTime.now().year - state.dateOfBirth!.year
        : 30;

    double bmr;
    if (gender == Gender.female) {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) - 161;
    } else {
      bmr = (10 * weight) + (6.25 * height) - (5 * age) + 5;
    }
    return (bmr * level.factor).roundToDouble();
  }

  DoshaType _determineDosha(int vata, int pitta, int kapha) {
    if (vata >= pitta && vata >= kapha) {
      if (pitta >= kapha) return DoshaType.vataPitta;
      if (kapha > pitta) return DoshaType.vataKapha;
      return DoshaType.vata;
    } else if (pitta >= vata && pitta >= kapha) {
      if (vata >= kapha) return DoshaType.vataPitta;
      if (kapha > vata) return DoshaType.pittaKapha;
      return DoshaType.pitta;
    } else {
      if (vata >= pitta) return DoshaType.vataKapha;
      if (pitta >= vata) return DoshaType.pittaKapha;
      return DoshaType.kapha;
    }
  }
}

final abhaStatusProvider = Provider<String?>((ref) {
  return ref.watch(onboardingProvider).abhaId;
});

// Dosha scoring for each quiz question (Vata, Pitta, Kapha)
const List<List<List<int>>> doshaScores = [
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q1: Digestion
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q2: Energy
  [[0, 0, 2], [0, 2, 0], [2, 0, 0]], // Q3: Body type
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q4: Skin
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q5: Hair
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q6: Sleep
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q7: Mood
  [[0, 0, 2], [0, 2, 0], [2, 0, 0]], // Q8: Weight
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q9: Weather
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q10: Appetite
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q11: Mind
  [[2, 0, 0], [0, 2, 0], [0, 0, 2]], // Q12: Exercise
];
