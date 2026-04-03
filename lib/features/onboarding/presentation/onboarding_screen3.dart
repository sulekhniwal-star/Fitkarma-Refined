import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen3 extends ConsumerStatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  ConsumerState<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends ConsumerState<OnboardingScreen3> {
  final Set<String> _selectedConditions = {};

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    final conditions = isHindi
        ? [
            ('diabetes', 'मधुमेह', '🩸', 'शugar level management'),
            ('hypertension', 'उच्च रक्तचाप', '💓', 'Blood pressure'),
            ('pcod', 'PCOD', '🔄', 'Hormonal balance'),
            ('hypothyroidism', 'हाइपोथायरॉयडिज्म', '🧠', 'Thyroid'),
            ('asthma', 'अस्थमा', '🫁', 'Respiratory'),
          ]
        : [
            ('diabetes', 'Diabetes', '🩸', 'Sugar level management'),
            ('hypertension', 'Hypertension', '💓', 'Blood pressure'),
            ('pcod', 'PCOD', '🔄', 'Hormonal balance'),
            ('hypothyroidism', 'Hypothyroidism', '🧠', 'Thyroid'),
            ('asthma', 'Asthma', '🫁', 'Respiratory'),
          ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'स्वास्थ्य स्थिति' : 'Health Conditions'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isHindi
                    ? 'क्या आपको कोई पुरानी बीमारी है?'
                    : 'Do you have any chronic conditions?',
                style: AppTextStyles.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                isHindi
                    ? 'यह हमें आपके लिए बेहतर योजना बनाने में मदद करेगा'
                    : 'This helps us create a better plan for you',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: conditions.map((c) {
                    final isSelected = _selectedConditions.contains(c.$1);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedConditions.remove(c.$1);
                            } else {
                              _selectedConditions.add(c.$1);
                            }
                          });
                          ref
                              .read(onboardingStateProvider.notifier)
                              .updateChronicConditions(_selectedConditions.toList());
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary.withValues(alpha: 0.1)
                                : Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : Colors.grey.shade300,
                              width: isSelected ? 2 : 1,
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
                                    color: isSelected ? AppColors.primary : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                  color: isSelected ? AppColors.primary : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Text(c.$3, style: const TextStyle(fontSize: 24)),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      c.$2,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected ? AppColors.primary : Colors.black87,
                                      ),
                                    ),
                                    Text(
                                      c.$4,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/onboarding/4'),
                  child: Text(
                    isHindi ? 'छोड़ें →' : 'Skip →',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => context.go('/onboarding/2'),
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
                    onPressed: () => context.go('/onboarding/4'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}