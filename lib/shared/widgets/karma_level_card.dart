import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// A hero-style card displaying the user's Karma level and XP progress.
class KarmaLevelCard extends StatelessWidget {
  final int level;
  final String title;
  final int currentXP;
  final int nextLevelXP;

  const KarmaLevelCard({
    super.key,
    required this.level,
    required this.title,
    required this.currentXP,
    required this.nextLevelXP,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentXP / nextLevelXP).clamp(0.0, 1.0);
    final xpRemaining = nextLevelXP - currentXP;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E),
            const Color(0xFF2C2A6B),
            AppColors.secondaryDark,
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
      child: Stack(
        children: [
          // Background accent
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              Icons.auto_awesome,
              size: 120,
              color: Colors.white.withOpacity(0.05),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Level Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.indigo[400],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'LEVEL $level',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: AppTextStyles.h1(isDark: true).copyWith(color: Colors.white),
                ),
                const SizedBox(height: 24),
                // Progress Bar
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white.withOpacity(0.1),
                  color: AppColors.accent,
                  minHeight: 8,
                  borderRadius: BorderRadius.circular(4),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$currentXP / $nextLevelXP XP',
                      style: AppTextStyles.labelMedium(isDark: true).copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    Text(
                      'Next level in $xpRemaining XP',
                      style: AppTextStyles.caption(isDark: true).copyWith(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
