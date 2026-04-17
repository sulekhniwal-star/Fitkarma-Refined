// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayurveda_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AyurvedaNotifier)
final ayurvedaProvider = AyurvedaNotifierProvider._();

final class AyurvedaNotifierProvider
    extends $AsyncNotifierProvider<AyurvedaNotifier, DoshaScore?> {
  AyurvedaNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ayurvedaProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ayurvedaNotifierHash();

  @$internal
  @override
  AyurvedaNotifier create() => AyurvedaNotifier();
}

String _$ayurvedaNotifierHash() => r'f9a3d1a6d4a6145316ea68e63876b275909f9e96';

abstract class _$AyurvedaNotifier extends $AsyncNotifier<DoshaScore?> {
  FutureOr<DoshaScore?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<DoshaScore?>, DoshaScore?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<DoshaScore?>, DoshaScore?>,
              AsyncValue<DoshaScore?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(RitualHistory)
final ritualHistoryProvider = RitualHistoryFamily._();

final class RitualHistoryProvider
    extends $AsyncNotifierProvider<RitualHistory, List<String>> {
  RitualHistoryProvider._({
    required RitualHistoryFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'ritualHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ritualHistoryHash();

  @override
  String toString() {
    return r'ritualHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RitualHistory create() => RitualHistory();

  @override
  bool operator ==(Object other) {
    return other is RitualHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ritualHistoryHash() => r'4d17ef2df0a21620546919a5d4ecaf8683343b12';

final class RitualHistoryFamily extends $Family
    with
        $ClassFamilyOverride<
          RitualHistory,
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>,
          DateTime
        > {
  RitualHistoryFamily._()
    : super(
        retry: null,
        name: r'ritualHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RitualHistoryProvider call(DateTime date) =>
      RitualHistoryProvider._(argument: date, from: this);

  @override
  String toString() => r'ritualHistoryProvider';
}

abstract class _$RitualHistory extends $AsyncNotifier<List<String>> {
  late final _$args = ref.$arg as DateTime;
  DateTime get date => _$args;

  FutureOr<List<String>> build(DateTime date);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(QuizProgress)
final quizProgressProvider = QuizProgressProvider._();

final class QuizProgressProvider
    extends $NotifierProvider<QuizProgress, Map<int, int>> {
  QuizProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quizProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quizProgressHash();

  @$internal
  @override
  QuizProgress create() => QuizProgress();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<int, int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<int, int>>(value),
    );
  }
}

String _$quizProgressHash() => r'b2dbedee38a97e5126a03b8ea2efe078931e4859';

abstract class _$QuizProgress extends $Notifier<Map<int, int>> {
  Map<int, int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<int, int>, Map<int, int>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<int, int>, Map<int, int>>,
              Map<int, int>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
