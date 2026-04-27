// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wearablesHash() => r'385b4c85103b351d7bb8b6c8d51e9359597db24c';

/// See also [wearables].
@ProviderFor(wearables)
final wearablesProvider = AutoDisposeProvider<List<String>>.internal(
  wearables,
  name: r'wearablesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$wearablesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WearablesRef = AutoDisposeProviderRef<List<String>>;
String _$subscriptionStatusHash() =>
    r'7a33f6e722913b8776c3726151efe80523ada976';

/// See also [subscriptionStatus].
@ProviderFor(subscriptionStatus)
final subscriptionStatusProvider = AutoDisposeProvider<String>.internal(
  subscriptionStatus,
  name: r'subscriptionStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SubscriptionStatusRef = AutoDisposeProviderRef<String>;
String _$themeNotifierHash() => r'd757f9a0db8d83486b3a461260b86177bdcaa420';

/// See also [ThemeNotifier].
@ProviderFor(ThemeNotifier)
final themeNotifierProvider =
    AutoDisposeNotifierProvider<ThemeNotifier, ThemeMode>.internal(
  ThemeNotifier.new,
  name: r'themeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$themeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ThemeNotifier = AutoDisposeNotifier<ThemeMode>;
String _$languageNotifierHash() => r'c42c5101d45e89a834913dcfb4dbbceecf538df2';

/// See also [LanguageNotifier].
@ProviderFor(LanguageNotifier)
final languageNotifierProvider =
    AutoDisposeNotifierProvider<LanguageNotifier, String>.internal(
  LanguageNotifier.new,
  name: r'languageNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$languageNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LanguageNotifier = AutoDisposeNotifier<String>;
String _$fontSizeNotifierHash() => r'fad7ff5c7ad8fefe16807a94a8a1dba034931b21';

/// See also [FontSizeNotifier].
@ProviderFor(FontSizeNotifier)
final fontSizeNotifierProvider =
    AutoDisposeNotifierProvider<FontSizeNotifier, double>.internal(
  FontSizeNotifier.new,
  name: r'fontSizeNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fontSizeNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FontSizeNotifier = AutoDisposeNotifier<double>;
String _$dyslexiaFontNotifierHash() =>
    r'd039bdebe56e7526b958067d5fc81126edb5d6c1';

/// See also [DyslexiaFontNotifier].
@ProviderFor(DyslexiaFontNotifier)
final dyslexiaFontNotifierProvider =
    AutoDisposeNotifierProvider<DyslexiaFontNotifier, bool>.internal(
  DyslexiaFontNotifier.new,
  name: r'dyslexiaFontNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dyslexiaFontNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DyslexiaFontNotifier = AutoDisposeNotifier<bool>;
String _$biometricLockNotifierHash() =>
    r'32a267fab682fbc7c87034b2ef71198a109d595c';

/// See also [BiometricLockNotifier].
@ProviderFor(BiometricLockNotifier)
final biometricLockNotifierProvider =
    AutoDisposeNotifierProvider<BiometricLockNotifier, bool>.internal(
  BiometricLockNotifier.new,
  name: r'biometricLockNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$biometricLockNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BiometricLockNotifier = AutoDisposeNotifier<bool>;
String _$notificationPrefsNotifierHash() =>
    r'15d745885ed2bdc831d7e245cebc4f37d545ebcb';

/// See also [NotificationPrefsNotifier].
@ProviderFor(NotificationPrefsNotifier)
final notificationPrefsNotifierProvider = AutoDisposeNotifierProvider<
    NotificationPrefsNotifier, Map<String, bool>>.internal(
  NotificationPrefsNotifier.new,
  name: r'notificationPrefsNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$notificationPrefsNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NotificationPrefsNotifier = AutoDisposeNotifier<Map<String, bool>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
