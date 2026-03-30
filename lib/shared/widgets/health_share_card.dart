import 'dart:async';

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'encryption_badge.dart';

class HealthShareCard extends StatelessWidget {
  final String patientName;
  final String? summary;
  final int ttlSeconds;
  final VoidCallback? onShare;
  final VoidCallback? onCopy;

  const HealthShareCard({
    super.key,
    required this.patientName,
    this.summary,
    this.ttlSeconds = 300,
    this.onShare,
    this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.health_and_safety_rounded,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Health Summary', style: AppTextStyles.titleSmall),
              const Spacer(),
              const EncryptionBadge(),
            ],
          ),
          const SizedBox(height: 16),
          Text(patientName, style: AppTextStyles.titleMedium),
          if (summary != null) ...[
            const SizedBox(height: 8),
            Text(
              summary!,
              style: AppTextStyles.bodySmall,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 16),
          _CountdownTimer(ttlSeconds: ttlSeconds),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: onCopy,
                  icon: const Icon(Icons.copy_rounded, size: 16),
                  label: const Text('Copy Link'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: onShare,
                  icon: const Icon(Icons.share_rounded, size: 16),
                  label: const Text('Share'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountdownTimer extends StatefulWidget {
  final int ttlSeconds;

  const _CountdownTimer({required this.ttlSeconds});

  @override
  State<_CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<_CountdownTimer> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.ttlSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _remaining > 0) {
        setState(() => _remaining--);
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
    final minutes = _remaining ~/ 60;
    final seconds = _remaining % 60;

    return Row(
      children: [
        Icon(Icons.timer_outlined, size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant),
        const SizedBox(width: 4),
        Text(
          'Expires in ${minutes}m ${seconds.toString().padLeft(2, '0')}s',
          style: AppTextStyles.labelSmall.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
