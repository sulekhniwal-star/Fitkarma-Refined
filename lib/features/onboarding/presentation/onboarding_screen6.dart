import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_completion_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen6 extends ConsumerStatefulWidget {
  const OnboardingScreen6({super.key});

  @override
  ConsumerState<OnboardingScreen6> createState() => _OnboardingScreen6State();
}

class _OnboardingScreen6State extends ConsumerState<OnboardingScreen6> {
  final _abhaController = TextEditingController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _abhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'ABHA + पहनने योग्य' : 'ABHA + Wearables'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAbhaSection(isHindi),
              const SizedBox(height: 32),
              _buildWearableSection(isHindi),
              const SizedBox(height: 40),
              _buildCompleteButton(isHindi),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAbhaSection(bool isHindi) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final hasAbha = onboardingState.abhaNumber != null && onboardingState.abhaNumber!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.health_and_safety, color: Colors.blue, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'ABHA नंबर लिंक करें' : 'Link ABHA Number',
                    style: AppTextStyles.titleMedium,
                  ),
                  Text(
                    isHindi
                        ? '(ऐच्छिक) +100 XP अर्जित करें'
                        : '(Optional) Earn +100 XP',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: hasAbha ? Colors.green.shade50 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: hasAbha ? Colors.green : Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasAbha)
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                    Text(
                      isHindi ? 'ABHA लिंक हो गया!' : 'ABHA Linked!',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    TextFormField(
                      controller: _abhaController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(14),
                      ],
                      decoration: InputDecoration(
                        hintText: isHindi ? '14-अंकीय ABHA नंबर' : '14-digit ABHA number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.numbers),
                      ),
                      onChanged: (value) {
                        if (value.length == 14) {
                          ref.read(onboardingStateProvider.notifier).updateAbha(value);
                        }
                      },
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isHindi
                          ? 'ABHA (Ayushman Bharat Health Account) आपकी स्वास्थ्य पहचान है'
                          : 'ABHA is your unique health ID',
                      style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWearableSection(bool isHindi) {
    final onboardingState = ref.watch(onboardingStateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.watch, color: Colors.purple, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'पहनने योग्य डिवाइस' : 'Wearable Device',
                    style: AppTextStyles.titleMedium,
                  ),
                  Text(
                    isHindi
                        ? '(ऐच्छिक) Apple Watch, Fitbit, Garmin'
                        : '(Optional) Apple Watch, Fitbit, Garmin',
                    style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: onboardingState.wearableConnected ? Colors.green.shade50 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: onboardingState.wearableConnected ? Colors.green : Colors.grey.shade300,
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isHindi ? 'डिवाइस कनेक्ट करें?' : 'Connect Device?',
                      style: AppTextStyles.bodyLarge,
                    ),
                  ),
                  Switch(
                    value: onboardingState.wearableConnected,
                    onChanged: (value) {
                      ref.read(onboardingStateProvider.notifier).updateWearable(value);
                    },
                    activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
                    activeThumbColor: AppColors.primary,
                  ),
                ],
              ),
              if (onboardingState.wearableConnected) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      isHindi ? 'डिवाइस कनेक्ट हो गया!' : 'Device Connected!',
                      style: TextStyle(color: Colors.green.shade700),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompleteButton(bool isHindi) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primary),
          ),
          child: Row(
            children: [
              const Icon(Icons.emoji_events, color: AppColors.primary, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isHindi ? 'पूर्णता XP बोनस' : 'Completion XP Bonus',
                      style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary),
                    ),
                    Text(
                      isHindi
                          ? 'ऑनबोर्डिंग पूरा करने पर +50 XP अर्जित करें'
                          : 'Earn +50 XP for completing onboarding',
                      style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade700),
                    ),
                  ],
                ),
              ),
              Text(
                '+50 XP',
                style: AppTextStyles.titleLarge.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _isProcessing ? null : () => _completeOnboarding(isHindi),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isProcessing
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    isHindi ? 'ऑनबोर्डिंग पूरी करें' : 'Complete Onboarding',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => context.go('/onboarding/5'),
          child: Text(
            isHindi ? 'पीछे' : 'Back',
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }

  Future<void> _completeOnboarding(bool isHindi) async {
    setState(() => _isProcessing = true);

    try {
      await OnboardingCompletionService.completeOnboarding(
        state: ref.read(onboardingStateProvider),
        context: context,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isHindi
                  ? 'ऑनबोर्डिंग पूर्ण! +50 XP अर्जित किए'
                  : 'Onboarding complete! +50 XP earned',
            ),
            backgroundColor: Colors.green,
          ),
        );
        context.go('/');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isHindi ? 'त्रुटि: ${e.toString()}' : 'Error: ${e.toString()}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }
}