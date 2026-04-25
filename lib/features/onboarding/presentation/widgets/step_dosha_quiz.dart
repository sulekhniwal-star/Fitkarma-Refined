import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepDoshaQuiz extends ConsumerStatefulWidget {
  const StepDoshaQuiz({super.key});

  @override
  ConsumerState<StepDoshaQuiz> createState() => _StepDoshaQuizState();
}

class _StepDoshaQuizState extends ConsumerState<StepDoshaQuiz> {
  int _currentQuestionIndex = 0;
  bool _showResult = false;

  static const List<Map<String, dynamic>> _questions = [
    {
      'question': 'How would you describe your digestion?',
      'questionHi': 'आपका पाचन कैसा है?',
      'options': [
        ('Irregular, often feel hungry or no appetite', 'अनियमित, अक्सर भूख या भूख नहीं लगना'),
        ('Strong, digest quickly, get hungry often', 'मजबूत, जल्दी पचता है, अक्सर भूख लगती है'),
        ('Slow, feel full for long periods', 'धीमा, लंबे समय तक भरा हुआ महसूस'),
      ],
    },
    {
      'question': 'What\'s your typical energy level throughout the day?',
      'questionHi': 'दिन भर आपकी ऊर्जा का स्तर कैसा रहता है?',
      'options': [
        ('Fluctuating, often feel energetic but sometimes fatigued', 'उतार-चढ़ाव, कभी ऊर्जावान कभी थका हुआ'),
        ('High, consistently energetic', 'उच्च, लगातार ऊर्जावान'),
        ('Steady, but can feel sluggish', 'स्थिर, लेकिन सुस्त लग सकता है'),
      ],
    },
    {
      'question': 'How would you describe your body frame?',
      'questionHi': 'आप अपने शरीर की संरचना का वर्णन कैसे करेंगे?',
      'options': [
        ('Thin, slender, often feel cold', 'पतला, लंबा, अक्सर ठंड लगता है'),
        ('Medium build, warm body temperature', 'मध्यम बनावट, गर्म शरीर का तापमान'),
        ('Stocky, gain weight easily', 'मोटा, आसानी से वजन बढ़ता है'),
      ],
    },
    {
      'question': 'How\'s your skin generally?',
      'questionHi': 'आपकी त्वचा कैसी होती है?',
      'options': [
        ('Dry, rough, prone to cracking', 'शुष्क, खुरदरा, दरारें आती हैं'),
        ('Oily, prone to rashes or acne', 'तेलीय, दाने या जलन होती है'),
        ('Smooth, thick, oily in some areas', 'मुलायम, कुछ जगहों पर तेलीय'),
      ],
    },
    {
      'question': 'How do you usually sleep?',
      'questionHi': 'आप आमतौर पर कैसे सोते हैं?',
      'options': [
        ('Light sleeper, often wake up', 'हल्की नींद, अक्सर जाग जाते हैं'),
        ('Sound sleeper, sleep deeply', 'गहरी नींद'),
        ('Heavy sleeper, hard to wake up', 'गहरी नींद, जागने में कठिनाई'),
      ],
    },
    {
      'question': 'How do you react to weather changes?',
      'questionHi': 'मौसम बदलाव पर आपकी प्रतिक्रिया कैसी होती है?',
      'options': [
        ('Dislike cold, prefer warm weather', 'ठंड पसंद नहीं, गर्म मौसम पसंद'),
        ('Dislike heat, prefer cooler weather', 'गर्मी पसंद नहीं, ठंडा मौसम पसंद'),
        ('Comfortable in most weather', 'अधिकांश मौसम में सहज'),
      ],
    },
  ];

