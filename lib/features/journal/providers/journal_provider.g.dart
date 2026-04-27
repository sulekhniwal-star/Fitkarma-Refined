// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journal_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$journalEntriesHash() => r'0874353bc451b33ad70c07d8abe82b13702e1779';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [journalEntries].
@ProviderFor(journalEntries)
const journalEntriesProvider = JournalEntriesFamily();

/// See also [journalEntries].
class JournalEntriesFamily extends Family<AsyncValue<List<JournalEntry>>> {
  /// See also [journalEntries].
  const JournalEntriesFamily();

  /// See also [journalEntries].
  JournalEntriesProvider call({
    int limit = 20,
    int offset = 0,
  }) {
    return JournalEntriesProvider(
      limit: limit,
      offset: offset,
    );
  }

  @override
  JournalEntriesProvider getProviderOverride(
    covariant JournalEntriesProvider provider,
  ) {
    return call(
      limit: provider.limit,
      offset: provider.offset,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'journalEntriesProvider';
}

/// See also [journalEntries].
class JournalEntriesProvider
    extends AutoDisposeFutureProvider<List<JournalEntry>> {
  /// See also [journalEntries].
  JournalEntriesProvider({
    int limit = 20,
    int offset = 0,
  }) : this._internal(
          (ref) => journalEntries(
            ref as JournalEntriesRef,
            limit: limit,
            offset: offset,
          ),
          from: journalEntriesProvider,
          name: r'journalEntriesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$journalEntriesHash,
          dependencies: JournalEntriesFamily._dependencies,
          allTransitiveDependencies:
              JournalEntriesFamily._allTransitiveDependencies,
          limit: limit,
          offset: offset,
        );

  JournalEntriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.limit,
    required this.offset,
  }) : super.internal();

  final int limit;
  final int offset;

  @override
  Override overrideWith(
    FutureOr<List<JournalEntry>> Function(JournalEntriesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: JournalEntriesProvider._internal(
        (ref) => create(ref as JournalEntriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        limit: limit,
        offset: offset,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<JournalEntry>> createElement() {
    return _JournalEntriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is JournalEntriesProvider &&
        other.limit == limit &&
        other.offset == offset;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, offset.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin JournalEntriesRef on AutoDisposeFutureProviderRef<List<JournalEntry>> {
  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `offset` of this provider.
  int get offset;
}

class _JournalEntriesProviderElement
    extends AutoDisposeFutureProviderElement<List<JournalEntry>>
    with JournalEntriesRef {
  _JournalEntriesProviderElement(super.provider);

  @override
  int get limit => (origin as JournalEntriesProvider).limit;
  @override
  int get offset => (origin as JournalEntriesProvider).offset;
}

String _$journalPromptHash() => r'8ff21099f07e6941aa87e4f2a253bc698e5647cf';

/// See also [journalPrompt].
@ProviderFor(journalPrompt)
final journalPromptProvider = AutoDisposeProvider<String>.internal(
  journalPrompt,
  name: r'journalPromptProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalPromptHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef JournalPromptRef = AutoDisposeProviderRef<String>;
String _$journalNotifierHash() => r'59a3dfe91f96fd996c83e8620660a1daa4b941d8';

/// See also [JournalNotifier].
@ProviderFor(JournalNotifier)
final journalNotifierProvider = AutoDisposeAsyncNotifierProvider<
    JournalNotifier, List<JournalEntry>>.internal(
  JournalNotifier.new,
  name: r'journalNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$journalNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$JournalNotifier = AutoDisposeAsyncNotifier<List<JournalEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
