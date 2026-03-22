// lib/features/sleep/presentation/sleep_screen.dart
// Sleep Tracker Screen with logging, charts, and debt tracker

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/sleep/data/sleep_providers.dart';
import 'package:fitkarma/features/sleep/data/sleep_service.dart';
import 'package:fitkarma/features/sleep/presentation/sleep_logging_sheet.dart';
import 'package:fitkarma/features/sleep/presentation/sleep_chart.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';
import 'package:fitkarma/core/storage/drift_service.dart';

class SleepScreen extends ConsumerStatefulWidget {
  const SleepScreen({super.key});

  @override
  ConsumerState<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends ConsumerState<SleepScreen> {
  @override
  Widget build(BuildContext context) {
    final todaySleep = ref.watch(todaySleepLogProvider);
    final weeklyData = ref.watch(weeklySleepDataProvider);
    final sleepDebt = ref.watch(sleepDebtProvider);
    final chronotype = ref.watch(chronotypeProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Sleep Tracker'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(todaySleepLogProvider);
          ref.invalidate(weeklySleepDataProvider);
          ref.invalidate(sleepDebtProvider);
          ref.invalidate(chronotypeProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sleep Debt Banner
              sleepDebt.when(
                data: (debt) => _SleepDebtBanner(debtMinutes: debt),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 16),

              // Today's Sleep Card
              _TodaySleepCard(
                sleepData: todaySleep,
                onLogTap: () => _showLoggingSheet(context),
              ),

              const SizedBox(height: 24),

              // Chronotype Card
              chronotype.when(
                data: (type) => _ChronotypeCard(chronotype: type),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Weekly Sleep Chart
              Text(
                'This Week',
                style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              weeklyData.when(
                data: (data) => SleepChart(weeklyData: data),
                loading: () => const SizedBox(
                  height: 200,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (e, _) => Text('Error: $e'),
              ),

              const SizedBox(height: 24),

              // Weekly Stats
              weeklyData.when(
                data: (data) =>
                    _WeeklyStatsRow(weeklyData: AsyncValue.data(data)),
                loading: () => const SizedBox.shrink(),
                error: (_, _) => const SizedBox.shrink(),
              ),

              const SizedBox(height: 24),

              // Recent Sleep Logs
              Text(
                'Recent Logs',
                style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 12),
              _RecentLogsList(weeklyData: weeklyData),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLoggingSheet(context),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Log Sleep', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  void _showLoggingSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SleepLoggingSheet(),
    );
  }
}

// ============================================================================
// Sleep Debt Banner Widget
// ============================================================================

class _SleepDebtBanner extends StatelessWidget {
  final int debtMinutes;

  const _SleepDebtBanner({required this.debtMinutes});

  @override
  Widget build(BuildContext context) {
    if (debtMinutes <= 0) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Text('✅', style: TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'You\'re well-rested! No sleep debt this week.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    }

    final hours = debtMinutes ~/ 60;
    final minutes = debtMinutes % 60;
    final debtText = hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const Text('😴', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'You owe $debtText sleep this week',
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.warning,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Today's Sleep Card Widget
// ============================================================================

class _TodaySleepCard extends StatelessWidget {
  final AsyncValue<SleepLogEntry?> sleepData;
  final VoidCallback onLogTap;

  const _TodaySleepCard({required this.sleepData, required this.onLogTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.purple, AppColors.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: sleepData.when(
        data: (sleep) {
          if (sleep == null) {
            return Column(
              children: [
                const Icon(
                  Icons.bedtime_outlined,
                  size: 48,
                  color: Colors.white70,
                ),
                const SizedBox(height: 12),
                const Text(
                  'No sleep logged today',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onLogTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.purple,
                  ),
                  child: const Text('Log Last Night\'s Sleep'),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Last Night',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _getQualityEmoji(sleep.qualityScore),
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${sleep.durationHours.toStringAsFixed(1)}h',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'sleep',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _SleepInfoChip(
                    icon: Icons.bedtime,
                    label: 'Bed: ${sleep.bedtime}',
                  ),
                  const SizedBox(width: 12),
                  _SleepInfoChip(
                    icon: Icons.wb_sunny,
                    label: 'Wake: ${sleep.wakeTime}',
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(children: [_SleepQualityBar(quality: sleep.qualityScore)]),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (e, _) =>
            Text('Error: $e', style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  String _getQualityEmoji(int quality) {
    if (quality >= 80) return '😴';
    if (quality >= 60) return '😊';
    if (quality >= 40) return '😐';
    if (quality >= 20) return '😔';
    return '😫';
  }
}

class _SleepInfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SleepInfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: Colors.white70),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _SleepQualityBar extends StatelessWidget {
  final int quality;

  const _SleepQualityBar({required this.quality});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quality: $quality%',
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: quality / 100,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                quality >= 70
                    ? AppColors.success
                    : quality >= 40
                    ? AppColors.warning
                    : AppColors.error,
              ),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Chronotype Card Widget
// ============================================================================

class _ChronotypeCard extends StatelessWidget {
  final Chronotype chronotype;

  const _ChronotypeCard({required this.chronotype});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                chronotype.emoji,
                style: const TextStyle(fontSize: 28),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Chronotype',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  chronotype.displayName,
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  chronotype == Chronotype.unknown
                      ? 'Log 30 days to detect'
                      : 'Based on your sleep patterns',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Weekly Stats Row Widget
// ============================================================================

class _WeeklyStatsRow extends StatelessWidget {
  final AsyncValue<WeeklySleepData> weeklyData;

  const _WeeklyStatsRow({required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return weeklyData.when(
      data: (data) => Row(
        children: [
          Expanded(
            child: _StatCard(
              icon: Icons.access_time,
              label: 'Avg Duration',
              value: '${data.avgDurationHours.toStringAsFixed(1)}h',
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.star,
              label: 'Avg Quality',
              value: '${data.avgQualityScore}%',
              color: AppColors.warning,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _StatCard(
              icon: Icons.nights_stay,
              label: 'Total Sleep',
              value: '${(data.totalSleepMin / 60).toStringAsFixed(1)}h',
              color: AppColors.purple,
            ),
          ),
        ],
      ),
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Recent Logs List Widget
// ============================================================================

class _RecentLogsList extends StatelessWidget {
  final AsyncValue<WeeklySleepData> weeklyData;

  const _RecentLogsList({required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    return weeklyData.when(
      data: (data) {
        if (data.logs.isEmpty) {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Icon(Icons.history, size: 48, color: Colors.grey[300]),
                const SizedBox(height: 12),
                Text(
                  'No sleep logs yet',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          children: data.logs
              .take(7)
              .map((log) => _LogListItem(log: log))
              .toList(),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
    );
  }
}

class _LogListItem extends StatelessWidget {
  final SleepLogEntry log;

  const _LogListItem({required this.log});

  @override
  Widget build(BuildContext context) {
    final dayName = _getDayName(log.date);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.purple.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                _getQualityEmoji(log.qualityScore),
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dayName,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${log.bedtime} → ${log.wakeTime}',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${log.durationHours.toStringAsFixed(1)}h',
                style: AppTextStyles.h4.copyWith(color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: _getQualityColor(
                    log.qualityScore,
                  ).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '${log.qualityScore}%',
                  style: AppTextStyles.caption.copyWith(
                    color: _getQualityColor(log.qualityScore),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDayName(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final logDate = DateTime(date.year, date.month, date.day);

    if (logDate == today) return 'Today';
    if (logDate == yesterday) return 'Yesterday';

    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[date.weekday - 1];
  }

  String _getQualityEmoji(int quality) {
    if (quality >= 80) return '😴';
    if (quality >= 60) return '😊';
    if (quality >= 40) return '😐';
    if (quality >= 20) return '😔';
    return '😫';
  }

  Color _getQualityColor(int quality) {
    if (quality >= 70) return AppColors.success;
    if (quality >= 40) return AppColors.warning;
    return AppColors.error;
  }
}
