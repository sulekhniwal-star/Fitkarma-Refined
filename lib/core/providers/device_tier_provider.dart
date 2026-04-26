import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/device_tier.dart';

final deviceTierProvider = FutureProvider<DeviceTier>((ref) async {
  final info = DeviceInfoPlugin();
  int ramMB = 4096; // default mid

  if (defaultTargetPlatform == TargetPlatform.android) {
    final android = await info.androidInfo;
    ramMB = _estimateRamFromAndroidVersion(android.version.sdkInt);
  }

  if (ramMB < 3000) return DeviceTier.low;
  if (ramMB < 6000) return DeviceTier.mid;
  return DeviceTier.high;
});

int _estimateRamFromAndroidVersion(int sdkInt) {
  if (sdkInt <= 28) return 2048; // Android 9 or lower: likely low tier
  if (sdkInt <= 30) return 4096; // Android 10/11: mid tier
  return 8192; // Android 12+: likely high tier
}
