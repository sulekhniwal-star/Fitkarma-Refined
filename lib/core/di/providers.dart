import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/app_database.dart';

/// Provider for the Drift database instance.
/// This must be overridden in the ProviderScope at the root of the app.
final driftDbProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('driftDbProvider must be overridden in ProviderScope');
});
