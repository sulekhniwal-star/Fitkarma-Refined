// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_logs_dao.dart';

// ignore_for_file: type=lint
class $StepLogsTable extends StepLogs with TableInfo<$StepLogsTable, StepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _distanceMetersMeta = const VerificationMeta(
    'distanceMeters',
  );
  @override
  late final GeneratedColumn<double> distanceMeters = GeneratedColumn<double>(
    'distance_meters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesBurnedMeta = const VerificationMeta(
    'caloriesBurned',
  );
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
    'calories_burned',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activeMinutesMeta = const VerificationMeta(
    'activeMinutes',
  );
  @override
  late final GeneratedColumn<int> activeMinutes = GeneratedColumn<int>(
    'active_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
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
    steps,
    distanceMeters,
    caloriesBurned,
    activeMinutes,
    date,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<StepLog> instance, {
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
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    } else if (isInserting) {
      context.missing(_stepsMeta);
    }
    if (data.containsKey('distance_meters')) {
      context.handle(
        _distanceMetersMeta,
        distanceMeters.isAcceptableOrUnknown(
          data['distance_meters']!,
          _distanceMetersMeta,
        ),
      );
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
        _caloriesBurnedMeta,
        caloriesBurned.isAcceptableOrUnknown(
          data['calories_burned']!,
          _caloriesBurnedMeta,
        ),
      );
    }
    if (data.containsKey('active_minutes')) {
      context.handle(
        _activeMinutesMeta,
        activeMinutes.isAcceptableOrUnknown(
          data['active_minutes']!,
          _activeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
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
  StepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      )!,
      distanceMeters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distance_meters'],
      ),
      caloriesBurned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_burned'],
      ),
      activeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}active_minutes'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
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
  $StepLogsTable createAlias(String alias) {
    return $StepLogsTable(attachedDatabase, alias);
  }
}

