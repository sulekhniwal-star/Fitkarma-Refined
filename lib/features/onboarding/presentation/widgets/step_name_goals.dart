import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/config/app_theme.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepNameGoals extends ConsumerStatefulWidget {
  const StepNameGoals({super.key});

  @override
  ConsumerState<StepNameGoals> createState() => _StepNameGoalsState();
}

class _StepNameGoalsState extends ConsumerState<StepNameGoals> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: ref.read(onboardingProvider).displayName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    
    final goals = [
      (OnboardingGoal.loseWeight, Icons.monitor_weight_outlined, 'Lose Weight', 'वजन कम करें'),
      (OnboardingGoal.gainMuscle, Icons.fitness_center_outlined, 'Build Muscle', 'मांसपेशियां बढ़ाएं'),
      (OnboardingGoal.maintain, Icons.spa_outlined, 'Wellness', 'स्वस्थ रहें'),
      (OnboardingGoal.endurance, Icons.directions_run_outlined, 'Endurance', 'सहनशक्ति बढ़ाएं'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Who are you?',
            style: AppTheme.displayMd(context),
          ),
          Text(
            'आपका परिचय',
            style: AppTheme.hindi(context).copyWith(
              color: AppTheme.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          Text(
            'Preferred Name',
            style: AppTheme.labelMd(context),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            onChanged: (value) => ref.read(onboardingProvider.notifier).setDisplayName(value),
            style: AppTheme.bodyMd(context),
            decoration: InputDecoration(
              hintText: 'e.g. Rahul',
              filled: true,
              fillColor: AppTheme.glass,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 40),
          
          Text(
            'Your Primary Goal',
            style: AppTheme.labelMd(context),
          ),
          const SizedBox(height: 4),
          Text(
            'आपका मुख्य लक्ष्य क्या है?',
            style: AppTheme.caption(context),
          ),
          const SizedBox(height: 16),
          
          ...goals.map((goalData) {
            final goal = goalData.$1;
            final icon = goalData.$2;
            final labelEn = goalData.$3;
            final labelHi = goalData.$4;
            final isSelected = state.goal == goal;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => ref.read(onboardingProvider.notifier).setGoal(goal),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryMuted : AppTheme.glass,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(
                      color: isSelected ? AppTheme.primary : AppTheme.glassBorder,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.primary : AppTheme.surface2,
                          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected ? Colors.white : AppTheme.textSecondary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labelEn,
                              style: AppTheme.labelLg(context).copyWith(
                                color: isSelected ? AppTheme.textPrimary : AppTheme.textPrimary.withValues(alpha: 0.8),
                              ),
                            ),
                            Text(
                              labelHi,
                              style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        const Icon(Icons.check_circle, color: AppTheme.primary, size: 24),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
