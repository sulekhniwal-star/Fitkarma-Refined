import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

enum DeviceTier { low, mid, high }

extension DeviceTierX on DeviceTier {
  bool get hasBlur => this != DeviceTier.low;
  bool get hasAmbientGlow => this != DeviceTier.low;
  bool get hasAdvancedGlow => this == DeviceTier.high;
  bool get hasRive => this == DeviceTier.high;
  bool get hasSpringPhysics => this != DeviceTier.low;
  bool get hasPerDigitCountUp => this == DeviceTier.high;
  bool get isGlassSurfacesEnabled => this == DeviceTier.high;

  int get ambientGlowCount {
    switch (this) {
      case DeviceTier.low:
        return 0;
      case DeviceTier.mid:
        return 1;
      case DeviceTier.high:
        return 3;
    }
  }

  double get blurRadius {
    switch (this) {
      case DeviceTier.low:
        return 0;
      default:
        return 12.0;
    }
  }
}

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

class DeviceTierService {
  static Future<DeviceTier> detectTier() async {
    final deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        // In a real production app, we would use a native bridge to check physical RAM.
        // For now, we'll use a heuristic: Android 12+ (SDK 31+) usually targets mid/high devices.
        // This is a placeholder for actual RAM-based detection.
        if (androidInfo.version.sdkInt < 28) return DeviceTier.low;
        if (androidInfo.version.sdkInt < 32) return DeviceTier.mid;
        return DeviceTier.high;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        // iPhones usually have good enough performance for mid-tier at least.
        // iPhone 11 and above (iPhone12,1+) are high tier.
        if (iosInfo.utsname.machine.contains('iPhone12') ||
            iosInfo.utsname.machine.contains('iPhone13') ||
            iosInfo.utsname.machine.contains('iPhone14') ||
            iosInfo.utsname.machine.contains('iPhone15')) {
          return DeviceTier.high;
        }
        return DeviceTier.mid;
      }
    } catch (e) {
      return DeviceTier.mid;
    }

    return DeviceTier.mid;
  }
}
