// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_nlp_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FoodNLPService)
final foodNLPServiceProvider = FoodNLPServiceProvider._();

final class FoodNLPServiceProvider
    extends $NotifierProvider<FoodNLPService, void> {
  FoodNLPServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'foodNLPServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$foodNLPServiceHash();

  @$internal
  @override
  FoodNLPService create() => FoodNLPService();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$foodNLPServiceHash() => r'040e83930444caa5f36425a41cee27473b64158a';

abstract class _$FoodNLPService extends $Notifier<void> {
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
