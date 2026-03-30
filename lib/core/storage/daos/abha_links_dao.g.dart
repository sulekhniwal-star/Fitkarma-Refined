// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'abha_links_dao.dart';

// ignore_for_file: type=lint
class $AbhaLinksTable extends AbhaLinks
    with TableInfo<$AbhaLinksTable, AbhaLink> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AbhaLinksTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _abhaIdMeta = const VerificationMeta('abhaId');
  @override
  late final GeneratedColumn<String> abhaId = GeneratedColumn<String>(
    'abha_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _abhaAddressMeta = const VerificationMeta(
    'abhaAddress',
  );
  @override
  late final GeneratedColumn<String> abhaAddress = GeneratedColumn<String>(
    'abha_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedNameMeta = const VerificationMeta(
    'linkedName',
  );
  @override
  late final GeneratedColumn<String> linkedName = GeneratedColumn<String>(
    'linked_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkedAtMeta = const VerificationMeta(
    'linkedAt',
  );
  @override
  late final GeneratedColumn<DateTime> linkedAt = GeneratedColumn<DateTime>(
    'linked_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
    abhaId,
    abhaAddress,
    linkedName,
    linkedAt,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'abha_links';
  @override
  VerificationContext validateIntegrity(
    Insertable<AbhaLink> instance, {
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
    if (data.containsKey('abha_id')) {
      context.handle(
        _abhaIdMeta,
        abhaId.isAcceptableOrUnknown(data['abha_id']!, _abhaIdMeta),
      );
    } else if (isInserting) {
      context.missing(_abhaIdMeta);
    }
    if (data.containsKey('abha_address')) {
      context.handle(
        _abhaAddressMeta,
        abhaAddress.isAcceptableOrUnknown(
          data['abha_address']!,
          _abhaAddressMeta,
        ),
      );
    }
    if (data.containsKey('linked_name')) {
      context.handle(
        _linkedNameMeta,
        linkedName.isAcceptableOrUnknown(data['linked_name']!, _linkedNameMeta),
      );
    }
    if (data.containsKey('linked_at')) {
      context.handle(
        _linkedAtMeta,
        linkedAt.isAcceptableOrUnknown(data['linked_at']!, _linkedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_linkedAtMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
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
  AbhaLink map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AbhaLink(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      abhaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abha_id'],
      )!,
      abhaAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}abha_address'],
      ),
      linkedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}linked_name'],
      ),
      linkedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}linked_at'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
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
  $AbhaLinksTable createAlias(String alias) {
    return $AbhaLinksTable(attachedDatabase, alias);
  }
}

