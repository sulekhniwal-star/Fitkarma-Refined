import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class MicronutrientBar extends StatelessWidget {
  final String label;
  final double current;
  final double target;
  final String unit;
  final Color? color;

  const MicronutrientBar({
    super.key,
    required this.label,
    required this.current,
    required this.target,
    this.unit = '%',
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final pct = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;
    final barColor = color ?? _defaultColor(label);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: Text(
              label,
              style: AppTextStyles.labelSmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: pct,
                minHeight: 6,
                backgroundColor: isDark
                    ? barColor.withValues(alpha: 0.15)
                    : barColor.withValues(alpha: 0.12),
                valueColor: AlwaysStoppedAnimation<Color>(barColor),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 36,
            child: Text(
              unit == '%' ? '${(pct * 100).round()}%' : '${current.round()}$unit',
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  static Color _defaultColor(String label) {
    switch (label.toLowerCase()) {
      case 'iron':
        return const Color(0xFFE17055);
      case 'b12':
        return const Color(0xFF6C5CE7);
      case 'vit d':
      case 'vitamin d':
        return const Color(0xFFFDCB6E);
      case 'calcium':
        return const Color(0xFF74B9FF);
      default:
        return const Color(0xFF00B894);
    }
  }
}

class MicronutrientGrid extends StatelessWidget {
  final List<MicronutrientBar> bars;

  const MicronutrientGrid({super.key, required this.bars});

  @override
  Widget build(BuildContext context) {
    return Column(children: bars);
  }
}
