import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ActivityRingsWidget extends StatelessWidget {
  final double caloriesProgress; // 0.0 - 1.0
  final double stepsProgress;    // 0.0 - 1.0
  final double waterProgress;    // 0.0 - 1.0
  final double minutesProgress;  // 0.0 - 1.0
  final double size;

  const ActivityRingsWidget({
    super.key,
    required this.caloriesProgress,
    required this.stepsProgress,
    required this.waterProgress,
    required this.minutesProgress,
    this.size = 200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _ActivityRingsPainter(
          caloriesProgress: caloriesProgress,
          stepsProgress: stepsProgress,
          waterProgress: waterProgress,
          minutesProgress: minutesProgress,
          isDarkMode: Theme.of(context).brightness == Brightness.dark,
        ),
      ),
    );
  }
}

class _ActivityRingsPainter extends CustomPainter {
  final double caloriesProgress;
  final double stepsProgress;
  final double waterProgress;
  final double minutesProgress;
  final bool isDarkMode;

  _ActivityRingsPainter({
    required this.caloriesProgress,
    required this.stepsProgress,
    required this.waterProgress,
    required this.minutesProgress,
    required this.isDarkMode,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = size.width * 0.08;
    final spacing = strokeWidth * 1.2;

    // Rings from outside to inside: Calories (Orange) -> Steps (Green) -> Water (Teal) -> Minutes (Purple)
    _drawRing(canvas, center, (size.width / 2) - (strokeWidth / 2), strokeWidth, AppColors.primary, caloriesProgress);
    _drawRing(canvas, center, (size.width / 2) - (strokeWidth / 2) - spacing, strokeWidth, AppColors.success, stepsProgress);
    _drawRing(canvas, center, (size.width / 2) - (strokeWidth / 2) - (spacing * 2), strokeWidth, AppColors.teal, waterProgress);
    _drawRing(canvas, center, (size.width / 2) - (strokeWidth / 2) - (spacing * 3), strokeWidth, AppColors.purple, minutesProgress);
  }

  void _drawRing(Canvas canvas, Offset center, double radius, double strokeWidth, Color color, double progress) {
    final backgroundPaint = Paint()
      ..color = isDarkMode ? color.withOpacity(0.15) : color.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background track
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress arc
    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = 2 * pi * progress.clamp(0.0, 1.0);
    
    // Start from top (-90 degrees)
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
