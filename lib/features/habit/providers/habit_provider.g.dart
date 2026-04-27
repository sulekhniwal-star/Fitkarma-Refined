// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todayHabitsHash() => r'9ced92156d8685bfa1fcbd795c62fe13c5bc8e13';

/// See also [todayHabits].
@ProviderFor(todayHabits)
final todayHabitsProvider = AutoDisposeStreamProvider<List<Habit>>.internal(
  todayHabits,
  name: r'todayHabitsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todayHabitsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TodayHabitsRef = AutoDisposeStreamProviderRef<List<Habit>>;
String _$habitNotifierHash() => r'0deac529b8304f75336f00457f74d87e89f0d43c';

/// See also [HabitNotifier].
@ProviderFor(HabitNotifier)
final habitNotifierProvider =
    AutoDisposeStreamNotifierProvider<HabitNotifier, List<Habit>>.internal(
  HabitNotifier.new,
  name: r'habitNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$habitNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HabitNotifier = AutoDisposeStreamNotifier<List<Habit>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
