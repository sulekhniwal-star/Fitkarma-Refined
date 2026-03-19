import 'package:flutter/foundation.dart';

/// Onboarding state that stores user data during the 6-step onboarding process
/// This is kept in memory and committed to Drift + Appwrite on step 6 completion
class OnboardingState {
  OnboardingState();
  // Screen 1: Basic Info
  String? name;
  String? gender; // 'male', 'female', 'other', 'prefer_not_to_say'
  DateTime? dateOfBirth;

  // Screen 2: Body & Fitness
  double? heightCm;
  double? weightKg;
  String?
  fitnessGoal; // 'weight_loss', 'muscle_gain', 'maintenance', 'endurance'
  String?
  activityLevel; // 'sedentary', 'light', 'moderate', 'active', 'very_active'

  // Screen 3: Chronic Conditions (multi-select)
  List<String> chronicConditions =
      []; // 'diabetes', 'hypertension', 'pcod', 'hypothyroidism', 'asthma'

  // Screen 4: Dosha Quiz
  Map<int, int> doshaQuizAnswers = {}; // questionId -> answerIndex (0-3)
  double? vataPercentage;
  double? pittaPercentage;
  double? kaphaPercentage;
  String? dominantDosha;

  // Screen 5: Language & Permissions
  String? languageCode; // 'en', 'hi', 'ta', etc.
  bool permissionStepCounter = false;
  bool permissionHeartRate = false;
  bool permissionSleep = false;

  // Screen 6: ABHA & Wearables
  String? abhaNumber; // Optional
  bool abhaLinked = false;
  List<String> connectedWearables =
      []; // 'fitbit', 'garmin', 'apple_health', 'google_fit'

  // Computed properties
  int get age {
    if (dateOfBirth == null) return 0;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }

  double? get bmi {
    if (heightCm == null || weightKg == null || heightCm! <= 0) return null;
    final heightM = heightCm! / 100;
    return weightKg! / (heightM * heightM);
  }

  String? get bmiCategory {
    final bmiValue = bmi;
    if (bmiValue == null) return null;
    if (bmiValue < 18.5) return 'underweight';
    if (bmiValue < 25) return 'normal';
    if (bmiValue < 30) return 'overweight';
    return 'obese';
  }

  bool get isStep1Complete =>
      name != null && name!.isNotEmpty && gender != null && dateOfBirth != null;
  bool get isStep2Complete =>
      heightCm != null &&
      weightKg != null &&
      fitnessGoal != null &&
      activityLevel != null;
  bool get isStep3Complete => true; // Optional - can skip
  bool get isStep4Complete =>
      doshaQuizAnswers.length >= 12 && vataPercentage != null;
  bool get isStep5Complete => languageCode != null;
  bool get isStep6Complete => true; // Optional - can skip

  bool get isOnboardingComplete =>
      isStep1Complete && isStep2Complete && isStep5Complete;

  /// Calculate Dosha percentages from quiz answers
  void calculateDosha() {
    if (doshaQuizAnswers.length < 12) return;

    double vata = 0, pitta = 0, kapha = 0;

    // Each question has 4 options - Vata/Pitta/Kapha dominant
    // Simple calculation: count which dosha each answer favors
    for (final entry in doshaQuizAnswers.entries) {
      final answer = entry.value;
      // Based on typical dosha quiz structure:
      // 0 = Vata, 1 = Pitta, 2 = Kapha, 3 = Mixed/平衡
      switch (answer) {
        case 0:
          vata++;
          break;
        case 1:
          pitta++;
          break;
        case 2:
          kapha++;
          break;
        case 3:
          // Balanced - add to all
          vata += 0.33;
          pitta += 0.33;
          kapha += 0.33;
          break;
      }
    }

    final total = vata + pitta + kapha;
    if (total > 0) {
      vataPercentage = (vata / total) * 100;
      pittaPercentage = (pitta / total) * 100;
      kaphaPercentage = (kapha / total) * 100;

      // Determine dominant dosha
      if (vataPercentage! >= pittaPercentage! &&
          vataPercentage! >= kaphaPercentage!) {
        dominantDosha = 'vata';
      } else if (pittaPercentage! >= vataPercentage! &&
          pittaPercentage! >= kaphaPercentage!) {
        dominantDosha = 'pitta';
      } else {
        dominantDosha = 'kapha';
      }
    }
  }

