// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeNotifier)
final themeProvider = ThemeNotifierProvider._();

final class ThemeNotifierProvider
    extends $NotifierProvider<ThemeNotifier, ThemeMode> {
  ThemeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'themeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$themeNotifierHash();

  @$internal
  @override
  ThemeNotifier create() => ThemeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$themeNotifierHash() => r'd757f9a0db8d83486b3a461260b86177bdcaa420';

abstract class _$ThemeNotifier extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ThemeMode, ThemeMode>, ThemeMode, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LanguageNotifier)
final languageProvider = LanguageNotifierProvider._();

final class LanguageNotifierProvider
    extends $NotifierProvider<LanguageNotifier, String> {
  LanguageNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'languageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$languageNotifierHash();

  @$internal
  @override
  LanguageNotifier create() => LanguageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$languageNotifierHash() => r'c42c5101d45e89a834913dcfb4dbbceecf538df2';

abstract class _$LanguageNotifier extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FontSizeNotifier)
final fontSizeProvider = FontSizeNotifierProvider._();

final class FontSizeNotifierProvider
    extends $NotifierProvider<FontSizeNotifier, double> {
  FontSizeNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fontSizeProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fontSizeNotifierHash();

  @$internal
  @override
  FontSizeNotifier create() => FontSizeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(double value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<double>(value),
    );
  }
}

String _$fontSizeNotifierHash() => r'fad7ff5c7ad8fefe16807a94a8a1dba034931b21';

abstract class _$FontSizeNotifier extends $Notifier<double> {
  double build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<double, double>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<double, double>, double, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(DyslexiaFontNotifier)
final dyslexiaFontProvider = DyslexiaFontNotifierProvider._();

final class DyslexiaFontNotifierProvider
    extends $NotifierProvider<DyslexiaFontNotifier, bool> {
  DyslexiaFontNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'dyslexiaFontProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$dyslexiaFontNotifierHash();

  @$internal
  @override
  DyslexiaFontNotifier create() => DyslexiaFontNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$dyslexiaFontNotifierHash() =>
    r'd039bdebe56e7526b958067d5fc81126edb5d6c1';

abstract class _$DyslexiaFontNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(BiometricLockNotifier)
final biometricLockProvider = BiometricLockNotifierProvider._();

final class BiometricLockNotifierProvider
    extends $NotifierProvider<BiometricLockNotifier, bool> {
  BiometricLockNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'biometricLockProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$biometricLockNotifierHash();

  @$internal
  @override
  BiometricLockNotifier create() => BiometricLockNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$biometricLockNotifierHash() =>
    r'32a267fab682fbc7c87034b2ef71198a109d595c';

abstract class _$BiometricLockNotifier extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(NotificationPrefsNotifier)
final notificationPrefsProvider = NotificationPrefsNotifierProvider._();

final class NotificationPrefsNotifierProvider
    extends $NotifierProvider<NotificationPrefsNotifier, Map<String, bool>> {
  NotificationPrefsNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'notificationPrefsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$notificationPrefsNotifierHash();

  @$internal
  @override
  NotificationPrefsNotifier create() => NotificationPrefsNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, bool>>(value),
    );
  }
}

String _$notificationPrefsNotifierHash() =>
    r'15d745885ed2bdc831d7e245cebc4f37d545ebcb';

abstract class _$NotificationPrefsNotifier
    extends $Notifier<Map<String, bool>> {
  Map<String, bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, bool>, Map<String, bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, bool>, Map<String, bool>>,
        Map<String, bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(wearables)
final wearablesProvider = WearablesProvider._();

final class WearablesProvider extends $FunctionalProvider<
        AsyncValue<List<String>>, List<String>, FutureOr<List<String>>>
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  WearablesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'wearablesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$wearablesHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return wearables(ref);
  }
}

String _$wearablesHash() => r'1c1f93210aa7f96be3435a501d4adf4166621cc0';

@ProviderFor(subscriptionStatus)
final subscriptionStatusProvider = SubscriptionStatusProvider._();

final class SubscriptionStatusProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  SubscriptionStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'subscriptionStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$subscriptionStatusHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return subscriptionStatus(ref);
  }
}

String _$subscriptionStatusHash() =>
    r'173bb5d18cb9c145b641bc8d9b5251bb32937092';
