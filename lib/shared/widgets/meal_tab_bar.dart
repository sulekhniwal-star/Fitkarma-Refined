import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

enum MealType { breakfast, lunch, dinner, snack }

/// A custom tab bar for selecting meal types with bilingual labels and icons.
class MealTabBar extends StatelessWidget {
  final MealType selected;
  final ValueChanged<MealType> onChanged;

  const MealTabBar({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: MealType.values.map((type) {
          final isSelected = selected == type;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _MealTabPill(
              type: type,
              isSelected: isSelected,
              onTap: () => onChanged(type),
              isDark: isDark,
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MealTabPill extends StatelessWidget {
  final MealType type;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _MealTabPill({
    required this.type,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor = isDark ? AppColorsDark.primary : AppColorsLight.primary;
    final surfaceColor = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : surfaceColor,
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? null : Border.all(color: primaryColor.withValues(alpha: 0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_getIcon(type), style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _getNameEn(type),
                  style: (isDark ? AppTypography.labelLg() : AppTypography.labelLg(color: AppColorsLight.textPrimary)).copyWith(
                    color: isSelected ? Colors.white : primaryColor,
                    fontSize: 12,
                    height: 1.1,
                  ),
                ),
                Text(
                  _getNameHi(type),
                  style: AppTypography.hindi(color: isSelected ? Colors.white70 : (isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted)).copyWith(
                    fontSize: 10,
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getIcon(MealType type) {
    switch (type) {
      case MealType.breakfast: return '🌅';
      case MealType.lunch: return '☀️';
      case MealType.dinner: return '🌙';
      case MealType.snack: return '🍎';
    }
  }

  String _getNameEn(MealType type) {
    switch (type) {
      case MealType.breakfast: return 'Breakfast';
      case MealType.lunch: return 'Lunch';
      case MealType.dinner: return 'Dinner';
      case MealType.snack: return 'Snacks';
    }
  }

  String _getNameHi(MealType type) {
    switch (type) {
      case MealType.breakfast: return 'नाश्ता';
      case MealType.lunch: return 'दोपहर का भोजन';
      case MealType.dinner: return 'रात का खाना';
      case MealType.snack: return 'नाश्ता';
    }
  }
}

