// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_card_dao.dart';

// ignore_for_file: type=lint
mixin _$EmergencyCardDaoMixin on DatabaseAccessor<AppDatabase> {
  $EmergencyCardTable get emergencyCard => attachedDatabase.emergencyCard;
  EmergencyCardDaoManager get managers => EmergencyCardDaoManager(this);
}

class EmergencyCardDaoManager {
  final _$EmergencyCardDaoMixin _db;
  EmergencyCardDaoManager(this._db);
  $$EmergencyCardTableTableManager get emergencyCard =>
      $$EmergencyCardTableTableManager(_db.attachedDatabase, _db.emergencyCard);
}
