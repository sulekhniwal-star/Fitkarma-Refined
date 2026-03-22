// lib/features/measurements/presentation/measurement_trend_chart.dart
// Measurement trend chart with configurable metrics

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:intl/intl.dart';

enum MeasurementMetric { weight, bodyFat, waist, hip, chest, arms, thighs }

extension MeasurementMetricExtension on MeasurementMetric {
  String get displayName {
    switch (this) {
      case MeasurementMetric.weight:
        return 'Weight';
      case MeasurementMetric.bodyFat:
        return 'Body Fat %';
      case MeasurementMetric.waist:
        return 'Waist';
      case MeasurementMetric.hip:
        return 'Hip';
      case MeasurementMetric.chest:
        return 'Chest';
      case MeasurementMetric.arms:
        return 'Arms';
      case MeasurementMetric.thighs:
        return 'Thighs';
    }
  }

  String get unit {
    switch (this) {
      case MeasurementMetric.weight:
        return 'kg';
      case MeasurementMetric.bodyFat:
        return '%';
      case MeasurementMetric.waist:
      case MeasurementMetric.hip:
      case MeasurementMetric.chest:
      case MeasurementMetric.arms:
      case MeasurementMetric.thighs:
        return 'cm';
    }
  }

  double? getValue(BodyMeasurement m) {
    switch (this) {
      case MeasurementMetric.weight:
        return m.weightKg;
      case MeasurementMetric.bodyFat:
        return m.bodyFatPercentage;
      case MeasurementMetric.waist:
        return m.waistCm;
      case MeasurementMetric.hip:
        return m.hipCm;
      case MeasurementMetric.chest:
        return m.chestCm;
      case MeasurementMetric.arms:
        return m.armsCm;
      case MeasurementMetric.thighs:
        return m.thighsCm;
    }
  }

  Color get color {
    switch (this) {
      case MeasurementMetric.weight:
        return const Color(0xFF2196F3); // Blue
      case MeasurementMetric.bodyFat:
        return const Color(0xFFFF9800); // Orange
      case MeasurementMetric.waist:
        return const Color(0xFFF44336); // Red
      case MeasurementMetric.hip:
        return const Color(0xFF9C27B0); // Purple
      case MeasurementMetric.chest:
        return const Color(0xFF4CAF50); // Green
      case MeasurementMetric.arms:
        return const Color(0xFF00BCD4); // Cyan
      case MeasurementMetric.thighs:
        return const Color(0xFF795548); // Brown
    }
  }
}

class MeasurementTrendChart extends StatelessWidget {
  final List<BodyMeasurement> measurements;
  final MeasurementMetric metric;
  final int days;

  const MeasurementTrendChart({
    super.key,
    required this.measurements,
    required this.metric,
    this.days = 30,
  });

  @override
  Widget build(BuildContext context) {
    if (measurements.isEmpty) {
      return _buildEmptyState();
    }

    // Sort by date
    final sortedMeasurements = List<BodyMeasurement>.from(measurements)
      ..sort((a, b) => a.measuredAt.compareTo(b.measuredAt));

    // Create data points
    final spots = <FlSpot>[];
    for (var i = 0; i < sortedMeasurements.length; i++) {
      final m = sortedMeasurements[i];
      final value = metric.getValue(m);
      if (value != null) {
        spots.add(FlSpot(i.toDouble(), value));
      }
    }

    if (spots.isEmpty) {
      return _buildEmptyState();
    }

    return _buildChart(spots, sortedMeasurements);
  }

  Widget _buildEmptyState() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.show_chart, size: 48, color: Colors.grey[400]),
          const SizedBox(height: 8),
          Text(
            'No ${metric.displayName.toLowerCase()} data yet',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Log your measurements to see trends',
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(
    List<FlSpot> spots,
    List<BodyMeasurement> sortedMeasurements,
  ) {
    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;
    final padding = range * 0.1;

    return Container(
      height: 220,
      padding: const EdgeInsets.only(right: 16, top: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: range > 0 ? range / 4 : 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.grey[300]!, strokeWidth: 1);
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 45,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toStringAsFixed(1),
                    style: TextStyle(color: Colors.grey[600], fontSize: 10),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                interval: spots.length > 7
                    ? (spots.length / 5).ceil().toDouble()
                    : 1,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < sortedMeasurements.length) {
                    final date = sortedMeasurements[index].measuredAt;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        DateFormat('MM/dd').format(date),
                        style: TextStyle(color: Colors.grey[600], fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: (spots.length - 1).toDouble(),
          minY: minY - padding,
          maxY: maxY + padding,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: metric.color,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: metric.color,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: metric.color.withValues(alpha: 0.1),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final index = spot.spotIndex;
                  if (index >= 0 && index < sortedMeasurements.length) {
                    final date = sortedMeasurements[index].measuredAt;
                    return LineTooltipItem(
                      '${metric.displayName}: ${spot.y.toStringAsFixed(1)} ${metric.unit}\n${DateFormat('MMM dd').format(date)}',
                      const TextStyle(color: Colors.white, fontSize: 12),
                    );
                  }
                  return null;
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
