import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/onboarding_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class OnboardingScreen2 extends ConsumerStatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  ConsumerState<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends ConsumerState<OnboardingScreen2> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  String? _selectedFitnessGoal;
  String? _selectedActivityLevel;

  final List<_FitnessGoal> _fitnessGoals = [
    _FitnessGoal(
      id: 'weight_loss',
      title: 'Weight Loss',
      description: 'Shed extra pounds',
      icon: Icons.trending_down,
      color: AppColors.teal,
    ),
    _FitnessGoal(
      id: 'muscle_gain',
      title: 'Muscle Gain',
      description: 'Build strength',
      icon: Icons.fitness_center,
      color: AppColors.rose,
    ),
    _FitnessGoal(
      id: 'maintenance',
      title: 'Maintenance',
      description: 'Stay fit',
      icon: Icons.balance,
      color: AppColors.success,
    ),
    _FitnessGoal(
      id: 'endurance',
      title: 'Endurance',
      description: 'Build stamina',
      icon: Icons.directions_run,
      color: AppColors.primary,
    ),
  ];

  final List<_ActivityLevel> _activityLevels = [
    _ActivityLevel(
      id: 'sedentary',
      title: 'Sedentary',
      description: 'Little or no exercise',
      icon: Icons.weekend,
    ),
    _ActivityLevel(
      id: 'light',
      title: 'Light',
      description: 'Light exercise 1-3 days/week',
      icon: Icons.directions_walk,
    ),
    _ActivityLevel(
      id: 'moderate',
      title: 'Moderate',
      description: 'Moderate exercise 3-5 days/week',
      icon: Icons.directions_run,
    ),
    _ActivityLevel(
      id: 'active',
      title: 'Active',
      description: 'Hard exercise 6-7 days/week',
      icon: Icons.fitness_center,
    ),
    _ActivityLevel(
      id: 'very_active',
      title: 'Very Active',
      description: 'Intense daily exercise',
      icon: Icons.sports_gymnastics,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingStateProvider).state;
      if (state.heightCm != null)
        _heightController.text = state.heightCm!.toStringAsFixed(0);
      if (state.weightKg != null)
        _weightController.text = state.weightKg!.toStringAsFixed(1);
      if (state.fitnessGoal != null) _selectedFitnessGoal = state.fitnessGoal;
      if (state.activityLevel != null)
        _selectedActivityLevel = state.activityLevel;
    });
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _saveAndNext() {
    final height = double.tryParse(_heightController.text);
    final weight = double.tryParse(_weightController.text);

    if (height == null || height < 50 || height > 300) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid height (50-300 cm)'),
        ),
      );
      return;
    }

    if (weight == null || weight < 20 || weight > 500) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid weight (20-500 kg)'),
        ),
      );
      return;
    }

    if (_selectedFitnessGoal == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your fitness goal')),
      );
      return;
    }

    if (_selectedActivityLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select your activity level')),
      );
      return;
    }

    final notifier = ref.read(onboardingStateProvider);
    final currentState = notifier.state;
    notifier.updateState(
      currentState.copyWith(
        heightCm: height,
        weightKg: weight,
        fitnessGoal: _selectedFitnessGoal,
        activityLevel: _selectedActivityLevel,
      ),
    );

    context.go('/onboarding/3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Body & Fitness'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/1'),
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
                value: 2 / 6,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step 2 of 6',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text('Your Body & Goals', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Help us understand your fitness journey',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 32),

              // Height & Weight
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Height (cm)', style: AppTextStyles.labelLarge),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _heightController,
                          decoration: const InputDecoration(
                            hintText: '170',
                            suffixText: 'cm',
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Weight (kg)', style: AppTextStyles.labelLarge),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _weightController,
                          decoration: const InputDecoration(
                            hintText: '70',
                            suffixText: 'kg',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Fitness Goal
              Text('Fitness Goal', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: _fitnessGoals.map((goal) {
                  final isSelected = _selectedFitnessGoal == goal.id;
                  return InkWell(
                    onTap: () => setState(() => _selectedFitnessGoal = goal.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? goal.color.withOpacity(0.1)
                            : Colors.white,
                        border: Border.all(
                          color: isSelected ? goal.color : AppColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(goal.icon, color: goal.color, size: 28),
                          const SizedBox(height: 8),
                          Text(
                            goal.title,
                            style: AppTextStyles.labelLarge.copyWith(
                              color: isSelected
                                  ? goal.color
                                  : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            goal.description,
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),

              // Activity Level
              Text('Activity Level', style: AppTextStyles.h4),
              const SizedBox(height: 12),
              ..._activityLevels.map((level) {
                final isSelected = _selectedActivityLevel == level.id;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                    onTap: () =>
                        setState(() => _selectedActivityLevel = level.id),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primarySurface
                            : Colors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.divider,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            level.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  level.title,
                                  style: AppTextStyles.labelLarge.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  level.description,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveAndNext,
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FitnessGoal {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _FitnessGoal({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _ActivityLevel {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  const _ActivityLevel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
