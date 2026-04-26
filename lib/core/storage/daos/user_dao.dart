import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';
import '../app_database.dart';
import '../tables/user_tables.dart';
import '../tables/india_platform_tables.dart';
import '../tables/core_log_tables.dart';

part 'user_dao.g.dart';

@DriftAccessor(
  tables: [
    Users,
    AbhaLinks,
    EmergencyCards,
    KarmaTransactions,
    PersonalRecords,
    NutritionGoals,
  ],
)
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  final _uuid = const Uuid();

  /// Returns the current user's profile.
  Future<LocalUser?> getUser(String userId) {
    return (select(users)..where((t) => t.id.equals(userId))).getSingleOrNull();
  }

  /// Watches the current user's profile.
  Stream<LocalUser?> watchUser(String userId) {
    return (select(users)..where((t) => t.id.equals(userId))).watchSingleOrNull();
  }

  /// Updates onboarding status.
  Future<void> updateOnboardingStatus(String userId, bool completed) {
    return (update(users)..where((t) => t.id.equals(userId))).write(
      UsersCompanion(
        onboardingCompleted: Value(completed),
        updatedAt: Value(DateTime.now()),
        syncStatus: const Value('pending'),
      ),
    );
  }

  /// Watches the current user's karma balance.
  Stream<int> watchKarmaBalance(String userId) {
    return (select(users)..where((t) => t.id.equals(userId)))
        .map((row) => row.karmaTotal)
        .watchSingle();
  }

  /// Records a new karma transaction and updates the user's balance.
  Future<void> addKarma(
    String userId,
    int amount,
    String action,
    String description,
  ) async {
    await transaction(() async {
      final user = await getUser(userId);
      if (user == null) return;

      final newBalance = user.karmaTotal + amount;

      // 1. Update User balance
      await (update(users)..where((t) => t.id.equals(userId))).write(
        UsersCompanion(
          karmaTotal: Value(newBalance),
          updatedAt: Value(DateTime.now()),
          syncStatus: const Value('pending'),
        ),
      );

      // 2. Record Transaction
      final id = _uuid.v4();
      await into(karmaTransactions).insert(
        KarmaTransactionsCompanion.insert(
          id: id,
          userId: userId,
          amount: amount,
          action: action,
          description: Value(description),
          balanceAfter: newBalance,
          createdAt: Value(DateTime.now()),
          updatedAt: Value(DateTime.now()),
          idempotencyKey: _uuid.v4(),
          syncStatus: const Value('pending'),
        ),
      );
    });
  }

  /// Upserts ABHA link details.
  Future<void> upsertAbha(AbhaLinksCompanion abha) async {
    // If id is not provided, generate one
    var companion = abha;
    if (companion.id.present == false) {
       companion = companion.copyWith(
         id: Value(_uuid.v4()),
         idempotencyKey: Value(_uuid.v4()),
         syncStatus: const Value('pending'),
       );
    }
    await into(abhaLinks).insert(companion, mode: InsertMode.insertOrReplace);
  }

  /// Fetches emergency contact cards.
  Stream<List<EmergencyCard>> watchEmergencyCards(String userId) {
    return (select(
      emergencyCards,
    )..where((t) => t.userId.equals(userId))).watch();
  }
}
