import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:fitkarma/core/storage/app_database.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

final sleepDataProvider = FutureProvider.family<SleepScreenData, String>((ref, userId) async {
  final db = ref.read(appDatabaseProvider);
  final debt = await db.sleepLogsDao.calculateSleepDebt(userId);
  final weekly = await db.sleepLogsDao.getWeeklyData(userId);
  final chronotype = await db.sleepLogsDao.detectChronotype(userId);
  
  return SleepScreenData(
    debt: debt,
    weeklyData: weekly,
    chronotype: chronotype,
  );
});

class SleepScreenData {
  final SleepDebtData debt;
  final List<WeeklySleepData> weeklyData;
  final ChronotypeData chronotype;

  SleepScreenData({
    required this.debt,
    required this.weeklyData,
    required this.chronotype,
  });
}

final appDatabaseProvider = Provider<AppDatabase>((ref) => AppDatabase());

class SleepHistoryScreen extends ConsumerWidget {
  final String userId;

  const SleepHistoryScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsync = ref.watch(sleepDataProvider(userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sleep'),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () => context.push('/sleep/log', extra: userId)),
        ],
      ),
      body: dataAsync.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, SleepScreenData data) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildSleepDebtBanner(data.debt),
          _buildChronotypeCard(data.chronotype),
          _buildWeeklyChart(data.weeklyData),
          _buildRecentLogs(context, userId),
        ],
      ),
    );
  }

  Widget _buildSleepDebtBanner(SleepDebtData debt) {
    final hasDebt = debt.debtMin > 0;
    final bgColor = hasDebt ? Colors.orange.shade700 : Colors.green.shade700;
    
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(hasDebt ? Icons.bedtime : Icons.check_circle, color: Colors.white, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hasDebt ? 'Sleep Debt' : 'Sleep Target Met!',
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  debt.displayString,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChronotypeCard(ChronotypeData chronotype) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.schedule, color: AppColors.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Chronotype', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  '${chronotype.displayName} (${(chronotype.confidence * 100).toInt()}% confidence)',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(List<WeeklySleepData> weeklyData) {
    final maxValue = weeklyData.map((d) => d.durationMin).reduce((a, b) => a > b ? a : b);
    final adjustedMax = (maxValue / 60).ceil() + 1;
    
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: adjustedMax * 60.0,
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                final data = weeklyData[group.x];
                return BarTooltipItem('${data.hours}h ${data.minutes}m', const TextStyle(color: Colors.white));
              },
            ),
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) => Text('${value.toInt() ~/ 60}h', style: const TextStyle(fontSize: 10)),
                interval: 120,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                  final idx = value.toInt();
                  if (idx >= 0 && idx < weeklyData.length) {
                    final dayName = days[weeklyData[idx].date.weekday - 1];
                    return Text(dayName, style: const TextStyle(fontSize: 10));
                  }
                  return const Text('');
                },
              ),
            ),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: 120,
            getDrawingHorizontalLine: (value) => FlLine(color: Colors.grey.shade300, strokeWidth: 1),
          ),
          borderData: FlBorderData(show: false),
          barGroups: List.generate(7, (i) {
            final data = i < weeklyData.length ? weeklyData[i] : WeeklySleepData(date: DateTime.now(), durationMin: 0, targetMet: false);
            final color = data.targetMet ? Colors.green : Colors.orange;
            return BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  toY: data.durationMin.toDouble(),
                  color: color,
                  width: 20,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                ),
              ],
            );
          }),
          extraLinesData: ExtraLinesData(
            horizontalLines: [
              HorizontalLine(y: 480, color: Colors.red.shade400, strokeWidth: 2, dashArray: [8, 4]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecentLogs(BuildContext context, String userId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightSurface,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Sleep', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 8),
          Text('Sleep logs will appear here', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}