  void _selectOption(int optionIndex) {
    ref.read(onboardingProvider.notifier).setDoshaAnswer(_currentQuestionIndex, optionIndex);
    
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() => _currentQuestionIndex++);
    } else {
      ref.read(onboardingProvider.notifier).calculateDosha();
      setState(() => _showResult = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    
    if (_showResult || state.determinedDosha != null) {
      final dosha = state.determinedDosha ?? DoshaType.balanced;
      final doshaColor = _getDoshaColor(dosha);
      
      return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: doshaColor.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: doshaColor.withValues(alpha: 0.5), width: 2),
                    ),
                    child: Icon(_getDoshaIcon(dosha), size: 40, color: doshaColor),
                  ),
                  const SizedBox(height: 16),
                  Text('Your Dominant Prakriti', style: AppTheme.caption(context)),
                  Text(
                    dosha.labelEn,
                    style: AppTheme.displayMd(context).copyWith(color: doshaColor),
                  ),
                  Text(
                    dosha.labelHi,
                    style: AppTheme.hindi(context).copyWith(fontSize: 18, color: AppTheme.textSecondary),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _getDoshaDescription(dosha),
                    style: AppTheme.bodyMd(context).copyWith(color: AppTheme.textSecondary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Element Distribution', style: AppTheme.labelMd(context)),
                  const SizedBox(height: 20),
                  _buildDoshaBar(context, 'Vata', _calculateVataPercent(state.doshaAnswers).toDouble(), AppTheme.secondary),
                  const SizedBox(height: 16),
                  _buildDoshaBar(context, 'Pitta', _calculatePittaPercent(state.doshaAnswers).toDouble(), AppTheme.primary),
                  const SizedBox(height: 16),
                  _buildDoshaBar(context, 'Kapha', _calculateKaphaPercent(state.doshaAnswers).toDouble(), AppTheme.teal),
                ],
              ),
            ),
          ],
        ),
      );
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Body Type Quiz', style: AppTheme.labelMd(context)),
                  Text(
                    '${_currentQuestionIndex + 1}/${_questions.length}',
                    style: AppTheme.labelMd(context).copyWith(color: AppTheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                child: LinearProgressIndicator(
                  value: (_currentQuestionIndex + 1) / _questions.length,
                  backgroundColor: AppTheme.surface2,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                  minHeight: 6,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentQuestion['question'] as String,
                  style: AppTheme.h1(context),
                ),
                Text(
                  currentQuestion['questionHi'] as String,
                  style: AppTheme.hindi(context).copyWith(fontSize: 16, color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 32),
                
                ...List.generate((currentQuestion['options'] as List).length, (index) {
                  final option = (currentQuestion['options'] as List)[index] as (String, String);
                  final isCurrentlySelected = state.doshaAnswers.length > _currentQuestionIndex &&
                      state.doshaAnswers[_currentQuestionIndex] == index;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => _selectOption(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: isCurrentlySelected ? AppTheme.primaryMuted : AppTheme.glass,
                          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                          border: Border.all(
                            color: isCurrentlySelected ? AppTheme.primary : AppTheme.glassBorder,
                            width: isCurrentlySelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isCurrentlySelected ? AppTheme.primary : AppTheme.textSecondary,
                                  width: 2,
                                ),
                                color: isCurrentlySelected ? AppTheme.primary : Colors.transparent,
                              ),
                              child: isCurrentlySelected
                                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                                  : null,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    option.$1,
                                    style: AppTheme.labelLg(context).copyWith(
                                      color: isCurrentlySelected ? AppTheme.textPrimary : AppTheme.textPrimary.withValues(alpha: 0.8),
                                    ),
                                  ),
                                  Text(
                                    option.$2,
                                    style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary),
                                  ),
                                ],
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
      ],
    );
  }

  Widget _buildDoshaBar(BuildContext context, String label, double percent, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.bodyMd(context).copyWith(color: AppTheme.textSecondary)),
            Text('${percent.toInt()}%', style: AppTheme.labelMd(context).copyWith(color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
          child: LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: AppTheme.surface2,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Color _getDoshaColor(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
      case DoshaType.vataPitta:
      case DoshaType.vataKapha:
        return AppTheme.secondary;
      case DoshaType.pitta:
      case DoshaType.pittaKapha:
        return AppTheme.primary;
      case DoshaType.kapha:
        return AppTheme.teal;
      case DoshaType.balanced:
        return AppTheme.accent;
    }
  }

  IconData _getDoshaIcon(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
      case DoshaType.vataPitta:
      case DoshaType.vataKapha:
        return Icons.air;
      case DoshaType.pitta:
      case DoshaType.pittaKapha:
        return Icons.local_fire_department;
      case DoshaType.kapha:
        return Icons.water_drop;
      case DoshaType.balanced:
        return Icons.balance;
    }
  }

  String _getDoshaDescription(DoshaType dosha) {
    switch (dosha) {
      case DoshaType.vata:
        return 'Light and creative energy. Focus on routine and warmth for balance.';
      case DoshaType.pitta:
        return 'Strong and intense energy. Focus on cooling foods and moderation.';
      case DoshaType.kapha:
        return 'Steady and grounded energy. Focus on movement and light foods.';
      case DoshaType.balanced:
        return 'Harmonious constitution. Maintain balance with a varied routine.';
      default:
        return 'A unique combination of elements. We will tailor your journey accordingly.';
    }
  }

  int _calculateVataPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int vata = answers.where((a) => a == 0).length;
    return (vata / _questions.length * 100).round();
  }

  int _calculatePittaPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int pitta = answers.where((a) => a == 1).length;
    return (pitta / _questions.length * 100).round();
  }

  int _calculateKaphaPercent(List<int> answers) {
    if (answers.isEmpty) return 33;
    int kapha = answers.where((a) => a == 2).length;
    return (kapha / _questions.length * 100).round();
  }
}
