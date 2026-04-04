import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../theme/app_colors.dart';

class DoshaDonutChart extends StatelessWidget {
  final Map<String, double> percentages;
  final double size;

  const DoshaDonutChart({
    super.key,
    required this.percentages,
    this.size = 120,
  });

  @override
  Widget build(BuildContext context) {
    final vata = percentages['Vata'] ?? 0;
    final pitta = percentages['Pitta'] ?? 0;
    final kapha = percentages['Kapha'] ?? 0;

    return SizedBox(
      height: size,
      width: size,
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: size * 0.3,
          startDegreeOffset: -90,
          sections: [
            PieChartSectionData(
              value: vata,
              color: AppColors.primary,
              title: vata > 10 ? 'V' : '',
              radius: size * 0.15,
              titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              value: pitta,
              color: AppColors.secondary,
              title: pitta > 10 ? 'P' : '',
              radius: size * 0.15,
              titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            PieChartSectionData(
              value: kapha,
              color: AppColors.accent,
              title: kapha > 10 ? 'K' : '',
              radius: size * 0.15,
              titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
