import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/theme/app_colors.dart';
import '../../../shared/theme/app_text_styles.dart';
import '../../../shared/widgets/bilingual_label.dart';

class HabitTrackerScreen extends ConsumerWidget {
  const HabitTrackerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColorsDark.background : AppColors.background,
      appBar: AppBar(title: const Text('Habit Tracker')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHabitCard(
              emoji: '💧',
              name: 'Drink Water',
              nameHi: 'पानी पिएं',
              current: 6,
              target: 8,
              streak: 12,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildHabitCard(
              emoji: '🧘',
              name: 'Meditation',
              nameHi: 'ध्यान',
              current: 0,
              target: 1,
              streak: 0,
              brokenRecently: true,
              isDark: isDark,
            ),
            const SizedBox(height: 16),
            _buildHabitCard(
              emoji: '📖',
              name: 'Read a Book',
              nameHi: 'किताब पढ़ें',
              current: 15,
              target: 30,
              streak: 245,
              isDark: isDark,
            ),
            
            const SizedBox(height: 48),
            Text('Consistency Heatmap', style: AppTextStyles.h3(isDark)),
            const SizedBox(height: 24),
            _buildHeatmapGrid(isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitCard({
    required String emoji,
    required String name,
    required String nameHi,
    required int current,
    required int target,
    required int streak,
    bool brokenRecently = false,
    required bool isDark,
  }) {
    final progress = (current / target).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 32)),
              const SizedBox(width: 16),
              Expanded(
                child: BilingualLabel(
                  english: name,
                  hindi: nameHi,
                ),
              ),
              if (streak > 0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text('🔥 $streak', style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: AppColors.divider.withValues(alpha: 0.2),
                    color: AppColors.primary,
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Text('$current/$target', style: AppTextStyles.labelLarge(isDark)),
            ],
          ),
          if (brokenRecently) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.flash_on, size: 16),
                label: const Text('RECOVER STREAK (50 XP)'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.amber[800],
                  side: BorderSide(color: Colors.amber[800]!),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHeatmapGrid(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemCount: 28, // 4 weeks
        itemBuilder: (context, index) {
          final intensity = (index % 5) / 5.0; // Mock intensity
          return Container(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: intensity == 0 ? 0.05 : intensity),
              borderRadius: BorderRadius.circular(2),
            ),
          );
        },
      ),
    );
  }
}

