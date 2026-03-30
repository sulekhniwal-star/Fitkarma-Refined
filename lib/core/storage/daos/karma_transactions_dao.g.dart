// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_transactions_dao.dart';

// ignore_for_file: type=lint
mixin _$KarmaTransactionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $KarmaTransactionsTable get karmaTransactions =>
      attachedDatabase.karmaTransactions;
  KarmaTransactionsDaoManager get managers => KarmaTransactionsDaoManager(this);
}

class KarmaTransactionsDaoManager {
  final _$KarmaTransactionsDaoMixin _db;
  KarmaTransactionsDaoManager(this._db);
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.karmaTransactions,
      );
}
