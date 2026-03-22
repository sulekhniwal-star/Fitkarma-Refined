// lib/features/glucose/presentation/glucose_screen.dart
// Glucose Screen - Main screen for blood glucose tracking

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/glucose/data/glucose_service.dart';
import 'package:fitkarma/features/glucose/data/glucose_providers.dart';
import 'package:fitkarma/features/glucose/presentation/glucose_logging_sheet.dart';
import 'package:fitkarma/features/glucose/presentation/glucose_trend_chart.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class GlucoseScreen extends ConsumerStatefulWidget {
  final String userId;

  const GlucoseScreen({super.key, required this.userId});

  @override
  ConsumerState<GlucoseScreen> createState() => _GlucoseScreenState();
}

class _GlucoseScreenState extends ConsumerState<GlucoseScreen> {
  int _selectedDays = 7;
  GlucoseReadingType? _filterType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Glucose'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _showReminderInfo,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quick Log Card
              _buildQuickLogCard(),
              const SizedBox(height: 20),

              // Latest Reading Card
              _buildLatestReadingCard(),
              const SizedBox(height: 20),

              // HbA1c Estimate Card
              _buildHbA1cCard(),
              const SizedBox(height: 20),

              // Statistics Card
              _buildStatisticsCard(),
              const SizedBox(height: 20),

              // Trend Chart
              _buildTrendSection(),
              const SizedBox(height: 20),

