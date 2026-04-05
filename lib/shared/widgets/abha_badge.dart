import 'package:flutter/material.dart';

class AbhaBadge extends StatelessWidget {
  final bool isLinked;
  final String? abhaNumber;
  final VoidCallback? onTap;

  const AbhaBadge({
    super.key,
    required this.isLinked,
    this.abhaNumber,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isLinked
              ? Colors.green.withValues(alpha: 0.1)
              : Colors.amber.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isLinked ? Colors.green : Colors.amber,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLinked ? Icons.verified : Icons.link_off,
              size: 18,
              color: isLinked ? Colors.green : Colors.amber,
            ),
            const SizedBox(width: 6),
            Text(
              isLinked ? 'ABHA Linked' : 'ABHA Unlinked',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isLinked ? Colors.green.shade700 : Colors.amber.shade700,
              ),
            ),
            if (isLinked && abhaNumber != null) ...[
              const SizedBox(width: 8),
              Text(
                abhaNumber!,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.green.shade600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}