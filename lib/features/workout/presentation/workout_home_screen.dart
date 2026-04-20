import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/config/app_theme.dart';
import '../../../../shared/widgets/fit_scaffold.dart';
import '../../../../shared/widgets/glass_card.dart';
import '../../../../shared/widgets/bilingual_label.dart';

class WorkoutHomeScreen extends ConsumerWidget {
  const WorkoutHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FitScaffold(
      title: 'Workouts',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActivePlanCard(context),
          const SizedBox(height: 32),
          const BilingualLabel(english: 'Categories', hindi: 'श्रेणियां'),
          const SizedBox(height: 16),
          _buildCategories(context),
          const SizedBox(height: 32),
          const BilingualLabel(english: 'Recommended for You', hindi: 'आपके लिए सिफारिश की गई'),
          const SizedBox(height: 16),
          _buildWorkoutList(context),
          const SizedBox(height: 100),
        ],
      ),
    );
  }

  Widget _buildActivePlanCard(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppTheme.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'ACTIVE PLAN',
                  style: AppTheme.monoSm(context).copyWith(color: AppTheme.primary),
                ),
              ),
              const Text('4/12 Weeks', style: TextStyle(color: AppTheme.textMuted, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 20),
          Text('Muscle Re-Construction', style: AppTheme.h2(context)),
          const SizedBox(height: 8),
          const Text('Focus: Hypertrophy & Stability', style: TextStyle(color: AppTheme.textSecondary)),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('START TODAY\'S WORKOUT'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'icon': '🏋️', 'label': 'Strength', 'color': Colors.blue},
      {'icon': '🧘', 'label': 'Yoga', 'color': Colors.orange},
      {'icon': '🏃', 'label': 'Cardio', 'color': Colors.red},
      {'icon': '🤸', 'label': 'HIIT', 'color': Colors.purple},
    ];

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Container(
            width: 85,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: (cat['color'] as Color).withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                    border: Border.all(color: (cat['color'] as Color).withValues(alpha: 0.3)),
                  ),
                  child: Center(child: Text(cat['icon'] as String, style: const TextStyle(fontSize: 28))),
                ),
                const SizedBox(height: 8),
                Text(cat['label'] as String, style: AppTheme.caption(context)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWorkoutList(BuildContext context) {
    return Column(
      children: [
        _buildWorkoutCard('Surya Namaskar Flow', '20 min · Beginner', '☀️', context),
        const SizedBox(height: 12),
        _buildWorkoutCard('Dumbbell Deadlift', '45 min · Intermediate', '💪', context),
        const SizedBox(height: 12),
        _buildWorkoutCard('Pranayama Basics', '10 min · Recovery', '🌬️', context),
      ],
    );
  }

  Widget _buildWorkoutCard(String title, String subtitle, String emoji, BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 32))),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.labelLg(context)),
                const SizedBox(height: 4),
                Text(subtitle, style: AppTheme.caption(context).copyWith(color: AppTheme.textMuted)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppTheme.textMuted),
        ],
      ),
    );
  }
}
