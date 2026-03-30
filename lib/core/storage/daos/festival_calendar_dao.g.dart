// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'festival_calendar_dao.dart';

// ignore_for_file: type=lint
class $FestivalCalendarTable extends FestivalCalendar
    with TableInfo<$FestivalCalendarTable, FestivalCalendarData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FestivalCalendarTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fastingRulesMeta = const VerificationMeta(
    'fastingRules',
  );
  @override
  late final GeneratedColumn<String> fastingRules = GeneratedColumn<String>(
    'fasting_rules',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dietaryNotesMeta = const VerificationMeta(
    'dietaryNotes',
  );
  @override
  late final GeneratedColumn<String> dietaryNotes = GeneratedColumn<String>(
    'dietary_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    name,
    description,
    date,
    region,
    category,
    fastingRules,
    dietaryNotes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'festival_calendar';
  @override
  VerificationContext validateIntegrity(
    Insertable<FestivalCalendarData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('fasting_rules')) {
      context.handle(
        _fastingRulesMeta,
        fastingRules.isAcceptableOrUnknown(
          data['fasting_rules']!,
          _fastingRulesMeta,
        ),
      );
    }
    if (data.containsKey('dietary_notes')) {
      context.handle(
        _dietaryNotesMeta,
        dietaryNotes.isAcceptableOrUnknown(
          data['dietary_notes']!,
          _dietaryNotesMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FestivalCalendarData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FestivalCalendarData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      fastingRules: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fasting_rules'],
      ),
      dietaryNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dietary_notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FestivalCalendarTable createAlias(String alias) {
    return $FestivalCalendarTable(attachedDatabase, alias);
  }
}

class FestivalCalendarData extends DataClass
    implements Insertable<FestivalCalendarData> {
  final int id;
  final String name;
  final String? description;
  final DateTime date;
  final String? region;
  final String? category;
  final String? fastingRules;
  final String? dietaryNotes;
  final DateTime createdAt;
  const FestivalCalendarData({
    required this.id,
    required this.name,
    this.description,
    required this.date,
    this.region,
    this.category,
    this.fastingRules,
    this.dietaryNotes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || fastingRules != null) {
      map['fasting_rules'] = Variable<String>(fastingRules);
    }
    if (!nullToAbsent || dietaryNotes != null) {
      map['dietary_notes'] = Variable<String>(dietaryNotes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FestivalCalendarCompanion toCompanion(bool nullToAbsent) {
    return FestivalCalendarCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      date: Value(date),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      fastingRules: fastingRules == null && nullToAbsent
          ? const Value.absent()
          : Value(fastingRules),
      dietaryNotes: dietaryNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(dietaryNotes),
      createdAt: Value(createdAt),
    );
  }

  factory FestivalCalendarData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FestivalCalendarData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      date: serializer.fromJson<DateTime>(json['date']),
      region: serializer.fromJson<String?>(json['region']),
      category: serializer.fromJson<String?>(json['category']),
      fastingRules: serializer.fromJson<String?>(json['fastingRules']),
      dietaryNotes: serializer.fromJson<String?>(json['dietaryNotes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'date': serializer.toJson<DateTime>(date),
      'region': serializer.toJson<String?>(region),
      'category': serializer.toJson<String?>(category),
      'fastingRules': serializer.toJson<String?>(fastingRules),
      'dietaryNotes': serializer.toJson<String?>(dietaryNotes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FestivalCalendarData copyWith({
    int? id,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? date,
    Value<String?> region = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<String?> fastingRules = const Value.absent(),
    Value<String?> dietaryNotes = const Value.absent(),
    DateTime? createdAt,
  }) => FestivalCalendarData(
    id: id ?? this.id,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    date: date ?? this.date,
    region: region.present ? region.value : this.region,
    category: category.present ? category.value : this.category,
    fastingRules: fastingRules.present ? fastingRules.value : this.fastingRules,
    dietaryNotes: dietaryNotes.present ? dietaryNotes.value : this.dietaryNotes,
    createdAt: createdAt ?? this.createdAt,
  );
  FestivalCalendarData copyWithCompanion(FestivalCalendarCompanion data) {
    return FestivalCalendarData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      date: data.date.present ? data.date.value : this.date,
      region: data.region.present ? data.region.value : this.region,
      category: data.category.present ? data.category.value : this.category,
      fastingRules: data.fastingRules.present
          ? data.fastingRules.value
          : this.fastingRules,
      dietaryNotes: data.dietaryNotes.present
          ? data.dietaryNotes.value
          : this.dietaryNotes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FestivalCalendarData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('region: $region, ')
          ..write('category: $category, ')
          ..write('fastingRules: $fastingRules, ')
          ..write('dietaryNotes: $dietaryNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    description,
    date,
    region,
    category,
    fastingRules,
    dietaryNotes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FestivalCalendarData &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.date == this.date &&
          other.region == this.region &&
          other.category == this.category &&
          other.fastingRules == this.fastingRules &&
          other.dietaryNotes == this.dietaryNotes &&
          other.createdAt == this.createdAt);
}

class FestivalCalendarCompanion extends UpdateCompanion<FestivalCalendarData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> date;
  final Value<String?> region;
  final Value<String?> category;
  final Value<String?> fastingRules;
  final Value<String?> dietaryNotes;
  final Value<DateTime> createdAt;
  const FestivalCalendarCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.date = const Value.absent(),
    this.region = const Value.absent(),
    this.category = const Value.absent(),
    this.fastingRules = const Value.absent(),
    this.dietaryNotes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FestivalCalendarCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required DateTime date,
    this.region = const Value.absent(),
    this.category = const Value.absent(),
    this.fastingRules = const Value.absent(),
    this.dietaryNotes = const Value.absent(),
    required DateTime createdAt,
  }) : name = Value(name),
       date = Value(date),
       createdAt = Value(createdAt);
  static Insertable<FestivalCalendarData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? date,
    Expression<String>? region,
    Expression<String>? category,
    Expression<String>? fastingRules,
    Expression<String>? dietaryNotes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (date != null) 'date': date,
      if (region != null) 'region': region,
      if (category != null) 'category': category,
      if (fastingRules != null) 'fasting_rules': fastingRules,
      if (dietaryNotes != null) 'dietary_notes': dietaryNotes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FestivalCalendarCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? date,
    Value<String?>? region,
    Value<String?>? category,
    Value<String?>? fastingRules,
    Value<String?>? dietaryNotes,
    Value<DateTime>? createdAt,
  }) {
    return FestivalCalendarCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      region: region ?? this.region,
      category: category ?? this.category,
      fastingRules: fastingRules ?? this.fastingRules,
      dietaryNotes: dietaryNotes ?? this.dietaryNotes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (fastingRules.present) {
      map['fasting_rules'] = Variable<String>(fastingRules.value);
    }
    if (dietaryNotes.present) {
      map['dietary_notes'] = Variable<String>(dietaryNotes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FestivalCalendarCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('date: $date, ')
          ..write('region: $region, ')
          ..write('category: $category, ')
          ..write('fastingRules: $fastingRules, ')
          ..write('dietaryNotes: $dietaryNotes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$FestivalCalendarDao extends GeneratedDatabase {
  _$FestivalCalendarDao(QueryExecutor e) : super(e);
  $FestivalCalendarDaoManager get managers => $FestivalCalendarDaoManager(this);
  late final $FestivalCalendarTable festivalCalendar = $FestivalCalendarTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [festivalCalendar];
}

typedef $$FestivalCalendarTableCreateCompanionBuilder =
    FestivalCalendarCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> description,
      required DateTime date,
      Value<String?> region,
      Value<String?> category,
      Value<String?> fastingRules,
      Value<String?> dietaryNotes,
      required DateTime createdAt,
    });
typedef $$FestivalCalendarTableUpdateCompanionBuilder =
    FestivalCalendarCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> date,
      Value<String?> region,
      Value<String?> category,
      Value<String?> fastingRules,
      Value<String?> dietaryNotes,
      Value<DateTime> createdAt,
    });

class $$FestivalCalendarTableFilterComposer
    extends Composer<_$FestivalCalendarDao, $FestivalCalendarTable> {
  $$FestivalCalendarTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fastingRules => $composableBuilder(
    column: $table.fastingRules,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FestivalCalendarTableOrderingComposer
    extends Composer<_$FestivalCalendarDao, $FestivalCalendarTable> {
  $$FestivalCalendarTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fastingRules => $composableBuilder(
    column: $table.fastingRules,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FestivalCalendarTableAnnotationComposer
    extends Composer<_$FestivalCalendarDao, $FestivalCalendarTable> {
  $$FestivalCalendarTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get fastingRules => $composableBuilder(
    column: $table.fastingRules,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dietaryNotes => $composableBuilder(
    column: $table.dietaryNotes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FestivalCalendarTableTableManager
    extends
        RootTableManager<
          _$FestivalCalendarDao,
          $FestivalCalendarTable,
          FestivalCalendarData,
          $$FestivalCalendarTableFilterComposer,
          $$FestivalCalendarTableOrderingComposer,
          $$FestivalCalendarTableAnnotationComposer,
          $$FestivalCalendarTableCreateCompanionBuilder,
          $$FestivalCalendarTableUpdateCompanionBuilder,
          (
            FestivalCalendarData,
            BaseReferences<
              _$FestivalCalendarDao,
              $FestivalCalendarTable,
              FestivalCalendarData
            >,
          ),
          FestivalCalendarData,
          PrefetchHooks Function()
        > {
  $$FestivalCalendarTableTableManager(
    _$FestivalCalendarDao db,
    $FestivalCalendarTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FestivalCalendarTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FestivalCalendarTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FestivalCalendarTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> fastingRules = const Value.absent(),
                Value<String?> dietaryNotes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FestivalCalendarCompanion(
                id: id,
                name: name,
                description: description,
                date: date,
                region: region,
                category: category,
                fastingRules: fastingRules,
                dietaryNotes: dietaryNotes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime date,
                Value<String?> region = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<String?> fastingRules = const Value.absent(),
                Value<String?> dietaryNotes = const Value.absent(),
                required DateTime createdAt,
              }) => FestivalCalendarCompanion.insert(
                id: id,
                name: name,
                description: description,
                date: date,
                region: region,
                category: category,
                fastingRules: fastingRules,
                dietaryNotes: dietaryNotes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FestivalCalendarTableProcessedTableManager =
    ProcessedTableManager<
      _$FestivalCalendarDao,
      $FestivalCalendarTable,
      FestivalCalendarData,
      $$FestivalCalendarTableFilterComposer,
      $$FestivalCalendarTableOrderingComposer,
      $$FestivalCalendarTableAnnotationComposer,
      $$FestivalCalendarTableCreateCompanionBuilder,
      $$FestivalCalendarTableUpdateCompanionBuilder,
      (
        FestivalCalendarData,
        BaseReferences<
          _$FestivalCalendarDao,
          $FestivalCalendarTable,
          FestivalCalendarData
        >,
      ),
      FestivalCalendarData,
      PrefetchHooks Function()
    >;

class $FestivalCalendarDaoManager {
  final _$FestivalCalendarDao _db;
  $FestivalCalendarDaoManager(this._db);
  $$FestivalCalendarTableTableManager get festivalCalendar =>
      $$FestivalCalendarTableTableManager(_db, _db.festivalCalendar);
}
