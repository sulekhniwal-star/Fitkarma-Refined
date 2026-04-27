import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/device_tier.dart';

class ActivityRingsWidget extends ConsumerWidget {
  final List<double> values; // 0.0 to 1.0
  final List<Color> colors;
  final Widget? center;

  const ActivityRingsWidget({
    super.key,
    required this.values,
    required this.colors,
    this.center,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tierAsync = ref.watch(deviceTierProvider);
    final tier = tierAsync.asData?.value ?? DeviceTier.mid;

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: _RingsPainter(
              values: values,
              colors: colors,
              showGlow: tier != DeviceTier.low,
            ),
          ),
          if (center != null) center!,
        ],
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;
  final bool showGlow;

  _RingsPainter({
    required this.values,
    required this.colors,
    required this.showGlow,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = min(size.width, size.height) / 2;
    const strokeWidth = 14.0;
    const spacing = 4.0;

    for (int i = 0; i < values.length; i++) {
      final radius = maxRadius - (i * (strokeWidth + spacing)) - strokeWidth / 2;
      final rect = Rect.fromCircle(center: center, radius: radius);
      
      // Background track
      final trackPaint = Paint()
        ..color = colors[i].withOpacity(0.1)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      
      canvas.drawCircle(center, radius, trackPaint);

      // Value arc
      final valuePaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      if (showGlow) {
        valuePaint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);
      }

      canvas.drawArc(
        rect,
        -pi / 2,
        2 * pi * values[i].clamp(0.0, 1.0),
        false,
        valuePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter oldDelegate) => 
      oldDelegate.values != values || oldDelegate.showGlow != showGlow;
}
