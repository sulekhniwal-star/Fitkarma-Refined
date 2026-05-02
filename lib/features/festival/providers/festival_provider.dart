import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../core/providers/core_providers.dart';

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
    // In a real app, we would fetch this from the user's profile in the DB
    // For now, returning empty to allow all festivals
    return {'religion': null, 'region': null};
  }

  void updateFilter({String? religion, String? region}) {
    state = {
      'religion': religion ?? state['religion'],
      'region': region ?? state['region'],
    };
  }
}

@riverpod
Future<Map<String, Object?>?> festivalDietPlan(Ref ref, String festivalId) async {
  final db = ref.watch(appDatabaseProvider);
  final festival = await db.getFestivalByKey(festivalId);
  if (festival?.dietPlanJson == null) return null;

  try {
    return jsonDecode(festival!.dietPlanJson!) as Map<String, dynamic>;
  } catch (_) {
    return null;
  }
}

@riverpod
Future<List<dynamic>> filteredActiveFestivals(Ref ref) async {
  final festivals = await ref.watch(activeFestivalsProvider.future);
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
