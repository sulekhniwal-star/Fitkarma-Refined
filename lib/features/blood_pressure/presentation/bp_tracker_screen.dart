import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../domain/bp_classifier.dart';
import '../domain/bp_providers.dart';

class BPTrackerScreen extends ConsumerWidget {
  const BPTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final latestBP = ref.watch(latestBPProvider);
    final logs = ref.watch(bpLogsProvider).value ?? [];

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildHeroHeader(context, latestBP, isDark),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildTrendSection(logs, isDark),
                const SizedBox(height: 32),
                _buildHistorySection(logs, isDark),
                const SizedBox(height: 100), // FAB space
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogBottomSheet(context, ref),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log BP', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, Map<String, dynamic>? latest, bool isDark) {
    final sys = latest?['systolic'] ?? 0;
    final dia = latest?['diastolic'] ?? 0;
    final classification = latest != null ? BPClassifier.classify(sys, dia) : null;

    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: AppColors.primary,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EncryptionBadge(),
                const SizedBox(height: 16),
                if (latest != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('$sys', style: AppTextStyles.displayLarge(true).copyWith(fontSize: 72, color: Colors.white)),
                      Text(' / $dia', style: AppTextStyles.h1(true).copyWith(color: Colors.white70)),
                    ],
                  ),
                  const Text('mmHg', style: TextStyle(color: Colors.white60, letterSpacing: 2)),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: BPClassifier.getColor(classification!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      BPClassifier.getLabel(classification),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ] else
                  const Text('No readings recorded yet', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
      title: const Text('Blood Pressure'),
    );
  }

  Widget _buildTrendSection(List<Map<String, dynamic>> logs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('7-Day Trend', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                _buildTrendLine(logs, true), // Systolic
                _buildTrendLine(logs, false), // Diastolic
              ],
            ),
          ),
        ),
      ],
    );
  }

  LineChartBarData _buildTrendLine(List<Map<String, dynamic>> logs, bool isSystolic) {
    // Reverse to chronological for chart
    final sorted = logs.reversed.toList();
    return LineChartBarData(
      spots: sorted.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), (e.value[isSystolic ? 'systolic' : 'diastolic'] as int).toDouble());
      }).toList(),
      isCurved: true,
      color: isSystolic ? Colors.white : Colors.white60,
      barWidth: 3,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: false),
    );
  }

  Widget _buildHistorySection(List<Map<String, dynamic>> logs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('History', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 12),
        ...logs.map((log) {
          final classification = BPClassifier.classify(log['systolic'], log['diastolic']);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColorsDark.surface : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.divider),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: BPClassifier.getColor(classification),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${log['systolic']}/${log['diastolic']} mmHg', style: AppTextStyles.labelLarge(isDark)),
                      Text(DateFormat('MMM dd, hh:mm a').format(log['loggedAt']), style: AppTextStyles.caption(isDark)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Pulse: ${log['pulse']}', style: AppTextStyles.bodySmall(isDark)),
                    Text(BPClassifier.getLabel(classification),
                        style: TextStyle(color: BPClassifier.getColor(classification), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  void _showLogBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _BPLogSheet(ref: ref),
    );
  }
}

class _BPLogSheet extends StatefulWidget {
  final WidgetRef ref;
  const _BPLogSheet({required this.ref});

  @override
  State<_BPLogSheet> createState() => _BPLogSheetState();
}

class _BPLogSheetState extends State<_BPLogSheet> {
  final _sysController = TextEditingController();
  final _diaController = TextEditingController();
  final _pulseController = TextEditingController();

  Future<void> _save() async {
    final sys = int.tryParse(_sysController.text);
    final dia = int.tryParse(_diaController.text);
    final pulse = int.tryParse(_pulseController.text);

    if (sys == null || dia == null || pulse == null) return;

    final classification = BPClassifier.classify(sys, dia);
    
    await widget.ref.read(bpDriftServiceProvider).insertBPLog(
      userId: 'current_user',
      systolic: sys,
      diastolic: dia,
      pulse: pulse,
    );

    widget.ref.invalidate(bpLogsProvider);
    Navigator.pop(context);

    if (classification == BPClassification.crisis) {
      _showEmergencyAlert();
    }
  }

  void _showEmergencyAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 8),
            Text('CRITICAL ALERT', style: TextStyle(color: Colors.red)),
          ],
        ),
        content: const Text(
          'Your blood pressure reading indicates a hypertensive crisis. Seek immediate medical attention or call emergency services right away.',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Dismiss')),
          ElevatedButton(
            onPressed: () {}, // TODO: Call emergency
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('CALL EMERGENCY', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Log Blood Pressure', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _sysController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Systolic', hintText: '120'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _diaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Diastolic', hintText: '80'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _pulseController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Pulse (BPM)', hintText: '72'),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: _save, child: const Text('Save Reading')),
          ),
        ],
      ),
    );
  }
}

