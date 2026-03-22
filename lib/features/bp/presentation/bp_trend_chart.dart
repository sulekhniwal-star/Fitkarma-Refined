// lib/features/bp/presentation/bp_trend_chart.dart
// BP Trend Chart with AHA colour bands using fl_chart

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/bp/data/bp_service.dart';
import 'package:drift/drift.dart' hide Column;

class BpTrendChart extends StatefulWidget {
  final String userId;

  const BpTrendChart({super.key, required this.userId});

  @override
  State<BpTrendChart> createState() => _BpTrendChartState();
}

class _BpTrendChartState extends State<BpTrendChart> {
  int _selectedPeriod = 7; // 7, 30, or 90 days
  List<BloodPressureLog> _logs = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    // In a real implementation, this would load from the database
    // For now, we'll simulate some data
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Period selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Trends',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    _buildPeriodChip(7, '7D'),
                    const SizedBox(width: 8),
                    _buildPeriodChip(30, '30D'),
                    const SizedBox(width: 8),
                    _buildPeriodChip(90, '90D'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Chart
            if (_isLoading)
              const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_logs.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.show_chart, size: 48, color: Colors.grey[400]),
                      const SizedBox(height: 8),
                      Text(
                        'No data for this period',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(height: 200, child: _buildChart()),

            const SizedBox(height: 16),

            // Legend
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodChip(int days, String label) {
    final isSelected = _selectedPeriod == days;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedPeriod = days);
        _loadData();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey[300]!,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 35,
              interval: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: _selectedPeriod > 30 ? 30 : 7,
              getTitlesWidget: (value, meta) {
                if (value.toInt() == 0 || value.toInt() % 7 != 0) {
                  return const SizedBox();
                }
                return Text(
                  'D${value.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                );
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
        minX: 0,
        maxX: _selectedPeriod.toDouble(),
        minY: 40,
        maxY: 200,
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            // AHA Zone Lines
            // Normal: < 120/80
            HorizontalLine(
              y: 80,
              color: AppColors.success.withOpacity(0.5),
              strokeWidth: 1,
              dashArray: [5, 5],
              label: HorizontalLineLabel(
                show: true,
                labelResolver: (line) => 'Normal',
                style: const TextStyle(fontSize: 10, color: AppColors.success),
              ),
            ),
            // Elevated: 120-129/<80
            HorizontalLine(
              y: 80,
              color: AppColors.warning.withOpacity(0.5),
              strokeWidth: 2,
            ),
            // Stage 1: 130-139/80-89
            HorizontalLine(
              y: 90,
              color: Colors.orange.withOpacity(0.5),
              strokeWidth: 2,
            ),
            // Stage 2: ≥140/90
            HorizontalLine(
              y: 90,
              color: AppColors.error.withOpacity(0.5),
              strokeWidth: 2,
            ),
          ],
        ),
        lineBarsData: [
          // Systolic line
          LineChartBarData(
            spots: _generateSpots(true),
            isCurved: true,
            color: AppColors.error,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.error,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.error.withOpacity(0.1),
            ),
          ),
          // Diastolic line
          LineChartBarData(
            spots: _generateSpots(false),
            isCurved: true,
            color: AppColors.primary,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: AppColors.primary,
                  strokeWidth: 2,
                  strokeColor: Colors.white,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.primary.withOpacity(0.1),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final isSys = spot.barIndex == 0;
                return LineTooltipItem(
                  '${isSys ? 'Sys' : 'Dia'}: ${spot.y.toInt()}',
                  TextStyle(
                    color: isSys ? AppColors.error : AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  List<FlSpot> _generateSpots(bool isSystolic) {
    // Generate sample data - in real app this comes from database
    final spots = <FlSpot>[];
    final now = DateTime.now();

    // Create sample data points
    for (int i = _selectedPeriod - 1; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      // Skip some days to simulate real data
      if (i % 3 != 0 && i % 2 != 0) continue;

      final dayIndex = _selectedPeriod - 1 - i;
      final baseSys = 120 + (i % 20 - 10);
      final baseDia = 75 + (i % 15 - 7);

      if (isSystolic) {
        spots.add(FlSpot(dayIndex.toDouble(), baseSys.toDouble()));
      } else {
        spots.add(FlSpot(dayIndex.toDouble(), baseDia.toDouble()));
      }
    }

    return spots;
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem('Systolic', AppColors.error),
        const SizedBox(width: 24),
        _buildLegendItem('Diastolic', AppColors.primary),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
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
