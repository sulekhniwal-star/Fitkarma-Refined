import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/features/steps/data/step_service.dart';
import 'package:fitkarma/shared/widgets/activity_rings.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';

class StepsScreen extends ConsumerWidget {
  const StepsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(dailyStepsProvider.notifier).refresh();
    final steps = ref.watch(dailyStepsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Steps'),
        centerTitle: true,
      ),
      body: _StepsContent(steps: steps),
    );
  }
}

class _StepsContent extends StatelessWidget {
  final DailySteps steps;

  const _StepsContent({required this.steps});

  @override
  Widget build(BuildContext context) {
    final progress = steps.progress;
    final isGoalReached = steps.goalReached;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          _buildRing(progress, isGoalReached),
          const SizedBox(height: 24),
          _buildStats(isGoalReached),
          const SizedBox(height: 24),
          _buildWeeklyChart(),
        ],
      ),
    );
  }

  Widget _buildRing(double progress, bool isGoalReached) {
    final ringColor = isGoalReached ? AppColors.primary : Colors.grey.shade400;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 180,
          height: 180,
          child: ActivityRings(
            stepsProgress: progress,
            caloriesProgress: progress,
            sleepProgress: 0.5,
            moodProgress: 0.5,
            size: 180,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${steps.todaySteps}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'of ${steps.goal}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            if (isGoalReached)
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '🎉 Goal!',
                  style: TextStyle(fontSize: 12, color: Colors.green),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildStats(bool isGoalReached) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'Remaining',
            value: '${steps.stepsRemaining}',
            color: isGoalReached ? Colors.green : AppColors.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            label: 'XP Earned',
            value: '+${(steps.todaySteps / 1000 * 5).floor()}',
            color: const Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildWeeklyChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This Week',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (i) {
                final height = (50 + (i * 15) % 80).toDouble();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: height,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _dayLabel(i),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  String _dayLabel(int i) {
    const days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    return days[i];
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, color: color)),
        ],
      ),
    );
  }
}