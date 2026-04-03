import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Breakfast / Lunch / Dinner / Snacks tab bar.
class MealTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const MealTabBar({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  static const meals = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];
  static const mealsHi = ['नाश्ता', 'दोपहर का खाना', 'रात का खाना', 'स्नैक्स'];
  static const icons = [
    Icons.wb_sunny_outlined,
    Icons.lunch_dining,
    Icons.nights_stay_outlined,
    Icons.cookie_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        children: List.generate(meals.length, (i) {
          final isSelected = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primary.withOpacity(0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icons[i],
                      size: 20,
                      color:
                          isSelected ? AppColors.primary : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      meals[i],
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isSelected ? AppColors.primary : null,
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                      ),
                    ),
                    Text(
                      mealsHi[i],
                      style: AppTextStyles.labelSmall.copyWith(
                        fontSize: 9,
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.7)
                            : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
