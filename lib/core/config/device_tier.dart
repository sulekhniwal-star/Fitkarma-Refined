// lib/core/config/device_tier.dart

import 'package:device_info_plus/device_info_plus.dart';
import 'package:system_info2/system_info2.dart';
import 'dart:io';

enum DeviceTier { low, mid, high }

extension DeviceTierX on DeviceTier {
  bool get hasBlur => this != DeviceTier.low;
  bool get hasAmbientGlow => this != DeviceTier.low;
  bool get hasAdvancedGlow => this == DeviceTier.high;
  bool get hasRive => this == DeviceTier.high;
  bool get hasSpringPhysics => this != DeviceTier.low;
  bool get hasPerDigitCountUp => this == DeviceTier.high;
  bool get isGlassSurfacesEnabled => this != DeviceTier.low;
  bool get hasLayeredDepth => this == DeviceTier.high;

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
      case DeviceTier.mid:
        return 8.0;
      case DeviceTier.high:
        return 12.0;
    }
  }

  double get glassOpacity {
    switch (this) {
      case DeviceTier.low:
        return 0.95; // Almost opaque for performance
      case DeviceTier.mid:
        return 0.7;
      case DeviceTier.high:
        return 0.4;
    }
  }
}

class DeviceTierService {
  static Future<DeviceTier> detectTier() async {
    try {
      final ramBytes = SysInfo.getTotalPhysicalMemory();
      final ramMB = ramBytes / (1024 * 1024);

      if (ramMB >= 6000) {
        return DeviceTier.high;
      } else if (ramMB >= 3000) {
        return DeviceTier.mid;
      } else {
        return DeviceTier.low;
      }
    } catch (e) {
      return _fallbackHeuristic();
    }
  }

  static Future<DeviceTier> _fallbackHeuristic() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        if (androidInfo.version.sdkInt < 28) return DeviceTier.low;
        if (androidInfo.version.sdkInt < 31) return DeviceTier.mid;
        return DeviceTier.high;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        if (iosInfo.utsname.machine.contains('iPhone12') ||
            iosInfo.utsname.machine.contains('iPhone13') ||
            iosInfo.utsname.machine.contains('iPhone14') ||
            iosInfo.utsname.machine.contains('iPhone15')) {
          return DeviceTier.high;
        }
        return DeviceTier.mid;
      }
    } catch (_) {}
    return DeviceTier.mid;
  }
}
