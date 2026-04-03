import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Dark purple gradient card with karma level and progress bar.
class KarmaLevelCard extends StatelessWidget {
  final int currentKarma;
  final int nextLevelKarma;
  final int level;
  final String title;

  const KarmaLevelCard({
    super.key,
    required this.currentKarma,
    required this.nextLevelKarma,
    required this.level,
    this.title = 'Karma Level',
  });

  @override
  Widget build(BuildContext context) {
    final progress = nextLevelKarma > 0
        ? (currentKarma / nextLevelKarma).clamp(0.0, 1.0)
        : 1.0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4A148C), Color(0xFF7B1FA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: AppTextStyles.labelLarge
                      .copyWith(color: Colors.white70)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Lv $level',
                  style: AppTextStyles.labelMedium
                      .copyWith(color: const Color(0xFFFFD700)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '$currentKarma / $nextLevelKarma',
            style: AppTextStyles.headlineSmall.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor:
                  const AlwaysStoppedAnimation(Color(0xFFFFD700)),
            ),
          ),
        ],
      ),
    );
  }
}
