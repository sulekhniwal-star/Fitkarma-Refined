import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final spo2HistoryProvider = FutureProvider.family<List<DecryptedSpo2Log>, Spo2HistoryParams>((ref, params) async {
  final db = ref.read(appDatabaseProvider);
  return db.spo2LogsDao.getLogsForUserDecrypted(
    params.userId,
    from: params.from,
    to: params.to,
  );
});

class Spo2HistoryParams {
  final String userId;
  final DateTime? from;
  final DateTime? to;

  Spo2HistoryParams({required this.userId, this.from, this.to});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Spo2HistoryParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => userId.hashCode ^ from.hashCode ^ to.hashCode;
}

class Spo2HistoryScreen extends ConsumerWidget {
  final String userId;

  const Spo2HistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
    final historyAsync = ref.watch(spo2HistoryProvider(Spo2HistoryParams(userId: userId, from: thirtyDaysAgo)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('SpO2 Trends'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/spo2/log', extra: userId),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: historyAsync.when(
              data: (logs) => logs.isEmpty
                  ? const Center(child: Text('No SpO2 logs yet. Tap + to add.'))
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

  Widget _buildChart(List<DecryptedSpo2Log> logs) {
    final sortedLogs = List<DecryptedSpo2Log>.from(logs)..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));
    
    final spots = <FlSpot>[];
    
    for (var i = 0; i < sortedLogs.length; i++) {
      final log = sortedLogs[i];
      if (log.spo2 > 0) {
        spots.add(FlSpot(i.toDouble(), log.spo2.toDouble()));
      }
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
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
                interval: 5,
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
          minY: 80,
          maxY: 105,
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 95, color: Colors.red.shade400, strokeWidth: 2, dashArray: [8, 4], label: HorizontalLineLabel(
                show: true,
                labelResolver: (line) => 'Low (95%)',
                style: const TextStyle(fontSize: 10, color: Colors.red),
              )),
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
                    '${spot.y.toInt()}%',
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

  Widget _buildRecentLogs(AsyncValue<List<DecryptedSpo2Log>> historyAsync) {
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
                    Text('${log.spo2Percentage}%', style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (log.pulse != null) Text('${log.pulse}bpm', style: const TextStyle(color: Colors.grey)),
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

  Widget _buildClassificationBadge(Spo2Classification classification) {
    Color color;
    String label;
    switch (classification) {
      case Spo2Classification.critical:
        color = Colors.red;
        label = 'Critical';
        break;
      case Spo2Classification.low:
        color = Colors.orange;
        label = 'Low';
        break;
      case Spo2Classification.normal:
        color = Colors.green;
        label = 'Normal';
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