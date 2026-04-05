import 'package:flutter/material.dart';

enum FastingType { nirjala, phalahar, roza, feast, sattvic }

class FestivalDietBadge extends StatelessWidget {
  final FastingType type;

  const FestivalDietBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color color;
    String label;
    IconData icon;

    switch (type) {
      case FastingType.nirjala:
        color = Colors.blue;
        label = 'Nirjala';
        icon = Icons.water_drop;
        break;
      case FastingType.phalahar:
        color = Colors.green;
        label = 'Phalahar';
        icon = Icons.apple;
        break;
      case FastingType.roza:
        color = Colors.purple;
        label = 'Roza';
        icon = Icons.mosque;
        break;
      case FastingType.feast:
        color = Colors.orange;
        label = 'Feast';
        icon = Icons.celebration;
        break;
      case FastingType.sattvic:
        color = Colors.teal;
        label = 'Sattvic';
        icon = Icons.spa;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}