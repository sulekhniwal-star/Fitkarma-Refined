import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/device_tier.dart';

enum BentoSize {
  full, // Full width
  half, // 50% width
  third, // 33% width
  twoThird, // 66% width
  quarter // 25% width
}

class BentoCard extends ConsumerWidget {
  final Widget child;
  final BentoSize size;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Color? glowColor;
  final bool showBorderGlow;

  const BentoCard({
    super.key,
    required this.child,
    this.size = BentoSize.full,
    this.padding,
    this.onTap,
    this.glowColor,
    this.showBorderGlow = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;

    // Resolve Size with Auto-Promotion (§2.5)
    final resolvedSize = _resolveSize(screenWidth);

    return _buildSurface(
      context,
      tier,
      isDark,
      _getWidthFactor(resolvedSize),
      child,
    );
  }

  BentoSize _resolveSize(double screenWidth) {
    const double minCellWidth = 80.0;
    final availableWidth = screenWidth - 32; // Standard horizontal padding (§2.5)

    // Promotion logic: if current size results in width < 80dp, move to next size
    double currentWidth = availableWidth * _getWidthFactor(size);
    
    if (currentWidth < minCellWidth) {
      switch (size) {
        case BentoSize.quarter:
          return BentoSize.third;
        case BentoSize.third:
          return BentoSize.half;
        case BentoSize.half:
          return BentoSize.twoThird;
        case BentoSize.twoThird:
          return BentoSize.full;
        case BentoSize.full:
          return BentoSize.full;
      }
    }
    return size;
  }

  double _getWidthFactor(BentoSize size) {
    switch (size) {
      case BentoSize.full:
        return 1.0;
      case BentoSize.half:
        return 0.5;
      case BentoSize.third:
        return 0.33;
      case BentoSize.twoThird:
        return 0.66;
      case BentoSize.quarter:
        return 0.25;
    }
  }

  Widget _buildSurface(
    BuildContext context,
    DeviceTier tier,
    bool isDark,
    double widthFactor,
    Widget content,
  ) {
    final glassColor = isDark ? AppTheme.bg2 : AppTheme.lSurface0;
    final glassOpacity = tier.glassOpacity;
    final borderOpacity = isDark ? 0.1 : 0.08;

    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(AppTheme.radiusMd),
      decoration: BoxDecoration(
        color: glassColor.withValues(alpha: glassOpacity),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: (isDark ? Colors.white : Colors.black).withValues(alpha: borderOpacity),
          width: 0.5,
        ),
        boxShadow: showBorderGlow && tier.hasAmbientGlow
            ? [
                BoxShadow(
                  color: (glowColor ?? AppTheme.primary).withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ]
            : null,
      ),
      child: content,
    );

    if (tier.isGlassSurfacesEnabled) {
      card = ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: tier.blurRadius,
            sigmaY: tier.blurRadius,
          ),
          child: card,
        ),
      );
    }

    if (onTap != null) {
      card = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        child: card,
      );
    }

    return card;
  }
}

