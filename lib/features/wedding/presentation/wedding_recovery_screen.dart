import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/theme/app_colors.dart';

class WeddingRecoveryScreen extends ConsumerWidget {
  const WeddingRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recovery & De-stress'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DeStressAlert(),
            const SizedBox(height: 24),
            _RecoveryMetric(
              icon: Icons.water_drop,
              title: 'Hydration Track',
              subtitle: 'Aim for 3L daily for a wedding glow.',
              color: Colors.blue,
              actionLabel: 'LOG WATER',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _RecoveryMetric(
              icon: Icons.nights_stay,
              title: 'Sleep Target (7h+)',
              subtitle: 'Consistent sleep reduces cortisol levels.',
              color: AppColors.secondary,
              actionLabel: 'LOG SLEEP',
              onTap: () {},
            ),
            const SizedBox(height: 16),
            _RecoveryMetric(
              icon: Icons.spa,
              title: 'Pranayama & Calm',
              subtitle: '10 mins of breathing to manage rituals.',
              color: AppColors.teal,
              actionLabel: 'START BREATHING',
              onTap: () {},
            ),
            const SizedBox(height: 32),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Avoid New Products', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 8),
                    Text('Stick to your regular skincare routine. No new treatments or drastic diet changes in the last 14 days.', textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeStressAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.teal.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.teal.withOpacity(0.3)),
      ),
      child: const Row(
        children: [
          Icon(Icons.check_circle_outline, color: AppColors.teal, size: 32),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You are 4 weeks to wedding', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Prioritize recovery. High intensity workouts should decrease soon.', style: TextStyle(fontSize: 13, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecoveryMetric extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final String actionLabel;
  final VoidCallback onTap;

  const _RecoveryMetric({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: color,
                  side: BorderSide(color: color),
                ),
                child: Text(actionLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
