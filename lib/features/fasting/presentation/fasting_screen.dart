// lib/features/fasting/presentation/fasting_screen.dart
// Fasting Screen with timer, stage ring, and protocol selection

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/fasting/data/fasting_providers.dart';
import 'package:fitkarma/features/fasting/data/fasting_service.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class FastingScreen extends ConsumerStatefulWidget {
  const FastingScreen({super.key});

  @override
  ConsumerState<FastingScreen> createState() => _FastingScreenState();
}

class _FastingScreenState extends ConsumerState<FastingScreen> {
  @override
  Widget build(BuildContext context) {
    final fastingState = ref.watch(fastingStateProvider);
    final statistics = ref.watch(fastingStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fasting'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsSheet,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Timer Card
              _buildTimerCard(fastingState),
              const SizedBox(height: 24),

              // Stage Ring
              _buildStageRing(fastingState),
              const SizedBox(height: 24),

              // Statistics Card
              _buildStatisticsCard(statistics),
              const SizedBox(height: 24),

              // Protocol Selection (when not fasting)
              fastingState.when(
                data: (state) {
                  if (!state.isFasting) {
                    return _buildProtocolSelection();
                  }
                  return const SizedBox();
                },
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              ),

              // Tips Card
              _buildTipsCard(),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildFab(fastingState),
    );
  }

  Future<void> _refreshData() async {
    ref.invalidate(activeFastProvider);
    ref.invalidate(fastingStateProvider);
    ref.invalidate(fastingHistoryProvider);
    ref.invalidate(fastingStatisticsProvider);
  }

