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
    extends $AsyncNotifierProvider<ThemeNotifier, ThemeMode> {
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
}

String _$themeNotifierHash() => r'665306a60538ecadd4944fe20dd6918607da2f2e';

abstract class _$ThemeNotifier extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
        AsyncValue<ThemeMode>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(LanguageNotifier)
final languageProvider = LanguageNotifierProvider._();

final class LanguageNotifierProvider
    extends $AsyncNotifierProvider<LanguageNotifier, String> {
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
}

String _$languageNotifierHash() => r'9dc5d1fcb9bf7a7e57d9adafacf98ff21901b52d';

abstract class _$LanguageNotifier extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<String>, String>,
        AsyncValue<String>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(FontSizeNotifier)
final fontSizeProvider = FontSizeNotifierProvider._();

final class FontSizeNotifierProvider
    extends $AsyncNotifierProvider<FontSizeNotifier, double> {
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
}

String _$fontSizeNotifierHash() => r'a7fbec0875279894dfd29d876034a70651aadcf7';

abstract class _$FontSizeNotifier extends $AsyncNotifier<double> {
  FutureOr<double> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<double>, double>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<double>, double>,
        AsyncValue<double>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(DyslexiaFontNotifier)
final dyslexiaFontProvider = DyslexiaFontNotifierProvider._();

final class DyslexiaFontNotifierProvider
    extends $AsyncNotifierProvider<DyslexiaFontNotifier, bool> {
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
}

String _$dyslexiaFontNotifierHash() =>
    r'21c13bdfedc0031748d4ae22b02e0d5f06451a55';

abstract class _$DyslexiaFontNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(BiometricLockNotifier)
final biometricLockProvider = BiometricLockNotifierProvider._();

final class BiometricLockNotifierProvider
    extends $AsyncNotifierProvider<BiometricLockNotifier, bool> {
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
}

String _$biometricLockNotifierHash() =>
    r'afdb40a10667a85b3402760651d4a5e020673eba';

abstract class _$BiometricLockNotifier extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(NotificationPrefsNotifier)
final notificationPrefsProvider = NotificationPrefsNotifierProvider._();

final class NotificationPrefsNotifierProvider extends $AsyncNotifierProvider<
    NotificationPrefsNotifier, Map<String, bool>> {
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
}

String _$notificationPrefsNotifierHash() =>
    r'305b3380dbd6f902432cf3dfc5eb25c563293316';

abstract class _$NotificationPrefsNotifier
    extends $AsyncNotifier<Map<String, bool>> {
  FutureOr<Map<String, bool>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<Map<String, bool>>, Map<String, bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Map<String, bool>>, Map<String, bool>>,
        AsyncValue<Map<String, bool>>,
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

String _$wearablesHash() => r'9b95c04e73f77a48df3b865779a870134b64d0b3';

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
