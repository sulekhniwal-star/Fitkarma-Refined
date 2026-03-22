// lib/features/spo2/presentation/spo2_screen.dart
// SpO2 Screen - Main screen for blood oxygen tracking

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/spo2/data/spo2_service.dart';
import 'package:fitkarma/features/spo2/data/spo2_providers.dart';
import 'package:fitkarma/features/spo2/presentation/spo2_logging_sheet.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class SpO2Screen extends ConsumerStatefulWidget {
  final String userId;

  const SpO2Screen({super.key, required this.userId});

  @override
  ConsumerState<SpO2Screen> createState() => _SpO2ScreenState();
}

class _SpO2ScreenState extends ConsumerState<SpO2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Oxygen'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Stats Card
              _buildQuickStatsCard(),
              const SizedBox(height: 20),

              // Latest Reading Card
              _buildLatestReadingCard(),
              const SizedBox(height: 20),

              // Trend Chart
              _buildTrendChart(),
              const SizedBox(height: 20),

              // Guidelines Card
              _buildGuidelinesCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLoggingSheet,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Log SpO2'),
      ),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(latestSpo2LogProvider);
    ref.invalidate(recentSpo2LogsProvider);
    ref.invalidate(spo2Statistics30DaysProvider);
  }

  Widget _buildQuickStatsCard() {
    final stats = ref.watch(spo2Statistics30DaysProvider);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blue.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.air, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blood Oxygen (SpO2)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Track your oxygen saturation',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            stats.when(
              data: (data) => Row(
                children: [
                  _buildQuickStatItem(
                    'Avg',
                    '${data.averageSpO2.toStringAsFixed(0)}%',
                  ),
                  const SizedBox(width: 24),
                  _buildQuickStatItem(
                    'Min',
                    '${data.minSpO2.toStringAsFixed(0)}%',
                  ),
                  const SizedBox(width: 24),
                  _buildQuickStatItem('Logs', '${data.totalLogs}'),
                ],
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              error: (_, __) => const Text(
                'Error loading data',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildLatestReadingCard() {
    final latestLog = ref.watch(latestSpo2LogProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.access_time, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Latest Reading',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            latestLog.when(
              data: (log) {
                if (log == null || log.spo2Percentage == null) {
                  return _buildNoDataPlaceholder('No readings yet');
                }

                final classification = classifySpO2(log.spo2Percentage!);
                final isAlert = isSpO2Alert(log.spo2Percentage!);

                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Color(
                              classification.colorValue,
                            ).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${log.spo2Percentage!.toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(classification.colorValue),
                                ),
                              ),
                              Text(
                                '%',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color(classification.colorValue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(
                                    classification.colorValue,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  classification.displayName,
                                  style: TextStyle(
                                    color: Color(classification.colorValue),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              if (log.pulseRate != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Pulse: ${log.pulseRate} BPM',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              Text(
                                _formatDateTime(log.loggedAt),
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Alert when SpO2 < 95%
                    if (isAlert) ...[
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.warning_amber,
                              color: Colors.orange,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Please consult your doctor',
                                style: TextStyle(
                                  color: Colors.orange[800],
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendChart() {
    final logs = ref.watch(recentSpo2LogsProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.show_chart, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  '30-Day Trend',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            logs.when(
              data: (logList) => _buildChart(logList),
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(List<Spo2Log> logs) {
    if (logs.isEmpty) {
      return _buildNoDataPlaceholder('No data yet');
    }

    final sortedLogs = List<Spo2Log>.from(logs)
      ..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));

    final spots = <FlSpot>[];
    for (var i = 0; i < sortedLogs.length; i++) {
      final log = sortedLogs[i];
      if (log.spo2Percentage != null) {
        spots.add(FlSpot(i.toDouble(), log.spo2Percentage!));
      }
    }

    if (spots.isEmpty) {
      return _buildNoDataPlaceholder('No SpO2 data');
    }

    final minY = (spots.map((s) => s.y).reduce((a, b) => a < b ? a : b) - 5)
        .clamp(80.0, 100.0);
    final maxY = 100.0;

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 16),
        child: LineChart(
          LineChartData(
            minY: minY,
            maxY: maxY,
            gridData: FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 5,
              getDrawingHorizontalLine: (value) {
                Color lineColor = Colors.grey[200]!;
                double lineWidth = 1;

                // Highlight 95% threshold
                if (value == 95) {
                  lineColor = Colors.orange.withOpacity(0.5);
                  lineWidth = 2;
                }

                return FlLine(color: lineColor, strokeWidth: lineWidth);
              },
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 35,
                  interval: 5,
                  getTitlesWidget: (value, meta) {
                    return Text(
                      '${value.toInt()}%',
                      style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    );
                  },
                ),
              ),
              bottomTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
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
              LineChartBarData(
                spots: spots,
                isCurved: true,
                curveSmoothness: 0.3,
                color: Colors.blue,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) {
                    final classification = classifySpO2(spot.y);
                    return FlDotCirclePainter(
                      radius: 4,
                      color: Color(classification.colorValue),
                      strokeWidth: 1,
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
                      Colors.blue.withOpacity(0.3),
                      Colors.blue.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ],
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                // 95% threshold line
                HorizontalLine(
                  y: 95,
                  color: Colors.orange.withOpacity(0.7),
                  strokeWidth: 2,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    alignment: Alignment.topRight,
                    style: TextStyle(
                      color: Colors.orange.withOpacity(0.8),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                    labelResolver: (line) => '95%',
                  ),
                ),
              ],
            ),
            lineTouchData: LineTouchData(
              enabled: true,
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    return LineTooltipItem(
                      '${spot.y.toStringAsFixed(0)}%',
                      const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGuidelinesCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.info_outline, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Understanding SpO2',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildGuidelineItem(
              '95-100%',
              'Normal - Healthy range',
              Colors.green,
            ),
            _buildGuidelineItem(
              '90-94%',
              'Low - Consult a doctor',
              Colors.orange,
            ),
            _buildGuidelineItem(
              '<90%',
              'Critical - Seek immediate care',
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String range, String description, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              range,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildNoDataPlaceholder(String message) {
    return Container(
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: Text(
        message,
        style: TextStyle(color: Colors.grey[500], fontSize: 14),
      ),
    );
  }

  void _showLoggingSheet() {
    showSpO2LoggingSheet(context);
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else if (diff.inDays < 7) {
      return '${diff.inDays}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }
}