              // Guidelines Info
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
        label: const Text('Log Glucose'),
      ),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(latestGlucoseLogProvider);
    ref.invalidate(recentGlucoseLogsProvider);
    ref.invalidate(glucoseStatistics7DaysProvider);
    ref.invalidate(glucoseStatistics30DaysProvider);
    ref.invalidate(hba1cEstimateProvider);
  }

  Widget _buildQuickLogCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              AppColors.primary.withOpacity(0.8),
            ],
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
                  child: const Icon(
                    Icons.water_drop,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Blood Glucose',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Track your blood sugar levels',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildQuickStatItem('Today', _getTodayLogsCount().toString()),
                const SizedBox(width: 24),
                _buildQuickStatItem('This Week', _getWeekLogsCount().toString()),
                const SizedBox(width: 24),
                _buildQuickStatItem('Avg', _getAverageGlucose().toStringAsFixed(0)),
              ],
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
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildLatestReadingCard() {
    final latestLog = ref.watch(latestGlucoseLogProvider);

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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            latestLog.when(
              data: (log) {
                if (log == null || log.glucoseMgdl == null) {
                  return _buildNoDataPlaceholder('No readings yet');
                }

                final readingType = GlucoseReadingTypeExtension.fromDbValue(log.readingType);
                final classification = classifyGlucose(log.glucoseMgdl!, readingType);

                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(classification.colorValue).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${log.glucoseMgdl!.toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(classification.colorValue),
                            ),
                          ),
                          Text(
                            'mg/dL',
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
                              color: Color(classification.colorValue).withOpacity(0.1),
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
                          const SizedBox(height: 4),
                          Text(
                            readingType.displayName,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
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
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHbA1cCard() {
    final hba1cData = ref.watch(hba1cEstimateProvider);

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
                Icon(Icons.analytics_outlined, size: 20, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Estimated HbA1c (90-day)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            hba1cData.when(
              data: (data) {
                if (data.estimatedHbA1c == 0) {
                  return _buildNoDataPlaceholder('Need more data for estimate');
                }

                final hba1c = data.estimatedHbA1c;
                String status;
                Color statusColor;
                
                if (hba1c < 5.7) {
                  status = 'Normal';
                  statusColor = Colors.green;
                } else if (hba1c < 6.5) {
                  status = 'Pre-Diabetes';
                  statusColor = Colors.orange;
                } else {
                  status = 'Diabetes';
                  statusColor = Colors.red;
                }

                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            hba1c.toStringAsFixed(1),
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: statusColor,
                            ),
                          ),
                          Text(
                            '%',
                            style: TextStyle(
                              fontSize: 12,
                              color: statusColor,
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
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              status,
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Avg: ${data.averageGlucose.toStringAsFixed(0)} mg/dL',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            'Based on 90-day average',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    final stats = _selectedDays == 7
        ? ref.watch(glucoseStatistics7DaysProvider)
        : ref.watch(glucoseStatistics30DaysProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.bar_chart, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Statistics',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(value: 7, label: Text('7D')),
                    ButtonSegment(value: 30, label: Text('30D')),
                  ],
                  selected: {_selectedDays},
                  onSelectionChanged: (selection) {
                    setState(() => _selectedDays = selection.first);
                  },
                  style: ButtonStyle(
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            stats.when(
              data: (data) {
                if (data.totalLogs == 0) {
                  return _buildNoDataPlaceholder('No data for this period');
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Average', '${data.averageGlucose.toStringAsFixed(0)} mg/dL'),
                    _buildStatItem('Min', '${data.minGlucose.toStringAsFixed(0)} mg/dL'),
                    _buildStatItem('Max', '${data.maxGlucose.toStringAsFixed(0)} mg/dL'),
                    _buildStatItem('Logs', '${data.totalLogs}'),
                  ],
                );
              },
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildTrendSection() {
    final logs = _selectedDays == 7
        ? ref.watch(recentGlucoseLogsProvider)
        : ref.watch(glucoseLogs30DaysProvider);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.show_chart, size: 20, color: Colors.grey),
                    SizedBox(width: 8),
                    Text(
                      'Trend',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                // Filter by reading type
                DropdownButton<GlucoseReadingType?>(
                  value: _filterType,
                  hint: const Text('All Types'),
                  isDense: true,
                  underline: const SizedBox(),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All Types'),
                    ),
                    ...GlucoseReadingType.values.map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.displayName),
                    )),
                  ],
                  onChanged: (value) {
                    setState(() => _filterType = value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            logs.when(
              data: (logList) => GlucoseTrendChart(
                logs: logList,
                filterType: _filterType,
                days: _selectedDays,
              ),
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (_, __) => _buildNoDataPlaceholder('Error loading data'),
            ),
            const SizedBox(height: 8),
            const Center(child: GlucoseChartLegend()),
          ],
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
                  'ADA Guidelines',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildGuidelineItem('Fasting', '70-100 mg/dL (Normal)', Colors.green),
            _buildGuidelineItem('Post-meal (2h)', '<140 mg/dL (Normal)', Colors.green),
            _buildGuidelineItem('Pre-Diabetes', '100-125 mg/dL (Fasting)', Colors.orange),
            _buildGuidelineItem('Diabetes', '≥126 mg/dL (Fasting)', Colors.red),
            _buildGuidelineItem('Hypoglycemia', '<70 mg/dL', Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildGuidelineItem(String type, String range, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              type,
              style: const TextStyle(fontSize: 13),
            ),
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
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
        style: TextStyle(
          color: Colors.grey[500],
          fontSize: 14,
        ),
      ),
    );
  }

  void _showLoggingSheet() {
    showGlucoseLoggingSheet(context);
  }

  void _showReminderInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Glucose Reminders'),
        content: const Text(
          'Set reminders to log your glucose at different times:\n\n'
          '• Morning fasting\n'
          '• After meals\n'
          '• Before bed\n\n'
          'This helps track your glucose patterns better.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  int _getTodayLogsCount() {
    final logs = ref.watch(recentGlucoseLogsProvider);
    return logs.maybeWhen(
      data: (list) {
        final today = DateTime.now();
        return list.where((l) =>
          l.loggedAt.year == today.year &&
          l.loggedAt.month == today.month &&
          l.loggedAt.day == today.day
        ).length;
      },
      orElse: () => 0,
    );
  }

  int _getWeekLogsCount() {
    final logs = ref.watch(recentGlucoseLogsProvider);
    return logs.maybeWhen(
      data: (list) => list.length,
      orElse: () => 0,
    );
  }

  double _getAverageGlucose() {
    final stats = ref.watch(glucoseStatistics7DaysProvider);
    return stats.maybeWhen(
      data: (data) => data.averageGlucose,
      orElse: () => 0.0,
    );
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
