import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// 🔒 AES-256 pill badge for sensitive health data.
class EncryptionBadge extends StatelessWidget {
  final String label;
  final EdgeInsets padding;

  const EncryptionBadge({
    super.key,
    this.label = 'AES-256 Encrypted',
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF81C784)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.lock, size: 12, color: Color(0xFF2E7D32)),
          const SizedBox(width: 4),
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}
