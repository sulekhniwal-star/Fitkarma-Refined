import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/domain/onboarding_providers.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/progress_indicator.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_name_goals.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_body_stats.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_activity_level.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_dosha_quiz.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_health_conditions.dart';
import 'package:fitkarma/features/onboarding/presentation/widgets/step_abha_wearables.dart';

class OnboardingFlowScreen extends ConsumerStatefulWidget {
  const OnboardingFlowScreen({super.key});

  @override
  ConsumerState<OnboardingFlowScreen> createState() => _OnboardingFlowScreenState();
}

class _OnboardingFlowScreenState extends ConsumerState<OnboardingFlowScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextStep() {
    final state = ref.read(onboardingProvider);
    
    // Validate current step before proceeding
    String? errorMessage;
    switch (state.currentStep) {
      case 0:
        if (state.displayName.isEmpty) {
          errorMessage = 'Please enter your name';
        } else if (state.goal == null) {
          errorMessage = 'Please select your goal';
        }
        break;
      case 1:
        // Body stats are optional, can always proceed
        break;
      case 2:
        // Activity level has default, can always proceed
        break;
      case 3:
        if (state.doshaAnswers.length < 12) {
          errorMessage = 'Please answer all questions';
        }
        break;
      case 4:
        // Health conditions are optional
        break;
      case 5:
        // ABHA and wearables are optional
        break;
    }
    
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: const Color(0xFFF87171),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    
    if (state.currentStep < 5) {
      ref.read(onboardingProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _previousStep() {
    final state = ref.read(onboardingProvider);
    if (state.currentStep > 0) {
      ref.read(onboardingProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    final state = ref.read(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);
    notifier.complete();
    
    // Award +50 XP for completing onboarding
    // TODO: Integrate with karma provider
    // await ref.read(karmaProvider.notifier).addXp(50, 'onboarding_complete');
    
    // Save user profile to Drift
    // final profile = state.toUserProfile();
    // await ref.read(userRepositoryProvider).saveProfile(profile);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.star, color: Colors.white),
              SizedBox(width: 8),
              Text('Welcome to FitKarma! +50 XP'),
            ],
          ),
          backgroundColor: Color(0xFF4ADE80),
          behavior: SnackBarBehavior.floating,
        ),
      );
      
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        context.go('/home/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final background = isDark ? const Color(0xFF080810) : const Color(0xFFF7F0E8);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark 
          ? SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
      child: Scaffold(
        backgroundColor: background,
        body: SafeArea(
          child: Column(
            children: [
              OnboardingProgressIndicator(
                currentStep: state.currentStep,
                totalSteps: 6,
                primaryColor: primary,
              ),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    ref.read(onboardingProvider.notifier).goToStep(index);
                  },
                  children: const [
                    StepNameGoals(),
                    StepBodyStats(),
                    StepActivityLevel(),
                    StepDoshaQuiz(),
                    StepHealthConditions(),
                    StepAbhaWearables(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state.currentStep > 0)
                      TextButton(
                        onPressed: _previousStep,
                        child: Text(
                          'Back',
                          style: TextStyle(color: textSecondary, fontSize: 16),
                        ),
                      )
                    else
                      const SizedBox(width: 80),
                    ElevatedButton(
                      onPressed: _nextStep,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        minimumSize: const Size(140, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        state.currentStep == 5 ? 'Get Started' : 'Continue',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
  }
}