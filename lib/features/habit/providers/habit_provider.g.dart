// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HabitNotifier)
final habitProvider = HabitNotifierProvider._();

final class HabitNotifierProvider
    extends $StreamNotifierProvider<HabitNotifier, List<dynamic>> {
  HabitNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'habitProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$habitNotifierHash();

  @$internal
  @override
  HabitNotifier create() => HabitNotifier();
}

String _$habitNotifierHash() => r'6512c2e4a8ce61664e437e53762e9acc74658116';

abstract class _$HabitNotifier extends $StreamNotifier<List<dynamic>> {
  Stream<List<dynamic>> build();
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

@ProviderFor(todayHabits)
final todayHabitsProvider = TodayHabitsProvider._();

final class TodayHabitsProvider extends $FunctionalProvider<
        AsyncValue<List<dynamic>>, List<dynamic>, FutureOr<List<dynamic>>>
    with $FutureModifier<List<dynamic>>, $FutureProvider<List<dynamic>> {
  TodayHabitsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todayHabitsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todayHabitsHash();

  @$internal
  @override
  $FutureProviderElement<List<dynamic>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<dynamic>> create(Ref ref) {
    return todayHabits(ref);
  }
}

String _$todayHabitsHash() => r'f715593c46d2f1250ba8a92f796065413c6c0cbd';
