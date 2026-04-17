// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dao.dart';

// ignore_for_file: type=lint
mixin _$UserDaoMixin on DatabaseAccessor<AppDatabase> {
  $UsersTable get users => attachedDatabase.users;
  $AbhaLinksTable get abhaLinks => attachedDatabase.abhaLinks;
  $EmergencyCardsTable get emergencyCards => attachedDatabase.emergencyCards;
  $KarmaTransactionsTable get karmaTransactions =>
      attachedDatabase.karmaTransactions;
  $PersonalRecordsTable get personalRecords => attachedDatabase.personalRecords;
  $NutritionGoalsTable get nutritionGoals => attachedDatabase.nutritionGoals;
  UserDaoManager get managers => UserDaoManager(this);
}

class UserDaoManager {
  final _$UserDaoMixin _db;
  UserDaoManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db.attachedDatabase, _db.users);
  $$AbhaLinksTableTableManager get abhaLinks =>
      $$AbhaLinksTableTableManager(_db.attachedDatabase, _db.abhaLinks);
  $$EmergencyCardsTableTableManager get emergencyCards =>
      $$EmergencyCardsTableTableManager(
        _db.attachedDatabase,
        _db.emergencyCards,
      );
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(
        _db.attachedDatabase,
        _db.karmaTransactions,
      );
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(
        _db.attachedDatabase,
        _db.personalRecords,
      );
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(
        _db.attachedDatabase,
        _db.nutritionGoals,
      );
}
