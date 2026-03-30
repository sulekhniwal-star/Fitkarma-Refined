import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class KarmaLevelCard extends StatelessWidget {
  final int totalKarma;
  final int currentLevel;
  final int karmaInLevel;
  final int karmaForNextLevel;
  final String title;

  const KarmaLevelCard({
    super.key,
    required this.totalKarma,
    required this.currentLevel,
    required this.karmaInLevel,
    required this.karmaForNextLevel,
    this.title = 'Karma',
  });

  @override
  Widget build(BuildContext context) {
    final progress = (karmaInLevel / karmaForNextLevel).clamp(0.0, 1.0);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2D1B69), Color(0xFF6C5CE7), Color(0xFF8B7CF6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.titleMedium.copyWith(color: Colors.white),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'LVL $currentLevel',
                  style:
                      AppTextStyles.labelLarge.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '$totalKarma',
            style:
                AppTextStyles.displaySmall.copyWith(color: AppColors.karmaGold),
          ),
          Text(
            'karma points',
            style: AppTextStyles.bodySmall
                .copyWith(color: Colors.white.withValues(alpha: 0.7)),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.2),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.karmaGold),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$karmaInLevel / $karmaForNextLevel to Level ${currentLevel + 1}',
            style: AppTextStyles.labelSmall
                .copyWith(color: Colors.white.withValues(alpha: 0.7)),
          ),
        ],
      ),
    );
  }
}
