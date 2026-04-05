import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/theme/app_colors.dart';
import '../../../shared/widgets/bilingual_text.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/data/auth_repository.dart';
import '../data/health_service.dart';

class StepsScreen extends ConsumerStatefulWidget {
  const StepsScreen({super.key});

  @override
  ConsumerState<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends ConsumerState<StepsScreen> {
  bool _isSyncing = false;

  void _sync() async {
    setState(() => _isSyncing = true);
    final user = await ref.read(currentUserProvider.future);
    if (user != null) {
      final success = await ref.read(healthServiceProvider).requestPermissions();
      if (success) {
        await ref.read(healthServiceProvider).syncTodaySteps(user.$id);
      }
    }
    setState(() => _isSyncing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BilingualText(
          english: "Step Tracker",
          hindi: "कदम गणक",
          englishStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: _isSyncing ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.refresh),
            onPressed: _isSyncing ? null : _sync,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildCurrentStepsCard(),
            const SizedBox(height: 24),
            _buildWeeklyChart(),
            const SizedBox(height: 24),
            _buildInsights(),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentStepsCard() {
    // We would normally watch the dashboard data or separate step provider
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.secondary, AppColors.secondary.withOpacity(0.7)]),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: AppColors.secondary.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        children: [
          const Icon(Icons.directions_walk, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          const Text("Today's Steps", style: TextStyle(color: Colors.white70)),
          const Text("6,432", style: TextStyle(color: Colors.white, fontSize: 42, fontWeight: FontWeight.bold)),
          const Text("Goal: 10,000", style: TextStyle(color: Colors.white60)),
          const SizedBox(height: 20),
          LinearProgressIndicator(
            value: 0.643,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("This Week", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              barGroups: _generateWeeklyData(),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
                      return Text(days[value.toInt()], style: const TextStyle(fontSize: 12, color: Colors.grey));
                    },
                  ),
                ),
              ),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateWeeklyData() {
    return List.generate(7, (i) {
      final values = [5000, 8000, 7500, 9200, 6400, 11000, 7000];
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: values[i].toDouble(),
            color: i == 4 ? AppColors.secondary : Colors.grey[200],
            width: 16,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  Widget _buildInsights() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(24),
      ),
      child: const Row(
        children: [
          Icon(Icons.tips_and_updates, color: Colors.amber),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              "You're 3,568 steps away from your daily goal! A 20-minute walk could help you finish it.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
