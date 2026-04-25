import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/config/device_tier.dart';
import '../../core/providers/device_tier_provider.dart';

/// Data model for a single activity ring.
class RingData {
  final double progress; // 0.0 to 1.0
  final Color color;
  final String label;
  final String value;
  final String goal;

  const RingData({
    required this.progress,
    required this.color,
    required this.label,
    required this.value,
    required this.goal,
  });
}

/// A custom-painted concentric activity rings widget.
/// 
/// Renders up to four rings (Calories, Steps, Water, Active Minutes) with 
/// individual progress indicators and stat labels.
class ActivityRingsWidget extends ConsumerWidget {
  final List<RingData> rings;
  final double strokeWidth;
  final double gap;
  final bool showLabels;

  const ActivityRingsWidget({
    super.key,
    required this.rings,
    this.strokeWidth = 12.0,
    this.gap = 12.0,
    this.showLabels = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark ? AppColorsDark.divider : AppColorsLight.divider;
    final tier = ref.watch(deviceTierProvider);

    // Primary metric (outermost ring)
    final primaryRing = rings.isNotEmpty ? rings.first : null;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 240,
          height: 240,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Center Metric (§2.25)
              if (primaryRing != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      primaryRing.value,
                      style: AppTypography.metricLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary),
                    ),
                    Text(
                      primaryRing.label.toUpperCase(),
                      style: AppTypography.caption(color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted).copyWith(
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              
              // The Rings
              CustomPaint(
                size: const Size(240, 240),
                painter: _RingsPainter(
                  rings: rings,
                  strokeWidth: strokeWidth,
                  gap: gap,
                  trackColor: trackColor,
                  tier: tier,
                ),
              ),
            ],
          ),
        ),
        if (showLabels) ...[
          const SizedBox(height: 32),
          Wrap(
            spacing: 20,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: rings.skip(1).map((ring) => _StatItem(ring: ring)).toList(),
          ),
        ],
      ],
    );
  }
}

class _RingsPainter extends CustomPainter {
  final List<RingData> rings;
  final double strokeWidth;
  final double gap;
  final Color trackColor;
  final DeviceTier tier;

  _RingsPainter({
    required this.rings,
    required this.strokeWidth,
    required this.gap,
    required this.trackColor,
    required this.tier,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = (min(size.width, size.height) / 2) - (strokeWidth / 2);

    for (int i = 0; i < rings.length; i++) {
      final ring = rings[i];
      final radius = maxRadius - (i * (strokeWidth + gap));
      
      if (radius <= 0) break;

      final rect = Rect.fromCircle(center: center, radius: radius);

      // Draw Background Track
      final trackPaint = Paint()
        ..color = trackColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawCircle(center, radius, trackPaint);

      // Draw Progress Arc
      final progressPaint = Paint()
        ..color = ring.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      // Add Glow if tier is mid/high and it's the primary or secondary ring
      // Spec says: "glow only on primary ring (Tier: mid/high)"
      if (tier != DeviceTier.low && i == 0) {
        progressPaint.maskFilter = MaskFilter.blur(BlurStyle.normal, 8);
        canvas.drawArc(rect, -pi / 2, 2 * pi * ring.progress.clamp(0.01, 0.999), false, progressPaint);
        progressPaint.maskFilter = null; // Reset for sharp ring
      }

      final sweepAngle = 2 * pi * ring.progress.clamp(0.01, 0.999);
      
      canvas.drawArc(
        rect,
        -pi / 2, // Start from top
        sweepAngle,
        false,
        progressPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter oldDelegate) {
    return oldDelegate.rings != rings || 
           oldDelegate.trackColor != trackColor ||
           oldDelegate.tier != tier;
  }
}

class _StatItem extends StatelessWidget {
  final RingData ring;

  const _StatItem({required this.ring});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: ring.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              ring.label,
              style: AppTypography.bodySm(color: isDark ? AppColorsDark.textMuted : AppColorsLight.textMuted),
            ),
          ],
        ),
        Text(
          ring.value,
          style: AppTypography.labelLg(color: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

