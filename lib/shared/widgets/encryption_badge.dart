import 'package:flutter/material.dart';

import '../theme/app_text_styles.dart';

class EncryptionBadge extends StatelessWidget {
  final String algorithm;

  const EncryptionBadge({
    super.key,
    this.algorithm = 'AES-256',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF00B894).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00B894).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock_rounded, size: 12, color: Color(0xFF00B894)),
          const SizedBox(width: 4),
          Text(
            algorithm,
            style: AppTextStyles.overline.copyWith(
              color: const Color(0xFF00B894),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
