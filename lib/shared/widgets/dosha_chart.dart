import 'package:flutter/material.dart';
import 'dart:math' as math;

/// Three-segment donut chart for Vata / Pitta / Kapha dosha.
/// Uses [CustomPainter] — no fl_chart dependency needed.
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
    this.size = 180,
  });

  @override
  Widget build(BuildContext context) {
    final total = vata + pitta + kapha;
    if (total == 0) return const SizedBox.shrink();

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _DonutPainter(
          vata: vata / total,
          pitta: pitta / total,
          kapha: kapha / total,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _dominant,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'dominant',
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String get _dominant {
    if (vata >= pitta && vata >= kapha) return 'Vata';
    if (pitta >= vata && pitta >= kapha) return 'Pitta';
    return 'Kapha';
  }
}

class _DonutPainter extends CustomPainter {
  final double vata;
  final double pitta;
  final double kapha;

  static const _vataColor = Color(0xFF81D4FA); // sky blue
  static const _pittaColor = Color(0xFFFF8A65); // coral
  static const _kaphaColor = Color(0xFFAED581); // light green

  _DonutPainter({
    required this.vata,
    required this.pitta,
    required this.kapha,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const strokeWidth = 28.0;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    var startAngle = -math.pi / 2;

    // Vata
    if (vata > 0) {
      paint.color = _vataColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        2 * math.pi * vata,
        false,
        paint,
      );
      startAngle += 2 * math.pi * vata;
    }

    // Pitta
    if (pitta > 0) {
      paint.color = _pittaColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        2 * math.pi * pitta,
        false,
        paint,
      );
      startAngle += 2 * math.pi * pitta;
    }

    // Kapha
    if (kapha > 0) {
      paint.color = _kaphaColor;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
        startAngle,
        2 * math.pi * kapha,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) =>
      old.vata != vata || old.pitta != pitta || old.kapha != kapha;
}

/// Legend row beneath the dosha chart.
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
    if (total == 0) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _dotLabel(const Color(0xFF81D4FA), 'Vata ${((vata / total) * 100).toStringAsFixed(0)}%'),
        const SizedBox(width: 16),
        _dotLabel(const Color(0xFFFF8A65), 'Pitta ${((pitta / total) * 100).toStringAsFixed(0)}%'),
        const SizedBox(width: 16),
        _dotLabel(const Color(0xFFAED581), 'Kapha ${((kapha / total) * 100).toStringAsFixed(0)}%'),
      ],
    );
  }

  Widget _dotLabel(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}
