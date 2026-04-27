import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/config/device_tier.dart';

class AmbientBlobs extends ConsumerWidget {
  const AmbientBlobs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tierAsync = ref.watch(deviceTierProvider);
    final tier = tierAsync.asData?.value ?? DeviceTier.mid;

    if (tier == DeviceTier.low) return const SizedBox.shrink();

    final blobCount = tier == DeviceTier.high ? 3 : 1;

    return Stack(
      children: List.generate(blobCount, (index) {
        return Positioned(
          top: 100.0 * index,
          left: -50.0 + (100 * index),
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFFF97316).withOpacity(0.1),
                  const Color(0xFFF97316).withOpacity(0.0),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
