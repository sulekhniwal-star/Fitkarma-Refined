import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class DoshaDonutChart extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;
  final double size;

  const DoshaDonutChart({
    super.key,
    required this.vata,
    required this.pitta,
    required this.kapha,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: size * 0.35,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  value: vata,
                  color: AppColors.purple,
                  title: '',
                  radius: size * 0.15,
                ),
                PieChartSectionData(
                  value: pitta,
                  color: AppColors.primary,
                  title: '',
                  radius: size * 0.15,
                ),
                PieChartSectionData(
                  value: kapha,
                  color: AppColors.teal,
                  title: '',
                  radius: size * 0.15,
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'DOSHA',
                  style: AppTextStyles.caption.copyWith(
                    letterSpacing: 1.2,
                    color: isDarkMode ? AppColors.darkTextMuted : AppColors.textMuted,
                  ),
                ),
                Text(
                  _getMainDosha(),
                  style: AppTextStyles.h2.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: _getMainDoshaColor(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getMainDosha() {
    if (vata >= pitta && vata >= kapha) return 'Vata';
    if (pitta >= vata && pitta >= kapha) return 'Pitta';
    return 'Kapha';
  }

  Color _getMainDoshaColor() {
    if (vata >= pitta && vata >= kapha) return AppColors.purple;
    if (pitta >= vata && pitta >= kapha) return AppColors.primary;
    return AppColors.teal;
  }
}
