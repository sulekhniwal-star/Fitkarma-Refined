import 'package:drift/drift.dart';
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

  /// Returns the current user's profile.
  Future<LocalUser?> getUser(String userId) {
    return (select(users)..where((t) => t.id.equals(userId))).getSingleOrNull();
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
        UsersCompanion(karmaTotal: Value(newBalance)),
      );

      // 2. Record Transaction
      await into(karmaTransactions).insert(
        KarmaTransactionsCompanion.insert(
          userId: userId,
          amount: amount,
          action: action,
          description: Value(description),
          balanceAfter: newBalance,
          createdAt: DateTime.now(),
        ),
      );
    });
  }

  /// Upserts ABHA link details.
  Future<int> upsertAbha(AbhaLinksCompanion abha) {
    return into(abhaLinks).insert(abha, mode: InsertMode.insertOrReplace);
  }

  /// Fetches emergency contact cards.
  Stream<List<EmergencyCard>> watchEmergencyCards(String userId) {
    return (select(
      emergencyCards,
    )..where((t) => t.userId.equals(userId))).watch();
  }
}
