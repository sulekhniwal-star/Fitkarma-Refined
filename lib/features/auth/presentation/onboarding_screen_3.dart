import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/onboarding_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class OnboardingScreen3 extends ConsumerStatefulWidget {
  const OnboardingScreen3({super.key});

  @override
  ConsumerState<OnboardingScreen3> createState() => _OnboardingScreen3State();
}

class _OnboardingScreen3State extends ConsumerState<OnboardingScreen3> {
  final List<_ChronicCondition> _conditions = [
    _ChronicCondition(id: 'diabetes', name: 'Diabetes', icon: Icons.bloodtype),
    _ChronicCondition(
      id: 'hypertension',
      name: 'Hypertension',
      icon: Icons.favorite,
    ),
    _ChronicCondition(id: 'pcod', name: 'PCOD', icon: Icons.woman),
    _ChronicCondition(
      id: 'hypothyroidism',
      name: 'Hypothyroidism',
      icon: Icons.psychology,
    ),
    _ChronicCondition(id: 'asthma', name: 'Asthma', icon: Icons.air),
  ];

  late List<String> _selectedConditions;

  @override
  void initState() {
    super.initState();
    _selectedConditions = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingStateProvider).state;
      _selectedConditions = List.from(state.chronicConditions);
    });
  }

  void _toggleCondition(String id) {
    setState(() {
      if (_selectedConditions.contains(id)) {
        _selectedConditions.remove(id);
      } else {
        _selectedConditions.add(id);
      }
    });
  }

  void _saveAndNext() {
    final notifier = ref.read(onboardingStateProvider);
    final currentState = notifier.state;
    notifier.updateState(
      currentState.copyWith(chronicConditions: _selectedConditions),
    );
    context.go('/onboarding/4');
  }

  void _skip() {
    context.go('/onboarding/4');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/2'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress indicator
              LinearProgressIndicator(
                value: 3 / 6,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step 3 of 6',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text('Health Conditions', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Select any conditions that apply to you (optional)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Conditions Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: _conditions.length,
                itemBuilder: (context, index) {
                  final condition = _conditions[index];
                  final isSelected = _selectedConditions.contains(condition.id);
                  return InkWell(
                    onTap: () => _toggleCondition(condition.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.error.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.error
                              : AppColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            condition.icon,
                            color: isSelected
                                ? AppColors.error
                                : AppColors.textSecondary,
                            size: 28,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            condition.name,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: isSelected
                                  ? AppColors.error
                                  : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Selected count
              if (_selectedConditions.isNotEmpty)
                Center(
                  child: Text(
                    '${_selectedConditions.length} condition${_selectedConditions.length > 1 ? 's' : ''} selected',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Buttons Row
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _skip,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Skip'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: _saveAndNext,
                      child: const Text('Continue'),
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

class _ChronicCondition {
  final String id;
  final String name;
  final IconData icon;

  const _ChronicCondition({
    required this.id,
    required this.name,
    required this.icon,
  });
}
