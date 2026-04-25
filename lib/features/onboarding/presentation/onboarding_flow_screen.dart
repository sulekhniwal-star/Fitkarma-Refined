import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/fit_scaffold.dart';
import 'package:fitkarma/shared/widgets/ambient_glow_blobs.dart';
import '../domain/onboarding_providers.dart';
import 'package:fitkarma/features/auth/domain/auth_providers.dart';
import 'widgets/progress_indicator.dart';
import 'widgets/step_name_goals.dart';
import 'widgets/step_body_stats.dart';
import 'widgets/step_activity_level.dart';
import 'widgets/step_dosha_quiz.dart';
import 'widgets/step_health_conditions.dart';
import 'widgets/step_abha_wearables.dart';

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
    
    String? errorMessage;
    switch (state.currentStep) {
      case 0:
        if (state.displayName.trim().isEmpty) {
          errorMessage = 'Please enter your name / कृपया अपना नाम लिखें';
        } else if (state.goal == null) {
          errorMessage = 'Please select your goal / कृपया अपना लक्ष्य चुनें';
        }
        break;
      case 1:
        // Physique is optional
        break;
      case 2:
        // Activity is optional
        break;
      case 3:
        // Dosha quiz is optional but discouraged to skip
        break;
      case 4:
        // Health conditions are optional
        break;
      case 5:
        // ABHA/Wearables are optional
        break;
    }
    
    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage, style: AppTheme.labelMd(context).copyWith(color: Colors.white)),
          backgroundColor: AppTheme.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }
    
    if (state.currentStep < 5) {
      ref.read(onboardingProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
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
        duration: const Duration(milliseconds: 600),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    final user = ref.read(authStateProvider).value;
    if (user == null) return;
    
    final notifier = ref.read(onboardingProvider.notifier);
    await notifier.complete(user.id);
    
    if (mounted) {
      HapticFeedback.heavyImpact();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.stars, color: AppTheme.accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Profile Complete!', style: AppTheme.labelLg(context).copyWith(color: Colors.white)),
                    Text('+50 XP Earned', style: AppTheme.bodySm(context).copyWith(color: Colors.white70)),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: AppTheme.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppTheme.radiusMd)),
        ),
      );
      
      await Future.delayed(const Duration(milliseconds: 1000));
      if (mounted) {
        context.go('/home/dashboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingProvider);

    return FitScaffold(
      pattern: ScaffoldPattern.standard,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
            child: OnboardingProgressIndicator(
              currentStep: state.currentStep,
              totalSteps: 6,
              primaryColor: AppTheme.primary,
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          const AmbientGlowBlobs(),
          Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
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
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.bg0.withValues(alpha: 0),
              AppTheme.bg0.withValues(alpha: 0.9),
              AppTheme.bg0,
            ],
          ),
        ),
        child: SafeArea(
          child: Row(
            children: [
              if (state.currentStep > 0)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _previousStep,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.glass,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(color: AppTheme.glassBorder),
                      ),
                      child: const Icon(Icons.arrow_back, color: AppTheme.textPrimary),
                    ),
                  ),
                ),
              if (state.currentStep > 0) const SizedBox(width: 16),
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _nextStep,
                    borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    child: Ink(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppTheme.primary, Color(0xFFFF8555)],
                        ),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withValues(alpha: 0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          state.currentStep == 5 ? 'GET STARTED' : 'CONTINUE',
                          style: AppTheme.labelLg(context).copyWith(
                            color: Colors.white,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