class StepLog extends DataClass implements Insertable<StepLog> {
  final int id;
  final String userId;
  final int steps;
  final double? distanceMeters;
  final int? caloriesBurned;
  final int? activeMinutes;
  final DateTime date;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StepLog({
    required this.id,
    required this.userId,
    required this.steps,
    this.distanceMeters,
    this.caloriesBurned,
    this.activeMinutes,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['steps'] = Variable<int>(steps);
    if (!nullToAbsent || distanceMeters != null) {
      map['distance_meters'] = Variable<double>(distanceMeters);
    }
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<int>(caloriesBurned);
    }
    if (!nullToAbsent || activeMinutes != null) {
      map['active_minutes'] = Variable<int>(activeMinutes);
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StepLogsCompanion toCompanion(bool nullToAbsent) {
    return StepLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      steps: Value(steps),
      distanceMeters: distanceMeters == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceMeters),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      activeMinutes: activeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(activeMinutes),
      date: Value(date),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      steps: serializer.fromJson<int>(json['steps']),
      distanceMeters: serializer.fromJson<double?>(json['distanceMeters']),
      caloriesBurned: serializer.fromJson<int?>(json['caloriesBurned']),
      activeMinutes: serializer.fromJson<int?>(json['activeMinutes']),
      date: serializer.fromJson<DateTime>(json['date']),
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
      'steps': serializer.toJson<int>(steps),
      'distanceMeters': serializer.toJson<double?>(distanceMeters),
      'caloriesBurned': serializer.toJson<int?>(caloriesBurned),
      'activeMinutes': serializer.toJson<int?>(activeMinutes),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StepLog copyWith({
    int? id,
    String? userId,
    int? steps,
    Value<double?> distanceMeters = const Value.absent(),
    Value<int?> caloriesBurned = const Value.absent(),
    Value<int?> activeMinutes = const Value.absent(),
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StepLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    steps: steps ?? this.steps,
    distanceMeters: distanceMeters.present
        ? distanceMeters.value
        : this.distanceMeters,
    caloriesBurned: caloriesBurned.present
        ? caloriesBurned.value
        : this.caloriesBurned,
    activeMinutes: activeMinutes.present
        ? activeMinutes.value
        : this.activeMinutes,
    date: date ?? this.date,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StepLog copyWithCompanion(StepLogsCompanion data) {
    return StepLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      steps: data.steps.present ? data.steps.value : this.steps,
      distanceMeters: data.distanceMeters.present
          ? data.distanceMeters.value
          : this.distanceMeters,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      activeMinutes: data.activeMinutes.present
          ? data.activeMinutes.value
          : this.activeMinutes,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('steps: $steps, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    steps,
    distanceMeters,
    caloriesBurned,
    activeMinutes,
    date,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.steps == this.steps &&
          other.distanceMeters == this.distanceMeters &&
          other.caloriesBurned == this.caloriesBurned &&
          other.activeMinutes == this.activeMinutes &&
          other.date == this.date &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StepLogsCompanion extends UpdateCompanion<StepLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> steps;
  final Value<double?> distanceMeters;
  final Value<int?> caloriesBurned;
  final Value<int?> activeMinutes;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const StepLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.steps = const Value.absent(),
    this.distanceMeters = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  StepLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int steps,
    this.distanceMeters = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.activeMinutes = const Value.absent(),
    required DateTime date,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       steps = Value(steps),
       date = Value(date),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StepLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? steps,
    Expression<double>? distanceMeters,
    Expression<int>? caloriesBurned,
    Expression<int>? activeMinutes,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (steps != null) 'steps': steps,
      if (distanceMeters != null) 'distance_meters': distanceMeters,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (activeMinutes != null) 'active_minutes': activeMinutes,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  StepLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? steps,
    Value<double?>? distanceMeters,
    Value<int?>? caloriesBurned,
    Value<int?>? activeMinutes,
    Value<DateTime>? date,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return StepLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      steps: steps ?? this.steps,
      distanceMeters: distanceMeters ?? this.distanceMeters,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      date: date ?? this.date,
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
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (distanceMeters.present) {
      map['distance_meters'] = Variable<double>(distanceMeters.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (activeMinutes.present) {
      map['active_minutes'] = Variable<int>(activeMinutes.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
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
    return (StringBuffer('StepLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('steps: $steps, ')
          ..write('distanceMeters: $distanceMeters, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('activeMinutes: $activeMinutes, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$StepLogsDao extends GeneratedDatabase {
  _$StepLogsDao(QueryExecutor e) : super(e);
  $StepLogsDaoManager get managers => $StepLogsDaoManager(this);
  late final $StepLogsTable stepLogs = $StepLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [stepLogs];
}

typedef $$StepLogsTableCreateCompanionBuilder =
    StepLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int steps,
      Value<double?> distanceMeters,
      Value<int?> caloriesBurned,
      Value<int?> activeMinutes,
      required DateTime date,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$StepLogsTableUpdateCompanionBuilder =
    StepLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> steps,
      Value<double?> distanceMeters,
      Value<int?> caloriesBurned,
      Value<int?> activeMinutes,
      Value<DateTime> date,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$StepLogsTableFilterComposer
    extends Composer<_$StepLogsDao, $StepLogsTable> {
  $$StepLogsTableFilterComposer({
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

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activeMinutes => $composableBuilder(
    column: $table.activeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
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

class $$StepLogsTableOrderingComposer
    extends Composer<_$StepLogsDao, $StepLogsTable> {
  $$StepLogsTableOrderingComposer({
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

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activeMinutes => $composableBuilder(
    column: $table.activeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
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

class $$StepLogsTableAnnotationComposer
    extends Composer<_$StepLogsDao, $StepLogsTable> {
  $$StepLogsTableAnnotationComposer({
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

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<double> get distanceMeters => $composableBuilder(
    column: $table.distanceMeters,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get activeMinutes => $composableBuilder(
    column: $table.activeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StepLogsTableTableManager
    extends
        RootTableManager<
          _$StepLogsDao,
          $StepLogsTable,
          StepLog,
          $$StepLogsTableFilterComposer,
          $$StepLogsTableOrderingComposer,
          $$StepLogsTableAnnotationComposer,
          $$StepLogsTableCreateCompanionBuilder,
          $$StepLogsTableUpdateCompanionBuilder,
          (StepLog, BaseReferences<_$StepLogsDao, $StepLogsTable, StepLog>),
          StepLog,
          PrefetchHooks Function()
        > {
  $$StepLogsTableTableManager(_$StepLogsDao db, $StepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> steps = const Value.absent(),
                Value<double?> distanceMeters = const Value.absent(),
                Value<int?> caloriesBurned = const Value.absent(),
                Value<int?> activeMinutes = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => StepLogsCompanion(
                id: id,
                userId: userId,
                steps: steps,
                distanceMeters: distanceMeters,
                caloriesBurned: caloriesBurned,
                activeMinutes: activeMinutes,
                date: date,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int steps,
                Value<double?> distanceMeters = const Value.absent(),
                Value<int?> caloriesBurned = const Value.absent(),
                Value<int?> activeMinutes = const Value.absent(),
                required DateTime date,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => StepLogsCompanion.insert(
                id: id,
                userId: userId,
                steps: steps,
                distanceMeters: distanceMeters,
                caloriesBurned: caloriesBurned,
                activeMinutes: activeMinutes,
                date: date,
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

typedef $$StepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$StepLogsDao,
      $StepLogsTable,
      StepLog,
      $$StepLogsTableFilterComposer,
      $$StepLogsTableOrderingComposer,
      $$StepLogsTableAnnotationComposer,
      $$StepLogsTableCreateCompanionBuilder,
      $$StepLogsTableUpdateCompanionBuilder,
      (StepLog, BaseReferences<_$StepLogsDao, $StepLogsTable, StepLog>),
      StepLog,
      PrefetchHooks Function()
    >;

class $StepLogsDaoManager {
  final _$StepLogsDao _db;
  $StepLogsDaoManager(this._db);
  $$StepLogsTableTableManager get stepLogs =>
      $$StepLogsTableTableManager(_db, _db.stepLogs);
}
