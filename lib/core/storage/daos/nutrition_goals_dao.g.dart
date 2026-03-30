// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_goals_dao.dart';

// ignore_for_file: type=lint
class $NutritionGoalsTable extends NutritionGoals
    with TableInfo<$NutritionGoalsTable, NutritionGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NutritionGoalsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dailyCaloriesMeta = const VerificationMeta(
    'dailyCalories',
  );
  @override
  late final GeneratedColumn<int> dailyCalories = GeneratedColumn<int>(
    'daily_calories',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyProteinMeta = const VerificationMeta(
    'dailyProtein',
  );
  @override
  late final GeneratedColumn<double> dailyProtein = GeneratedColumn<double>(
    'daily_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyCarbsMeta = const VerificationMeta(
    'dailyCarbs',
  );
  @override
  late final GeneratedColumn<double> dailyCarbs = GeneratedColumn<double>(
    'daily_carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyFatMeta = const VerificationMeta(
    'dailyFat',
  );
  @override
  late final GeneratedColumn<double> dailyFat = GeneratedColumn<double>(
    'daily_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyFiberMeta = const VerificationMeta(
    'dailyFiber',
  );
  @override
  late final GeneratedColumn<double> dailyFiber = GeneratedColumn<double>(
    'daily_fiber',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dailyWaterMlMeta = const VerificationMeta(
    'dailyWaterMl',
  );
  @override
  late final GeneratedColumn<double> dailyWaterMl = GeneratedColumn<double>(
    'daily_water_ml',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    dailyCalories,
    dailyProtein,
    dailyCarbs,
    dailyFat,
    dailyFiber,
    dailyWaterMl,
    goalType,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nutrition_goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<NutritionGoal> instance, {
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
    if (data.containsKey('daily_calories')) {
      context.handle(
        _dailyCaloriesMeta,
        dailyCalories.isAcceptableOrUnknown(
          data['daily_calories']!,
          _dailyCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('daily_protein')) {
      context.handle(
        _dailyProteinMeta,
        dailyProtein.isAcceptableOrUnknown(
          data['daily_protein']!,
          _dailyProteinMeta,
        ),
      );
    }
    if (data.containsKey('daily_carbs')) {
      context.handle(
        _dailyCarbsMeta,
        dailyCarbs.isAcceptableOrUnknown(data['daily_carbs']!, _dailyCarbsMeta),
      );
    }
    if (data.containsKey('daily_fat')) {
      context.handle(
        _dailyFatMeta,
        dailyFat.isAcceptableOrUnknown(data['daily_fat']!, _dailyFatMeta),
      );
    }
    if (data.containsKey('daily_fiber')) {
      context.handle(
        _dailyFiberMeta,
        dailyFiber.isAcceptableOrUnknown(data['daily_fiber']!, _dailyFiberMeta),
      );
    }
    if (data.containsKey('daily_water_ml')) {
      context.handle(
        _dailyWaterMlMeta,
        dailyWaterMl.isAcceptableOrUnknown(
          data['daily_water_ml']!,
          _dailyWaterMlMeta,
        ),
      );
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
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
  NutritionGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NutritionGoal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      dailyCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}daily_calories'],
      ),
      dailyProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_protein'],
      ),
      dailyCarbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_carbs'],
      ),
      dailyFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_fat'],
      ),
      dailyFiber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_fiber'],
      ),
      dailyWaterMl: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}daily_water_ml'],
      ),
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      ),
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
  $NutritionGoalsTable createAlias(String alias) {
    return $NutritionGoalsTable(attachedDatabase, alias);
  }
}

