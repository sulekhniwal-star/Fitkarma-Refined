import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

/// Represents a link to a specific app module within a correlation card.
class ModuleLink {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const ModuleLink({
    required this.label,
    required this.icon,
    required this.onTap,
  });
}

/// A specialized card for insights that link multiple modules (correlation analysis).
/// 
/// Features a "link" icon and tappable module pills at the bottom.
class CorrelationInsightCard extends StatelessWidget {
  final String message;
  final List<ModuleLink> modules;
  final VoidCallback onThumbsUp;
  final VoidCallback onThumbsDown;

  const CorrelationInsightCard({
    super.key,
    required this.message,
    required this.modules,
    required this.onThumbsUp,
    required this.onThumbsDown,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? AppColorsDark.secondaryMuted : AppColorsLight.secondaryMuted;
    final primaryColor = isDark ? AppColorsDark.secondary : AppColorsLight.secondary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Text('🔗', style: TextStyle(fontSize: 14)),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    message,
                    style: (isDark ? AppTypography.bodyMd() : AppTypography.bodyMd(color: AppColorsLight.textPrimary)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: modules.map((link) => _ModulePill(link: link)).toList(),
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Was this helpful?',
                  style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.thumb_up_outlined, size: 18),
                  onPressed: onThumbsUp,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.thumb_down_outlined, size: 18),
                  onPressed: onThumbsDown,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModulePill extends StatelessWidget {
  final ModuleLink link;

  const _ModulePill({required this.link});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? AppColorsDark.secondary : AppColorsLight.secondary;
    final surfaceColor = isDark ? AppColorsDark.surface0 : AppColorsLight.surface0;

    return InkWell(
      onTap: link.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: surfaceColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: primaryColor.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(link.icon, size: 14, color: primaryColor),
            const SizedBox(width: 4),
            Text(
              link.label,
              style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)).copyWith(
                color: primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

