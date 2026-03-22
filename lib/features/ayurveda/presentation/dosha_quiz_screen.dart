// lib/features/ayurveda/presentation/dosha_quiz_screen.dart
// Dosha quiz screen with 12 questions

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/ayurveda/data/ayurveda_providers.dart';
import 'package:fitkarma/features/ayurveda/data/dosha_quiz_data.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class DoshaQuizScreen extends ConsumerWidget {
  const DoshaQuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final questions = ref.watch(doshaQuizQuestionsProvider);
    final currentQuestion = questions[quizState.currentQuestionIndex];
    final progress = ref.watch(quizProgressProvider);
    final selectedAnswer = ref.watch(currentSelectedAnswerProvider);

    if (quizState.isCompleted) {
      return _buildResultScreen(context, ref);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dosha Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          // Progress bar
          LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.surface,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),

          // Question counter
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Question ${quizState.currentQuestionIndex + 1} of ${questions.length}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(progress * 100).round()}%',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Question
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentQuestion.question,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Answer options
                  ...List.generate(currentQuestion.answers.length, (index) {
                    final answer = currentQuestion.answers[index];
                    final isSelected = selectedAnswer == index;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          ref.read(quizProvider.notifier).selectAnswer(index);
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.divider,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isSelected
                                    ? Icons.radio_button_checked
                                    : Icons.radio_button_off,
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.textSecondary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  answer.text,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Navigation buttons
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (quizState.currentQuestionIndex > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          ref.read(quizProvider.notifier).previousQuestion();
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Previous'),
                      ),
                    )
                  else
                    const Spacer(),

                  const SizedBox(width: 16),

                  Expanded(
                    child: FilledButton(
                      onPressed: selectedAnswer != null
                          ? () {
                              if (quizState.currentQuestionIndex <
                                  questions.length - 1) {
                                ref.read(quizProvider.notifier).nextQuestion();
                              } else {
                                ref.read(quizProvider.notifier).submitQuiz();
                              }
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        quizState.currentQuestionIndex < questions.length - 1
                            ? 'Next'
                            : 'See Results',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultScreen(BuildContext context, WidgetRef ref) {
    final doshaResult = ref.watch(doshaResultProvider);

    if (doshaResult == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Your Dosha Profile')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),

            // Result icon
            Text(
              doshaResult.dominantDosha.name.contains('vata')
                  ? '🌬️'
                  : doshaResult.dominantDosha.name.contains('pitta')
                  ? '🔥'
                  : doshaResult.dominantDosha.name.contains('kapha')
                  ? '💧'
                  : '⚖️',
              style: const TextStyle(fontSize: 80),
            ),

            const SizedBox(height: 16),

            // Dominant dosha
            Text(
              doshaResult.dominantDosha.displayName,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              doshaResult.dominantDosha.description,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
            ),

            const SizedBox(height: 32),

            // Donut chart placeholder (will implement full chart in profile screen)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    'Dosha Balance',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDoshaStat('Vata', doshaResult.vataPercent, '🌬️'),
                      _buildDoshaStat('Pitta', doshaResult.pittaPercent, '🔥'),
                      _buildDoshaStat('Kapha', doshaResult.kaphaPercent, '💧'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action buttons
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => context.go('/ayurveda/profile'),
                child: const Text('View Full Profile'),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  ref.read(quizProvider.notifier).resetQuiz();
                },
                child: const Text('Retake Quiz'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoshaStat(String name, int percent, String emoji) {
    return Column(
      children: [
        Text(emoji, style: const TextStyle(fontSize: 24)),
        const SizedBox(height: 4),
        Text(
          '$percent%',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(
          name,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }
}
