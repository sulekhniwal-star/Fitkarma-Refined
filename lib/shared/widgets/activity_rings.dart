import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Four concentric activity rings (orange, green, teal, purple).
class ActivityRings extends StatelessWidget {
  final double stepsProgress; // 0..1
  final double caloriesProgress;
  final double sleepProgress;
  final double moodProgress;
  final double size;

  const ActivityRings({
    super.key,
    required this.stepsProgress,
    required this.caloriesProgress,
    required this.sleepProgress,
    required this.moodProgress,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _RingsPainter(
          steps: stepsProgress.clamp(0, 1),
          calories: caloriesProgress.clamp(0, 1),
          sleep: sleepProgress.clamp(0, 1),
          mood: moodProgress.clamp(0, 1),
        ),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  final double steps;
  final double calories;
  final double sleep;
  final double mood;

  static const _colors = [
    Color(0xFFFF9500), // orange  — steps
    Color(0xFF2ECC71), // green   — calories
    Color(0xFF1ABC9C), // teal    — sleep
    Color(0xFF9B59B6), // purple  — mood
  ];

  _RingsPainter({
    required this.steps,
    required this.calories,
    required this.sleep,
    required this.mood,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    const ringWidth = 14.0;
    const gap = 4.0;
    const startAngle = -math.pi / 2;

    final progresses = [steps, calories, sleep, mood];

    for (int i = 0; i < 4; i++) {
      final radius = maxRadius - (i * (ringWidth + gap));
      final progress = progresses[i];

      // Background ring
      final bgPaint = Paint()
        ..color = _colors[i].withOpacity(0.15)
        ..style = PaintingStyle.stroke
        ..strokeWidth = ringWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawCircle(center, radius, bgPaint);

      // Progress arc
      if (progress > 0) {
        final fgPaint = Paint()
          ..color = _colors[i]
          ..style = PaintingStyle.stroke
          ..strokeWidth = ringWidth
          ..strokeCap = StrokeCap.round;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          2 * math.pi * progress,
          false,
          fgPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter old) =>
      old.steps != steps ||
      old.calories != calories ||
      old.sleep != sleep ||
      old.mood != mood;
}
