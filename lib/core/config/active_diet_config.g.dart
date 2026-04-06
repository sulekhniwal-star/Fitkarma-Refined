// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_diet_config.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(activeDietConfig)
final activeDietConfigProvider = ActiveDietConfigProvider._();

final class ActiveDietConfigProvider
    extends
        $FunctionalProvider<
          AsyncValue<CombinedDietConfig>,
          CombinedDietConfig,
          FutureOr<CombinedDietConfig>
        >
    with
        $FutureModifier<CombinedDietConfig>,
        $FutureProvider<CombinedDietConfig> {
  ActiveDietConfigProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeDietConfigProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeDietConfigHash();

  @$internal
  @override
  $FutureProviderElement<CombinedDietConfig> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CombinedDietConfig> create(Ref ref) {
    return activeDietConfig(ref);
  }
}

String _$activeDietConfigHash() => r'cb038ac620dd0ef900a244fedb43740525f15005';
