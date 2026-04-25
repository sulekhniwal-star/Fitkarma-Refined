import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepHealthConditions extends ConsumerWidget {
  const StepHealthConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    
    final conditions = [
      (ChronicCondition.diabetes, Icons.bloodtype_outlined, 'Diabetes', 'मधुमेह'),
      (ChronicCondition.hypertension, Icons.favorite_outline, 'Hypertension', 'उच्च रक्तचाप'),
      (ChronicCondition.pcodPcos, Icons.woman_outlined, 'PCOD/PCOS', 'पीसीओडी/पीसीओएस'),
      (ChronicCondition.hypothyroidism, Icons.medical_services_outlined, 'Hypothyroidism', 'थायरॉयड'),
      (ChronicCondition.asthma, Icons.air_outlined, 'Asthma', 'दमा'),
    ];
    
    final permissions = [
      ('steps', Icons.directions_walk, 'Steps & Activity', 'Track your daily steps', 'दैनिक कदम ट्रैक करें'),
      ('heart', Icons.favorite, 'Heart Rate', 'Monitor your heart rate', 'हृदय गति की निगरानी करें'),
      ('sleep', Icons.bedtime, 'Sleep Data', 'Sync your sleep patterns', 'नींद के पैटर्न को सिंक करें'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Conditions',
            style: AppTheme.h1(context),
          ),
          Text(
            'स्वास्थ्य की स्थिति',
            style: AppTheme.hindi(context).copyWith(fontSize: 16, color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 32),
          
          Text(
            'Do you have any existing conditions?',
            style: AppTheme.labelMd(context).copyWith(color: AppTheme.textSecondary),
          ),
          const SizedBox(height: 16),
          
          ...conditions.map((conditionData) {
            final condition = conditionData.$1;
            final isSelected = state.chronicConditions.contains(condition);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () => ref.read(onboardingProvider.notifier).toggleChronicCondition(condition),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryMuted : AppTheme.glass,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    border: Border.all(
                      color: isSelected ? AppTheme.primary : AppTheme.glassBorder,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        conditionData.$2,
                        color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(conditionData.$3, style: AppTheme.labelLg(context)),
                            Text(conditionData.$4, style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary)),
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
          
          const SizedBox(height: 12),
          
          // None option
          GestureDetector(
            onTap: () => ref.read(onboardingProvider.notifier).toggleChronicCondition(ChronicCondition.none),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                    ? AppTheme.teal.withValues(alpha: 0.1)
                    : AppTheme.glass,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(
                  color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                      ? AppTheme.teal
                      : AppTheme.divider,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                        ? AppTheme.teal
                        : AppTheme.textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text('None of the above', style: AppTheme.labelLg(context)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 48),
          
          // Permissions section
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.security_outlined, color: AppTheme.primary),
                    const SizedBox(width: 12),
                    Text('Data Sync Permissions', style: AppTheme.h3(context)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Enable these for more accurate fitness tracking and personalized insights.',
                  style: AppTheme.bodySm(context).copyWith(color: AppTheme.textSecondary),
                ),
                const SizedBox(height: 24),
                
                ...permissions.map((permData) {
                  final permKey = permData.$1;
                  final isGranted = state.requestedPermissions.contains(permKey);
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppTheme.surface2,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(permData.$2, color: AppTheme.textSecondary, size: 20),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(permData.$3, style: AppTheme.labelMd(context)),
                              Text(permData.$5, style: AppTheme.caption(context).copyWith(color: AppTheme.textSecondary)),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => ref.read(onboardingProvider.notifier).addPermission(permKey),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: isGranted ? AppTheme.success.withValues(alpha: 0.1) : AppTheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                              border: Border.all(color: isGranted ? AppTheme.success : AppTheme.primary),
                            ),
                            child: Text(
                              isGranted ? 'Granted' : 'Allow',
                              style: AppTheme.caption(context).copyWith(
                                color: isGranted ? AppTheme.success : AppTheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
