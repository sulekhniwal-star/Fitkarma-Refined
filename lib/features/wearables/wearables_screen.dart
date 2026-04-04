import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/wearables/data/wearable_repository.dart';
import 'package:fitkarma/features/wearables/data/wearable_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class WearablesScreen extends ConsumerWidget {
  const WearablesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(wearableRepositoryProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Wearable Devices ⌚'),
        centerTitle: true,
        actions: [
          if (state.isSyncing)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: SizedBox(
                width: 20, height: 20,
                child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.sync),
              onPressed: () => ref.read(wearableRepositoryProvider.notifier).syncData(force: true),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSyncStatus(state),
            const SizedBox(height: 24),
            Text('Primary Platforms', style: AppTextStyles.titleSmall.copyWith(color: Colors.grey)),
            const SizedBox(height: 12),
            _buildPlatformCard(
              context,
              ref,
              title: _getCorePlatformName(context),
              subtitle: 'Steps, Sleep, HR, SpO2, BP',
              icon: Icons.health_and_safety,
              platform: _getCorePlatform(context),
              isConnected: state.connectedPlatforms[_getCorePlatform(context)] ?? false,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            Text('Direct Integrations', style: AppTextStyles.titleSmall.copyWith(color: Colors.grey)),
            const SizedBox(height: 12),
            _buildPlatformCard(
              context,
              ref,
              title: 'Fitbit',
              subtitle: 'Steps, Sleep, HR',
              icon: Icons.watch_outlined,
              platform: WearablePlatform.fitbit,
              isConnected: state.connectedPlatforms[WearablePlatform.fitbit] ?? false,
              color: Colors.teal,
              isBeta: true,
            ),
            const SizedBox(height: 12),
            _buildPlatformCard(
              context,
              ref,
              title: 'Garmin Connect',
              subtitle: 'Steps, HR, Calories',
              icon: Icons.sports_handball,
              platform: WearablePlatform.garmin,
              isConnected: state.connectedPlatforms[WearablePlatform.garmin] ?? false,
              color: Colors.blueGrey,
              isBeta: true,
            ),
            const SizedBox(height: 24),
            Text('Bridges', style: AppTextStyles.titleSmall.copyWith(color: Colors.grey)),
            const SizedBox(height: 12),
            _buildBridgeItem(
              title: 'Mi Band / boAt',
              subtitle: 'Supported via Google Health Connect',
              icon: Icons.link,
            ),
            const SizedBox(height: 32),
            _buildSettings(ref, state),
          ],
        ),
      ),
    );
  }

  WearablePlatform _getCorePlatform(BuildContext context) => 
      Theme.of(context).platform == TargetPlatform.iOS 
          ? WearablePlatform.healthKit 
          : WearablePlatform.healthConnect;

  String _getCorePlatformName(BuildContext context) => 
      Theme.of(context).platform == TargetPlatform.iOS 
          ? 'Apple HealthKit' 
          : 'Health Connect (Android)';

  Widget _buildSyncStatus(WearableState state) {
    final lastSync = state.lastSyncAt;
    final timeStr = lastSync != null 
        ? '${lastSync.hour}:${lastSync.minute.toString().padLeft(2, '0')}' 
        : 'Never';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          const Icon(Icons.cloud_done, color: AppColors.primary, size: 32),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Device Sync Active', style: AppTextStyles.titleSmall),
              Text('Last successful sync: $timeStr', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const Spacer(),
          if (state.lastSyncAt != null)
            const Icon(Icons.check_circle, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required IconData icon,
    required WearablePlatform platform,
    required bool isConnected,
    required Color color,
    bool isBeta = false,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color),
          ),
          title: Row(
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              if (isBeta)
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(4)),
                  child: const Text('BETA', style: TextStyle(fontSize: 8, color: Colors.orange, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
          trailing: isConnected 
              ? const Icon(Icons.check_circle, color: Colors.green)
              : OutlinedButton(
                  onPressed: () => _handleConnect(ref, platform),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: const Text('Connect'),
                ),
        ),
      ),
    );
  }

  Widget _buildBridgeItem({required String title, required String subtitle, required IconData icon}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 11)),
      dense: true,
    );
  }

  Widget _buildSettings(WidgetRef ref, WearableState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Sync Settings', style: AppTextStyles.titleSmall),
        const SizedBox(height: 12),
        SwitchListTile(
          value: state.isLowDataMode,
          onChanged: (v) => ref.read(wearableRepositoryProvider.notifier).toggleLowDataMode(v),
          title: const Text('Low Data Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          subtitle: const Text('Reduces sync frequency to every 6 hours', style: TextStyle(fontSize: 12)),
          activeColor: AppColors.primary,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  void _handleConnect(WidgetRef ref, WearablePlatform platform) {
    if (platform == WearablePlatform.healthConnect || platform == WearablePlatform.healthKit) {
      ref.read(wearableRepositoryProvider.notifier).connectHealthPlatform();
    } else {
      ref.read(wearableRepositoryProvider.notifier).connectProvider(platform);
    }
  }
}
