// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mood_logs_dao.dart';

// ignore_for_file: type=lint
class $MoodLogsTable extends MoodLogs with TableInfo<$MoodLogsTable, MoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MoodLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _moodScoreMeta = const VerificationMeta(
    'moodScore',
  );
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
    'mood_score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodLabelMeta = const VerificationMeta(
    'moodLabel',
  );
  @override
  late final GeneratedColumn<String> moodLabel = GeneratedColumn<String>(
    'mood_label',
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
  static const VerificationMeta _energyLevelMeta = const VerificationMeta(
    'energyLevel',
  );
  @override
  late final GeneratedColumn<int> energyLevel = GeneratedColumn<int>(
    'energy_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stressLevelMeta = const VerificationMeta(
    'stressLevel',
  );
  @override
  late final GeneratedColumn<int> stressLevel = GeneratedColumn<int>(
    'stress_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _factorsMeta = const VerificationMeta(
    'factors',
  );
  @override
  late final GeneratedColumn<String> factors = GeneratedColumn<String>(
    'factors',
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
    moodScore,
    moodLabel,
    notes,
    energyLevel,
    stressLevel,
    factors,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mood_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MoodLog> instance, {
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
    if (data.containsKey('mood_score')) {
      context.handle(
        _moodScoreMeta,
        moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_moodScoreMeta);
    }
    if (data.containsKey('mood_label')) {
      context.handle(
        _moodLabelMeta,
        moodLabel.isAcceptableOrUnknown(data['mood_label']!, _moodLabelMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('energy_level')) {
      context.handle(
        _energyLevelMeta,
        energyLevel.isAcceptableOrUnknown(
          data['energy_level']!,
          _energyLevelMeta,
        ),
      );
    }
    if (data.containsKey('stress_level')) {
      context.handle(
        _stressLevelMeta,
        stressLevel.isAcceptableOrUnknown(
          data['stress_level']!,
          _stressLevelMeta,
        ),
      );
    }
    if (data.containsKey('factors')) {
      context.handle(
        _factorsMeta,
        factors.isAcceptableOrUnknown(data['factors']!, _factorsMeta),
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
  MoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      moodScore: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_score'],
      )!,
      moodLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood_label'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      energyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}energy_level'],
      ),
      stressLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stress_level'],
      ),
      factors: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}factors'],
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
  $MoodLogsTable createAlias(String alias) {
    return $MoodLogsTable(attachedDatabase, alias);
  }
}

class MoodLog extends DataClass implements Insertable<MoodLog> {
  final int id;
  final String userId;
  final int moodScore;
  final String? moodLabel;
  final String? notes;
  final int? energyLevel;
  final int? stressLevel;
  final String? factors;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MoodLog({
    required this.id,
    required this.userId,
    required this.moodScore,
    this.moodLabel,
    this.notes,
    this.energyLevel,
    this.stressLevel,
    this.factors,
    required this.loggedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['mood_score'] = Variable<int>(moodScore);
    if (!nullToAbsent || moodLabel != null) {
      map['mood_label'] = Variable<String>(moodLabel);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || energyLevel != null) {
      map['energy_level'] = Variable<int>(energyLevel);
    }
    if (!nullToAbsent || stressLevel != null) {
      map['stress_level'] = Variable<int>(stressLevel);
    }
    if (!nullToAbsent || factors != null) {
      map['factors'] = Variable<String>(factors);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MoodLogsCompanion toCompanion(bool nullToAbsent) {
    return MoodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      moodScore: Value(moodScore),
      moodLabel: moodLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(moodLabel),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      energyLevel: energyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(energyLevel),
      stressLevel: stressLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(stressLevel),
      factors: factors == null && nullToAbsent
          ? const Value.absent()
          : Value(factors),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MoodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      moodScore: serializer.fromJson<int>(json['moodScore']),
      moodLabel: serializer.fromJson<String?>(json['moodLabel']),
      notes: serializer.fromJson<String?>(json['notes']),
      energyLevel: serializer.fromJson<int?>(json['energyLevel']),
      stressLevel: serializer.fromJson<int?>(json['stressLevel']),
      factors: serializer.fromJson<String?>(json['factors']),
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
      'moodScore': serializer.toJson<int>(moodScore),
      'moodLabel': serializer.toJson<String?>(moodLabel),
      'notes': serializer.toJson<String?>(notes),
      'energyLevel': serializer.toJson<int?>(energyLevel),
      'stressLevel': serializer.toJson<int?>(stressLevel),
      'factors': serializer.toJson<String?>(factors),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MoodLog copyWith({
    int? id,
    String? userId,
    int? moodScore,
    Value<String?> moodLabel = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<int?> energyLevel = const Value.absent(),
    Value<int?> stressLevel = const Value.absent(),
    Value<String?> factors = const Value.absent(),
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MoodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    moodScore: moodScore ?? this.moodScore,
    moodLabel: moodLabel.present ? moodLabel.value : this.moodLabel,
    notes: notes.present ? notes.value : this.notes,
    energyLevel: energyLevel.present ? energyLevel.value : this.energyLevel,
    stressLevel: stressLevel.present ? stressLevel.value : this.stressLevel,
    factors: factors.present ? factors.value : this.factors,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MoodLog copyWithCompanion(MoodLogsCompanion data) {
    return MoodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      moodLabel: data.moodLabel.present ? data.moodLabel.value : this.moodLabel,
      notes: data.notes.present ? data.notes.value : this.notes,
      energyLevel: data.energyLevel.present
          ? data.energyLevel.value
          : this.energyLevel,
      stressLevel: data.stressLevel.present
          ? data.stressLevel.value
          : this.stressLevel,
      factors: data.factors.present ? data.factors.value : this.factors,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MoodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('moodScore: $moodScore, ')
          ..write('moodLabel: $moodLabel, ')
          ..write('notes: $notes, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('factors: $factors, ')
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
    moodScore,
    moodLabel,
    notes,
    energyLevel,
    stressLevel,
    factors,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MoodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.moodScore == this.moodScore &&
          other.moodLabel == this.moodLabel &&
          other.notes == this.notes &&
          other.energyLevel == this.energyLevel &&
          other.stressLevel == this.stressLevel &&
          other.factors == this.factors &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MoodLogsCompanion extends UpdateCompanion<MoodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> moodScore;
  final Value<String?> moodLabel;
  final Value<String?> notes;
  final Value<int?> energyLevel;
  final Value<int?> stressLevel;
  final Value<String?> factors;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MoodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.moodLabel = const Value.absent(),
    this.notes = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.factors = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MoodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int moodScore,
    this.moodLabel = const Value.absent(),
    this.notes = const Value.absent(),
    this.energyLevel = const Value.absent(),
    this.stressLevel = const Value.absent(),
    this.factors = const Value.absent(),
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       moodScore = Value(moodScore),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MoodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? moodScore,
    Expression<String>? moodLabel,
    Expression<String>? notes,
    Expression<int>? energyLevel,
    Expression<int>? stressLevel,
    Expression<String>? factors,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (moodScore != null) 'mood_score': moodScore,
      if (moodLabel != null) 'mood_label': moodLabel,
      if (notes != null) 'notes': notes,
      if (energyLevel != null) 'energy_level': energyLevel,
      if (stressLevel != null) 'stress_level': stressLevel,
      if (factors != null) 'factors': factors,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MoodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? moodScore,
    Value<String?>? moodLabel,
    Value<String?>? notes,
    Value<int?>? energyLevel,
    Value<int?>? stressLevel,
    Value<String?>? factors,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MoodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      moodScore: moodScore ?? this.moodScore,
      moodLabel: moodLabel ?? this.moodLabel,
      notes: notes ?? this.notes,
      energyLevel: energyLevel ?? this.energyLevel,
      stressLevel: stressLevel ?? this.stressLevel,
      factors: factors ?? this.factors,
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
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (moodLabel.present) {
      map['mood_label'] = Variable<String>(moodLabel.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (energyLevel.present) {
      map['energy_level'] = Variable<int>(energyLevel.value);
    }
    if (stressLevel.present) {
      map['stress_level'] = Variable<int>(stressLevel.value);
    }
    if (factors.present) {
      map['factors'] = Variable<String>(factors.value);
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
    return (StringBuffer('MoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('moodScore: $moodScore, ')
          ..write('moodLabel: $moodLabel, ')
          ..write('notes: $notes, ')
          ..write('energyLevel: $energyLevel, ')
          ..write('stressLevel: $stressLevel, ')
          ..write('factors: $factors, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$MoodLogsDao extends GeneratedDatabase {
  _$MoodLogsDao(QueryExecutor e) : super(e);
  $MoodLogsDaoManager get managers => $MoodLogsDaoManager(this);
  late final $MoodLogsTable moodLogs = $MoodLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [moodLogs];
}

typedef $$MoodLogsTableCreateCompanionBuilder =
    MoodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required int moodScore,
      Value<String?> moodLabel,
      Value<String?> notes,
      Value<int?> energyLevel,
      Value<int?> stressLevel,
      Value<String?> factors,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MoodLogsTableUpdateCompanionBuilder =
    MoodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> moodScore,
      Value<String?> moodLabel,
      Value<String?> notes,
      Value<int?> energyLevel,
      Value<int?> stressLevel,
      Value<String?> factors,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MoodLogsTableFilterComposer
    extends Composer<_$MoodLogsDao, $MoodLogsTable> {
  $$MoodLogsTableFilterComposer({
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

  ColumnFilters<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get moodLabel => $composableBuilder(
    column: $table.moodLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get factors => $composableBuilder(
    column: $table.factors,
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

class $$MoodLogsTableOrderingComposer
    extends Composer<_$MoodLogsDao, $MoodLogsTable> {
  $$MoodLogsTableOrderingComposer({
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

  ColumnOrderings<int> get moodScore => $composableBuilder(
    column: $table.moodScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moodLabel => $composableBuilder(
    column: $table.moodLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get factors => $composableBuilder(
    column: $table.factors,
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

class $$MoodLogsTableAnnotationComposer
    extends Composer<_$MoodLogsDao, $MoodLogsTable> {
  $$MoodLogsTableAnnotationComposer({
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

  GeneratedColumn<int> get moodScore =>
      $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<String> get moodLabel =>
      $composableBuilder(column: $table.moodLabel, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get energyLevel => $composableBuilder(
    column: $table.energyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get stressLevel => $composableBuilder(
    column: $table.stressLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get factors =>
      $composableBuilder(column: $table.factors, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MoodLogsTableTableManager
    extends
        RootTableManager<
          _$MoodLogsDao,
          $MoodLogsTable,
          MoodLog,
          $$MoodLogsTableFilterComposer,
          $$MoodLogsTableOrderingComposer,
          $$MoodLogsTableAnnotationComposer,
          $$MoodLogsTableCreateCompanionBuilder,
          $$MoodLogsTableUpdateCompanionBuilder,
          (MoodLog, BaseReferences<_$MoodLogsDao, $MoodLogsTable, MoodLog>),
          MoodLog,
          PrefetchHooks Function()
        > {
  $$MoodLogsTableTableManager(_$MoodLogsDao db, $MoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> moodScore = const Value.absent(),
                Value<String?> moodLabel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<int?> stressLevel = const Value.absent(),
                Value<String?> factors = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MoodLogsCompanion(
                id: id,
                userId: userId,
                moodScore: moodScore,
                moodLabel: moodLabel,
                notes: notes,
                energyLevel: energyLevel,
                stressLevel: stressLevel,
                factors: factors,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int moodScore,
                Value<String?> moodLabel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int?> energyLevel = const Value.absent(),
                Value<int?> stressLevel = const Value.absent(),
                Value<String?> factors = const Value.absent(),
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MoodLogsCompanion.insert(
                id: id,
                userId: userId,
                moodScore: moodScore,
                moodLabel: moodLabel,
                notes: notes,
                energyLevel: energyLevel,
                stressLevel: stressLevel,
                factors: factors,
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

typedef $$MoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$MoodLogsDao,
      $MoodLogsTable,
      MoodLog,
      $$MoodLogsTableFilterComposer,
      $$MoodLogsTableOrderingComposer,
      $$MoodLogsTableAnnotationComposer,
      $$MoodLogsTableCreateCompanionBuilder,
      $$MoodLogsTableUpdateCompanionBuilder,
      (MoodLog, BaseReferences<_$MoodLogsDao, $MoodLogsTable, MoodLog>),
      MoodLog,
      PrefetchHooks Function()
    >;

class $MoodLogsDaoManager {
  final _$MoodLogsDao _db;
  $MoodLogsDaoManager(this._db);
  $$MoodLogsTableTableManager get moodLogs =>
      $$MoodLogsTableTableManager(_db, _db.moodLogs);
}
