import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Compact progress bar for a single micronutrient.
class MicronutrientBar extends StatelessWidget {
  final String label;
  final double current;
  final double target;
  final String unit;
  final Color color;

  const MicronutrientBar({
    super.key,
    required this.label,
    required this.current,
    required this.target,
    this.unit = 'mg',
    this.color = const Color(0xFF2ECC71),
  });

  @override
  Widget build(BuildContext context) {
    final pct = target > 0 ? (current / target).clamp(0.0, 1.0) : 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.labelMedium),
              Text(
                '${current.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} $unit',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: color.withOpacity(0.12),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Convenience: renders Iron, B12, Vit D, Calcium in a column.
class MicronutrientPanel extends StatelessWidget {
  final double iron;
  final double b12;
  final double vitD;
  final double calcium;
  final double ironTarget;
  final double b12Target;
  final double vitDTarget;
  final double calciumTarget;

  const MicronutrientPanel({
    super.key,
    required this.iron,
    required this.b12,
    required this.vitD,
    required this.calcium,
    this.ironTarget = 18,
    this.b12Target = 2.4,
    this.vitDTarget = 15,
    this.calciumTarget = 1000,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MicronutrientBar(
            label: 'Iron',
            current: iron,
            target: ironTarget,
            unit: 'mg',
            color: const Color(0xFFE74C3C)),
        MicronutrientBar(
            label: 'B12',
            current: b12,
            target: b12Target,
            unit: 'µg',
            color: const Color(0xFF9B59B6)),
        MicronutrientBar(
            label: 'Vit D',
            current: vitD,
            target: vitDTarget,
            unit: 'µg',
            color: const Color(0xFFF39C12)),
        MicronutrientBar(
            label: 'Calcium',
            current: calcium,
            target: calciumTarget,
            unit: 'mg',
            color: const Color(0xFF3498DB)),
      ],
    );
  }
}
