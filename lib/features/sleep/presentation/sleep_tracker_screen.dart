import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:fitkarma/core/theme/app_colors.dart';
import 'package:fitkarma/core/theme/app_text_styles.dart';
import '../domain/sleep_providers.dart';
import '../data/sleep_drift_service.dart';

class SleepTrackerScreen extends ConsumerWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final lastNight = ref.watch(lastNightSleepProvider);
    final logs = ref.watch(sleepLogsProvider).value ?? [];
    final debt = ref.watch(sleepDebtProvider);
    final chronotype = ref.watch(chronotypeProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildHeroHeader(context, lastNight, isDark),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSleepDebtCard(debt, isDark),
                const SizedBox(height: 24),
                _buildBarChart(logs, isDark),
                const SizedBox(height: 24),
                if (chronotype != null) _buildChronotypeCard(chronotype, isDark),
                const SizedBox(height: 24),
                _buildAyurvedicTip(logs, isDark),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogBottomSheet(context, ref),
        backgroundColor: Colors.indigo,
        icon: const Icon(Icons.nightlight_round, color: Colors.white),
        label: const Text('Log Sleep', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, dynamic lastNight, bool isDark) {
    final hours = lastNight != null ? (lastNight.durationMin / 60).floor() : 0;
    final minutes = lastNight != null ? lastNight.durationMin % 60 : 0;
    final quality = lastNight?.quality ?? 0;

    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      backgroundColor: Colors.indigo[900],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.indigo[900]!, Colors.purple[900]!],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.nights_stay, color: Colors.white30, size: 60),
                const SizedBox(height: 16),
                if (lastNight != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('$hours', style: AppTextStyles.displayLarge(true).copyWith(fontSize: 80, color: Colors.white)),
                      Text('h $minutes', style: AppTextStyles.h1(true).copyWith(color: Colors.white70)),
                      Text('m', style: AppTextStyles.bodyMedium(true).copyWith(color: Colors.white54)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: hours >= 7 ? Colors.green.withValues(alpha: 0.3) : Colors.red.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: hours >= 7 ? Colors.green : Colors.red),
                    ),
                    child: Text(
                      hours >= 7 ? 'GOOD SLEEP' : 'POOR SLEEP',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10),
                    ),
                  ),
                ] else
                  const Text('No sleep data for last night', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
      title: const Text('Sleep Tracker'),
    );
  }

  Widget _buildSleepDebtCard(int debtMinutes, bool isDark) {
    final hours = debtMinutes ~/ 60;
    final mins = debtMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: debtMinutes > 60 ? Colors.red.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: debtMinutes > 60 ? Colors.red.withValues(alpha: 0.3) : Colors.green.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: debtMinutes > 60 ? Colors.red : Colors.green),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('SLEEP DEBT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1)),
                Text(
                  debtMinutes > 0 ? '$hours h $mins m lost this week' : 'No sleep debt!',
                  style: AppTextStyles.h3(isDark),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<dynamic> logs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Last 7 Nights', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 24),
        SizedBox(
          height: 180,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 12,
              barGroups: logs.reversed.toList().asMap().entries.map((e) {
                return BarChartGroupData(
                  x: e.key,
                  barRods: [
                    BarChartRodData(
                      toY: (e.value.durationMin / 60.0),
                      color: Colors.indigo,
                      width: 16,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }).toList(),
              titlesData: const FlTitlesData(show: false),
              gridData: const FlGridData(show: false),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildChronotypeCard(Chronotype chronotype, bool isDark) {
    String label = 'Intermediate';
    IconData icon = Icons.wb_sunny_outlined;
    if (chronotype == Chronotype.earlyBird) {
      label = 'Early Bird (Lark)';
      icon = Icons.wb_twilight;
    } else if (chronotype == Chronotype.nightOwl) {
      label = 'Night Owl';
      icon = Icons.bedtime;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.indigo, Colors.indigo[800]!]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 40),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('YOUR CHRONOTYPE', style: TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAyurvedicTip(List<dynamic> logs, bool isDark) {
    final avgDuration = logs.isEmpty ? 0 : logs.map((l) => l.durationMin).reduce((a, b) => a + b) / logs.length;
    if (avgDuration >= 360) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: const Row(
        children: [
          Text('🧘', style: TextStyle(fontSize: 24)),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Ayurveda Tip: Lack of sleep increases Vata dosha. Try rubbing warm sesame oil on your feet before bed.',
              style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  void _showLogBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SleepLogSheet(ref: ref),
    );
  }
}

class _SleepLogSheet extends StatefulWidget {
  final WidgetRef ref;
  const _SleepLogSheet({required this.ref});

  @override
  State<_SleepLogSheet> createState() => _SleepLogSheetState();
}

class _SleepLogSheetState extends State<_SleepLogSheet> {
  TimeOfDay _bedtime = const TimeOfDay(hour: 22, minute: 30);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 6, minute: 30);
  int _quality = 3;

  Future<void> _save() async {
    final now = DateTime.now();
    final wake = DateTime(now.year, now.month, now.day, _wakeTime.hour, _wakeTime.minute);
    
    // If bedtime is late, it might be yesterday
    DateTime bed = DateTime(now.year, now.month, now.day, _bedtime.hour, _bedtime.minute);
    if (bed.isAfter(wake)) {
      bed = bed.subtract(const Duration(days: 1));
    }

    await widget.ref.read(sleepDriftServiceProvider).insertSleepLog(
      userId: 'current_user',
      bedtime: bed,
      wakeTime: wake,
      quality: _quality,
    );

    widget.ref.invalidate(sleepLogsProvider);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2C),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Log Last Night Sleep', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTimeSelector('Bedtime', _bedtime, (t) => setState(() => _bedtime = t)),
              _buildTimeSelector('Wake Time', _wakeTime, (t) => setState(() => _wakeTime = t)),
            ],
          ),
          const SizedBox(height: 32),
          const Text('How was your sleep?', style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final val = index + 1;
              final isSelected = _quality == val;
              return IconButton(
                onPressed: () => setState(() => _quality = val),
                icon: Opacity(
                  opacity: isSelected ? 1.0 : 0.3,
                  child: Text(
                    _getEmoji(val),
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              child: const Text('Save Record'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector(String label, TimeOfDay time, ValueChanged<TimeOfDay> onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final t = await showTimePicker(context: context, initialTime: time);
            if (t != null) onChanged(t);
          },
          child: Text(
            time.format(context),
            style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  String _getEmoji(int q) {
    switch (q) {
      case 1: return '😫';
      case 2: return '🥱';
      case 3: return '😴';
      case 4: return '😌';
      case 5: return '🤩';
      default: return '😴';
    }
  }
}

