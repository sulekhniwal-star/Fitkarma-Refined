import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/encryption_badge.dart';
import '../domain/glucose_providers.dart';

class GlucoseTrackerScreen extends ConsumerWidget {
  const GlucoseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final latest = ref.watch(latestGlucoseProvider);
    final logs = ref.watch(glucoseLogsProvider).value ?? [];
    final hba1c = ref.watch(hba1cEstimateProvider);

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildHeroHeader(context, latest, hba1c, isDark),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildActionButtons(context, isDark),
                const SizedBox(height: 32),
                _buildTrendSection(logs, isDark),
                const SizedBox(height: 32),
                _buildHistorySection(logs, isDark),
                const SizedBox(height: 100),
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLogBottomSheet(context, ref),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeroHeader(BuildContext context, Map<String, dynamic>? latest, double? hba1c, bool isDark) {
    return SliverAppBar(
      expandedHeight: 320,
      pinned: true,
      backgroundColor: Colors.teal,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.teal, Color(0xFF00796B)],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EncryptionBadge(),
                const SizedBox(height: 16),
                if (latest != null) ...[
                  Text(
                    '${latest['value']}',
                    style: AppTextStyles.displayLarge(true).copyWith(fontSize: 80, color: Colors.white),
                  ),
                  Text('mg/dL · ${latest['type']}', style: const TextStyle(color: Colors.white70)),
                  const SizedBox(height: 24),
                  if (hba1c != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Text(
                        'Estimated HbA1c: ${hba1c.toStringAsFixed(1)}%',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  else
                    const Text('log 30+ readings for HbA1c estimation', style: TextStyle(color: Colors.white54, fontSize: 10)),
                ] else
                  const Text('No glucose logs yet', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ),
      ),
      title: const Text('Blood Glucose'),
    );
  }

  Widget _buildActionButtons(BuildContext context, bool isDark) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => context.push('/home/food/lab-scan'),
            icon: const Icon(Icons.document_scanner_outlined),
            label: const Text('Import Lab Report'),
          ),
        ),
      ],
    );
  }

  Widget _buildTrendSection(List<Map<String, dynamic>> logs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glucose Trend', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 24),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: logs.reversed.toList().asMap().entries.map((e) {
                    return FlSpot(e.key.toDouble(), (e.value['value'] as double));
                  }).toList(),
                  isCurved: true,
                  color: Colors.tealAccent,
                  barWidth: 3,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(show: true, color: Colors.tealAccent.withValues(alpha: 0.1)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(List<Map<String, dynamic>> logs, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('History', style: AppTextStyles.h3(isDark)),
        const SizedBox(height: 12),
        ...logs.map((log) => _buildLogItem(log, isDark)),
      ],
    );
  }

  Widget _buildLogItem(Map<String, dynamic> log, bool isDark) {
    final val = log['value'] as double;
    final type = log['type'] as String;
    
    Color statusColor = Colors.green;
    if (type == 'Fasting') {
      if (val >= 126) {
        statusColor = Colors.red;
      } else if (val >= 100) statusColor = Colors.orange;
    } else {
      if (val >= 200) {
        statusColor = Colors.red;
      } else if (val >= 140) statusColor = Colors.orange;
    }

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
          CircleAvatar(
            radius: 4,
            backgroundColor: statusColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${log['value']} mg/dL', style: AppTextStyles.labelLarge(isDark)),
                Text(DateFormat('MMM dd, hh:mm a').format(log['loggedAt']), style: AppTextStyles.caption(isDark)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(type, style: TextStyle(color: isDark ? Colors.white70 : Colors.black54, fontSize: 10)),
              if (log['mealId'] != null)
                const Icon(Icons.restaurant, size: 14, color: Colors.orange),
            ],
          ),
        ],
      ),
    );
  }

  void _showLogBottomSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _GlucoseLogSheet(ref: ref),
    );
  }
}

class _GlucoseLogSheet extends StatefulWidget {
  final WidgetRef ref;
  const _GlucoseLogSheet({required this.ref});

  @override
  State<_GlucoseLogSheet> createState() => _GlucoseLogSheetState();
}

class _GlucoseLogSheetState extends State<_GlucoseLogSheet> {
  final _valController = TextEditingController();
  String _selectedType = 'Fasting';

  final List<String> _types = ['Fasting', 'Post-meal', 'Random', 'Bedtime'];

  Future<void> _save() async {
    final val = double.tryParse(_valController.text);
    if (val == null) return;

    await widget.ref.read(glucoseDriftServiceProvider).insertGlucoseLog(
      userId: 'current_user',
      value: val,
      readingType: _selectedType,
    );

    widget.ref.invalidate(glucoseLogsProvider);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Log Blood Glucose', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          TextField(
            controller: _valController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Reading (mg/dL)', hintText: '100'),
          ),
          const SizedBox(height: 24),
          Text('Reading Type', style: AppTextStyles.bodySmall(false)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: _types.map((t) {
              final isSelected = _selectedType == t;
              return ChoiceChip(
                label: Text(t),
                selected: isSelected,
                onSelected: (val) => setState(() => _selectedType = t),
              );
            }).toList(),
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

