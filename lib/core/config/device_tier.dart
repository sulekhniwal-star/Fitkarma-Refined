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
    // ignore: unused_local_variable
    final androidInfo = await deviceInfo.androidInfo;
    // Fallback if systemMemoryInfo is missing in this version
    final ramGb = 4.0; 
    // final ramGb = (androidInfo.systemMemoryInfo?.totalMemory ?? 0) / (1024 * 1024 * 1024);
    
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
