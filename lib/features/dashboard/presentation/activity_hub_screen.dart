import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/fit_scaffold.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/bilingual_label.dart';
import '../../../../shared/widgets/activity_rings.dart';
import '../../dashboard/domain/dashboard_providers.dart';

class ActivityHubScreen extends ConsumerWidget {
  const ActivityHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final steps = ref.watch(todayStepsProvider).value ?? 0;
    final calories = ref.watch(todayCaloriesProvider).value ?? 0;
    final minutes = ref.watch(todayActiveMinutesProvider).value ?? 0;

    return FitScaffold(
      title: 'Activity Hub',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BilingualLabel(english: 'Movement at a Glance', hindi: 'एक नज़र में गतिविधि'),
          const SizedBox(height: 24),
          
          // 1. Central Hero Bento (Rings)
          GestureDetector(
            onTap: () => context.push('/home/steps'),
            child: GlassCard(
              height: 260,
              child: Center(
                child: ActivityRingsWidget(
                  strokeWidth: 12,
                  gap: 10,
                  rings: [
                    RingData(
                      progress: (steps / 10000).clamp(0, 1),
                      color: AppTheme.primary,
                      value: steps.toString(),
                      label: 'Steps',
                      goal: '10k',
                    ),
                    RingData(
                      progress: (calories / 2000).clamp(0, 1),
                      color: AppTheme.accent,
                      value: calories.toInt().toString(),
                      label: 'Kcal',
                      goal: '2k',
                    ),
                    RingData(
                      progress: (minutes / 30).clamp(0, 1),
                      color: Colors.purple,
                      value: minutes.toString(),
                      label: 'Min',
                      goal: '30',
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // 2. Action Bento Grid
          Row(
            children: [
              Expanded(
                child: _buildBentoAction(
                  context,
                  icon: Icons.fitness_center,
                  title: 'Workouts',
                  subtitle: 'Start session',
                  color: Colors.orange,
                  onTap: () => context.push('/home/workout'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildBentoAction(
                  context,
                  icon: Icons.map_outlined,
                  title: 'GPS Run',
                  subtitle: 'Track route',
                  color: Colors.blue,
                  onTap: () => context.push('/home/workout/gps'),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          _buildBentoAction(
            context,
            icon: Icons.emoji_events_outlined,
            title: 'Activity Challenges',
            subtitle: 'Join community events',
            color: Colors.amber,
            isWide: true,
            onTap: () => context.push('/social/challenges'),
          ),
          
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildBentoAction(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    bool isWide = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        height: isWide ? 100 : 160,
        padding: const EdgeInsets.all(20),
        child: isWide 
          ? Row(
              children: [
                _buildIconBox(icon, color),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: AppTheme.labelLg(context)),
                    Text(subtitle, style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
                  ],
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.textMuted),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconBox(icon, color),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTheme.labelLg(context)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
                  ],
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildIconBox(IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}
