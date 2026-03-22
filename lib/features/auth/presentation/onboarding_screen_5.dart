import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/onboarding_providers.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';

class OnboardingScreen5 extends ConsumerStatefulWidget {
  const OnboardingScreen5({super.key});

  @override
  ConsumerState<OnboardingScreen5> createState() => _OnboardingScreen5State();
}

class _OnboardingScreen5State extends ConsumerState<OnboardingScreen5> {
  String? _selectedLanguage;
  bool _permissionStepCounter = false;
  bool _permissionHeartRate = false;
  bool _permissionSleep = false;

  final List<_Language> _languages = [
    _Language(code: 'en', name: 'English', nativeName: 'English'),
    _Language(code: 'hi', name: 'Hindi', nativeName: 'हिन्दी'),
    _Language(code: 'ta', name: 'Tamil', nativeName: 'தமிழ்'),
    _Language(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
    _Language(code: 'kn', name: 'Kannada', nativeName: 'ಕನ್ನಡ'),
    _Language(code: 'ml', name: 'Malayalam', nativeName: 'മലയാളം'),
    _Language(code: 'mr', name: 'Marathi', nativeName: 'मराठी'),
    _Language(code: 'gu', name: 'Gujarati', nativeName: 'ગુજરાતી'),
    _Language(code: 'bn', name: 'Bengali', nativeName: 'বাংলা'),
    _Language(code: 'pa', name: 'Punjabi', nativeName: 'ਪੰਜਾਬੀ'),
    _Language(code: 'or', name: 'Odia', nativeName: 'ଓଡ଼ିଆ'),
    _Language(code: 'as', name: 'Assamese', nativeName: 'অসমীয়া'),
    _Language(code: 'ur', name: 'Urdu', nativeName: 'اردو'),
    _Language(code: 'fr', name: 'French', nativeName: 'Français'),
    _Language(code: 'es', name: 'Spanish', nativeName: 'Español'),
    _Language(code: 'de', name: 'German', nativeName: 'Deutsch'),
    _Language(code: 'pt', name: 'Portuguese', nativeName: 'Português'),
    _Language(code: 'it', name: 'Italian', nativeName: 'Italiano'),
    _Language(code: 'ru', name: 'Russian', nativeName: 'Русский'),
    _Language(code: 'zh', name: 'Chinese', nativeName: '中文'),
    _Language(code: 'ja', name: 'Japanese', nativeName: '日本語'),
    _Language(code: 'ko', name: 'Korean', nativeName: '한국어'),
    _Language(code: 'ar', name: 'Arabic', nativeName: 'العربية'),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = ref.read(onboardingStateProvider).state;
      if (state.languageCode != null) _selectedLanguage = state.languageCode;
      _permissionStepCounter = state.permissionStepCounter;
      _permissionHeartRate = state.permissionHeartRate;
      _permissionSleep = state.permissionSleep;
    });
  }

  void _saveAndNext() {
    if (_selectedLanguage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please select a language')));
      return;
    }

    final notifier = ref.read(onboardingStateProvider);
    final currentState = notifier.state;
    notifier.updateState(
      currentState.copyWith(
        languageCode: _selectedLanguage,
        permissionStepCounter: _permissionStepCounter,
        permissionHeartRate: _permissionHeartRate,
        permissionSleep: _permissionSleep,
      ),
    );

    context.go('/onboarding/6');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language & Permissions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/onboarding/4'),
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
                value: 5 / 6,
                backgroundColor: AppColors.divider,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Step 5 of 6',
                style: AppTextStyles.caption.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 24),

              // Title
              Text('Choose Your Language', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              Text(
                'Select your preferred language for the app',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),

              // Language Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.5,
                ),
                itemCount: _languages.length,
                itemBuilder: (context, index) {
                  final lang = _languages[index];
                  final isSelected = _selectedLanguage == lang.code;
                  return InkWell(
                    onTap: () => setState(() => _selectedLanguage = lang.code),
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          if (isSelected)
                            const Icon(
                              Icons.check_circle,
                              color: AppColors.primary,
                              size: 18,
                            )
                          else
                            const Icon(
                              Icons.circle_outlined,
                              color: AppColors.textMuted,
                              size: 18,
                            ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  lang.nativeName,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: isSelected
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  lang.name,
                                  style: AppTextStyles.caption.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              // Health Permissions
              Text('Health Permissions', style: AppTextStyles.h3),
              const SizedBox(height: 8),
              Text(
                'Enable health data sync for better tracking (optional)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),

              // Permission cards
              _PermissionCard(
                icon: Icons.directions_walk,
                title: 'Step Counter',
                description: 'Track your daily steps and distance',
                isEnabled: _permissionStepCounter,
                onToggle: (value) =>
                    setState(() => _permissionStepCounter = value),
              ),
              const SizedBox(height: 12),
              _PermissionCard(
                icon: Icons.favorite,
                title: 'Heart Rate',
                description: 'Monitor your heart rate data',
                isEnabled: _permissionHeartRate,
                onToggle: (value) =>
                    setState(() => _permissionHeartRate = value),
              ),
              const SizedBox(height: 12),
              _PermissionCard(
                icon: Icons.bedtime,
                title: 'Sleep Tracking',
                description: 'Analyze your sleep patterns',
                isEnabled: _permissionSleep,
                onToggle: (value) => setState(() => _permissionSleep = value),
              ),
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

class _Language {
  final String code;
  final String name;
  final String nativeName;

  const _Language({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

class _PermissionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isEnabled;
  final ValueChanged<bool> onToggle;

  const _PermissionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.isEnabled,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isEnabled ? AppColors.success.withOpacity(0.1) : Colors.white,
        border: Border.all(
          color: isEnabled ? AppColors.success : AppColors.divider,
          width: isEnabled ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: isEnabled ? AppColors.success : AppColors.textSecondary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: isEnabled
                        ? AppColors.success
                        : AppColors.textPrimary,
                  ),
                ),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onToggle,
            activeThumbColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}
