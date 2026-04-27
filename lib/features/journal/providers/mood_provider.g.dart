// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayMoodHash() => r'e20c2c270b22afbb5ed026ad1a537dc8672808d4';

/// See also [todayMood].
@ProviderFor(todayMood)
final todayMoodProvider = AutoDisposeStreamProvider<JournalEntry?>.internal(
  todayMood,
  name: r'todayMoodProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayMoodHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayMoodRef = AutoDisposeStreamProviderRef<JournalEntry?>;
String _$moodHistoryHash() => r'927a69bf1001795bd3c3377a73593ffe00ac87f9';

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

/// See also [moodHistory].
@ProviderFor(moodHistory)
const moodHistoryProvider = MoodHistoryFamily();

/// See also [moodHistory].
class MoodHistoryFamily extends Family<AsyncValue<List<JournalEntry>>> {
  /// See also [moodHistory].
  const MoodHistoryFamily();

  /// See also [moodHistory].
  MoodHistoryProvider call(
    int days,
  ) {
    return MoodHistoryProvider(
      days,
    );
  }

  @override
  MoodHistoryProvider getProviderOverride(
    covariant MoodHistoryProvider provider,
  ) {
    return call(
      provider.days,
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
  String? get name => r'moodHistoryProvider';
}

/// See also [moodHistory].
class MoodHistoryProvider
    extends AutoDisposeStreamProvider<List<JournalEntry>> {
  /// See also [moodHistory].
  MoodHistoryProvider(
    int days,
  ) : this._internal(
          (ref) => moodHistory(
            ref as MoodHistoryRef,
            days,
          ),
          from: moodHistoryProvider,
          name: r'moodHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$moodHistoryHash,
          dependencies: MoodHistoryFamily._dependencies,
          allTransitiveDependencies:
              MoodHistoryFamily._allTransitiveDependencies,
          days: days,
        );

  MoodHistoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.days,
  }) : super.internal();

  final int days;

  @override
  Override overrideWith(
    Stream<List<JournalEntry>> Function(MoodHistoryRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: MoodHistoryProvider._internal(
        (ref) => create(ref as MoodHistoryRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        days: days,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<List<JournalEntry>> createElement() {
    return _MoodHistoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MoodHistoryProvider && other.days == days;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, days.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MoodHistoryRef on AutoDisposeStreamProviderRef<List<JournalEntry>> {
  /// The parameter `days` of this provider.
  int get days;
}

class _MoodHistoryProviderElement
    extends AutoDisposeStreamProviderElement<List<JournalEntry>>
    with MoodHistoryRef {
  _MoodHistoryProviderElement(super.provider);

  @override
  int get days => (origin as MoodHistoryProvider).days;
}

String _$moodNotifierHash() => r'8d0162fcecd06e87b5d44f91d5471510aacb1c7d';

/// See also [MoodNotifier].
@ProviderFor(MoodNotifier)
final moodNotifierProvider =
    AutoDisposeNotifierProvider<MoodNotifier, void>.internal(
  MoodNotifier.new,
  name: r'moodNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$moodNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MoodNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
