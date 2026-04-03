import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fitkarma/core/constants/app_config.dart';
import 'package:fitkarma/core/di/providers.dart';

final karmaAwServiceProvider = Provider<KarmaAwService>((ref) {
  final client = ref.watch(appwriteClientProvider);
  return KarmaAwService(client);
});

class KarmaAwService {
  final Client _client;
  late final Databases _databases;

  static const String _databaseId = AppConfig.appwriteDatabaseId;
  static const String _transactionsCollectionId = 'karma_transactions';

  KarmaAwService(this._client) {
    _databases = Databases(_client);
  }

  Future<models.Document> createTransaction({
    required String odUserId,
    required int amount,
    String? description,
  }) async {
    return _databases.createDocument(
      databaseId: _databaseId,
      collectionId: _transactionsCollectionId,
      documentId: ID.unique(),
      data: {
        'odUserId': odUserId,
        'amount': amount,
        'description': description ?? '',
        'createdAt': DateTime.now().toIso8601String(),
      },
      permissions: [
        Permission.read(Role.user(odUserId)),
        Permission.write(Role.user(odUserId)),
      ],
    );
  }

  Future<List<models.Document>> getTransactionsForUser(
    String odUserId, {
    int limit = 20,
  }) async {
    final response = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _transactionsCollectionId,
      queries: [
        Query.equal('odUserId', [odUserId]),
        Query.orderDesc('createdAt'),
        Query.limit(limit),
      ],
    );
    return response.documents;
  }

  Future<int> getTotalKarmaFromServer(String odUserId) async {
    final transactions = await getTransactionsForUser(odUserId, limit: 1000);
    int total = 0;
    for (final doc in transactions) {
      final amount = doc.data['amount'] as int? ?? 0;
      total += amount;
    }
    return total;
  }

  Future<List<models.Document>> getLeaderboard({
    required String scope,
    int limit = 50,
  }) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(weekStart.year, weekStart.month, weekStart.day);

    final response = await _databases.listDocuments(
      databaseId: _databaseId,
      collectionId: _transactionsCollectionId,
      queries: [
        Query.greaterThanEqual('createdAt', startOfWeek.toIso8601String()),
        Query.orderDesc('amount'),
        Query.limit(limit),
      ],
    );
    return response.documents;
  }

  Stream<RealtimeMessage> subscribeToTransactions(String odUserId) {
    final realtime = Realtime(_client);
    return realtime.subscribe([
      'databases.$_databaseId.collections.$_transactionsCollectionId.documents'
    ]).stream;
  }

  Stream<RealtimeMessage> subscribeToLeaderboard() {
    final realtime = Realtime(_client);
    return realtime.subscribe([
      'databases.$_databaseId.collections.$_transactionsCollectionId.documents'
    ]).stream;
  }
}

class KarmaReward {
  final String id;
  final String name;
  final String description;
  final int cost;
  final String icon;
  final bool isAvailable;

  KarmaReward({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.icon,
    this.isAvailable = true,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'cost': cost,
    'icon': icon,
    'isAvailable': isAvailable,
  };
}

final availableRewardsProvider = Provider<List<KarmaReward>>((ref) {
  return [
    KarmaReward(
      id: 'streak_resume',
      name: 'Streak Resume',
      description: 'Restore a broken streak. Limited to once per 30 days.',
      cost: 50,
      icon: '🔥',
    ),
    KarmaReward(
      id: 'premium_theme',
      name: 'Premium Theme',
      description: 'Unlock exclusive app themes and colors.',
      cost: 200,
      icon: '🎨',
    ),
    KarmaReward(
      id: 'analytics_pack',
      name: 'Analytics Pack',
      description: 'Advanced health insights and trend analysis.',
      cost: 150,
      icon: '📊',
    ),
    KarmaReward(
      id: 'meal_plan_week',
      name: 'Weekly Meal Plan',
      description: 'Personalized meal plan for one week.',
      cost: 100,
      icon: '🍽️',
    ),
    KarmaReward(
      id: 'workout_plan',
      name: 'Custom Workout',
      description: 'Custom workout routine based on your goals.',
      cost: 120,
      icon: '💪',
    ),
    KarmaReward(
      id: 'meditation_pack',
      name: 'Meditation Series',
      description: 'Access to premium meditation sessions.',
      cost: 80,
      icon: '🧘',
    ),
    KarmaReward(
      id: 'badge_showcase',
      name: 'Badge Showcase',
      description: 'Display your achievements on your profile.',
      cost: 75,
      icon: '🏆',
    ),
    KarmaReward(
      id: 'api_access',
      name: 'API Access',
      description: 'Export your data via API for 30 days.',
      cost: 250,
      icon: '🔌',
    ),
  ];
});