// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(JournalNotifier)
final journalProvider = JournalNotifierProvider._();

final class JournalNotifierProvider
    extends $AsyncNotifierProvider<JournalNotifier, List<dynamic>> {
  JournalNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'journalProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$journalNotifierHash();

  @$internal
  @override
  JournalNotifier create() => JournalNotifier();
}

String _$journalNotifierHash() => r'72db778cc5a66fb55d2096e292673f3160abc779';

abstract class _$JournalNotifier extends $AsyncNotifier<List<dynamic>> {
  FutureOr<List<dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<dynamic>>, List<dynamic>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<dynamic>>, List<dynamic>>,
        AsyncValue<List<dynamic>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(journalEntries)
final journalEntriesProvider = JournalEntriesFamily._();

final class JournalEntriesProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  JournalEntriesProvider._(
      {required JournalEntriesFamily super.from,
      required ({
        int limit,
        int offset,
      })
          super.argument})
      : super(
          retry: null,
          name: r'journalEntriesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$journalEntriesHash();

  @override
  String toString() {
    return r'journalEntriesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<dynamic>> create(Ref ref) {
    final argument = this.argument as ({
      int limit,
      int offset,
    });
    return journalEntries(
      ref,
      limit: argument.limit,
      offset: argument.offset,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntriesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$journalEntriesHash() => r'b387cceebdb496f1bc5b953a342156b467834436';

final class JournalEntriesFamily extends $Family
    with
        $FunctionalFamilyOverride<
            FutureOr<List<dynamic>>,
            ({
              int limit,
              int offset,
            })> {
  JournalEntriesFamily._()
      : super(
          retry: null,
          name: r'journalEntriesProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  JournalEntriesProvider call({
    int limit = 20,
    int offset = 0,
  }) =>
      JournalEntriesProvider._(argument: (
        limit: limit,
        offset: offset,
      ), from: this);

  @override
  String toString() => r'journalEntriesProvider';
}

@ProviderFor(journalPrompt)
final journalPromptProvider = JournalPromptProvider._();

final class JournalPromptProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  JournalPromptProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'journalPromptProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$journalPromptHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return journalPrompt(ref);
  }
}

String _$journalPromptHash() => r'1859933e31ab6238b45673be426beefd1e6181f2';
