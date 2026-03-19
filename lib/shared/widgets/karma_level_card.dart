import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class KarmaLevelCard extends StatelessWidget {
  final int level;
  final String title;
  final double progress; // 0.0 - 1.0
  final int karmaPoints;
  final int pointsToNextLevel;

  const KarmaLevelCard({
    super.key,
    required this.level,
    required this.title,
    required this.progress,
    required this.karmaPoints,
    required this.pointsToNextLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.secondary,
            AppColors.secondaryDark.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level $level',
                    style: AppTextStyles.h4.copyWith(
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: AppTextStyles.h1OnDark.copyWith(
                      fontSize: 28,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.stars_rounded,
                color: AppColors.accent,
                size: 40,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$karmaPoints Karma',
                style: AppTextStyles.labelMedium.copyWith(color: Colors.white),
              ),
              Text(
                'Next Level: $pointsToNextLevel',
                style: AppTextStyles.captionOnDark,
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white.withOpacity(0.1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Keep it up! Your healthy habits are earning you real-world rewards.',
            style: AppTextStyles.bodyOnDark.copyWith(
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
