import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CorrelationInsightCard extends StatelessWidget {
  final String title;
  final String insight;
  final List<CorrelationModule> modules;
  final VoidCallback? onDismiss;

  const CorrelationInsightCard({
    super.key,
    required this.title,
    required this.insight,
    required this.modules,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Card(
      elevation: 0,
      color: isDarkMode ? AppColors.darkSecondarySurface : AppColors.secondarySurface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.secondary.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                ),
                if (onDismiss != null)
                  IconButton(
                    onPressed: onDismiss,
                    icon: const Icon(Icons.close, size: 18),
                    color: AppColors.secondary.withOpacity(0.5),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              insight,
              style: AppTextStyles.bodyMedium.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: modules.map((module) => _ModulePill(module: module)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class CorrelationModule {
  final String label;
  final IconData icon;
  final Color color;

  CorrelationModule({
    required this.label,
    required this.icon,
    required this.color,
  });

  // Common preset modules
  factory CorrelationModule.food() => CorrelationModule(label: 'Nutrition', icon: Icons.restaurant_rounded, color: AppColors.primary);
  factory CorrelationModule.steps() => CorrelationModule(label: 'Activity', icon: Icons.directions_walk_rounded, color: AppColors.success);
  factory CorrelationModule.sleep() => CorrelationModule(label: 'Sleep', icon: Icons.bedtime_rounded, color: AppColors.purple);
  factory CorrelationModule.mood() => CorrelationModule(label: 'Mood', icon: Icons.mood_rounded, color: AppColors.teal);
}

class _ModulePill extends StatelessWidget {
  final CorrelationModule module;

  const _ModulePill({required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: module.color.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(module.icon, size: 14, color: module.color),
          const SizedBox(width: 6),
          Text(
            module.label,
            style: AppTextStyles.labelMedium.copyWith(
              color: module.color,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
