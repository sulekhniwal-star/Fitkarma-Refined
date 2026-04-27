import 'package:flutter/material.dart';

class ABHALinkBadge extends StatelessWidget {
  final bool isLinked;
  final bool compact;

  const ABHALinkBadge({
    super.key,
    required this.isLinked,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLinked ? Colors.green : Colors.orange;
    final icon = isLinked ? Icons.verified : Icons.warning_amber_rounded;
    final label = isLinked ? 'ABHA LINKED' : 'ABHA NOT LINKED';

    if (compact) {
      return Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 14),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class FestivalDietBadge extends StatelessWidget {
  final String type; // Nirjala, Phalahar, Roza, Feast

  const FestivalDietBadge({
    super.key,
    required this.type,
  });

  Color _getColor() {
    switch (type.toLowerCase()) {
      case 'nirjala': return Colors.red;
      case 'phalahar': return Colors.green;
      case 'roza': return Colors.purple;
      case 'feast': return Colors.orange;
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        type.toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
      ),
    );
  }
}
