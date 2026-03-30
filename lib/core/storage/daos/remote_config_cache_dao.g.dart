// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_config_cache_dao.dart';

// ignore_for_file: type=lint
class $RemoteConfigCacheTable extends RemoteConfigCache
    with TableInfo<$RemoteConfigCacheTable, RemoteConfigCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemoteConfigCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fetchedAtMeta = const VerificationMeta(
    'fetchedAt',
  );
  @override
  late final GeneratedColumn<DateTime> fetchedAt = GeneratedColumn<DateTime>(
    'fetched_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<DateTime> expiresAt = GeneratedColumn<DateTime>(
    'expires_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, key, value, fetchedAt, expiresAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'remote_config_cache';
  @override
  VerificationContext validateIntegrity(
    Insertable<RemoteConfigCacheData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('fetched_at')) {
      context.handle(
        _fetchedAtMeta,
        fetchedAt.isAcceptableOrUnknown(data['fetched_at']!, _fetchedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_fetchedAtMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemoteConfigCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RemoteConfigCacheData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
      fetchedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fetched_at'],
      )!,
      expiresAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}expires_at'],
      ),
    );
  }

  @override
  $RemoteConfigCacheTable createAlias(String alias) {
    return $RemoteConfigCacheTable(attachedDatabase, alias);
  }
}

