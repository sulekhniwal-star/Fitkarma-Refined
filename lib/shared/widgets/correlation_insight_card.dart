import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CorrelationInsightCard extends StatelessWidget {
  final String title;
  final String insight;
  final List<ModulePill> modules;
  final VoidCallback? onTap;

  const CorrelationInsightCard({
    super.key,
    required this.title,
    required this.insight,
    required this.modules,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.5)),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: AppColors.lightShadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome_rounded,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(title, style: AppTextStyles.titleSmall),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(insight, style: AppTextStyles.bodySmall),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: modules.map((m) => _Pill(module: m)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ModulePill {
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const ModulePill({
    required this.label,
    required this.color,
    this.onTap,
  });
}

class _Pill extends StatelessWidget {
  final ModulePill module;

  const _Pill({required this.module});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: module.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: module.color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          module.label,
          style: AppTextStyles.labelSmall.copyWith(color: module.color),
        ),
      ),
    );
  }
}
