import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/onboarding_state.dart';
import '../../domain/onboarding_providers.dart';

class StepBodyStats extends ConsumerWidget {
  const StepBodyStats({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final textPrimary = isDark ? const Color(0xFFF1F0FF) : const Color(0xFF1A1830);
    final textSecondary = isDark ? const Color(0xFF9B99CC) : const Color(0xFF6B6A96);
    final primary = isDark ? const Color(0xFFFF6B35) : const Color(0xFFF4511E);
    final surface = isDark ? const Color(0xFF1C1C2E) : Colors.white;
    final divider = isDark ? const Color(0x33FFFFFF) : const Color(0x12000000);
    final error = isDark ? const Color(0xFFF87171) : const Color(0xFFEF4444);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About You',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'आपके बारे में',
            style: TextStyle(
              fontSize: 12,
              color: textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          
          // Gender Selection
          Text(
            'Gender',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: Gender.values.where((g) => g != Gender.preferNotToSay).map((gender) {
              final isSelected = state.gender == gender;
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: gender != Gender.values.last ? 8 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      ref.read(onboardingProvider.notifier).setGender(gender);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected 
                            ? primary.withValues(alpha: 0.15) 
                            : surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? primary : divider,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Text(
                        gender.labelEn,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          color: isSelected ? primary : textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          
          // Date of Birth
          Text(
            'Date of Birth',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: state.dateOfBirth ?? now.subtract(const Duration(days: 365 * 25)),
                firstDate: DateTime(1920),
                lastDate: now.subtract(const Duration(days: 365 * 10)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: isDark 
                          ? const ColorScheme.dark(primary: Color(0xFFFF6B35))
                          : const ColorScheme.light(primary: Color(0xFFF4511E)),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                ref.read(onboardingProvider.notifier).setDateOfBirth(picked);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: divider),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: textSecondary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    state.dateOfBirth != null
                        ? '${state.dateOfBirth!.day}/${state.dateOfBirth!.month}/${state.dateOfBirth!.year}'
                        : 'Select date of birth',
                    style: TextStyle(
                      fontSize: 15,
                      color: state.dateOfBirth != null ? textPrimary : textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Height
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Height',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              Text(
                '${state.heightCm.toInt()} cm',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: primary,
              inactiveTrackColor: divider,
              thumbColor: primary,
              overlayColor: primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: state.heightCm,
              min: 120,
              max: 220,
              onChanged: (value) {
                ref.read(onboardingProvider.notifier).setHeight(value);
              },
            ),
          ),
          const SizedBox(height: 16),
          
          // Weight
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Weight',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textPrimary,
                ),
              ),
              Text(
                '${state.weightKg.toInt()} kg',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: primary,
              inactiveTrackColor: divider,
              thumbColor: primary,
              overlayColor: primary.withValues(alpha: 0.2),
            ),
            child: Slider(
              value: state.weightKg,
              min: 30,
              max: 200,
              onChanged: (value) {
                ref.read(onboardingProvider.notifier).setWeight(value);
              },
            ),
          ),
          const SizedBox(height: 24),
          
          // Blood Group
          Text(
            'Blood Group (optional)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: BloodGroup.values.map((group) {
              final isSelected = state.bloodGroup == group;
              return GestureDetector(
                onTap: () {
                  ref.read(onboardingProvider.notifier).setBloodGroup(group);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? primary.withValues(alpha: 0.15) 
                        : surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? primary : divider,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Text(
                    group.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                      color: isSelected ? primary : textPrimary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          
          // BMI Display
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: divider),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BMI',
                      style: TextStyle(
                        fontSize: 12,
                        color: textSecondary,
                      ),
                    ),
                    Text(
                      _calculateBmi(state.heightCm, state.weightKg).toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: textPrimary,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getBmiColor(_calculateBmi(state.heightCm, state.weightKg)).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _getBmiCategory(_calculateBmi(state.heightCm, state.weightKg)),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  double _calculateBmi(double heightCm, double weightKg) {
    if (heightCm <= 0 || weightKg <= 0) return 0;
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  Color _getBmiColor(double bmi) {
    if (bmi < 18.5) return const Color(0xFFFBBF24); // Underweight - Warning
    if (bmi < 25) return const Color(0xFF4ADE80); // Normal - Success
    if (bmi < 30) return const Color(0xFFFBBF24); // Overweight - Warning
    return const Color(0xFFF87171); // Obese - Error
  }

  String _getBmiCategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}
