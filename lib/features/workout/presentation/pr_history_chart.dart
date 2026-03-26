// lib/features/workout/presentation/pr_history_chart.dart
// Chart widget to display PR history for an exercise

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

/// Widget to display PR history chart for an exercise
class PRHistoryChart extends StatelessWidget {
  final List<PRHistoryData> prHistory;
  final String exerciseName;
  final String unit;
  final bool isTimeBased; // For 5K time (lower is better)

  const PRHistoryChart({
    super.key,
    required this.prHistory,
    required this.exerciseName,
    required this.unit,
    this.isTimeBased = false,
  });

  @override
  Widget build(BuildContext context) {
    if (prHistory.isEmpty) {
      return _buildEmptyState();
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.emoji_events,
                  color: Colors.amber.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  '$exerciseName PR History',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            // Current PR
            _buildCurrentPR(),
            const SizedBox(height: 16),
            
            // Chart
            SizedBox(
              height: 200,
              child: _buildChart(),
            ),
            
            // Legend
            const SizedBox(height: 8),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.emoji_events_outlined,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 12),
            Text(
              'No PRs yet for $exerciseName',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Complete a workout to set your first record!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentPR() {
    final latestPR = prHistory.first;
    final dateFormat = DateFormat('MMM d, yyyy');
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current PR',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                _formatValue(latestPR.value),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Achieved',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                dateFormat.format(latestPR.date),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChart() {
    if (prHistory.length < 2) {
      return Center(
        child: Text(
          'Need at least 2 PRs to show chart',
          style: TextStyle(color: Colors.grey.shade500),
        ),
      );
    }

    // Sort by date ascending for chart
    final sortedHistory = List<PRHistoryData>.from(prHistory)
      ..sort((a, b) => a.date.compareTo(b.date));

    final spots = <FlSpot>[];
    for (int i = 0; i < sortedHistory.length; i++) {
      // For time-based (5K), invert so chart shows improvement going up
      final value = isTimeBased 
          ? -sortedHistory[i].value 
          : sortedHistory[i].value;
      spots.add(FlSpot(i.toDouble(), value));
    }

    final minY = spots.map((s) => s.y).reduce((a, b) => a < b ? a : b);
    final maxY = spots.map((s) => s.y).reduce((a, b) => a > b ? a : b);
    final range = maxY - minY;
    final padding = range * 0.1;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: range > 0 ? range / 4 : 1,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey.shade200,
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: (value, meta) {
                final displayValue = isTimeBased ? -value : value;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Text(
                    _formatValue(displayValue),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index >= 0 && index < sortedHistory.length) {
                  final dateFormat = DateFormat('M/d');
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      dateFormat.format(sortedHistory[index].date),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  );
                }
                return const SizedBox();
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
        maxX: (sortedHistory.length - 1).toDouble(),
        minY: minY - padding,
        maxY: maxY + padding,
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: Colors.amber.shade700,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 5,
                  color: Colors.white,
                  strokeWidth: 2,
                  strokeColor: Colors.amber.shade700,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.amber.shade100.withOpacity(0.3),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((spot) {
                final index = spot.x.toInt();
                if (index >= 0 && index < sortedHistory.length) {
                  final pr = sortedHistory[index];
                  final dateFormat = DateFormat('MMM d');
                  return LineTooltipItem(
                    '${_formatValue(pr.value)} $unit\n${dateFormat.format(pr.date)}',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return null;
              }).toList();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isTimeBased ? Icons.timer : Icons.fitness_center,
          size: 16,
          color: Colors.grey.shade600,
        ),
        const SizedBox(width: 4),
        Text(
          isTimeBased ? 'Lower is better' : 'Higher is better',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  String _formatValue(double value) {
    if (isTimeBased) {
      // Format as mm:ss
      final minutes = value ~/ 60;
      final seconds = (value % 60).round();
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
    return value.toStringAsFixed(1);
  }
}

/// Data model for PR history
class PRHistoryData {
  final DateTime date;
  final double value;
  final String? previousValue;

  PRHistoryData({
    required this.date,
    required this.value,
    this.previousValue,
  });

  factory PRHistoryData.fromMap(Map<String, dynamic> map) {
    return PRHistoryData(
      date: DateTime.parse(map['achievedAt'] as String),
      value: (map['value'] as num).toDouble(),
      previousValue: map['previousValue']?.toString(),
    );
  }
}

/// Widget to display list of PRs with their dates
class PRHistoryList extends StatelessWidget {
  final List<PRHistoryData> prHistory;
  final String exerciseName;
  final String unit;
  final bool isTimeBased;

  const PRHistoryList({
    super.key,
    required this.prHistory,
    required this.exerciseName,
    required this.unit,
    this.isTimeBased = false,
  });

  @override
  Widget build(BuildContext context) {
    if (prHistory.isEmpty) {
      return const SizedBox.shrink();
    }

    final sortedHistory = List<PRHistoryData>.from(prHistory)
      ..sort((a, b) => b.date.compareTo(a.date));

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  color: Colors.grey.shade700,
                ),
                const SizedBox(width: 8),
                Text(
                  'All $exerciseName PRs',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortedHistory.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final pr = sortedHistory[index];
                final isLatest = index == 0;
                
                return ListTile(
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLatest 
                          ? Colors.amber.shade100 
                          : Colors.grey.shade100,
                    ),
                    child: Center(
                      child: isLatest
                          ? Icon(
                              Icons.emoji_events,
                              color: Colors.amber.shade700,
                              size: 20,
                            )
                          : Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade600,
                              ),
                            ),
                    ),
                  ),
                  title: Text(
                    _formatValue(pr.value),
                    style: TextStyle(
                      fontWeight: isLatest ? FontWeight.bold : FontWeight.normal,
                      color: isLatest ? Colors.amber.shade900 : null,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('MMMM d, yyyy').format(pr.date),
                  ),
                  trailing: isLatest
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.shade100,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'PR',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        )
                      : null,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatValue(double value) {
    if (isTimeBased) {
      final minutes = value ~/ 60;
      final seconds = (value % 60).round();
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
    return '${value.toStringAsFixed(1)} $unit';
  }
}
