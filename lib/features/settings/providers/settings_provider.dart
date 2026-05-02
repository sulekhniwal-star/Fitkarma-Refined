import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';

part 'settings_provider.g.dart';

@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    _load();
    return ThemeMode.system;
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) {
      state = ThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ThemeMode.system,
      );
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    state = mode;
    await ref.read(secureStorageProvider).write(key: _key, value: mode.name);
  }
}

@riverpod
class LanguageNotifier extends _$LanguageNotifier {
  static const _key = 'language_code';

  @override
  String build() {
    _load();
    return 'en';
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) state = value;
  }

  Future<void> setLanguage(String code) async {
    state = code;
    await ref.read(secureStorageProvider).write(key: _key, value: code);
  }
}

@riverpod
class FontSizeNotifier extends _$FontSizeNotifier {
  static const _key = 'font_size_scale';

  @override
  double build() {
    _load();
    return 1.0;
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) state = double.parse(value);
  }

  Future<void> setScale(double scale) async {
    state = scale;
    await ref.read(secureStorageProvider).write(key: _key, value: scale.toString());
  }
}

@riverpod
class DyslexiaFontNotifier extends _$DyslexiaFontNotifier {
  static const _key = 'dyslexia_font_enabled';

  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) state = value == 'true';
  }

  Future<void> setEnabled(bool enabled) async {
    state = enabled;
    await ref.read(secureStorageProvider).write(key: _key, value: enabled.toString());
  }
}

@riverpod
class BiometricLockNotifier extends _$BiometricLockNotifier {
  static const _key = 'biometric_lock_enabled';

  @override
  bool build() {
    _load();
    return false;
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) state = value == 'true';
  }

  Future<void> setEnabled(bool enabled) async {
    state = enabled;
    await ref.read(secureStorageProvider).write(key: _key, value: enabled.toString());
  }
}

@riverpod
class NotificationPrefsNotifier extends _$NotificationPrefsNotifier {
  static const _key = 'notification_prefs';

  @override
  Map<String, bool> build() {
    _load();
    return {
      'steps': true,
      'water': true,
      'habits': true,
      'social': true,
    };
  }

  Future<void> _load() async {
    final storage = ref.read(secureStorageProvider);
    final value = await storage.read(key: _key);
    if (value != null) {
      state = Map<String, bool>.from(jsonDecode(value));
    }
  }

  Future<void> togglePref(String module) async {
    final newState = {...state};
    newState[module] = !(newState[module] ?? true);
    state = newState;
    await ref.read(secureStorageProvider).write(key: _key, value: jsonEncode(state));
  }
}

@riverpod
Future<List<String>> wearables(Ref ref) async {
  // Placeholder for connected devices
  return ['Health Connect', 'Google Fit'];
}

@riverpod
Future<String> subscriptionStatus(Ref ref) async {
  // Placeholder for subscription state
  return 'free';
}