class AbhaLink extends DataClass implements Insertable<AbhaLink> {
  final int id;
  final String userId;
  final String abhaId;
  final String? abhaAddress;
  final String? linkedName;
  final DateTime linkedAt;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AbhaLink({
    required this.id,
    required this.userId,
    required this.abhaId,
    this.abhaAddress,
    this.linkedName,
    required this.linkedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['abha_id'] = Variable<String>(abhaId);
    if (!nullToAbsent || abhaAddress != null) {
      map['abha_address'] = Variable<String>(abhaAddress);
    }
    if (!nullToAbsent || linkedName != null) {
      map['linked_name'] = Variable<String>(linkedName);
    }
    map['linked_at'] = Variable<DateTime>(linkedAt);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AbhaLinksCompanion toCompanion(bool nullToAbsent) {
    return AbhaLinksCompanion(
      id: Value(id),
      userId: Value(userId),
      abhaId: Value(abhaId),
      abhaAddress: abhaAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(abhaAddress),
      linkedName: linkedName == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedName),
      linkedAt: Value(linkedAt),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AbhaLink.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AbhaLink(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      abhaId: serializer.fromJson<String>(json['abhaId']),
      abhaAddress: serializer.fromJson<String?>(json['abhaAddress']),
      linkedName: serializer.fromJson<String?>(json['linkedName']),
      linkedAt: serializer.fromJson<DateTime>(json['linkedAt']),
      isActive: serializer.fromJson<bool>(json['isActive']),
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
      'abhaId': serializer.toJson<String>(abhaId),
      'abhaAddress': serializer.toJson<String?>(abhaAddress),
      'linkedName': serializer.toJson<String?>(linkedName),
      'linkedAt': serializer.toJson<DateTime>(linkedAt),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AbhaLink copyWith({
    int? id,
    String? userId,
    String? abhaId,
    Value<String?> abhaAddress = const Value.absent(),
    Value<String?> linkedName = const Value.absent(),
    DateTime? linkedAt,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AbhaLink(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    abhaId: abhaId ?? this.abhaId,
    abhaAddress: abhaAddress.present ? abhaAddress.value : this.abhaAddress,
    linkedName: linkedName.present ? linkedName.value : this.linkedName,
    linkedAt: linkedAt ?? this.linkedAt,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AbhaLink copyWithCompanion(AbhaLinksCompanion data) {
    return AbhaLink(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      abhaId: data.abhaId.present ? data.abhaId.value : this.abhaId,
      abhaAddress: data.abhaAddress.present
          ? data.abhaAddress.value
          : this.abhaAddress,
      linkedName: data.linkedName.present
          ? data.linkedName.value
          : this.linkedName,
      linkedAt: data.linkedAt.present ? data.linkedAt.value : this.linkedAt,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AbhaLink(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('abhaId: $abhaId, ')
          ..write('abhaAddress: $abhaAddress, ')
          ..write('linkedName: $linkedName, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    abhaId,
    abhaAddress,
    linkedName,
    linkedAt,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AbhaLink &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.abhaId == this.abhaId &&
          other.abhaAddress == this.abhaAddress &&
          other.linkedName == this.linkedName &&
          other.linkedAt == this.linkedAt &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AbhaLinksCompanion extends UpdateCompanion<AbhaLink> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> abhaId;
  final Value<String?> abhaAddress;
  final Value<String?> linkedName;
  final Value<DateTime> linkedAt;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AbhaLinksCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.abhaId = const Value.absent(),
    this.abhaAddress = const Value.absent(),
    this.linkedName = const Value.absent(),
    this.linkedAt = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AbhaLinksCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String abhaId,
    this.abhaAddress = const Value.absent(),
    this.linkedName = const Value.absent(),
    required DateTime linkedAt,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       abhaId = Value(abhaId),
       linkedAt = Value(linkedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AbhaLink> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? abhaId,
    Expression<String>? abhaAddress,
    Expression<String>? linkedName,
    Expression<DateTime>? linkedAt,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (abhaId != null) 'abha_id': abhaId,
      if (abhaAddress != null) 'abha_address': abhaAddress,
      if (linkedName != null) 'linked_name': linkedName,
      if (linkedAt != null) 'linked_at': linkedAt,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AbhaLinksCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? abhaId,
    Value<String?>? abhaAddress,
    Value<String?>? linkedName,
    Value<DateTime>? linkedAt,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AbhaLinksCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      abhaId: abhaId ?? this.abhaId,
      abhaAddress: abhaAddress ?? this.abhaAddress,
      linkedName: linkedName ?? this.linkedName,
      linkedAt: linkedAt ?? this.linkedAt,
      isActive: isActive ?? this.isActive,
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
    if (abhaId.present) {
      map['abha_id'] = Variable<String>(abhaId.value);
    }
    if (abhaAddress.present) {
      map['abha_address'] = Variable<String>(abhaAddress.value);
    }
    if (linkedName.present) {
      map['linked_name'] = Variable<String>(linkedName.value);
    }
    if (linkedAt.present) {
      map['linked_at'] = Variable<DateTime>(linkedAt.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('AbhaLinksCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('abhaId: $abhaId, ')
          ..write('abhaAddress: $abhaAddress, ')
          ..write('linkedName: $linkedName, ')
          ..write('linkedAt: $linkedAt, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AbhaLinksDao extends GeneratedDatabase {
  _$AbhaLinksDao(QueryExecutor e) : super(e);
  $AbhaLinksDaoManager get managers => $AbhaLinksDaoManager(this);
  late final $AbhaLinksTable abhaLinks = $AbhaLinksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [abhaLinks];
}

typedef $$AbhaLinksTableCreateCompanionBuilder =
    AbhaLinksCompanion Function({
      Value<int> id,
      required String userId,
      required String abhaId,
      Value<String?> abhaAddress,
      Value<String?> linkedName,
      required DateTime linkedAt,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$AbhaLinksTableUpdateCompanionBuilder =
    AbhaLinksCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> abhaId,
      Value<String?> abhaAddress,
      Value<String?> linkedName,
      Value<DateTime> linkedAt,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$AbhaLinksTableFilterComposer
    extends Composer<_$AbhaLinksDao, $AbhaLinksTable> {
  $$AbhaLinksTableFilterComposer({
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

  ColumnFilters<String> get abhaId => $composableBuilder(
    column: $table.abhaId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get linkedName => $composableBuilder(
    column: $table.linkedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

class $$AbhaLinksTableOrderingComposer
    extends Composer<_$AbhaLinksDao, $AbhaLinksTable> {
  $$AbhaLinksTableOrderingComposer({
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

  ColumnOrderings<String> get abhaId => $composableBuilder(
    column: $table.abhaId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get linkedName => $composableBuilder(
    column: $table.linkedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get linkedAt => $composableBuilder(
    column: $table.linkedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
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

class $$AbhaLinksTableAnnotationComposer
    extends Composer<_$AbhaLinksDao, $AbhaLinksTable> {
  $$AbhaLinksTableAnnotationComposer({
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

  GeneratedColumn<String> get abhaId =>
      $composableBuilder(column: $table.abhaId, builder: (column) => column);

  GeneratedColumn<String> get abhaAddress => $composableBuilder(
    column: $table.abhaAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get linkedName => $composableBuilder(
    column: $table.linkedName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get linkedAt =>
      $composableBuilder(column: $table.linkedAt, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AbhaLinksTableTableManager
    extends
        RootTableManager<
          _$AbhaLinksDao,
          $AbhaLinksTable,
          AbhaLink,
          $$AbhaLinksTableFilterComposer,
          $$AbhaLinksTableOrderingComposer,
          $$AbhaLinksTableAnnotationComposer,
          $$AbhaLinksTableCreateCompanionBuilder,
          $$AbhaLinksTableUpdateCompanionBuilder,
          (AbhaLink, BaseReferences<_$AbhaLinksDao, $AbhaLinksTable, AbhaLink>),
          AbhaLink,
          PrefetchHooks Function()
        > {
  $$AbhaLinksTableTableManager(_$AbhaLinksDao db, $AbhaLinksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AbhaLinksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AbhaLinksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AbhaLinksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> abhaId = const Value.absent(),
                Value<String?> abhaAddress = const Value.absent(),
                Value<String?> linkedName = const Value.absent(),
                Value<DateTime> linkedAt = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AbhaLinksCompanion(
                id: id,
                userId: userId,
                abhaId: abhaId,
                abhaAddress: abhaAddress,
                linkedName: linkedName,
                linkedAt: linkedAt,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String abhaId,
                Value<String?> abhaAddress = const Value.absent(),
                Value<String?> linkedName = const Value.absent(),
                required DateTime linkedAt,
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => AbhaLinksCompanion.insert(
                id: id,
                userId: userId,
                abhaId: abhaId,
                abhaAddress: abhaAddress,
                linkedName: linkedName,
                linkedAt: linkedAt,
                isActive: isActive,
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

typedef $$AbhaLinksTableProcessedTableManager =
    ProcessedTableManager<
      _$AbhaLinksDao,
      $AbhaLinksTable,
      AbhaLink,
      $$AbhaLinksTableFilterComposer,
      $$AbhaLinksTableOrderingComposer,
      $$AbhaLinksTableAnnotationComposer,
      $$AbhaLinksTableCreateCompanionBuilder,
      $$AbhaLinksTableUpdateCompanionBuilder,
      (AbhaLink, BaseReferences<_$AbhaLinksDao, $AbhaLinksTable, AbhaLink>),
      AbhaLink,
      PrefetchHooks Function()
    >;

class $AbhaLinksDaoManager {
  final _$AbhaLinksDao _db;
  $AbhaLinksDaoManager(this._db);
  $$AbhaLinksTableTableManager get abhaLinks =>
      $$AbhaLinksTableTableManager(_db, _db.abhaLinks);
}
