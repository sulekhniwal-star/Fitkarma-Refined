import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/drift_service.dart';
import '../../../core/storage/app_database.dart';
import '../../auth/domain/auth_providers.dart';
import 'package:drift/drift.dart';

class WeddingProfileData {
  final String role;
  final DateTime startDate;
  final DateTime endDate;
  final String goal;

  WeddingProfileData({
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.goal,
  });
}

final weddingProfileProvider = FutureProvider<WeddingProfileData?>((ref) async {
  return WeddingProfileData(
    role: 'bride',
    startDate: DateTime.now().add(const Duration(days: 12)),
    endDate: DateTime.now().add(const Duration(days: 15)),
    goal: 'Glowing Skin',
  );
});

final weddingEventsProvider = FutureProvider<List<WeddingEvent>>((ref) async {
  final db = DriftService.db;
  final authState = ref.watch(authStateProvider);
  final userId = authState.value?.id ?? 'anonymous';
  
  return (db.select(db.weddingEvents)..where((t) => t.userId.equals(userId))).get();
});

final nextWeddingEventProvider = FutureProvider<WeddingEvent?>((ref) async {
  final eventsAsync = await ref.watch(weddingEventsProvider.future);
  if (eventsAsync.isEmpty) return null;
  
  final now = DateTime.now();
  final upcoming = eventsAsync.where((e) => e.date.isAfter(now)).toList();
  upcoming.sort((a, b) => a.date.compareTo(b.date));
  
  return upcoming.isNotEmpty ? upcoming.first : null;
});
