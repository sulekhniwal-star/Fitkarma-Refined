// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lifestyle_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LifestyleRepository)
final lifestyleRepositoryProvider = LifestyleRepositoryProvider._();

final class LifestyleRepositoryProvider
    extends $NotifierProvider<LifestyleRepository, void> {
  LifestyleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'lifestyleRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$lifestyleRepositoryHash();

  @$internal
  @override
  LifestyleRepository create() => LifestyleRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$lifestyleRepositoryHash() =>
    r'2802f22a0b8cbd260548583825423aeca2626d8a';

abstract class _$LifestyleRepository extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