  /// Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'name': name,
    'gender': gender,
    'dateOfBirth': dateOfBirth?.toIso8601String(),
    'heightCm': heightCm,
    'weightKg': weightKg,
    'fitnessGoal': fitnessGoal,
    'activityLevel': activityLevel,
    'chronicConditions': chronicConditions,
    'doshaQuizAnswers': doshaQuizAnswers.map(
      (k, v) => MapEntry(k.toString(), v),
    ),
    'vataPercentage': vataPercentage,
    'pittaPercentage': pittaPercentage,
    'kaphaPercentage': kaphaPercentage,
    'dominantDosha': dominantDosha,
    'languageCode': languageCode,
    'permissionStepCounter': permissionStepCounter,
    'permissionHeartRate': permissionHeartRate,
    'permissionSleep': permissionSleep,
    'abhaNumber': abhaNumber,
    'abhaLinked': abhaLinked,
    'connectedWearables': connectedWearables,
  };

  /// Create from JSON
  factory OnboardingState.fromJson(Map<String, dynamic> json) {
    final state = OnboardingState();
    state.name = json['name'] as String?;
    state.gender = json['gender'] as String?;
    state.dateOfBirth = json['dateOfBirth'] != null
        ? DateTime.parse(json['dateOfBirth'] as String)
        : null;
    state.heightCm = json['heightCm'] as double?;
    state.weightKg = json['weightKg'] as double?;
    state.fitnessGoal = json['fitnessGoal'] as String?;
    state.activityLevel = json['activityLevel'] as String?;
    state.chronicConditions = List<String>.from(
      json['chronicConditions'] ?? [],
    );
    if (json['doshaQuizAnswers'] != null) {
      state.doshaQuizAnswers =
          (json['doshaQuizAnswers'] as Map<String, dynamic>).map(
            (k, v) => MapEntry(int.parse(k), v as int),
          );
    }
    state.vataPercentage = json['vataPercentage'] as double?;
    state.pittaPercentage = json['pittaPercentage'] as double?;
    state.kaphaPercentage = json['kaphaPercentage'] as double?;
    state.dominantDosha = json['dominantDosha'] as String?;
    state.languageCode = json['languageCode'] as String?;
    state.permissionStepCounter =
        json['permissionStepCounter'] as bool? ?? false;
    state.permissionHeartRate = json['permissionHeartRate'] as bool? ?? false;
    state.permissionSleep = json['permissionSleep'] as bool? ?? false;
    state.abhaNumber = json['abhaNumber'] as String?;
    state.abhaLinked = json['abhaLinked'] as bool? ?? false;
    state.connectedWearables = List<String>.from(
      json['connectedWearables'] ?? [],
    );
    return state;
  }

  OnboardingState copyWith({
    String? name,
    String? gender,
    DateTime? dateOfBirth,
    double? heightCm,
    double? weightKg,
    String? fitnessGoal,
    String? activityLevel,
    List<String>? chronicConditions,
    Map<int, int>? doshaQuizAnswers,
    double? vataPercentage,
    double? pittaPercentage,
    double? kaphaPercentage,
    String? dominantDosha,
    String? languageCode,
    bool? permissionStepCounter,
    bool? permissionHeartRate,
    bool? permissionSleep,
    String? abhaNumber,
    bool? abhaLinked,
    List<String>? connectedWearables,
  }) {
    return OnboardingState()
      ..name = name ?? this.name
      ..gender = gender ?? this.gender
      ..dateOfBirth = dateOfBirth ?? this.dateOfBirth
      ..heightCm = heightCm ?? this.heightCm
      ..weightKg = weightKg ?? this.weightKg
      ..fitnessGoal = fitnessGoal ?? this.fitnessGoal
      ..activityLevel = activityLevel ?? this.activityLevel
      ..chronicConditions =
          chronicConditions ?? List.from(this.chronicConditions)
      ..doshaQuizAnswers = doshaQuizAnswers ?? Map.from(this.doshaQuizAnswers)
      ..vataPercentage = vataPercentage ?? this.vataPercentage
      ..pittaPercentage = pittaPercentage ?? this.pittaPercentage
      ..kaphaPercentage = kaphaPercentage ?? this.kaphaPercentage
      ..dominantDosha = dominantDosha ?? this.dominantDosha
      ..languageCode = languageCode ?? this.languageCode
      ..permissionStepCounter =
          permissionStepCounter ?? this.permissionStepCounter
      ..permissionHeartRate = permissionHeartRate ?? this.permissionHeartRate
      ..permissionSleep = permissionSleep ?? this.permissionSleep
      ..abhaNumber = abhaNumber ?? this.abhaNumber
      ..abhaLinked = abhaLinked ?? this.abhaLinked
      ..connectedWearables =
          connectedWearables ?? List.from(this.connectedWearables);
  }
}

