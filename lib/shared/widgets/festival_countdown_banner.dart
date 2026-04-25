import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

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
                        festivalName.toUpperCase(),
                        style: AppTypography.h2(color: Colors.white).copyWith(
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        festivalNameHi,
                        style: AppTypography.labelMd(color: Colors.white.withValues(alpha: 0.8)),
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
                        daysRemaining == 0 ? 'LIVE' : daysRemaining.toString(),
                        style: AppTypography.monoLg(color: Colors.white).copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (daysRemaining > 0)
                        Text(
                          'DAYS',
                          style: AppTypography.labelMd(color: Colors.white70).copyWith(
                            letterSpacing: 1.2,
                          ),
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
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: InkWell(
                      onTap: onViewDietPlan,
                      child: Center(
                        child: Text(
                          'VIEW DIET PLAN',
                          style: AppTypography.labelLg(color: bannerColor).copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (onSpecialAction != null) ...[
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: InkWell(
                        onTap: onSpecialAction,
                        child: Center(
                          child: Text(
                            (specialActionLabel ?? 'ACTION').toUpperCase(),
                            style: AppTypography.labelLg(color: Colors.white).copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
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
