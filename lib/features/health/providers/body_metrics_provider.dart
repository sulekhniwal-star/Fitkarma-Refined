import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'body_metrics_provider.g.dart';

@riverpod
class BodyMetricsNotifier extends _$BodyMetricsNotifier {
  @override
  Stream<Map<String, Object>> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return Stream.value({});

    final db = ref.watch(appDatabaseProvider);
    
    return Rx.combineLatest2(
      db.watchUserProfile(user.$id),
      db.watchLatestWeight(user.$id),
      (profile, latestWeight) {
        final weight = latestWeight?.weightKg ?? 0.0;
        final height = profile?.heightCm ?? 0.0;
        
        double bmi = 0.0;
        if (height > 0 && weight > 0) {
          bmi = weight / ((height / 100) * (height / 100));
        }
        
        return {
          'weight': weight,
          'height': height,
          'bmi': bmi,
          'level': profile?.level ?? 1,
          'xp': profile?.xp ?? 0,
          'rank': profile?.rank ?? 'Rookie',
        };
      },
    );
  }

  Future<void> logWeight(double weight) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = DateTime.now().millisecondsSinceEpoch.toString(); // Simple ID for now
    
    await db.into(db.weightLogs).insert(WeightLogsCompanion.insert(
      id: id,
      userId: user.$id,
      weightKg: weight,
      measuredAt: DateTime.now(),
    ));
    
    // Remote sync logic would go here via repository
  }
}

@riverpod
Stream<List<dynamic>> weightHistory(Ref ref, int days) {
  final authState = ref.watch(authProvider);
  final user = authState.asData?.value;
  if (user == null) return Stream.value([]);

  return ref.watch(appDatabaseProvider).watchWeightHistory(user.$id, days);
}
