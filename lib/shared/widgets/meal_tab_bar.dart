import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MealTypeTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController? controller;
  final ValueChanged<int>? onTap;

  const MealTypeTabBar({
    super.key,
    this.controller,
    this.onTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : AppColors.surface,
        border: Border(
          bottom: BorderSide(
            color: isDarkMode ? AppColors.darkDivider : AppColors.divider,
            width: 1,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        onTap: onTap,
        indicatorColor: AppColors.primary,
        indicatorWeight: 3,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.textSecondary,
        labelPadding: EdgeInsets.zero,
        tabs: [
          _MealTab(icon: Icons.breakfast_dining_rounded, en: 'Breakfast', hi: 'नाश्ता'),
          _MealTab(icon: Icons.lunch_dining_rounded, en: 'Lunch', hi: 'दोपहर का भोजन'),
          _MealTab(icon: Icons.dinner_dining_rounded, en: 'Dinner', hi: 'रात का भोजन'),
          _MealTab(icon: Icons.fastfood_rounded, en: 'Snacks', hi: 'नाश्ता'),
        ],
      ),
    );
  }
}

class _MealTab extends StatelessWidget {
  final IconData icon;
  final String en;
  final String hi;

  const _MealTab({required this.icon, required this.en, required this.hi});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(height: 4),
          Text(
            en,
            style: AppTextStyles.labelMedium.copyWith(fontSize: 12),
          ),
          Text(
            hi,
            style: AppTextStyles.sectionHeaderHindi.copyWith(fontSize: 9),
          ),
        ],
      ),
    );
  }
}
