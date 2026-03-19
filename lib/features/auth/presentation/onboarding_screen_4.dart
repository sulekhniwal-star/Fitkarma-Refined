import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/onboarding_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/dosha_chart.dart';

class OnboardingScreen4 extends ConsumerStatefulWidget {
  const OnboardingScreen4({super.key});

  @override
  ConsumerState<OnboardingScreen4> createState() => _OnboardingScreen4State();
}

class _OnboardingScreen4State extends ConsumerState<OnboardingScreen4> {
  late Map<int, int> _answers;
  int _currentQuestion = 0;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _answers = {};
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingStateProvider).state;
      _answers = Map.from(state.doshaQuizAnswers);
      if (_answers.length >= 12) {
        _showResult = true;
      }
    });
  }

  void _selectAnswer(int answerIndex) {
    setState(() {
      _answers[_currentQuestion + 1] = answerIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestion < 11) {
      setState(() {
        _currentQuestion++;
      });
    } else {
      // Calculate dosha percentages
      _calculateDosha();
      setState(() {
        _showResult = true;
      });
    }
  }

  void _previousQuestion() {
    if (_currentQuestion > 0) {
      setState(() {
        _currentQuestion--;
      });
    }
  }

  void _calculateDosha() {
    double vata = 0, pitta = 0, kapha = 0;

    for (final entry in _answers.entries) {
      final answer = entry.value;
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
          vata += 0.33;
          pitta += 0.33;
          kapha += 0.33;
          break;
      }
    }

    final total = vata + pitta + kapha;
    double? vataPct, pittaPct, kaphaPct;
    String? dominant;

    if (total > 0) {
      vataPct = (vata / total) * 100;
      pittaPct = (pitta / total) * 100;
      kaphaPct = (kapha / total) * 100;

      if (vataPct >= pittaPct && vataPct >= kaphaPct) {
        dominant = 'vata';
      } else if (pittaPct >= vataPct && pittaPct >= kaphaPct) {
        dominant = 'pitta';
      } else {
        dominant = 'kapha';
      }
    }

    final notifier = ref.read(onboardingStateProvider);
    final currentState = notifier.state;
    notifier.updateState(
      currentState.copyWith(
        doshaQuizAnswers: _answers,
        vataPercentage: vataPct,
        pittaPercentage: pittaPct,
        kaphaPercentage: kaphaPct,
        dominantDosha: dominant,
      ),
    );
  }

  void _saveAndNext() {
    context.go('/onboarding/5');
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(doshaQuizQuestionsProvider);

    if (_showResult) {
      return _buildResultScreen();
    }

    final currentQ = questions[_currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayurveda Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/3'),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: (_currentQuestion + 1) / questions.length,
                    backgroundColor: AppColors.divider,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_currentQuestion + 1} of ${questions.length}',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        '${_answers.length}/${questions.length} answered',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Question
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentQ.question, style: AppTextStyles.h3),
                    const SizedBox(height: 24),

                    // Options
                    ...List.generate(currentQ.options.length, (index) {
                      final option = currentQ.options[index];
                      final isSelected =
                          _answers[_currentQuestion + 1] == index;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () => _selectAnswer(index),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.primarySurface
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.divider,
                                width: isSelected ? 2 : 1,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                      width: 2,
                                    ),
                                    color: isSelected
                                        ? AppColors.primary
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(
                                          Icons.check,
                                          size: 16,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    option,
                                    style: AppTextStyles.bodyMedium.copyWith(
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  if (_currentQuestion > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _previousQuestion,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Previous'),
                      ),
                    ),
                  if (_currentQuestion > 0) const SizedBox(width: 16),
                  Expanded(
                    flex: _currentQuestion > 0 ? 1 : 2,
                    child: ElevatedButton(
                      onPressed: _answers.containsKey(_currentQuestion + 1)
                          ? _nextQuestion
                          : null,
                      child: Text(
                        _currentQuestion < 11 ? 'Next' : 'See Results',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultScreen() {
    final state = ref.watch(onboardingStateProvider).state;
    final vata = state.vataPercentage ?? 0;
    final pitta = state.pittaPercentage ?? 0;
    final kapha = state.kaphaPercentage ?? 0;
    final dominant = state.dominantDosha ?? 'vata';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Dosha'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Your Ayurvedic Constitution', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Text(
                'Based on your responses',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Dosha Chart
              DoshaDonutChart(
                vata: vata,
                pitta: pitta,
                kapha: kapha,
                size: 220,
              ),
              const SizedBox(height: 32),

              // Dosha breakdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _DoshaBreakdown(
                    name: 'Vata',
                    percentage: vata,
                    color: AppColors.purple,
                    description: 'Air & Space',
                  ),
                  _DoshaBreakdown(
                    name: 'Pitta',
                    percentage: pitta,
                    color: AppColors.primary,
                    description: 'Fire & Water',
                  ),
                  _DoshaBreakdown(
                    name: 'Kapha',
                    percentage: kapha,
                    color: AppColors.teal,
                    description: 'Earth & Water',
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Dominant dosha description
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Your dominant dosha is',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dominant.toUpperCase(),
                      style: AppTextStyles.h2.copyWith(
                        color: dominant == 'vata'
                            ? AppColors.purple
                            : dominant == 'pitta'
                            ? AppColors.primary
                            : AppColors.teal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getDoshaDescription(dominant),
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAndNext,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getDoshaDescription(String dosha) {
    switch (dosha) {
      case 'vata':
        return 'You have a Vata dominant constitution. You tend to be creative, energetic, and quick-thinking. Focus on warmth, routine, and hydration.';
      case 'pitta':
        return 'You have a Pitta dominant constitution. You tend to be focused, determined, and ambitious. Focus on cooling activities and moderation.';
      case 'kapha':
        return 'You have a Kapha dominant constitution. You tend to be calm, patient, and supportive. Focus on stimulation and regular exercise.';
      default:
        return 'You have a balanced constitution across all three doshas.';
    }
  }
}

class _DoshaBreakdown extends StatelessWidget {
  final String name;
  final double percentage;
  final Color color;
  final String description;

  const _DoshaBreakdown({
    required this.name,
    required this.percentage,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${percentage.toStringAsFixed(0)}%',
              style: AppTextStyles.labelMedium.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name, style: AppTextStyles.labelLarge.copyWith(color: color)),
        Text(
          description,
          style: AppTextStyles.caption.copyWith(color: AppColors.textMuted),
        ),
      ],
    );
  }
}
