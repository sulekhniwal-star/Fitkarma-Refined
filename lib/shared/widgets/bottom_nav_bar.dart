import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_theme.dart';

/// Model representing a single item in the bottom navigation bar.
class BottomNavItem {
  final IconData outlinedIcon;
  final IconData filledIcon;
  final String labelEn;
  final String labelHi;

  const BottomNavItem({
    required this.outlinedIcon,
    required this.filledIcon,
    required this.labelEn,
    required this.labelHi,
  });
}

/// A custom bilingual bottom navigation bar for FitKarma with a center notch.
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
      labelHi: 'होम',
    ),
    BottomNavItem(
      outlinedIcon: Icons.restaurant_outlined,
      filledIcon: Icons.restaurant,
      labelEn: 'Food',
      labelHi: 'खाना',
    ),
    BottomNavItem(
      outlinedIcon: Icons.directions_walk_outlined,
      filledIcon: Icons.directions_walk,
      labelEn: 'Activity',
      labelHi: 'एक्टिविटी',
    ),
    BottomNavItem(
      outlinedIcon: Icons.person_outline,
      filledIcon: Icons.person,
      labelEn: 'Profile',
      labelHi: 'प्रोफाइल',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BottomAppBar(
      height: 80,
      padding: EdgeInsets.zero,
      color: isDark ? AppTheme.bg1 : AppTheme.lBg1,
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavBarItem(
            item: items[0],
            isSelected: currentIndex == 0,
            onTap: () => _handleTap(0),
            isDark: isDark,
          ),
          _NavBarItem(
            item: items[1],
            isSelected: currentIndex == 1,
            onTap: () => _handleTap(1),
            isDark: isDark,
          ),
          const SizedBox(width: 48), // Notch space
          _NavBarItem(
            item: items[2],
            isSelected: currentIndex == 2,
            onTap: () => _handleTap(2),
            isDark: isDark,
          ),
          _NavBarItem(
            item: items[3],
            isSelected: currentIndex == 3,
            onTap: () => _handleTap(3),
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  void _handleTap(int index) {
    HapticFeedback.lightImpact();
    onTap(index);
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
    final activeColor = isDark ? AppTheme.primary : AppTheme.lPrimary;
    final inactiveColor = isDark ? AppTheme.textMuted : AppTheme.lTextSecondary;
    
    return Expanded(
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                // Subtle Neutral Glow
                if (isSelected)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 44,
                    height: 28,
                    decoration: BoxDecoration(
                      color: activeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: activeColor.withValues(alpha: 0.2),
                          blurRadius: 10,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                  ),
                Icon(
                  isSelected ? item.filledIcon : item.outlinedIcon,
                  color: isSelected ? activeColor : inactiveColor,
                  size: 24,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              item.labelEn.toUpperCase(),
              style: AppTheme.labelMd(context).copyWith(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? activeColor : inactiveColor,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              item.labelHi,
              style: AppTheme.hindi(context).copyWith(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? activeColor.withValues(alpha: 0.9) : inactiveColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

