import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepHealthConditions extends ConsumerWidget {
  const StepHealthConditions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final textPrimary = isDark ? const Color(0xFFF1F0FF) : const Color(0xFF1A1830);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final divider = isDark ? const Color(0x33FFFFFF) : const Color(0x12000000);
    final warning = isDark ? const Color(0xFFFBBF24) : const Color(0xFFF59E0B);
    final error = isDark ? const Color(0xFFF87171) : const Color(0xFFEF4444);
    
    final conditions = [
      (ChronicCondition.diabetes, Icons.bloodtype_outlined, 'Diabetes', 'मधुमेह'),
      (ChronicCondition.hypertension, Icons.favorite_outline, 'Hypertension', 'उच्च रक्तचाप'),
      (ChronicCondition.pcodPcos, Icons.woman_outlined, 'PCOD/PCOS', 'पॉलिसिस्टिक ओवरी सिंड्रोम'),
      (ChronicCondition.hypothyroidism, Icons.medical_services_outlined, 'Hypothyroidism', 'थायरॉयड कमी'),
      (ChronicCondition.asthma, Icons.air_outlined, 'Asthma', 'दमा'),
    ];
    
    final permissions = [
      ('steps', Icons.directions_walk, 'Steps & Activity', 'Track your daily steps and activity'),
      ('heart', Icons.favorite, 'Heart Rate', 'Monitor your heart rate during workouts'),
      ('sleep', Icons.bedtime, 'Sleep Data', 'Sync your sleep patterns'),
      ('location', Icons.location_on, 'Location', 'GPS for outdoor activities'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Health Conditions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'स्वास्थ्य की स्थिति',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This helps us personalize your experience',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Conditions
          Text(
            'Do you have any of these conditions?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          ...conditions.map((conditionData) {
            final condition = conditionData.$1;
            final icon = conditionData.$2;
            final labelEn = conditionData.$3;
            final labelHi = conditionData.$4;
            final isSelected = state.chronicConditions.contains(condition);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  ref.read(onboardingProvider.notifier).toggleChronicCondition(condition);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? warning.withValues(alpha: 0.15) 
                        : surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? warning : divider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? warning.withValues(alpha: 0.2) 
                              : divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          icon,
                          color: isSelected ? warning : textSecondary,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              labelEn,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: textPrimary,
                              ),
                            ),
                            Text(
                              labelHi,
                              style: TextStyle(
                                fontSize: 12,
                                color: textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: warning,
                          size: 24,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
          
          const SizedBox(height: 8),
          
          // None option
          GestureDetector(
            onTap: () {
              ref.read(onboardingProvider.notifier).toggleChronicCondition(ChronicCondition.none);
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                    ? const Color(0xFF4ADE80).withValues(alpha: 0.15)
                    : surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                      ? const Color(0xFF4ADE80)
                      : divider,
                  width: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                      ? 2
                      : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: state.chronicConditions.contains(ChronicCondition.none) || state.chronicConditions.isEmpty
                        ? const Color(0xFF4ADE80)
                        : textSecondary,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'None of the above',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 32),
          
          // Permissions section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: primary.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.shield_outlined, color: primary, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      'Permission Request',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Allow permissions to enable smart tracking. You can manage these anytime in Settings.',
                  style: TextStyle(
                    fontSize: 12,
                    color: textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          ...permissions.map((permData) {
            final permKey = permData.$1;
            final icon = permData.$2;
            final label = permData.$3;
            final desc = permData.$4;
            final isGranted = state.requestedPermissions.contains(permKey);
            
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: divider),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: divider,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: textSecondary, size: 22),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textPrimary,
                            ),
                          ),
                          Text(
                            desc,
                            style: TextStyle(
                              fontSize: 12,
                              color: textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (isGranted) {
                          final newPerms = List<String>.from(state.requestedPermissions)..remove(permKey);
                          ref.read(onboardingProvider.notifier).addPermission(permKey); // This toggles
                        } else {
                          ref.read(onboardingProvider.notifier).addPermission(permKey);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isGranted 
                              ? const Color(0xFF4ADE80).withValues(alpha: 0.15)
                              : primary.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isGranted ? const Color(0xFF4ADE80) : primary,
                          ),
                        ),
                        child: Text(
                          isGranted ? 'Granted' : 'Allow',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isGranted ? const Color(0xFF4ADE80) : primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
