import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/appwrite_client.dart';
import '../domain/auth_providers.dart';

class UsersRepository {
  final Client client;
  final Databases databases;

  UsersRepository({required this.client}) : databases = Databases(client);

  Future<void> updateWeddingData({
    required String userId,
    required String role,
    required String? relativeType,
    required DateTime? startDate,
    required DateTime? endDate,
    required List<String> events,
    required String? prepWeeks,
    required String? primaryGoal,
  }) async {
    // This assumes the user data is stored in a 'users' collection or as app user preferences
    // For this implementation, we will update the user's Preferences in Appwrite
    // or a dedicated 'user_profiles' collection.
    
    // Using Preferences as a flexible way to store this metadata
    final account = Account(client);
    final prefs = await account.getPrefs();
    
    final weddingData = {
      'wedding_role': role,
      'wedding_relative_type': relativeType,
      'wedding_start_date': startDate?.toIso8601String(),
      'wedding_end_date': endDate?.toIso8601String(),
      'wedding_events': events,
      'wedding_prep_weeks': prepWeeks,
      'wedding_primary_goal': primaryGoal,
      'is_wedding_active': true,
    };

    final newPrefs = Map<String, dynamic>.from(prefs.data)..addAll(weddingData);
    await account.updatePrefs(prefs: newPrefs);
  }
}

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  return UsersRepository(client: AppwriteClient.client);
});
