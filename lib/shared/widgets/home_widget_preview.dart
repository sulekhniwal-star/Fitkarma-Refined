import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class HomeWidgetPreview extends StatelessWidget {
  final int steps;
  final int calories;
  final int sleepMinutes;
  final double waterGlasses;

  const HomeWidgetPreview({
    super.key,
    required this.steps,
    required this.calories,
    required this.sleepMinutes,
    required this.waterGlasses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 180,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF161B22), Color(0xFF21262D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('🧘', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 6),
              Text(
                'Fitkarma',
                style: AppTextStyles.labelSmall.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          const Spacer(),
          _StatRow(
            icon: Icons.directions_walk_rounded,
            value: _formatNumber(steps),
            label: 'steps',
            color: AppColors.stepsBlue,
          ),
          const SizedBox(height: 6),
          _StatRow(
            icon: Icons.local_fire_department_rounded,
            value: '$calories',
            label: 'kcal',
            color: AppColors.caloriesOrange,
          ),
          const SizedBox(height: 6),
          _StatRow(
            icon: Icons.bedtime_rounded,
            value: '${sleepMinutes ~/ 60}h ${sleepMinutes % 60}m',
            label: 'sleep',
            color: AppColors.sleepPurple,
          ),
          const SizedBox(height: 6),
          _StatRow(
            icon: Icons.water_drop_rounded,
            value: '${waterGlasses.toStringAsFixed(1)}',
            label: 'glasses',
            color: AppColors.waterCyan,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatRow({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(
          value,
          style: AppTextStyles.labelLarge.copyWith(color: Colors.white),
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: AppTextStyles.overline.copyWith(
            color: Colors.white.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }
}
