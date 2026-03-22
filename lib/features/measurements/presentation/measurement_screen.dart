// lib/features/measurements/presentation/measurement_screen.dart
// Main screen for body measurements tracking

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/storage/drift_database.dart';
import 'package:fitkarma/features/measurements/data/measurement_providers.dart';
import 'package:fitkarma/features/measurements/data/measurement_service.dart';
import 'package:fitkarma/features/measurements/presentation/measurement_logging_sheet.dart';
import 'package:fitkarma/features/measurements/presentation/measurement_trend_chart.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class MeasurementScreen extends ConsumerStatefulWidget {
  const MeasurementScreen({super.key});

  @override
  ConsumerState<MeasurementScreen> createState() => _MeasurementScreenState();
}

class _MeasurementScreenState extends ConsumerState<MeasurementScreen> {
  MeasurementMetric _selectedMetric = MeasurementMetric.weight;
  MeasurementTimeRange _selectedTimeRange = MeasurementTimeRange.days30;

  @override
  Widget build(BuildContext context) {
    final latestMeasurement = ref.watch(latestMeasurementProvider);
    final bmiInfo = ref.watch(bmiCalculationProvider);
    final waistHipInfo = ref.watch(waistHipRatioProvider);
    final waistHeightInfo = ref.watch(waistHeightRatioProvider);
    final progressPhotos = ref.watch(progressPhotosProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Measurements'),
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
              // Quick Stats Cards
              _buildQuickStatsSection(bmiInfo, waistHipInfo, waistHeightInfo),
              const SizedBox(height: 24),

              // Latest Measurements Card
              _buildLatestMeasurementCard(latestMeasurement),
              const SizedBox(height: 24),

              // Trend Chart Section
              _buildTrendChartSection(),
              const SizedBox(height: 24),

              // Progress Photos Section
              _buildProgressPhotosSection(progressPhotos),
              const SizedBox(height: 24),

              // Tips Card
              _buildTipsCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showLoggingSheet,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Log Measurement'),
      ),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(latestMeasurementProvider);
    ref.invalidate(bmiCalculationProvider);
    ref.invalidate(waistHipRatioProvider);
    ref.invalidate(waistHeightRatioProvider);
    ref.invalidate(measurements30DaysProvider);
    ref.invalidate(measurements90DaysProvider);
    ref.invalidate(measurements180DaysProvider);
    ref.invalidate(progressPhotosProvider);
  }

