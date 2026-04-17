// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_filter_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FestivalRegionFilter)
final festivalRegionFilterProvider = FestivalRegionFilterProvider._();

final class FestivalRegionFilterProvider
    extends $NotifierProvider<FestivalRegionFilter, String> {
  FestivalRegionFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'festivalRegionFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$festivalRegionFilterHash();

  @$internal
  @override
  FestivalRegionFilter create() => FestivalRegionFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$festivalRegionFilterHash() =>
    r'4cfe9f08c324b1eae64bad5e727d329f87874be6';

abstract class _$FestivalRegionFilter extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

