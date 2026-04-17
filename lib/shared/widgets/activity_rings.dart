import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

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
class ActivityRingsWidget extends StatelessWidget {
  final List<RingData> rings;
  final double strokeWidth;
  final double gap;

  const ActivityRingsWidget({
    super.key,
    required this.rings,
    this.strokeWidth = 10.0,
    this.gap = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final trackColor = isDark ? AppColorsDark.divider : AppColors.divider;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 200,
          height: 200,
          child: CustomPaint(
            painter: _RingsPainter(
              rings: rings,
              strokeWidth: strokeWidth,
              gap: gap,
              trackColor: trackColor,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: rings.map((ring) => _StatItem(ring: ring)).toList(),
        ),
      ],
    );
  }
}

class _RingsPainter extends CustomPainter {
  final List<RingData> rings;
  final double strokeWidth;
  final double gap;
  final Color trackColor;

  _RingsPainter({
    required this.rings,
    required this.strokeWidth,
    required this.gap,
    required this.trackColor,
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

      // Ensure we don't exceed 360 degrees, but allow subtle overflow visually?
      // Usually rings represent 0 to 100%, but some designers like them to wrap.
      // Here we cap at 0.999 to show the round cap properly at 100%.
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
           oldDelegate.trackColor != trackColor;
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
            const SizedBox(width: 4),
            Text(
              ring.label,
              style: AppTextStyles.caption(isDark),
            ),
          ],
        ),
        Text(
          '${ring.value}/${ring.goal}',
          style: AppTextStyles.labelMedium(isDark),
        ),
      ],
    );
  }
}

