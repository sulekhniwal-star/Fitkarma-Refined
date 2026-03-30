// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_transactions_dao.dart';

// ignore_for_file: type=lint
class $KarmaTransactionsTable extends KarmaTransactions
    with TableInfo<$KarmaTransactionsTable, KarmaTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KarmaTransactionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
    'points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionTypeMeta = const VerificationMeta(
    'transactionType',
  );
  @override
  late final GeneratedColumn<String> transactionType = GeneratedColumn<String>(
    'transaction_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceIdMeta = const VerificationMeta(
    'referenceId',
  );
  @override
  late final GeneratedColumn<int> referenceId = GeneratedColumn<int>(
    'reference_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _referenceTypeMeta = const VerificationMeta(
    'referenceType',
  );
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
    'reference_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    points,
    transactionType,
    source,
    referenceId,
    referenceType,
    description,
    transactionDate,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'karma_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<KarmaTransaction> instance, {
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
    if (data.containsKey('points')) {
      context.handle(
        _pointsMeta,
        points.isAcceptableOrUnknown(data['points']!, _pointsMeta),
      );
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('transaction_type')) {
      context.handle(
        _transactionTypeMeta,
        transactionType.isAcceptableOrUnknown(
          data['transaction_type']!,
          _transactionTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionTypeMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('reference_id')) {
      context.handle(
        _referenceIdMeta,
        referenceId.isAcceptableOrUnknown(
          data['reference_id']!,
          _referenceIdMeta,
        ),
      );
    }
    if (data.containsKey('reference_type')) {
      context.handle(
        _referenceTypeMeta,
        referenceType.isAcceptableOrUnknown(
          data['reference_type']!,
          _referenceTypeMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KarmaTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KarmaTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      points: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}points'],
      )!,
      transactionType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_type'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      referenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reference_id'],
      ),
      referenceType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_type'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $KarmaTransactionsTable createAlias(String alias) {
    return $KarmaTransactionsTable(attachedDatabase, alias);
  }
}

