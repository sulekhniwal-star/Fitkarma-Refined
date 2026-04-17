// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SecurityNotifier)
final securityProvider = SecurityNotifierProvider._();

final class SecurityNotifierProvider
    extends $AsyncNotifierProvider<SecurityNotifier, SecurityState> {
  SecurityNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'securityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$securityNotifierHash();

  @$internal
  @override
  SecurityNotifier create() => SecurityNotifier();
}

String _$securityNotifierHash() => r'7603e47a65a1a88f133341fba017a9c92cf0e50f';

abstract class _$SecurityNotifier extends $AsyncNotifier<SecurityState> {
  FutureOr<SecurityState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SecurityState>, SecurityState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SecurityState>, SecurityState>,
              AsyncValue<SecurityState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
