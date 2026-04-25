import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepBodyStats extends ConsumerWidget {
  const StepBodyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Physique & Stats',
            style: AppTheme.displayMd(context),
          ),
          Text(
            'अपने शरीर के बारे में बताएं',
            style: AppTheme.hindi(context).copyWith(
              color: AppTheme.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          
          Text('Gender', style: AppTheme.labelMd(context)),
          const SizedBox(height: 12),
          Row(
            children: Gender.values.where((g) => g != Gender.preferNotToSay).map((gender) {
              final isSelected = state.gender == gender;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: gender != Gender.male ? 8 : 0, // Simplified check for 3 items
                  ),
                  child: GestureDetector(
                    onTap: () => ref.read(onboardingProvider.notifier).setGender(gender),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.primaryMuted : AppTheme.glass,
                        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                        border: Border.all(
                          color: isSelected ? AppTheme.primary : AppTheme.glassBorder,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        gender.labelEn,
                        textAlign: TextAlign.center,
                        style: AppTheme.labelMd(context).copyWith(
                          color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),
          
          Text('Date of Birth', style: AppTheme.labelMd(context)),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: state.dateOfBirth ?? now.subtract(const Duration(days: 365 * 25)),
                firstDate: DateTime(1920),
                lastDate: now.subtract(const Duration(days: 365 * 10)),
                builder: (context, child) => Theme(
                  data: isDark ? AppTheme.darkTheme : AppTheme.lightTheme,
                  child: child!,
                ),
              );
              if (picked != null) {
                ref.read(onboardingProvider.notifier).setDateOfBirth(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.glass,
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                border: Border.all(color: AppTheme.glassBorder),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 20, color: AppTheme.textSecondary),
                  const SizedBox(width: 12),
                  Text(
                    state.dateOfBirth != null
                        ? '${state.dateOfBirth!.day}/${state.dateOfBirth!.month}/${state.dateOfBirth!.year}'
                        : 'Select Date',
                    style: AppTheme.bodyMd(context).copyWith(
                      color: state.dateOfBirth != null ? AppTheme.textPrimary : AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
          
          _buildSlider(
            context,
            label: 'Height',
            value: state.heightCm,
            unit: 'cm',
            min: 120,
            max: 220,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setHeight(v),
          ),
          const SizedBox(height: 24),
          _buildSlider(
            context,
            label: 'Weight',
            value: state.weightKg,
            unit: 'kg',
            min: 30,
            max: 200,
            onChanged: (v) => ref.read(onboardingProvider.notifier).setWeight(v),
          ),
          const SizedBox(height: 40),
          
          const Divider(height: 1, color: AppTheme.divider),
          const SizedBox(height: 32),
          
          GlassCard(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Body Mass Index (BMI)', style: AppTheme.caption(context)),
                    Text(
                      _calculateBmi(state.heightCm, state.weightKg).toStringAsFixed(1),
                      style: AppTheme.displayMd(context).copyWith(color: AppTheme.primary),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _getBmiColor(_calculateBmi(state.heightCm, state.weightKg)).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppTheme.radiusFull),
                    border: Border.all(
                      color: _getBmiColor(_calculateBmi(state.heightCm, state.weightKg)).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    _getBmiCategory(_calculateBmi(state.heightCm, state.weightKg)),
                    style: AppTheme.labelMd(context).copyWith(
                      color: _getBmiColor(_calculateBmi(state.heightCm, state.weightKg)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    BuildContext context, {
    required String label,
    required double value,
    required String unit,
    required double min,
    required double max,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTheme.labelMd(context)),
            Text('${value.toInt()} $unit', style: AppTheme.labelLg(context).copyWith(color: AppTheme.primary)),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppTheme.primary,
            inactiveTrackColor: AppTheme.surface2,
            thumbColor: Colors.white,
            overlayColor: AppTheme.primary.withValues(alpha: 0.1),
            trackHeight: 6,
          ),
          child: Slider(
            value: value,
            min: min,
            max: max,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  double _calculateBmi(double heightCm, double weightKg) {
    if (heightCm <= 0 || weightKg <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return AppTheme.warning;
    if (bmi < 25) return AppTheme.success;
    if (bmi < 30) return AppTheme.warning;
    return AppTheme.error;
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}