class KarmaTransaction extends DataClass
    implements Insertable<KarmaTransaction> {
  final int id;
  final String userId;
  final int points;
  final String transactionType;
  final String source;
  final int? referenceId;
  final String? referenceType;
  final String? description;
  final DateTime transactionDate;
  final DateTime createdAt;
  const KarmaTransaction({
    required this.id,
    required this.userId,
    required this.points,
    required this.transactionType,
    required this.source,
    this.referenceId,
    this.referenceType,
    this.description,
    required this.transactionDate,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['points'] = Variable<int>(points);
    map['transaction_type'] = Variable<String>(transactionType);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<int>(referenceId);
    }
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KarmaTransactionsCompanion toCompanion(bool nullToAbsent) {
    return KarmaTransactionsCompanion(
      id: Value(id),
      userId: Value(userId),
      points: Value(points),
      transactionType: Value(transactionType),
      source: Value(source),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      transactionDate: Value(transactionDate),
      createdAt: Value(createdAt),
    );
  }

  factory KarmaTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KarmaTransaction(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      points: serializer.fromJson<int>(json['points']),
      transactionType: serializer.fromJson<String>(json['transactionType']),
      source: serializer.fromJson<String>(json['source']),
      referenceId: serializer.fromJson<int?>(json['referenceId']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      description: serializer.fromJson<String?>(json['description']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<String>(userId),
      'points': serializer.toJson<int>(points),
      'transactionType': serializer.toJson<String>(transactionType),
      'source': serializer.toJson<String>(source),
      'referenceId': serializer.toJson<int?>(referenceId),
      'referenceType': serializer.toJson<String?>(referenceType),
      'description': serializer.toJson<String?>(description),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KarmaTransaction copyWith({
    int? id,
    String? userId,
    int? points,
    String? transactionType,
    String? source,
    Value<int?> referenceId = const Value.absent(),
    Value<String?> referenceType = const Value.absent(),
    Value<String?> description = const Value.absent(),
    DateTime? transactionDate,
    DateTime? createdAt,
  }) => KarmaTransaction(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    points: points ?? this.points,
    transactionType: transactionType ?? this.transactionType,
    source: source ?? this.source,
    referenceId: referenceId.present ? referenceId.value : this.referenceId,
    referenceType: referenceType.present
        ? referenceType.value
        : this.referenceType,
    description: description.present ? description.value : this.description,
    transactionDate: transactionDate ?? this.transactionDate,
    createdAt: createdAt ?? this.createdAt,
  );
  KarmaTransaction copyWithCompanion(KarmaTransactionsCompanion data) {
    return KarmaTransaction(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      points: data.points.present ? data.points.value : this.points,
      transactionType: data.transactionType.present
          ? data.transactionType.value
          : this.transactionType,
      source: data.source.present ? data.source.value : this.source,
      referenceId: data.referenceId.present
          ? data.referenceId.value
          : this.referenceId,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      description: data.description.present
          ? data.description.value
          : this.description,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KarmaTransaction(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('points: $points, ')
          ..write('transactionType: $transactionType, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    points,
    transactionType,
    source,
    referenceId,
    referenceType,
    description,
    transactionDate,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KarmaTransaction &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.points == this.points &&
          other.transactionType == this.transactionType &&
          other.source == this.source &&
          other.referenceId == this.referenceId &&
          other.referenceType == this.referenceType &&
          other.description == this.description &&
          other.transactionDate == this.transactionDate &&
          other.createdAt == this.createdAt);
}

class KarmaTransactionsCompanion extends UpdateCompanion<KarmaTransaction> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int> points;
  final Value<String> transactionType;
  final Value<String> source;
  final Value<int?> referenceId;
  final Value<String?> referenceType;
  final Value<String?> description;
  final Value<DateTime> transactionDate;
  final Value<DateTime> createdAt;
  const KarmaTransactionsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.points = const Value.absent(),
    this.transactionType = const Value.absent(),
    this.source = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.description = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  KarmaTransactionsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required int points,
    required String transactionType,
    required String source,
    this.referenceId = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.description = const Value.absent(),
    required DateTime transactionDate,
    required DateTime createdAt,
  }) : userId = Value(userId),
       points = Value(points),
       transactionType = Value(transactionType),
       source = Value(source),
       transactionDate = Value(transactionDate),
       createdAt = Value(createdAt);
  static Insertable<KarmaTransaction> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? points,
    Expression<String>? transactionType,
    Expression<String>? source,
    Expression<int>? referenceId,
    Expression<String>? referenceType,
    Expression<String>? description,
    Expression<DateTime>? transactionDate,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (points != null) 'points': points,
      if (transactionType != null) 'transaction_type': transactionType,
      if (source != null) 'source': source,
      if (referenceId != null) 'reference_id': referenceId,
      if (referenceType != null) 'reference_type': referenceType,
      if (description != null) 'description': description,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  KarmaTransactionsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int>? points,
    Value<String>? transactionType,
    Value<String>? source,
    Value<int?>? referenceId,
    Value<String?>? referenceType,
    Value<String?>? description,
    Value<DateTime>? transactionDate,
    Value<DateTime>? createdAt,
  }) {
    return KarmaTransactionsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      points: points ?? this.points,
      transactionType: transactionType ?? this.transactionType,
      source: source ?? this.source,
      referenceId: referenceId ?? this.referenceId,
      referenceType: referenceType ?? this.referenceType,
      description: description ?? this.description,
      transactionDate: transactionDate ?? this.transactionDate,
      createdAt: createdAt ?? this.createdAt,
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
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (transactionType.present) {
      map['transaction_type'] = Variable<String>(transactionType.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<int>(referenceId.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KarmaTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('points: $points, ')
          ..write('transactionType: $transactionType, ')
          ..write('source: $source, ')
          ..write('referenceId: $referenceId, ')
          ..write('referenceType: $referenceType, ')
          ..write('description: $description, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$KarmaTransactionsDao extends GeneratedDatabase {
  _$KarmaTransactionsDao(QueryExecutor e) : super(e);
  $KarmaTransactionsDaoManager get managers =>
      $KarmaTransactionsDaoManager(this);
  late final $KarmaTransactionsTable karmaTransactions =
      $KarmaTransactionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [karmaTransactions];
}

typedef $$KarmaTransactionsTableCreateCompanionBuilder =
    KarmaTransactionsCompanion Function({
      Value<int> id,
      required String userId,
      required int points,
      required String transactionType,
      required String source,
      Value<int?> referenceId,
      Value<String?> referenceType,
      Value<String?> description,
      required DateTime transactionDate,
      required DateTime createdAt,
    });
typedef $$KarmaTransactionsTableUpdateCompanionBuilder =
    KarmaTransactionsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int> points,
      Value<String> transactionType,
      Value<String> source,
      Value<int?> referenceId,
      Value<String?> referenceType,
      Value<String?> description,
      Value<DateTime> transactionDate,
      Value<DateTime> createdAt,
    });

class $$KarmaTransactionsTableFilterComposer
    extends Composer<_$KarmaTransactionsDao, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableFilterComposer({
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

  ColumnFilters<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$KarmaTransactionsTableOrderingComposer
    extends Composer<_$KarmaTransactionsDao, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableOrderingComposer({
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

  ColumnOrderings<int> get points => $composableBuilder(
    column: $table.points,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$KarmaTransactionsTableAnnotationComposer
    extends Composer<_$KarmaTransactionsDao, $KarmaTransactionsTable> {
  $$KarmaTransactionsTableAnnotationComposer({
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

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<String> get transactionType => $composableBuilder(
    column: $table.transactionType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get referenceId => $composableBuilder(
    column: $table.referenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referenceType => $composableBuilder(
    column: $table.referenceType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$KarmaTransactionsTableTableManager
    extends
        RootTableManager<
          _$KarmaTransactionsDao,
          $KarmaTransactionsTable,
          KarmaTransaction,
          $$KarmaTransactionsTableFilterComposer,
          $$KarmaTransactionsTableOrderingComposer,
          $$KarmaTransactionsTableAnnotationComposer,
          $$KarmaTransactionsTableCreateCompanionBuilder,
          $$KarmaTransactionsTableUpdateCompanionBuilder,
          (
            KarmaTransaction,
            BaseReferences<
              _$KarmaTransactionsDao,
              $KarmaTransactionsTable,
              KarmaTransaction
            >,
          ),
          KarmaTransaction,
          PrefetchHooks Function()
        > {
  $$KarmaTransactionsTableTableManager(
    _$KarmaTransactionsDao db,
    $KarmaTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KarmaTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KarmaTransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KarmaTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int> points = const Value.absent(),
                Value<String> transactionType = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<int?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => KarmaTransactionsCompanion(
                id: id,
                userId: userId,
                points: points,
                transactionType: transactionType,
                source: source,
                referenceId: referenceId,
                referenceType: referenceType,
                description: description,
                transactionDate: transactionDate,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required int points,
                required String transactionType,
                required String source,
                Value<int?> referenceId = const Value.absent(),
                Value<String?> referenceType = const Value.absent(),
                Value<String?> description = const Value.absent(),
                required DateTime transactionDate,
                required DateTime createdAt,
              }) => KarmaTransactionsCompanion.insert(
                id: id,
                userId: userId,
                points: points,
                transactionType: transactionType,
                source: source,
                referenceId: referenceId,
                referenceType: referenceType,
                description: description,
                transactionDate: transactionDate,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$KarmaTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$KarmaTransactionsDao,
      $KarmaTransactionsTable,
      KarmaTransaction,
      $$KarmaTransactionsTableFilterComposer,
      $$KarmaTransactionsTableOrderingComposer,
      $$KarmaTransactionsTableAnnotationComposer,
      $$KarmaTransactionsTableCreateCompanionBuilder,
      $$KarmaTransactionsTableUpdateCompanionBuilder,
      (
        KarmaTransaction,
        BaseReferences<
          _$KarmaTransactionsDao,
          $KarmaTransactionsTable,
          KarmaTransaction
        >,
      ),
      KarmaTransaction,
      PrefetchHooks Function()
    >;

class $KarmaTransactionsDaoManager {
  final _$KarmaTransactionsDao _db;
  $KarmaTransactionsDaoManager(this._db);
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(_db, _db.karmaTransactions);
}
