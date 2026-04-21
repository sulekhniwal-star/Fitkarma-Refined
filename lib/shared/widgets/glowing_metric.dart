import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/device_tier.dart';

class GlowingMetric extends ConsumerWidget {
  final String value;
  final String? unit;
  final Color color;
  final bool animate;

  const GlowingMetric({
    super.key,
    required this.value,
    this.unit,
    this.color = AppTheme.primary,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // 1. Double depth glow (§8)
        if (tier.hasAdvancedGlow) ...[
          _buildGlow(color.withValues(alpha: 0.15), 40, -10),
          _buildGlow(color.withValues(alpha: 0.25), 15, -5),
        ] else if (tier.hasAmbientGlow) ...[
          _buildGlow(color.withValues(alpha: 0.2), 25, -5),
        ],

        // 2. The Text
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTheme.metricXL(context).copyWith(
                color: AppTheme.textPrimary,
                shadows: tier.hasAmbientGlow 
                  ? [Shadow(color: color.withValues(alpha: 0.5), blurRadius: 12)] 
                  : null,
              ),
            ),
            if (unit != null) ...[
              const SizedBox(width: 4),
              Text(
                unit!,
                style: AppTheme.monoLg(context).copyWith(
                  color: AppTheme.textSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildGlow(Color color, double blur, double spread) {
    return Container(
      width: 60,
      height: 30,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: color,
            blurRadius: blur,
            spreadRadius: spread,
          ),
        ],
      ),
    );
  }
}
