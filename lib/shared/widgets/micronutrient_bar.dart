import 'package:flutter/material.dart';

enum NutrientType { iron, vitaminB12, vitaminD, calcium }

class MicronutrientBar extends StatelessWidget {
  final NutrientType nutrient;
  final double current;
  final double target;
  final String? unit;
  final bool showLabel;

  const MicronutrientBar({
    super.key,
    required this.nutrient,
    required this.current,
    required this.target,
    this.unit = 'mg',
    this.showLabel = true,
  });

  String get _label {
    switch (nutrient) {
      case NutrientType.iron:
        return 'Iron';
      case NutrientType.vitaminB12:
        return 'Vitamin B12';
      case NutrientType.vitaminD:
        return 'Vitamin D';
      case NutrientType.calcium:
        return 'Calcium';
    }
  }

  Color get _color {
    final percentage = (current / target * 100).clamp(0, 100);
    if (percentage >= 80) return Colors.green;
    if (percentage >= 50) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (current / target * 100).clamp(0, 100);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showLabel)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _label,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '${current.toStringAsFixed(1)}/$target${unit ?? ''}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: _color,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(_color),
            minHeight: 8,
          ),
        ),
      ],
    );
  }
}