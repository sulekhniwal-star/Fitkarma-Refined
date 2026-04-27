import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MicronutrientBar extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const MicronutrientBar({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
            Text('${(value * 100).toInt()}%', style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class DoshaDonutChart extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;

  const DoshaDonutChart({
    super.key,
    required this.vata,
    required this.pitta,
    required this.kapha,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          sectionsSpace: 4,
          centerSpaceRadius: 40,
          sections: [
            PieChartSectionData(
              value: vata,
              title: 'Vata',
              color: Colors.blue,
              radius: 20,
              showTitle: false,
            ),
            PieChartSectionData(
              value: pitta,
              title: 'Pitta',
              color: Colors.orange,
              radius: 20,
              showTitle: false,
            ),
            PieChartSectionData(
              value: kapha,
              title: 'Kapha',
              color: Colors.green,
              radius: 20,
              showTitle: false,
            ),
          ],
        ),
      ),
    );
  }
}
