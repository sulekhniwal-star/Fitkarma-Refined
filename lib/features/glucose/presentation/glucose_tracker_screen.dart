import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:fitkarma/core/theme/app_theme.dart';
import 'package:fitkarma/shared/widgets/fit_scaffold.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import 'package:fitkarma/shared/widgets/encryption_badge.dart';
import '../domain/glucose_providers.dart';

class GlucoseTrackerScreen extends ConsumerWidget {
  const GlucoseTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latest = ref.watch(latestGlucoseProvider);
    final logs = ref.watch(glucoseLogsProvider).value ?? [];
    final hba1c = ref.watch(hba1cEstimateProvider);

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Blood Glucose',
      heroContent: _buildHeroContent(context, latest, hba1c),
      body: Column(
        children: [
          _buildActionButtons(context),
          const SizedBox(height: 32),
          _buildTrendSection(context, logs),
          const SizedBox(height: 32),
          _buildHistorySection(context, logs),
          const SizedBox(height: 100),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showLogBottomSheet(context, ref),
        backgroundColor: AppTheme.teal,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, Map<String, dynamic>? latest, double? hba1c) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const EncryptionBadge(),
          const SizedBox(height: 16),
          if (latest != null) ...[
            Text(
              '${latest['value']}',
              style: AppTheme.h1(context).copyWith(fontSize: 80, color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'mg/dL',
                  style: AppTheme.labelMd(context).copyWith(color: Colors.white70, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(color: Colors.white38, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Text(
                  '${latest['type']}'.toUpperCase(),
                  style: AppTheme.labelMd(context).copyWith(color: AppTheme.teal.withValues(alpha: 0.8), letterSpacing: 1),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (hba1c != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Column(
                  children: [
                    Text(
                      'ESTIMATED HBA1C',
                      style: AppTheme.labelMd(context).copyWith(color: Colors.white60, fontSize: 10, letterSpacing: 1.5),
                    ),
                    Text(
                      '${hba1c.toStringAsFixed(1)}%',
                      style: AppTheme.h3(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            else
              Text(
                'LOG 30+ READINGS FOR HbA1C ESTIMATION',
                style: AppTheme.labelMd(context).copyWith(color: Colors.white38, fontSize: 9, letterSpacing: 1),
              ),
          ] else
            Text(
              'No glucose logs recorded yet',
              style: AppTheme.bodyMd(context).copyWith(color: Colors.white70),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => context.push('/home/food/lab-scan'),
        icon: const Icon(Icons.document_scanner_outlined, size: 20),
        label: Text('SCAN LAB REPORT', style: AppTheme.labelMd(context).copyWith(letterSpacing: 1.2)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: BorderSide(color: AppTheme.teal.withValues(alpha: 0.5)),
          foregroundColor: AppTheme.teal,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildTrendSection(BuildContext context, List<Map<String, dynamic>> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Glucose Trend', style: AppTheme.h3(context)),
        const SizedBox(height: 24),
        SizedBox(
          height: 220,
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
                  color: AppTheme.teal,
                  barWidth: 4,
                  dotData: const FlDotData(show: false),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppTheme.teal.withValues(alpha: 0.2),
                        AppTheme.teal.withValues(alpha: 0.0),
                      ],
                    ),
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (spot) => AppTheme.bg2.withValues(alpha: 0.9),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistorySection(BuildContext context, List<Map<String, dynamic>> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('History Logs', style: AppTheme.h3(context)),
        const SizedBox(height: 16),
        ...logs.map((log) => _buildLogItem(context, log)),
      ],
    );
  }

  Widget _buildLogItem(BuildContext context, Map<String, dynamic> log) {
    final val = log['value'] as double;
    final type = log['type'] as String;
    
    Color statusColor = Colors.green;
    if (type == 'Fasting') {
      if (val >= 126) {
        statusColor = Colors.red;
      } else if (val >= 100) {
        statusColor = Colors.orange;
      }
    } else {
      if (val >= 200) {
        statusColor = Colors.red;
      } else if (val >= 140) {
        statusColor = Colors.orange;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 5,
              backgroundColor: statusColor,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: statusColor.withValues(alpha: 0.4), blurRadius: 6, spreadRadius: 1),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '${log['value']}',
                          style: AppTheme.h3(context).copyWith(color: Colors.white),
                        ),
                        TextSpan(
                          text: ' mg/dL',
                          style: AppTheme.bodySm(context).copyWith(color: AppTheme.textMuted),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    DateFormat('MMM dd, hh:mm a').format(log['loggedAt']),
                    style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    type.toUpperCase(),
                    style: AppTheme.labelMd(context).copyWith(fontSize: 8, color: Colors.white60, letterSpacing: 0.5),
                  ),
                ),
                if (log['mealId'] != null) ...[
                  const SizedBox(height: 4),
                  const Icon(Icons.restaurant, size: 14, color: Colors.orange),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showLogBottomSheet(BuildContext context, WidgetRef ref) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
    if (val == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid reading')),
      );
      return;
    }

    await widget.ref.read(glucoseDriftServiceProvider).insertGlucoseLog(
      userId: 'current_user',
      value: val,
      readingType: _selectedType,
    );

    widget.ref.invalidate(glucoseLogsProvider);
    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.bg2,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(28, 20, 28, 28 + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text('Log Blood Glucose', style: AppTheme.h2(context)),
          const SizedBox(height: 32),
          Text(
            'GLUCOSE READING (mg/dL)',
            style: AppTheme.labelMd(context).copyWith(
              color: AppTheme.teal.withValues(alpha: 0.8),
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _valController,
            keyboardType: TextInputType.number,
            style: AppTheme.h3(context).copyWith(color: Colors.white),
            decoration: InputDecoration(
              hintText: '100',
              hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
              prefixIcon: Icon(Icons.bloodtype, color: AppTheme.teal.withValues(alpha: 0.5), size: 20),
              filled: true,
              fillColor: Colors.white.withValues(alpha: 0.05),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'READING TYPE',
            style: AppTheme.labelMd(context).copyWith(
              color: Colors.white60,
              fontSize: 10,
              letterSpacing: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _types.map((t) {
              final isSelected = _selectedType == t;
              return GestureDetector(
                onTap: () => setState(() => _selectedType = t),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.teal.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected ? AppTheme.teal : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    t,
                    style: AppTheme.bodySm(context).copyWith(
                      color: isSelected ? AppTheme.teal : Colors.white70,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.teal,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: Text(
                'SAVE READING',
                style: AppTheme.labelMd(context).copyWith(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