class RemoteConfigCacheData extends DataClass
    implements Insertable<RemoteConfigCacheData> {
  final int id;
  final String key;
  final String value;
  final DateTime fetchedAt;
  final DateTime? expiresAt;
  const RemoteConfigCacheData({
    required this.id,
    required this.key,
    required this.value,
    required this.fetchedAt,
    this.expiresAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    map['fetched_at'] = Variable<DateTime>(fetchedAt);
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<DateTime>(expiresAt);
    }
    return map;
  }

  RemoteConfigCacheCompanion toCompanion(bool nullToAbsent) {
    return RemoteConfigCacheCompanion(
      id: Value(id),
      key: Value(key),
      value: Value(value),
      fetchedAt: Value(fetchedAt),
      expiresAt: expiresAt == null && nullToAbsent
          ? const Value.absent()
          : Value(expiresAt),
    );
  }

  factory RemoteConfigCacheData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RemoteConfigCacheData(
      id: serializer.fromJson<int>(json['id']),
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
      fetchedAt: serializer.fromJson<DateTime>(json['fetchedAt']),
      expiresAt: serializer.fromJson<DateTime?>(json['expiresAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
      'fetchedAt': serializer.toJson<DateTime>(fetchedAt),
      'expiresAt': serializer.toJson<DateTime?>(expiresAt),
    };
  }

  RemoteConfigCacheData copyWith({
    int? id,
    String? key,
    String? value,
    DateTime? fetchedAt,
    Value<DateTime?> expiresAt = const Value.absent(),
  }) => RemoteConfigCacheData(
    id: id ?? this.id,
    key: key ?? this.key,
    value: value ?? this.value,
    fetchedAt: fetchedAt ?? this.fetchedAt,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
  );
  RemoteConfigCacheData copyWithCompanion(RemoteConfigCacheCompanion data) {
    return RemoteConfigCacheData(
      id: data.id.present ? data.id.value : this.id,
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
      fetchedAt: data.fetchedAt.present ? data.fetchedAt.value : this.fetchedAt,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RemoteConfigCacheData(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, key, value, fetchedAt, expiresAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RemoteConfigCacheData &&
          other.id == this.id &&
          other.key == this.key &&
          other.value == this.value &&
          other.fetchedAt == this.fetchedAt &&
          other.expiresAt == this.expiresAt);
}

class RemoteConfigCacheCompanion
    extends UpdateCompanion<RemoteConfigCacheData> {
  final Value<int> id;
  final Value<String> key;
  final Value<String> value;
  final Value<DateTime> fetchedAt;
  final Value<DateTime?> expiresAt;
  const RemoteConfigCacheCompanion({
    this.id = const Value.absent(),
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.fetchedAt = const Value.absent(),
    this.expiresAt = const Value.absent(),
  });
  RemoteConfigCacheCompanion.insert({
    this.id = const Value.absent(),
    required String key,
    required String value,
    required DateTime fetchedAt,
    this.expiresAt = const Value.absent(),
  }) : key = Value(key),
       value = Value(value),
       fetchedAt = Value(fetchedAt);
  static Insertable<RemoteConfigCacheData> custom({
    Expression<int>? id,
    Expression<String>? key,
    Expression<String>? value,
    Expression<DateTime>? fetchedAt,
    Expression<DateTime>? expiresAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (fetchedAt != null) 'fetched_at': fetchedAt,
      if (expiresAt != null) 'expires_at': expiresAt,
    });
  }

  RemoteConfigCacheCompanion copyWith({
    Value<int>? id,
    Value<String>? key,
    Value<String>? value,
    Value<DateTime>? fetchedAt,
    Value<DateTime?>? expiresAt,
  }) {
    return RemoteConfigCacheCompanion(
      id: id ?? this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      fetchedAt: fetchedAt ?? this.fetchedAt,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (fetchedAt.present) {
      map['fetched_at'] = Variable<DateTime>(fetchedAt.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<DateTime>(expiresAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemoteConfigCacheCompanion(')
          ..write('id: $id, ')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('fetchedAt: $fetchedAt, ')
          ..write('expiresAt: $expiresAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$RemoteConfigCacheDao extends GeneratedDatabase {
  _$RemoteConfigCacheDao(QueryExecutor e) : super(e);
  $RemoteConfigCacheDaoManager get managers =>
      $RemoteConfigCacheDaoManager(this);
  late final $RemoteConfigCacheTable remoteConfigCache =
      $RemoteConfigCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [remoteConfigCache];
}

typedef $$RemoteConfigCacheTableCreateCompanionBuilder =
    RemoteConfigCacheCompanion Function({
      Value<int> id,
      required String key,
      required String value,
      required DateTime fetchedAt,
      Value<DateTime?> expiresAt,
    });
typedef $$RemoteConfigCacheTableUpdateCompanionBuilder =
    RemoteConfigCacheCompanion Function({
      Value<int> id,
      Value<String> key,
      Value<String> value,
      Value<DateTime> fetchedAt,
      Value<DateTime?> expiresAt,
    });

class $$RemoteConfigCacheTableFilterComposer
    extends Composer<_$RemoteConfigCacheDao, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemoteConfigCacheTableOrderingComposer
    extends Composer<_$RemoteConfigCacheDao, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fetchedAt => $composableBuilder(
    column: $table.fetchedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemoteConfigCacheTableAnnotationComposer
    extends Composer<_$RemoteConfigCacheDao, $RemoteConfigCacheTable> {
  $$RemoteConfigCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get fetchedAt =>
      $composableBuilder(column: $table.fetchedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);
}

class $$RemoteConfigCacheTableTableManager
    extends
        RootTableManager<
          _$RemoteConfigCacheDao,
          $RemoteConfigCacheTable,
          RemoteConfigCacheData,
          $$RemoteConfigCacheTableFilterComposer,
          $$RemoteConfigCacheTableOrderingComposer,
          $$RemoteConfigCacheTableAnnotationComposer,
          $$RemoteConfigCacheTableCreateCompanionBuilder,
          $$RemoteConfigCacheTableUpdateCompanionBuilder,
          (
            RemoteConfigCacheData,
            BaseReferences<
              _$RemoteConfigCacheDao,
              $RemoteConfigCacheTable,
              RemoteConfigCacheData
            >,
          ),
          RemoteConfigCacheData,
          PrefetchHooks Function()
        > {
  $$RemoteConfigCacheTableTableManager(
    _$RemoteConfigCacheDao db,
    $RemoteConfigCacheTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemoteConfigCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemoteConfigCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemoteConfigCacheTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<DateTime> fetchedAt = const Value.absent(),
                Value<DateTime?> expiresAt = const Value.absent(),
              }) => RemoteConfigCacheCompanion(
                id: id,
                key: key,
                value: value,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String key,
                required String value,
                required DateTime fetchedAt,
                Value<DateTime?> expiresAt = const Value.absent(),
              }) => RemoteConfigCacheCompanion.insert(
                id: id,
                key: key,
                value: value,
                fetchedAt: fetchedAt,
                expiresAt: expiresAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemoteConfigCacheTableProcessedTableManager =
    ProcessedTableManager<
      _$RemoteConfigCacheDao,
      $RemoteConfigCacheTable,
      RemoteConfigCacheData,
      $$RemoteConfigCacheTableFilterComposer,
      $$RemoteConfigCacheTableOrderingComposer,
      $$RemoteConfigCacheTableAnnotationComposer,
      $$RemoteConfigCacheTableCreateCompanionBuilder,
      $$RemoteConfigCacheTableUpdateCompanionBuilder,
      (
        RemoteConfigCacheData,
        BaseReferences<
          _$RemoteConfigCacheDao,
          $RemoteConfigCacheTable,
          RemoteConfigCacheData
        >,
      ),
      RemoteConfigCacheData,
      PrefetchHooks Function()
    >;

class $RemoteConfigCacheDaoManager {
  final _$RemoteConfigCacheDao _db;
  $RemoteConfigCacheDaoManager(this._db);
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(_db, _db.remoteConfigCache);
}
