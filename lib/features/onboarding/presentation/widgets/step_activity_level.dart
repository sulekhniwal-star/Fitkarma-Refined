import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/config/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepActivityLevel extends ConsumerWidget {
  const StepActivityLevel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    
    final activityLevels = [
      (ActivityLevel.sedentary, Icons.weekend_outlined, 'Sedentary', 'निष्क्रिय', 'Office work, little movement'),
      (ActivityLevel.light, Icons.directions_walk_outlined, 'Lightly Active', 'हल्का सक्रिय', 'Light exercise 1-3 days/week'),
      (ActivityLevel.moderate, Icons.directions_run_outlined, 'Moderately Active', 'मध्यम सक्रिय', 'Moderate exercise 3-5 days/week'),
      (ActivityLevel.active, Icons.fitness_center_outlined, 'Very Active', 'अत्यधिक सक्रिय', 'High intensity 6-7 days/week'),
      (ActivityLevel.veryActive, Icons.sports_gymnastics_outlined, 'Extra Active', 'अतिरिक्त सक्रिय', 'Professional athlete / Physical labor'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Active Pulse',
            style: AppTheme.displayMd(context),
          ),
          Text(
            'आपकी सक्रियता का स्तर',
            style: AppTheme.hindi(context).copyWith(
              color: AppTheme.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          ...activityLevels.map((levelData) {
            final level = levelData.$1;
            final icon = levelData.$2;
            final labelEn = levelData.$3;
            final desc = levelData.$5;
            final isSelected = state.activityLevel == level;
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => ref.read(onboardingProvider.notifier).setActivityLevel(level),
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
                            const SizedBox(height: 2),
                            Text(
                              desc,
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
          
          const SizedBox(height: 32),
          
          GlassCard(
            child: Column(
              children: [
                Text(
                  'Daily Calorie Maintenance (TDEE)',
                  style: AppTheme.caption(context),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      state.tdee.toInt().toString(),
                      style: AppTheme.displayLg(context).copyWith(
                        color: AppTheme.primary,
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'kcal/day',
                      style: AppTheme.bodyMd(context).copyWith(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                  ),
                  child: Text(
                    'Mifflin-St Jeor Estimation',
                    style: AppTheme.caption(context).copyWith(color: AppTheme.primary, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          Text(
            'Goal Influence',
            style: AppTheme.labelMd(context),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildGoalMini(context, 'Fat Loss', '-500', AppTheme.primary),
              _buildGoalMini(context, 'Maintenance', '0', AppTheme.warning),
              _buildGoalMini(context, 'Lean Gain', '+250', AppTheme.success),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGoalMini(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label, style: AppTheme.caption(context), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.labelLg(context).copyWith(color: color),
          ),
          Text('kcal', style: AppTheme.caption(context).copyWith(fontSize: 10)),
        ],
      ),
    );
  }
}
