import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/abha_badge.dart';
import '../data/abha_providers.dart';
import '../data/models/abha_profile.dart';
import 'abha_records_screen.dart';

/// Screen displaying the linked ABHA profile
class ABHAProfileScreen extends ConsumerStatefulWidget {
  const ABHAProfileScreen({super.key});

  @override
  ConsumerState<ABHAProfileScreen> createState() => _ABHAProfileScreenState();
}

class _ABHAProfileScreenState extends ConsumerState<ABHAProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Load profile on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(abhaProfileProvider).loadProfile();
    });
  }

  Future<void> _showUnlinkConfirmation() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Unlink ABHA?'),
        content: const Text(
          'This will remove your ABHA ID from Fitkarma. You can link it again anytime. Your local health records will not be affected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Unlink'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await ref.read(abhaLinkingStatusProvider).unlink();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('ABHA unlinked successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileNotifier = ref.watch(abhaProfileProvider);
    final profileState = profileNotifier.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ABHA Profile'),
        actions: [
          if (profileState.isLinked)
            IconButton(
              icon: const Icon(Icons.delete_outline_rounded),
              color: AppColors.error,
              onPressed: _showUnlinkConfirmation,
              tooltip: 'Unlink ABHA',
            ),
        ],
      ),
      body: profileState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profileState.profile == null
          ? _buildNotLinked()
          : _buildProfile(profileState.profile!),
    );
  }

  Widget _buildNotLinked() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.link_off_rounded,
                size: 48,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 24),
            Text('ABHA Not Linked', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            Text(
              'Link your Ayushman Bharat Health Account to access verified medical records',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.link_rounded),
              label: const Text('Link ABHA'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfile(ABHAProfile profile) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                // Avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  profile.displayName,
                  style: AppTextStyles.h3.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),

                // Health ID
                Text(
                  profile.healthId,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
                const SizedBox(height: 12),

                // Verified Badge
                ABHABadge(isLinked: true, isLarge: true),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Profile Details
          Text('Profile Details', style: AppTextStyles.h4),
          const SizedBox(height: 12),

          if (profile.healthIdNumber != null)
            _buildDetailRow(
              icon: Icons.numbers_rounded,
              label: 'ABHA Number',
              value: profile.maskedHealthId,
            ),

          if (profile.gender != null)
            _buildDetailRow(
              icon: Icons.wc_rounded,
              label: 'Gender',
              value: profile.gender!,
            ),

          if (profile.dateOfBirth != null)
            _buildDetailRow(
              icon: Icons.cake_rounded,
              label: 'Date of Birth',
              value:
                  '${profile.dateOfBirth!.day}/${profile.dateOfBirth!.month}/${profile.dateOfBirth!.year}',
            ),

          if (profile.email != null)
            _buildDetailRow(
              icon: Icons.email_rounded,
              label: 'Email',
              value: profile.email!,
            ),

          if (profile.phone != null)
            _buildDetailRow(
              icon: Icons.phone_rounded,
              label: 'Phone',
              value: profile.phone!,
            ),

          if (profile.state != null || profile.district != null)
            _buildDetailRow(
              icon: Icons.location_on_rounded,
              label: 'Location',
              value: [
                profile.district,
                profile.state,
              ].where((e) => e != null).join(', '),
            ),

          const SizedBox(height: 24),

          // Sync Info
          if (profile.lastSyncedAt != null)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.sync_rounded,
                    size: 20,
                    color: AppColors.textMuted,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Last synced: ${_formatDate(profile.lastSyncedAt!)}',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ref.read(abhaProfileProvider).refreshProfile();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Refresh'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ABHARecordsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.description_rounded),
                  label: const Text('Records'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primarySurface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(value, style: AppTextStyles.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inHours < 1) return '${diff.inMinutes} minutes ago';
    if (diff.inDays < 1) return '${diff.inHours} hours ago';
    if (diff.inDays < 7) return '${diff.inDays} days ago';

    return '${date.day}/${date.month}/${date.year}';
  }
}
