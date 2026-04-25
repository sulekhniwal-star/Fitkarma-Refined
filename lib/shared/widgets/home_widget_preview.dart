import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class HomeWidgetPreview extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? description;
  final String? size;
  final IconData? icon;
  final VoidCallback? onAdd;

  const HomeWidgetPreview({
    super.key,
    this.child,
    this.title,
    this.description,
    this.size,
    this.icon,
    this.onAdd,
  }) : assert(child != null || (title != null && description != null && size != null && icon != null),
          'Either provide child or all of title, description, size, and icon');

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0D0D0D) : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Center(
            child: child ?? _buildDefaultContent(context),
          ),
        ),
        const SizedBox(height: 12),
        if (title != null)
          Text(
            title!,
            style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.textPrimary)).copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        if (description != null) ...[
          const SizedBox(height: 4),
          Text(
            description!,
            style: (isDark ? AppTypography.bodySm() : AppTypography.bodySm(color: AppColorsLight.textMuted)),
          ),
        ],
        if (onAdd != null) ...[
          const SizedBox(height: 12),
          TextButton.icon(
            onPressed: onAdd,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Widget'),
          ),
        ],
      ],
    );
  }

  Widget _buildDefaultContent(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 48, color: isDark ? Colors.white70 : Colors.black54),
        if (size != null) ...[
          const SizedBox(height: 8),
          Text(
            size!,
            style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)),
          ),
        ],
      ],
    );
  }
}

class ActivityRingsWidgetPreview extends StatelessWidget {
  const ActivityRingsWidgetPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E1E2C) : AppColorsLight.bg1;

    return Container(
      width: 280,
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _RingMiniStat(color: isDark ? AppColorsDark.primary : AppColorsLight.primary, label: '8.5k', icon: Icons.directions_walk),
          _RingMiniStat(color: isDark ? AppColorsDark.success : AppColorsLight.success, label: '1.2k', icon: Icons.local_fire_department),
          _RingMiniStat(color: isDark ? AppColorsDark.teal : AppColorsLight.teal, label: '4/8', icon: Icons.water_drop),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('FitKarma', style: (isDark ? AppTypography.caption() : AppTypography.caption(color: AppColorsLight.textMuted)).copyWith(fontSize: 8, fontWeight: FontWeight.bold)),
              Text('Level 12', style: (isDark ? AppTypography.labelMd() : AppTypography.labelMd(color: AppColorsLight.primary)).copyWith(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingMiniStat extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  const _RingMiniStat({required this.color, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.2), width: 3),
          ),
          child: Center(child: Icon(icon, size: 10, color: color)),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

