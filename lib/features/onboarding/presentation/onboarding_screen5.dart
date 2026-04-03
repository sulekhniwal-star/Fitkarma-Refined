import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/features/onboarding/data/onboarding_state.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class OnboardingScreen5 extends ConsumerWidget {
  const OnboardingScreen5({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingState = ref.watch(onboardingStateProvider);
    final isHindi = onboardingState.language == 'hi';

    final languages = [
      ('en', 'English', '🇺🇸'),
      ('hi', 'हिंदी', '🇮🇳'),
      ('bn', 'বাংলা', '🇧🇩'),
      ('ta', 'தமிழ்', '🇮🇳'),
      ('te', 'తెలుగు', '🇮🇳'),
      ('mr', 'मराठी', '🇮🇳'),
      ('gu', 'ગુજરાતી', '🇮🇳'),
      ('kn', 'ಕನ್ನಡ', '🇮🇳'),
      ('ml', 'മലയാളം', '🇮🇳'),
      ('pa', 'ਪੰਜਾਬੀ', '🇮🇳'),
      ('or', 'odia', '🇮🇳'),
      ('as', 'অসমীয়া', '🇮🇳'),
      ('ur', 'اردو', '🇵🇰'),
      ('sd', 'سنڌي', '🇵🇰'),
      ('ne', 'नेपाली', '🇳🇵'),
      ('si', 'සිංහල', '🇱🇰'),
      ('ar', 'العربية', '🇸🇦'),
      ('fa', 'فارسی', '🇮🇷'),
      ('th', 'ไทย', '🇹🇭'),
      ('vi', 'Tiếng Việt', '🇻🇳'),
      ('id', 'Bahasa Indonesia', '🇮🇩'),
      ('ms', 'Bahasa Melayu', '🇲🇾'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(isHindi ? 'सेटिंग्स' : 'Settings'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isHindi ? 'अपनी भाषा चुनें' : 'Select your language',
                style: AppTextStyles.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                isHindi
                    ? 'आपकी पसंदीदा भाषा में ऐप का अनुभव प्राप्त करें'
                    : 'Experience the app in your preferred language',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: languages.map((lang) {
                  final isSelected = onboardingState.language == lang.$1;
                  return GestureDetector(
                    onTap: () {
                      ref.read(onboardingStateProvider.notifier).updateLanguage(lang.$1);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : Colors.grey.shade300,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(lang.$3, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            lang.$2,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                isHindi ? 'स्वास्थ्य अनुमतियां' : 'Health Permissions',
                style: AppTextStyles.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                isHindi
                    ? 'बेहतर अनुभव के लिए ये अनुमतियां दें'
                    : 'Enable these for a better experience',
                style: AppTextStyles.bodyMedium.copyWith(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),
              _buildPermissionTile(
                icon: Icons.directions_walk,
                title: isHindi ? 'कदम गिनना' : 'Step Counter',
                subtitle: isHindi
                    ? 'दैनिक कदमों को ट्रैक करें'
                    : 'Track your daily steps',
                value: onboardingState.stepCounterPermission,
                onChanged: (value) {
                  ref.read(onboardingStateProvider.notifier).updatePermissions(stepCounter: value);
                },
              ),
              _buildPermissionTile(
                icon: Icons.favorite,
                title: isHindi ? 'हृदय गति' : 'Heart Rate',
                subtitle: isHindi
                    ? 'हृदय संबंधी डेटा ट्रैक करें'
                    : 'Monitor heart rate data',
                value: onboardingState.heartRatePermission,
                onChanged: (value) {
                  ref.read(onboardingStateProvider.notifier).updatePermissions(heartRate: value);
                },
              ),
              _buildPermissionTile(
                icon: Icons.bedtime,
                title: isHindi ? 'नींद ट्रैकिंग' : 'Sleep Tracking',
                subtitle: isHindi
                    ? 'अपनी नींद के पैटर्न को समझें'
                    : 'Understand your sleep patterns',
                value: onboardingState.sleepPermission,
                onChanged: (value) {
                  ref.read(onboardingStateProvider.notifier).updatePermissions(sleep: value);
                },
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => context.go('/onboarding/4'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(isHindi ? 'पीछे' : 'Back'),
                  ),
                  const Spacer(),
                  FilledButton(
                    onPressed: () => context.go('/onboarding/6'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isHindi ? 'आगे बढ़ें' : 'Continue',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

  Widget _buildPermissionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.titleSmall),
                Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: Colors.grey.shade600)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}