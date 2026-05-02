import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'festival_provider.g.dart';

@riverpod
Stream<List<dynamic>> activeFestivals(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchActiveFestivals(DateTime.now());
}

@riverpod
Stream<List<dynamic>> upcomingFestivals(Ref ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchUpcomingFestivals(DateTime.now(), 30);
}

@riverpod
class UserFestivalFilter extends _$UserFestivalFilter {
  @override
  Map<String, String?> build() {
    final authState = ref.watch(authProvider);
    final user = authState.asData?.value;
    if (user == null) return {'religion': null, 'region': null};

    // Note: In a real implementation, we would listen to the UserProfile stream
    // and initialize the state with user preferences.
    return {'religion': null, 'region': null};
  }

  void updateFilter({String? religion, String? region}) {
    state = {
      ...state,
      if (religion != null) 'religion': religion,
      if (region != null) 'region': region,
    };
  }
}

@riverpod
Future<Map<String, dynamic>?> festivalDiet(Ref ref, String festivalKey) async {
  final db = ref.watch(appDatabaseProvider);
  final festival = await db.getFestivalByKey(festivalKey);
  if (festival?.dietPlanJson == null) return null;

  try {
    return jsonDecode(festival!.dietPlanJson!) as Map<String, dynamic>;
  } catch (_) {
    return null;
  }
}

@riverpod
Future<List<dynamic>> filteredFestivals(Ref ref, List<dynamic> festivals) async {
  final filters = ref.watch(userFestivalFilterProvider);
  
  return festivals.where((f) {
    bool matchesReligion = filters['religion'] == null || 
                           f.religion == null || 
                           f.religion == filters['religion'] || 
                           f.religion == 'All';
    bool matchesRegion = filters['region'] == null || 
                         f.region == null || 
                         f.region == filters['region'] || 
                         f.region == 'Pan-India';
    return matchesReligion && matchesRegion;
  }).toList();
}
