import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class DoshaChart extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;
  final double size;

  const DoshaChart({
    super.key,
    required this.vata,
    required this.pitta,
    required this.kapha,
    this.size = 140,
  });

  @override
  Widget build(BuildContext context) {
    final total = vata + pitta + kapha;
    if (total == 0) return const SizedBox.shrink();

    final vataPct = vata / total;
    final pittaPct = pitta / total;
    final kaphaPct = kapha / total;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(
          segments: [
            _Segment(vataPct, const Color(0xFF74B9FF)), // air
            _Segment(pittaPct, const Color(0xFFE17055)), // fire
            _Segment(kaphaPct, const Color(0xFF00B894)), // earth
          ],
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dosha',
                style: AppTextStyles.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DoshaLegend extends StatelessWidget {
  final double vata;
  final double pitta;
  final double kapha;

  const DoshaLegend({
    super.key,
    required this.vata,
    required this.pitta,
    required this.kapha,
  });

  @override
  Widget build(BuildContext context) {
    final total = vata + pitta + kapha;
    final items = [
      ('Vata', vata, const Color(0xFF74B9FF)),
      ('Pitta', pitta, const Color(0xFFE17055)),
      ('Kapha', kapha, const Color(0xFF00B894)),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: items.map((item) {
        final pct = total > 0 ? (item.$2 / total * 100).round() : 0;
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: item.$3,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '${item.$1} $pct%',
              style: AppTextStyles.labelSmall,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class _Segment {
  final double pct;
  final Color color;
  _Segment(this.pct, this.color);
}

class _DonutPainter extends CustomPainter {
  final List<_Segment> segments;
  _DonutPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = radius * 0.28;
    var startAngle = -math.pi / 2;

    for (final seg in segments) {
      if (seg.pct <= 0) continue;
      final sweep = 2 * math.pi * seg.pct;
      final paint = Paint()
        ..color = seg.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        sweep,
        false,
        paint,
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) => true;
}
