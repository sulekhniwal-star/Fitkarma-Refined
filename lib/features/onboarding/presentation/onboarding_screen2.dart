import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen2 extends ConsumerStatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  ConsumerState<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends ConsumerState<OnboardingScreen2> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedGoal;
  String? _selectedActivity;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'आपकी फिटनेस' : 'Your Fitness Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeightWeightInputs(isHindi),
              const SizedBox(height: 32),
              _buildFitnessGoalSection(isHindi),
              const SizedBox(height: 32),
              _buildActivityLevelSection(isHindi),
              const SizedBox(height: 40),
              _buildNavigationButtons(isHindi),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeightWeightInputs(bool isHindi) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'ऊंचाई (cm)' : 'Height (cm)',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(3),
                    ],
                    decoration: InputDecoration(
                      hintText: isHindi ? 'सेमी' : 'cm',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.height),
                    ),
                    onChanged: (value) {
                      final height = double.tryParse(value);
                      if (height != null) {
                        ref.read(onboardingStateProvider.notifier).updateHeight(height);
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'वजन (kg)' : 'Weight (kg)',
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _weightController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                      LengthLimitingTextInputFormatter(5),
                    ],
                    decoration: InputDecoration(
                      hintText: isHindi ? 'किलो' : 'kg',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.monitor_weight_outlined),
                    ),
                    onChanged: (value) {
                      final weight = double.tryParse(value);
                      if (weight != null) {
                        ref.read(onboardingStateProvider.notifier).updateWeight(weight);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFitnessGoalSection(bool isHindi) {
    final goals = isHindi
        ? [
            ('weight_loss', 'वजन कम करें', '⚖️', 'लंबे समय में स्वस्थ रहें'),
            ('muscle_gain', 'मांसपेशियां बढ़ाएं', '💪', 'शक्ति और मांसपेशियां'),
            ('maintain', 'वजन बनाए रखें', '🎯', 'स्वस्थ वजन बनाए रखें'),
            ('endurance', 'सहनशक्ति बढ़ाएं', '🏃', 'धीरज और ऊर्जा'),
          ]
        : [
            ('weight_loss', 'Lose Weight', '⚖️', 'Long-term health'),
            ('muscle_gain', 'Build Muscle', '💪', 'Strength & mass'),
            ('maintain', 'Maintain Weight', '🎯', 'Stay healthy'),
            ('endurance', 'Build Endurance', '🏃', 'Stamina & energy'),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'आपका लक्ष्य क्या है?' : 'What is your fitness goal?',
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: goals.map((g) {
            final isSelected = _selectedGoal == g.$1;
            return GestureDetector(
              onTap: () {
                setState(() => _selectedGoal = g.$1);
                ref.read(onboardingStateProvider.notifier).updateFitnessGoal(g.$1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: (MediaQuery.of(context).size.width - 60) / 2,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(g.$3, style: const TextStyle(fontSize: 28)),
                    const SizedBox(height: 8),
                    Text(
                      g.$2,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.primary : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      g.$4,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActivityLevelSection(bool isHindi) {
    final activities = isHindi
        ? [
            ('sedentary', 'बैठक का काम', '🪑', 'कम शारीरिक गतिविधि'),
            ('light', 'हल्की गतिविधि', '🚶', 'हल्की सैर या व्यायाम'),
            ('moderate', 'मध्यम गतिविधि', '🏋️', 'साप्ताहिक व्यायाम'),
            ('active', 'सक्रिय', '🏃', 'दैनिक व्यायाम'),
            ('very_active', 'बहुत सक्रिय', '🔥', 'कठोर प्रशिक्षण'),
          ]
        : [
            ('sedentary', 'Sedentary', '🪑', 'Desk job, little exercise'),
            ('light', 'Light Activity', '🚶', 'Light walking/exercise'),
            ('moderate', 'Moderate', '🏋️', 'Exercise 3-5 days/week'),
            ('active', 'Active', '🏃', 'Daily exercise'),
            ('very_active', 'Very Active', '🔥', 'Intense training'),
          ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isHindi ? 'आपकी दैनिक गतिविधि स्तर' : 'Your daily activity level',
          style: AppTextStyles.titleMedium,
        ),
        const SizedBox(height: 12),
        ...activities.map((a) {
          final isSelected = _selectedActivity == a.$1;
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedActivity = a.$1);
                ref.read(onboardingStateProvider.notifier).updateActivityLevel(a.$1);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(a.$3, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.$2,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? AppColors.primary : Colors.black87,
                            ),
                          ),
                          Text(
                            a.$4,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isSelected)
                      const Icon(Icons.check_circle, color: AppColors.primary),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildNavigationButtons(bool isHindi) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => context.go('/onboarding/1'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(isHindi ? 'पीछे' : 'Back'),
        ),
        const Spacer(),
        FilledButton(
          onPressed: _canProceed() ? () => context.go('/onboarding/3') : null,
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isHindi ? 'आगे बढ़ें' : 'Continue',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  bool _canProceed() {
    return _heightController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _selectedGoal != null &&
        _selectedActivity != null;
  }
}