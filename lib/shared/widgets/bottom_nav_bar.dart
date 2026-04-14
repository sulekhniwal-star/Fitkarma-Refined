import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'sync_status_banner.dart';

/// Model representing a single item in the bottom navigation bar.
class BottomNavItem {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String labelEn;
  final String labelHi;
  final String route;

  const BottomNavItem({
    required this.outlinedIcon,
    required this.filledIcon,
    required this.labelEn,
    required this.labelHi,
    required this.route,
  });
}

/// A custom bilingual bottom navigation bar for FitKarma.
/// 
/// Displays 5 tabs with English and Hindi labels, status indicators, 
/// and integrates with the SyncStatusBanner.
class FitKarmaBottomNav extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FitKarmaBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<BottomNavItem> items = [
    BottomNavItem(
      outlinedIcon: Icons.home_outlined,
      filledIcon: Icons.home,
      labelEn: 'Home',
      labelHi: 'मुख्यपृष्ठ',
      route: '/home/dashboard',
    ),
    BottomNavItem(
      outlinedIcon: Icons.restaurant_outlined,
      filledIcon: Icons.restaurant,
      labelEn: 'Food',
      labelHi: 'खाना',
      route: '/home/food',
    ),
    BottomNavItem(
      outlinedIcon: Icons.fitness_center_outlined,
      filledIcon: Icons.fitness_center,
      labelEn: 'Workout',
      labelHi: 'वर्कआउट',
      route: '/home/workout',
    ),
    BottomNavItem(
      outlinedIcon: Icons.directions_walk_outlined,
      filledIcon: Icons.directions_walk,
      labelEn: 'Steps',
      labelHi: 'कदम',
      route: '/home/steps',
    ),
    BottomNavItem(
      outlinedIcon: Icons.person_outline,
      filledIcon: Icons.person,
      labelEn: 'Me',
      labelHi: 'मैं',
      route: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF1E1E2C) : AppColors.surface;
    
    // In a real app, this would come from a proper sync service provider
    // For now, we use a placeholder that satisfies the SyncStatusBanner requirement
    const dlqCount = 0;
    const isOffline = false;
    const isLowDataMode = false;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Global Sync Status Banner
        SyncStatusBanner(
          dlqCount: dlqCount,
          isOffline: isOffline,
          isLowDataMode: isLowDataMode,
        ),
        
        // Navigation Bar
        Material(
          elevation: 8,
          color: backgroundColor,
          child: SafeArea(
            top: false,
            child: Container(
              height: 72,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(items.length, (index) {
                  return _NavBarItem(
                    item: items[index],
                    isSelected: currentIndex == index,
                    onTap: () => onTap(index),
                    isDark: isDark,
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = isDark ? AppColorsDark.primary : AppColors.primary;
    final inactiveColor = isDark ? AppColorsDark.textMuted : AppColors.textMuted;
    final color = isSelected ? activeColor : inactiveColor;

    return InkWell(
      onTap: onTap,
      splashColor: activeColor.withValues(alpha: 0.1),
      highlightColor: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? item.filledIcon : item.outlinedIcon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              item.labelEn,
              style: AppTextStyles.navLabelEn(isDark).copyWith(
                color: color,
              ),
            ),
            Text(
              item.labelHi,
              style: AppTextStyles.navLabelHi(isDark).copyWith(
                color: isSelected ? activeColor.withValues(alpha: 0.8) : inactiveColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
