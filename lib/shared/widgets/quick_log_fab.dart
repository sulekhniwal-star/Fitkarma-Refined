import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class QuickLogFAB extends StatelessWidget {
  final VoidCallback onLogFood;
  final VoidCallback onLogWater;
  final VoidCallback onLogMood;
  final VoidCallback onLogWorkout;
  final VoidCallback onLogBP;
  final VoidCallback onLogGlucose;

  const QuickLogFAB({
    super.key,
    required this.onLogFood,
    required this.onLogWater,
    required this.onLogMood,
    required this.onLogWorkout,
    required this.onLogBP,
    required this.onLogGlucose,
  });

  @override
  Widget build(BuildContext context) {

    return SpeedDial(
      icon: Icons.add_rounded,
      activeIcon: Icons.close_rounded,
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      spacing: 12,
      spaceBetweenChildren: 8,
      buttonSize: const Size(60, 60),
      childrenButtonSize: const Size(54, 54),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        _buildDialChild(
          label: 'Food',
          icon: Icons.restaurant_rounded,
          color: AppColors.primary,
          onTap: onLogFood,
        ),
        _buildDialChild(
          label: 'Water',
          icon: Icons.water_drop_rounded,
          color: Colors.blue,
          onTap: onLogWater,
        ),
        _buildDialChild(
          label: 'Mood',
          icon: Icons.mood_rounded,
          color: AppColors.teal,
          onTap: onLogMood,
        ),
        _buildDialChild(
          label: 'Workout',
          icon: Icons.fitness_center_rounded,
          color: AppColors.success,
          onTap: onLogWorkout,
        ),
        _buildDialChild(
          label: 'BP',
          icon: Icons.favorite_rounded,
          color: AppColors.rose,
          onTap: onLogBP,
        ),
        _buildDialChild(
          label: 'Glucose',
          icon: Icons.opacity_rounded,
          color: AppColors.purple,
          onTap: onLogGlucose,
        ),
      ],
    );
  }

  SpeedDialChild _buildDialChild({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SpeedDialChild(
      child: Icon(icon, color: Colors.white, size: 24),
      backgroundColor: color,
      label: label,
      labelStyle: AppTextStyles.labelLarge.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      labelBackgroundColor: Colors.white,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }
}
