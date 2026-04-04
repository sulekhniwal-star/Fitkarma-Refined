import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final glucoseHistoryProvider = FutureProvider.family<List<DecryptedGlucoseLog>, GlucoseHistoryParams>((ref, params) async {
  final db = ref.read(appDatabaseProvider);
  return db.glucoseLogsDao.getLogsForUserDecrypted(
    params.userId,
    from: params.from,
    to: params.to,
  );
});

class GlucoseHistoryParams {
  final String userId;
  final DateTime? from;
  final DateTime? to;

  GlucoseHistoryParams({required this.userId, this.from, this.to});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GlucoseHistoryParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => userId.hashCode ^ from.hashCode ^ to.hashCode;
}

enum GlucosePeriod { week, month, threeMonths }

class GlucosePeriodNotifier extends Notifier<GlucosePeriod> {
  @override
  GlucosePeriod build() => GlucosePeriod.week;

  void setPeriod(GlucosePeriod period) => state = period;
}

final glucosePeriodProvider = NotifierProvider<GlucosePeriodNotifier, GlucosePeriod>(GlucosePeriodNotifier.new);

class GlucoseHistoryScreen extends ConsumerWidget {
  final String userId;

  const GlucoseHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(glucosePeriodProvider);
    final now = DateTime.now();
    late DateTime from;
    switch (period) {
      case GlucosePeriod.week:
        from = now.subtract(const Duration(days: 7));
        break;
      case GlucosePeriod.month:
        from = now.subtract(const Duration(days: 30));
        break;
      case GlucosePeriod.threeMonths:
        from = now.subtract(const Duration(days: 90));
        break;
    }

    final historyAsync = ref.watch(glucoseHistoryProvider(GlucoseHistoryParams(userId: userId, from: from)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Trends'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/glucose/log', extra: userId),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPeriodSelector(context, ref, period),
          Expanded(
            child: historyAsync.when(
              data: (logs) => logs.isEmpty
                  ? const Center(child: Text('No glucose logs yet. Tap + to add.'))
                  : _buildChart(logs),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          _buildRecentLogs(historyAsync),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, WidgetRef ref, GlucosePeriod period) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SegmentedButton<GlucosePeriod>(
        segments: const [
          ButtonSegment(value: GlucosePeriod.week, label: Text('7 Days')),
          ButtonSegment(value: GlucosePeriod.month, label: Text('30 Days')),
          ButtonSegment(value: GlucosePeriod.threeMonths, label: Text('90 Days')),
        ],
        selected: {period},
        onSelectionChanged: (s) => ref.read(glucosePeriodProvider.notifier).setPeriod(s.first),
      ),
    );
  }

  Widget _buildChart(List<DecryptedGlucoseLog> logs) {
    final sortedLogs = List<DecryptedGlucoseLog>.from(logs)..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));
    
    final spots = <FlSpot>[];
    
    for (var i = 0; i < sortedLogs.length; i++) {
      final log = sortedLogs[i];
      if (log.glucose > 0) {
        spots.add(FlSpot(i.toDouble(), log.glucose.toDouble()));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 50,
            getDrawingHorizontalLine: (value) => FlLine(
              color: Colors.grey.shade300,
              strokeWidth: 1,
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 50,
                getTitlesWidget: (value, meta) => Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ),
            bottomTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minY: 40,
          maxY: 250,
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 70, color: Colors.blue.shade400, strokeWidth: 2, dashArray: [8, 4]),
              HorizontalLine(y: 100, color: Colors.green.shade600, strokeWidth: 2, dashArray: [8, 4], label: HorizontalLineLabel(
                show: true,
                labelResolver: (line) => 'Normal',
                style: const TextStyle(fontSize: 10),
              )),
              HorizontalLine(y: 140, color: Colors.yellow.shade600, strokeWidth: 2, dashArray: [8, 4]),
              HorizontalLine(y: 200, color: Colors.red.shade700, strokeWidth: 2, dashArray: [8, 4]),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppColors.secondary,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: AppColors.secondary.withValues(alpha: 0.2)),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '${spot.y.toInt()} mg/dL',
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentLogs(AsyncValue<List<DecryptedGlucoseLog>> historyAsync) {
    return historyAsync.when(
      data: (logs) {
        final recent = logs.take(5).toList();
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.lightSurface,
            border: Border(top: BorderSide(color: Colors.grey.shade200)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Recent Readings', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              ...recent.map((log) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${log.loggedAt.day}/${log.loggedAt.month}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      log.mealType ?? 'random',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text('${log.glucoseMgdl} mg/dL', style: const TextStyle(fontWeight: FontWeight.bold)),
                    _buildClassificationBadge(log.classification),
                  ],
                ),
              )),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }

  Widget _buildClassificationBadge(GlucoseClassification classification) {
    Color color;
    String label;
    switch (classification) {
      case GlucoseClassification.low:
        color = Colors.blue;
        label = 'Low';
        break;
      case GlucoseClassification.normal:
        color = Colors.green;
        label = 'Normal';
        break;
      case GlucoseClassification.prediabetes:
        color = Colors.yellow.shade700;
        label = 'Pre-DM';
        break;
      case GlucoseClassification.diabetes:
        color = Colors.red;
        label = 'DM';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label, style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());