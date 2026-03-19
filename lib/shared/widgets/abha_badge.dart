import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class ABHABadge extends StatelessWidget {
  final bool isLinked;
  final bool isLarge;

  const ABHABadge({
    super.key,
    required this.isLinked,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isLinked ? AppColors.success : AppColors.warning;
    final String label = isLinked ? 'ABHA Linked' : 'ABHA Not Linked';
    final IconData icon = isLinked ? Icons.verified_user_rounded : Icons.info_outline_rounded;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isLarge ? 14 : 10,
        vertical: isLarge ? 8 : 4,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: isLarge ? 18 : 14,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: AppTextStyles.labelMedium.copyWith(
              color: color,
              fontSize: isLarge ? 13 : 11,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (isLarge) ...[
            const SizedBox(width: 8),
            Icon(
              Icons.chevron_right_rounded,
              size: 16,
              color: color.withOpacity(0.7),
            ),
          ],
        ],
      ),
    );
  }
}
