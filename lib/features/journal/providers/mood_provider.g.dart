// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MoodNotifier)
final moodProvider = MoodNotifierProvider._();

final class MoodNotifierProvider extends $NotifierProvider<MoodNotifier, void> {
  MoodNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'moodProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$moodNotifierHash();

  @$internal
  @override
  MoodNotifier create() => MoodNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$moodNotifierHash() => r'e8f045f346f7acddf78bfd04dbdea5cc43a33b47';

abstract class _$MoodNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<void, void>, void, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(todayMood)
final todayMoodProvider = TodayMoodProvider._();

final class TodayMoodProvider
    extends $FunctionalProvider<AsyncValue<dynamic>, dynamic, Stream<dynamic>>
    with $FutureModifier<dynamic>, $StreamProvider<dynamic> {
  TodayMoodProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todayMoodProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todayMoodHash();

  @$internal
  @override
  $StreamProviderElement<dynamic> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<dynamic> create(Ref ref) {
    return todayMood(ref);
  }
}

String _$todayMoodHash() => r'2f7c6eeac08c39b8a5358a675a6efa8083043204';

@ProviderFor(moodHistory)
final moodHistoryProvider = MoodHistoryFamily._();

final class MoodHistoryProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, Stream<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $StreamProvider<List<dynamic>> {
  MoodHistoryProvider._(
      {required MoodHistoryFamily super.from, required int super.argument})
      : super(
          retry: null,
          name: r'moodHistoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$moodHistoryHash();

  @override
  String toString() {
    return r'moodHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<List<dynamic>> create(Ref ref) {
    final argument = this.argument as int;
    return moodHistory(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MoodHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$moodHistoryHash() => r'd6ea7fc64c07a34388318d9afcbc5007bab53841';

final class MoodHistoryFamily extends $Family
    with $FunctionalFamilyOverride<Stream<List<dynamic>>, int> {
  MoodHistoryFamily._()
      : super(
          retry: null,
          name: r'moodHistoryProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  MoodHistoryProvider call(
    int days,
  ) =>
      MoodHistoryProvider._(argument: days, from: this);

  @override
  String toString() => r'moodHistoryProvider';
}
