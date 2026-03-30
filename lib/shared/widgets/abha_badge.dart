import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class AbhaBadge extends StatelessWidget {
  final bool isLinked;
  final String? abhaAddress;
  final VoidCallback? onTap;

  const AbhaBadge({
    super.key,
    required this.isLinked,
    this.abhaAddress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLinked ? AppColors.success : AppColors.warning;
    final label = isLinked ? 'ABHA Linked' : 'Link ABHA';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isLinked ? Icons.verified_user_rounded : Icons.link_rounded,
              size: 14,
              color: color,
            ),
            const SizedBox(width: 6),
            Text(
              abhaAddress ?? label,
              style: AppTextStyles.labelSmall.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
