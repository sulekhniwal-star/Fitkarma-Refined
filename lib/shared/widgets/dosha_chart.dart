import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// A pie chart displaying the balance of Vata, Pitta, and Kapha doshas.
class DoshaChart extends StatelessWidget {
  final double vataPct;
  final double pittaPct;
  final double kaphaPct;

  const DoshaChart({
    super.key,
    required this.vataPct,
    required this.pittaPct,
    required this.kaphaPct,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dominant = _getDominantDosha();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 60,
                  sections: [
                    PieChartSectionData(
                      value: vataPct,
                      color: Colors.lightBlue[300],
                      title: '',
                      radius: 20,
                    ),
                    PieChartSectionData(
                      value: pittaPct,
                      color: Colors.redAccent[700],
                      title: '',
                      radius: 20,
                    ),
                    PieChartSectionData(
                      value: kaphaPct,
                      color: Colors.green[600],
                      title: '',
                      radius: 20,
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    dominant.toUpperCase(),
                    style: (isDark ? AppTypography.h2() : AppTypography.h2(color: AppColorsLight.textPrimary)),
                  ),
                  Text(
                    'Dominant',
                    style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _LegendItem(label: 'Vata', color: Colors.lightBlue[300]!, isDark: isDark),
            const SizedBox(width: 16),
            _LegendItem(label: 'Pitta', color: Colors.redAccent[700]!, isDark: isDark),
            const SizedBox(width: 16),
            _LegendItem(label: 'Kapha', color: Colors.green[600]!, isDark: isDark),
          ],
        ),
      ],
    );
  }

  String _getDominantDosha() {
    if (vataPct >= pittaPct && vataPct >= kaphaPct) return 'Vata';
    if (pittaPct >= vataPct && pittaPct >= kaphaPct) return 'Pitta';
    return 'Kapha';
  }
}

class _LegendItem extends StatelessWidget {
  final String label;
  final Color color;
  final bool isDark;

  const _LegendItem({
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)),
        ),
      ],
    );
  }
}

