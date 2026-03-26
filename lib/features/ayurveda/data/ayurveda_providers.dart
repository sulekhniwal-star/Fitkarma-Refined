// lib/features/ayurveda/data/ayurveda_providers.dart
// Riverpod providers for Ayurveda feature

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_service.dart';
import 'package:fitkarma/features/ayurveda/data/dosha_quiz_data.dart';
import 'package:fitkarma/features/ayurveda/data/ritucharya_data.dart';
import 'package:fitkarma/features/ayurveda/data/herbal_remedies_data.dart';

/// Ayurveda service provider
final ayurvedaServiceProvider = Provider<AyurvedaService>((ref) {
  return AyurvedaService();
});

/// Current user ID provider (mock for now - should come from auth)
final odUserIdProvider = Provider<String>((ref) {
  // In production, this would come from the auth service
  return 'demo_user_123';
});

/// Ayurveda profile provider
final ayurvedaProfileProvider = Provider<AyurvedaProfile>((ref) {
  final service = ref.watch(ayurvedaServiceProvider);
  final odUserId = ref.watch(odUserIdProvider);
  return service.getOrCreateProfile(odUserId);
});

/// Dosha result provider
final doshaResultProvider = Provider<DoshaResult?>((ref) {
  final profile = ref.watch(ayurvedaProfileProvider);
  return profile.doshaResult;
});

/// Current season provider
final currentSeasonProvider = Provider<IndianSeason>((ref) {
  return IndianSeason.getCurrentSeason();
});

/// Seasonal recommendation provider
final seasonalRecommendationProvider = Provider<SeasonalRecommendation>((ref) {
  final season = ref.watch(currentSeasonProvider);
  final profile = ref.watch(ayurvedaProfileProvider);
  final doshaResult = profile.doshaResult;

  if (doshaResult != null) {
    // Get dosha type and adjust recommendations
    final doshaType = _getPrimaryDoshaType(doshaResult);
    final baseRec = RitucharyaData.getRecommendationForSeason(season);
    return SeasonalRecommendation(
      season: season,
      diet: RitucharyaData.getDietAdjustments(doshaType, season),
      lifestyle: RitucharyaData.getLifestyleAdjustments(doshaType, season),
      exercises: baseRec?.exercises ?? [],
      avoid: baseRec?.avoid ?? [],
      specialNote: baseRec?.specialNote,
    );
  }

  return RitucharyaData.getCurrentSeasonRecommendation();
});

DoshaType _getPrimaryDoshaType(DoshaResult result) {
  if (result.vataPercent >= result.pittaPercent &&
      result.vataPercent >= result.kaphaPercent) {
    return DoshaType.vata;
  } else if (result.pittaPercent >= result.vataPercent &&
      result.pittaPercent >= result.kaphaPercent) {
    return DoshaType.pitta;
  }
  return DoshaType.kapha;
}

/// Daily rituals provider
final dailyRitualsProvider = Provider<List<DinacharyaTask>>((ref) {
  final service = ref.watch(ayurvedaServiceProvider);
  final odUserId = ref.watch(odUserIdProvider);
  final profile = ref.watch(ayurvedaProfileProvider);
  final doshaResult = profile.doshaResult;
  final season = ref.watch(currentSeasonProvider);

  DoshaType? doshaType;
  if (doshaResult != null) {
    doshaType = _getPrimaryDoshaType(doshaResult);
  }

  return service.getDailyRituals(
    odUserId,
    doshaType: doshaType,
    season: season,
  );
});

/// Herbal remedies provider
final herbalRemediesProvider = Provider<List<HerbalRemedy>>((ref) {
  return HerbalRemediesData.remedies;
});

/// Quiz state for managing quiz progress
class QuizState {
  final int currentQuestionIndex;
  final List<int> selectedAnswers;
  final bool isCompleted;

  const QuizState({
    this.currentQuestionIndex = 0,
    this.selectedAnswers = const [],
    this.isCompleted = false,
  });

  QuizState copyWith({
    int? currentQuestionIndex,
    List<int>? selectedAnswers,
    bool? isCompleted,
  }) {
    return QuizState(
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

/// Quiz notifier using Notifier
class QuizNotifier extends Notifier<QuizState> {
  @override
  QuizState build() {
    return const QuizState();
  }

  void selectAnswer(int answerIndex) {
    final newAnswers = List<int>.from(state.selectedAnswers);
    // Ensure the list has enough elements
    while (newAnswers.length <= state.currentQuestionIndex) {
      newAnswers.add(-1);
    }
    newAnswers[state.currentQuestionIndex] = answerIndex;
    state = state.copyWith(selectedAnswers: newAnswers);
  }

  void nextQuestion() {
    if (state.currentQuestionIndex < DoshaQuizData.questions.length - 1) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex + 1,
      );
    }
  }

  void previousQuestion() {
    if (state.currentQuestionIndex > 0) {
      state = state.copyWith(
        currentQuestionIndex: state.currentQuestionIndex - 1,
      );
    }
  }

  DoshaResult submitQuiz() {
    // Calculate result
    final result = DoshaQuizData.calculateResult(state.selectedAnswers);

    final service = ref.read(ayurvedaServiceProvider);
    final odUserId = ref.read(odUserIdProvider);

    // Save result to profile
    service.updateDoshaResult(odUserId, result);

    state = state.copyWith(isCompleted: true);
    return result;
  }

  void resetQuiz() {
    state = const QuizState();
  }
}

/// Quiz provider
final quizProvider = NotifierProvider<QuizNotifier, QuizState>(
  QuizNotifier.new,
);

/// Ritual completion notifier
class RitualCompletionNotifier extends Notifier<Map<String, bool>> {
  @override
  Map<String, bool> build() {
    return {};
  }

  void toggleRitual(String ritualId) {
    final service = ref.read(ayurvedaServiceProvider);
    final odUserId = ref.read(odUserIdProvider);

    final currentState = state[ritualId] ?? false;
    if (currentState) {
      service.markRitualIncomplete(odUserId, ritualId);
      state = {...state, ritualId: false};
    } else {
      service.markRitualComplete(odUserId, ritualId);
      state = {...state, ritualId: true};
    }
  }

  void loadCompletionStatus(List<DinacharyaTask> tasks) {
    final completionMap = <String, bool>{};
    for (final task in tasks) {
      completionMap[task.id] = task.isCompleted;
    }
    state = completionMap;
  }
}

/// Ritual completion provider
final ritualCompletionProvider =
    NotifierProvider<RitualCompletionNotifier, Map<String, bool>>(
      RitualCompletionNotifier.new,
    );

/// Dosha quiz questions provider
final doshaQuizQuestionsProvider = Provider<List<DoshaQuestion>>((ref) {
  return DoshaQuizData.questions;
});

/// Current quiz question provider
final currentQuizQuestionProvider = Provider<DoshaQuestion>((ref) {
  final questions = ref.watch(doshaQuizQuestionsProvider);
  final quizState = ref.watch(quizProvider);
  return questions[quizState.currentQuestionIndex];
});

/// Quiz progress provider (0.0 to 1.0)
final quizProgressProvider = Provider<double>((ref) {
  final quizState = ref.watch(quizProvider);
  final totalQuestions = DoshaQuizData.questions.length;
  return (quizState.currentQuestionIndex + 1) / totalQuestions;
});

/// Selected answer for current question
final currentSelectedAnswerProvider = Provider<int?>((ref) {
  final quizState = ref.watch(quizProvider);
  if (quizState.currentQuestionIndex < quizState.selectedAnswers.length) {
    return quizState.selectedAnswers[quizState.currentQuestionIndex];
  }
  return null;
});
