import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../storage/app_database.dart';

export '../routing/app_router.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(ThemeNotifier.new);

final driftDbProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('driftDbProvider must be overridden in ProviderScope');
});

final foodDaoProvider = Provider((ref) => ref.watch(driftDbProvider).foodDao);
final healthDaoProvider = Provider((ref) => ref.watch(driftDbProvider).healthDao);
final userDaoProvider = Provider((ref) => ref.watch(driftDbProvider).userDao);
final syncDaoProvider = Provider((ref) => ref.watch(driftDbProvider).syncDao);
final ayurvedaDaoProvider = Provider((ref) => ref.watch(driftDbProvider).ayurvedaDao);
