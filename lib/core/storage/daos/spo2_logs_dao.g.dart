// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spo2_logs_dao.dart';

// ignore_for_file: type=lint
class $Spo2LogsTable extends Spo2Logs with TableInfo<$Spo2LogsTable, Spo2Log> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Spo2LogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _spo2PercentMeta = const VerificationMeta(
    'spo2Percent',
  );
  @override
  late final GeneratedColumn<int> spo2Percent = GeneratedColumn<int>(
    'spo2_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heartRateMeta = const VerificationMeta(
    'heartRate',
  );
  @override
  late final GeneratedColumn<int> heartRate = GeneratedColumn<int>(
    'heart_rate',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loggedAtMeta = const VerificationMeta(
    'loggedAt',
  );
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
    'logged_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    spo2Percent,
    heartRate,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spo2_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Spo2Log> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('spo2_percent')) {
      context.handle(
        _spo2PercentMeta,
        spo2Percent.isAcceptableOrUnknown(
          data['spo2_percent']!,
          _spo2PercentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_spo2PercentMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('logged_at')) {
      context.handle(
        _loggedAtMeta,
        loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spo2Log map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spo2Log(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      spo2Percent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}spo2_percent'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $Spo2LogsTable createAlias(String alias) {
    return $Spo2LogsTable(attachedDatabase, alias);
  }
}

class Spo2Log extends DataClass implements Insertable<Spo2Log> {
  final int id;
  final String userId;
  final int spo2Percent;
  final int? heartRate;
  final String? notes;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Spo2Log({
    required this.id,
    required this.userId,
    required this.spo2Percent,
    this.heartRate,
    this.notes,
    required this.loggedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['spo2_percent'] = Variable<int>(spo2Percent);
    if (!nullToAbsent || heartRate != null) {
      map['heart_rate'] = Variable<int>(heartRate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  Spo2LogsCompanion toCompanion(bool nullToAbsent) {
    return Spo2LogsCompanion(
      id: Value(id),
      userId: Value(userId),
      spo2Percent: Value(spo2Percent),
      heartRate: heartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRate),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Spo2Log.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spo2Log(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      spo2Percent: serializer.fromJson<int>(json['spo2Percent']),
      heartRate: serializer.fromJson<int?>(json['heartRate']),
      notes: serializer.fromJson<String?>(json['notes']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'spo2Percent': serializer.toJson<int>(spo2Percent),
      'heartRate': serializer.toJson<int?>(heartRate),
      'notes': serializer.toJson<String?>(notes),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Spo2Log copyWith({
    int? id,
    String? userId,
    int? spo2Percent,
    Value<int?> heartRate = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Spo2Log(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    spo2Percent: spo2Percent ?? this.spo2Percent,
    heartRate: heartRate.present ? heartRate.value : this.heartRate,
    notes: notes.present ? notes.value : this.notes,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Spo2Log copyWithCompanion(Spo2LogsCompanion data) {
    return Spo2Log(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      spo2Percent: data.spo2Percent.present
          ? data.spo2Percent.value
          : this.spo2Percent,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      notes: data.notes.present ? data.notes.value : this.notes,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spo2Log(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percent: $spo2Percent, ')
          ..write('heartRate: $heartRate, ')
          ..write('notes: $notes, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    spo2Percent,
    heartRate,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spo2Log &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.spo2Percent == this.spo2Percent &&
          other.heartRate == this.heartRate &&
          other.notes == this.notes &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class Spo2LogsCompanion extends UpdateCompanion<Spo2Log> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> spo2Percent;
  final Value<int?> heartRate;
  final Value<String?> notes;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const Spo2LogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.spo2Percent = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.notes = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  Spo2LogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int spo2Percent,
    this.heartRate = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       spo2Percent = Value(spo2Percent),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Spo2Log> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? spo2Percent,
    Expression<int>? heartRate,
    Expression<String>? notes,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (spo2Percent != null) 'spo2_percent': spo2Percent,
      if (heartRate != null) 'heart_rate': heartRate,
      if (notes != null) 'notes': notes,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  Spo2LogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? spo2Percent,
    Value<int?>? heartRate,
    Value<String?>? notes,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return Spo2LogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      spo2Percent: spo2Percent ?? this.spo2Percent,
      heartRate: heartRate ?? this.heartRate,
      notes: notes ?? this.notes,
      loggedAt: loggedAt ?? this.loggedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (spo2Percent.present) {
      map['spo2_percent'] = Variable<int>(spo2Percent.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Spo2LogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percent: $spo2Percent, ')
          ..write('heartRate: $heartRate, ')
          ..write('notes: $notes, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$Spo2LogsDao extends GeneratedDatabase {
  _$Spo2LogsDao(QueryExecutor e) : super(e);
  $Spo2LogsDaoManager get managers => $Spo2LogsDaoManager(this);
  late final $Spo2LogsTable spo2Logs = $Spo2LogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [spo2Logs];
}

typedef $$Spo2LogsTableCreateCompanionBuilder =
    Spo2LogsCompanion Function({
      Value<int> id,
      required String userId,
      required int spo2Percent,
      Value<int?> heartRate,
      Value<String?> notes,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$Spo2LogsTableUpdateCompanionBuilder =
    Spo2LogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> spo2Percent,
      Value<int?> heartRate,
      Value<String?> notes,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$Spo2LogsTableFilterComposer
    extends Composer<_$Spo2LogsDao, $Spo2LogsTable> {
  $$Spo2LogsTableFilterComposer({
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

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$Spo2LogsTableOrderingComposer
    extends Composer<_$Spo2LogsDao, $Spo2LogsTable> {
  $$Spo2LogsTableOrderingComposer({
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

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$Spo2LogsTableAnnotationComposer
    extends Composer<_$Spo2LogsDao, $Spo2LogsTable> {
  $$Spo2LogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get spo2Percent => $composableBuilder(
    column: $table.spo2Percent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$Spo2LogsTableTableManager
    extends
        RootTableManager<
          _$Spo2LogsDao,
          $Spo2LogsTable,
          Spo2Log,
          $$Spo2LogsTableFilterComposer,
          $$Spo2LogsTableOrderingComposer,
          $$Spo2LogsTableAnnotationComposer,
          $$Spo2LogsTableCreateCompanionBuilder,
          $$Spo2LogsTableUpdateCompanionBuilder,
          (Spo2Log, BaseReferences<_$Spo2LogsDao, $Spo2LogsTable, Spo2Log>),
          Spo2Log,
          PrefetchHooks Function()
        > {
  $$Spo2LogsTableTableManager(_$Spo2LogsDao db, $Spo2LogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Spo2LogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Spo2LogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Spo2LogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> spo2Percent = const Value.absent(),
                Value<int?> heartRate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => Spo2LogsCompanion(
                id: id,
                userId: userId,
                spo2Percent: spo2Percent,
                heartRate: heartRate,
                notes: notes,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int spo2Percent,
                Value<int?> heartRate = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => Spo2LogsCompanion.insert(
                id: id,
                userId: userId,
                spo2Percent: spo2Percent,
                heartRate: heartRate,
                notes: notes,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$Spo2LogsTableProcessedTableManager =
    ProcessedTableManager<
      _$Spo2LogsDao,
      $Spo2LogsTable,
      Spo2Log,
      $$Spo2LogsTableFilterComposer,
      $$Spo2LogsTableOrderingComposer,
      $$Spo2LogsTableAnnotationComposer,
      $$Spo2LogsTableCreateCompanionBuilder,
      $$Spo2LogsTableUpdateCompanionBuilder,
      (Spo2Log, BaseReferences<_$Spo2LogsDao, $Spo2LogsTable, Spo2Log>),
      Spo2Log,
      PrefetchHooks Function()
    >;

class $Spo2LogsDaoManager {
  final _$Spo2LogsDao _db;
  $Spo2LogsDaoManager(this._db);
  $$Spo2LogsTableTableManager get spo2Logs =>
      $$Spo2LogsTableTableManager(_db, _db.spo2Logs);
}
