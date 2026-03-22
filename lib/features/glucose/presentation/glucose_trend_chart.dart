// lib/features/glucose/presentation/glucose_trend_chart.dart
// Glucose trend chart with configurable target bands

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/glucose/data/glucose_service.dart';

class GlucoseTrendChart extends StatelessWidget {
  final List<GlucoseLog> logs;
  final GlucoseReadingType? filterType;
  final GlucoseTargetBands? customBands;
  final int days;

  const GlucoseTrendChart({
    super.key,
    required this.logs,
    this.filterType,
    this.customBands,
    this.days = 7,
  });

  @override
  Widget build(BuildContext context) {
    if (logs.isEmpty) {
      return _buildEmptyState();
    }

    // Filter logs by reading type if specified
    final filteredLogs = filterType != null
        ? logs.where((l) => l.readingType == filterType!.dbValue).toList()
        : logs;

    if (filteredLogs.isEmpty) {
      return _buildEmptyState();
    }

    // Sort by date
    final sortedLogs = List<GlucoseLog>.from(filteredLogs)
      ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

    // Get target bands
    final bands = customBands ?? GlucoseTargetBands.fasting;

    // Create data points
    final spots = <FlSpot>[];
    for (var i = 0; i < sortedLogs.length; i++) {
      final log = sortedLogs[i];
      if (log.glucoseMgdl != null) {
        spots.add(FlSpot(i.toDouble(), log.glucoseMgdl!));
      }
    }

    if (spots.isEmpty) {
      return _buildEmptyState();
    }

    return _buildChart(spots, sortedLogs, bands);
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
            'No glucose data yet',
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            'Log your glucose to see trends',
            style: TextStyle(color: Colors.grey[400], fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(
    List<FlSpot> spots,
    List<GlucoseLog> logs,
    GlucoseTargetBands bands,
  ) {
    final minY = (spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 20)
        .clamp(0.0, double.infinity);
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b) + 20.0;

    return SizedBox(
      height: 250,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 16),
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 20,
              getDrawingHorizontalLine: (value) {
                Color lineColor = Colors.grey[200]!;
                double lineWidth = 1;

                // Highlight target bands
                if (value >= bands.normalMin && value <= bands.normalMax) {
                  lineColor = Colors.green.withOpacity(0.3);
                  lineWidth = 2;
                }

                return FlLine(color: lineColor, strokeWidth: lineWidth);
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  interval: 40,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    );
                  },
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < logs.length) {
                      // Show fewer labels to avoid crowding
                      if (logs.length > 7 && index % (logs.length ~/ 5) != 0) {
                        return const SizedBox.shrink();
                      }
                      final log = logs[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          _formatDate(log.loggedAt),
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 9,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              // Main data line
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: 0.3,
                color: _getLineColor(spots),
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final classification = _getClassificationForValue(
                      spot.y,
                      filterType ?? GlucoseReadingType.random,
                    );
                    return FlDotCirclePainter(
                      radius: 5,
                      color: Color(classification.colorValue),
                      strokeWidth: 2,
                      strokeColor: Colors.white,
                    );
                  },
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      _getLineColor(spots).withOpacity(0.3),
                      _getLineColor(spots).withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ],
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                // Low boundary ( hypoglycemia)
                HorizontalLine(
                  y: 70,
                  color: Colors.purple.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: TextStyle(
                      color: Colors.purple.withOpacity(0.7),
                      fontSize: 10,
                    ),
                    labelResolver: (line) => 'Low (<70)',
                  ),
                ),
                // Normal range start
                HorizontalLine(
                  y: bands.normalMin,
                  color: Colors.green.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                ),
                // Normal range end
                HorizontalLine(
                  y: bands.normalMax,
                  color: Colors.green.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: TextStyle(
                      color: Colors.green.withOpacity(0.7),
                      fontSize: 10,
                    ),
                    labelResolver: (line) => 'Normal',
                  ),
                ),
                // Pre-diabetes/high
                HorizontalLine(
                  y: bands.highNormalMin,
                  color: Colors.orange.withOpacity(0.5),
                  strokeWidth: 1,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: TextStyle(
                      color: Colors.orange.withOpacity(0.7),
                      fontSize: 10,
                    ),
                    labelResolver: (line) => 'High',
                  ),
                ),
              ],
            ),
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    final index = spot.spotIndex;
                    if (index >= 0 && index < logs.length) {
                      final log = logs[index];
                      final classification = classifyGlucose(
                        log.glucoseMgdl ?? 0,
                        GlucoseReadingTypeExtension.fromDbValue(
                          log.readingType,
                        ),
                      );
                      return LineTooltipItem(
                        '${log.glucoseMgdl?.toStringAsFixed(0)} mg/dL\n${log.readingType}\n${classification.displayName}',
                        TextStyle(
                          color: Color(classification.colorValue),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      );
                    }
                    return null;
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getLineColor(List<FlSpot> spots) {
    // Check if most readings are in normal range
    int normalCount = 0;
    for (final spot in spots) {
      final classification = _getClassificationForValue(
        spot.y,
        filterType ?? GlucoseReadingType.random,
      );
      if (classification.isNormal) normalCount++;
    }

    if (normalCount == spots.length) {
      return Colors.green;
    } else if (normalCount > spots.length * 0.5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  GlucoseClassification _getClassificationForValue(
    double value,
    GlucoseReadingType type,
  ) {
    return classifyGlucose(value, type);
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}';
  }
}

/// Legend widget for glucose chart
class GlucoseChartLegend extends StatelessWidget {
  const GlucoseChartLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: [
        _buildLegendItem('Low (<70)', Colors.purple),
        _buildLegendItem('Normal', Colors.green),
        _buildLegendItem('Pre-Diabetes', Colors.orange),
        _buildLegendItem('High (Diabetes)', Colors.red),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
