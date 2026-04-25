import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_text_styles.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../../../core/di/providers.dart';
import '../../../core/security/security_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final LocalAuthentication _auth = LocalAuthentication();
  final double _fontSize = 1.0;
  bool _dyslexiaFont = false;
  bool _lowDataMode = false;
  String _selectedLanguage = 'English';
  int _syncInterval = 15;

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeProvider);
    final securityState = ref.watch(securityProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF161625) : const Color(0xFFFFF9F2),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF161625) : const Color(0xFFFFF9F2),
        elevation: 0,
        title: Text(
          'Settings',
          style: AppTextStyles.h1(isDark),
        ),
        titleSpacing: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: EncryptionBadge(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          // Account Section
          _buildSectionCard(
            title: 'Account',
            hindi: 'खाता',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.person_outline,
                label: 'Edit Profile',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/profile/edit'),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.star_outline,
                label: 'Subscription',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PRO',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
                onTap: () => context.push('/subscription'),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.lock_outline,
                label: 'Change Password',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.health_and_safety_outlined,
                label: 'ABHA Account',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Linked',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.success,
                      fontSize: 10,
                    ),
                  ),
                ),
                onTap: () => context.push('/abha'),
                isDark: isDark,
              ),
            ],
          ),

          // Preferences Section
          _buildSectionCard(
            title: 'Preferences',
            hindi: 'पसंद',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.language,
                label: 'Language',
                trailing: Text(
                  _selectedLanguage,
                  style: AppTextStyles.bodyMedium(isDark),
                ),
                onTap: () => _showLanguagePicker(),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.dark_mode_outlined,
                label: 'Theme',
                trailing: DropdownButton<ThemeMode>(
                  value: themeMode,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.chevron_right),
                  onChanged: (mode) {
                    if (mode != null) ref.read(themeProvider.notifier).state = mode;
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Text('Auto', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text('Light', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text('Dark', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                  ],
                ),
                isDark: isDark,
              ),
              _buildSliderRow(
                label: 'Font Size',
                icon: Icons.format_size,
                value: _fontSize,
                min: 0.8,
                max: 1.4,
                isDark: isDark,
              ),
              _buildSwitchRow(
                icon: Icons.spellcheck,
                label: 'Dyslexia Friendly Font',
                subtitle: 'Reduces reading difficulty',
                value: _dyslexiaFont,
                onChanged: (val) => setState(() => _dyslexiaFont = val),
                isDark: isDark,
              ),
            ],
          ),

          // Notifications Section
          _buildSectionCard(
            title: 'Notifications',
            hindi: 'सूचनाएं',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.restaurant,
                label: 'Meal Reminders',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primary,
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.directions_walk,
                label: 'Step Reminders',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primary,
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.favorite,
                label: 'Health Check Reminders',
                trailing: Switch(
                  value: true,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primary,
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.wb_sunny,
                label: 'Morning Briefing',
                trailing: Switch(
                  value: false,
                  onChanged: (val) {},
                  activeThumbColor: AppColors.primary,
                ),
                isDark: isDark,
              ),
            ],
          ),

          // Privacy & Security Section
          _buildSectionCard(
            title: 'Privacy & Security',
            hindi: 'गोपनीयता और सुरक्षा',
            isDark: isDark,
            children: [
              _buildSwitchRow(
                icon: Icons.fingerprint,
                label: 'Biometric Lock',
                subtitle: 'Require fingerprint to open',
                value: securityState.value?.isBiometricEnabled ?? false,
                onChanged: (val) async {
                  final canCheck = await ref.read(biometricServiceProvider).canAuthenticate();
                  if (canCheck) {
                    await ref.read(securityProvider.notifier).setBiometricEnabled(val);
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Biometrics not supported or setup on this device')),
                      );
                    }
                  }
                },
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.download_outlined,
                label: 'Export My Data',
                subtitle: 'Portable JSON of all health logs',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Share.share(
                  '{"user": "id", "logs": []}',
                  subject: 'FitKarma Data Export',
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.delete_forever,
                label: 'Account Deletion',
                subtitle: 'Permanently delete all data',
                trailing: const Icon(Icons.chevron_right, color: AppColors.error),
                onTap: _showDeleteDialog,
                isDark: isDark,
                isDestructive: true,
              ),
            ],
          ),

          // Data & Sync Section
          _buildSectionCard(
            title: 'Data & Sync',
            hindi: 'डेटा और सिंक',
            isDark: isDark,
            children: [
              _buildSwitchRow(
                icon: Icons.data_usage,
                label: 'Low Data Mode',
                subtitle: 'Reduce data usage',
                value: _lowDataMode,
                onChanged: (val) => setState(() => _lowDataMode = val),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.sync,
                label: 'Sync Interval',
                trailing: DropdownButton<int>(
                  value: _syncInterval,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.chevron_right),
                  items: [
                    DropdownMenuItem(
                      value: 15,
                      child: Text('15 min', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                    DropdownMenuItem(
                      value: 30,
                      child: Text('30 min', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                    DropdownMenuItem(
                      value: 60,
                      child: Text('1 hour', style: AppTextStyles.bodyMedium(isDark)),
                    ),
                  ],
                  onChanged: (val) {
                    if (val != null) setState(() => _syncInterval = val);
                  },
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.watch,
                label: 'Wearable Connections',
                subtitle: 'Connect fitness devices',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/wearables'),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.pending_outlined,
                label: 'Pending Sync Items',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '2',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                onTap: () {},
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.error_outline,
                label: 'View Failed Sync Items',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                isDark: isDark,
              ),
            ],
          ),

          // Health Permissions Section
          _buildSectionCard(
            title: 'Health Permissions',
            hindi: 'स्वास्थ्य अनुमतियाँ',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.directions_walk,
                label: 'Step Counter',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Allowed',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.success,
                      fontSize: 10,
                    ),
                  ),
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.favorite,
                label: 'Heart Rate',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Allowed',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.success,
                      fontSize: 10,
                    ),
                  ),
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.bedtime,
                label: 'Sleep Data',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Allowed',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.success,
                      fontSize: 10,
                    ),
                  ),
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.location_on,
                label: 'Location (GPS)',
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.warning.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'When in use',
                    style: AppTextStyles.labelMedium(isDark).copyWith(
                      color: AppColors.warning,
                      fontSize: 10,
                    ),
                  ),
                ),
                onTap: () {},
                isDark: isDark,
              ),
            ],
          ),

          // Customisation Section
          _buildSectionCard(
            title: 'Customisation',
            hindi: 'अनुकूलन',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.widgets_outlined,
                label: 'Home Widgets',
                subtitle: 'Configure Android/iOS widgets',
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push('/home-widgets'),
                isDark: isDark,
              ),
            ],
          ),

          // About Section
          _buildSectionCard(
            title: 'About',
            hindi: 'के बारे में',
            isDark: isDark,
            children: [
              _buildSettingRow(
                icon: Icons.info_outline,
                label: 'App Version',
                trailing: Text(
                  '1.0.0',
                  style: AppTextStyles.bodyMedium(isDark),
                ),
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.description_outlined,
                label: 'Terms of Service',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                isDark: isDark,
              ),
              _buildSettingRow(
                icon: Icons.support_agent,
                label: 'Contact Support',
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
                isDark: isDark,
              ),
            ],
          ),

          const SizedBox(height: 32),
          // Logout button
          Center(
            child: TextButton(
              onPressed: () => context.go('/login'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
              ),
              child: Text(
                'LOGOUT',
                style: AppTextStyles.labelLarge(isDark).copyWith(
                  color: AppColors.error,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String hindi, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 3,
            height: 16,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: AppTextStyles.sectionHeader(isDark),
          ),
          const SizedBox(width: 4),
          Text(
            hindi,
            style: AppTextStyles.caption(isDark),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required String hindi,
    required bool isDark,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColorsDark.divider : AppColors.divider,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(title, hindi, isDark),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String label,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
    required bool isDark,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 22,
              color: isDestructive
                  ? AppColors.error
                  : (isDark ? AppColorsDark.textSecondary : AppColors.textSecondary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.labelLarge(isDark).copyWith(
                      color: isDestructive ? AppColors.error : null,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: AppTextStyles.bodySmall(isDark),
                    ),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow({
    required IconData icon,
    required String label,
    String? subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.labelLarge(isDark),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: AppTextStyles.bodySmall(isDark),
                  ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildSliderRow({
    required String label,
    required IconData icon,
    required double value,
    required double min,
    required double max,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 22,
            color: isDark ? AppColorsDark.textSecondary : AppColors.textSecondary,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTextStyles.labelLarge(isDark),
          ),
          Expanded(
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: (val) => setState(() => value = val),
              activeColor: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final languages = [
          'English',
          'हिंदी (Hindi)',
          'বাংলা (Bengali)',
          'தமிழ் (Tamil)',
          'తెలుగు (Telugu)',
          'मराठी (Marathi)',
          'ಕನ್ನಡ (Kannada)',
          'മലയാളം (Malayalam)',
          'গুজরાતી (Gujarati)',
          'ਪੰਜਾਬੀ (Punjabi)',
        ];
        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(languages[index]),
              leading: Radio<String>(
                value: languages[index],
                groupValue: _selectedLanguage,
                onChanged: (val) {
                  setState(() => _selectedLanguage = val!);
                  Navigator.pop(context);
                },
              ),
              onTap: () {
                setState(() => _selectedLanguage = languages[index]);
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account?'),
        content: const Text(
          'All your encrypted health data, logs, and progress will be permanently erased. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL'),
          ),
          TextButton(
            onPressed: () => context.go('/login'),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('DELETE PERMANENTLY'),
          ),
        ],
      ),
    );
  }
}
