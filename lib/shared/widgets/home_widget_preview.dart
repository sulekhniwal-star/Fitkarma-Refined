import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Scaled preview of Android/iOS home screen widgets.
class HomeWidgetPreview extends StatelessWidget {
  final int steps;
  final int calories;
  final int karmaPoints;
  final double stepsTarget;
  final double caloriesTarget;

  const HomeWidgetPreview({
    super.key,
    required this.steps,
    required this.calories,
    required this.karmaPoints,
    this.stepsTarget = 10000,
    this.caloriesTarget = 2000,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Home Widget Preview', style: AppTextStyles.titleSmall),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _WidgetTile(
                label: 'Steps',
                value: _formatNumber(steps),
                target: _formatNumber(stepsTarget.toInt()),
                progress: (steps / stepsTarget).clamp(0, 1),
                color: const Color(0xFFFF9500),
                icon: Icons.directions_walk,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _WidgetTile(
                label: 'Calories',
                value: '$calories',
                target: '${caloriesTarget.toInt()}',
                progress: (calories / caloriesTarget).clamp(0, 1),
                color: const Color(0xFF2ECC71),
                icon: Icons.local_fire_department,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _WidgetTile(
                label: 'Karma',
                value: '$karmaPoints',
                target: '',
                progress: 1,
                color: const Color(0xFFFFD700),
                icon: Icons.star,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatNumber(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
    return '$n';
  }
}

class _WidgetTile extends StatelessWidget {
  final String label;
  final String value;
  final String target;
  final double progress;
  final Color color;
  final IconData icon;

  const _WidgetTile({
    required this.label,
    required this.value,
    required this.target,
    required this.progress,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: Theme.of(context)
                .colorScheme
                .outline
                .withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.headlineSmall.copyWith(color: color),
          ),
          if (target.isNotEmpty)
            Text(
              '/ $target',
              style: AppTextStyles.labelSmall,
            ),
          if (target.isNotEmpty) ...[
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 4,
                backgroundColor: color.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation(color),
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(label, style: AppTextStyles.labelSmall),
        ],
      ),
    );
  }
}
