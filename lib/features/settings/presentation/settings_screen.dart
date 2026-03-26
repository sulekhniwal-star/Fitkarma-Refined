import 'package:fitkarma/core/di/providers.dart';
import 'package:fitkarma/core/network/sync_queue.dart';
import 'package:fitkarma/features/abha/data/abha_providers.dart';
import 'package:fitkarma/features/abha/presentation/abha_profile_screen.dart';
import 'package:fitkarma/features/abha/presentation/link_abha_screen.dart';
import 'package:fitkarma/features/period/presentation/period_tracking_screen.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/shared/widgets/abha_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/security/biometric_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;
  bool _periodSyncEnabled = false; // Default is local-only
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

  Future<void> _toggleLowDataMode(bool value) async {
    // Get sync queue instance and update interval
    final syncQueue = SyncQueueService.instance;
    syncQueue.updateSyncInterval();

    await ref.read(lowDataModeServiceProvider).setLowDataMode(value);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value
                ? 'Low Data Mode enabled - images disabled, sync reduced to every 6 hours'
                : 'Low Data Mode disabled',
          ),
          backgroundColor: value ? AppColors.warning : AppColors.success,
        ),
      );
    }
  }

  Future<void> _toggleAutoDetect(bool value) async {
    await ref.read(lowDataModeServiceProvider).setAutoDetect(value);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            value
                ? 'Auto-detect enabled - will automatically enable on slow connections'
                : 'Auto-detect disabled',
          ),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  void _togglePeriodSync(bool value) {
    setState(() {
      _periodSyncEnabled = value;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          value
              ? 'Period data sync enabled - your data will be backed up to cloud'
              : 'Period data sync disabled - data stored locally only',
        ),
        backgroundColor: value ? AppColors.success : AppColors.warning,
      ),
    );
  }

  void _navigateToPeriodTracking() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PeriodTrackingScreen()),
    );
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

    // Watch for low data mode changes
    final lowDataModeEnabled = ref
        .watch(lowDataModeServiceProvider)
        .isLowDataModeEnabled;

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

          // Health Data Section
          _buildSectionHeader('Health Data'),
          _buildSettingTile(
            icon: Icons.cloud_sync_outlined,
            title: 'Sync Period Data',
            subtitle: 'Enable cloud sync for period data (opt-in)',
            trailing: Switch(
              value: _periodSyncEnabled,
              onChanged: _togglePeriodSync,
              activeThumbColor: AppColors.primary,
            ),
          ),
          _buildSettingTile(
            icon: Icons.woman_outlined,
            title: 'Period Tracking',
            subtitle: 'Track your menstrual cycle',
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.textMuted,
            ),
            onTap: _navigateToPeriodTracking,
          ),

          const Divider(height: 32),

          const Divider(height: 32),

          // Data & Sync Section
          _buildSectionHeader('Data & Sync'),
          _buildSettingTile(
            icon: Icons.data_saver_on_outlined,
            title: 'Low Data Mode',
            subtitle: 'Disable images, sync every 6 hours',
            trailing: Switch(
              value: lowDataModeEnabled,
              onChanged: _toggleLowDataMode,
              activeThumbColor: AppColors.primary,
            ),
            onTap: () => _toggleLowDataMode(!lowDataModeEnabled),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 72, right: 16),
            child: Row(
              children: [
                Icon(Icons.wifi_find, size: 18, color: AppColors.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Auto-detect slow connections',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textMuted,
                    ),
                  ),
                ),
                Switch(
                  value: ref
                      .watch(lowDataModeServiceProvider)
                      .isAutoDetectEnabled,
                  onChanged: _toggleAutoDetect,
                  activeThumbColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

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
              activeThumbColor: AppColors.primary,
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
