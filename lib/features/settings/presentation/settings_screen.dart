import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/security/biometric_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/shared/widgets/abha_badge.dart';
import 'package:fitkarma/features/abha/presentation/link_abha_screen.dart';
import 'package:fitkarma/features/abha/presentation/abha_profile_screen.dart';
import 'package:fitkarma/features/abha/data/abha_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  final BiometricService _biometricService = biometricServiceProvider;

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadABHAStatus();
  }

  Future<void> _loadSettings() async {
    _biometricEnabled = await _biometricService.isBiometricLockEnabled();
    _biometricAvailable = await _biometricService.isBiometricAvailable();
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadABHAStatus() async {
    // Load ABHA profile to check if linked
    try {
      final profileNotifier = ref.read(abhaProfileProvider);
      await profileNotifier.loadProfile();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      // ABHA service not initialized yet, ignore
    }
  }

  Future<void> _toggleBiometric(bool value) async {
    if (value && !_biometricAvailable) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Biometric authentication not available on this device',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    await _biometricService.setBiometricLockEnabled(value);
    setState(() {
      _biometricEnabled = value;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value ? 'Biometric lock enabled' : 'Biometric lock disabled',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  Future<void> _navigateToLinkABHA() async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (context) => const LinkABHAScreen()),
    );

    if (result == true && mounted) {
      // Refresh ABHA status
      await _loadABHAStatus();
    }
  }

  Future<void> _navigateToABHAProfile() async {
    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const ABHAProfileScreen()));

    // Refresh on return
    await _loadABHAStatus();
  }

  @override
  Widget build(BuildContext context) {
    // Watch for ABHA profile changes
    final abhaProfileState = ref.watch(abhaProfileProvider);
    final isAbhaLinked = abhaProfileState.state.isLinked;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 16),

          // Linked Accounts Section
          _buildSectionHeader('Linked Accounts'),
          _buildSettingTile(
            icon: Icons.health_and_safety_rounded,
            title: 'ABHA ID',
            subtitle: isAbhaLinked
                ? abhaProfileState.state.profile?.displayName ?? 'Linked'
                : 'Link your Ayushman Bharat Health Account',
            trailing: isAbhaLinked
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ABHABadge(isLinked: true),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textMuted,
                      ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ABHABadge(isLinked: false),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: AppColors.textMuted,
                      ),
                    ],
                  ),
            onTap: isAbhaLinked ? _navigateToABHAProfile : _navigateToLinkABHA,
          ),

          const Divider(height: 32),

          // Security Section
          _buildSectionHeader('Security'),
          _buildSettingTile(
            icon: Icons.fingerprint,
            title: 'Biometric Lock',
            subtitle: _biometricAvailable
                ? 'Require biometric authentication to open app'
                : 'Not available on this device',
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: _biometricAvailable ? _toggleBiometric : null,
              activeColor: AppColors.primary,
            ),
          ),

          const Divider(height: 32),

          // About Section
          _buildSectionHeader('About'),
          _buildSettingTile(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: '1.0.0',
          ),
          _buildSettingTile(
            icon: Icons.description_outlined,
            title: 'Terms of Service',
            subtitle: 'View terms and conditions',
            onTap: () {
              // TODO: Navigate to terms
            },
          ),
          _buildSettingTile(
            icon: Icons.privacy_tip_outlined,
            title: 'Privacy Policy',
            subtitle: 'View privacy policy',
            onTap: () {
              // TODO: Navigate to privacy policy
            },
          ),

          const Divider(height: 32),

          // Support Section
          _buildSectionHeader('Support'),
          _buildSettingTile(
            icon: Icons.help_outline,
            title: 'Help & FAQ',
            subtitle: 'Get help with common questions',
            onTap: () {
              // TODO: Navigate to help
            },
          ),
          _buildSettingTile(
            icon: Icons.feedback_outlined,
            title: 'Send Feedback',
            subtitle: 'Help us improve Fitkarma',
            onTap: () {
              // TODO: Open feedback
            },
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: AppTextStyles.h4.copyWith(color: AppColors.primary),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.primarySurface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary),
      ),
      title: Text(title, style: AppTextStyles.bodyLarge),
      subtitle: Text(
        subtitle,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textMuted),
      ),
      trailing:
          trailing ??
          (onTap != null
              ? const Icon(Icons.chevron_right, color: AppColors.textMuted)
              : null),
      onTap: onTap,
    );
  }
}
