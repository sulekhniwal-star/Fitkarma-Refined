import 'package:flutter/material.dart';

class ABHALinkBadge extends StatelessWidget {
  final bool isLinked;
  final bool isLarge;

  const ABHALinkBadge({
    super.key,
    required this.isLinked,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLarge) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isLinked ? Colors.green.shade50 : Colors.blue.shade50,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: isLinked ? Colors.green : Colors.blue, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLinked ? Icons.verified_user : Icons.health_and_safety,
              color: isLinked ? Colors.green : Colors.blue,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              isLinked ? 'ABHA LINKED' : 'ABHA NOT LINKED',
              style: TextStyle(
                color: isLinked ? Colors.green.shade800 : Colors.blue.shade800,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isLinked ? Colors.green.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isLinked ? Colors.green : Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isLinked ? Icons.check_circle : Icons.add_circle_outline,
            size: 14,
            color: isLinked ? Colors.green : Colors.grey,
          ),
          const SizedBox(width: 4),
          Text(
            isLinked ? 'ABHA Linked' : 'Link ABHA',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: isLinked ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

