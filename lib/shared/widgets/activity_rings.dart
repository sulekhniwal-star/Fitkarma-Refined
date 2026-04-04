import 'dart:math' as math;
import 'package:flutter/material.dart';

class ActivityRingsWidget extends StatelessWidget {
  final List<ActivityRingData> rings;
  final double size;
  final double strokeWidth;
  final double spacing;

  const ActivityRingsWidget({
    super.key,
    required this.rings,
    this.size = 200,
    this.strokeWidth = 16,
    this.spacing = 4,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < rings.length; i++)
            _ActivityRing(
              progress: rings[i].progress,
              color: rings[i].color,
              radius: (size / 2) - (i * (strokeWidth + spacing)) - (strokeWidth / 2),
              strokeWidth: strokeWidth,
            ),
          const Icon(Icons.flash_on, color: Colors.orange, size: 24),
        ],
      ),
    );
  }
}

class ActivityRingData {
  final double progress;
  final Color color;

  const ActivityRingData({
    required this.progress,
    required this.color,
  });
}

class _ActivityRing extends StatelessWidget {
  final double progress;
  final Color color;
  final double radius;
  final double strokeWidth;

  const _ActivityRing({
    required this.progress,
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: _RingPainter(
        progress: progress,
        color: color,
        radius: radius,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double radius;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.radius,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    
    // Background track
    final trackPaint = Paint()
      ..color = color.withOpacity(0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
      
    canvas.drawCircle(center, radius, trackPaint);
    
    // Progress arc
    final progressPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
      
    final rect = Rect.fromCircle(center: center, radius: radius);
    
    // Start from top (-90 degrees)
    canvas.drawArc(
      rect, 
      -math.pi / 2, 
      2 * math.pi * progress.clamp(0.0, 1.0), 
      false, 
      progressPaint
    );

    // If progress > 1.0, draw a slight glow or indicator of over-achievement
    if (progress > 1.0) {
       final overAchievementPaint = Paint()
      ..color = Colors.white.withOpacity(0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
      
       canvas.drawArc(
        rect, 
        -math.pi / 2, 
        2 * math.pi, 
        false, 
        overAchievementPaint
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return oldDelegate.progress != progress || oldDelegate.color != color;
  }
}
