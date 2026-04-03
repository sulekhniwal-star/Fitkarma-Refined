import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// ABHA linked (green) / unlinked (amber) indicator badge.
class AbhaBadge extends StatelessWidget {
  final bool linked;
  final VoidCallback? onTap;

  const AbhaBadge({
    super.key,
    required this.linked,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = linked ? const Color(0xFF2E7D32) : const Color(0xFFF57F17);
    final bgColor = linked ? const Color(0xFFE8F5E9) : const Color(0xFFFFF8E1);
    final label = linked ? 'ABHA Linked' : 'Link ABHA';
    final icon = linked ? Icons.verified : Icons.link_off;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