  void _showLoggingSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const MeasurementLoggingSheet(),
    );
  }

  Widget _buildQuickStatsSection(
    AsyncValue<BmiCategoryInfo> bmiInfo,
    AsyncValue<WaistHipRatioRiskInfo> waistHipInfo,
    AsyncValue<WaistHeightRatioRiskInfo> waistHeightInfo,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Health Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                title: 'BMI',
                valueWidget: bmiInfo.when(
                  data: (info) => Column(
                    children: [
                      Text(
                        info.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(info.colorValue),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.description,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  loading: () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text('N/A'),
                ),
                icon: Icons.monitor_weight_outlined,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Waist-to-Hip',
                valueWidget: waistHipInfo.when(
                  data: (info) => Column(
                    children: [
                      Text(
                        info.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(info.colorValue),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.description,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  loading: () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text('N/A'),
                ),
                icon: Icons.straighten,
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildMetricCard(
                title: 'Waist-to-Height',
                valueWidget: waistHeightInfo.when(
                  data: (info) => Column(
                    children: [
                      Text(
                        info.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(info.colorValue),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        info.description,
                        style: const TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  loading: () => const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (_, __) => const Text('N/A'),
                ),
                icon: Icons.height,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required Widget valueWidget,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4),
            valueWidget,
          ],
        ),
      ),
    );
  }

  Widget _buildLatestMeasurementCard(AsyncValue<dynamic> latestMeasurement) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Latest Measurements',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                latestMeasurement.when(
                  data: (m) => m != null
                      ? Text(
                          _formatDate(m.measuredAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        )
                      : const SizedBox(),
                  loading: () => const SizedBox(),
                  error: (_, __) => const SizedBox(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            latestMeasurement.when(
              data: (m) {
                if (m == null) {
                  return const Center(
                    child: Text(
                      'No measurements yet.\nTap the button below to log your first measurement.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }
                return Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  children: [
                    if (m.weightKg != null)
                      _buildMeasurementItem(
                        'Weight',
                        '${m.weightKg!.toStringAsFixed(1)} kg',
                      ),
                    if (m.heightCm != null)
                      _buildMeasurementItem(
                        'Height',
                        '${m.heightCm!.toStringAsFixed(1)} cm',
                      ),
                    if (m.bodyFatPercentage != null)
                      _buildMeasurementItem(
                        'Body Fat',
                        '${m.bodyFatPercentage!.toStringAsFixed(1)}%',
                      ),
                    if (m.waistCm != null)
                      _buildMeasurementItem(
                        'Waist',
                        '${m.waistCm!.toStringAsFixed(1)} cm',
                      ),
                    if (m.hipCm != null)
                      _buildMeasurementItem(
                        'Hip',
                        '${m.hipCm!.toStringAsFixed(1)} cm',
                      ),
                    if (m.chestCm != null)
                      _buildMeasurementItem(
                        'Chest',
                        '${m.chestCm!.toStringAsFixed(1)} cm',
                      ),
                    if (m.armsCm != null)
                      _buildMeasurementItem(
                        'Arms',
                        '${m.armsCm!.toStringAsFixed(1)} cm',
                      ),
                    if (m.thighsCm != null)
                      _buildMeasurementItem(
                        'Thighs',
                        '${m.thighsCm!.toStringAsFixed(1)} cm',
                      ),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeasurementItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTrendChartSection() {
    final measurementsAsync = _getMeasurementsForTimeRange();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Trend Chart',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Time range selector
            Row(
              children: [
                _buildTimeRangeChip('30 Days', MeasurementTimeRange.days30),
                const SizedBox(width: 8),
                _buildTimeRangeChip('90 Days', MeasurementTimeRange.days90),
                const SizedBox(width: 8),
                _buildTimeRangeChip('180 Days', MeasurementTimeRange.days180),
              ],
            ),
            const SizedBox(height: 12),

            // Metric selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: MeasurementMetric.values
                    .map((m) => _buildMetricChip(m))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Chart
            measurementsAsync.when(
              data: (measurements) => MeasurementTrendChart(
                measurements: measurements,
                metric: _selectedMetric,
                days: _getDaysForTimeRange(),
              ),
              loading: () => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 200,
                child: Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeRangeChip(String label, MeasurementTimeRange value) {
    final isSelected = _selectedTimeRange == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() => _selectedTimeRange = value);
        }
      },
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.primary : Colors.grey[600],
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildMetricChip(MeasurementMetric metric) {
    final isSelected = _selectedMetric == metric;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(metric.displayName),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            setState(() => _selectedMetric = metric);
          }
        },
        selectedColor: metric.color.withValues(alpha: 0.2),
        labelStyle: TextStyle(
          color: isSelected ? metric.color : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 12,
        ),
      ),
    );
  }

  AsyncValue<List<BodyMeasurement>> _getMeasurementsForTimeRange() {
    switch (_selectedTimeRange) {
      case MeasurementTimeRange.days30:
        return ref.watch(measurements30DaysProvider);
      case MeasurementTimeRange.days90:
        return ref.watch(measurements90DaysProvider);
      case MeasurementTimeRange.days180:
        return ref.watch(measurements180DaysProvider);
    }
  }

  int _getDaysForTimeRange() {
    switch (_selectedTimeRange) {
      case MeasurementTimeRange.days30:
        return 30;
      case MeasurementTimeRange.days90:
        return 90;
      case MeasurementTimeRange.days180:
        return 180;
    }
  }

  Widget _buildProgressPhotosSection(AsyncValue<List<String>> photosAsync) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Progress Photos',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(Icons.lock, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      'Local only',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            photosAsync.when(
              data: (photos) {
                if (photos.isEmpty) {
                  return Container(
                    height: 150,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_library_outlined,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No progress photos yet',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Add a photo when logging measurements',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photos.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(photos[index]),
                            width: 120,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
              loading: () => const SizedBox(
                height: 150,
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SizedBox(
                height: 150,
                child: Center(child: Text('Error: $e')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      elevation: 2,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Measure yourself at the same time each day for consistent results. Best time is in the morning before eating.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
