// lib/shared/widgets/glass_card.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/config/device_tier.dart';
import '../../core/providers/device_tier_provider.dart';

class GlassCard extends ConsumerWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? glowColor;       // null = no glow
  final Color? borderColor;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.borderRadius = AppRadius.md,
    this.glowColor,
    this.borderColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final useBlur = tier.hasBlur;
    final bgColor = isDark
        ? (useBlur ? AppColorsDark.glass : AppColorsDark.surface1)
        : (useBlur ? AppColorsLight.glass : AppColorsLight.surface1);
    final border = borderColor ??
        (isDark ? AppColorsDark.glassBorder : AppColorsLight.glassBorder);

    final boxDecoration = BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: border, width: 1),
      boxShadow: glowColor != null && isDark && tier.hasAdvancedGlow
          ? [BoxShadow(color: glowColor!, blurRadius: 24, spreadRadius: -4)]
          : null,
    );

    Widget content = Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: boxDecoration,
      child: child,
    );

    if (onTap != null) {
      content = GestureDetector(
        onTap: onTap,
        child: content,
      );
    }

    if (!useBlur) return content;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: tier.blurRadius, sigmaY: tier.blurRadius),
        child: content,
      ),
    );
  }
}
