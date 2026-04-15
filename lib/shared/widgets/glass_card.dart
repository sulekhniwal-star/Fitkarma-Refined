import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/device_tier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlassCard extends ConsumerWidget {
  final Widget child;
  final double? width;
  final double? height;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double blur;
  final double opacity;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius = AppTheme.radiusLg,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.color,
    this.blur = 12.0,
    this.opacity = 0.06,
    this.border,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Low tier fallback: solid color instead of blur
    if (tier == DeviceTier.low) {
      return Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? (isDark ? AppTheme.surface1 : AppTheme.lSurface1),
          borderRadius: BorderRadius.circular(borderRadius),
          border: border ?? Border.all(
            color: isDark ? AppTheme.divider : AppTheme.lDivider,
          ),
        ),
        child: child,
      );
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: tier == DeviceTier.high ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: color ?? (isDark 
                ? AppTheme.textPrimary.withOpacity(opacity) 
                : AppTheme.lGlass),
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ?? Border.all(
                color: isDark ? AppTheme.glassBorder : AppTheme.lGlassBorder,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