/// Dosha quiz question model
class DoshaQuestion {
  final int id;
  final String question;
  final List<String> options;
  final List<int> doshaScores; // Scores for [Vata, Pitta, Kapha]

  DoshaQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.doshaScores,
  });
}

/// Provider for onboarding state
class OnboardingStateNotifier extends ChangeNotifier {
  OnboardingState _state = OnboardingState();

  OnboardingState get state => _state;

  void updateState(OnboardingState newState) {
    _state = newState;
    notifyListeners();
  }

  void updateBasicInfo({String? name, String? gender, DateTime? dateOfBirth}) {
    _state = _state.copyWith(
      name: name,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
    notifyListeners();
  }

  void updateBodyMetrics({
    double? heightCm,
    double? weightKg,
    String? fitnessGoal,
    String? activityLevel,
  }) {
    _state = _state.copyWith(
      heightCm: heightCm,
      weightKg: weightKg,
      fitnessGoal: fitnessGoal,
      activityLevel: activityLevel,
    );
    notifyListeners();
  }

  void updateChronicConditions(List<String> conditions) {
    _state = _state.copyWith(chronicConditions: conditions);
    notifyListeners();
  }

  void updateDoshaResults({
    Map<int, int>? answers,
    double? vataPercent,
    double? pittaPercent,
    double? kaphaPercent,
    String? dominantDosha,
  }) {
    _state = _state.copyWith(
      doshaQuizAnswers: answers,
      vataPercentage: vataPercent,
      pittaPercentage: pittaPercent,
      kaphaPercentage: kaphaPercent,
      dominantDosha: dominantDosha,
    );
    notifyListeners();
  }

  void updateLanguageAndPermissions({
    String? languageCode,
    bool? permissionStepCounter,
    bool? permissionHeartRate,
    bool? permissionSleep,
  }) {
    _state = _state.copyWith(
      languageCode: languageCode,
      permissionStepCounter: permissionStepCounter,
      permissionHeartRate: permissionHeartRate,
      permissionSleep: permissionSleep,
    );
    notifyListeners();
  }

  void updateAbhaAndWearable({
    String? abhaNumber,
    bool? abhaLinked,
    List<String>? connectedWearables,
  }) {
    _state = _state.copyWith(
      abhaNumber: abhaNumber,
      abhaLinked: abhaLinked,
      connectedWearables: connectedWearables,
    );
    notifyListeners();
  }

  void completeOnboarding() {
    // Mark as complete - the copyWith doesn't have isOnboardingComplete field
    // so we handle it differently
    notifyListeners();
  }

  void reset() {
    _state = OnboardingState();
    notifyListeners();
  }
}
