import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fitkarma/core/network/low_data_mode_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = FutureProvider<SharedPreferences>((
  ref,
) async {
  return await SharedPreferences.getInstance();
});

// Service for managing low data mode
final lowDataModeServiceProvider = Provider<LowDataModeService>((ref) {
  final connectivity = Connectivity();
  final sharedPreferences = ref.watch(sharedPreferencesProvider).asData!.value;
  return LowDataModeService(connectivity, sharedPreferences);
});

// Stream provider for low data mode status (watchable anywhere)
final lowDataModeStreamProvider = StreamProvider<bool>((ref) {
  return ref.watch(lowDataModeServiceProvider).lowDataModeStream;
});

// Provider for image compression service
final imageCompressionServiceProvider = Provider<ImageCompressionService>((
  ref,
) {
  return ImageCompressionService.instance;
});
