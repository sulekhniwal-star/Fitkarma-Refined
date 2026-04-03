import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fitkarma/shared/theme/app_colors.dart';
import 'package:fitkarma/shared/theme/app_text_styles.dart';

/// Shareable doctor link card with countdown timer.
class HealthShareCard extends StatefulWidget {
  final String shareUrl;
  final Duration expiresIn;
  final VoidCallback? onCopy;
  final VoidCallback? onShare;
  final VoidCallback? onRevoke;

  const HealthShareCard({
    super.key,
    required this.shareUrl,
    required this.expiresIn,
    this.onCopy,
    this.onShare,
    this.onRevoke,
  });

  @override
  State<HealthShareCard> createState() => _HealthShareCardState();
}

class _HealthShareCardState extends State<HealthShareCard> {
  late Duration _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.expiresIn;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remaining.inSeconds <= 0) {
        _timer?.cancel();
        setState(() {});
      } else {
        setState(() => _remaining -= const Duration(seconds: 1));
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expired = _remaining.inSeconds <= 0;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: expired
                ? AppColors.error.withOpacity(0.3)
                : AppColors.info.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                expired ? Icons.link_off : Icons.share,
                size: 18,
                color: expired ? AppColors.error : AppColors.info,
              ),
              const SizedBox(width: 8),
              Text(
                expired ? 'Link expired' : 'Share with doctor',
                style: AppTextStyles.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (!expired) ...[
            // Countdown
            Row(
              children: [
                const Icon(Icons.timer, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  _formatDuration(_remaining),
                  style: AppTextStyles.labelMedium
                      .copyWith(color: AppColors.warning),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // URL preview
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.lightSurfaceVariant,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.shareUrl,
                      style: AppTextStyles.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 16),
                    onPressed: widget.onCopy,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onShare,
                    icon: const Icon(Icons.send, size: 16),
                    label: const Text('Share'),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: widget.onRevoke,
                  child: const Text('Revoke'),
                ),
              ],
            ),
          ] else
            Text(
              'Generate a new link to share your health data.',
              style: AppTextStyles.bodySmall,
            ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    final s = d.inSeconds.remainder(60);
    if (h > 0) return '${h}h ${m}m ${s}s';
    if (m > 0) return '${m}m ${s}s';
    return '${s}s';
  }
}
