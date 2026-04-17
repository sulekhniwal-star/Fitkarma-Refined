import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/app_theme.dart';
import '../../core/config/device_tier.dart';

class AmbientGlowBlobs extends ConsumerWidget {
  const AmbientGlowBlobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tier = ref.watch(deviceTierProvider);
    
    if (tier == DeviceTier.low) return const SizedBox.shrink();

    return Stack(
      children: [
        // Blob 1: Secondary (Purple/Blue)
        _buildBlob(
          alignment: const Alignment(-0.8, -0.6),
          color: AppTheme.secondary.withOpacity(tier == DeviceTier.mid ? 0.05 : 0.20),
          size: 280,
          blur: 80,
        ),
        
        if (tier == DeviceTier.high) ...[
          // Blob 2: Primary (Orange)
          _buildBlob(
            alignment: const Alignment(0.7, -0.4),
            color: AppTheme.primary.withOpacity(0.15),
            size: 200,
            blur: 60,
          ),
          
          // Blob 3: Teal
          _buildBlob(
            alignment: const Alignment(0.0, -0.8),
            color: AppTheme.teal.withOpacity(0.10),
            size: 160,
            blur: 50,
          ),
        ],
      ],
    );
  }

  Widget _buildBlob({
    required Alignment alignment,
    required Color color,
    required double size,
    required double blur,
  }) {
    return Align(
      alignment: alignment,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        foregroundDecoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: blur,
              spreadRadius: blur / 2,
            ),
          ],
        ),
      ),
    );
  }
}
