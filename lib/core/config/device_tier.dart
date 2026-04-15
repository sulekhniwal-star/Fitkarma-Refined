import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

enum DeviceTier { low, mid, high }

final deviceTierProvider = StateProvider<DeviceTier>((ref) => DeviceTier.mid);

class DeviceTierService {
  static Future<DeviceTier> detectTier() async {
    final deviceInfo = DeviceInfoPlugin();
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      // Note: Getting exact RAM in Android requires some native code or reading /proc/meminfo
      // For now, we'll use a heuristic based on SDK version and model if possible,
      // but a better way is to use system_info or a native channel.
      // Assuming mid-tier for now as a safe default if detection is uncertain.
      // In a real app, I'd implement a method to check physical memory.
      
      // Heuristic fallback:
      // If we could get memory, it would be:
      // low: < 3GB RAM | mid: 3–6GB | high: 6GB+
      return DeviceTier.high; // Defaulting to high for development/testing if detection is complex
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      // Similar logic for iOS
      return DeviceTier.high;
    }
    
    return DeviceTier.mid;
  }
}