  Widget _buildTimerCard(AsyncValue<FastingState> fastingState) {
    return fastingState.when(
      data: (state) {
        return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(24),
            width: double.infinity,
            child: Column(
              children: [
                // Status text
                Text(
                  state.isFasting ? 'Fasting' : 'Not Fasting',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: state.isFasting ? AppColors.primary : Colors.grey,
                  ),
                ),
                const SizedBox(height: 16),

                // Timer display
                Text(
                  state.elapsedFormatted,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 8),

                // Target/Remaining
                if (state.isFasting) ...[
                  Text(
                    state.remainingFormatted,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Target: ${state.target.inHours} hours',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                  if (state.protocol != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Protocol: ${state.protocol!.displayName}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ] else ...[
                  const Text(
                    'Start a fast to begin tracking',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text('Error: $e'),
        ),
      ),
    );
  }

  Widget _buildStageRing(AsyncValue<FastingState> fastingState) {
    return fastingState.when(
      data: (state) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text(
                  'Fasting Stage',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // Custom stage ring
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CustomPaint(
                    painter: _StageRingPainter(
                      progress: state.isFasting ? state.progress : 0,
                      stage: state.stage,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state.isFasting
                                ? '${(state.progress * 100).toInt()}%'
                                : '0%',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (state.isFasting)
                            Text(
                              state.stage.displayName,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(state.stage.colorValue),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Stage description
                if (state.isFasting)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(
                        state.stage.colorValue,
                      ).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      state.stage.description,
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(state.stage.colorValue),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                // Stage timeline
                const SizedBox(height: 16),
                _buildStageTimeline(state),
              ],
            ),
          ),
        );
      },
      loading: () => const SizedBox(),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildStageTimeline(FastingState state) {
    final stages = [
      FastingStage.earlyFasting,
      FastingStage.fatBurning,
      FastingStage.ketosis,
      FastingStage.deepKetosis,
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: stages.map((stage) {
        final isActive =
            state.isFasting &&
            stages.indexOf(state.stage) >= stages.indexOf(stage);
        final isCurrent = state.isFasting && state.stage == stage;

        return Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Color(stage.colorValue) : Colors.grey[300],
                border: isCurrent
                    ? Border.all(color: Color(stage.colorValue), width: 2)
                    : null,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${stage.minHours}h',
              style: TextStyle(
                fontSize: 10,
                color: isActive ? Colors.grey[700] : Colors.grey[400],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildStatisticsCard(AsyncValue<FastingStatistics> statistics) {
    return statistics.when(
      data: (stats) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Statistics (30 days)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.local_fire_department,
                        value: stats.totalFasts.toString(),
                        label: 'Fasts',
                        color: Colors.orange,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.star,
                        value: '+${stats.totalXpEarned}',
                        label: 'XP Earned',
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.timer,
                        value: stats.averageDurationFormatted,
                        label: 'Avg Duration',
                        color: AppColors.primary,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        icon: Icons.trending_up,
                        value: '${stats.completionRate.toStringAsFixed(0)}%',
                        label: 'Completion',
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('Unable to load statistics'),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildProtocolSelection() {
    final selectedProtocol = ref.watch(selectedProtocolProvider);
    final isRamadanMode = ref.watch(ramadanModeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Protocol',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Protocol options
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: FastingProtocol.values.map((protocol) {
                final isSelected = selectedProtocol == protocol;
                return ChoiceChip(
                  label: Text(protocol.displayName),
                  selected: isSelected,
                  onSelected: (selected) {
                    if (selected) {
                      ref.read(selectedProtocolProvider.notifier).state =
                          protocol;
                    }
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 12),

            // Ramadan mode toggle
            SwitchListTile(
              title: const Text('Ramadan Mode'),
              subtitle: const Text('Use Sehri/Iftar times'),
              value: isRamadanMode,
              onChanged: (value) {
                ref.read(ramadanModeProvider.notifier).state = value;
              },
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTipsCard() {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.blue[700]),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tips',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[700],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Stay hydrated during your fasting window. Black coffee and unsweetened tea are allowed during fasting hours.',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab(AsyncValue<FastingState> fastingState) {
    return fastingState.when(
      data: (state) {
        if (state.isFasting) {
          return FloatingActionButton.extended(
            onPressed: () => _endFast(),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.stop),
            label: const Text('End Fast'),
          );
        } else {
          return FloatingActionButton.extended(
            onPressed: () => _startFast(),
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Fast'),
          );
        }
      },
      loading: () => const SizedBox(),
      error: (_, __) => FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.grey,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.error),
        label: const Text('Error'),
      ),
    );
  }

  Future<void> _startFast() async {
    final protocol = ref.read(selectedProtocolProvider);
    final isRamadan = ref.read(ramadanModeProvider);

    final notifier = ref.read(fastingNotifierProvider.notifier);
    await notifier.startFast(protocol: protocol, isRamadanMode: isRamadan);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Started ${protocol.displayName} fasting!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  Future<void> _endFast() async {
    final activeFast = await ref.read(activeFastProvider.future);
    if (activeFast == null) return;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('End Fast?'),
        content: const Text('Are you sure you want to end your current fast?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('End Fast'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final notifier = ref.read(fastingNotifierProvider.notifier);
      final result = await notifier.endFast(activeFast.id);

      if (mounted && result != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Fast completed! +${result.xpEarned} XP earned! 🎉'),
            backgroundColor: Colors.amber[700],
          ),
        );
      }
    }
  }

  void _showSettingsSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Hydration alerts toggle
            SwitchListTile(
              title: const Text('Hydration Alerts'),
              subtitle: const Text('Get reminded to drink water'),
              value: ref.watch(hydrationAlertsEnabledProvider),
              onChanged: (value) {
                ref.read(hydrationAlertsEnabledProvider.notifier).state = value;
              },
            ),

            // Hydration interval
            ListTile(
              title: const Text('Alert Interval'),
              subtitle: Text(
                'Every ${ref.watch(hydurationAlertIntervalProvider)} minutes',
              ),
              trailing: DropdownButton<int>(
                value: ref.watch(hydurationAlertIntervalProvider),
                items: [30, 45, 60, 90, 120].map((mins) {
                  return DropdownMenuItem(
                    value: mins,
                    child: Text('$mins min'),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    ref.read(hydurationAlertIntervalProvider.notifier).state =
                        value;
                  }
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Custom painter for the fasting stage ring
class _StageRingPainter extends CustomPainter {
  final double progress;
  final FastingStage stage;

  _StageRingPainter({required this.progress, required this.stage});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 10;

    // Background ring
    final bgPaint = Paint()
      ..color = Colors.grey[200]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    // Progress ring
    if (progress > 0) {
      final progressPaint = Paint()
        ..color = Color(stage.colorValue)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round;

      final sweepAngle = 2 * math.pi * progress;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, // Start from top
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(_StageRingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.stage != stage;
  }
}
