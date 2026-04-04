import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class MeasurementsScreen extends ConsumerWidget {
  final String userId;

  const MeasurementsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Body Measurements'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLatestMeasurement(context, db),
            const SizedBox(height: 24),
            _buildTrends(db),
            const SizedBox(height: 24),
            _buildHistory(db),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/measurements/log', extra: userId),
        icon: const Icon(Icons.add),
        label: const Text('Log'),
      ),
    );
  }

  Widget _buildLatestMeasurement(BuildContext context, AppDatabase db) {
    return FutureBuilder(
      future: db.bodyMeasurementsDao.getLatest(userId),
      builder: (context, snapshot) {
        final m = snapshot.data;
        if (m == null) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.straighten, size: 48, color: Colors.grey.shade400),
                  const SizedBox(height: 8),
                  const Text('No measurements yet'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => context.push('/measurements/log', extra: userId),
                    child: const Text('Log Now'),
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Latest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text(_formatDate(m.measuredAt), style: TextStyle(color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 16),
                _metricRow('Weight', '${m.weightKg?.toStringAsFixed(1)} kg'),
                if (m.bmi != null) _metricRow('BMI', m.bmi!.toStringAsFixed(1)),
                if (m.waistToHipRatio != null) _metricRow('Waist/Hip', m.waistToHipRatio!.toStringAsFixed(2)),
                if (m.waistToHeightRatio != null) _metricRow('Waist/Height', m.waistToHeightRatio!.toStringAsFixed(2)),
                if (m.bodyFatPercent != null) _metricRow('Body Fat', '${m.bodyFatPercent!.toStringAsFixed(1)}%'),
                if (m.photoPath != null) ...[
                  const SizedBox(height: 8),
                  const Text('📷 Progress photo stored locally', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _metricRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTrends(AppDatabase db) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Weight Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: FutureBuilder(
            future: db.bodyMeasurementsDao.getTrends(userId, days: 30),
            builder: (context, snapshot) {
              final trends = snapshot.data ?? [];
              if (trends.isEmpty) {
                return Center(child: Text('No data', style: TextStyle(color: Colors.grey.shade400)));
              }
              return LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: trends.asMap().entries.map((e) {
                        return FlSpot(e.key.toDouble(), e.value.weight ?? 0);
                      }).toList(),
                      isCurved: true,
                      color: AppColors.primary,
                      barWidth: 3,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.primary.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHistory(AppDatabase db) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        const SizedBox(height: 8),
        FutureBuilder(
          future: db.bodyMeasurementsDao.getMeasurementsForUser(userId),
          builder: (context, snapshot) {
            final measurements = snapshot.data ?? [];
            if (measurements.isEmpty) {
              return const Text('No history');
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: measurements.length.clamp(0, 10),
              itemBuilder: (context, index) {
                final m = measurements[index];
                return ListTile(
                  dense: true,
                  title: Text(_formatDate(m.measuredAt)),
                  subtitle: Text(
                    [
                      if (m.weightKg != null) '${m.weightKg}kg',
                      if (m.bmi != null) 'BMI ${m.bmi!.toStringAsFixed(1)}',
                    ].join(' | '),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatDate(DateTime d) => '${d.day}/${d.month}/${d.year}';
}