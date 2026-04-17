import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

/// A prominent banner for upcoming festivals with countdown and meal actions.
class FestivalCountdownBanner extends StatelessWidget {
  final String festivalName;
  final String festivalNameHi;
  final int daysRemaining;
  final String fastingType;
  final Color bannerColor;
  final VoidCallback onViewDietPlan;
  final VoidCallback? onSpecialAction;
  final String? specialActionLabel;

  const FestivalCountdownBanner({
    super.key,
    required this.festivalName,
    required this.festivalNameHi,
    required this.daysRemaining,
    required this.fastingType,
    required this.bannerColor,
    required this.onViewDietPlan,
    this.onSpecialAction,
    this.specialActionLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [bannerColor, bannerColor.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: bannerColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        festivalName,
                        style: AppTextStyles.h2(true).copyWith(color: Colors.white),
                      ),
                      Text(
                        festivalNameHi,
                        style: AppTextStyles.sectionHeaderHindi(true).copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        daysRemaining.toString(),
                        style: AppTextStyles.statLarge(true).copyWith(color: Colors.white),
                      ),
                      const Text(
                        'DAYS',
                        style: TextStyle(color: Colors.white70, fontSize: 8, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _FeaturePill(label: 'Mode: $fastingType', icon: Icons.restaurant_menu),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onViewDietPlan,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: bannerColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('View Diet Plan'),
                  ),
                ),
                if (onSpecialAction != null) ...[
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onSpecialAction,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(specialActionLabel ?? 'Action'),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturePill extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FeaturePill({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

