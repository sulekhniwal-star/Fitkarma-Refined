// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ayurveda_dao.dart';

// ignore_for_file: type=lint
mixin _$AyurvedaDaoMixin on DatabaseAccessor<AppDatabase> {
  $AyurvedicRitualLogsTable get ayurvedicRitualLogs =>
      attachedDatabase.ayurvedicRitualLogs;
  AyurvedaDaoManager get managers => AyurvedaDaoManager(this);
}

class AyurvedaDaoManager {
  final _$AyurvedaDaoMixin _db;
  AyurvedaDaoManager(this._db);
  $$AyurvedicRitualLogsTableTableManager get ayurvedicRitualLogs =>
      $$AyurvedicRitualLogsTableTableManager(
        _db.attachedDatabase,
        _db.ayurvedicRitualLogs,
      );
}

