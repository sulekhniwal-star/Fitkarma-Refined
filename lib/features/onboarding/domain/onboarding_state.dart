import 'package:flutter/foundation.dart';

enum OnboardingGoal {
  loseWeight('Lose Weight', 'वजन कम करें'),
  gainMuscle('Gain Muscle', 'मांसपेशियां बढ़ाएं'),
  maintain('Maintain', 'बनाए रखें'),
  endurance('Endurance', 'सहनशक्ति');

  final String labelEn;
  final String labelHi;
  const OnboardingGoal(this.labelEn, this.labelHi);
}

enum ActivityLevel {
  sedentary(1.2, 'Sedentary', 'निष्क्रिय'),
  light(1.375, 'Lightly Active', 'हल्का सक्रिय'),
  moderate(1.55, 'Moderately Active', 'मध्यम सक्रिय'),
  active(1.725, 'Very Active', 'अत्यधिक सक्रिय'),
  veryActive(1.9, 'Extra Active', 'अतिरिक्त सक्रिय');

  final double factor;
  final String labelEn;
  final String labelHi;
  const ActivityLevel(this.factor, this.labelEn, this.labelHi);
}

enum Gender {
  male('Male', 'पुरुष'),
  female('Female', 'महिला'),
  other('Other', 'अन्य'),
  preferNotToSay('Prefer not to say', 'नहीं बताना');

  final String labelEn;
  final String labelHi;
  const Gender(this.labelEn, this.labelHi);
}

enum BloodGroup {
  aPositive('A+'), aNegative('A-'),
  bPositive('B+'), bNegative('B-'),
  abPositive('AB+'), abNegative('AB-'),
  oPositive('O+'), oNegative('O-');

  final String label;
  const BloodGroup(this.label);
}

enum ChronicCondition {
  diabetes('Diabetes', 'मधुमेह'),
  pcodPcos('PCOD/PCOS', 'पॉलिसिस्टिक ओवरी सिंड्रोम'),
  hypertension('Hypertension', 'उच्च रक्तचाप'),
  hypothyroidism('Hypothyroidism', 'थायरॉयड कमी'),
  asthma('Asthma', 'दमा'),
  none('None', 'कोई नहीं');

  final String labelEn;
  final String labelHi;
  const ChronicCondition(this.labelEn, this.labelHi);
}

enum DoshaType {
  vata('Vata', 'वात'),
  pitta('Pitta', 'पित्त'),
  kapha('Kapha', 'कफ'),
  vataPitta('Vata-Pitta', 'वात-पित्त'),
  vataKapha('Vata-Kapha', 'वात-कफ'),
  pittaKapha('Pitta-Kapha', 'पित्त-कफ'),
  balanced('Balanced', 'संतुलित');

  final String labelEn;
  final String labelHi;
  const DoshaType(this.labelEn, this.labelHi);
}

@immutable
class OnboardingState {
  final int currentStep;
  final String displayName;
  final OnboardingGoal? goal;
  
  // Step 2: Body Stats
  final double heightCm;
  final double weightKg;
  final DateTime? dateOfBirth;
  final Gender gender;
  final BloodGroup? bloodGroup;
  
  // Step 3: Activity Level
  final ActivityLevel activityLevel;
  final double tdee;
  
  // Step 4: Dosha Quiz
  final List<int> doshaAnswers;
  final DoshaType? determinedDosha;
  
  // Step 5: Health Conditions
  final Set<ChronicCondition> chronicConditions;
  final List<String> requestedPermissions;
  
  // Step 6: ABHA & Wearables
  final String? abhaId;
  final bool abhaLinked;
  final bool wearableConnected;
  final String? connectedWearableType;
  
  // Completion
  final bool isComplete;

  const OnboardingState({
    this.currentStep = 0,
    this.displayName = '',
    this.goal,
    this.heightCm = 170,
    this.weightKg = 70,
    this.dateOfBirth,
    this.gender = Gender.male,
    this.bloodGroup,
    this.activityLevel = ActivityLevel.moderate,
    this.tdee = 2000,
    this.doshaAnswers = const [],
    this.determinedDosha,
    this.chronicConditions = const {},
    this.requestedPermissions = const [],
    this.abhaId,
    this.abhaLinked = false,
    this.wearableConnected = false,
    this.connectedWearableType,
    this.isComplete = false,
  });

  int get age {
    if (dateOfOfBirth == null) return 30;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month || 
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  DateTime? get dateOfOfBirth => dateOfBirth;

  double calculateTdee() {
    // Mifflin-St Jeor equation
    double bmr;
    if (gender == Gender.female) {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) - 161;
    } else {
      bmr = (10 * weightKg) + (6.25 * heightCm) - (5 * age) + 5;
    }
    return bmr * activityLevel.factor;
  }

  OnboardingState copyWith({
    int? currentStep,
    String? displayName,
    OnboardingGoal? goal,
    double? heightCm,
    double? weightKg,
    DateTime? dateOfBirth,
    Gender? gender,
    BloodGroup? bloodGroup,
    ActivityLevel? activityLevel,
    double? tdee,
    List<int>? doshaAnswers,
    DoshaType? determinedDosha,
    Set<ChronicCondition>? chronicConditions,
    List<String>? requestedPermissions,
    String? abhaId,
    bool? abhaLinked,
    bool? wearableConnected,
    String? connectedWearableType,
    bool? isComplete,
  }) {
    return OnboardingState(
      currentStep: currentStep ?? this.currentStep,
      displayName: displayName ?? this.displayName,
      goal: goal ?? this.goal,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      activityLevel: activityLevel ?? this.activityLevel,
      tdee: tdee ?? this.tdee,
      doshaAnswers: doshaAnswers ?? this.doshaAnswers,
      determinedDosha: determinedDosha ?? this.determinedDosha,
      chronicConditions: chronicConditions ?? this.chronicConditions,
      requestedPermissions: requestedPermissions ?? this.requestedPermissions,
      abhaId: abhaId ?? this.abhaId,
      abhaLinked: abhaLinked ?? this.abhaLinked,
      wearableConnected: wearableConnected ?? this.wearableConnected,
      connectedWearableType: connectedWearableType ?? this.connectedWearableType,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  Map<String, dynamic> toUserProfile() {
    return {
      'displayName': displayName,
      'goal': goal?.name,
      'heightCm': heightCm,
      'weightKg': weightKg,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender.name,
      'bloodGroup': bloodGroup?.name,
      'activityLevel': activityLevel.name,
      'tdee': tdee,
      'doshaType': determinedDosha?.name,
      'chronicConditions': chronicConditions.map((c) => c.name).toList(),
      'language': 'en',
      'onboardingCompletedAt': DateTime.now().toIso8601String(),
    };
  }
}
