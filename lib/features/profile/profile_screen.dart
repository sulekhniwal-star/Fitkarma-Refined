import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Me 👤'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(),
              const SizedBox(height: 32),
              _buildSection('Social & Community', [
                _ProfileMenuItem(
                  icon: Icons.family_restroom,
                  title: 'Family Hub',
                  subtitle: 'Compete with family members',
                  onTap: () => context.push('/family'),
                  color: Colors.blue,
                ),
                _ProfileMenuItem(
                  icon: Icons.groups_outlined,
                  title: 'Community Groups',
                  subtitle: 'Join fitness tribes',
                  onTap: () => context.push('/community/groups'),
                  color: Colors.green,
                ),
              ]),
              const SizedBox(height: 24),
              _buildSection('Health & Devices', [
                _ProfileMenuItem(
                  icon: Icons.watch_outlined,
                  title: 'Wearable Sync',
                  subtitle: 'Garmin, Fitbit, Apple Watch',
                  onTap: () => context.push('/wearables'),
                  color: Colors.purple,
                ),
                _ProfileMenuItem(
                  icon: Icons.history,
                  title: 'Health Data History',
                  subtitle: 'BP, Glucose, SpO2 logs',
                  onTap: () => context.push('/health-reports'),
                  color: Colors.red,
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Column(
      children: [
        const CircleAvatar(
          radius: 50,
          backgroundColor: AppColors.primary,
          child: Text('SA', style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 16),
        const Text('Sulekh Niwal', style: AppTextStyles.titleLarge),
        const Text('Pro Plan User', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
              color: Colors.orange.shade50, borderRadius: BorderRadius.circular(12)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text('2,450 XP', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(title, style: AppTextStyles.titleSmall.copyWith(color: Colors.grey)),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: items),
        ),
      ],
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const _ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }
}
