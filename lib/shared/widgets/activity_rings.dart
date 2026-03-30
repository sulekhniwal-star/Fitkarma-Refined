import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class ActivityRings extends StatelessWidget {
  final double caloriesPct;
  final double stepsPct;
  final double sleepPct;
  final double mindfulnessPct;
  final double size;

  const ActivityRings({
    super.key,
    required this.caloriesPct,
    required this.stepsPct,
    required this.sleepPct,
    required this.mindfulnessPct,
    this.size = 160,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingsPainter(
          caloriesPct: caloriesPct.clamp(0, 1),
          stepsPct: stepsPct.clamp(0, 1),
          sleepPct: sleepPct.clamp(0, 1),
          mindfulnessPct: mindfulnessPct.clamp(0, 1),
        ),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  final double caloriesPct;
  final double stepsPct;
  final double sleepPct;
  final double mindfulnessPct;

  _RingsPainter({
    required this.caloriesPct,
    required this.stepsPct,
    required this.sleepPct,
    required this.mindfulnessPct,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.08;
    final gap = strokeWidth * 0.6;

    final rings = [
      (caloriesPct, AppColors.caloriesOrange),
      (stepsPct, AppColors.weightGreen),
      (sleepPct, AppColors.waterCyan),
      (mindfulnessPct, AppColors.sleepPurple),
    ];

    for (var i = 0; i < rings.length; i++) {
      final radius = (size.width / 2) - (i * (strokeWidth + gap)) - strokeWidth / 2;
      final (pct, color) = rings[i];

      final bgPaint = Paint()
        ..color = color.withValues(alpha: 0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(center, radius, bgPaint);

      if (pct > 0) {
        final fgPaint = Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          -math.pi / 2,
          2 * math.pi * pct,
          false,
          fgPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter old) =>
      old.caloriesPct != caloriesPct ||
      old.stepsPct != stepsPct ||
      old.sleepPct != sleepPct ||
      old.mindfulnessPct != mindfulnessPct;
}
