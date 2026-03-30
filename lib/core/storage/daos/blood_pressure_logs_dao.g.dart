// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_logs_dao.dart';

// ignore_for_file: type=lint
class $BloodPressureLogsTable extends BloodPressureLogs
    with TableInfo<$BloodPressureLogsTable, BloodPressureLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BloodPressureLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _systolicMeta = const VerificationMeta(
    'systolic',
  );
  @override
  late final GeneratedColumn<int> systolic = GeneratedColumn<int>(
    'systolic',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diastolicMeta = const VerificationMeta(
    'diastolic',
  );
  @override
  late final GeneratedColumn<int> diastolic = GeneratedColumn<int>(
    'diastolic',
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
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _armMeta = const VerificationMeta('arm');
  @override
  late final GeneratedColumn<String> arm = GeneratedColumn<String>(
    'arm',
    aliasedName,
    true,
    type: DriftSqlType.string,
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
    systolic,
    diastolic,
    heartRate,
    position,
    arm,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'blood_pressure_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<BloodPressureLog> instance, {
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
    if (data.containsKey('systolic')) {
      context.handle(
        _systolicMeta,
        systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta),
      );
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(
        _diastolicMeta,
        diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta),
      );
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('heart_rate')) {
      context.handle(
        _heartRateMeta,
        heartRate.isAcceptableOrUnknown(data['heart_rate']!, _heartRateMeta),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('arm')) {
      context.handle(
        _armMeta,
        arm.isAcceptableOrUnknown(data['arm']!, _armMeta),
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
  BloodPressureLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BloodPressureLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      systolic: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}systolic'],
      )!,
      diastolic: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}diastolic'],
      )!,
      heartRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      arm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}arm'],
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
  $BloodPressureLogsTable createAlias(String alias) {
    return $BloodPressureLogsTable(attachedDatabase, alias);
  }
}

