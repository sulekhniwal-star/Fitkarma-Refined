import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/device_tier.dart';

class GlassCard extends ConsumerWidget {
  final Widget child;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final bool showGlow;
  final Color? glowColor;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius,
    this.padding,
    this.showGlow = false,
    this.glowColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tierAsync = ref.watch(deviceTierProvider);
    final tier = tierAsync.asData?.value ?? DeviceTier.mid;

    final blur = tier == DeviceTier.high ? 20.0 : (tier == DeviceTier.mid ? 10.0 : 0.0);
    final opacity = tier == DeviceTier.low ? 1.0 : 0.15;

    return Container(
      decoration: BoxDecoration(
        boxShadow: showGlow && tier != DeviceTier.low
            ? [
                BoxShadow(
                  color: (glowColor ?? Colors.orange).withOpacity(0.2),
                  blurRadius: 30,
                  spreadRadius: 5,
                )
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(opacity),
              borderRadius: BorderRadius.circular(borderRadius ?? 24),
              border: Border.all(
                color: Colors.white.withOpacity(tier == DeviceTier.low ? 0.1 : 0.2),
                width: 1.5,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
