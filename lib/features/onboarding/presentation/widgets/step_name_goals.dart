import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepNameGoals extends ConsumerStatefulWidget {
  const StepNameGoals({super.key});

  @override
  ConsumerState<StepNameGoals> createState() => _StepNameGoalsState();
}

class _StepNameGoalsState extends ConsumerState<StepNameGoals> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final textPrimary = isDark ? const Color(0xFFF1F0FF) : const Color(0xFF1A1830);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final divider = isDark ? const Color(0x33FFFFFF) : const Color(0x12000000);

    final goals = [
      (OnboardingGoal.loseWeight, 'assets/images/goals/wellness.png', 'Lose Weight', 'वजन कम करें'),
      (OnboardingGoal.gainMuscle, 'assets/images/goals/strength.png', 'Build Muscle', 'मांसपेशियां बढ़ाएं'),
      (OnboardingGoal.maintain, 'assets/images/goals/wellness.png', 'Maintain', 'बनाए रखें'),
      (OnboardingGoal.endurance, 'assets/images/goals/strength.png', 'Build Endurance', 'सहनशक्ति बढ़ाएं'),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to FitKarma',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'स्वागत है',
            style: TextStyle(
              fontSize: 14,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Let\'s set up your personalized health journey',
            style: TextStyle(
              fontSize: 16,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          // Name input
          Text(
            'What should we call you?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            onChanged: (value) {
              ref.read(onboardingProvider.notifier).setDisplayName(value);
            },
            style: TextStyle(color: textPrimary),
            decoration: InputDecoration(
              hintText: 'Your name',
              hintStyle: TextStyle(color: textSecondary),
              filled: true,
              fillColor: surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 32),
          
          // Goal selection
          Text(
            'What\'s your main goal?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'आपका मुख्य लक्ष्य क्या है?',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
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
                onTap: () {
                  ref.read(onboardingProvider.notifier).setGoal(goal);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primary.withValues(alpha: 0.15) 
                        : surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? primary : divider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? primary.withValues(alpha: 0.2) 
                              : divider,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          goalData.$2,
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
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
                          color: primary,
                          size: 24,
                        ),
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
