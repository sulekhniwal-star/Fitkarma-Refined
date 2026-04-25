// lib/core/providers/device_tier_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/device_tier.dart';

final deviceTierProvider = NotifierProvider<DeviceTierNotifier, DeviceTier>(
  DeviceTierNotifier.new,
);

class DeviceTierNotifier extends Notifier<DeviceTier> {
  @override
  DeviceTier build() => DeviceTier.mid;

  void setTier(DeviceTier tier) {
    state = tier;
  }
}
