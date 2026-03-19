import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'onboarding_state.dart';

/// Global singleton instance for onboarding state
final onboardingStateNotifier = OnboardingStateNotifier();

/// Provider that returns the OnboardingStateNotifier singleton
/// The screens access it as: ref.read(onboardingStateProvider).state
final onboardingStateProvider = Provider<OnboardingStateNotifier>((ref) {
  return onboardingStateNotifier;
});

/// Current onboarding step (1-6) - using a simple int wrapped in a class
class OnboardingStepNotifier extends ChangeNotifier {
  int _step = 1;
  int get step => _step;
  void setStep(int value) {
    _step = value;
    notifyListeners();
  }
}

final onboardingStepNotifier = OnboardingStepNotifier();

/// Provider for current onboarding step (1-6)
final onboardingStepProvider = Provider<OnboardingStepNotifier>((ref) {
  return onboardingStepNotifier;
});

/// Provider to check if onboarding is complete
final onboardingCompleteProvider = Provider<bool>((ref) {
  final state = ref.watch(onboardingStateProvider).state;
  return state.isOnboardingComplete;
});

/// Dosha quiz questions provider
final doshaQuizQuestionsProvider = Provider<List<DoshaQuestion>>((ref) {
  return doshaQuizQuestions;
});

/// List of 12 Dosha quiz questions
final doshaQuizQuestions = [
  DoshaQuestion(
    id: 1,
    question: 'How would you describe your body frame?',
    options: [
      'Thin, slender, delicate',
      'Medium build, well-proportioned',
      'Stocky, solid, broad',
    ],
    doshaScores: [2, 1, 0], // Vata, Pitta, Kapha
  ),
  DoshaQuestion(
    id: 2,
    question: 'What is your skin type?',
    options: ['Dry, rough, cool', 'Oily, warm, sensitive', 'Thick, oily, pale'],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 3,
    question: 'How do you typically react to stress?',
    options: [
      'Anxious, worried, overthink',
      'Irritable, angry, competitive',
      'Calm, steady, lethargic',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 4,
    question: 'What is your appetite like?',
    options: [
      'Variable, often irregular',
      'Strong, intense, can\'t skip meals',
      'Steady, can skip meals easily',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 5,
    question: 'How is your digestion?',
    options: [
      'Tends to be gassy, irregular',
      'Strong, fast, sometimes heartburn',
      'Slow, steady, heavy feeling',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 6,
    question: 'What is your sleep pattern?',
    options: [
      'Light sleeper, often insomnia',
      'Moderate, can be disturbed',
      'Deep sleeper, oversleeps',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 7,
    question: 'How do you prefer to exercise?',
    options: [
      'Light activities, yoga, walking',
      'Moderate, jogging, swimming',
      'Heavy, intense, bodybuilding',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 8,
    question: 'What is your energy level throughout the day?',
    options: [
      'Fluctuates, peaks and crashes',
      'Consistently high in afternoon',
      'Steady, slow start, maintains',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 9,
    question: 'How is your memory?',
    options: [
      'Quick to learn, quick to forget',
      'Sharp, focused',
      'Slow to learn, long-term recall',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 10,
    question: 'What is your personality like?',
    options: [
      'Creative, enthusiastic, restless',
      'Ambitious, determined, forceful',
      'Calm, patient, methodical',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 11,
    question: 'How do you handle change?',
    options: [
      'Embrace easily, get bored quickly',
      'Adapt but prefer routine',
      'Resist, prefer stability',
    ],
    doshaScores: [2, 1, 0],
  ),
  DoshaQuestion(
    id: 12,
    question: 'What is your ideal climate?',
    options: ['Warm, humid', 'Cool, moderate', 'Cold, dry'],
    doshaScores: [2, 1, 0],
  ),
];

/// Calculate Dosha percentages from quiz answers
DoshaResult calculateDoshaResults(Map<int, int> answers) {
  double vataTotal = 0;
  double pittaTotal = 0;
  double kaphaTotal = 0;

  for (final question in doshaQuizQuestions) {
    final answerIndex = answers[question.id];
    if (answerIndex != null && answerIndex < question.doshaScores.length) {
      // Score for each dosha based on answer
      // 0 = Vata (option 1), 1 = Pitta (option 2), 2 = Kapha (option 3)
      if (answerIndex == 0) {
        vataTotal += 2;
      } else if (answerIndex == 1) {
        pittaTotal += 2;
      } else {
        kaphaTotal += 2;
      }
    }
  }

  final total = vataTotal + pittaTotal + kaphaTotal;
  if (total == 0) {
    return DoshaResult(
      vataPercent: 33.33,
      pittaPercent: 33.33,
      kaphaPercent: 33.33,
      dominantDosha: 'Vata-Pitta-Kapha',
    );
  }

  final vataPercent = (vataTotal / total) * 100;
  final pittaPercent = (pittaTotal / total) * 100;
  final kaphaPercent = (kaphaTotal / total) * 100;

  String dominantDosha;
  if (vataPercent >= pittaPercent && vataPercent >= kaphaPercent) {
    dominantDosha = 'Vata';
  } else if (pittaPercent >= vataPercent && pittaPercent >= kaphaPercent) {
    dominantDosha = 'Pitta';
  } else {
    dominantDosha = 'Kapha';
  }

  return DoshaResult(
    vataPercent: vataPercent,
    pittaPercent: pittaPercent,
    kaphaPercent: kaphaPercent,
    dominantDosha: dominantDosha,
  );
}

/// Dosha calculation result
class DoshaResult {
  final double vataPercent;
  final double pittaPercent;
  final double kaphaPercent;
  final String dominantDosha;

  DoshaResult({
    required this.vataPercent,
    required this.pittaPercent,
    required this.kaphaPercent,
    required this.dominantDosha,
  });
}

/// Supported languages
final supportedLanguages = [
  LanguageOption(code: 'en', name: 'English'),
  LanguageOption(code: 'hi', name: 'हिन्दी (Hindi)'),
  LanguageOption(code: 'bn', name: 'বাংলা (Bengali)'),
  LanguageOption(code: 'te', name: 'తెలుగు (Telugu)'),
  LanguageOption(code: 'mr', name: 'मराठी (Marathi)'),
  LanguageOption(code: 'ta', name: 'தமிழ் (Tamil)'),
  LanguageOption(code: 'ur', name: 'اردو (Urdu)'),
  LanguageOption(code: 'gu', name: 'ગુજરાતી (Gujarati)'),
  LanguageOption(code: 'kn', name: 'ಕನ್ನಡ (Kannada)'),
  LanguageOption(code: 'ml', name: 'മലയാളം (Malayalam)'),
  LanguageOption(code: 'pa', name: 'ਪੰਜਾਬੀ (Punjabi)'),
  LanguageOption(code: 'or', name: 'ଓଡ଼ିଆ (Odia)'),
  LanguageOption(code: 'as', name: 'অসমীয়া (Assamese)'),
  LanguageOption(code: 'sd', name: 'سنڌي (Sindhi)'),
  LanguageOption(code: 'sa', name: 'संस्कृत (Sanskrit)'),
  LanguageOption(code: 'kok', name: 'कोंकणी (Konkani)'),
  LanguageOption(code: 'mni', name: 'মিতোল (Manipuri)'),
  LanguageOption(code: 'sid', name: 'ሲዳማ (Siddi)'),
  LanguageOption(code: 'saz', name: 'सौराष्ट्र (Saurashtra)'),
  LanguageOption(code: 'sat', name: 'संथाली (Santali)'),
  LanguageOption(code: 'nag', name: 'নাগামী (Nagpuri)'),
  LanguageOption(code: 'hoc', name: 'हो (Ho)'),
];

/// Language option model
class LanguageOption {
  final String code;
  final String name;

  LanguageOption({required this.code, required this.name});
}

/// Available chronic conditions
final chronicConditionsList = [
  ChronicCondition(id: 'diabetes', name: 'Diabetes', icon: '🩸'),
  ChronicCondition(id: 'hypertension', name: 'Hypertension', icon: '💓'),
  ChronicCondition(id: 'pcod', name: 'PCOD', icon: '🔄'),
  ChronicCondition(id: 'hypothyroidism', name: 'Hypothyroidism', icon: '⚖️'),
  ChronicCondition(id: 'asthma', name: 'Asthma', icon: '🫁'),
];

/// Chronic condition model
class ChronicCondition {
  final String id;
  final String name;
  final String icon;

  ChronicCondition({required this.id, required this.name, required this.icon});
}

/// Fitness goal options
final fitnessGoals = [
  FitnessGoalOption(
    id: 'weight_loss',
    name: 'Weight Loss',
    description: 'Lose weight and get leaner',
    icon: '🔥',
  ),
  FitnessGoalOption(
    id: 'muscle_gain',
    name: 'Muscle Gain',
    description: 'Build muscle and strength',
    icon: '💪',
  ),
  FitnessGoalOption(
    id: 'endurance',
    name: 'Endurance',
    description: 'Improve stamina and cardio',
    icon: '🏃',
  ),
  FitnessGoalOption(
    id: 'general_fitness',
    name: 'General Fitness',
    description: 'Stay healthy and active',
    icon: '🧘',
  ),
];

/// Fitness goal option model
class FitnessGoalOption {
  final String id;
  final String name;
  final String description;
  final String icon;

  FitnessGoalOption({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

/// Activity level options
final activityLevels = [
  ActivityLevelOption(
    id: 'sedentary',
    name: 'Sedentary',
    description: 'Little to no exercise',
    icon: '🛋️',
  ),
  ActivityLevelOption(
    id: 'light',
    name: 'Lightly Active',
    description: 'Light exercise 1-3 days/week',
    icon: '🚶',
  ),
  ActivityLevelOption(
    id: 'moderate',
    name: 'Moderately Active',
    description: 'Moderate exercise 3-5 days/week',
    icon: '🏋️',
  ),
  ActivityLevelOption(
    id: 'active',
    name: 'Very Active',
    description: 'Hard exercise 6-7 days/week',
    icon: '🏃',
  ),
  ActivityLevelOption(
    id: 'athlete',
    name: 'Athlete',
    description: 'Very hard exercise, physical job',
    icon: '🏆',
  ),
];

/// Activity level option model
class ActivityLevelOption {
  final String id;
  final String name;
  final String description;
  final String icon;

  ActivityLevelOption({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });
}

/// Gender options
final genderOptions = ['Male', 'Female', 'Other', 'Prefer not to say'];
