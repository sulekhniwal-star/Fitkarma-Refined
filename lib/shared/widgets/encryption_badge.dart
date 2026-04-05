import 'package:flutter/material.dart';

class EncryptionBadge extends StatelessWidget {
  final bool isEncrypted;
  final double size;

  const EncryptionBadge({
    super.key,
    this.isEncrypted = true,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: isEncrypted
            ? Colors.green.withValues(alpha: 0.1)
            : Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isEncrypted ? Colors.green : Colors.orange,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isEncrypted ? Icons.lock : Icons.lock_open,
            size: size,
            color: isEncrypted ? Colors.green : Colors.orange,
          ),
          const SizedBox(width: 4),
          Text(
            isEncrypted ? 'AES-256' : 'Unencrypted',
            style: TextStyle(
              fontSize: size - 4,
              fontWeight: FontWeight.w500,
              color: isEncrypted ? Colors.green : Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}