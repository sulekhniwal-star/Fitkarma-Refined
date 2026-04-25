import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';

class HealthShareCard extends StatelessWidget {
  final String expiryLabel; // e.g. "Link expires in 7 days"
  final VoidCallback onShareWhatsApp;
  final VoidCallback onCopyLink;
  final VoidCallback onDeleteLink;

  const HealthShareCard({
    super.key,
    required this.expiryLabel,
    required this.onShareWhatsApp,
    required this.onCopyLink,
    required this.onDeleteLink,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface0 : AppColorsLight.surface0,
        borderRadius: BorderRadius.circular(16),
        border: isDark ? Border.all(color: AppColorsDark.divider) : Border.all(color: AppColorsLight.divider),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isDark ? AppColorsDark.teal : AppColorsLight.teal).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.share, color: isDark ? AppColorsDark.teal : AppColorsLight.teal, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shareable Health Report', style: (isDark ? AppTypography.h4() : AppTypography.h4(color: AppColorsLight.textPrimary))),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: (isDark ? AppColorsDark.warning : AppColorsLight.warning).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      expiryLabel,
                      style: TextStyle(
                        color: isDark ? AppColorsDark.warning : AppColorsLight.warning,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onShareWhatsApp,
              icon: const Icon(Icons.wechat), // Using wechat as a placeholder for WhatsApp if not available, or just WhatsApp icon if custom
              label: const Text('Share via WhatsApp'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25D366), // WhatsApp Green
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCopyLink,
                  icon: const Icon(Icons.copy, size: 18),
                  label: const Text('Copy Link'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: isDark ? AppColorsDark.textPrimary : AppColorsLight.textPrimary,
                    side: BorderSide(color: isDark ? AppColorsDark.divider : AppColorsLight.divider),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: onDeleteLink,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                tooltip: 'Delete Link',
              ),
            ],
          ),
        ],
      ),
    );
  }
}

