import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  static const _key = 'theme_mode';

  @override
  FutureOr<ThemeMode> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) {
      return ThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ThemeMode.system,
      );
    }
    return ThemeMode.system;
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    await ref.read(secureStorageProvider).write(key: _key, value: mode.name);
  }
}

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  static const _key = 'language_code';

  @override
  FutureOr<String> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    return value ?? 'en';
  }

  Future<void> setLanguage(String code) async {
    state = AsyncValue.data(code);
    await ref.read(secureStorageProvider).write(key: _key, value: code);
  }

  List<Map<String, String>> get availableLanguages => [
    {'code': 'en', 'name': 'English'},
    {'code': 'hi', 'name': 'Hindi'},
    {'code': 'mr', 'name': 'Marathi'},
    {'code': 'gu', 'name': 'Gujarati'},
    {'code': 'ta', 'name': 'Tamil'},
    {'code': 'te', 'name': 'Telugu'},
    {'code': 'kn', 'name': 'Kannada'},
    {'code': 'ml', 'name': 'Malayalam'},
    {'code': 'bn', 'name': 'Bengali'},
    {'code': 'pa', 'name': 'Punjabi'},
    {'code': 'or', 'name': 'Odia'},
    {'code': 'as', 'name': 'Assamese'},
    {'code': 'ur', 'name': 'Urdu'},
    {'code': 'sa', 'name': 'Sanskrit'},
    {'code': 'ks', 'name': 'Kashmiri'},
    {'code': 'sd', 'name': 'Sindhi'},
    {'code': 'ne', 'name': 'Nepali'},
    {'code': 'mai', 'name': 'Maithili'},
    {'code': 'doi', 'name': 'Dogri'},
    {'code': 'kok', 'name': 'Konkani'},
    {'code': 'mni', 'name': 'Manipuri'},
    {'code': 'sat', 'name': 'Santali'},
  ];
}

@riverpod
class FontSizeNotifier extends _$FontSizeNotifier {
  static const _key = 'font_size_scale';

  @override
  FutureOr<double> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) return double.parse(value);
    return 1.0;
  }

  Future<void> setScale(double scale) async {
    state = AsyncValue.data(scale);
    await ref.read(secureStorageProvider).write(key: _key, value: scale.toString());
  }
}

@riverpod
class DyslexiaFontNotifier extends _$DyslexiaFontNotifier {
  static const _key = 'dyslexia_font_enabled';

  @override
  FutureOr<bool> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    return value == 'true';
  }

  Future<void> setEnabled(bool enabled) async {
    state = AsyncValue.data(enabled);
    await ref.read(secureStorageProvider).write(key: _key, value: enabled.toString());
  }
}

@riverpod
class BiometricLockNotifier extends _$BiometricLockNotifier {
  static const _key = 'biometric_lock_enabled';

  @override
  FutureOr<bool> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    return value == 'true';
  }

  Future<void> setEnabled(bool enabled) async {
    state = AsyncValue.data(enabled);
    await ref.read(secureStorageProvider).write(key: _key, value: enabled.toString());
  }
}

@riverpod
class NotificationPrefsNotifier extends _$NotificationPrefsNotifier {
  static const _key = 'notification_prefs';

  @override
  FutureOr<Map<String, bool>> build() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) {
      return Map<String, bool>.from(jsonDecode(value));
    }
    return {
      'steps': true,
      'water': true,
      'habits': true,
      'social': true,
      'medication': true,
      'wedding': true,
      'festival': true,
    };
  }

  Future<void> togglePref(String module) async {
    final current = state.asData?.value ?? {};
    final newState = {...current};
    newState[module] = !(newState[module] ?? true);
    state = AsyncValue.data(newState);
    await ref.read(secureStorageProvider).write(key: _key, value: jsonEncode(newState));
  }
}

@riverpod
Future<List<String>> wearables(Ref ref) async {
  // Mock connected devices
  return ['Health Connect', 'Google Fit', 'Fitbit', 'Oura Ring'];
}

@riverpod
Future<String> subscriptionStatus(Ref ref) async {
  // Mock subscription state: free/monthly/quarterly/yearly/family
  return 'free';
}
