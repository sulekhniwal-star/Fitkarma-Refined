// lib/shared/widgets/bottom_nav_bar.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/config/device_tier.dart';
import '../../core/config/user_experience_stage.dart';
import '../../core/providers/device_tier_provider.dart';
import '../../core/providers/ux_stage_provider.dart';

class FitKarmaBottomNav extends ConsumerWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const FitKarmaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _tabs = [
    (icon: Icons.home_outlined,         filled: Icons.home,           en: 'Home',    hi: 'मुख्यपृष्ठ', route: '/home/dashboard'),
    (icon: Icons.restaurant_outlined,   filled: Icons.restaurant,     en: 'Food',    hi: 'खाना',       route: '/home/food'),
    (icon: Icons.fitness_center_outlined, filled: Icons.fitness_center, en: 'Workout', hi: 'वर्कआउट',  route: '/home/workout'),
    (icon: Icons.directions_walk_outlined, filled: Icons.directions_walk, en: 'Steps', hi: 'कदम',      route: '/home/steps'),
    (icon: Icons.person_outline,        filled: Icons.person,         en: 'Me',      hi: 'मैं',        route: '/profile'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stage = ref.watch(uxStageProvider);
    final showAllLabels = stage == UXStage.firstWeek;
    final tier = ref.watch(deviceTierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16,
          MediaQuery.of(context).padding.bottom + 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: tier.blurRadius > 0 ? 16 : 0,
            sigmaY: tier.blurRadius > 0 ? 16 : 0,
          ),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColorsDark.surface1.withOpacity(tier.isGlassSurfacesEnabled ? 0.9 : 1.0)
                  : AppColorsLight.surface1.withOpacity(tier.isGlassSurfacesEnabled ? 0.9 : 1.0),
              borderRadius: BorderRadius.circular(AppRadius.full),
              border: Border.all(
                color: isDark ? AppColorsDark.glassBorder : AppColorsLight.glassBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 32,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Row(
              children: List.generate(_tabs.length, (i) {
                final tab = _tabs[i];
                final isActive = currentIndex == i;
                return Expanded(
                  child: _NavTab(
                    icon: isActive ? tab.filled : tab.icon,
                    label: tab.en,
                    hindiLabel: tab.hi,
                    isActive: isActive,
                    showLabel: isActive || showAllLabels,
                    showGlow: tier.hasAdvancedGlow,
                    onTap: () => onTap(i),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final String hindiLabel;
  final bool isActive;
  final bool showLabel;
  final bool showGlow;
  final VoidCallback onTap;

  const _NavTab({
    required this.icon,
    required this.label,
    required this.hindiLabel,
    required this.isActive,
    required this.showLabel,
    required this.showGlow,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final inactiveColor = isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? activeColor : inactiveColor,
            size: 24,
            shadows: isActive && showGlow
                ? [Shadow(color: activeColor.withOpacity(0.5), blurRadius: 10)]
                : null,
          ),
          if (showLabel) ...[
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTypography.labelMd(
                color: isActive ? activeColor : inactiveColor,
              ).copyWith(fontSize: 10, fontWeight: isActive ? FontWeight.w600 : FontWeight.w400),
            ),
            if (isActive)
              Text(
                hindiLabel,
                style: AppTypography.hindi(
                  color: isActive ? activeColor : inactiveColor,
                ).copyWith(fontSize: 9),
              ),
          ],
        ],
      ),
    );
  }
}
