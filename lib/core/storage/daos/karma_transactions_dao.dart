import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'karma_transactions_dao.g.dart';


@DriftDatabase(tables: [KarmaTransactions])
class KarmaTransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$KarmaTransactionsDaoMixin {
  KarmaTransactionsDao(super.db);

  Future<List<KarmaTransaction>> getAll(String userId) =>
      (select(karmaTransactions)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)]))
          .get();

  Future<int> getTotalPoints(String userId) async {
    final earned = await (selectOnly(karmaTransactions)
          ..addColumns([karmaTransactions.points.sum()])
          ..where(karmaTransactions.userId.equals(userId))
          ..where(karmaTransactions.points.isBiggerThanValue(0)))
        .getSingle();
    final spent = await (selectOnly(karmaTransactions)
          ..addColumns([karmaTransactions.points.sum()])
          ..where(karmaTransactions.userId.equals(userId))
          ..where(karmaTransactions.points.isSmallerThanValue(0)))
        .getSingle();
    return (earned.read(karmaTransactions.points.sum()) ?? 0) +
        (spent.read(karmaTransactions.points.sum()) ?? 0);
  }

  Future<int> insertTransaction(KarmaTransactionsCompanion entry) =>
      into(karmaTransactions).insert(entry);

  Stream<List<KarmaTransaction>> watchRecent(String userId, {int limit = 20}) {
    return (select(karmaTransactions)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.transactionDate)])
          ..limit(limit))
        .watch();
  }
}
