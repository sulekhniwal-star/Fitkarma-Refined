import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final bpHistoryProvider = FutureProvider.family<List<DecryptedBPLog>, BpHistoryParams>((ref, params) async {
  final db = ref.read(appDatabaseProvider);
  return db.bloodPressureLogsDao.getLogsForUserDecrypted(
    params.userId,
    from: params.from,
    to: params.to,
  );
});

class BpHistoryParams {
  final String userId;
  final DateTime? from;
  final DateTime? to;

  BpHistoryParams({required this.userId, this.from, this.to});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BpHistoryParams &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          from == other.from &&
          to == other.to;

  @override
  int get hashCode => userId.hashCode ^ from.hashCode ^ to.hashCode;
}

enum BpPeriod { week, month, threeMonths }

class BpPeriodNotifier extends Notifier<BpPeriod> {
  @override
  BpPeriod build() => BpPeriod.week;

  void setPeriod(BpPeriod period) => state = period;
}

final bpPeriodProvider = NotifierProvider<BpPeriodNotifier, BpPeriod>(BpPeriodNotifier.new);

class BpHistoryScreen extends ConsumerWidget {
  final String userId;

  const BpHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(bpPeriodProvider);
    final now = DateTime.now();
    late DateTime from;
    switch (period) {
      case BpPeriod.week:
        from = now.subtract(const Duration(days: 7));
        break;
      case BpPeriod.month:
        from = now.subtract(const Duration(days: 30));
        break;
      case BpPeriod.threeMonths:
        from = now.subtract(const Duration(days: 90));
        break;
    }

    final historyAsync = ref.watch(bpHistoryProvider(BpHistoryParams(userId: userId, from: from)));

    return Scaffold(
      appBar: AppBar(
        title: const Text('BP Trends'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/bp/log', extra: userId),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPeriodSelector(context, ref, period),
          Expanded(
            child: historyAsync.when(
              data: (logs) => logs.isEmpty
                  ? const Center(child: Text('No BP logs yet. Tap + to add.'))
                  : _buildChart(logs, period),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
          _buildRecentLogs(context, historyAsync),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(BuildContext context, WidgetRef ref, BpPeriod period) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SegmentedButton<BpPeriod>(
        segments: const [
          ButtonSegment(value: BpPeriod.week, label: Text('7 Days')),
          ButtonSegment(value: BpPeriod.month, label: Text('30 Days')),
          ButtonSegment(value: BpPeriod.threeMonths, label: Text('90 Days')),
        ],
        selected: {period},
        onSelectionChanged: (s) => ref.read(bpPeriodProvider.notifier).setPeriod(s.first),
      ),
    );
  }

  Widget _buildChart(List<DecryptedBPLog> logs, BpPeriod period) {
    final sortedLogs = List<DecryptedBPLog>.from(logs)..sort((a, b) => a.loggedAt.compareTo(b.loggedAt));
    
    final sysSpots = <FlSpot>[];
    final diaSpots = <FlSpot>[];
    
    for (var i = 0; i < sortedLogs.length; i++) {
      final log = sortedLogs[i];
      if (log.sys > 0) sysSpots.add(FlSpot(i.toDouble(), log.sys.toDouble()));
      if (log.dia > 0) diaSpots.add(FlSpot(i.toDouble(), log.dia.toDouble()));
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 20,
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
                interval: 40,
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
          minY: 60,
          maxY: 200,
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 180, color: Colors.red.shade900, strokeWidth: 2, dashArray: [8, 4]),
              HorizontalLine(y: 120, color: Colors.orange.shade700, strokeWidth: 2, dashArray: [8, 4]),
              HorizontalLine(y: 80, color: Colors.yellow.shade700, strokeWidth: 2, dashArray: [8, 4]),
              HorizontalLine(y: 120, color: Colors.green.shade700, strokeWidth: 2, dashArray: [8, 4], label: HorizontalLineLabel(
                show: true,
                labelResolver: (line) => 'Normal',
                style: const TextStyle(fontSize: 10),
              )),
            ],
          ),
          lineBarsData: [
            LineChartBarData(
              spots: sysSpots,
              isCurved: true,
              color: Colors.red.shade600,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: Colors.red.shade100.withValues(alpha: 0.3)),
            ),
            LineChartBarData(
              spots: diaSpots,
              isCurved: true,
              color: Colors.blue.shade600,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true, color: Colors.blue.shade100.withValues(alpha: 0.3)),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final isSys = spot.barIndex == 0;
                  return LineTooltipItem(
                    '${isSys ? "Sys" : "Dia"}: ${spot.y.toInt()}',
                    TextStyle(color: isSys ? Colors.red : Colors.blue, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecentLogs(BuildContext context, AsyncValue<List<DecryptedBPLog>> historyAsync) {
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
                    Row(
                      children: [
                        Text('${log.sys}/${log.dia}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        if (log.pulse != null) Text(' • ${log.pulse}bpm', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
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

  Widget _buildClassificationBadge(BPClassification classification) {
    Color color;
    String label;
    switch (classification) {
      case BPClassification.crisis:
        color = Colors.red;
        label = 'Crisis';
        break;
      case BPClassification.stage2:
        color = Colors.orange;
        label = 'Stage 2';
        break;
      case BPClassification.stage1:
        color = Colors.yellow.shade700;
        label = 'Stage 1';
        break;
      case BPClassification.elevated:
        color = AppColors.primary;
        label = 'Elevated';
        break;
      case BPClassification.normal:
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