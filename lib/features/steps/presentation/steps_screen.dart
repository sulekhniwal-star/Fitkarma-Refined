// lib/features/steps/presentation/steps_screen.dart
// Steps screen showing today's count, goal ring, and weekly bar chart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fitkarma/features/steps/data/step_providers.dart';
import 'package:fitkarma/features/steps/data/inactivity_service.dart';

class StepsScreen extends ConsumerStatefulWidget {
  const StepsScreen({super.key});

  @override
  ConsumerState<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends ConsumerState<StepsScreen>
    with WidgetsBindingObserver {
  final InactivityService _inactivityService = InactivityService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Start inactivity monitoring
    _inactivityService.startMonitoring(
      onInactivityDetected: _showInactivityReminder,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityService.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh steps when returning to the app
      ref.refresh(todayStepsProvider);
      ref.refresh(weeklyStepsProvider);
      ref.refresh(dailyGoalProvider);
      _inactivityService.recordActivity();
    }
  }

  void _showInactivityReminder() {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.directions_walk, color: Colors.white),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                'Time to move! You\'ve been inactive for over an hour.',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.orange,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'OK',
          textColor: Colors.white,
          onPressed: () {
            _inactivityService.recordActivity();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todayStepsAsync = ref.watch(todayStepsProvider);
    final dailyGoalAsync = ref.watch(dailyGoalProvider);
    final weeklyDataAsync = ref.watch(weeklyStepsProvider);
    final xpEarned = ref.watch(xpEarnedTodayProvider);
    final isUsingPedometer = ref.watch(isUsingPedometerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps'),
        actions: [
          if (isUsingPedometer)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Tooltip(
                message: 'Using device pedometer',
                child: Icon(Icons.directions_walk, size: 20),
              ),
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(todayStepsProvider);
          ref.refresh(weeklyStepsProvider);
          ref.refresh(dailyGoalProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // XP Badge
              _buildXPBadge(xpEarned),
              const SizedBox(height: 24),

              // Goal Ring
              todayStepsAsync.when(
                data: (todaySteps) => dailyGoalAsync.when(
                  data: (dailyGoal) => _buildGoalRing(todaySteps, dailyGoal),
                  loading: () => const CircularProgressIndicator(),
                  error: (_, __) => _buildGoalRing(todaySteps, 10000),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, __) => _buildGoalRing(0, 10000),
              ),
              const SizedBox(height: 32),

              // Stats Row
              todayStepsAsync.when(
                data: (todaySteps) => dailyGoalAsync.when(
                  data: (dailyGoal) => _buildStatsRow(todaySteps, dailyGoal),
                  loading: () => const SizedBox(),
                  error: (_, __) => _buildStatsRow(todaySteps, 10000),
                ),
                loading: () => const SizedBox(),
                error: (_, __) => _buildStatsRow(0, 10000),
              ),
              const SizedBox(height: 32),

              // Weekly Bar Chart
              const Text(
                'Weekly Progress',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              weeklyDataAsync.when(
                data: (weeklyData) => _buildWeeklyChart(weeklyData),
                loading: () => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox(
                  height: 200,
                  child: Center(child: Text('Error loading weekly data')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildXPBadge(double xp) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Colors.amber, Colors.orange]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 20),
          const SizedBox(width: 8),
          Text(
            '+${xp.toStringAsFixed(0)} XP today',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRing(int steps, int goal) {
    final progress = goal > 0 ? (steps / goal).clamp(0.0, 1.0) : 0.0;
    final isGoalMet = steps >= goal;

    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background ring
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 1,
                strokeWidth: 12,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation(Colors.grey.shade200),
              ),
            ),
            // Progress ring
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(
                  isGoalMet ? Colors.green : Colors.blue,
                ),
                strokeCap: StrokeCap.round,
              ),
            ),
            // Center text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$steps',
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'of $goal steps',
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
                if (isGoalMet) ...[
                  const SizedBox(height: 4),
                  const Icon(Icons.check_circle, color: Colors.green, size: 24),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsRow(int steps, int goal) {
    final remaining = goal - steps;
    final distanceKm = (steps * 0.762) / 1000;
    final calories = steps * 0.04; // Approximate calories per step

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          icon: Icons.flag_outlined,
          value: remaining > 0 ? '$remaining' : '0',
          label: 'Remaining',
        ),
        _buildStatItem(
          icon: Icons.straighten,
          value: '${distanceKm.toStringAsFixed(1)} km',
          label: 'Distance',
        ),
        _buildStatItem(
          icon: Icons.local_fire_department,
          value: '${calories.toStringAsFixed(0)}',
          label: 'Calories',
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildWeeklyChart(List<dynamic> weeklyData) {
    if (weeklyData.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No data available')),
      );
    }

    final maxSteps = weeklyData
        .map((d) => d.steps as int)
        .reduce((a, b) => a > b ? a : b)
        .toDouble();
    final goal = 10000.0;

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxSteps > goal ? maxSteps * 1.2 : goal * 1.2,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${rod.toY.toInt()} steps',
                  const TextStyle(color: Colors.white),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < weeklyData.length) {
                    return Text(
                      weeklyData[value.toInt()].dayName,
                      style: const TextStyle(fontSize: 12),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(
            show: true,
            horizontalInterval: goal,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.shade300,
                strokeWidth: 1,
                dashArray: value == goal ? null : [5, 5],
              );
            },
            drawVerticalLine: false,
          ),
          borderData: FlBorderData(show: false),
          barGroups: weeklyData.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final steps = data.steps as int;
            final goalMet = steps >= goal;

            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: steps.toDouble(),
                  color: goalMet ? Colors.green : Colors.blue,
                  width: 24,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
