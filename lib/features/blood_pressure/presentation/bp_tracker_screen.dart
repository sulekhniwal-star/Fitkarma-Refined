import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart';
import 'package:fitkarma/core/config/app_theme.dart';
import 'package:fitkarma/shared/widgets/fit_scaffold.dart';
import 'package:fitkarma/shared/widgets/glass_card.dart';
import 'package:fitkarma/shared/widgets/encryption_badge.dart';
import '../domain/bp_classifier.dart';
import '../domain/bp_providers.dart';

class BPTrackerScreen extends ConsumerWidget {
  const BPTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final latestBP = ref.watch(latestBPProvider);
    final logs = ref.watch(bpLogsProvider).value ?? [];

    return FitScaffold(
      pattern: ScaffoldPattern.immersiveHero,
      title: 'Blood Pressure',
      heroContent: _buildHeroContent(context, latestBP),
      body: Column(
        children: [
          _buildTrendSection(context, logs),
          const SizedBox(height: 32),
          _buildHistorySection(context, logs),
          const SizedBox(height: 100), // FAB space
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogBottomSheet(context, ref),
        backgroundColor: AppTheme.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text('Log Reading', style: AppTheme.labelMd(context).copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildHeroContent(BuildContext context, Map<String, dynamic>? latest) {
    final sys = latest?['systolic'] ?? 0;
    final dia = latest?['diastolic'] ?? 0;
    final classification = latest != null ? BPClassifier.classify(sys, dia) : null;

    return Center(
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
                Text('$sys', style: AppTheme.h1(context).copyWith(fontSize: 80, color: Colors.white)),
                Text(' / $dia', style: AppTheme.h2(context).copyWith(color: Colors.white.withValues(alpha: 0.6))),
              ],
            ),
            Text(
              'mmHg',
              style: AppTheme.labelMd(context).copyWith(
                color: Colors.white.withValues(alpha: 0.5),
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: BPClassifier.getColor(classification!).withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: BPClassifier.getColor(classification).withValues(alpha: 0.5)),
              ),
              child: Text(
                BPClassifier.getLabel(classification).toUpperCase(),
                style: AppTheme.labelMd(context).copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ] else
            Text(
              'No readings recorded yet',
              style: AppTheme.bodyMd(context).copyWith(color: Colors.white.withValues(alpha: 0.7)),
            ),
        ],
      ),
    );
  }

  Widget _buildTrendSection(BuildContext context, List<Map<String, dynamic>> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('7-Day Trend', style: AppTheme.h3(context)),
        const SizedBox(height: 24),
        SizedBox(
          height: 220,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                _buildTrendLine(logs, true), // Systolic
                _buildTrendLine(logs, false), // Diastolic
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

  LineChartBarData _buildTrendLine(List<Map<String, dynamic>> logs, bool isSystolic) {
    final sorted = logs.reversed.toList();
    return LineChartBarData(
      spots: sorted.asMap().entries.map((e) {
        return FlSpot(e.key.toDouble(), (e.value[isSystolic ? 'systolic' : 'diastolic'] as int).toDouble());
      }).toList(),
      isCurved: true,
      color: isSystolic ? AppTheme.primary : AppTheme.primary.withValues(alpha: 0.4),
      barWidth: 4,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(
        show: isSystolic,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppTheme.primary.withValues(alpha: 0.2),
            AppTheme.primary.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }

  Widget _buildHistorySection(BuildContext context, List<Map<String, dynamic>> logs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('History', style: AppTheme.h3(context)),
            Text(
              '${logs.length} readings',
              style: AppTheme.bodySm(context).copyWith(color: AppTheme.textMuted),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...logs.map((log) {
          final classification = BPClassifier.classify(log['systolic'], log['diastolic']);
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: GlassCard(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 44,
                    decoration: BoxDecoration(
                      color: BPClassifier.getColor(classification),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: BPClassifier.getColor(classification).withValues(alpha: 0.3),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ],
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
                                text: '${log['systolic']}',
                                style: AppTheme.h3(context).copyWith(color: Colors.white),
                              ),
                              TextSpan(
                                text: '/${log['diastolic']}',
                                style: AppTheme.h4(context).copyWith(color: Colors.white.withValues(alpha: 0.6)),
                              ),
                              TextSpan(
                                text: ' mmHg',
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
                      Row(
                        children: [
                          Icon(Icons.favorite, size: 14, color: AppTheme.primary.withValues(alpha: 0.6)),
                          const SizedBox(width: 4),
                          Text(
                            '${log['pulse']} BPM',
                            style: AppTheme.bodySm(context).copyWith(
                              color: AppTheme.textMuted,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        BPClassifier.getLabel(classification).toUpperCase(),
                        style: AppTheme.labelMd(context).copyWith(
                          color: BPClassifier.getColor(classification),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  void _showLogBottomSheet(BuildContext context, WidgetRef ref) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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

    if (sys == null || dia == null || pulse == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid readings')),
      );
      return;
    }

    final classification = BPClassifier.classify(sys, dia);
    
    await widget.ref.read(bpDriftServiceProvider).insertBPLog(
      userId: 'current_user',
      systolic: sys,
      diastolic: dia,
      pulse: pulse,
    );

    widget.ref.invalidate(bpLogsProvider);
    if (!mounted) return;
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
          Text('Log Blood Pressure', style: AppTheme.h2(context)),
          const SizedBox(height: 8),
          Text(
            'Ensure you are in a relaxed sitting position.',
            style: AppTheme.bodySm(context).copyWith(color: AppTheme.textMuted),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _buildInputField(
                  controller: _sysController,
                  label: 'SYSTOLIC',
                  hint: '120',
                  icon: Icons.compress,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildInputField(
                  controller: _diaController,
                  label: 'DIASTOLIC',
                  hint: '80',
                  icon: Icons.expand,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInputField(
            controller: _pulseController,
            label: 'PULSE (BPM)',
            hint: '72',
            icon: Icons.favorite,
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.labelMd(context).copyWith(
            color: AppTheme.primary.withValues(alpha: 0.8),
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: AppTheme.h3(context).copyWith(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.2)),
            prefixIcon: Icon(icon, color: Colors.white38, size: 20),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ],
    );
  }
}

