// lib/features/ayurveda/data/dosha_quiz_data.dart
// 12-question Dosha quiz with scoring

import 'package:fitkarma/features/ayurveda/data/ayurveda_models.dart';

/// Dosha quiz questions with scoring
class DoshaQuizData {
  static const List<DoshaQuestion> questions = [
    // Question 1 - Physical constitution
    DoshaQuestion(
      id: 1,
      question: 'How would you describe your body frame?',
      answers: [
        DoshaAnswer(
          text: 'Thin, slender, with prominent joints and veins',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Medium build, well-proportioned, muscular',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Stocky, broad shouldered, easy to gain weight',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 2 - Skin
    DoshaQuestion(
      id: 2,
      question: 'How would you describe your skin?',
      answers: [
        DoshaAnswer(
          text: 'Dry, cool, rough, tendency to crack',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Warm, soft, oily in T-zone, prone to rashes',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Thick, smooth, pale, well-moisturized',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 3 - Energy levels
    DoshaQuestion(
      id: 3,
      question: 'What best describes your energy levels throughout the day?',
      answers: [
        DoshaAnswer(
          text: 'Variable - lots of energy then suddenly tired',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Consistent - steady energy, can overdo it',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Slow but steady - need time to get going',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 4 - Digestion
    DoshaQuestion(
      id: 4,
      question: 'How is your digestion?',
      answers: [
        DoshaAnswer(
          text: 'Irregular - often constipated, bloated, gas',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Strong - get hungry often, acid/heartburn sometimes',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Slow - feel full easily, heavy after meals',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 5 - Weather preference
    DoshaQuestion(
      id: 5,
      question: 'How do you typically respond to weather?',
      answers: [
        DoshaAnswer(
          text: 'Dislike cold - feel dry, stiff, anxious in cold',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Dislike heat - feel irritable, sweaty in warm weather',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Tolerate most weather - can feel sluggish in humidity',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 6 - Sleep
    DoshaQuestion(
      id: 6,
      question: 'How is your sleep?',
      answers: [
        DoshaAnswer(
          text: 'Light, easily disturbed, often wake up anxious',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Moderate, sometimes hot, vivid dreams',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Deep, long, hard to wake up',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 7 - Mind
    DoshaQuestion(
      id: 7,
      question: 'How would you describe your mind and mental style?',
      answers: [
        DoshaAnswer(
          text: 'Creative, quick learner, but easily distracted',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Sharp, focused, ambitious, can be critical',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Calm, steady, methodical, but can be slow',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 8 - Emotions
    DoshaQuestion(
      id: 8,
      question: 'What emotions do you experience most?',
      answers: [
        DoshaAnswer(
          text: 'Anxiety, worry, fear, nervousness',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Anger, frustration, impatience, jealousy',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Contentment, attachment, sadness, greed',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 9 - Appetite
    DoshaQuestion(
      id: 9,
      question: 'How is your appetite?',
      answers: [
        DoshaAnswer(
          text: 'Erratic - sometimes forget to eat, prefer snacks',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Strong - get irritable if meals delayed',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Moderate - can skip meals easily',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 10 - Sweating
    DoshaQuestion(
      id: 10,
      question: 'How do you sweat?',
      answers: [
        DoshaAnswer(
          text: 'Little - rarely sweat, hands/feet often cold',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Moderate - sweat easily, especially in heat',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Heavy - sweat a lot, especially with exertion',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 11 - Exercise
    DoshaQuestion(
      id: 11,
      question: 'How do you approach exercise?',
      answers: [
        DoshaAnswer(
          text: 'Enjoy variety, get bored easily, prefer light activities',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Love challenging workouts, competitive, push hard',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Prefer gentle, slow exercises, avoid overexertion',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),

    // Question 12 - Memory
    DoshaQuestion(
      id: 12,
      question: 'How is your memory?',
      answers: [
        DoshaAnswer(
          text: 'Quick to learn, quick to forget',
          vataScore: 3,
          pittaScore: 0,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Sharp, good recall, especially for facts',
          vataScore: 0,
          pittaScore: 3,
          kaphaScore: 0,
        ),
        DoshaAnswer(
          text: 'Slow to learn, but long-term memory is strong',
          vataScore: 0,
          pittaScore: 0,
          kaphaScore: 3,
        ),
      ],
    ),
  ];

  /// Calculate dosha scores from answers
  static DoshaResult calculateResult(List<int> selectedAnswers) {
    int vataScore = 0;
    int pittaScore = 0;
    int kaphaScore = 0;

    for (int i = 0; i < questions.length && i < selectedAnswers.length; i++) {
      final answerIndex = selectedAnswers[i];
      if (answerIndex >= 0 && answerIndex < questions[i].answers.length) {
        final answer = questions[i].answers[answerIndex];
        vataScore += answer.vataScore;
        pittaScore += answer.pittaScore;
        kaphaScore += answer.kaphaScore;
      }
    }

    return DoshaResult.fromScores(vataScore, pittaScore, kaphaScore);
  }
}