class BloodPressureLog extends DataClass
    implements Insertable<BloodPressureLog> {
  final int id;
  final String userId;
  final int systolic;
  final int diastolic;
  final int? heartRate;
  final String? position;
  final String? arm;
  final String? notes;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BloodPressureLog({
    required this.id,
    required this.userId,
    required this.systolic,
    required this.diastolic,
    this.heartRate,
    this.position,
    this.arm,
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
    map['systolic'] = Variable<int>(systolic);
    map['diastolic'] = Variable<int>(diastolic);
    if (!nullToAbsent || heartRate != null) {
      map['heart_rate'] = Variable<int>(heartRate);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || arm != null) {
      map['arm'] = Variable<String>(arm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BloodPressureLogsCompanion toCompanion(bool nullToAbsent) {
    return BloodPressureLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      systolic: Value(systolic),
      diastolic: Value(diastolic),
      heartRate: heartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRate),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      arm: arm == null && nullToAbsent ? const Value.absent() : Value(arm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BloodPressureLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BloodPressureLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      systolic: serializer.fromJson<int>(json['systolic']),
      diastolic: serializer.fromJson<int>(json['diastolic']),
      heartRate: serializer.fromJson<int?>(json['heartRate']),
      position: serializer.fromJson<String?>(json['position']),
      arm: serializer.fromJson<String?>(json['arm']),
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
      'systolic': serializer.toJson<int>(systolic),
      'diastolic': serializer.toJson<int>(diastolic),
      'heartRate': serializer.toJson<int?>(heartRate),
      'position': serializer.toJson<String?>(position),
      'arm': serializer.toJson<String?>(arm),
      'notes': serializer.toJson<String?>(notes),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BloodPressureLog copyWith({
    int? id,
    String? userId,
    int? systolic,
    int? diastolic,
    Value<int?> heartRate = const Value.absent(),
    Value<String?> position = const Value.absent(),
    Value<String?> arm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BloodPressureLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    systolic: systolic ?? this.systolic,
    diastolic: diastolic ?? this.diastolic,
    heartRate: heartRate.present ? heartRate.value : this.heartRate,
    position: position.present ? position.value : this.position,
    arm: arm.present ? arm.value : this.arm,
    notes: notes.present ? notes.value : this.notes,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BloodPressureLog copyWithCompanion(BloodPressureLogsCompanion data) {
    return BloodPressureLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      heartRate: data.heartRate.present ? data.heartRate.value : this.heartRate,
      position: data.position.present ? data.position.value : this.position,
      arm: data.arm.present ? data.arm.value : this.arm,
      notes: data.notes.present ? data.notes.value : this.notes,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BloodPressureLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('heartRate: $heartRate, ')
          ..write('position: $position, ')
          ..write('arm: $arm, ')
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
    systolic,
    diastolic,
    heartRate,
    position,
    arm,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BloodPressureLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.heartRate == this.heartRate &&
          other.position == this.position &&
          other.arm == this.arm &&
          other.notes == this.notes &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BloodPressureLogsCompanion extends UpdateCompanion<BloodPressureLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> systolic;
  final Value<int> diastolic;
  final Value<int?> heartRate;
  final Value<String?> position;
  final Value<String?> arm;
  final Value<String?> notes;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BloodPressureLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.heartRate = const Value.absent(),
    this.position = const Value.absent(),
    this.arm = const Value.absent(),
    this.notes = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BloodPressureLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int systolic,
    required int diastolic,
    this.heartRate = const Value.absent(),
    this.position = const Value.absent(),
    this.arm = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       systolic = Value(systolic),
       diastolic = Value(diastolic),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BloodPressureLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? systolic,
    Expression<int>? diastolic,
    Expression<int>? heartRate,
    Expression<String>? position,
    Expression<String>? arm,
    Expression<String>? notes,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (heartRate != null) 'heart_rate': heartRate,
      if (position != null) 'position': position,
      if (arm != null) 'arm': arm,
      if (notes != null) 'notes': notes,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BloodPressureLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? systolic,
    Value<int>? diastolic,
    Value<int?>? heartRate,
    Value<String?>? position,
    Value<String?>? arm,
    Value<String?>? notes,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BloodPressureLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      heartRate: heartRate ?? this.heartRate,
      position: position ?? this.position,
      arm: arm ?? this.arm,
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
    if (systolic.present) {
      map['systolic'] = Variable<int>(systolic.value);
    }
    if (diastolic.present) {
      map['diastolic'] = Variable<int>(diastolic.value);
    }
    if (heartRate.present) {
      map['heart_rate'] = Variable<int>(heartRate.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (arm.present) {
      map['arm'] = Variable<String>(arm.value);
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
    return (StringBuffer('BloodPressureLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('heartRate: $heartRate, ')
          ..write('position: $position, ')
          ..write('arm: $arm, ')
          ..write('notes: $notes, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$BloodPressureLogsDao extends GeneratedDatabase {
  _$BloodPressureLogsDao(QueryExecutor e) : super(e);
  $BloodPressureLogsDaoManager get managers =>
      $BloodPressureLogsDaoManager(this);
  late final $BloodPressureLogsTable bloodPressureLogs =
      $BloodPressureLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [bloodPressureLogs];
}

typedef $$BloodPressureLogsTableCreateCompanionBuilder =
    BloodPressureLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int systolic,
      required int diastolic,
      Value<int?> heartRate,
      Value<String?> position,
      Value<String?> arm,
      Value<String?> notes,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$BloodPressureLogsTableUpdateCompanionBuilder =
    BloodPressureLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> systolic,
      Value<int> diastolic,
      Value<int?> heartRate,
      Value<String?> position,
      Value<String?> arm,
      Value<String?> notes,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BloodPressureLogsTableFilterComposer
    extends Composer<_$BloodPressureLogsDao, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableFilterComposer({
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

  ColumnFilters<int> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get arm => $composableBuilder(
    column: $table.arm,
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

class $$BloodPressureLogsTableOrderingComposer
    extends Composer<_$BloodPressureLogsDao, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableOrderingComposer({
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

  ColumnOrderings<int> get systolic => $composableBuilder(
    column: $table.systolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get diastolic => $composableBuilder(
    column: $table.diastolic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRate => $composableBuilder(
    column: $table.heartRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get arm => $composableBuilder(
    column: $table.arm,
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

class $$BloodPressureLogsTableAnnotationComposer
    extends Composer<_$BloodPressureLogsDao, $BloodPressureLogsTable> {
  $$BloodPressureLogsTableAnnotationComposer({
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

  GeneratedColumn<int> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<int> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get heartRate =>
      $composableBuilder(column: $table.heartRate, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get arm =>
      $composableBuilder(column: $table.arm, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BloodPressureLogsTableTableManager
    extends
        RootTableManager<
          _$BloodPressureLogsDao,
          $BloodPressureLogsTable,
          BloodPressureLog,
          $$BloodPressureLogsTableFilterComposer,
          $$BloodPressureLogsTableOrderingComposer,
          $$BloodPressureLogsTableAnnotationComposer,
          $$BloodPressureLogsTableCreateCompanionBuilder,
          $$BloodPressureLogsTableUpdateCompanionBuilder,
          (
            BloodPressureLog,
            BaseReferences<
              _$BloodPressureLogsDao,
              $BloodPressureLogsTable,
              BloodPressureLog
            >,
          ),
          BloodPressureLog,
          PrefetchHooks Function()
        > {
  $$BloodPressureLogsTableTableManager(
    _$BloodPressureLogsDao db,
    $BloodPressureLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BloodPressureLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BloodPressureLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BloodPressureLogsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> systolic = const Value.absent(),
                Value<int> diastolic = const Value.absent(),
                Value<int?> heartRate = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> arm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BloodPressureLogsCompanion(
                id: id,
                userId: userId,
                systolic: systolic,
                diastolic: diastolic,
                heartRate: heartRate,
                position: position,
                arm: arm,
                notes: notes,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int systolic,
                required int diastolic,
                Value<int?> heartRate = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> arm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BloodPressureLogsCompanion.insert(
                id: id,
                userId: userId,
                systolic: systolic,
                diastolic: diastolic,
                heartRate: heartRate,
                position: position,
                arm: arm,
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

typedef $$BloodPressureLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloodPressureLogsDao,
      $BloodPressureLogsTable,
      BloodPressureLog,
      $$BloodPressureLogsTableFilterComposer,
      $$BloodPressureLogsTableOrderingComposer,
      $$BloodPressureLogsTableAnnotationComposer,
      $$BloodPressureLogsTableCreateCompanionBuilder,
      $$BloodPressureLogsTableUpdateCompanionBuilder,
      (
        BloodPressureLog,
        BaseReferences<
          _$BloodPressureLogsDao,
          $BloodPressureLogsTable,
          BloodPressureLog
        >,
      ),
      BloodPressureLog,
      PrefetchHooks Function()
    >;

class $BloodPressureLogsDaoManager {
  final _$BloodPressureLogsDao _db;
  $BloodPressureLogsDaoManager(this._db);
  $$BloodPressureLogsTableTableManager get bloodPressureLogs =>
      $$BloodPressureLogsTableTableManager(_db, _db.bloodPressureLogs);
}