class NutritionGoal extends DataClass implements Insertable<NutritionGoal> {
  final int id;
  final String userId;
  final int? dailyCalories;
  final double? dailyProtein;
  final double? dailyCarbs;
  final double? dailyFat;
  final double? dailyFiber;
  final double? dailyWaterMl;
  final String? goalType;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const NutritionGoal({
    required this.id,
    required this.userId,
    this.dailyCalories,
    this.dailyProtein,
    this.dailyCarbs,
    this.dailyFat,
    this.dailyFiber,
    this.dailyWaterMl,
    this.goalType,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || dailyCalories != null) {
      map['daily_calories'] = Variable<int>(dailyCalories);
    }
    if (!nullToAbsent || dailyProtein != null) {
      map['daily_protein'] = Variable<double>(dailyProtein);
    }
    if (!nullToAbsent || dailyCarbs != null) {
      map['daily_carbs'] = Variable<double>(dailyCarbs);
    }
    if (!nullToAbsent || dailyFat != null) {
      map['daily_fat'] = Variable<double>(dailyFat);
    }
    if (!nullToAbsent || dailyFiber != null) {
      map['daily_fiber'] = Variable<double>(dailyFiber);
    }
    if (!nullToAbsent || dailyWaterMl != null) {
      map['daily_water_ml'] = Variable<double>(dailyWaterMl);
    }
    if (!nullToAbsent || goalType != null) {
      map['goal_type'] = Variable<String>(goalType);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NutritionGoalsCompanion toCompanion(bool nullToAbsent) {
    return NutritionGoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      dailyCalories: dailyCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyCalories),
      dailyProtein: dailyProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyProtein),
      dailyCarbs: dailyCarbs == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyCarbs),
      dailyFat: dailyFat == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyFat),
      dailyFiber: dailyFiber == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyFiber),
      dailyWaterMl: dailyWaterMl == null && nullToAbsent
          ? const Value.absent()
          : Value(dailyWaterMl),
      goalType: goalType == null && nullToAbsent
          ? const Value.absent()
          : Value(goalType),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory NutritionGoal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NutritionGoal(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      dailyCalories: serializer.fromJson<int?>(json['dailyCalories']),
      dailyProtein: serializer.fromJson<double?>(json['dailyProtein']),
      dailyCarbs: serializer.fromJson<double?>(json['dailyCarbs']),
      dailyFat: serializer.fromJson<double?>(json['dailyFat']),
      dailyFiber: serializer.fromJson<double?>(json['dailyFiber']),
      dailyWaterMl: serializer.fromJson<double?>(json['dailyWaterMl']),
      goalType: serializer.fromJson<String?>(json['goalType']),
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
      'dailyCalories': serializer.toJson<int?>(dailyCalories),
      'dailyProtein': serializer.toJson<double?>(dailyProtein),
      'dailyCarbs': serializer.toJson<double?>(dailyCarbs),
      'dailyFat': serializer.toJson<double?>(dailyFat),
      'dailyFiber': serializer.toJson<double?>(dailyFiber),
      'dailyWaterMl': serializer.toJson<double?>(dailyWaterMl),
      'goalType': serializer.toJson<String?>(goalType),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NutritionGoal copyWith({
    int? id,
    String? userId,
    Value<int?> dailyCalories = const Value.absent(),
    Value<double?> dailyProtein = const Value.absent(),
    Value<double?> dailyCarbs = const Value.absent(),
    Value<double?> dailyFat = const Value.absent(),
    Value<double?> dailyFiber = const Value.absent(),
    Value<double?> dailyWaterMl = const Value.absent(),
    Value<String?> goalType = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NutritionGoal(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    dailyCalories: dailyCalories.present
        ? dailyCalories.value
        : this.dailyCalories,
    dailyProtein: dailyProtein.present ? dailyProtein.value : this.dailyProtein,
    dailyCarbs: dailyCarbs.present ? dailyCarbs.value : this.dailyCarbs,
    dailyFat: dailyFat.present ? dailyFat.value : this.dailyFat,
    dailyFiber: dailyFiber.present ? dailyFiber.value : this.dailyFiber,
    dailyWaterMl: dailyWaterMl.present ? dailyWaterMl.value : this.dailyWaterMl,
    goalType: goalType.present ? goalType.value : this.goalType,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NutritionGoal copyWithCompanion(NutritionGoalsCompanion data) {
    return NutritionGoal(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      dailyCalories: data.dailyCalories.present
          ? data.dailyCalories.value
          : this.dailyCalories,
      dailyProtein: data.dailyProtein.present
          ? data.dailyProtein.value
          : this.dailyProtein,
      dailyCarbs: data.dailyCarbs.present
          ? data.dailyCarbs.value
          : this.dailyCarbs,
      dailyFat: data.dailyFat.present ? data.dailyFat.value : this.dailyFat,
      dailyFiber: data.dailyFiber.present
          ? data.dailyFiber.value
          : this.dailyFiber,
      dailyWaterMl: data.dailyWaterMl.present
          ? data.dailyWaterMl.value
          : this.dailyWaterMl,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NutritionGoal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dailyCalories: $dailyCalories, ')
          ..write('dailyProtein: $dailyProtein, ')
          ..write('dailyCarbs: $dailyCarbs, ')
          ..write('dailyFat: $dailyFat, ')
          ..write('dailyFiber: $dailyFiber, ')
          ..write('dailyWaterMl: $dailyWaterMl, ')
          ..write('goalType: $goalType, ')
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
    dailyCalories,
    dailyProtein,
    dailyCarbs,
    dailyFat,
    dailyFiber,
    dailyWaterMl,
    goalType,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NutritionGoal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.dailyCalories == this.dailyCalories &&
          other.dailyProtein == this.dailyProtein &&
          other.dailyCarbs == this.dailyCarbs &&
          other.dailyFat == this.dailyFat &&
          other.dailyFiber == this.dailyFiber &&
          other.dailyWaterMl == this.dailyWaterMl &&
          other.goalType == this.goalType &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class NutritionGoalsCompanion extends UpdateCompanion<NutritionGoal> {
  final Value<int> id;
  final Value<String> userId;
  final Value<int?> dailyCalories;
  final Value<double?> dailyProtein;
  final Value<double?> dailyCarbs;
  final Value<double?> dailyFat;
  final Value<double?> dailyFiber;
  final Value<double?> dailyWaterMl;
  final Value<String?> goalType;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const NutritionGoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.dailyCalories = const Value.absent(),
    this.dailyProtein = const Value.absent(),
    this.dailyCarbs = const Value.absent(),
    this.dailyFat = const Value.absent(),
    this.dailyFiber = const Value.absent(),
    this.dailyWaterMl = const Value.absent(),
    this.goalType = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NutritionGoalsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.dailyCalories = const Value.absent(),
    this.dailyProtein = const Value.absent(),
    this.dailyCarbs = const Value.absent(),
    this.dailyFat = const Value.absent(),
    this.dailyFiber = const Value.absent(),
    this.dailyWaterMl = const Value.absent(),
    this.goalType = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<NutritionGoal> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<int>? dailyCalories,
    Expression<double>? dailyProtein,
    Expression<double>? dailyCarbs,
    Expression<double>? dailyFat,
    Expression<double>? dailyFiber,
    Expression<double>? dailyWaterMl,
    Expression<String>? goalType,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (dailyCalories != null) 'daily_calories': dailyCalories,
      if (dailyProtein != null) 'daily_protein': dailyProtein,
      if (dailyCarbs != null) 'daily_carbs': dailyCarbs,
      if (dailyFat != null) 'daily_fat': dailyFat,
      if (dailyFiber != null) 'daily_fiber': dailyFiber,
      if (dailyWaterMl != null) 'daily_water_ml': dailyWaterMl,
      if (goalType != null) 'goal_type': goalType,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NutritionGoalsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<int?>? dailyCalories,
    Value<double?>? dailyProtein,
    Value<double?>? dailyCarbs,
    Value<double?>? dailyFat,
    Value<double?>? dailyFiber,
    Value<double?>? dailyWaterMl,
    Value<String?>? goalType,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return NutritionGoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      dailyCalories: dailyCalories ?? this.dailyCalories,
      dailyProtein: dailyProtein ?? this.dailyProtein,
      dailyCarbs: dailyCarbs ?? this.dailyCarbs,
      dailyFat: dailyFat ?? this.dailyFat,
      dailyFiber: dailyFiber ?? this.dailyFiber,
      dailyWaterMl: dailyWaterMl ?? this.dailyWaterMl,
      goalType: goalType ?? this.goalType,
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
    if (dailyCalories.present) {
      map['daily_calories'] = Variable<int>(dailyCalories.value);
    }
    if (dailyProtein.present) {
      map['daily_protein'] = Variable<double>(dailyProtein.value);
    }
    if (dailyCarbs.present) {
      map['daily_carbs'] = Variable<double>(dailyCarbs.value);
    }
    if (dailyFat.present) {
      map['daily_fat'] = Variable<double>(dailyFat.value);
    }
    if (dailyFiber.present) {
      map['daily_fiber'] = Variable<double>(dailyFiber.value);
    }
    if (dailyWaterMl.present) {
      map['daily_water_ml'] = Variable<double>(dailyWaterMl.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
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
    return (StringBuffer('NutritionGoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('dailyCalories: $dailyCalories, ')
          ..write('dailyProtein: $dailyProtein, ')
          ..write('dailyCarbs: $dailyCarbs, ')
          ..write('dailyFat: $dailyFat, ')
          ..write('dailyFiber: $dailyFiber, ')
          ..write('dailyWaterMl: $dailyWaterMl, ')
          ..write('goalType: $goalType, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$NutritionGoalsDao extends GeneratedDatabase {
  _$NutritionGoalsDao(QueryExecutor e) : super(e);
  $NutritionGoalsDaoManager get managers => $NutritionGoalsDaoManager(this);
  late final $NutritionGoalsTable nutritionGoals = $NutritionGoalsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [nutritionGoals];
}

typedef $$NutritionGoalsTableCreateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      required String userId,
      Value<int?> dailyCalories,
      Value<double?> dailyProtein,
      Value<double?> dailyCarbs,
      Value<double?> dailyFat,
      Value<double?> dailyFiber,
      Value<double?> dailyWaterMl,
      Value<String?> goalType,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$NutritionGoalsTableUpdateCompanionBuilder =
    NutritionGoalsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<int?> dailyCalories,
      Value<double?> dailyProtein,
      Value<double?> dailyCarbs,
      Value<double?> dailyFat,
      Value<double?> dailyFiber,
      Value<double?> dailyWaterMl,
      Value<String?> goalType,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$NutritionGoalsTableFilterComposer
    extends Composer<_$NutritionGoalsDao, $NutritionGoalsTable> {
  $$NutritionGoalsTableFilterComposer({
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

  ColumnFilters<int> get dailyCalories => $composableBuilder(
    column: $table.dailyCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyFat => $composableBuilder(
    column: $table.dailyFat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyFiber => $composableBuilder(
    column: $table.dailyFiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get dailyWaterMl => $composableBuilder(
    column: $table.dailyWaterMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
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

class $$NutritionGoalsTableOrderingComposer
    extends Composer<_$NutritionGoalsDao, $NutritionGoalsTable> {
  $$NutritionGoalsTableOrderingComposer({
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

  ColumnOrderings<int> get dailyCalories => $composableBuilder(
    column: $table.dailyCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyFat => $composableBuilder(
    column: $table.dailyFat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyFiber => $composableBuilder(
    column: $table.dailyFiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get dailyWaterMl => $composableBuilder(
    column: $table.dailyWaterMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
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

class $$NutritionGoalsTableAnnotationComposer
    extends Composer<_$NutritionGoalsDao, $NutritionGoalsTable> {
  $$NutritionGoalsTableAnnotationComposer({
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

  GeneratedColumn<int> get dailyCalories => $composableBuilder(
    column: $table.dailyCalories,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyProtein => $composableBuilder(
    column: $table.dailyProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyCarbs => $composableBuilder(
    column: $table.dailyCarbs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyFat =>
      $composableBuilder(column: $table.dailyFat, builder: (column) => column);

  GeneratedColumn<double> get dailyFiber => $composableBuilder(
    column: $table.dailyFiber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get dailyWaterMl => $composableBuilder(
    column: $table.dailyWaterMl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NutritionGoalsTableTableManager
    extends
        RootTableManager<
          _$NutritionGoalsDao,
          $NutritionGoalsTable,
          NutritionGoal,
          $$NutritionGoalsTableFilterComposer,
          $$NutritionGoalsTableOrderingComposer,
          $$NutritionGoalsTableAnnotationComposer,
          $$NutritionGoalsTableCreateCompanionBuilder,
          $$NutritionGoalsTableUpdateCompanionBuilder,
          (
            NutritionGoal,
            BaseReferences<
              _$NutritionGoalsDao,
              $NutritionGoalsTable,
              NutritionGoal
            >,
          ),
          NutritionGoal,
          PrefetchHooks Function()
        > {
  $$NutritionGoalsTableTableManager(
    _$NutritionGoalsDao db,
    $NutritionGoalsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NutritionGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NutritionGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NutritionGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<int?> dailyCalories = const Value.absent(),
                Value<double?> dailyProtein = const Value.absent(),
                Value<double?> dailyCarbs = const Value.absent(),
                Value<double?> dailyFat = const Value.absent(),
                Value<double?> dailyFiber = const Value.absent(),
                Value<double?> dailyWaterMl = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NutritionGoalsCompanion(
                id: id,
                userId: userId,
                dailyCalories: dailyCalories,
                dailyProtein: dailyProtein,
                dailyCarbs: dailyCarbs,
                dailyFat: dailyFat,
                dailyFiber: dailyFiber,
                dailyWaterMl: dailyWaterMl,
                goalType: goalType,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                Value<int?> dailyCalories = const Value.absent(),
                Value<double?> dailyProtein = const Value.absent(),
                Value<double?> dailyCarbs = const Value.absent(),
                Value<double?> dailyFat = const Value.absent(),
                Value<double?> dailyFiber = const Value.absent(),
                Value<double?> dailyWaterMl = const Value.absent(),
                Value<String?> goalType = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => NutritionGoalsCompanion.insert(
                id: id,
                userId: userId,
                dailyCalories: dailyCalories,
                dailyProtein: dailyProtein,
                dailyCarbs: dailyCarbs,
                dailyFat: dailyFat,
                dailyFiber: dailyFiber,
                dailyWaterMl: dailyWaterMl,
                goalType: goalType,
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

typedef $$NutritionGoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$NutritionGoalsDao,
      $NutritionGoalsTable,
      NutritionGoal,
      $$NutritionGoalsTableFilterComposer,
      $$NutritionGoalsTableOrderingComposer,
      $$NutritionGoalsTableAnnotationComposer,
      $$NutritionGoalsTableCreateCompanionBuilder,
      $$NutritionGoalsTableUpdateCompanionBuilder,
      (
        NutritionGoal,
        BaseReferences<
          _$NutritionGoalsDao,
          $NutritionGoalsTable,
          NutritionGoal
        >,
      ),
      NutritionGoal,
      PrefetchHooks Function()
    >;

class $NutritionGoalsDaoManager {
  final _$NutritionGoalsDao _db;
  $NutritionGoalsDaoManager(this._db);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(_db, _db.nutritionGoals);
}
