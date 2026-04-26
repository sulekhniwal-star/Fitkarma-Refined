import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

part 'device_tier.g.dart';

enum DeviceTier {
  low,
  mid,
  high,
}

@riverpod
Future<DeviceTier> deviceTier(DeviceTierRef ref) async {
  final deviceInfo = DeviceInfoPlugin();
  
  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    final ramGb = (androidInfo.systemMemoryInfo?.totalMemory ?? 0) / (1024 * 1024 * 1024);
    
    if (ramGb < 4) return DeviceTier.low;
    if (ramGb < 8) return DeviceTier.mid;
    return DeviceTier.high;
  }
  
  if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    // Simple heuristic for iOS
    final model = iosInfo.utsname.machine;
    if (model.contains('iPhone10') || model.contains('iPhone11')) return DeviceTier.mid;
    if (model.contains('iPhone8') || model.contains('iPhone9')) return DeviceTier.low;
    return DeviceTier.high;
  }
  
  return DeviceTier.mid;
}
