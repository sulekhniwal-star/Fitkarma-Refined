// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodLogsTable extends FoodLogs with TableInfo<$FoodLogsTable, FoodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _mealTypeMeta = const VerificationMeta(
    'mealType',
  );
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
    'meal_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _foodNameMeta = const VerificationMeta(
    'foodName',
  );
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
    'food_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesMeta = const VerificationMeta(
    'calories',
  );
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
    'calories',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinMeta = const VerificationMeta(
    'protein',
  );
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
    'protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
    'carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
    'fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fiberMeta = const VerificationMeta('fiber');
  @override
  late final GeneratedColumn<double> fiber = GeneratedColumn<double>(
    'fiber',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
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
    mealType,
    foodName,
    quantity,
    unit,
    calories,
    protein,
    carbs,
    fat,
    fiber,
    loggedAt,
    notes,
    imageUrl,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodLog> instance, {
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
    if (data.containsKey('meal_type')) {
      context.handle(
        _mealTypeMeta,
        mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('food_name')) {
      context.handle(
        _foodNameMeta,
        foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta),
      );
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(
        _caloriesMeta,
        calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(
        _proteinMeta,
        protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta),
      );
    }
    if (data.containsKey('carbs')) {
      context.handle(
        _carbsMeta,
        carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta),
      );
    }
    if (data.containsKey('fat')) {
      context.handle(
        _fatMeta,
        fat.isAcceptableOrUnknown(data['fat']!, _fatMeta),
      );
    }
    if (data.containsKey('fiber')) {
      context.handle(
        _fiberMeta,
        fiber.isAcceptableOrUnknown(data['fiber']!, _fiberMeta),
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
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
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
  FoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      mealType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meal_type'],
      )!,
      foodName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}food_name'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      calories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories'],
      )!,
      protein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein'],
      ),
      carbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs'],
      ),
      fat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat'],
      ),
      fiber: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber'],
      ),
      loggedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}logged_at'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
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
  $FoodLogsTable createAlias(String alias) {
    return $FoodLogsTable(attachedDatabase, alias);
  }
}

class FoodLog extends DataClass implements Insertable<FoodLog> {
  final int id;
  final String userId;
  final String mealType;
  final String foodName;
  final double quantity;
  final String unit;
  final int calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final double? fiber;
  final DateTime loggedAt;
  final String? notes;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodLog({
    required this.id,
    required this.userId,
    required this.mealType,
    required this.foodName,
    required this.quantity,
    required this.unit,
    required this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.fiber,
    required this.loggedAt,
    this.notes,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['meal_type'] = Variable<String>(mealType);
    map['food_name'] = Variable<String>(foodName);
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    map['calories'] = Variable<int>(calories);
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || carbs != null) {
      map['carbs'] = Variable<double>(carbs);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    if (!nullToAbsent || fiber != null) {
      map['fiber'] = Variable<double>(fiber);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodLogsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      mealType: Value(mealType),
      foodName: Value(foodName),
      quantity: Value(quantity),
      unit: Value(unit),
      calories: Value(calories),
      protein: protein == null && nullToAbsent
          ? const Value.absent()
          : Value(protein),
      carbs: carbs == null && nullToAbsent
          ? const Value.absent()
          : Value(carbs),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      fiber: fiber == null && nullToAbsent
          ? const Value.absent()
          : Value(fiber),
      loggedAt: Value(loggedAt),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      mealType: serializer.fromJson<String>(json['mealType']),
      foodName: serializer.fromJson<String>(json['foodName']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
      calories: serializer.fromJson<int>(json['calories']),
      protein: serializer.fromJson<double?>(json['protein']),
      carbs: serializer.fromJson<double?>(json['carbs']),
      fat: serializer.fromJson<double?>(json['fat']),
      fiber: serializer.fromJson<double?>(json['fiber']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
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
      'mealType': serializer.toJson<String>(mealType),
      'foodName': serializer.toJson<String>(foodName),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
      'calories': serializer.toJson<int>(calories),
      'protein': serializer.toJson<double?>(protein),
      'carbs': serializer.toJson<double?>(carbs),
      'fat': serializer.toJson<double?>(fat),
      'fiber': serializer.toJson<double?>(fiber),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'notes': serializer.toJson<String?>(notes),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodLog copyWith({
    int? id,
    String? userId,
    String? mealType,
    String? foodName,
    double? quantity,
    String? unit,
    int? calories,
    Value<double?> protein = const Value.absent(),
    Value<double?> carbs = const Value.absent(),
    Value<double?> fat = const Value.absent(),
    Value<double?> fiber = const Value.absent(),
    DateTime? loggedAt,
    Value<String?> notes = const Value.absent(),
    Value<String?> imageUrl = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    mealType: mealType ?? this.mealType,
    foodName: foodName ?? this.foodName,
    quantity: quantity ?? this.quantity,
    unit: unit ?? this.unit,
    calories: calories ?? this.calories,
    protein: protein.present ? protein.value : this.protein,
    carbs: carbs.present ? carbs.value : this.carbs,
    fat: fat.present ? fat.value : this.fat,
    fiber: fiber.present ? fiber.value : this.fiber,
    loggedAt: loggedAt ?? this.loggedAt,
    notes: notes.present ? notes.value : this.notes,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodLog copyWithCompanion(FoodLogsCompanion data) {
    return FoodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
      calories: data.calories.present ? data.calories.value : this.calories,
      protein: data.protein.present ? data.protein.value : this.protein,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fat: data.fat.present ? data.fat.value : this.fat,
      fiber: data.fiber.present ? data.fiber.value : this.fiber,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('mealType: $mealType, ')
          ..write('foodName: $foodName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('fiber: $fiber, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    mealType,
    foodName,
    quantity,
    unit,
    calories,
    protein,
    carbs,
    fat,
    fiber,
    loggedAt,
    notes,
    imageUrl,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.mealType == this.mealType &&
          other.foodName == this.foodName &&
          other.quantity == this.quantity &&
          other.unit == this.unit &&
          other.calories == this.calories &&
          other.protein == this.protein &&
          other.carbs == this.carbs &&
          other.fat == this.fat &&
          other.fiber == this.fiber &&
          other.loggedAt == this.loggedAt &&
          other.notes == this.notes &&
          other.imageUrl == this.imageUrl &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodLogsCompanion extends UpdateCompanion<FoodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> mealType;
  final Value<String> foodName;
  final Value<double> quantity;
  final Value<String> unit;
  final Value<int> calories;
  final Value<double?> protein;
  final Value<double?> carbs;
  final Value<double?> fat;
  final Value<double?> fiber;
  final Value<DateTime> loggedAt;
  final Value<String?> notes;
  final Value<String?> imageUrl;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FoodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.mealType = const Value.absent(),
    this.foodName = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
    this.calories = const Value.absent(),
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.fiber = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String mealType,
    required String foodName,
    required double quantity,
    required String unit,
    required int calories,
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.fiber = const Value.absent(),
    required DateTime loggedAt,
    this.notes = const Value.absent(),
    this.imageUrl = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       mealType = Value(mealType),
       foodName = Value(foodName),
       quantity = Value(quantity),
       unit = Value(unit),
       calories = Value(calories),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? mealType,
    Expression<String>? foodName,
    Expression<double>? quantity,
    Expression<String>? unit,
    Expression<int>? calories,
    Expression<double>? protein,
    Expression<double>? carbs,
    Expression<double>? fat,
    Expression<double>? fiber,
    Expression<DateTime>? loggedAt,
    Expression<String>? notes,
    Expression<String>? imageUrl,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (mealType != null) 'meal_type': mealType,
      if (foodName != null) 'food_name': foodName,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
      if (calories != null) 'calories': calories,
      if (protein != null) 'protein': protein,
      if (carbs != null) 'carbs': carbs,
      if (fat != null) 'fat': fat,
      if (fiber != null) 'fiber': fiber,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (notes != null) 'notes': notes,
      if (imageUrl != null) 'image_url': imageUrl,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? mealType,
    Value<String>? foodName,
    Value<double>? quantity,
    Value<String>? unit,
    Value<int>? calories,
    Value<double?>? protein,
    Value<double?>? carbs,
    Value<double?>? fat,
    Value<double?>? fiber,
    Value<DateTime>? loggedAt,
    Value<String?>? notes,
    Value<String?>? imageUrl,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FoodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      mealType: mealType ?? this.mealType,
      foodName: foodName ?? this.foodName,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      loggedAt: loggedAt ?? this.loggedAt,
      notes: notes ?? this.notes,
      imageUrl: imageUrl ?? this.imageUrl,
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
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (fiber.present) {
      map['fiber'] = Variable<double>(fiber.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
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
    return (StringBuffer('FoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('mealType: $mealType, ')
          ..write('foodName: $foodName, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('fiber: $fiber, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('notes: $notes, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FoodItemsTable extends FoodItems
    with TableInfo<$FoodItemsTable, FoodItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
    'brand',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPer100gMeta = const VerificationMeta(
    'caloriesPer100g',
  );
  @override
  late final GeneratedColumn<int> caloriesPer100g = GeneratedColumn<int>(
    'calories_per100g',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinPer100gMeta = const VerificationMeta(
    'proteinPer100g',
  );
  @override
  late final GeneratedColumn<double> proteinPer100g = GeneratedColumn<double>(
    'protein_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carbsPer100gMeta = const VerificationMeta(
    'carbsPer100g',
  );
  @override
  late final GeneratedColumn<double> carbsPer100g = GeneratedColumn<double>(
    'carbs_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatPer100gMeta = const VerificationMeta(
    'fatPer100g',
  );
  @override
  late final GeneratedColumn<double> fatPer100g = GeneratedColumn<double>(
    'fat_per100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fiberPer100gMeta = const VerificationMeta(
    'fiberPer100g',
  );
  @override
  late final GeneratedColumn<double> fiberPer100g = GeneratedColumn<double>(
    'fiber_per100g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingSizeMeta = const VerificationMeta(
    'servingSize',
  );
  @override
  late final GeneratedColumn<double> servingSize = GeneratedColumn<double>(
    'serving_size',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingUnitMeta = const VerificationMeta(
    'servingUnit',
  );
  @override
  late final GeneratedColumn<String> servingUnit = GeneratedColumn<String>(
    'serving_unit',
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
  static const VerificationMeta _isUserCreatedMeta = const VerificationMeta(
    'isUserCreated',
  );
  @override
  late final GeneratedColumn<bool> isUserCreated = GeneratedColumn<bool>(
    'is_user_created',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_user_created" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isVerifiedMeta = const VerificationMeta(
    'isVerified',
  );
  @override
  late final GeneratedColumn<bool> isVerified = GeneratedColumn<bool>(
    'is_verified',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_verified" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    name,
    brand,
    barcode,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    fiberPer100g,
    servingSize,
    servingUnit,
    category,
    isUserCreated,
    isVerified,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodItem> instance, {
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
    if (data.containsKey('brand')) {
      context.handle(
        _brandMeta,
        brand.isAcceptableOrUnknown(data['brand']!, _brandMeta),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
        _caloriesPer100gMeta,
        caloriesPer100g.isAcceptableOrUnknown(
          data['calories_per100g']!,
          _caloriesPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriesPer100gMeta);
    }
    if (data.containsKey('protein_per100g')) {
      context.handle(
        _proteinPer100gMeta,
        proteinPer100g.isAcceptableOrUnknown(
          data['protein_per100g']!,
          _proteinPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_proteinPer100gMeta);
    }
    if (data.containsKey('carbs_per100g')) {
      context.handle(
        _carbsPer100gMeta,
        carbsPer100g.isAcceptableOrUnknown(
          data['carbs_per100g']!,
          _carbsPer100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carbsPer100gMeta);
    }
    if (data.containsKey('fat_per100g')) {
      context.handle(
        _fatPer100gMeta,
        fatPer100g.isAcceptableOrUnknown(data['fat_per100g']!, _fatPer100gMeta),
      );
    } else if (isInserting) {
      context.missing(_fatPer100gMeta);
    }
    if (data.containsKey('fiber_per100g')) {
      context.handle(
        _fiberPer100gMeta,
        fiberPer100g.isAcceptableOrUnknown(
          data['fiber_per100g']!,
          _fiberPer100gMeta,
        ),
      );
    }
    if (data.containsKey('serving_size')) {
      context.handle(
        _servingSizeMeta,
        servingSize.isAcceptableOrUnknown(
          data['serving_size']!,
          _servingSizeMeta,
        ),
      );
    }
    if (data.containsKey('serving_unit')) {
      context.handle(
        _servingUnitMeta,
        servingUnit.isAcceptableOrUnknown(
          data['serving_unit']!,
          _servingUnitMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_user_created')) {
      context.handle(
        _isUserCreatedMeta,
        isUserCreated.isAcceptableOrUnknown(
          data['is_user_created']!,
          _isUserCreatedMeta,
        ),
      );
    }
    if (data.containsKey('is_verified')) {
      context.handle(
        _isVerifiedMeta,
        isVerified.isAcceptableOrUnknown(data['is_verified']!, _isVerifiedMeta),
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
  FoodItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      brand: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand'],
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      caloriesPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per100g'],
      )!,
      proteinPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per100g'],
      )!,
      carbsPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per100g'],
      )!,
      fatPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per100g'],
      )!,
      fiberPer100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fiber_per100g'],
      ),
      servingSize: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}serving_size'],
      ),
      servingUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serving_unit'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isUserCreated: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_user_created'],
      )!,
      isVerified: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_verified'],
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
  $FoodItemsTable createAlias(String alias) {
    return $FoodItemsTable(attachedDatabase, alias);
  }
}

class FoodItem extends DataClass implements Insertable<FoodItem> {
  final int id;
  final String name;
  final String? brand;
  final String? barcode;
  final int caloriesPer100g;
  final double proteinPer100g;
  final double carbsPer100g;
  final double fatPer100g;
  final double? fiberPer100g;
  final double? servingSize;
  final String? servingUnit;
  final String? category;
  final bool isUserCreated;
  final bool isVerified;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FoodItem({
    required this.id,
    required this.name,
    this.brand,
    this.barcode,
    required this.caloriesPer100g,
    required this.proteinPer100g,
    required this.carbsPer100g,
    required this.fatPer100g,
    this.fiberPer100g,
    this.servingSize,
    this.servingUnit,
    this.category,
    required this.isUserCreated,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String>(brand);
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['calories_per100g'] = Variable<int>(caloriesPer100g);
    map['protein_per100g'] = Variable<double>(proteinPer100g);
    map['carbs_per100g'] = Variable<double>(carbsPer100g);
    map['fat_per100g'] = Variable<double>(fatPer100g);
    if (!nullToAbsent || fiberPer100g != null) {
      map['fiber_per100g'] = Variable<double>(fiberPer100g);
    }
    if (!nullToAbsent || servingSize != null) {
      map['serving_size'] = Variable<double>(servingSize);
    }
    if (!nullToAbsent || servingUnit != null) {
      map['serving_unit'] = Variable<String>(servingUnit);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_user_created'] = Variable<bool>(isUserCreated);
    map['is_verified'] = Variable<bool>(isVerified);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FoodItemsCompanion toCompanion(bool nullToAbsent) {
    return FoodItemsCompanion(
      id: Value(id),
      name: Value(name),
      brand: brand == null && nullToAbsent
          ? const Value.absent()
          : Value(brand),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      caloriesPer100g: Value(caloriesPer100g),
      proteinPer100g: Value(proteinPer100g),
      carbsPer100g: Value(carbsPer100g),
      fatPer100g: Value(fatPer100g),
      fiberPer100g: fiberPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberPer100g),
      servingSize: servingSize == null && nullToAbsent
          ? const Value.absent()
          : Value(servingSize),
      servingUnit: servingUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(servingUnit),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isUserCreated: Value(isUserCreated),
      isVerified: Value(isVerified),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FoodItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodItem(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      brand: serializer.fromJson<String?>(json['brand']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      caloriesPer100g: serializer.fromJson<int>(json['caloriesPer100g']),
      proteinPer100g: serializer.fromJson<double>(json['proteinPer100g']),
      carbsPer100g: serializer.fromJson<double>(json['carbsPer100g']),
      fatPer100g: serializer.fromJson<double>(json['fatPer100g']),
      fiberPer100g: serializer.fromJson<double?>(json['fiberPer100g']),
      servingSize: serializer.fromJson<double?>(json['servingSize']),
      servingUnit: serializer.fromJson<String?>(json['servingUnit']),
      category: serializer.fromJson<String?>(json['category']),
      isUserCreated: serializer.fromJson<bool>(json['isUserCreated']),
      isVerified: serializer.fromJson<bool>(json['isVerified']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'brand': serializer.toJson<String?>(brand),
      'barcode': serializer.toJson<String?>(barcode),
      'caloriesPer100g': serializer.toJson<int>(caloriesPer100g),
      'proteinPer100g': serializer.toJson<double>(proteinPer100g),
      'carbsPer100g': serializer.toJson<double>(carbsPer100g),
      'fatPer100g': serializer.toJson<double>(fatPer100g),
      'fiberPer100g': serializer.toJson<double?>(fiberPer100g),
      'servingSize': serializer.toJson<double?>(servingSize),
      'servingUnit': serializer.toJson<String?>(servingUnit),
      'category': serializer.toJson<String?>(category),
      'isUserCreated': serializer.toJson<bool>(isUserCreated),
      'isVerified': serializer.toJson<bool>(isVerified),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FoodItem copyWith({
    int? id,
    String? name,
    Value<String?> brand = const Value.absent(),
    Value<String?> barcode = const Value.absent(),
    int? caloriesPer100g,
    double? proteinPer100g,
    double? carbsPer100g,
    double? fatPer100g,
    Value<double?> fiberPer100g = const Value.absent(),
    Value<double?> servingSize = const Value.absent(),
    Value<String?> servingUnit = const Value.absent(),
    Value<String?> category = const Value.absent(),
    bool? isUserCreated,
    bool? isVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FoodItem(
    id: id ?? this.id,
    name: name ?? this.name,
    brand: brand.present ? brand.value : this.brand,
    barcode: barcode.present ? barcode.value : this.barcode,
    caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
    proteinPer100g: proteinPer100g ?? this.proteinPer100g,
    carbsPer100g: carbsPer100g ?? this.carbsPer100g,
    fatPer100g: fatPer100g ?? this.fatPer100g,
    fiberPer100g: fiberPer100g.present ? fiberPer100g.value : this.fiberPer100g,
    servingSize: servingSize.present ? servingSize.value : this.servingSize,
    servingUnit: servingUnit.present ? servingUnit.value : this.servingUnit,
    category: category.present ? category.value : this.category,
    isUserCreated: isUserCreated ?? this.isUserCreated,
    isVerified: isVerified ?? this.isVerified,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FoodItem copyWithCompanion(FoodItemsCompanion data) {
    return FoodItem(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      brand: data.brand.present ? data.brand.value : this.brand,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinPer100g: data.proteinPer100g.present
          ? data.proteinPer100g.value
          : this.proteinPer100g,
      carbsPer100g: data.carbsPer100g.present
          ? data.carbsPer100g.value
          : this.carbsPer100g,
      fatPer100g: data.fatPer100g.present
          ? data.fatPer100g.value
          : this.fatPer100g,
      fiberPer100g: data.fiberPer100g.present
          ? data.fiberPer100g.value
          : this.fiberPer100g,
      servingSize: data.servingSize.present
          ? data.servingSize.value
          : this.servingSize,
      servingUnit: data.servingUnit.present
          ? data.servingUnit.value
          : this.servingUnit,
      category: data.category.present ? data.category.value : this.category,
      isUserCreated: data.isUserCreated.present
          ? data.isUserCreated.value
          : this.isUserCreated,
      isVerified: data.isVerified.present
          ? data.isVerified.value
          : this.isVerified,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodItem(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('servingSize: $servingSize, ')
          ..write('servingUnit: $servingUnit, ')
          ..write('category: $category, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    brand,
    barcode,
    caloriesPer100g,
    proteinPer100g,
    carbsPer100g,
    fatPer100g,
    fiberPer100g,
    servingSize,
    servingUnit,
    category,
    isUserCreated,
    isVerified,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodItem &&
          other.id == this.id &&
          other.name == this.name &&
          other.brand == this.brand &&
          other.barcode == this.barcode &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinPer100g == this.proteinPer100g &&
          other.carbsPer100g == this.carbsPer100g &&
          other.fatPer100g == this.fatPer100g &&
          other.fiberPer100g == this.fiberPer100g &&
          other.servingSize == this.servingSize &&
          other.servingUnit == this.servingUnit &&
          other.category == this.category &&
          other.isUserCreated == this.isUserCreated &&
          other.isVerified == this.isVerified &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FoodItemsCompanion extends UpdateCompanion<FoodItem> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> brand;
  final Value<String?> barcode;
  final Value<int> caloriesPer100g;
  final Value<double> proteinPer100g;
  final Value<double> carbsPer100g;
  final Value<double> fatPer100g;
  final Value<double?> fiberPer100g;
  final Value<double?> servingSize;
  final Value<String?> servingUnit;
  final Value<String?> category;
  final Value<bool> isUserCreated;
  final Value<bool> isVerified;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FoodItemsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinPer100g = const Value.absent(),
    this.carbsPer100g = const Value.absent(),
    this.fatPer100g = const Value.absent(),
    this.fiberPer100g = const Value.absent(),
    this.servingSize = const Value.absent(),
    this.servingUnit = const Value.absent(),
    this.category = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.isVerified = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FoodItemsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    required int caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    this.fiberPer100g = const Value.absent(),
    this.servingSize = const Value.absent(),
    this.servingUnit = const Value.absent(),
    this.category = const Value.absent(),
    this.isUserCreated = const Value.absent(),
    this.isVerified = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : name = Value(name),
       caloriesPer100g = Value(caloriesPer100g),
       proteinPer100g = Value(proteinPer100g),
       carbsPer100g = Value(carbsPer100g),
       fatPer100g = Value(fatPer100g),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FoodItem> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? brand,
    Expression<String>? barcode,
    Expression<int>? caloriesPer100g,
    Expression<double>? proteinPer100g,
    Expression<double>? carbsPer100g,
    Expression<double>? fatPer100g,
    Expression<double>? fiberPer100g,
    Expression<double>? servingSize,
    Expression<String>? servingUnit,
    Expression<String>? category,
    Expression<bool>? isUserCreated,
    Expression<bool>? isVerified,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinPer100g != null) 'protein_per100g': proteinPer100g,
      if (carbsPer100g != null) 'carbs_per100g': carbsPer100g,
      if (fatPer100g != null) 'fat_per100g': fatPer100g,
      if (fiberPer100g != null) 'fiber_per100g': fiberPer100g,
      if (servingSize != null) 'serving_size': servingSize,
      if (servingUnit != null) 'serving_unit': servingUnit,
      if (category != null) 'category': category,
      if (isUserCreated != null) 'is_user_created': isUserCreated,
      if (isVerified != null) 'is_verified': isVerified,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FoodItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? brand,
    Value<String?>? barcode,
    Value<int>? caloriesPer100g,
    Value<double>? proteinPer100g,
    Value<double>? carbsPer100g,
    Value<double>? fatPer100g,
    Value<double?>? fiberPer100g,
    Value<double?>? servingSize,
    Value<String?>? servingUnit,
    Value<String?>? category,
    Value<bool>? isUserCreated,
    Value<bool>? isVerified,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FoodItemsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinPer100g: proteinPer100g ?? this.proteinPer100g,
      carbsPer100g: carbsPer100g ?? this.carbsPer100g,
      fatPer100g: fatPer100g ?? this.fatPer100g,
      fiberPer100g: fiberPer100g ?? this.fiberPer100g,
      servingSize: servingSize ?? this.servingSize,
      servingUnit: servingUnit ?? this.servingUnit,
      category: category ?? this.category,
      isUserCreated: isUserCreated ?? this.isUserCreated,
      isVerified: isVerified ?? this.isVerified,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<int>(caloriesPer100g.value);
    }
    if (proteinPer100g.present) {
      map['protein_per100g'] = Variable<double>(proteinPer100g.value);
    }
    if (carbsPer100g.present) {
      map['carbs_per100g'] = Variable<double>(carbsPer100g.value);
    }
    if (fatPer100g.present) {
      map['fat_per100g'] = Variable<double>(fatPer100g.value);
    }
    if (fiberPer100g.present) {
      map['fiber_per100g'] = Variable<double>(fiberPer100g.value);
    }
    if (servingSize.present) {
      map['serving_size'] = Variable<double>(servingSize.value);
    }
    if (servingUnit.present) {
      map['serving_unit'] = Variable<String>(servingUnit.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isUserCreated.present) {
      map['is_user_created'] = Variable<bool>(isUserCreated.value);
    }
    if (isVerified.present) {
      map['is_verified'] = Variable<bool>(isVerified.value);
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
    return (StringBuffer('FoodItemsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinPer100g: $proteinPer100g, ')
          ..write('carbsPer100g: $carbsPer100g, ')
          ..write('fatPer100g: $fatPer100g, ')
          ..write('fiberPer100g: $fiberPer100g, ')
          ..write('servingSize: $servingSize, ')
          ..write('servingUnit: $servingUnit, ')
          ..write('category: $category, ')
          ..write('isUserCreated: $isUserCreated, ')
          ..write('isVerified: $isVerified, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $WorkoutLogsTable extends WorkoutLogs
    with TableInfo<$WorkoutLogsTable, WorkoutLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _workoutTypeMeta = const VerificationMeta(
    'workoutType',
  );
  @override
  late final GeneratedColumn<String> workoutType = GeneratedColumn<String>(
    'workout_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _intensityMeta = const VerificationMeta(
    'intensity',
  );
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
    'intensity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateAvgMeta = const VerificationMeta(
    'heartRateAvg',
  );
  @override
  late final GeneratedColumn<int> heartRateAvg = GeneratedColumn<int>(
    'heart_rate_avg',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heartRateMaxMeta = const VerificationMeta(
    'heartRateMax',
  );
  @override
  late final GeneratedColumn<int> heartRateMax = GeneratedColumn<int>(
    'heart_rate_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _setsMeta = const VerificationMeta('sets');
  @override
  late final GeneratedColumn<int> sets = GeneratedColumn<int>(
    'sets',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    workoutType,
    exerciseName,
    durationMinutes,
    caloriesBurned,
    intensity,
    heartRateAvg,
    heartRateMax,
    sets,
    reps,
    weight,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutLog> instance, {
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
    if (data.containsKey('workout_type')) {
      context.handle(
        _workoutTypeMeta,
        workoutType.isAcceptableOrUnknown(
          data['workout_type']!,
          _workoutTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_workoutTypeMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
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
    if (data.containsKey('intensity')) {
      context.handle(
        _intensityMeta,
        intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta),
      );
    }
    if (data.containsKey('heart_rate_avg')) {
      context.handle(
        _heartRateAvgMeta,
        heartRateAvg.isAcceptableOrUnknown(
          data['heart_rate_avg']!,
          _heartRateAvgMeta,
        ),
      );
    }
    if (data.containsKey('heart_rate_max')) {
      context.handle(
        _heartRateMaxMeta,
        heartRateMax.isAcceptableOrUnknown(
          data['heart_rate_max']!,
          _heartRateMaxMeta,
        ),
      );
    }
    if (data.containsKey('sets')) {
      context.handle(
        _setsMeta,
        sets.isAcceptableOrUnknown(data['sets']!, _setsMeta),
      );
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
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
  WorkoutLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      workoutType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_type'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      caloriesBurned: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_burned'],
      ),
      intensity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}intensity'],
      ),
      heartRateAvg: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_avg'],
      ),
      heartRateMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}heart_rate_max'],
      ),
      sets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sets'],
      ),
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
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
  $WorkoutLogsTable createAlias(String alias) {
    return $WorkoutLogsTable(attachedDatabase, alias);
  }
}

class WorkoutLog extends DataClass implements Insertable<WorkoutLog> {
  final int id;
  final String userId;
  final String workoutType;
  final String exerciseName;
  final int durationMinutes;
  final int? caloriesBurned;
  final int? intensity;
  final int? heartRateAvg;
  final int? heartRateMax;
  final int? sets;
  final int? reps;
  final double? weight;
  final String? notes;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const WorkoutLog({
    required this.id,
    required this.userId,
    required this.workoutType,
    required this.exerciseName,
    required this.durationMinutes,
    this.caloriesBurned,
    this.intensity,
    this.heartRateAvg,
    this.heartRateMax,
    this.sets,
    this.reps,
    this.weight,
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
    map['workout_type'] = Variable<String>(workoutType);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<int>(caloriesBurned);
    }
    if (!nullToAbsent || intensity != null) {
      map['intensity'] = Variable<int>(intensity);
    }
    if (!nullToAbsent || heartRateAvg != null) {
      map['heart_rate_avg'] = Variable<int>(heartRateAvg);
    }
    if (!nullToAbsent || heartRateMax != null) {
      map['heart_rate_max'] = Variable<int>(heartRateMax);
    }
    if (!nullToAbsent || sets != null) {
      map['sets'] = Variable<int>(sets);
    }
    if (!nullToAbsent || reps != null) {
      map['reps'] = Variable<int>(reps);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WorkoutLogsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      workoutType: Value(workoutType),
      exerciseName: Value(exerciseName),
      durationMinutes: Value(durationMinutes),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      intensity: intensity == null && nullToAbsent
          ? const Value.absent()
          : Value(intensity),
      heartRateAvg: heartRateAvg == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateAvg),
      heartRateMax: heartRateMax == null && nullToAbsent
          ? const Value.absent()
          : Value(heartRateMax),
      sets: sets == null && nullToAbsent ? const Value.absent() : Value(sets),
      reps: reps == null && nullToAbsent ? const Value.absent() : Value(reps),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WorkoutLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      workoutType: serializer.fromJson<String>(json['workoutType']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      caloriesBurned: serializer.fromJson<int?>(json['caloriesBurned']),
      intensity: serializer.fromJson<int?>(json['intensity']),
      heartRateAvg: serializer.fromJson<int?>(json['heartRateAvg']),
      heartRateMax: serializer.fromJson<int?>(json['heartRateMax']),
      sets: serializer.fromJson<int?>(json['sets']),
      reps: serializer.fromJson<int?>(json['reps']),
      weight: serializer.fromJson<double?>(json['weight']),
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
      'workoutType': serializer.toJson<String>(workoutType),
      'exerciseName': serializer.toJson<String>(exerciseName),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'caloriesBurned': serializer.toJson<int?>(caloriesBurned),
      'intensity': serializer.toJson<int?>(intensity),
      'heartRateAvg': serializer.toJson<int?>(heartRateAvg),
      'heartRateMax': serializer.toJson<int?>(heartRateMax),
      'sets': serializer.toJson<int?>(sets),
      'reps': serializer.toJson<int?>(reps),
      'weight': serializer.toJson<double?>(weight),
      'notes': serializer.toJson<String?>(notes),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WorkoutLog copyWith({
    int? id,
    String? userId,
    String? workoutType,
    String? exerciseName,
    int? durationMinutes,
    Value<int?> caloriesBurned = const Value.absent(),
    Value<int?> intensity = const Value.absent(),
    Value<int?> heartRateAvg = const Value.absent(),
    Value<int?> heartRateMax = const Value.absent(),
    Value<int?> sets = const Value.absent(),
    Value<int?> reps = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => WorkoutLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    workoutType: workoutType ?? this.workoutType,
    exerciseName: exerciseName ?? this.exerciseName,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    caloriesBurned: caloriesBurned.present
        ? caloriesBurned.value
        : this.caloriesBurned,
    intensity: intensity.present ? intensity.value : this.intensity,
    heartRateAvg: heartRateAvg.present ? heartRateAvg.value : this.heartRateAvg,
    heartRateMax: heartRateMax.present ? heartRateMax.value : this.heartRateMax,
    sets: sets.present ? sets.value : this.sets,
    reps: reps.present ? reps.value : this.reps,
    weight: weight.present ? weight.value : this.weight,
    notes: notes.present ? notes.value : this.notes,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WorkoutLog copyWithCompanion(WorkoutLogsCompanion data) {
    return WorkoutLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      workoutType: data.workoutType.present
          ? data.workoutType.value
          : this.workoutType,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      heartRateAvg: data.heartRateAvg.present
          ? data.heartRateAvg.value
          : this.heartRateAvg,
      heartRateMax: data.heartRateMax.present
          ? data.heartRateMax.value
          : this.heartRateMax,
      sets: data.sets.present ? data.sets.value : this.sets,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      notes: data.notes.present ? data.notes.value : this.notes,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutType: $workoutType, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('intensity: $intensity, ')
          ..write('heartRateAvg: $heartRateAvg, ')
          ..write('heartRateMax: $heartRateMax, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
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
    workoutType,
    exerciseName,
    durationMinutes,
    caloriesBurned,
    intensity,
    heartRateAvg,
    heartRateMax,
    sets,
    reps,
    weight,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.workoutType == this.workoutType &&
          other.exerciseName == this.exerciseName &&
          other.durationMinutes == this.durationMinutes &&
          other.caloriesBurned == this.caloriesBurned &&
          other.intensity == this.intensity &&
          other.heartRateAvg == this.heartRateAvg &&
          other.heartRateMax == this.heartRateMax &&
          other.sets == this.sets &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.notes == this.notes &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class WorkoutLogsCompanion extends UpdateCompanion<WorkoutLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> workoutType;
  final Value<String> exerciseName;
  final Value<int> durationMinutes;
  final Value<int?> caloriesBurned;
  final Value<int?> intensity;
  final Value<int?> heartRateAvg;
  final Value<int?> heartRateMax;
  final Value<int?> sets;
  final Value<int?> reps;
  final Value<double?> weight;
  final Value<String?> notes;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const WorkoutLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.workoutType = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.intensity = const Value.absent(),
    this.heartRateAvg = const Value.absent(),
    this.heartRateMax = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  WorkoutLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String workoutType,
    required String exerciseName,
    required int durationMinutes,
    this.caloriesBurned = const Value.absent(),
    this.intensity = const Value.absent(),
    this.heartRateAvg = const Value.absent(),
    this.heartRateMax = const Value.absent(),
    this.sets = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       workoutType = Value(workoutType),
       exerciseName = Value(exerciseName),
       durationMinutes = Value(durationMinutes),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<WorkoutLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? workoutType,
    Expression<String>? exerciseName,
    Expression<int>? durationMinutes,
    Expression<int>? caloriesBurned,
    Expression<int>? intensity,
    Expression<int>? heartRateAvg,
    Expression<int>? heartRateMax,
    Expression<int>? sets,
    Expression<int>? reps,
    Expression<double>? weight,
    Expression<String>? notes,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (workoutType != null) 'workout_type': workoutType,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (intensity != null) 'intensity': intensity,
      if (heartRateAvg != null) 'heart_rate_avg': heartRateAvg,
      if (heartRateMax != null) 'heart_rate_max': heartRateMax,
      if (sets != null) 'sets': sets,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (notes != null) 'notes': notes,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  WorkoutLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? workoutType,
    Value<String>? exerciseName,
    Value<int>? durationMinutes,
    Value<int?>? caloriesBurned,
    Value<int?>? intensity,
    Value<int?>? heartRateAvg,
    Value<int?>? heartRateMax,
    Value<int?>? sets,
    Value<int?>? reps,
    Value<double?>? weight,
    Value<String?>? notes,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return WorkoutLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      workoutType: workoutType ?? this.workoutType,
      exerciseName: exerciseName ?? this.exerciseName,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      intensity: intensity ?? this.intensity,
      heartRateAvg: heartRateAvg ?? this.heartRateAvg,
      heartRateMax: heartRateMax ?? this.heartRateMax,
      sets: sets ?? this.sets,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
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
    if (workoutType.present) {
      map['workout_type'] = Variable<String>(workoutType.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (heartRateAvg.present) {
      map['heart_rate_avg'] = Variable<int>(heartRateAvg.value);
    }
    if (heartRateMax.present) {
      map['heart_rate_max'] = Variable<int>(heartRateMax.value);
    }
    if (sets.present) {
      map['sets'] = Variable<int>(sets.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
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
    return (StringBuffer('WorkoutLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('workoutType: $workoutType, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('intensity: $intensity, ')
          ..write('heartRateAvg: $heartRateAvg, ')
          ..write('heartRateMax: $heartRateMax, ')
          ..write('sets: $sets, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('notes: $notes, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sleepStartMeta = const VerificationMeta(
    'sleepStart',
  );
  @override
  late final GeneratedColumn<DateTime> sleepStart = GeneratedColumn<DateTime>(
    'sleep_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sleepEndMeta = const VerificationMeta(
    'sleepEnd',
  );
  @override
  late final GeneratedColumn<DateTime> sleepEnd = GeneratedColumn<DateTime>(
    'sleep_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<int> quality = GeneratedColumn<int>(
    'quality',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deepSleepMinutesMeta = const VerificationMeta(
    'deepSleepMinutes',
  );
  @override
  late final GeneratedColumn<int> deepSleepMinutes = GeneratedColumn<int>(
    'deep_sleep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _remSleepMinutesMeta = const VerificationMeta(
    'remSleepMinutes',
  );
  @override
  late final GeneratedColumn<int> remSleepMinutes = GeneratedColumn<int>(
    'rem_sleep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lightSleepMinutesMeta = const VerificationMeta(
    'lightSleepMinutes',
  );
  @override
  late final GeneratedColumn<int> lightSleepMinutes = GeneratedColumn<int>(
    'light_sleep_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _awakeMinutesMeta = const VerificationMeta(
    'awakeMinutes',
  );
  @override
  late final GeneratedColumn<int> awakeMinutes = GeneratedColumn<int>(
    'awake_minutes',
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
    sleepStart,
    sleepEnd,
    durationMinutes,
    quality,
    deepSleepMinutes,
    remSleepMinutes,
    lightSleepMinutes,
    awakeMinutes,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
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
    if (data.containsKey('sleep_start')) {
      context.handle(
        _sleepStartMeta,
        sleepStart.isAcceptableOrUnknown(data['sleep_start']!, _sleepStartMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepStartMeta);
    }
    if (data.containsKey('sleep_end')) {
      context.handle(
        _sleepEndMeta,
        sleepEnd.isAcceptableOrUnknown(data['sleep_end']!, _sleepEndMeta),
      );
    } else if (isInserting) {
      context.missing(_sleepEndMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('deep_sleep_minutes')) {
      context.handle(
        _deepSleepMinutesMeta,
        deepSleepMinutes.isAcceptableOrUnknown(
          data['deep_sleep_minutes']!,
          _deepSleepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('rem_sleep_minutes')) {
      context.handle(
        _remSleepMinutesMeta,
        remSleepMinutes.isAcceptableOrUnknown(
          data['rem_sleep_minutes']!,
          _remSleepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('light_sleep_minutes')) {
      context.handle(
        _lightSleepMinutesMeta,
        lightSleepMinutes.isAcceptableOrUnknown(
          data['light_sleep_minutes']!,
          _lightSleepMinutesMeta,
        ),
      );
    }
    if (data.containsKey('awake_minutes')) {
      context.handle(
        _awakeMinutesMeta,
        awakeMinutes.isAcceptableOrUnknown(
          data['awake_minutes']!,
          _awakeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      sleepStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sleep_start'],
      )!,
      sleepEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sleep_end'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quality'],
      ),
      deepSleepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deep_sleep_minutes'],
      ),
      remSleepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rem_sleep_minutes'],
      ),
      lightSleepMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}light_sleep_minutes'],
      ),
      awakeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}awake_minutes'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final int id;
  final String userId;
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final int durationMinutes;
  final int? quality;
  final int? deepSleepMinutes;
  final int? remSleepMinutes;
  final int? lightSleepMinutes;
  final int? awakeMinutes;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const SleepLog({
    required this.id,
    required this.userId,
    required this.sleepStart,
    required this.sleepEnd,
    required this.durationMinutes,
    this.quality,
    this.deepSleepMinutes,
    this.remSleepMinutes,
    this.lightSleepMinutes,
    this.awakeMinutes,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['sleep_start'] = Variable<DateTime>(sleepStart);
    map['sleep_end'] = Variable<DateTime>(sleepEnd);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || quality != null) {
      map['quality'] = Variable<int>(quality);
    }
    if (!nullToAbsent || deepSleepMinutes != null) {
      map['deep_sleep_minutes'] = Variable<int>(deepSleepMinutes);
    }
    if (!nullToAbsent || remSleepMinutes != null) {
      map['rem_sleep_minutes'] = Variable<int>(remSleepMinutes);
    }
    if (!nullToAbsent || lightSleepMinutes != null) {
      map['light_sleep_minutes'] = Variable<int>(lightSleepMinutes);
    }
    if (!nullToAbsent || awakeMinutes != null) {
      map['awake_minutes'] = Variable<int>(awakeMinutes);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      sleepStart: Value(sleepStart),
      sleepEnd: Value(sleepEnd),
      durationMinutes: Value(durationMinutes),
      quality: quality == null && nullToAbsent
          ? const Value.absent()
          : Value(quality),
      deepSleepMinutes: deepSleepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(deepSleepMinutes),
      remSleepMinutes: remSleepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(remSleepMinutes),
      lightSleepMinutes: lightSleepMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(lightSleepMinutes),
      awakeMinutes: awakeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(awakeMinutes),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      sleepStart: serializer.fromJson<DateTime>(json['sleepStart']),
      sleepEnd: serializer.fromJson<DateTime>(json['sleepEnd']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      quality: serializer.fromJson<int?>(json['quality']),
      deepSleepMinutes: serializer.fromJson<int?>(json['deepSleepMinutes']),
      remSleepMinutes: serializer.fromJson<int?>(json['remSleepMinutes']),
      lightSleepMinutes: serializer.fromJson<int?>(json['lightSleepMinutes']),
      awakeMinutes: serializer.fromJson<int?>(json['awakeMinutes']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'sleepStart': serializer.toJson<DateTime>(sleepStart),
      'sleepEnd': serializer.toJson<DateTime>(sleepEnd),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'quality': serializer.toJson<int?>(quality),
      'deepSleepMinutes': serializer.toJson<int?>(deepSleepMinutes),
      'remSleepMinutes': serializer.toJson<int?>(remSleepMinutes),
      'lightSleepMinutes': serializer.toJson<int?>(lightSleepMinutes),
      'awakeMinutes': serializer.toJson<int?>(awakeMinutes),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  SleepLog copyWith({
    int? id,
    String? userId,
    DateTime? sleepStart,
    DateTime? sleepEnd,
    int? durationMinutes,
    Value<int?> quality = const Value.absent(),
    Value<int?> deepSleepMinutes = const Value.absent(),
    Value<int?> remSleepMinutes = const Value.absent(),
    Value<int?> lightSleepMinutes = const Value.absent(),
    Value<int?> awakeMinutes = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => SleepLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    sleepStart: sleepStart ?? this.sleepStart,
    sleepEnd: sleepEnd ?? this.sleepEnd,
    durationMinutes: durationMinutes ?? this.durationMinutes,
    quality: quality.present ? quality.value : this.quality,
    deepSleepMinutes: deepSleepMinutes.present
        ? deepSleepMinutes.value
        : this.deepSleepMinutes,
    remSleepMinutes: remSleepMinutes.present
        ? remSleepMinutes.value
        : this.remSleepMinutes,
    lightSleepMinutes: lightSleepMinutes.present
        ? lightSleepMinutes.value
        : this.lightSleepMinutes,
    awakeMinutes: awakeMinutes.present ? awakeMinutes.value : this.awakeMinutes,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      sleepStart: data.sleepStart.present
          ? data.sleepStart.value
          : this.sleepStart,
      sleepEnd: data.sleepEnd.present ? data.sleepEnd.value : this.sleepEnd,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      quality: data.quality.present ? data.quality.value : this.quality,
      deepSleepMinutes: data.deepSleepMinutes.present
          ? data.deepSleepMinutes.value
          : this.deepSleepMinutes,
      remSleepMinutes: data.remSleepMinutes.present
          ? data.remSleepMinutes.value
          : this.remSleepMinutes,
      lightSleepMinutes: data.lightSleepMinutes.present
          ? data.lightSleepMinutes.value
          : this.lightSleepMinutes,
      awakeMinutes: data.awakeMinutes.present
          ? data.awakeMinutes.value
          : this.awakeMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('sleepStart: $sleepStart, ')
          ..write('sleepEnd: $sleepEnd, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('quality: $quality, ')
          ..write('deepSleepMinutes: $deepSleepMinutes, ')
          ..write('remSleepMinutes: $remSleepMinutes, ')
          ..write('lightSleepMinutes: $lightSleepMinutes, ')
          ..write('awakeMinutes: $awakeMinutes, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    sleepStart,
    sleepEnd,
    durationMinutes,
    quality,
    deepSleepMinutes,
    remSleepMinutes,
    lightSleepMinutes,
    awakeMinutes,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.sleepStart == this.sleepStart &&
          other.sleepEnd == this.sleepEnd &&
          other.durationMinutes == this.durationMinutes &&
          other.quality == this.quality &&
          other.deepSleepMinutes == this.deepSleepMinutes &&
          other.remSleepMinutes == this.remSleepMinutes &&
          other.lightSleepMinutes == this.lightSleepMinutes &&
          other.awakeMinutes == this.awakeMinutes &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> sleepStart;
  final Value<DateTime> sleepEnd;
  final Value<int> durationMinutes;
  final Value<int?> quality;
  final Value<int?> deepSleepMinutes;
  final Value<int?> remSleepMinutes;
  final Value<int?> lightSleepMinutes;
  final Value<int?> awakeMinutes;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.sleepStart = const Value.absent(),
    this.sleepEnd = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.quality = const Value.absent(),
    this.deepSleepMinutes = const Value.absent(),
    this.remSleepMinutes = const Value.absent(),
    this.lightSleepMinutes = const Value.absent(),
    this.awakeMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    required int durationMinutes,
    this.quality = const Value.absent(),
    this.deepSleepMinutes = const Value.absent(),
    this.remSleepMinutes = const Value.absent(),
    this.lightSleepMinutes = const Value.absent(),
    this.awakeMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       sleepStart = Value(sleepStart),
       sleepEnd = Value(sleepEnd),
       durationMinutes = Value(durationMinutes),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<SleepLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? sleepStart,
    Expression<DateTime>? sleepEnd,
    Expression<int>? durationMinutes,
    Expression<int>? quality,
    Expression<int>? deepSleepMinutes,
    Expression<int>? remSleepMinutes,
    Expression<int>? lightSleepMinutes,
    Expression<int>? awakeMinutes,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (sleepStart != null) 'sleep_start': sleepStart,
      if (sleepEnd != null) 'sleep_end': sleepEnd,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (quality != null) 'quality': quality,
      if (deepSleepMinutes != null) 'deep_sleep_minutes': deepSleepMinutes,
      if (remSleepMinutes != null) 'rem_sleep_minutes': remSleepMinutes,
      if (lightSleepMinutes != null) 'light_sleep_minutes': lightSleepMinutes,
      if (awakeMinutes != null) 'awake_minutes': awakeMinutes,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SleepLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? sleepStart,
    Value<DateTime>? sleepEnd,
    Value<int>? durationMinutes,
    Value<int?>? quality,
    Value<int?>? deepSleepMinutes,
    Value<int?>? remSleepMinutes,
    Value<int?>? lightSleepMinutes,
    Value<int?>? awakeMinutes,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sleepStart: sleepStart ?? this.sleepStart,
      sleepEnd: sleepEnd ?? this.sleepEnd,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      quality: quality ?? this.quality,
      deepSleepMinutes: deepSleepMinutes ?? this.deepSleepMinutes,
      remSleepMinutes: remSleepMinutes ?? this.remSleepMinutes,
      lightSleepMinutes: lightSleepMinutes ?? this.lightSleepMinutes,
      awakeMinutes: awakeMinutes ?? this.awakeMinutes,
      notes: notes ?? this.notes,
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
    if (sleepStart.present) {
      map['sleep_start'] = Variable<DateTime>(sleepStart.value);
    }
    if (sleepEnd.present) {
      map['sleep_end'] = Variable<DateTime>(sleepEnd.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (quality.present) {
      map['quality'] = Variable<int>(quality.value);
    }
    if (deepSleepMinutes.present) {
      map['deep_sleep_minutes'] = Variable<int>(deepSleepMinutes.value);
    }
    if (remSleepMinutes.present) {
      map['rem_sleep_minutes'] = Variable<int>(remSleepMinutes.value);
    }
    if (lightSleepMinutes.present) {
      map['light_sleep_minutes'] = Variable<int>(lightSleepMinutes.value);
    }
    if (awakeMinutes.present) {
      map['awake_minutes'] = Variable<int>(awakeMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('sleepStart: $sleepStart, ')
          ..write('sleepEnd: $sleepEnd, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('quality: $quality, ')
          ..write('deepSleepMinutes: $deepSleepMinutes, ')
          ..write('remSleepMinutes: $remSleepMinutes, ')
          ..write('lightSleepMinutes: $lightSleepMinutes, ')
          ..write('awakeMinutes: $awakeMinutes, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetCountMeta = const VerificationMeta(
    'targetCount',
  );
  @override
  late final GeneratedColumn<int> targetCount = GeneratedColumn<int>(
    'target_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _reminderTimeMeta = const VerificationMeta(
    'reminderTime',
  );
  @override
  late final GeneratedColumn<String> reminderTime = GeneratedColumn<String>(
    'reminder_time',
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
    name,
    description,
    icon,
    color,
    frequency,
    targetCount,
    reminderTime,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
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
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('target_count')) {
      context.handle(
        _targetCountMeta,
        targetCount.isAcceptableOrUnknown(
          data['target_count']!,
          _targetCountMeta,
        ),
      );
    }
    if (data.containsKey('reminder_time')) {
      context.handle(
        _reminderTimeMeta,
        reminderTime.isAcceptableOrUnknown(
          data['reminder_time']!,
          _reminderTimeMeta,
        ),
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
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      targetCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_count'],
      )!,
      reminderTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_time'],
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
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final String userId;
  final String name;
  final String? description;
  final String? icon;
  final String? color;
  final String frequency;
  final int targetCount;
  final String? reminderTime;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Habit({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.icon,
    this.color,
    required this.frequency,
    required this.targetCount,
    this.reminderTime,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['frequency'] = Variable<String>(frequency);
    map['target_count'] = Variable<int>(targetCount);
    if (!nullToAbsent || reminderTime != null) {
      map['reminder_time'] = Variable<String>(reminderTime);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      frequency: Value(frequency),
      targetCount: Value(targetCount),
      reminderTime: reminderTime == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTime),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      icon: serializer.fromJson<String?>(json['icon']),
      color: serializer.fromJson<String?>(json['color']),
      frequency: serializer.fromJson<String>(json['frequency']),
      targetCount: serializer.fromJson<int>(json['targetCount']),
      reminderTime: serializer.fromJson<String?>(json['reminderTime']),
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'icon': serializer.toJson<String?>(icon),
      'color': serializer.toJson<String?>(color),
      'frequency': serializer.toJson<String>(frequency),
      'targetCount': serializer.toJson<int>(targetCount),
      'reminderTime': serializer.toJson<String?>(reminderTime),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Habit copyWith({
    int? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    Value<String?> color = const Value.absent(),
    String? frequency,
    int? targetCount,
    Value<String?> reminderTime = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Habit(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    icon: icon.present ? icon.value : this.icon,
    color: color.present ? color.value : this.color,
    frequency: frequency ?? this.frequency,
    targetCount: targetCount ?? this.targetCount,
    reminderTime: reminderTime.present ? reminderTime.value : this.reminderTime,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      targetCount: data.targetCount.present
          ? data.targetCount.value
          : this.targetCount,
      reminderTime: data.reminderTime.present
          ? data.reminderTime.value
          : this.reminderTime,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('frequency: $frequency, ')
          ..write('targetCount: $targetCount, ')
          ..write('reminderTime: $reminderTime, ')
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
    name,
    description,
    icon,
    color,
    frequency,
    targetCount,
    reminderTime,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.frequency == this.frequency &&
          other.targetCount == this.targetCount &&
          other.reminderTime == this.reminderTime &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> icon;
  final Value<String?> color;
  final Value<String> frequency;
  final Value<int> targetCount;
  final Value<String?> reminderTime;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.frequency = const Value.absent(),
    this.targetCount = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.description = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    required String frequency,
    this.targetCount = const Value.absent(),
    this.reminderTime = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       frequency = Value(frequency),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? icon,
    Expression<String>? color,
    Expression<String>? frequency,
    Expression<int>? targetCount,
    Expression<String>? reminderTime,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (frequency != null) 'frequency': frequency,
      if (targetCount != null) 'target_count': targetCount,
      if (reminderTime != null) 'reminder_time': reminderTime,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? icon,
    Value<String?>? color,
    Value<String>? frequency,
    Value<int>? targetCount,
    Value<String?>? reminderTime,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      frequency: frequency ?? this.frequency,
      targetCount: targetCount ?? this.targetCount,
      reminderTime: reminderTime ?? this.reminderTime,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (targetCount.present) {
      map['target_count'] = Variable<int>(targetCount.value);
    }
    if (reminderTime.present) {
      map['reminder_time'] = Variable<String>(reminderTime.value);
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
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('frequency: $frequency, ')
          ..write('targetCount: $targetCount, ')
          ..write('reminderTime: $reminderTime, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $HabitCompletionsTable extends HabitCompletions
    with TableInfo<$HabitCompletionsTable, HabitCompletion> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitCompletionsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
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
    habitId,
    userId,
    completedAt,
    count,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_completions';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitCompletion> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_completedAtMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  HabitCompletion map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitCompletion(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}habit_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      )!,
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitCompletionsTable createAlias(String alias) {
    return $HabitCompletionsTable(attachedDatabase, alias);
  }
}

class HabitCompletion extends DataClass implements Insertable<HabitCompletion> {
  final int id;
  final int habitId;
  final String userId;
  final DateTime completedAt;
  final int count;
  final String? notes;
  final DateTime createdAt;
  const HabitCompletion({
    required this.id,
    required this.habitId,
    required this.userId,
    required this.completedAt,
    required this.count,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['user_id'] = Variable<String>(userId);
    map['completed_at'] = Variable<DateTime>(completedAt);
    map['count'] = Variable<int>(count);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitCompletionsCompanion toCompanion(bool nullToAbsent) {
    return HabitCompletionsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      userId: Value(userId),
      completedAt: Value(completedAt),
      count: Value(count),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory HabitCompletion.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitCompletion(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      userId: serializer.fromJson<String>(json['userId']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      count: serializer.fromJson<int>(json['count']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'userId': serializer.toJson<String>(userId),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'count': serializer.toJson<int>(count),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitCompletion copyWith({
    int? id,
    int? habitId,
    String? userId,
    DateTime? completedAt,
    int? count,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => HabitCompletion(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    userId: userId ?? this.userId,
    completedAt: completedAt ?? this.completedAt,
    count: count ?? this.count,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitCompletion copyWithCompanion(HabitCompletionsCompanion data) {
    return HabitCompletion(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      userId: data.userId.present ? data.userId.value : this.userId,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      count: data.count.present ? data.count.value : this.count,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('userId: $userId, ')
          ..write('completedAt: $completedAt, ')
          ..write('count: $count, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, habitId, userId, completedAt, count, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitCompletion &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.userId == this.userId &&
          other.completedAt == this.completedAt &&
          other.count == this.count &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class HabitCompletionsCompanion extends UpdateCompanion<HabitCompletion> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<String> userId;
  final Value<DateTime> completedAt;
  final Value<int> count;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  const HabitCompletionsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.userId = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.count = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HabitCompletionsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required String userId,
    required DateTime completedAt,
    this.count = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
  }) : habitId = Value(habitId),
       userId = Value(userId),
       completedAt = Value(completedAt),
       createdAt = Value(createdAt);
  static Insertable<HabitCompletion> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<String>? userId,
    Expression<DateTime>? completedAt,
    Expression<int>? count,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (userId != null) 'user_id': userId,
      if (completedAt != null) 'completed_at': completedAt,
      if (count != null) 'count': count,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HabitCompletionsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<String>? userId,
    Value<DateTime>? completedAt,
    Value<int>? count,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
  }) {
    return HabitCompletionsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,
      completedAt: completedAt ?? this.completedAt,
      count: count ?? this.count,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitCompletionsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('userId: $userId, ')
          ..write('completedAt: $completedAt, ')
          ..write('count: $count, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $BodyMeasurementsTable extends BodyMeasurements
    with TableInfo<$BodyMeasurementsTable, BodyMeasurement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BodyMeasurementsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bmiMeta = const VerificationMeta('bmi');
  @override
  late final GeneratedColumn<double> bmi = GeneratedColumn<double>(
    'bmi',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyFatPercentMeta = const VerificationMeta(
    'bodyFatPercent',
  );
  @override
  late final GeneratedColumn<double> bodyFatPercent = GeneratedColumn<double>(
    'body_fat_percent',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _muscleMassKgMeta = const VerificationMeta(
    'muscleMassKg',
  );
  @override
  late final GeneratedColumn<double> muscleMassKg = GeneratedColumn<double>(
    'muscle_mass_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waistCmMeta = const VerificationMeta(
    'waistCm',
  );
  @override
  late final GeneratedColumn<double> waistCm = GeneratedColumn<double>(
    'waist_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _chestCmMeta = const VerificationMeta(
    'chestCm',
  );
  @override
  late final GeneratedColumn<double> chestCm = GeneratedColumn<double>(
    'chest_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hipCmMeta = const VerificationMeta('hipCm');
  @override
  late final GeneratedColumn<double> hipCm = GeneratedColumn<double>(
    'hip_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bicepCmMeta = const VerificationMeta(
    'bicepCm',
  );
  @override
  late final GeneratedColumn<double> bicepCm = GeneratedColumn<double>(
    'bicep_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
  static const VerificationMeta _measuredAtMeta = const VerificationMeta(
    'measuredAt',
  );
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
    'measured_at',
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
    weightKg,
    heightCm,
    bmi,
    bodyFatPercent,
    muscleMassKg,
    waistCm,
    chestCm,
    hipCm,
    bicepCm,
    notes,
    measuredAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'body_measurements';
  @override
  VerificationContext validateIntegrity(
    Insertable<BodyMeasurement> instance, {
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
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('bmi')) {
      context.handle(
        _bmiMeta,
        bmi.isAcceptableOrUnknown(data['bmi']!, _bmiMeta),
      );
    }
    if (data.containsKey('body_fat_percent')) {
      context.handle(
        _bodyFatPercentMeta,
        bodyFatPercent.isAcceptableOrUnknown(
          data['body_fat_percent']!,
          _bodyFatPercentMeta,
        ),
      );
    }
    if (data.containsKey('muscle_mass_kg')) {
      context.handle(
        _muscleMassKgMeta,
        muscleMassKg.isAcceptableOrUnknown(
          data['muscle_mass_kg']!,
          _muscleMassKgMeta,
        ),
      );
    }
    if (data.containsKey('waist_cm')) {
      context.handle(
        _waistCmMeta,
        waistCm.isAcceptableOrUnknown(data['waist_cm']!, _waistCmMeta),
      );
    }
    if (data.containsKey('chest_cm')) {
      context.handle(
        _chestCmMeta,
        chestCm.isAcceptableOrUnknown(data['chest_cm']!, _chestCmMeta),
      );
    }
    if (data.containsKey('hip_cm')) {
      context.handle(
        _hipCmMeta,
        hipCm.isAcceptableOrUnknown(data['hip_cm']!, _hipCmMeta),
      );
    }
    if (data.containsKey('bicep_cm')) {
      context.handle(
        _bicepCmMeta,
        bicepCm.isAcceptableOrUnknown(data['bicep_cm']!, _bicepCmMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('measured_at')) {
      context.handle(
        _measuredAtMeta,
        measuredAt.isAcceptableOrUnknown(data['measured_at']!, _measuredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
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
  BodyMeasurement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BodyMeasurement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      bmi: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bmi'],
      ),
      bodyFatPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}body_fat_percent'],
      ),
      muscleMassKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}muscle_mass_kg'],
      ),
      waistCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}waist_cm'],
      ),
      chestCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}chest_cm'],
      ),
      hipCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}hip_cm'],
      ),
      bicepCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bicep_cm'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      measuredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}measured_at'],
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
  $BodyMeasurementsTable createAlias(String alias) {
    return $BodyMeasurementsTable(attachedDatabase, alias);
  }
}

class BodyMeasurement extends DataClass implements Insertable<BodyMeasurement> {
  final int id;
  final String userId;
  final double? weightKg;
  final double? heightCm;
  final double? bmi;
  final double? bodyFatPercent;
  final double? muscleMassKg;
  final double? waistCm;
  final double? chestCm;
  final double? hipCm;
  final double? bicepCm;
  final String? notes;
  final DateTime measuredAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BodyMeasurement({
    required this.id,
    required this.userId,
    this.weightKg,
    this.heightCm,
    this.bmi,
    this.bodyFatPercent,
    this.muscleMassKg,
    this.waistCm,
    this.chestCm,
    this.hipCm,
    this.bicepCm,
    this.notes,
    required this.measuredAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || bmi != null) {
      map['bmi'] = Variable<double>(bmi);
    }
    if (!nullToAbsent || bodyFatPercent != null) {
      map['body_fat_percent'] = Variable<double>(bodyFatPercent);
    }
    if (!nullToAbsent || muscleMassKg != null) {
      map['muscle_mass_kg'] = Variable<double>(muscleMassKg);
    }
    if (!nullToAbsent || waistCm != null) {
      map['waist_cm'] = Variable<double>(waistCm);
    }
    if (!nullToAbsent || chestCm != null) {
      map['chest_cm'] = Variable<double>(chestCm);
    }
    if (!nullToAbsent || hipCm != null) {
      map['hip_cm'] = Variable<double>(hipCm);
    }
    if (!nullToAbsent || bicepCm != null) {
      map['bicep_cm'] = Variable<double>(bicepCm);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BodyMeasurementsCompanion toCompanion(bool nullToAbsent) {
    return BodyMeasurementsCompanion(
      id: Value(id),
      userId: Value(userId),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      bmi: bmi == null && nullToAbsent ? const Value.absent() : Value(bmi),
      bodyFatPercent: bodyFatPercent == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPercent),
      muscleMassKg: muscleMassKg == null && nullToAbsent
          ? const Value.absent()
          : Value(muscleMassKg),
      waistCm: waistCm == null && nullToAbsent
          ? const Value.absent()
          : Value(waistCm),
      chestCm: chestCm == null && nullToAbsent
          ? const Value.absent()
          : Value(chestCm),
      hipCm: hipCm == null && nullToAbsent
          ? const Value.absent()
          : Value(hipCm),
      bicepCm: bicepCm == null && nullToAbsent
          ? const Value.absent()
          : Value(bicepCm),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      measuredAt: Value(measuredAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BodyMeasurement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BodyMeasurement(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      bmi: serializer.fromJson<double?>(json['bmi']),
      bodyFatPercent: serializer.fromJson<double?>(json['bodyFatPercent']),
      muscleMassKg: serializer.fromJson<double?>(json['muscleMassKg']),
      waistCm: serializer.fromJson<double?>(json['waistCm']),
      chestCm: serializer.fromJson<double?>(json['chestCm']),
      hipCm: serializer.fromJson<double?>(json['hipCm']),
      bicepCm: serializer.fromJson<double?>(json['bicepCm']),
      notes: serializer.fromJson<String?>(json['notes']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
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
      'weightKg': serializer.toJson<double?>(weightKg),
      'heightCm': serializer.toJson<double?>(heightCm),
      'bmi': serializer.toJson<double?>(bmi),
      'bodyFatPercent': serializer.toJson<double?>(bodyFatPercent),
      'muscleMassKg': serializer.toJson<double?>(muscleMassKg),
      'waistCm': serializer.toJson<double?>(waistCm),
      'chestCm': serializer.toJson<double?>(chestCm),
      'hipCm': serializer.toJson<double?>(hipCm),
      'bicepCm': serializer.toJson<double?>(bicepCm),
      'notes': serializer.toJson<String?>(notes),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BodyMeasurement copyWith({
    int? id,
    String? userId,
    Value<double?> weightKg = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> bmi = const Value.absent(),
    Value<double?> bodyFatPercent = const Value.absent(),
    Value<double?> muscleMassKg = const Value.absent(),
    Value<double?> waistCm = const Value.absent(),
    Value<double?> chestCm = const Value.absent(),
    Value<double?> hipCm = const Value.absent(),
    Value<double?> bicepCm = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? measuredAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BodyMeasurement(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    bmi: bmi.present ? bmi.value : this.bmi,
    bodyFatPercent: bodyFatPercent.present
        ? bodyFatPercent.value
        : this.bodyFatPercent,
    muscleMassKg: muscleMassKg.present ? muscleMassKg.value : this.muscleMassKg,
    waistCm: waistCm.present ? waistCm.value : this.waistCm,
    chestCm: chestCm.present ? chestCm.value : this.chestCm,
    hipCm: hipCm.present ? hipCm.value : this.hipCm,
    bicepCm: bicepCm.present ? bicepCm.value : this.bicepCm,
    notes: notes.present ? notes.value : this.notes,
    measuredAt: measuredAt ?? this.measuredAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BodyMeasurement copyWithCompanion(BodyMeasurementsCompanion data) {
    return BodyMeasurement(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      bmi: data.bmi.present ? data.bmi.value : this.bmi,
      bodyFatPercent: data.bodyFatPercent.present
          ? data.bodyFatPercent.value
          : this.bodyFatPercent,
      muscleMassKg: data.muscleMassKg.present
          ? data.muscleMassKg.value
          : this.muscleMassKg,
      waistCm: data.waistCm.present ? data.waistCm.value : this.waistCm,
      chestCm: data.chestCm.present ? data.chestCm.value : this.chestCm,
      hipCm: data.hipCm.present ? data.hipCm.value : this.hipCm,
      bicepCm: data.bicepCm.present ? data.bicepCm.value : this.bicepCm,
      notes: data.notes.present ? data.notes.value : this.notes,
      measuredAt: data.measuredAt.present
          ? data.measuredAt.value
          : this.measuredAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BodyMeasurement(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('bmi: $bmi, ')
          ..write('bodyFatPercent: $bodyFatPercent, ')
          ..write('muscleMassKg: $muscleMassKg, ')
          ..write('waistCm: $waistCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('hipCm: $hipCm, ')
          ..write('bicepCm: $bicepCm, ')
          ..write('notes: $notes, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    weightKg,
    heightCm,
    bmi,
    bodyFatPercent,
    muscleMassKg,
    waistCm,
    chestCm,
    hipCm,
    bicepCm,
    notes,
    measuredAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BodyMeasurement &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weightKg == this.weightKg &&
          other.heightCm == this.heightCm &&
          other.bmi == this.bmi &&
          other.bodyFatPercent == this.bodyFatPercent &&
          other.muscleMassKg == this.muscleMassKg &&
          other.waistCm == this.waistCm &&
          other.chestCm == this.chestCm &&
          other.hipCm == this.hipCm &&
          other.bicepCm == this.bicepCm &&
          other.notes == this.notes &&
          other.measuredAt == this.measuredAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BodyMeasurementsCompanion extends UpdateCompanion<BodyMeasurement> {
  final Value<int> id;
  final Value<String> userId;
  final Value<double?> weightKg;
  final Value<double?> heightCm;
  final Value<double?> bmi;
  final Value<double?> bodyFatPercent;
  final Value<double?> muscleMassKg;
  final Value<double?> waistCm;
  final Value<double?> chestCm;
  final Value<double?> hipCm;
  final Value<double?> bicepCm;
  final Value<String?> notes;
  final Value<DateTime> measuredAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BodyMeasurementsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.bmi = const Value.absent(),
    this.bodyFatPercent = const Value.absent(),
    this.muscleMassKg = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.chestCm = const Value.absent(),
    this.hipCm = const Value.absent(),
    this.bicepCm = const Value.absent(),
    this.notes = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BodyMeasurementsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.bmi = const Value.absent(),
    this.bodyFatPercent = const Value.absent(),
    this.muscleMassKg = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.chestCm = const Value.absent(),
    this.hipCm = const Value.absent(),
    this.bicepCm = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime measuredAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       measuredAt = Value(measuredAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BodyMeasurement> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<double>? weightKg,
    Expression<double>? heightCm,
    Expression<double>? bmi,
    Expression<double>? bodyFatPercent,
    Expression<double>? muscleMassKg,
    Expression<double>? waistCm,
    Expression<double>? chestCm,
    Expression<double>? hipCm,
    Expression<double>? bicepCm,
    Expression<String>? notes,
    Expression<DateTime>? measuredAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weightKg != null) 'weight_kg': weightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (bmi != null) 'bmi': bmi,
      if (bodyFatPercent != null) 'body_fat_percent': bodyFatPercent,
      if (muscleMassKg != null) 'muscle_mass_kg': muscleMassKg,
      if (waistCm != null) 'waist_cm': waistCm,
      if (chestCm != null) 'chest_cm': chestCm,
      if (hipCm != null) 'hip_cm': hipCm,
      if (bicepCm != null) 'bicep_cm': bicepCm,
      if (notes != null) 'notes': notes,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BodyMeasurementsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<double?>? weightKg,
    Value<double?>? heightCm,
    Value<double?>? bmi,
    Value<double?>? bodyFatPercent,
    Value<double?>? muscleMassKg,
    Value<double?>? waistCm,
    Value<double?>? chestCm,
    Value<double?>? hipCm,
    Value<double?>? bicepCm,
    Value<String?>? notes,
    Value<DateTime>? measuredAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BodyMeasurementsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      bmi: bmi ?? this.bmi,
      bodyFatPercent: bodyFatPercent ?? this.bodyFatPercent,
      muscleMassKg: muscleMassKg ?? this.muscleMassKg,
      waistCm: waistCm ?? this.waistCm,
      chestCm: chestCm ?? this.chestCm,
      hipCm: hipCm ?? this.hipCm,
      bicepCm: bicepCm ?? this.bicepCm,
      notes: notes ?? this.notes,
      measuredAt: measuredAt ?? this.measuredAt,
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
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (bmi.present) {
      map['bmi'] = Variable<double>(bmi.value);
    }
    if (bodyFatPercent.present) {
      map['body_fat_percent'] = Variable<double>(bodyFatPercent.value);
    }
    if (muscleMassKg.present) {
      map['muscle_mass_kg'] = Variable<double>(muscleMassKg.value);
    }
    if (waistCm.present) {
      map['waist_cm'] = Variable<double>(waistCm.value);
    }
    if (chestCm.present) {
      map['chest_cm'] = Variable<double>(chestCm.value);
    }
    if (hipCm.present) {
      map['hip_cm'] = Variable<double>(hipCm.value);
    }
    if (bicepCm.present) {
      map['bicep_cm'] = Variable<double>(bicepCm.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
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
    return (StringBuffer('BodyMeasurementsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('bmi: $bmi, ')
          ..write('bodyFatPercent: $bodyFatPercent, ')
          ..write('muscleMassKg: $muscleMassKg, ')
          ..write('waistCm: $waistCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('hipCm: $hipCm, ')
          ..write('bicepCm: $bicepCm, ')
          ..write('notes: $notes, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MedicationsTable extends Medications
    with TableInfo<$MedicationsTable, Medication> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicationsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dosageMeta = const VerificationMeta('dosage');
  @override
  late final GeneratedColumn<String> dosage = GeneratedColumn<String>(
    'dosage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderTimesMeta = const VerificationMeta(
    'reminderTimes',
  );
  @override
  late final GeneratedColumn<String> reminderTimes = GeneratedColumn<String>(
    'reminder_times',
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
    name,
    dosage,
    frequency,
    unit,
    instructions,
    startDate,
    endDate,
    reminderTimes,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Medication> instance, {
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
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('dosage')) {
      context.handle(
        _dosageMeta,
        dosage.isAcceptableOrUnknown(data['dosage']!, _dosageMeta),
      );
    } else if (isInserting) {
      context.missing(_dosageMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('reminder_times')) {
      context.handle(
        _reminderTimesMeta,
        reminderTimes.isAcceptableOrUnknown(
          data['reminder_times']!,
          _reminderTimesMeta,
        ),
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
  Medication map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Medication(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      dosage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dosage'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      reminderTimes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reminder_times'],
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
  $MedicationsTable createAlias(String alias) {
    return $MedicationsTable(attachedDatabase, alias);
  }
}

class Medication extends DataClass implements Insertable<Medication> {
  final int id;
  final String userId;
  final String name;
  final String dosage;
  final String frequency;
  final String? unit;
  final String? instructions;
  final DateTime startDate;
  final DateTime? endDate;
  final String? reminderTimes;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Medication({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.unit,
    this.instructions,
    required this.startDate,
    this.endDate,
    this.reminderTimes,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['dosage'] = Variable<String>(dosage);
    map['frequency'] = Variable<String>(frequency);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || reminderTimes != null) {
      map['reminder_times'] = Variable<String>(reminderTimes);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MedicationsCompanion toCompanion(bool nullToAbsent) {
    return MedicationsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      dosage: Value(dosage),
      frequency: Value(frequency),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      reminderTimes: reminderTimes == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderTimes),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Medication.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Medication(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      dosage: serializer.fromJson<String>(json['dosage']),
      frequency: serializer.fromJson<String>(json['frequency']),
      unit: serializer.fromJson<String?>(json['unit']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      reminderTimes: serializer.fromJson<String?>(json['reminderTimes']),
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
      'name': serializer.toJson<String>(name),
      'dosage': serializer.toJson<String>(dosage),
      'frequency': serializer.toJson<String>(frequency),
      'unit': serializer.toJson<String?>(unit),
      'instructions': serializer.toJson<String?>(instructions),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'reminderTimes': serializer.toJson<String?>(reminderTimes),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Medication copyWith({
    int? id,
    String? userId,
    String? name,
    String? dosage,
    String? frequency,
    Value<String?> unit = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> reminderTimes = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Medication(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    dosage: dosage ?? this.dosage,
    frequency: frequency ?? this.frequency,
    unit: unit.present ? unit.value : this.unit,
    instructions: instructions.present ? instructions.value : this.instructions,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    reminderTimes: reminderTimes.present
        ? reminderTimes.value
        : this.reminderTimes,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Medication copyWithCompanion(MedicationsCompanion data) {
    return Medication(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      dosage: data.dosage.present ? data.dosage.value : this.dosage,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      unit: data.unit.present ? data.unit.value : this.unit,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      reminderTimes: data.reminderTimes.present
          ? data.reminderTimes.value
          : this.reminderTimes,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Medication(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('unit: $unit, ')
          ..write('instructions: $instructions, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reminderTimes: $reminderTimes, ')
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
    name,
    dosage,
    frequency,
    unit,
    instructions,
    startDate,
    endDate,
    reminderTimes,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Medication &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.dosage == this.dosage &&
          other.frequency == this.frequency &&
          other.unit == this.unit &&
          other.instructions == this.instructions &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.reminderTimes == this.reminderTimes &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MedicationsCompanion extends UpdateCompanion<Medication> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> dosage;
  final Value<String> frequency;
  final Value<String?> unit;
  final Value<String?> instructions;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> reminderTimes;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MedicationsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.dosage = const Value.absent(),
    this.frequency = const Value.absent(),
    this.unit = const Value.absent(),
    this.instructions = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.reminderTimes = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MedicationsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    required String dosage,
    required String frequency,
    this.unit = const Value.absent(),
    this.instructions = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.reminderTimes = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       dosage = Value(dosage),
       frequency = Value(frequency),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Medication> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? dosage,
    Expression<String>? frequency,
    Expression<String>? unit,
    Expression<String>? instructions,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? reminderTimes,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (dosage != null) 'dosage': dosage,
      if (frequency != null) 'frequency': frequency,
      if (unit != null) 'unit': unit,
      if (instructions != null) 'instructions': instructions,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (reminderTimes != null) 'reminder_times': reminderTimes,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MedicationsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String>? dosage,
    Value<String>? frequency,
    Value<String?>? unit,
    Value<String?>? instructions,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<String?>? reminderTimes,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MedicationsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      unit: unit ?? this.unit,
      instructions: instructions ?? this.instructions,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderTimes: reminderTimes ?? this.reminderTimes,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (dosage.present) {
      map['dosage'] = Variable<String>(dosage.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (reminderTimes.present) {
      map['reminder_times'] = Variable<String>(reminderTimes.value);
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
    return (StringBuffer('MedicationsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('dosage: $dosage, ')
          ..write('frequency: $frequency, ')
          ..write('unit: $unit, ')
          ..write('instructions: $instructions, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('reminderTimes: $reminderTimes, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $FastingLogsTable extends FastingLogs
    with TableInfo<$FastingLogsTable, FastingLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FastingLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fastingTypeMeta = const VerificationMeta(
    'fastingType',
  );
  @override
  late final GeneratedColumn<String> fastingType = GeneratedColumn<String>(
    'fasting_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startTimeMeta = const VerificationMeta(
    'startTime',
  );
  @override
  late final GeneratedColumn<DateTime> startTime = GeneratedColumn<DateTime>(
    'start_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endTimeMeta = const VerificationMeta(
    'endTime',
  );
  @override
  late final GeneratedColumn<DateTime> endTime = GeneratedColumn<DateTime>(
    'end_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriesConsumedMeta = const VerificationMeta(
    'caloriesConsumed',
  );
  @override
  late final GeneratedColumn<int> caloriesConsumed = GeneratedColumn<int>(
    'calories_consumed',
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
    fastingType,
    startTime,
    endTime,
    durationMinutes,
    status,
    caloriesConsumed,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fasting_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<FastingLog> instance, {
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
    if (data.containsKey('fasting_type')) {
      context.handle(
        _fastingTypeMeta,
        fastingType.isAcceptableOrUnknown(
          data['fasting_type']!,
          _fastingTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fastingTypeMeta);
    }
    if (data.containsKey('start_time')) {
      context.handle(
        _startTimeMeta,
        startTime.isAcceptableOrUnknown(data['start_time']!, _startTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_startTimeMeta);
    }
    if (data.containsKey('end_time')) {
      context.handle(
        _endTimeMeta,
        endTime.isAcceptableOrUnknown(data['end_time']!, _endTimeMeta),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('calories_consumed')) {
      context.handle(
        _caloriesConsumedMeta,
        caloriesConsumed.isAcceptableOrUnknown(
          data['calories_consumed']!,
          _caloriesConsumedMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  FastingLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FastingLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      fastingType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fasting_type'],
      )!,
      startTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_time'],
      )!,
      endTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_time'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      caloriesConsumed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_consumed'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $FastingLogsTable createAlias(String alias) {
    return $FastingLogsTable(attachedDatabase, alias);
  }
}

class FastingLog extends DataClass implements Insertable<FastingLog> {
  final int id;
  final String userId;
  final String fastingType;
  final DateTime startTime;
  final DateTime? endTime;
  final int? durationMinutes;
  final String status;
  final int? caloriesConsumed;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FastingLog({
    required this.id,
    required this.userId,
    required this.fastingType,
    required this.startTime,
    this.endTime,
    this.durationMinutes,
    required this.status,
    this.caloriesConsumed,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['fasting_type'] = Variable<String>(fastingType);
    map['start_time'] = Variable<DateTime>(startTime);
    if (!nullToAbsent || endTime != null) {
      map['end_time'] = Variable<DateTime>(endTime);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || caloriesConsumed != null) {
      map['calories_consumed'] = Variable<int>(caloriesConsumed);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FastingLogsCompanion toCompanion(bool nullToAbsent) {
    return FastingLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      fastingType: Value(fastingType),
      startTime: Value(startTime),
      endTime: endTime == null && nullToAbsent
          ? const Value.absent()
          : Value(endTime),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      status: Value(status),
      caloriesConsumed: caloriesConsumed == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesConsumed),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FastingLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FastingLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fastingType: serializer.fromJson<String>(json['fastingType']),
      startTime: serializer.fromJson<DateTime>(json['startTime']),
      endTime: serializer.fromJson<DateTime?>(json['endTime']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      status: serializer.fromJson<String>(json['status']),
      caloriesConsumed: serializer.fromJson<int?>(json['caloriesConsumed']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'fastingType': serializer.toJson<String>(fastingType),
      'startTime': serializer.toJson<DateTime>(startTime),
      'endTime': serializer.toJson<DateTime?>(endTime),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'status': serializer.toJson<String>(status),
      'caloriesConsumed': serializer.toJson<int?>(caloriesConsumed),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FastingLog copyWith({
    int? id,
    String? userId,
    String? fastingType,
    DateTime? startTime,
    Value<DateTime?> endTime = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    String? status,
    Value<int?> caloriesConsumed = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FastingLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fastingType: fastingType ?? this.fastingType,
    startTime: startTime ?? this.startTime,
    endTime: endTime.present ? endTime.value : this.endTime,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    status: status ?? this.status,
    caloriesConsumed: caloriesConsumed.present
        ? caloriesConsumed.value
        : this.caloriesConsumed,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FastingLog copyWithCompanion(FastingLogsCompanion data) {
    return FastingLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fastingType: data.fastingType.present
          ? data.fastingType.value
          : this.fastingType,
      startTime: data.startTime.present ? data.startTime.value : this.startTime,
      endTime: data.endTime.present ? data.endTime.value : this.endTime,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      status: data.status.present ? data.status.value : this.status,
      caloriesConsumed: data.caloriesConsumed.present
          ? data.caloriesConsumed.value
          : this.caloriesConsumed,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FastingLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fastingType: $fastingType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status, ')
          ..write('caloriesConsumed: $caloriesConsumed, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    fastingType,
    startTime,
    endTime,
    durationMinutes,
    status,
    caloriesConsumed,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FastingLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fastingType == this.fastingType &&
          other.startTime == this.startTime &&
          other.endTime == this.endTime &&
          other.durationMinutes == this.durationMinutes &&
          other.status == this.status &&
          other.caloriesConsumed == this.caloriesConsumed &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FastingLogsCompanion extends UpdateCompanion<FastingLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> fastingType;
  final Value<DateTime> startTime;
  final Value<DateTime?> endTime;
  final Value<int?> durationMinutes;
  final Value<String> status;
  final Value<int?> caloriesConsumed;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const FastingLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fastingType = const Value.absent(),
    this.startTime = const Value.absent(),
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.caloriesConsumed = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  FastingLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String fastingType,
    required DateTime startTime,
    this.endTime = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    required String status,
    this.caloriesConsumed = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       fastingType = Value(fastingType),
       startTime = Value(startTime),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<FastingLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? fastingType,
    Expression<DateTime>? startTime,
    Expression<DateTime>? endTime,
    Expression<int>? durationMinutes,
    Expression<String>? status,
    Expression<int>? caloriesConsumed,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fastingType != null) 'fasting_type': fastingType,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (status != null) 'status': status,
      if (caloriesConsumed != null) 'calories_consumed': caloriesConsumed,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  FastingLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? fastingType,
    Value<DateTime>? startTime,
    Value<DateTime?>? endTime,
    Value<int?>? durationMinutes,
    Value<String>? status,
    Value<int?>? caloriesConsumed,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return FastingLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fastingType: fastingType ?? this.fastingType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      status: status ?? this.status,
      caloriesConsumed: caloriesConsumed ?? this.caloriesConsumed,
      notes: notes ?? this.notes,
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
    if (fastingType.present) {
      map['fasting_type'] = Variable<String>(fastingType.value);
    }
    if (startTime.present) {
      map['start_time'] = Variable<DateTime>(startTime.value);
    }
    if (endTime.present) {
      map['end_time'] = Variable<DateTime>(endTime.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (caloriesConsumed.present) {
      map['calories_consumed'] = Variable<int>(caloriesConsumed.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('FastingLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fastingType: $fastingType, ')
          ..write('startTime: $startTime, ')
          ..write('endTime: $endTime, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status, ')
          ..write('caloriesConsumed: $caloriesConsumed, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MealPlansTable extends MealPlans
    with TableInfo<$MealPlansTable, MealPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealPlansTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCaloriesMeta = const VerificationMeta(
    'targetCalories',
  );
  @override
  late final GeneratedColumn<int> targetCalories = GeneratedColumn<int>(
    'target_calories',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetProteinMeta = const VerificationMeta(
    'targetProtein',
  );
  @override
  late final GeneratedColumn<double> targetProtein = GeneratedColumn<double>(
    'target_protein',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCarbsMeta = const VerificationMeta(
    'targetCarbs',
  );
  @override
  late final GeneratedColumn<double> targetCarbs = GeneratedColumn<double>(
    'target_carbs',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetFatMeta = const VerificationMeta(
    'targetFat',
  );
  @override
  late final GeneratedColumn<double> targetFat = GeneratedColumn<double>(
    'target_fat',
    aliasedName,
    true,
    type: DriftSqlType.double,
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
    name,
    description,
    startDate,
    endDate,
    targetCalories,
    targetProtein,
    targetCarbs,
    targetFat,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_plans';
  @override
  VerificationContext validateIntegrity(
    Insertable<MealPlan> instance, {
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
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('target_calories')) {
      context.handle(
        _targetCaloriesMeta,
        targetCalories.isAcceptableOrUnknown(
          data['target_calories']!,
          _targetCaloriesMeta,
        ),
      );
    }
    if (data.containsKey('target_protein')) {
      context.handle(
        _targetProteinMeta,
        targetProtein.isAcceptableOrUnknown(
          data['target_protein']!,
          _targetProteinMeta,
        ),
      );
    }
    if (data.containsKey('target_carbs')) {
      context.handle(
        _targetCarbsMeta,
        targetCarbs.isAcceptableOrUnknown(
          data['target_carbs']!,
          _targetCarbsMeta,
        ),
      );
    }
    if (data.containsKey('target_fat')) {
      context.handle(
        _targetFatMeta,
        targetFat.isAcceptableOrUnknown(data['target_fat']!, _targetFatMeta),
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
  MealPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealPlan(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      targetCalories: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_calories'],
      ),
      targetProtein: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_protein'],
      ),
      targetCarbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_carbs'],
      ),
      targetFat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_fat'],
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
  $MealPlansTable createAlias(String alias) {
    return $MealPlansTable(attachedDatabase, alias);
  }
}

class MealPlan extends DataClass implements Insertable<MealPlan> {
  final int id;
  final String userId;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime? endDate;
  final int? targetCalories;
  final double? targetProtein;
  final double? targetCarbs;
  final double? targetFat;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MealPlan({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.startDate,
    this.endDate,
    this.targetCalories,
    this.targetProtein,
    this.targetCarbs,
    this.targetFat,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || targetCalories != null) {
      map['target_calories'] = Variable<int>(targetCalories);
    }
    if (!nullToAbsent || targetProtein != null) {
      map['target_protein'] = Variable<double>(targetProtein);
    }
    if (!nullToAbsent || targetCarbs != null) {
      map['target_carbs'] = Variable<double>(targetCarbs);
    }
    if (!nullToAbsent || targetFat != null) {
      map['target_fat'] = Variable<double>(targetFat);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MealPlansCompanion toCompanion(bool nullToAbsent) {
    return MealPlansCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      targetCalories: targetCalories == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCalories),
      targetProtein: targetProtein == null && nullToAbsent
          ? const Value.absent()
          : Value(targetProtein),
      targetCarbs: targetCarbs == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCarbs),
      targetFat: targetFat == null && nullToAbsent
          ? const Value.absent()
          : Value(targetFat),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MealPlan.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealPlan(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      targetCalories: serializer.fromJson<int?>(json['targetCalories']),
      targetProtein: serializer.fromJson<double?>(json['targetProtein']),
      targetCarbs: serializer.fromJson<double?>(json['targetCarbs']),
      targetFat: serializer.fromJson<double?>(json['targetFat']),
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'targetCalories': serializer.toJson<int?>(targetCalories),
      'targetProtein': serializer.toJson<double?>(targetProtein),
      'targetCarbs': serializer.toJson<double?>(targetCarbs),
      'targetFat': serializer.toJson<double?>(targetFat),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MealPlan copyWith({
    int? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<int?> targetCalories = const Value.absent(),
    Value<double?> targetProtein = const Value.absent(),
    Value<double?> targetCarbs = const Value.absent(),
    Value<double?> targetFat = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MealPlan(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    targetCalories: targetCalories.present
        ? targetCalories.value
        : this.targetCalories,
    targetProtein: targetProtein.present
        ? targetProtein.value
        : this.targetProtein,
    targetCarbs: targetCarbs.present ? targetCarbs.value : this.targetCarbs,
    targetFat: targetFat.present ? targetFat.value : this.targetFat,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MealPlan copyWithCompanion(MealPlansCompanion data) {
    return MealPlan(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      targetCalories: data.targetCalories.present
          ? data.targetCalories.value
          : this.targetCalories,
      targetProtein: data.targetProtein.present
          ? data.targetProtein.value
          : this.targetProtein,
      targetCarbs: data.targetCarbs.present
          ? data.targetCarbs.value
          : this.targetCarbs,
      targetFat: data.targetFat.present ? data.targetFat.value : this.targetFat,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealPlan(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProtein: $targetProtein, ')
          ..write('targetCarbs: $targetCarbs, ')
          ..write('targetFat: $targetFat, ')
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
    name,
    description,
    startDate,
    endDate,
    targetCalories,
    targetProtein,
    targetCarbs,
    targetFat,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealPlan &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.targetCalories == this.targetCalories &&
          other.targetProtein == this.targetProtein &&
          other.targetCarbs == this.targetCarbs &&
          other.targetFat == this.targetFat &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MealPlansCompanion extends UpdateCompanion<MealPlan> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> targetCalories;
  final Value<double?> targetProtein;
  final Value<double?> targetCarbs;
  final Value<double?> targetFat;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MealPlansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.targetProtein = const Value.absent(),
    this.targetCarbs = const Value.absent(),
    this.targetFat = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MealPlansCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.description = const Value.absent(),
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.targetCalories = const Value.absent(),
    this.targetProtein = const Value.absent(),
    this.targetCarbs = const Value.absent(),
    this.targetFat = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MealPlan> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? targetCalories,
    Expression<double>? targetProtein,
    Expression<double>? targetCarbs,
    Expression<double>? targetFat,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (targetCalories != null) 'target_calories': targetCalories,
      if (targetProtein != null) 'target_protein': targetProtein,
      if (targetCarbs != null) 'target_carbs': targetCarbs,
      if (targetFat != null) 'target_fat': targetFat,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MealPlansCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int?>? targetCalories,
    Value<double?>? targetProtein,
    Value<double?>? targetCarbs,
    Value<double?>? targetFat,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MealPlansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      targetCalories: targetCalories ?? this.targetCalories,
      targetProtein: targetProtein ?? this.targetProtein,
      targetCarbs: targetCarbs ?? this.targetCarbs,
      targetFat: targetFat ?? this.targetFat,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (targetCalories.present) {
      map['target_calories'] = Variable<int>(targetCalories.value);
    }
    if (targetProtein.present) {
      map['target_protein'] = Variable<double>(targetProtein.value);
    }
    if (targetCarbs.present) {
      map['target_carbs'] = Variable<double>(targetCarbs.value);
    }
    if (targetFat.present) {
      map['target_fat'] = Variable<double>(targetFat.value);
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
    return (StringBuffer('MealPlansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('targetCalories: $targetCalories, ')
          ..write('targetProtein: $targetProtein, ')
          ..write('targetCarbs: $targetCarbs, ')
          ..write('targetFat: $targetFat, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prepTimeMinutesMeta = const VerificationMeta(
    'prepTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> prepTimeMinutes = GeneratedColumn<int>(
    'prep_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _servingsMeta = const VerificationMeta(
    'servings',
  );
  @override
  late final GeneratedColumn<int> servings = GeneratedColumn<int>(
    'servings',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _caloriesPerServingMeta =
      const VerificationMeta('caloriesPerServing');
  @override
  late final GeneratedColumn<int> caloriesPerServing = GeneratedColumn<int>(
    'calories_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _proteinPerServingMeta = const VerificationMeta(
    'proteinPerServing',
  );
  @override
  late final GeneratedColumn<double> proteinPerServing =
      GeneratedColumn<double>(
        'protein_per_serving',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _carbsPerServingMeta = const VerificationMeta(
    'carbsPerServing',
  );
  @override
  late final GeneratedColumn<double> carbsPerServing = GeneratedColumn<double>(
    'carbs_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fatPerServingMeta = const VerificationMeta(
    'fatPerServing',
  );
  @override
  late final GeneratedColumn<double> fatPerServing = GeneratedColumn<double>(
    'fat_per_serving',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ingredientsMeta = const VerificationMeta(
    'ingredients',
  );
  @override
  late final GeneratedColumn<String> ingredients = GeneratedColumn<String>(
    'ingredients',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageUrlMeta = const VerificationMeta(
    'imageUrl',
  );
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
    'image_url',
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
  static const VerificationMeta _isPublicMeta = const VerificationMeta(
    'isPublic',
  );
  @override
  late final GeneratedColumn<bool> isPublic = GeneratedColumn<bool>(
    'is_public',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_public" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    name,
    description,
    instructions,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    carbsPerServing,
    fatPerServing,
    ingredients,
    imageUrl,
    category,
    isPublic,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
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
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('prep_time_minutes')) {
      context.handle(
        _prepTimeMinutesMeta,
        prepTimeMinutes.isAcceptableOrUnknown(
          data['prep_time_minutes']!,
          _prepTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('servings')) {
      context.handle(
        _servingsMeta,
        servings.isAcceptableOrUnknown(data['servings']!, _servingsMeta),
      );
    }
    if (data.containsKey('calories_per_serving')) {
      context.handle(
        _caloriesPerServingMeta,
        caloriesPerServing.isAcceptableOrUnknown(
          data['calories_per_serving']!,
          _caloriesPerServingMeta,
        ),
      );
    }
    if (data.containsKey('protein_per_serving')) {
      context.handle(
        _proteinPerServingMeta,
        proteinPerServing.isAcceptableOrUnknown(
          data['protein_per_serving']!,
          _proteinPerServingMeta,
        ),
      );
    }
    if (data.containsKey('carbs_per_serving')) {
      context.handle(
        _carbsPerServingMeta,
        carbsPerServing.isAcceptableOrUnknown(
          data['carbs_per_serving']!,
          _carbsPerServingMeta,
        ),
      );
    }
    if (data.containsKey('fat_per_serving')) {
      context.handle(
        _fatPerServingMeta,
        fatPerServing.isAcceptableOrUnknown(
          data['fat_per_serving']!,
          _fatPerServingMeta,
        ),
      );
    }
    if (data.containsKey('ingredients')) {
      context.handle(
        _ingredientsMeta,
        ingredients.isAcceptableOrUnknown(
          data['ingredients']!,
          _ingredientsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ingredientsMeta);
    }
    if (data.containsKey('image_url')) {
      context.handle(
        _imageUrlMeta,
        imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('is_public')) {
      context.handle(
        _isPublicMeta,
        isPublic.isAcceptableOrUnknown(data['is_public']!, _isPublicMeta),
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
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      )!,
      prepTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}prep_time_minutes'],
      ),
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      ),
      servings: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}servings'],
      ),
      caloriesPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}calories_per_serving'],
      ),
      proteinPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}protein_per_serving'],
      ),
      carbsPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbs_per_serving'],
      ),
      fatPerServing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fat_per_serving'],
      ),
      ingredients: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ingredients'],
      )!,
      imageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      isPublic: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_public'],
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
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String userId;
  final String name;
  final String? description;
  final String instructions;
  final int? prepTimeMinutes;
  final int? cookTimeMinutes;
  final int? servings;
  final int? caloriesPerServing;
  final double? proteinPerServing;
  final double? carbsPerServing;
  final double? fatPerServing;
  final String ingredients;
  final String? imageUrl;
  final String? category;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Recipe({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    required this.instructions,
    this.prepTimeMinutes,
    this.cookTimeMinutes,
    this.servings,
    this.caloriesPerServing,
    this.proteinPerServing,
    this.carbsPerServing,
    this.fatPerServing,
    required this.ingredients,
    this.imageUrl,
    this.category,
    required this.isPublic,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['instructions'] = Variable<String>(instructions);
    if (!nullToAbsent || prepTimeMinutes != null) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes);
    }
    if (!nullToAbsent || cookTimeMinutes != null) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    }
    if (!nullToAbsent || servings != null) {
      map['servings'] = Variable<int>(servings);
    }
    if (!nullToAbsent || caloriesPerServing != null) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing);
    }
    if (!nullToAbsent || proteinPerServing != null) {
      map['protein_per_serving'] = Variable<double>(proteinPerServing);
    }
    if (!nullToAbsent || carbsPerServing != null) {
      map['carbs_per_serving'] = Variable<double>(carbsPerServing);
    }
    if (!nullToAbsent || fatPerServing != null) {
      map['fat_per_serving'] = Variable<double>(fatPerServing);
    }
    map['ingredients'] = Variable<String>(ingredients);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    map['is_public'] = Variable<bool>(isPublic);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      instructions: Value(instructions),
      prepTimeMinutes: prepTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(prepTimeMinutes),
      cookTimeMinutes: cookTimeMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(cookTimeMinutes),
      servings: servings == null && nullToAbsent
          ? const Value.absent()
          : Value(servings),
      caloriesPerServing: caloriesPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesPerServing),
      proteinPerServing: proteinPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinPerServing),
      carbsPerServing: carbsPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsPerServing),
      fatPerServing: fatPerServing == null && nullToAbsent
          ? const Value.absent()
          : Value(fatPerServing),
      ingredients: Value(ingredients),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      isPublic: Value(isPublic),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      instructions: serializer.fromJson<String>(json['instructions']),
      prepTimeMinutes: serializer.fromJson<int?>(json['prepTimeMinutes']),
      cookTimeMinutes: serializer.fromJson<int?>(json['cookTimeMinutes']),
      servings: serializer.fromJson<int?>(json['servings']),
      caloriesPerServing: serializer.fromJson<int?>(json['caloriesPerServing']),
      proteinPerServing: serializer.fromJson<double?>(
        json['proteinPerServing'],
      ),
      carbsPerServing: serializer.fromJson<double?>(json['carbsPerServing']),
      fatPerServing: serializer.fromJson<double?>(json['fatPerServing']),
      ingredients: serializer.fromJson<String>(json['ingredients']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      category: serializer.fromJson<String?>(json['category']),
      isPublic: serializer.fromJson<bool>(json['isPublic']),
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'instructions': serializer.toJson<String>(instructions),
      'prepTimeMinutes': serializer.toJson<int?>(prepTimeMinutes),
      'cookTimeMinutes': serializer.toJson<int?>(cookTimeMinutes),
      'servings': serializer.toJson<int?>(servings),
      'caloriesPerServing': serializer.toJson<int?>(caloriesPerServing),
      'proteinPerServing': serializer.toJson<double?>(proteinPerServing),
      'carbsPerServing': serializer.toJson<double?>(carbsPerServing),
      'fatPerServing': serializer.toJson<double?>(fatPerServing),
      'ingredients': serializer.toJson<String>(ingredients),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'category': serializer.toJson<String?>(category),
      'isPublic': serializer.toJson<bool>(isPublic),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Recipe copyWith({
    int? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    String? instructions,
    Value<int?> prepTimeMinutes = const Value.absent(),
    Value<int?> cookTimeMinutes = const Value.absent(),
    Value<int?> servings = const Value.absent(),
    Value<int?> caloriesPerServing = const Value.absent(),
    Value<double?> proteinPerServing = const Value.absent(),
    Value<double?> carbsPerServing = const Value.absent(),
    Value<double?> fatPerServing = const Value.absent(),
    String? ingredients,
    Value<String?> imageUrl = const Value.absent(),
    Value<String?> category = const Value.absent(),
    bool? isPublic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Recipe(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    instructions: instructions ?? this.instructions,
    prepTimeMinutes: prepTimeMinutes.present
        ? prepTimeMinutes.value
        : this.prepTimeMinutes,
    cookTimeMinutes: cookTimeMinutes.present
        ? cookTimeMinutes.value
        : this.cookTimeMinutes,
    servings: servings.present ? servings.value : this.servings,
    caloriesPerServing: caloriesPerServing.present
        ? caloriesPerServing.value
        : this.caloriesPerServing,
    proteinPerServing: proteinPerServing.present
        ? proteinPerServing.value
        : this.proteinPerServing,
    carbsPerServing: carbsPerServing.present
        ? carbsPerServing.value
        : this.carbsPerServing,
    fatPerServing: fatPerServing.present
        ? fatPerServing.value
        : this.fatPerServing,
    ingredients: ingredients ?? this.ingredients,
    imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
    category: category.present ? category.value : this.category,
    isPublic: isPublic ?? this.isPublic,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      prepTimeMinutes: data.prepTimeMinutes.present
          ? data.prepTimeMinutes.value
          : this.prepTimeMinutes,
      cookTimeMinutes: data.cookTimeMinutes.present
          ? data.cookTimeMinutes.value
          : this.cookTimeMinutes,
      servings: data.servings.present ? data.servings.value : this.servings,
      caloriesPerServing: data.caloriesPerServing.present
          ? data.caloriesPerServing.value
          : this.caloriesPerServing,
      proteinPerServing: data.proteinPerServing.present
          ? data.proteinPerServing.value
          : this.proteinPerServing,
      carbsPerServing: data.carbsPerServing.present
          ? data.carbsPerServing.value
          : this.carbsPerServing,
      fatPerServing: data.fatPerServing.present
          ? data.fatPerServing.value
          : this.fatPerServing,
      ingredients: data.ingredients.present
          ? data.ingredients.value
          : this.ingredients,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      category: data.category.present ? data.category.value : this.category,
      isPublic: data.isPublic.present ? data.isPublic.value : this.isPublic,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('ingredients: $ingredients, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('category: $category, ')
          ..write('isPublic: $isPublic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    instructions,
    prepTimeMinutes,
    cookTimeMinutes,
    servings,
    caloriesPerServing,
    proteinPerServing,
    carbsPerServing,
    fatPerServing,
    ingredients,
    imageUrl,
    category,
    isPublic,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.prepTimeMinutes == this.prepTimeMinutes &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.servings == this.servings &&
          other.caloriesPerServing == this.caloriesPerServing &&
          other.proteinPerServing == this.proteinPerServing &&
          other.carbsPerServing == this.carbsPerServing &&
          other.fatPerServing == this.fatPerServing &&
          other.ingredients == this.ingredients &&
          other.imageUrl == this.imageUrl &&
          other.category == this.category &&
          other.isPublic == this.isPublic &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String> instructions;
  final Value<int?> prepTimeMinutes;
  final Value<int?> cookTimeMinutes;
  final Value<int?> servings;
  final Value<int?> caloriesPerServing;
  final Value<double?> proteinPerServing;
  final Value<double?> carbsPerServing;
  final Value<double?> fatPerServing;
  final Value<String> ingredients;
  final Value<String?> imageUrl;
  final Value<String?> category;
  final Value<bool> isPublic;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.proteinPerServing = const Value.absent(),
    this.carbsPerServing = const Value.absent(),
    this.fatPerServing = const Value.absent(),
    this.ingredients = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.isPublic = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String name,
    this.description = const Value.absent(),
    required String instructions,
    this.prepTimeMinutes = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.servings = const Value.absent(),
    this.caloriesPerServing = const Value.absent(),
    this.proteinPerServing = const Value.absent(),
    this.carbsPerServing = const Value.absent(),
    this.fatPerServing = const Value.absent(),
    required String ingredients,
    this.imageUrl = const Value.absent(),
    this.category = const Value.absent(),
    this.isPublic = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       name = Value(name),
       instructions = Value(instructions),
       ingredients = Value(ingredients),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<int>? prepTimeMinutes,
    Expression<int>? cookTimeMinutes,
    Expression<int>? servings,
    Expression<int>? caloriesPerServing,
    Expression<double>? proteinPerServing,
    Expression<double>? carbsPerServing,
    Expression<double>? fatPerServing,
    Expression<String>? ingredients,
    Expression<String>? imageUrl,
    Expression<String>? category,
    Expression<bool>? isPublic,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (prepTimeMinutes != null) 'prep_time_minutes': prepTimeMinutes,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (servings != null) 'servings': servings,
      if (caloriesPerServing != null)
        'calories_per_serving': caloriesPerServing,
      if (proteinPerServing != null) 'protein_per_serving': proteinPerServing,
      if (carbsPerServing != null) 'carbs_per_serving': carbsPerServing,
      if (fatPerServing != null) 'fat_per_serving': fatPerServing,
      if (ingredients != null) 'ingredients': ingredients,
      if (imageUrl != null) 'image_url': imageUrl,
      if (category != null) 'category': category,
      if (isPublic != null) 'is_public': isPublic,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<String>? instructions,
    Value<int?>? prepTimeMinutes,
    Value<int?>? cookTimeMinutes,
    Value<int?>? servings,
    Value<int?>? caloriesPerServing,
    Value<double?>? proteinPerServing,
    Value<double?>? carbsPerServing,
    Value<double?>? fatPerServing,
    Value<String>? ingredients,
    Value<String?>? imageUrl,
    Value<String?>? category,
    Value<bool>? isPublic,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      caloriesPerServing: caloriesPerServing ?? this.caloriesPerServing,
      proteinPerServing: proteinPerServing ?? this.proteinPerServing,
      carbsPerServing: carbsPerServing ?? this.carbsPerServing,
      fatPerServing: fatPerServing ?? this.fatPerServing,
      ingredients: ingredients ?? this.ingredients,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isPublic: isPublic ?? this.isPublic,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (prepTimeMinutes.present) {
      map['prep_time_minutes'] = Variable<int>(prepTimeMinutes.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (servings.present) {
      map['servings'] = Variable<int>(servings.value);
    }
    if (caloriesPerServing.present) {
      map['calories_per_serving'] = Variable<int>(caloriesPerServing.value);
    }
    if (proteinPerServing.present) {
      map['protein_per_serving'] = Variable<double>(proteinPerServing.value);
    }
    if (carbsPerServing.present) {
      map['carbs_per_serving'] = Variable<double>(carbsPerServing.value);
    }
    if (fatPerServing.present) {
      map['fat_per_serving'] = Variable<double>(fatPerServing.value);
    }
    if (ingredients.present) {
      map['ingredients'] = Variable<String>(ingredients.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPublic.present) {
      map['is_public'] = Variable<bool>(isPublic.value);
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
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('prepTimeMinutes: $prepTimeMinutes, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('servings: $servings, ')
          ..write('caloriesPerServing: $caloriesPerServing, ')
          ..write('proteinPerServing: $proteinPerServing, ')
          ..write('carbsPerServing: $carbsPerServing, ')
          ..write('fatPerServing: $fatPerServing, ')
          ..write('ingredients: $ingredients, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('category: $category, ')
          ..write('isPublic: $isPublic, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $GlucoseLogsTable extends GlucoseLogs
    with TableInfo<$GlucoseLogsTable, GlucoseLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlucoseLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _measurementTypeMeta = const VerificationMeta(
    'measurementType',
  );
  @override
  late final GeneratedColumn<String> measurementType = GeneratedColumn<String>(
    'measurement_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    value,
    unit,
    measurementType,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'glucose_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<GlucoseLog> instance, {
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
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('measurement_type')) {
      context.handle(
        _measurementTypeMeta,
        measurementType.isAcceptableOrUnknown(
          data['measurement_type']!,
          _measurementTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_measurementTypeMeta);
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
  GlucoseLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlucoseLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      measurementType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_type'],
      )!,
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
  $GlucoseLogsTable createAlias(String alias) {
    return $GlucoseLogsTable(attachedDatabase, alias);
  }
}

class GlucoseLog extends DataClass implements Insertable<GlucoseLog> {
  final int id;
  final String userId;
  final double value;
  final String unit;
  final String measurementType;
  final String? notes;
  final DateTime loggedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GlucoseLog({
    required this.id,
    required this.userId,
    required this.value,
    required this.unit,
    required this.measurementType,
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
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    map['measurement_type'] = Variable<String>(measurementType);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GlucoseLogsCompanion toCompanion(bool nullToAbsent) {
    return GlucoseLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      value: Value(value),
      unit: Value(unit),
      measurementType: Value(measurementType),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      loggedAt: Value(loggedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GlucoseLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlucoseLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      measurementType: serializer.fromJson<String>(json['measurementType']),
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
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'measurementType': serializer.toJson<String>(measurementType),
      'notes': serializer.toJson<String?>(notes),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GlucoseLog copyWith({
    int? id,
    String? userId,
    double? value,
    String? unit,
    String? measurementType,
    Value<String?> notes = const Value.absent(),
    DateTime? loggedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GlucoseLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    measurementType: measurementType ?? this.measurementType,
    notes: notes.present ? notes.value : this.notes,
    loggedAt: loggedAt ?? this.loggedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GlucoseLog copyWithCompanion(GlucoseLogsCompanion data) {
    return GlucoseLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      measurementType: data.measurementType.present
          ? data.measurementType.value
          : this.measurementType,
      notes: data.notes.present ? data.notes.value : this.notes,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('measurementType: $measurementType, ')
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
    value,
    unit,
    measurementType,
    notes,
    loggedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlucoseLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.measurementType == this.measurementType &&
          other.notes == this.notes &&
          other.loggedAt == this.loggedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GlucoseLogsCompanion extends UpdateCompanion<GlucoseLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<double> value;
  final Value<String> unit;
  final Value<String> measurementType;
  final Value<String?> notes;
  final Value<DateTime> loggedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const GlucoseLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.measurementType = const Value.absent(),
    this.notes = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  GlucoseLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required double value,
    required String unit,
    required String measurementType,
    this.notes = const Value.absent(),
    required DateTime loggedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       value = Value(value),
       unit = Value(unit),
       measurementType = Value(measurementType),
       loggedAt = Value(loggedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<GlucoseLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<String>? measurementType,
    Expression<String>? notes,
    Expression<DateTime>? loggedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (measurementType != null) 'measurement_type': measurementType,
      if (notes != null) 'notes': notes,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  GlucoseLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<double>? value,
    Value<String>? unit,
    Value<String>? measurementType,
    Value<String?>? notes,
    Value<DateTime>? loggedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return GlucoseLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      measurementType: measurementType ?? this.measurementType,
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
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (measurementType.present) {
      map['measurement_type'] = Variable<String>(measurementType.value);
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
    return (StringBuffer('GlucoseLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('measurementType: $measurementType, ')
          ..write('notes: $notes, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $PeriodLogsTable extends PeriodLogs
    with TableInfo<$PeriodLogsTable, PeriodLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PeriodLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flowLevelMeta = const VerificationMeta(
    'flowLevel',
  );
  @override
  late final GeneratedColumn<int> flowLevel = GeneratedColumn<int>(
    'flow_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _symptomsMeta = const VerificationMeta(
    'symptoms',
  );
  @override
  late final GeneratedColumn<String> symptoms = GeneratedColumn<String>(
    'symptoms',
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
    startDate,
    endDate,
    flowLevel,
    symptoms,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'period_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<PeriodLog> instance, {
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
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('flow_level')) {
      context.handle(
        _flowLevelMeta,
        flowLevel.isAcceptableOrUnknown(data['flow_level']!, _flowLevelMeta),
      );
    }
    if (data.containsKey('symptoms')) {
      context.handle(
        _symptomsMeta,
        symptoms.isAcceptableOrUnknown(data['symptoms']!, _symptomsMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  PeriodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PeriodLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      flowLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}flow_level'],
      ),
      symptoms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}symptoms'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $PeriodLogsTable createAlias(String alias) {
    return $PeriodLogsTable(attachedDatabase, alias);
  }
}

class PeriodLog extends DataClass implements Insertable<PeriodLog> {
  final int id;
  final String userId;
  final DateTime startDate;
  final DateTime? endDate;
  final int? flowLevel;
  final String? symptoms;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PeriodLog({
    required this.id,
    required this.userId,
    required this.startDate,
    this.endDate,
    this.flowLevel,
    this.symptoms,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['start_date'] = Variable<DateTime>(startDate);
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || flowLevel != null) {
      map['flow_level'] = Variable<int>(flowLevel);
    }
    if (!nullToAbsent || symptoms != null) {
      map['symptoms'] = Variable<String>(symptoms);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PeriodLogsCompanion toCompanion(bool nullToAbsent) {
    return PeriodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      startDate: Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      flowLevel: flowLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(flowLevel),
      symptoms: symptoms == null && nullToAbsent
          ? const Value.absent()
          : Value(symptoms),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PeriodLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PeriodLog(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      flowLevel: serializer.fromJson<int?>(json['flowLevel']),
      symptoms: serializer.fromJson<String?>(json['symptoms']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'flowLevel': serializer.toJson<int?>(flowLevel),
      'symptoms': serializer.toJson<String?>(symptoms),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PeriodLog copyWith({
    int? id,
    String? userId,
    DateTime? startDate,
    Value<DateTime?> endDate = const Value.absent(),
    Value<int?> flowLevel = const Value.absent(),
    Value<String?> symptoms = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PeriodLog(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    startDate: startDate ?? this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    flowLevel: flowLevel.present ? flowLevel.value : this.flowLevel,
    symptoms: symptoms.present ? symptoms.value : this.symptoms,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PeriodLog copyWithCompanion(PeriodLogsCompanion data) {
    return PeriodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      flowLevel: data.flowLevel.present ? data.flowLevel.value : this.flowLevel,
      symptoms: data.symptoms.present ? data.symptoms.value : this.symptoms,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PeriodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('flowLevel: $flowLevel, ')
          ..write('symptoms: $symptoms, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    startDate,
    endDate,
    flowLevel,
    symptoms,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PeriodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.flowLevel == this.flowLevel &&
          other.symptoms == this.symptoms &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PeriodLogsCompanion extends UpdateCompanion<PeriodLog> {
  final Value<int> id;
  final Value<String> userId;
  final Value<DateTime> startDate;
  final Value<DateTime?> endDate;
  final Value<int?> flowLevel;
  final Value<String?> symptoms;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PeriodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.flowLevel = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PeriodLogsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required DateTime startDate,
    this.endDate = const Value.absent(),
    this.flowLevel = const Value.absent(),
    this.symptoms = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       startDate = Value(startDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PeriodLog> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<int>? flowLevel,
    Expression<String>? symptoms,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (flowLevel != null) 'flow_level': flowLevel,
      if (symptoms != null) 'symptoms': symptoms,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PeriodLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<DateTime>? startDate,
    Value<DateTime?>? endDate,
    Value<int?>? flowLevel,
    Value<String?>? symptoms,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PeriodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      flowLevel: flowLevel ?? this.flowLevel,
      symptoms: symptoms ?? this.symptoms,
      notes: notes ?? this.notes,
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
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (flowLevel.present) {
      map['flow_level'] = Variable<int>(flowLevel.value);
    }
    if (symptoms.present) {
      map['symptoms'] = Variable<String>(symptoms.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('PeriodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('flowLevel: $flowLevel, ')
          ..write('symptoms: $symptoms, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTable extends JournalEntries
    with TableInfo<$JournalEntriesTable, JournalEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlsMeta = const VerificationMeta(
    'imageUrls',
  );
  @override
  late final GeneratedColumn<String> imageUrls = GeneratedColumn<String>(
    'image_urls',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isPrivateMeta = const VerificationMeta(
    'isPrivate',
  );
  @override
  late final GeneratedColumn<bool> isPrivate = GeneratedColumn<bool>(
    'is_private',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_private" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _entryDateMeta = const VerificationMeta(
    'entryDate',
  );
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
    'entry_date',
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
    title,
    content,
    mood,
    tags,
    imageUrls,
    isPrivate,
    entryDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntry> instance, {
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
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    }
    if (data.containsKey('image_urls')) {
      context.handle(
        _imageUrlsMeta,
        imageUrls.isAcceptableOrUnknown(data['image_urls']!, _imageUrlsMeta),
      );
    }
    if (data.containsKey('is_private')) {
      context.handle(
        _isPrivateMeta,
        isPrivate.isAcceptableOrUnknown(data['is_private']!, _isPrivateMeta),
      );
    }
    if (data.containsKey('entry_date')) {
      context.handle(
        _entryDateMeta,
        entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta),
      );
    } else if (isInserting) {
      context.missing(_entryDateMeta);
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
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      ),
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      ),
      imageUrls: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_urls'],
      ),
      isPrivate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_private'],
      )!,
      entryDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}entry_date'],
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
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final int id;
  final String userId;
  final String? title;
  final String content;
  final String? mood;
  final String? tags;
  final String? imageUrls;
  final bool isPrivate;
  final DateTime entryDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const JournalEntry({
    required this.id,
    required this.userId,
    this.title,
    required this.content,
    this.mood,
    this.tags,
    this.imageUrls,
    required this.isPrivate,
    required this.entryDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    if (!nullToAbsent || imageUrls != null) {
      map['image_urls'] = Variable<String>(imageUrls);
    }
    map['is_private'] = Variable<bool>(isPrivate);
    map['entry_date'] = Variable<DateTime>(entryDate);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      title: title == null && nullToAbsent
          ? const Value.absent()
          : Value(title),
      content: Value(content),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      imageUrls: imageUrls == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrls),
      isPrivate: Value(isPrivate),
      entryDate: Value(entryDate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory JournalEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      mood: serializer.fromJson<String?>(json['mood']),
      tags: serializer.fromJson<String?>(json['tags']),
      imageUrls: serializer.fromJson<String?>(json['imageUrls']),
      isPrivate: serializer.fromJson<bool>(json['isPrivate']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
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
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String>(content),
      'mood': serializer.toJson<String?>(mood),
      'tags': serializer.toJson<String?>(tags),
      'imageUrls': serializer.toJson<String?>(imageUrls),
      'isPrivate': serializer.toJson<bool>(isPrivate),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  JournalEntry copyWith({
    int? id,
    String? userId,
    Value<String?> title = const Value.absent(),
    String? content,
    Value<String?> mood = const Value.absent(),
    Value<String?> tags = const Value.absent(),
    Value<String?> imageUrls = const Value.absent(),
    bool? isPrivate,
    DateTime? entryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => JournalEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    title: title.present ? title.value : this.title,
    content: content ?? this.content,
    mood: mood.present ? mood.value : this.mood,
    tags: tags.present ? tags.value : this.tags,
    imageUrls: imageUrls.present ? imageUrls.value : this.imageUrls,
    isPrivate: isPrivate ?? this.isPrivate,
    entryDate: entryDate ?? this.entryDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      mood: data.mood.present ? data.mood.value : this.mood,
      tags: data.tags.present ? data.tags.value : this.tags,
      imageUrls: data.imageUrls.present ? data.imageUrls.value : this.imageUrls,
      isPrivate: data.isPrivate.present ? data.isPrivate.value : this.isPrivate,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('tags: $tags, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('entryDate: $entryDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    title,
    content,
    mood,
    tags,
    imageUrls,
    isPrivate,
    entryDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.content == this.content &&
          other.mood == this.mood &&
          other.tags == this.tags &&
          other.imageUrls == this.imageUrls &&
          other.isPrivate == this.isPrivate &&
          other.entryDate == this.entryDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String?> title;
  final Value<String> content;
  final Value<String?> mood;
  final Value<String?> tags;
  final Value<String?> imageUrls;
  final Value<bool> isPrivate;
  final Value<DateTime> entryDate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.mood = const Value.absent(),
    this.tags = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.isPrivate = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    this.title = const Value.absent(),
    required String content,
    this.mood = const Value.absent(),
    this.tags = const Value.absent(),
    this.imageUrls = const Value.absent(),
    this.isPrivate = const Value.absent(),
    required DateTime entryDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       content = Value(content),
       entryDate = Value(entryDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<JournalEntry> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? mood,
    Expression<String>? tags,
    Expression<String>? imageUrls,
    Expression<bool>? isPrivate,
    Expression<DateTime>? entryDate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (mood != null) 'mood': mood,
      if (tags != null) 'tags': tags,
      if (imageUrls != null) 'image_urls': imageUrls,
      if (isPrivate != null) 'is_private': isPrivate,
      if (entryDate != null) 'entry_date': entryDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  JournalEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String?>? title,
    Value<String>? content,
    Value<String?>? mood,
    Value<String?>? tags,
    Value<String?>? imageUrls,
    Value<bool>? isPrivate,
    Value<DateTime>? entryDate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      mood: mood ?? this.mood,
      tags: tags ?? this.tags,
      imageUrls: imageUrls ?? this.imageUrls,
      isPrivate: isPrivate ?? this.isPrivate,
      entryDate: entryDate ?? this.entryDate,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (imageUrls.present) {
      map['image_urls'] = Variable<String>(imageUrls.value);
    }
    if (isPrivate.present) {
      map['is_private'] = Variable<bool>(isPrivate.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
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
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('mood: $mood, ')
          ..write('tags: $tags, ')
          ..write('imageUrls: $imageUrls, ')
          ..write('isPrivate: $isPrivate, ')
          ..write('entryDate: $entryDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $DoctorAppointmentsTable extends DoctorAppointments
    with TableInfo<$DoctorAppointmentsTable, DoctorAppointment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DoctorAppointmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _specialtyMeta = const VerificationMeta(
    'specialty',
  );
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
    'specialty',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clinicNameMeta = const VerificationMeta(
    'clinicName',
  );
  @override
  late final GeneratedColumn<String> clinicName = GeneratedColumn<String>(
    'clinic_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _appointmentDateMeta = const VerificationMeta(
    'appointmentDate',
  );
  @override
  late final GeneratedColumn<DateTime> appointmentDate =
      GeneratedColumn<DateTime>(
        'appointment_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
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
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _reminderSetMeta = const VerificationMeta(
    'reminderSet',
  );
  @override
  late final GeneratedColumn<bool> reminderSet = GeneratedColumn<bool>(
    'reminder_set',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminder_set" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
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
    doctorName,
    specialty,
    clinicName,
    address,
    phone,
    appointmentDate,
    reason,
    notes,
    status,
    reminderSet,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'doctor_appointments';
  @override
  VerificationContext validateIntegrity(
    Insertable<DoctorAppointment> instance, {
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
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    } else if (isInserting) {
      context.missing(_doctorNameMeta);
    }
    if (data.containsKey('specialty')) {
      context.handle(
        _specialtyMeta,
        specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta),
      );
    }
    if (data.containsKey('clinic_name')) {
      context.handle(
        _clinicNameMeta,
        clinicName.isAcceptableOrUnknown(data['clinic_name']!, _clinicNameMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('appointment_date')) {
      context.handle(
        _appointmentDateMeta,
        appointmentDate.isAcceptableOrUnknown(
          data['appointment_date']!,
          _appointmentDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_appointmentDateMeta);
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('reminder_set')) {
      context.handle(
        _reminderSetMeta,
        reminderSet.isAcceptableOrUnknown(
          data['reminder_set']!,
          _reminderSetMeta,
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
  DoctorAppointment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DoctorAppointment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      )!,
      specialty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}specialty'],
      ),
      clinicName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clinic_name'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      appointmentDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}appointment_date'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reminderSet: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminder_set'],
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
  $DoctorAppointmentsTable createAlias(String alias) {
    return $DoctorAppointmentsTable(attachedDatabase, alias);
  }
}

class DoctorAppointment extends DataClass
    implements Insertable<DoctorAppointment> {
  final int id;
  final String userId;
  final String doctorName;
  final String? specialty;
  final String? clinicName;
  final String? address;
  final String? phone;
  final DateTime appointmentDate;
  final String? reason;
  final String? notes;
  final String status;
  final bool reminderSet;
  final DateTime createdAt;
  final DateTime updatedAt;
  const DoctorAppointment({
    required this.id,
    required this.userId,
    required this.doctorName,
    this.specialty,
    this.clinicName,
    this.address,
    this.phone,
    required this.appointmentDate,
    this.reason,
    this.notes,
    required this.status,
    required this.reminderSet,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['doctor_name'] = Variable<String>(doctorName);
    if (!nullToAbsent || specialty != null) {
      map['specialty'] = Variable<String>(specialty);
    }
    if (!nullToAbsent || clinicName != null) {
      map['clinic_name'] = Variable<String>(clinicName);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['appointment_date'] = Variable<DateTime>(appointmentDate);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['reminder_set'] = Variable<bool>(reminderSet);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DoctorAppointmentsCompanion toCompanion(bool nullToAbsent) {
    return DoctorAppointmentsCompanion(
      id: Value(id),
      userId: Value(userId),
      doctorName: Value(doctorName),
      specialty: specialty == null && nullToAbsent
          ? const Value.absent()
          : Value(specialty),
      clinicName: clinicName == null && nullToAbsent
          ? const Value.absent()
          : Value(clinicName),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      appointmentDate: Value(appointmentDate),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      status: Value(status),
      reminderSet: Value(reminderSet),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory DoctorAppointment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DoctorAppointment(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      doctorName: serializer.fromJson<String>(json['doctorName']),
      specialty: serializer.fromJson<String?>(json['specialty']),
      clinicName: serializer.fromJson<String?>(json['clinicName']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      appointmentDate: serializer.fromJson<DateTime>(json['appointmentDate']),
      reason: serializer.fromJson<String?>(json['reason']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      reminderSet: serializer.fromJson<bool>(json['reminderSet']),
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
      'doctorName': serializer.toJson<String>(doctorName),
      'specialty': serializer.toJson<String?>(specialty),
      'clinicName': serializer.toJson<String?>(clinicName),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'appointmentDate': serializer.toJson<DateTime>(appointmentDate),
      'reason': serializer.toJson<String?>(reason),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'reminderSet': serializer.toJson<bool>(reminderSet),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DoctorAppointment copyWith({
    int? id,
    String? userId,
    String? doctorName,
    Value<String?> specialty = const Value.absent(),
    Value<String?> clinicName = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    DateTime? appointmentDate,
    Value<String?> reason = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    String? status,
    bool? reminderSet,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => DoctorAppointment(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    doctorName: doctorName ?? this.doctorName,
    specialty: specialty.present ? specialty.value : this.specialty,
    clinicName: clinicName.present ? clinicName.value : this.clinicName,
    address: address.present ? address.value : this.address,
    phone: phone.present ? phone.value : this.phone,
    appointmentDate: appointmentDate ?? this.appointmentDate,
    reason: reason.present ? reason.value : this.reason,
    notes: notes.present ? notes.value : this.notes,
    status: status ?? this.status,
    reminderSet: reminderSet ?? this.reminderSet,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DoctorAppointment copyWithCompanion(DoctorAppointmentsCompanion data) {
    return DoctorAppointment(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      clinicName: data.clinicName.present
          ? data.clinicName.value
          : this.clinicName,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      appointmentDate: data.appointmentDate.present
          ? data.appointmentDate.value
          : this.appointmentDate,
      reason: data.reason.present ? data.reason.value : this.reason,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      reminderSet: data.reminderSet.present
          ? data.reminderSet.value
          : this.reminderSet,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DoctorAppointment(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('doctorName: $doctorName, ')
          ..write('specialty: $specialty, ')
          ..write('clinicName: $clinicName, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('reminderSet: $reminderSet, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    doctorName,
    specialty,
    clinicName,
    address,
    phone,
    appointmentDate,
    reason,
    notes,
    status,
    reminderSet,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DoctorAppointment &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.doctorName == this.doctorName &&
          other.specialty == this.specialty &&
          other.clinicName == this.clinicName &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.appointmentDate == this.appointmentDate &&
          other.reason == this.reason &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.reminderSet == this.reminderSet &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DoctorAppointmentsCompanion extends UpdateCompanion<DoctorAppointment> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> doctorName;
  final Value<String?> specialty;
  final Value<String?> clinicName;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<DateTime> appointmentDate;
  final Value<String?> reason;
  final Value<String?> notes;
  final Value<String> status;
  final Value<bool> reminderSet;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const DoctorAppointmentsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.specialty = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.appointmentDate = const Value.absent(),
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.reminderSet = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  DoctorAppointmentsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String doctorName,
    this.specialty = const Value.absent(),
    this.clinicName = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    required DateTime appointmentDate,
    this.reason = const Value.absent(),
    this.notes = const Value.absent(),
    required String status,
    this.reminderSet = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       doctorName = Value(doctorName),
       appointmentDate = Value(appointmentDate),
       status = Value(status),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<DoctorAppointment> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? doctorName,
    Expression<String>? specialty,
    Expression<String>? clinicName,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<DateTime>? appointmentDate,
    Expression<String>? reason,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<bool>? reminderSet,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (doctorName != null) 'doctor_name': doctorName,
      if (specialty != null) 'specialty': specialty,
      if (clinicName != null) 'clinic_name': clinicName,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (appointmentDate != null) 'appointment_date': appointmentDate,
      if (reason != null) 'reason': reason,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (reminderSet != null) 'reminder_set': reminderSet,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  DoctorAppointmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? doctorName,
    Value<String?>? specialty,
    Value<String?>? clinicName,
    Value<String?>? address,
    Value<String?>? phone,
    Value<DateTime>? appointmentDate,
    Value<String?>? reason,
    Value<String?>? notes,
    Value<String>? status,
    Value<bool>? reminderSet,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return DoctorAppointmentsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      doctorName: doctorName ?? this.doctorName,
      specialty: specialty ?? this.specialty,
      clinicName: clinicName ?? this.clinicName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      appointmentDate: appointmentDate ?? this.appointmentDate,
      reason: reason ?? this.reason,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      reminderSet: reminderSet ?? this.reminderSet,
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
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (clinicName.present) {
      map['clinic_name'] = Variable<String>(clinicName.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (appointmentDate.present) {
      map['appointment_date'] = Variable<DateTime>(appointmentDate.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reminderSet.present) {
      map['reminder_set'] = Variable<bool>(reminderSet.value);
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
    return (StringBuffer('DoctorAppointmentsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('doctorName: $doctorName, ')
          ..write('specialty: $specialty, ')
          ..write('clinicName: $clinicName, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('appointmentDate: $appointmentDate, ')
          ..write('reason: $reason, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('reminderSet: $reminderSet, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $LabReportsTable extends LabReports
    with TableInfo<$LabReportsTable, LabReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LabReportsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _reportNameMeta = const VerificationMeta(
    'reportName',
  );
  @override
  late final GeneratedColumn<String> reportName = GeneratedColumn<String>(
    'report_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labNameMeta = const VerificationMeta(
    'labName',
  );
  @override
  late final GeneratedColumn<String> labName = GeneratedColumn<String>(
    'lab_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _doctorNameMeta = const VerificationMeta(
    'doctorName',
  );
  @override
  late final GeneratedColumn<String> doctorName = GeneratedColumn<String>(
    'doctor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reportDateMeta = const VerificationMeta(
    'reportDate',
  );
  @override
  late final GeneratedColumn<DateTime> reportDate = GeneratedColumn<DateTime>(
    'report_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resultsMeta = const VerificationMeta(
    'results',
  );
  @override
  late final GeneratedColumn<String> results = GeneratedColumn<String>(
    'results',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileUrlMeta = const VerificationMeta(
    'fileUrl',
  );
  @override
  late final GeneratedColumn<String> fileUrl = GeneratedColumn<String>(
    'file_url',
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
    reportName,
    labName,
    doctorName,
    reportDate,
    results,
    fileUrl,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<LabReport> instance, {
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
    if (data.containsKey('report_name')) {
      context.handle(
        _reportNameMeta,
        reportName.isAcceptableOrUnknown(data['report_name']!, _reportNameMeta),
      );
    } else if (isInserting) {
      context.missing(_reportNameMeta);
    }
    if (data.containsKey('lab_name')) {
      context.handle(
        _labNameMeta,
        labName.isAcceptableOrUnknown(data['lab_name']!, _labNameMeta),
      );
    }
    if (data.containsKey('doctor_name')) {
      context.handle(
        _doctorNameMeta,
        doctorName.isAcceptableOrUnknown(data['doctor_name']!, _doctorNameMeta),
      );
    }
    if (data.containsKey('report_date')) {
      context.handle(
        _reportDateMeta,
        reportDate.isAcceptableOrUnknown(data['report_date']!, _reportDateMeta),
      );
    } else if (isInserting) {
      context.missing(_reportDateMeta);
    }
    if (data.containsKey('results')) {
      context.handle(
        _resultsMeta,
        results.isAcceptableOrUnknown(data['results']!, _resultsMeta),
      );
    }
    if (data.containsKey('file_url')) {
      context.handle(
        _fileUrlMeta,
        fileUrl.isAcceptableOrUnknown(data['file_url']!, _fileUrlMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  LabReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      reportName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_name'],
      )!,
      labName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lab_name'],
      ),
      doctorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}doctor_name'],
      ),
      reportDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}report_date'],
      )!,
      results: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}results'],
      ),
      fileUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_url'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $LabReportsTable createAlias(String alias) {
    return $LabReportsTable(attachedDatabase, alias);
  }
}

class LabReport extends DataClass implements Insertable<LabReport> {
  final int id;
  final String userId;
  final String reportName;
  final String? labName;
  final String? doctorName;
  final DateTime reportDate;
  final String? results;
  final String? fileUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LabReport({
    required this.id,
    required this.userId,
    required this.reportName,
    this.labName,
    this.doctorName,
    required this.reportDate,
    this.results,
    this.fileUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['report_name'] = Variable<String>(reportName);
    if (!nullToAbsent || labName != null) {
      map['lab_name'] = Variable<String>(labName);
    }
    if (!nullToAbsent || doctorName != null) {
      map['doctor_name'] = Variable<String>(doctorName);
    }
    map['report_date'] = Variable<DateTime>(reportDate);
    if (!nullToAbsent || results != null) {
      map['results'] = Variable<String>(results);
    }
    if (!nullToAbsent || fileUrl != null) {
      map['file_url'] = Variable<String>(fileUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LabReportsCompanion toCompanion(bool nullToAbsent) {
    return LabReportsCompanion(
      id: Value(id),
      userId: Value(userId),
      reportName: Value(reportName),
      labName: labName == null && nullToAbsent
          ? const Value.absent()
          : Value(labName),
      doctorName: doctorName == null && nullToAbsent
          ? const Value.absent()
          : Value(doctorName),
      reportDate: Value(reportDate),
      results: results == null && nullToAbsent
          ? const Value.absent()
          : Value(results),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LabReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabReport(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      reportName: serializer.fromJson<String>(json['reportName']),
      labName: serializer.fromJson<String?>(json['labName']),
      doctorName: serializer.fromJson<String?>(json['doctorName']),
      reportDate: serializer.fromJson<DateTime>(json['reportDate']),
      results: serializer.fromJson<String?>(json['results']),
      fileUrl: serializer.fromJson<String?>(json['fileUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'reportName': serializer.toJson<String>(reportName),
      'labName': serializer.toJson<String?>(labName),
      'doctorName': serializer.toJson<String?>(doctorName),
      'reportDate': serializer.toJson<DateTime>(reportDate),
      'results': serializer.toJson<String?>(results),
      'fileUrl': serializer.toJson<String?>(fileUrl),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LabReport copyWith({
    int? id,
    String? userId,
    String? reportName,
    Value<String?> labName = const Value.absent(),
    Value<String?> doctorName = const Value.absent(),
    DateTime? reportDate,
    Value<String?> results = const Value.absent(),
    Value<String?> fileUrl = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LabReport(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    reportName: reportName ?? this.reportName,
    labName: labName.present ? labName.value : this.labName,
    doctorName: doctorName.present ? doctorName.value : this.doctorName,
    reportDate: reportDate ?? this.reportDate,
    results: results.present ? results.value : this.results,
    fileUrl: fileUrl.present ? fileUrl.value : this.fileUrl,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LabReport copyWithCompanion(LabReportsCompanion data) {
    return LabReport(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      reportName: data.reportName.present
          ? data.reportName.value
          : this.reportName,
      labName: data.labName.present ? data.labName.value : this.labName,
      doctorName: data.doctorName.present
          ? data.doctorName.value
          : this.doctorName,
      reportDate: data.reportDate.present
          ? data.reportDate.value
          : this.reportDate,
      results: data.results.present ? data.results.value : this.results,
      fileUrl: data.fileUrl.present ? data.fileUrl.value : this.fileUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabReport(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('reportName: $reportName, ')
          ..write('labName: $labName, ')
          ..write('doctorName: $doctorName, ')
          ..write('reportDate: $reportDate, ')
          ..write('results: $results, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    reportName,
    labName,
    doctorName,
    reportDate,
    results,
    fileUrl,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabReport &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.reportName == this.reportName &&
          other.labName == this.labName &&
          other.doctorName == this.doctorName &&
          other.reportDate == this.reportDate &&
          other.results == this.results &&
          other.fileUrl == this.fileUrl &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LabReportsCompanion extends UpdateCompanion<LabReport> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> reportName;
  final Value<String?> labName;
  final Value<String?> doctorName;
  final Value<DateTime> reportDate;
  final Value<String?> results;
  final Value<String?> fileUrl;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LabReportsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.reportName = const Value.absent(),
    this.labName = const Value.absent(),
    this.doctorName = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.results = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LabReportsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String reportName,
    this.labName = const Value.absent(),
    this.doctorName = const Value.absent(),
    required DateTime reportDate,
    this.results = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       reportName = Value(reportName),
       reportDate = Value(reportDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LabReport> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? reportName,
    Expression<String>? labName,
    Expression<String>? doctorName,
    Expression<DateTime>? reportDate,
    Expression<String>? results,
    Expression<String>? fileUrl,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (reportName != null) 'report_name': reportName,
      if (labName != null) 'lab_name': labName,
      if (doctorName != null) 'doctor_name': doctorName,
      if (reportDate != null) 'report_date': reportDate,
      if (results != null) 'results': results,
      if (fileUrl != null) 'file_url': fileUrl,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LabReportsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? reportName,
    Value<String?>? labName,
    Value<String?>? doctorName,
    Value<DateTime>? reportDate,
    Value<String?>? results,
    Value<String?>? fileUrl,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LabReportsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      reportName: reportName ?? this.reportName,
      labName: labName ?? this.labName,
      doctorName: doctorName ?? this.doctorName,
      reportDate: reportDate ?? this.reportDate,
      results: results ?? this.results,
      fileUrl: fileUrl ?? this.fileUrl,
      notes: notes ?? this.notes,
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
    if (reportName.present) {
      map['report_name'] = Variable<String>(reportName.value);
    }
    if (labName.present) {
      map['lab_name'] = Variable<String>(labName.value);
    }
    if (doctorName.present) {
      map['doctor_name'] = Variable<String>(doctorName.value);
    }
    if (reportDate.present) {
      map['report_date'] = Variable<DateTime>(reportDate.value);
    }
    if (results.present) {
      map['results'] = Variable<String>(results.value);
    }
    if (fileUrl.present) {
      map['file_url'] = Variable<String>(fileUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('LabReportsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('reportName: $reportName, ')
          ..write('labName: $labName, ')
          ..write('doctorName: $doctorName, ')
          ..write('reportDate: $reportDate, ')
          ..write('results: $results, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $EmergencyCardTable extends EmergencyCard
    with TableInfo<$EmergencyCardTable, EmergencyCardData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyCardTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bloodTypeMeta = const VerificationMeta(
    'bloodType',
  );
  @override
  late final GeneratedColumn<String> bloodType = GeneratedColumn<String>(
    'blood_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _allergiesMeta = const VerificationMeta(
    'allergies',
  );
  @override
  late final GeneratedColumn<String> allergies = GeneratedColumn<String>(
    'allergies',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _conditionsMeta = const VerificationMeta(
    'conditions',
  );
  @override
  late final GeneratedColumn<String> conditions = GeneratedColumn<String>(
    'conditions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _medicationsMeta = const VerificationMeta(
    'medications',
  );
  @override
  late final GeneratedColumn<String> medications = GeneratedColumn<String>(
    'medications',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emergencyContactNameMeta =
      const VerificationMeta('emergencyContactName');
  @override
  late final GeneratedColumn<String> emergencyContactName =
      GeneratedColumn<String>(
        'emergency_contact_name',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emergencyContactPhoneMeta =
      const VerificationMeta('emergencyContactPhone');
  @override
  late final GeneratedColumn<String> emergencyContactPhone =
      GeneratedColumn<String>(
        'emergency_contact_phone',
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
  static const VerificationMeta _isVisibleOnLockScreenMeta =
      const VerificationMeta('isVisibleOnLockScreen');
  @override
  late final GeneratedColumn<bool> isVisibleOnLockScreen =
      GeneratedColumn<bool>(
        'is_visible_on_lock_screen',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_visible_on_lock_screen" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
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
    fullName,
    dateOfBirth,
    bloodType,
    allergies,
    conditions,
    medications,
    emergencyContactName,
    emergencyContactPhone,
    notes,
    isVisibleOnLockScreen,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_card';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyCardData> instance, {
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
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('blood_type')) {
      context.handle(
        _bloodTypeMeta,
        bloodType.isAcceptableOrUnknown(data['blood_type']!, _bloodTypeMeta),
      );
    }
    if (data.containsKey('allergies')) {
      context.handle(
        _allergiesMeta,
        allergies.isAcceptableOrUnknown(data['allergies']!, _allergiesMeta),
      );
    }
    if (data.containsKey('conditions')) {
      context.handle(
        _conditionsMeta,
        conditions.isAcceptableOrUnknown(data['conditions']!, _conditionsMeta),
      );
    }
    if (data.containsKey('medications')) {
      context.handle(
        _medicationsMeta,
        medications.isAcceptableOrUnknown(
          data['medications']!,
          _medicationsMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_name')) {
      context.handle(
        _emergencyContactNameMeta,
        emergencyContactName.isAcceptableOrUnknown(
          data['emergency_contact_name']!,
          _emergencyContactNameMeta,
        ),
      );
    }
    if (data.containsKey('emergency_contact_phone')) {
      context.handle(
        _emergencyContactPhoneMeta,
        emergencyContactPhone.isAcceptableOrUnknown(
          data['emergency_contact_phone']!,
          _emergencyContactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_visible_on_lock_screen')) {
      context.handle(
        _isVisibleOnLockScreenMeta,
        isVisibleOnLockScreen.isAcceptableOrUnknown(
          data['is_visible_on_lock_screen']!,
          _isVisibleOnLockScreenMeta,
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
  EmergencyCardData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyCardData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      bloodType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}blood_type'],
      ),
      allergies: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}allergies'],
      ),
      conditions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conditions'],
      ),
      medications: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medications'],
      ),
      emergencyContactName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_name'],
      ),
      emergencyContactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emergency_contact_phone'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isVisibleOnLockScreen: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_visible_on_lock_screen'],
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
  $EmergencyCardTable createAlias(String alias) {
    return $EmergencyCardTable(attachedDatabase, alias);
  }
}

class EmergencyCardData extends DataClass
    implements Insertable<EmergencyCardData> {
  final int id;
  final String userId;
  final String fullName;
  final DateTime? dateOfBirth;
  final String? bloodType;
  final String? allergies;
  final String? conditions;
  final String? medications;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? notes;
  final bool isVisibleOnLockScreen;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EmergencyCardData({
    required this.id,
    required this.userId,
    required this.fullName,
    this.dateOfBirth,
    this.bloodType,
    this.allergies,
    this.conditions,
    this.medications,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.notes,
    required this.isVisibleOnLockScreen,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || bloodType != null) {
      map['blood_type'] = Variable<String>(bloodType);
    }
    if (!nullToAbsent || allergies != null) {
      map['allergies'] = Variable<String>(allergies);
    }
    if (!nullToAbsent || conditions != null) {
      map['conditions'] = Variable<String>(conditions);
    }
    if (!nullToAbsent || medications != null) {
      map['medications'] = Variable<String>(medications);
    }
    if (!nullToAbsent || emergencyContactName != null) {
      map['emergency_contact_name'] = Variable<String>(emergencyContactName);
    }
    if (!nullToAbsent || emergencyContactPhone != null) {
      map['emergency_contact_phone'] = Variable<String>(emergencyContactPhone);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_visible_on_lock_screen'] = Variable<bool>(isVisibleOnLockScreen);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmergencyCardCompanion toCompanion(bool nullToAbsent) {
    return EmergencyCardCompanion(
      id: Value(id),
      userId: Value(userId),
      fullName: Value(fullName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      bloodType: bloodType == null && nullToAbsent
          ? const Value.absent()
          : Value(bloodType),
      allergies: allergies == null && nullToAbsent
          ? const Value.absent()
          : Value(allergies),
      conditions: conditions == null && nullToAbsent
          ? const Value.absent()
          : Value(conditions),
      medications: medications == null && nullToAbsent
          ? const Value.absent()
          : Value(medications),
      emergencyContactName: emergencyContactName == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactName),
      emergencyContactPhone: emergencyContactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(emergencyContactPhone),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isVisibleOnLockScreen: Value(isVisibleOnLockScreen),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EmergencyCardData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyCardData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      bloodType: serializer.fromJson<String?>(json['bloodType']),
      allergies: serializer.fromJson<String?>(json['allergies']),
      conditions: serializer.fromJson<String?>(json['conditions']),
      medications: serializer.fromJson<String?>(json['medications']),
      emergencyContactName: serializer.fromJson<String?>(
        json['emergencyContactName'],
      ),
      emergencyContactPhone: serializer.fromJson<String?>(
        json['emergencyContactPhone'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      isVisibleOnLockScreen: serializer.fromJson<bool>(
        json['isVisibleOnLockScreen'],
      ),
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
      'fullName': serializer.toJson<String>(fullName),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'bloodType': serializer.toJson<String?>(bloodType),
      'allergies': serializer.toJson<String?>(allergies),
      'conditions': serializer.toJson<String?>(conditions),
      'medications': serializer.toJson<String?>(medications),
      'emergencyContactName': serializer.toJson<String?>(emergencyContactName),
      'emergencyContactPhone': serializer.toJson<String?>(
        emergencyContactPhone,
      ),
      'notes': serializer.toJson<String?>(notes),
      'isVisibleOnLockScreen': serializer.toJson<bool>(isVisibleOnLockScreen),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EmergencyCardData copyWith({
    int? id,
    String? userId,
    String? fullName,
    Value<DateTime?> dateOfBirth = const Value.absent(),
    Value<String?> bloodType = const Value.absent(),
    Value<String?> allergies = const Value.absent(),
    Value<String?> conditions = const Value.absent(),
    Value<String?> medications = const Value.absent(),
    Value<String?> emergencyContactName = const Value.absent(),
    Value<String?> emergencyContactPhone = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isVisibleOnLockScreen,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EmergencyCardData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    fullName: fullName ?? this.fullName,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    bloodType: bloodType.present ? bloodType.value : this.bloodType,
    allergies: allergies.present ? allergies.value : this.allergies,
    conditions: conditions.present ? conditions.value : this.conditions,
    medications: medications.present ? medications.value : this.medications,
    emergencyContactName: emergencyContactName.present
        ? emergencyContactName.value
        : this.emergencyContactName,
    emergencyContactPhone: emergencyContactPhone.present
        ? emergencyContactPhone.value
        : this.emergencyContactPhone,
    notes: notes.present ? notes.value : this.notes,
    isVisibleOnLockScreen: isVisibleOnLockScreen ?? this.isVisibleOnLockScreen,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EmergencyCardData copyWithCompanion(EmergencyCardCompanion data) {
    return EmergencyCardData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      bloodType: data.bloodType.present ? data.bloodType.value : this.bloodType,
      allergies: data.allergies.present ? data.allergies.value : this.allergies,
      conditions: data.conditions.present
          ? data.conditions.value
          : this.conditions,
      medications: data.medications.present
          ? data.medications.value
          : this.medications,
      emergencyContactName: data.emergencyContactName.present
          ? data.emergencyContactName.value
          : this.emergencyContactName,
      emergencyContactPhone: data.emergencyContactPhone.present
          ? data.emergencyContactPhone.value
          : this.emergencyContactPhone,
      notes: data.notes.present ? data.notes.value : this.notes,
      isVisibleOnLockScreen: data.isVisibleOnLockScreen.present
          ? data.isVisibleOnLockScreen.value
          : this.isVisibleOnLockScreen,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyCardData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('bloodType: $bloodType, ')
          ..write('allergies: $allergies, ')
          ..write('conditions: $conditions, ')
          ..write('medications: $medications, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('notes: $notes, ')
          ..write('isVisibleOnLockScreen: $isVisibleOnLockScreen, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    fullName,
    dateOfBirth,
    bloodType,
    allergies,
    conditions,
    medications,
    emergencyContactName,
    emergencyContactPhone,
    notes,
    isVisibleOnLockScreen,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyCardData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fullName == this.fullName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.bloodType == this.bloodType &&
          other.allergies == this.allergies &&
          other.conditions == this.conditions &&
          other.medications == this.medications &&
          other.emergencyContactName == this.emergencyContactName &&
          other.emergencyContactPhone == this.emergencyContactPhone &&
          other.notes == this.notes &&
          other.isVisibleOnLockScreen == this.isVisibleOnLockScreen &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EmergencyCardCompanion extends UpdateCompanion<EmergencyCardData> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> fullName;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> bloodType;
  final Value<String?> allergies;
  final Value<String?> conditions;
  final Value<String?> medications;
  final Value<String?> emergencyContactName;
  final Value<String?> emergencyContactPhone;
  final Value<String?> notes;
  final Value<bool> isVisibleOnLockScreen;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EmergencyCardCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.bloodType = const Value.absent(),
    this.allergies = const Value.absent(),
    this.conditions = const Value.absent(),
    this.medications = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVisibleOnLockScreen = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmergencyCardCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String fullName,
    this.dateOfBirth = const Value.absent(),
    this.bloodType = const Value.absent(),
    this.allergies = const Value.absent(),
    this.conditions = const Value.absent(),
    this.medications = const Value.absent(),
    this.emergencyContactName = const Value.absent(),
    this.emergencyContactPhone = const Value.absent(),
    this.notes = const Value.absent(),
    this.isVisibleOnLockScreen = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       fullName = Value(fullName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<EmergencyCardData> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? fullName,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? bloodType,
    Expression<String>? allergies,
    Expression<String>? conditions,
    Expression<String>? medications,
    Expression<String>? emergencyContactName,
    Expression<String>? emergencyContactPhone,
    Expression<String>? notes,
    Expression<bool>? isVisibleOnLockScreen,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fullName != null) 'full_name': fullName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (bloodType != null) 'blood_type': bloodType,
      if (allergies != null) 'allergies': allergies,
      if (conditions != null) 'conditions': conditions,
      if (medications != null) 'medications': medications,
      if (emergencyContactName != null)
        'emergency_contact_name': emergencyContactName,
      if (emergencyContactPhone != null)
        'emergency_contact_phone': emergencyContactPhone,
      if (notes != null) 'notes': notes,
      if (isVisibleOnLockScreen != null)
        'is_visible_on_lock_screen': isVisibleOnLockScreen,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmergencyCardCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? fullName,
    Value<DateTime?>? dateOfBirth,
    Value<String?>? bloodType,
    Value<String?>? allergies,
    Value<String?>? conditions,
    Value<String?>? medications,
    Value<String?>? emergencyContactName,
    Value<String?>? emergencyContactPhone,
    Value<String?>? notes,
    Value<bool>? isVisibleOnLockScreen,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EmergencyCardCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fullName: fullName ?? this.fullName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bloodType: bloodType ?? this.bloodType,
      allergies: allergies ?? this.allergies,
      conditions: conditions ?? this.conditions,
      medications: medications ?? this.medications,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone:
          emergencyContactPhone ?? this.emergencyContactPhone,
      notes: notes ?? this.notes,
      isVisibleOnLockScreen:
          isVisibleOnLockScreen ?? this.isVisibleOnLockScreen,
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
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (bloodType.present) {
      map['blood_type'] = Variable<String>(bloodType.value);
    }
    if (allergies.present) {
      map['allergies'] = Variable<String>(allergies.value);
    }
    if (conditions.present) {
      map['conditions'] = Variable<String>(conditions.value);
    }
    if (medications.present) {
      map['medications'] = Variable<String>(medications.value);
    }
    if (emergencyContactName.present) {
      map['emergency_contact_name'] = Variable<String>(
        emergencyContactName.value,
      );
    }
    if (emergencyContactPhone.present) {
      map['emergency_contact_phone'] = Variable<String>(
        emergencyContactPhone.value,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isVisibleOnLockScreen.present) {
      map['is_visible_on_lock_screen'] = Variable<bool>(
        isVisibleOnLockScreen.value,
      );
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
    return (StringBuffer('EmergencyCardCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fullName: $fullName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('bloodType: $bloodType, ')
          ..write('allergies: $allergies, ')
          ..write('conditions: $conditions, ')
          ..write('medications: $medications, ')
          ..write('emergencyContactName: $emergencyContactName, ')
          ..write('emergencyContactPhone: $emergencyContactPhone, ')
          ..write('notes: $notes, ')
          ..write('isVisibleOnLockScreen: $isVisibleOnLockScreen, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

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

class $PersonalRecordsTable extends PersonalRecords
    with TableInfo<$PersonalRecordsTable, PersonalRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonalRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordTypeMeta = const VerificationMeta(
    'recordType',
  );
  @override
  late final GeneratedColumn<String> recordType = GeneratedColumn<String>(
    'record_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _achievedAtMeta = const VerificationMeta(
    'achievedAt',
  );
  @override
  late final GeneratedColumn<DateTime> achievedAt = GeneratedColumn<DateTime>(
    'achieved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutLogIdMeta = const VerificationMeta(
    'workoutLogId',
  );
  @override
  late final GeneratedColumn<int> workoutLogId = GeneratedColumn<int>(
    'workout_log_id',
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
    exerciseName,
    recordType,
    value,
    unit,
    achievedAt,
    workoutLogId,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'personal_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<PersonalRecord> instance, {
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
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    if (data.containsKey('record_type')) {
      context.handle(
        _recordTypeMeta,
        recordType.isAcceptableOrUnknown(data['record_type']!, _recordTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_recordTypeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('achieved_at')) {
      context.handle(
        _achievedAtMeta,
        achievedAt.isAcceptableOrUnknown(data['achieved_at']!, _achievedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_achievedAtMeta);
    }
    if (data.containsKey('workout_log_id')) {
      context.handle(
        _workoutLogIdMeta,
        workoutLogId.isAcceptableOrUnknown(
          data['workout_log_id']!,
          _workoutLogIdMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
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
  PersonalRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PersonalRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      )!,
      recordType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_type'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      achievedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}achieved_at'],
      )!,
      workoutLogId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}workout_log_id'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
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
  $PersonalRecordsTable createAlias(String alias) {
    return $PersonalRecordsTable(attachedDatabase, alias);
  }
}

class PersonalRecord extends DataClass implements Insertable<PersonalRecord> {
  final int id;
  final String userId;
  final String exerciseName;
  final String recordType;
  final double value;
  final String unit;
  final DateTime achievedAt;
  final int? workoutLogId;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const PersonalRecord({
    required this.id,
    required this.userId,
    required this.exerciseName,
    required this.recordType,
    required this.value,
    required this.unit,
    required this.achievedAt,
    this.workoutLogId,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<String>(userId);
    map['exercise_name'] = Variable<String>(exerciseName);
    map['record_type'] = Variable<String>(recordType);
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    map['achieved_at'] = Variable<DateTime>(achievedAt);
    if (!nullToAbsent || workoutLogId != null) {
      map['workout_log_id'] = Variable<int>(workoutLogId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PersonalRecordsCompanion toCompanion(bool nullToAbsent) {
    return PersonalRecordsCompanion(
      id: Value(id),
      userId: Value(userId),
      exerciseName: Value(exerciseName),
      recordType: Value(recordType),
      value: Value(value),
      unit: Value(unit),
      achievedAt: Value(achievedAt),
      workoutLogId: workoutLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(workoutLogId),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory PersonalRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PersonalRecord(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
      recordType: serializer.fromJson<String>(json['recordType']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      achievedAt: serializer.fromJson<DateTime>(json['achievedAt']),
      workoutLogId: serializer.fromJson<int?>(json['workoutLogId']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'exerciseName': serializer.toJson<String>(exerciseName),
      'recordType': serializer.toJson<String>(recordType),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'achievedAt': serializer.toJson<DateTime>(achievedAt),
      'workoutLogId': serializer.toJson<int?>(workoutLogId),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PersonalRecord copyWith({
    int? id,
    String? userId,
    String? exerciseName,
    String? recordType,
    double? value,
    String? unit,
    DateTime? achievedAt,
    Value<int?> workoutLogId = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => PersonalRecord(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    exerciseName: exerciseName ?? this.exerciseName,
    recordType: recordType ?? this.recordType,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    achievedAt: achievedAt ?? this.achievedAt,
    workoutLogId: workoutLogId.present ? workoutLogId.value : this.workoutLogId,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PersonalRecord copyWithCompanion(PersonalRecordsCompanion data) {
    return PersonalRecord(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      recordType: data.recordType.present
          ? data.recordType.value
          : this.recordType,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      achievedAt: data.achievedAt.present
          ? data.achievedAt.value
          : this.achievedAt,
      workoutLogId: data.workoutLogId.present
          ? data.workoutLogId.value
          : this.workoutLogId,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PersonalRecord(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('recordType: $recordType, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('workoutLogId: $workoutLogId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    exerciseName,
    recordType,
    value,
    unit,
    achievedAt,
    workoutLogId,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PersonalRecord &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.exerciseName == this.exerciseName &&
          other.recordType == this.recordType &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.achievedAt == this.achievedAt &&
          other.workoutLogId == this.workoutLogId &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class PersonalRecordsCompanion extends UpdateCompanion<PersonalRecord> {
  final Value<int> id;
  final Value<String> userId;
  final Value<String> exerciseName;
  final Value<String> recordType;
  final Value<double> value;
  final Value<String> unit;
  final Value<DateTime> achievedAt;
  final Value<int?> workoutLogId;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const PersonalRecordsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.recordType = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.achievedAt = const Value.absent(),
    this.workoutLogId = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PersonalRecordsCompanion.insert({
    this.id = const Value.absent(),
    required String userId,
    required String exerciseName,
    required String recordType,
    required double value,
    required String unit,
    required DateTime achievedAt,
    this.workoutLogId = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : userId = Value(userId),
       exerciseName = Value(exerciseName),
       recordType = Value(recordType),
       value = Value(value),
       unit = Value(unit),
       achievedAt = Value(achievedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<PersonalRecord> custom({
    Expression<int>? id,
    Expression<String>? userId,
    Expression<String>? exerciseName,
    Expression<String>? recordType,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<DateTime>? achievedAt,
    Expression<int>? workoutLogId,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (recordType != null) 'record_type': recordType,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (achievedAt != null) 'achieved_at': achievedAt,
      if (workoutLogId != null) 'workout_log_id': workoutLogId,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PersonalRecordsCompanion copyWith({
    Value<int>? id,
    Value<String>? userId,
    Value<String>? exerciseName,
    Value<String>? recordType,
    Value<double>? value,
    Value<String>? unit,
    Value<DateTime>? achievedAt,
    Value<int?>? workoutLogId,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return PersonalRecordsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseName: exerciseName ?? this.exerciseName,
      recordType: recordType ?? this.recordType,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      achievedAt: achievedAt ?? this.achievedAt,
      workoutLogId: workoutLogId ?? this.workoutLogId,
      notes: notes ?? this.notes,
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
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (recordType.present) {
      map['record_type'] = Variable<String>(recordType.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (achievedAt.present) {
      map['achieved_at'] = Variable<DateTime>(achievedAt.value);
    }
    if (workoutLogId.present) {
      map['workout_log_id'] = Variable<int>(workoutLogId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('PersonalRecordsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('recordType: $recordType, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('achievedAt: $achievedAt, ')
          ..write('workoutLogId: $workoutLogId, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _syncTableMeta = const VerificationMeta(
    'syncTable',
  );
  @override
  late final GeneratedColumn<String> syncTable = GeneratedColumn<String>(
    'sync_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
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
  static const VerificationMeta _lastAttemptAtMeta = const VerificationMeta(
    'lastAttemptAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttemptAt =
      GeneratedColumn<DateTime>(
        'last_attempt_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    syncTable,
    recordId,
    operation,
    payload,
    status,
    retryCount,
    createdAt,
    lastAttemptAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_table')) {
      context.handle(
        _syncTableMeta,
        syncTable.isAcceptableOrUnknown(data['sync_table']!, _syncTableMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
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
    if (data.containsKey('last_attempt_at')) {
      context.handle(
        _lastAttemptAtMeta,
        lastAttemptAt.isAcceptableOrUnknown(
          data['last_attempt_at']!,
          _lastAttemptAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttemptAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt_at'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String syncTable;
  final int recordId;
  final String operation;
  final String payload;
  final String status;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttemptAt;
  const SyncQueueData({
    required this.id,
    required this.syncTable,
    required this.recordId,
    required this.operation,
    required this.payload,
    required this.status,
    required this.retryCount,
    required this.createdAt,
    this.lastAttemptAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_table'] = Variable<String>(syncTable);
    map['record_id'] = Variable<int>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttemptAt != null) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      syncTable: Value(syncTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttemptAt: lastAttemptAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttemptAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      syncTable: serializer.fromJson<String>(json['syncTable']),
      recordId: serializer.fromJson<int>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttemptAt: serializer.fromJson<DateTime?>(json['lastAttemptAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncTable': serializer.toJson<String>(syncTable),
      'recordId': serializer.toJson<int>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttemptAt': serializer.toJson<DateTime?>(lastAttemptAt),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? syncTable,
    int? recordId,
    String? operation,
    String? payload,
    String? status,
    int? retryCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttemptAt = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    syncTable: syncTable ?? this.syncTable,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttemptAt: lastAttemptAt.present
        ? lastAttemptAt.value
        : this.lastAttemptAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      syncTable: data.syncTable.present ? data.syncTable.value : this.syncTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttemptAt: data.lastAttemptAt.present
          ? data.lastAttemptAt.value
          : this.lastAttemptAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('syncTable: $syncTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTable,
    recordId,
    operation,
    payload,
    status,
    retryCount,
    createdAt,
    lastAttemptAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.syncTable == this.syncTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttemptAt == this.lastAttemptAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> syncTable;
  final Value<int> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttemptAt;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.syncTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttemptAt = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String syncTable,
    required int recordId,
    required String operation,
    required String payload,
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    required DateTime createdAt,
    this.lastAttemptAt = const Value.absent(),
  }) : syncTable = Value(syncTable),
       recordId = Value(recordId),
       operation = Value(operation),
       payload = Value(payload),
       createdAt = Value(createdAt);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? syncTable,
    Expression<int>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttemptAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTable != null) 'sync_table': syncTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttemptAt != null) 'last_attempt_at': lastAttemptAt,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? syncTable,
    Value<int>? recordId,
    Value<String>? operation,
    Value<String>? payload,
    Value<String>? status,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttemptAt,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      syncTable: syncTable ?? this.syncTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttemptAt: lastAttemptAt ?? this.lastAttemptAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTable.present) {
      map['sync_table'] = Variable<String>(syncTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttemptAt.present) {
      map['last_attempt_at'] = Variable<DateTime>(lastAttemptAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('syncTable: $syncTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttemptAt: $lastAttemptAt')
          ..write(')'))
        .toString();
  }
}

class $SyncDeadLetterTable extends SyncDeadLetter
    with TableInfo<$SyncDeadLetterTable, SyncDeadLetterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncDeadLetterTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _syncTableMeta = const VerificationMeta(
    'syncTable',
  );
  @override
  late final GeneratedColumn<String> syncTable = GeneratedColumn<String>(
    'sync_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<int> recordId = GeneratedColumn<int>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _originalRetryCountMeta =
      const VerificationMeta('originalRetryCount');
  @override
  late final GeneratedColumn<int> originalRetryCount = GeneratedColumn<int>(
    'original_retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    syncTable,
    recordId,
    operation,
    payload,
    errorMessage,
    originalRetryCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_dead_letter';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncDeadLetterData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sync_table')) {
      context.handle(
        _syncTableMeta,
        syncTable.isAcceptableOrUnknown(data['sync_table']!, _syncTableMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTableMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('original_retry_count')) {
      context.handle(
        _originalRetryCountMeta,
        originalRetryCount.isAcceptableOrUnknown(
          data['original_retry_count']!,
          _originalRetryCountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalRetryCountMeta);
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
  SyncDeadLetterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncDeadLetterData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      syncTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_table'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      originalRetryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}original_retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncDeadLetterTable createAlias(String alias) {
    return $SyncDeadLetterTable(attachedDatabase, alias);
  }
}

class SyncDeadLetterData extends DataClass
    implements Insertable<SyncDeadLetterData> {
  final int id;
  final String syncTable;
  final int recordId;
  final String operation;
  final String payload;
  final String? errorMessage;
  final int originalRetryCount;
  final DateTime createdAt;
  const SyncDeadLetterData({
    required this.id,
    required this.syncTable,
    required this.recordId,
    required this.operation,
    required this.payload,
    this.errorMessage,
    required this.originalRetryCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sync_table'] = Variable<String>(syncTable);
    map['record_id'] = Variable<int>(recordId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['original_retry_count'] = Variable<int>(originalRetryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncDeadLetterCompanion toCompanion(bool nullToAbsent) {
    return SyncDeadLetterCompanion(
      id: Value(id),
      syncTable: Value(syncTable),
      recordId: Value(recordId),
      operation: Value(operation),
      payload: Value(payload),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      originalRetryCount: Value(originalRetryCount),
      createdAt: Value(createdAt),
    );
  }

  factory SyncDeadLetterData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncDeadLetterData(
      id: serializer.fromJson<int>(json['id']),
      syncTable: serializer.fromJson<String>(json['syncTable']),
      recordId: serializer.fromJson<int>(json['recordId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      originalRetryCount: serializer.fromJson<int>(json['originalRetryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'syncTable': serializer.toJson<String>(syncTable),
      'recordId': serializer.toJson<int>(recordId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'originalRetryCount': serializer.toJson<int>(originalRetryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncDeadLetterData copyWith({
    int? id,
    String? syncTable,
    int? recordId,
    String? operation,
    String? payload,
    Value<String?> errorMessage = const Value.absent(),
    int? originalRetryCount,
    DateTime? createdAt,
  }) => SyncDeadLetterData(
    id: id ?? this.id,
    syncTable: syncTable ?? this.syncTable,
    recordId: recordId ?? this.recordId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    originalRetryCount: originalRetryCount ?? this.originalRetryCount,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncDeadLetterData copyWithCompanion(SyncDeadLetterCompanion data) {
    return SyncDeadLetterData(
      id: data.id.present ? data.id.value : this.id,
      syncTable: data.syncTable.present ? data.syncTable.value : this.syncTable,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      originalRetryCount: data.originalRetryCount.present
          ? data.originalRetryCount.value
          : this.originalRetryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncDeadLetterData(')
          ..write('id: $id, ')
          ..write('syncTable: $syncTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('originalRetryCount: $originalRetryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    syncTable,
    recordId,
    operation,
    payload,
    errorMessage,
    originalRetryCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncDeadLetterData &&
          other.id == this.id &&
          other.syncTable == this.syncTable &&
          other.recordId == this.recordId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.errorMessage == this.errorMessage &&
          other.originalRetryCount == this.originalRetryCount &&
          other.createdAt == this.createdAt);
}

class SyncDeadLetterCompanion extends UpdateCompanion<SyncDeadLetterData> {
  final Value<int> id;
  final Value<String> syncTable;
  final Value<int> recordId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<String?> errorMessage;
  final Value<int> originalRetryCount;
  final Value<DateTime> createdAt;
  const SyncDeadLetterCompanion({
    this.id = const Value.absent(),
    this.syncTable = const Value.absent(),
    this.recordId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.originalRetryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SyncDeadLetterCompanion.insert({
    this.id = const Value.absent(),
    required String syncTable,
    required int recordId,
    required String operation,
    required String payload,
    this.errorMessage = const Value.absent(),
    required int originalRetryCount,
    required DateTime createdAt,
  }) : syncTable = Value(syncTable),
       recordId = Value(recordId),
       operation = Value(operation),
       payload = Value(payload),
       originalRetryCount = Value(originalRetryCount),
       createdAt = Value(createdAt);
  static Insertable<SyncDeadLetterData> custom({
    Expression<int>? id,
    Expression<String>? syncTable,
    Expression<int>? recordId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? errorMessage,
    Expression<int>? originalRetryCount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (syncTable != null) 'sync_table': syncTable,
      if (recordId != null) 'record_id': recordId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (errorMessage != null) 'error_message': errorMessage,
      if (originalRetryCount != null)
        'original_retry_count': originalRetryCount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SyncDeadLetterCompanion copyWith({
    Value<int>? id,
    Value<String>? syncTable,
    Value<int>? recordId,
    Value<String>? operation,
    Value<String>? payload,
    Value<String?>? errorMessage,
    Value<int>? originalRetryCount,
    Value<DateTime>? createdAt,
  }) {
    return SyncDeadLetterCompanion(
      id: id ?? this.id,
      syncTable: syncTable ?? this.syncTable,
      recordId: recordId ?? this.recordId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      errorMessage: errorMessage ?? this.errorMessage,
      originalRetryCount: originalRetryCount ?? this.originalRetryCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (syncTable.present) {
      map['sync_table'] = Variable<String>(syncTable.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<int>(recordId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (originalRetryCount.present) {
      map['original_retry_count'] = Variable<int>(originalRetryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncDeadLetterCompanion(')
          ..write('id: $id, ')
          ..write('syncTable: $syncTable, ')
          ..write('recordId: $recordId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('originalRetryCount: $originalRetryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodLogsTable foodLogs = $FoodLogsTable(this);
  late final $FoodItemsTable foodItems = $FoodItemsTable(this);
  late final $WorkoutLogsTable workoutLogs = $WorkoutLogsTable(this);
  late final $StepLogsTable stepLogs = $StepLogsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $MoodLogsTable moodLogs = $MoodLogsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitCompletionsTable habitCompletions = $HabitCompletionsTable(
    this,
  );
  late final $BodyMeasurementsTable bodyMeasurements = $BodyMeasurementsTable(
    this,
  );
  late final $MedicationsTable medications = $MedicationsTable(this);
  late final $FastingLogsTable fastingLogs = $FastingLogsTable(this);
  late final $MealPlansTable mealPlans = $MealPlansTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $BloodPressureLogsTable bloodPressureLogs =
      $BloodPressureLogsTable(this);
  late final $GlucoseLogsTable glucoseLogs = $GlucoseLogsTable(this);
  late final $Spo2LogsTable spo2Logs = $Spo2LogsTable(this);
  late final $PeriodLogsTable periodLogs = $PeriodLogsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $DoctorAppointmentsTable doctorAppointments =
      $DoctorAppointmentsTable(this);
  late final $LabReportsTable labReports = $LabReportsTable(this);
  late final $AbhaLinksTable abhaLinks = $AbhaLinksTable(this);
  late final $EmergencyCardTable emergencyCard = $EmergencyCardTable(this);
  late final $FestivalCalendarTable festivalCalendar = $FestivalCalendarTable(
    this,
  );
  late final $RemoteConfigCacheTable remoteConfigCache =
      $RemoteConfigCacheTable(this);
  late final $KarmaTransactionsTable karmaTransactions =
      $KarmaTransactionsTable(this);
  late final $NutritionGoalsTable nutritionGoals = $NutritionGoalsTable(this);
  late final $PersonalRecordsTable personalRecords = $PersonalRecordsTable(
    this,
  );
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SyncDeadLetterTable syncDeadLetter = $SyncDeadLetterTable(this);
  late final FoodLogsDao foodLogsDao = FoodLogsDao(this as AppDatabase);
  late final FoodItemsDao foodItemsDao = FoodItemsDao(this as AppDatabase);
  late final WorkoutLogsDao workoutLogsDao = WorkoutLogsDao(
    this as AppDatabase,
  );
  late final StepLogsDao stepLogsDao = StepLogsDao(this as AppDatabase);
  late final SleepLogsDao sleepLogsDao = SleepLogsDao(this as AppDatabase);
  late final MoodLogsDao moodLogsDao = MoodLogsDao(this as AppDatabase);
  late final HabitsDao habitsDao = HabitsDao(this as AppDatabase);
  late final BodyMeasurementsDao bodyMeasurementsDao = BodyMeasurementsDao(
    this as AppDatabase,
  );
  late final MedicationsDao medicationsDao = MedicationsDao(
    this as AppDatabase,
  );
  late final FastingLogsDao fastingLogsDao = FastingLogsDao(
    this as AppDatabase,
  );
  late final MealPlansDao mealPlansDao = MealPlansDao(this as AppDatabase);
  late final RecipesDao recipesDao = RecipesDao(this as AppDatabase);
  late final BloodPressureLogsDao bloodPressureLogsDao = BloodPressureLogsDao(
    this as AppDatabase,
  );
  late final GlucoseLogsDao glucoseLogsDao = GlucoseLogsDao(
    this as AppDatabase,
  );
  late final Spo2LogsDao spo2LogsDao = Spo2LogsDao(this as AppDatabase);
  late final PeriodLogsDao periodLogsDao = PeriodLogsDao(this as AppDatabase);
  late final JournalEntriesDao journalEntriesDao = JournalEntriesDao(
    this as AppDatabase,
  );
  late final DoctorAppointmentsDao doctorAppointmentsDao =
      DoctorAppointmentsDao(this as AppDatabase);
  late final LabReportsDao labReportsDao = LabReportsDao(this as AppDatabase);
  late final AbhaLinksDao abhaLinksDao = AbhaLinksDao(this as AppDatabase);
  late final EmergencyCardDao emergencyCardDao = EmergencyCardDao(
    this as AppDatabase,
  );
  late final FestivalCalendarDao festivalCalendarDao = FestivalCalendarDao(
    this as AppDatabase,
  );
  late final RemoteConfigCacheDao remoteConfigCacheDao = RemoteConfigCacheDao(
    this as AppDatabase,
  );
  late final KarmaTransactionsDao karmaTransactionsDao = KarmaTransactionsDao(
    this as AppDatabase,
  );
  late final NutritionGoalsDao nutritionGoalsDao = NutritionGoalsDao(
    this as AppDatabase,
  );
  late final PersonalRecordsDao personalRecordsDao = PersonalRecordsDao(
    this as AppDatabase,
  );
  late final SyncQueueDao syncQueueDao = SyncQueueDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    foodLogs,
    foodItems,
    workoutLogs,
    stepLogs,
    sleepLogs,
    moodLogs,
    habits,
    habitCompletions,
    bodyMeasurements,
    medications,
    fastingLogs,
    mealPlans,
    recipes,
    bloodPressureLogs,
    glucoseLogs,
    spo2Logs,
    periodLogs,
    journalEntries,
    doctorAppointments,
    labReports,
    abhaLinks,
    emergencyCard,
    festivalCalendar,
    remoteConfigCache,
    karmaTransactions,
    nutritionGoals,
    personalRecords,
    syncQueue,
    syncDeadLetter,
  ];
}

typedef $$FoodLogsTableCreateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String mealType,
      required String foodName,
      required double quantity,
      required String unit,
      required int calories,
      Value<double?> protein,
      Value<double?> carbs,
      Value<double?> fat,
      Value<double?> fiber,
      required DateTime loggedAt,
      Value<String?> notes,
      Value<String?> imageUrl,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$FoodLogsTableUpdateCompanionBuilder =
    FoodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> mealType,
      Value<String> foodName,
      Value<double> quantity,
      Value<String> unit,
      Value<int> calories,
      Value<double?> protein,
      Value<double?> carbs,
      Value<double?> fat,
      Value<double?> fiber,
      Value<DateTime> loggedAt,
      Value<String?> notes,
      Value<String?> imageUrl,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$FoodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableFilterComposer({
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

  ColumnFilters<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

class $$FoodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableOrderingComposer({
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

  ColumnOrderings<String> get mealType => $composableBuilder(
    column: $table.mealType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get foodName => $composableBuilder(
    column: $table.foodName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get calories => $composableBuilder(
    column: $table.calories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get protein => $composableBuilder(
    column: $table.protein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbs => $composableBuilder(
    column: $table.carbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fat => $composableBuilder(
    column: $table.fat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiber => $composableBuilder(
    column: $table.fiber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
    column: $table.loggedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
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

class $$FoodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodLogsTable> {
  $$FoodLogsTableAnnotationComposer({
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

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get fiber =>
      $composableBuilder(column: $table.fiber, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FoodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodLogsTable,
          FoodLog,
          $$FoodLogsTableFilterComposer,
          $$FoodLogsTableOrderingComposer,
          $$FoodLogsTableAnnotationComposer,
          $$FoodLogsTableCreateCompanionBuilder,
          $$FoodLogsTableUpdateCompanionBuilder,
          (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
          FoodLog,
          PrefetchHooks Function()
        > {
  $$FoodLogsTableTableManager(_$AppDatabase db, $FoodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> mealType = const Value.absent(),
                Value<String> foodName = const Value.absent(),
                Value<double> quantity = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> calories = const Value.absent(),
                Value<double?> protein = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FoodLogsCompanion(
                id: id,
                userId: userId,
                mealType: mealType,
                foodName: foodName,
                quantity: quantity,
                unit: unit,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fat: fat,
                fiber: fiber,
                loggedAt: loggedAt,
                notes: notes,
                imageUrl: imageUrl,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String mealType,
                required String foodName,
                required double quantity,
                required String unit,
                required int calories,
                Value<double?> protein = const Value.absent(),
                Value<double?> carbs = const Value.absent(),
                Value<double?> fat = const Value.absent(),
                Value<double?> fiber = const Value.absent(),
                required DateTime loggedAt,
                Value<String?> notes = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => FoodLogsCompanion.insert(
                id: id,
                userId: userId,
                mealType: mealType,
                foodName: foodName,
                quantity: quantity,
                unit: unit,
                calories: calories,
                protein: protein,
                carbs: carbs,
                fat: fat,
                fiber: fiber,
                loggedAt: loggedAt,
                notes: notes,
                imageUrl: imageUrl,
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

typedef $$FoodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodLogsTable,
      FoodLog,
      $$FoodLogsTableFilterComposer,
      $$FoodLogsTableOrderingComposer,
      $$FoodLogsTableAnnotationComposer,
      $$FoodLogsTableCreateCompanionBuilder,
      $$FoodLogsTableUpdateCompanionBuilder,
      (FoodLog, BaseReferences<_$AppDatabase, $FoodLogsTable, FoodLog>),
      FoodLog,
      PrefetchHooks Function()
    >;
typedef $$FoodItemsTableCreateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> brand,
      Value<String?> barcode,
      required int caloriesPer100g,
      required double proteinPer100g,
      required double carbsPer100g,
      required double fatPer100g,
      Value<double?> fiberPer100g,
      Value<double?> servingSize,
      Value<String?> servingUnit,
      Value<String?> category,
      Value<bool> isUserCreated,
      Value<bool> isVerified,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$FoodItemsTableUpdateCompanionBuilder =
    FoodItemsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> brand,
      Value<String?> barcode,
      Value<int> caloriesPer100g,
      Value<double> proteinPer100g,
      Value<double> carbsPer100g,
      Value<double> fatPer100g,
      Value<double?> fiberPer100g,
      Value<double?> servingSize,
      Value<String?> servingUnit,
      Value<String?> category,
      Value<bool> isUserCreated,
      Value<bool> isVerified,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$FoodItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableFilterComposer({
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

  ColumnFilters<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fiberPer100g => $composableBuilder(
    column: $table.fiberPer100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
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

class $$FoodItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableOrderingComposer({
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

  ColumnOrderings<String> get brand => $composableBuilder(
    column: $table.brand,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fiberPer100g => $composableBuilder(
    column: $table.fiberPer100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
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

class $$FoodItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodItemsTable> {
  $$FoodItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<int> get caloriesPer100g => $composableBuilder(
    column: $table.caloriesPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPer100g => $composableBuilder(
    column: $table.proteinPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPer100g => $composableBuilder(
    column: $table.carbsPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPer100g => $composableBuilder(
    column: $table.fatPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fiberPer100g => $composableBuilder(
    column: $table.fiberPer100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get servingSize => $composableBuilder(
    column: $table.servingSize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get servingUnit => $composableBuilder(
    column: $table.servingUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isUserCreated => $composableBuilder(
    column: $table.isUserCreated,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isVerified => $composableBuilder(
    column: $table.isVerified,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FoodItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodItemsTable,
          FoodItem,
          $$FoodItemsTableFilterComposer,
          $$FoodItemsTableOrderingComposer,
          $$FoodItemsTableAnnotationComposer,
          $$FoodItemsTableCreateCompanionBuilder,
          $$FoodItemsTableUpdateCompanionBuilder,
          (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
          FoodItem,
          PrefetchHooks Function()
        > {
  $$FoodItemsTableTableManager(_$AppDatabase db, $FoodItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<int> caloriesPer100g = const Value.absent(),
                Value<double> proteinPer100g = const Value.absent(),
                Value<double> carbsPer100g = const Value.absent(),
                Value<double> fatPer100g = const Value.absent(),
                Value<double?> fiberPer100g = const Value.absent(),
                Value<double?> servingSize = const Value.absent(),
                Value<String?> servingUnit = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FoodItemsCompanion(
                id: id,
                name: name,
                brand: brand,
                barcode: barcode,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                fiberPer100g: fiberPer100g,
                servingSize: servingSize,
                servingUnit: servingUnit,
                category: category,
                isUserCreated: isUserCreated,
                isVerified: isVerified,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> brand = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                required int caloriesPer100g,
                required double proteinPer100g,
                required double carbsPer100g,
                required double fatPer100g,
                Value<double?> fiberPer100g = const Value.absent(),
                Value<double?> servingSize = const Value.absent(),
                Value<String?> servingUnit = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isUserCreated = const Value.absent(),
                Value<bool> isVerified = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => FoodItemsCompanion.insert(
                id: id,
                name: name,
                brand: brand,
                barcode: barcode,
                caloriesPer100g: caloriesPer100g,
                proteinPer100g: proteinPer100g,
                carbsPer100g: carbsPer100g,
                fatPer100g: fatPer100g,
                fiberPer100g: fiberPer100g,
                servingSize: servingSize,
                servingUnit: servingUnit,
                category: category,
                isUserCreated: isUserCreated,
                isVerified: isVerified,
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

typedef $$FoodItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodItemsTable,
      FoodItem,
      $$FoodItemsTableFilterComposer,
      $$FoodItemsTableOrderingComposer,
      $$FoodItemsTableAnnotationComposer,
      $$FoodItemsTableCreateCompanionBuilder,
      $$FoodItemsTableUpdateCompanionBuilder,
      (FoodItem, BaseReferences<_$AppDatabase, $FoodItemsTable, FoodItem>),
      FoodItem,
      PrefetchHooks Function()
    >;
typedef $$WorkoutLogsTableCreateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String workoutType,
      required String exerciseName,
      required int durationMinutes,
      Value<int?> caloriesBurned,
      Value<int?> intensity,
      Value<int?> heartRateAvg,
      Value<int?> heartRateMax,
      Value<int?> sets,
      Value<int?> reps,
      Value<double?> weight,
      Value<String?> notes,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$WorkoutLogsTableUpdateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> workoutType,
      Value<String> exerciseName,
      Value<int> durationMinutes,
      Value<int?> caloriesBurned,
      Value<int?> intensity,
      Value<int?> heartRateAvg,
      Value<int?> heartRateMax,
      Value<int?> sets,
      Value<int?> reps,
      Value<double?> weight,
      Value<String?> notes,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$WorkoutLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableFilterComposer({
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

  ColumnFilters<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateAvg => $composableBuilder(
    column: $table.heartRateAvg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get heartRateMax => $composableBuilder(
    column: $table.heartRateMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
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

class $$WorkoutLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableOrderingComposer({
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

  ColumnOrderings<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intensity => $composableBuilder(
    column: $table.intensity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateAvg => $composableBuilder(
    column: $table.heartRateAvg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get heartRateMax => $composableBuilder(
    column: $table.heartRateMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sets => $composableBuilder(
    column: $table.sets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
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

class $$WorkoutLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableAnnotationComposer({
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

  GeneratedColumn<String> get workoutType => $composableBuilder(
    column: $table.workoutType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
    column: $table.caloriesBurned,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<int> get heartRateAvg => $composableBuilder(
    column: $table.heartRateAvg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get heartRateMax => $composableBuilder(
    column: $table.heartRateMax,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sets =>
      $composableBuilder(column: $table.sets, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WorkoutLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutLogsTable,
          WorkoutLog,
          $$WorkoutLogsTableFilterComposer,
          $$WorkoutLogsTableOrderingComposer,
          $$WorkoutLogsTableAnnotationComposer,
          $$WorkoutLogsTableCreateCompanionBuilder,
          $$WorkoutLogsTableUpdateCompanionBuilder,
          (
            WorkoutLog,
            BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>,
          ),
          WorkoutLog,
          PrefetchHooks Function()
        > {
  $$WorkoutLogsTableTableManager(_$AppDatabase db, $WorkoutLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> workoutType = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<int?> caloriesBurned = const Value.absent(),
                Value<int?> intensity = const Value.absent(),
                Value<int?> heartRateAvg = const Value.absent(),
                Value<int?> heartRateMax = const Value.absent(),
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => WorkoutLogsCompanion(
                id: id,
                userId: userId,
                workoutType: workoutType,
                exerciseName: exerciseName,
                durationMinutes: durationMinutes,
                caloriesBurned: caloriesBurned,
                intensity: intensity,
                heartRateAvg: heartRateAvg,
                heartRateMax: heartRateMax,
                sets: sets,
                reps: reps,
                weight: weight,
                notes: notes,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String workoutType,
                required String exerciseName,
                required int durationMinutes,
                Value<int?> caloriesBurned = const Value.absent(),
                Value<int?> intensity = const Value.absent(),
                Value<int?> heartRateAvg = const Value.absent(),
                Value<int?> heartRateMax = const Value.absent(),
                Value<int?> sets = const Value.absent(),
                Value<int?> reps = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => WorkoutLogsCompanion.insert(
                id: id,
                userId: userId,
                workoutType: workoutType,
                exerciseName: exerciseName,
                durationMinutes: durationMinutes,
                caloriesBurned: caloriesBurned,
                intensity: intensity,
                heartRateAvg: heartRateAvg,
                heartRateMax: heartRateMax,
                sets: sets,
                reps: reps,
                weight: weight,
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

typedef $$WorkoutLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutLogsTable,
      WorkoutLog,
      $$WorkoutLogsTableFilterComposer,
      $$WorkoutLogsTableOrderingComposer,
      $$WorkoutLogsTableAnnotationComposer,
      $$WorkoutLogsTableCreateCompanionBuilder,
      $$WorkoutLogsTableUpdateCompanionBuilder,
      (
        WorkoutLog,
        BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog>,
      ),
      WorkoutLog,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $StepLogsTable> {
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
    extends Composer<_$AppDatabase, $StepLogsTable> {
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
    extends Composer<_$AppDatabase, $StepLogsTable> {
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
          _$AppDatabase,
          $StepLogsTable,
          StepLog,
          $$StepLogsTableFilterComposer,
          $$StepLogsTableOrderingComposer,
          $$StepLogsTableAnnotationComposer,
          $$StepLogsTableCreateCompanionBuilder,
          $$StepLogsTableUpdateCompanionBuilder,
          (StepLog, BaseReferences<_$AppDatabase, $StepLogsTable, StepLog>),
          StepLog,
          PrefetchHooks Function()
        > {
  $$StepLogsTableTableManager(_$AppDatabase db, $StepLogsTable table)
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
      _$AppDatabase,
      $StepLogsTable,
      StepLog,
      $$StepLogsTableFilterComposer,
      $$StepLogsTableOrderingComposer,
      $$StepLogsTableAnnotationComposer,
      $$StepLogsTableCreateCompanionBuilder,
      $$StepLogsTableUpdateCompanionBuilder,
      (StepLog, BaseReferences<_$AppDatabase, $StepLogsTable, StepLog>),
      StepLog,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime sleepStart,
      required DateTime sleepEnd,
      required int durationMinutes,
      Value<int?> quality,
      Value<int?> deepSleepMinutes,
      Value<int?> remSleepMinutes,
      Value<int?> lightSleepMinutes,
      Value<int?> awakeMinutes,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$SleepLogsTableUpdateCompanionBuilder =
    SleepLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> sleepStart,
      Value<DateTime> sleepEnd,
      Value<int> durationMinutes,
      Value<int?> quality,
      Value<int?> deepSleepMinutes,
      Value<int?> remSleepMinutes,
      Value<int?> lightSleepMinutes,
      Value<int?> awakeMinutes,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sleepEnd => $composableBuilder(
    column: $table.sleepEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get deepSleepMinutes => $composableBuilder(
    column: $table.deepSleepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remSleepMinutes => $composableBuilder(
    column: $table.remSleepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lightSleepMinutes => $composableBuilder(
    column: $table.lightSleepMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sleepEnd => $composableBuilder(
    column: $table.sleepEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get deepSleepMinutes => $composableBuilder(
    column: $table.deepSleepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remSleepMinutes => $composableBuilder(
    column: $table.remSleepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lightSleepMinutes => $composableBuilder(
    column: $table.lightSleepMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get sleepStart => $composableBuilder(
    column: $table.sleepStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sleepEnd =>
      $composableBuilder(column: $table.sleepEnd, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<int> get deepSleepMinutes => $composableBuilder(
    column: $table.deepSleepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remSleepMinutes => $composableBuilder(
    column: $table.remSleepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lightSleepMinutes => $composableBuilder(
    column: $table.lightSleepMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awakeMinutes => $composableBuilder(
    column: $table.awakeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> sleepStart = const Value.absent(),
                Value<DateTime> sleepEnd = const Value.absent(),
                Value<int> durationMinutes = const Value.absent(),
                Value<int?> quality = const Value.absent(),
                Value<int?> deepSleepMinutes = const Value.absent(),
                Value<int?> remSleepMinutes = const Value.absent(),
                Value<int?> lightSleepMinutes = const Value.absent(),
                Value<int?> awakeMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                userId: userId,
                sleepStart: sleepStart,
                sleepEnd: sleepEnd,
                durationMinutes: durationMinutes,
                quality: quality,
                deepSleepMinutes: deepSleepMinutes,
                remSleepMinutes: remSleepMinutes,
                lightSleepMinutes: lightSleepMinutes,
                awakeMinutes: awakeMinutes,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime sleepStart,
                required DateTime sleepEnd,
                required int durationMinutes,
                Value<int?> quality = const Value.absent(),
                Value<int?> deepSleepMinutes = const Value.absent(),
                Value<int?> remSleepMinutes = const Value.absent(),
                Value<int?> lightSleepMinutes = const Value.absent(),
                Value<int?> awakeMinutes = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => SleepLogsCompanion.insert(
                id: id,
                userId: userId,
                sleepStart: sleepStart,
                sleepEnd: sleepEnd,
                durationMinutes: durationMinutes,
                quality: quality,
                deepSleepMinutes: deepSleepMinutes,
                remSleepMinutes: remSleepMinutes,
                lightSleepMinutes: lightSleepMinutes,
                awakeMinutes: awakeMinutes,
                notes: notes,
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

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $MoodLogsTable> {
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
    extends Composer<_$AppDatabase, $MoodLogsTable> {
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
    extends Composer<_$AppDatabase, $MoodLogsTable> {
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
          _$AppDatabase,
          $MoodLogsTable,
          MoodLog,
          $$MoodLogsTableFilterComposer,
          $$MoodLogsTableOrderingComposer,
          $$MoodLogsTableAnnotationComposer,
          $$MoodLogsTableCreateCompanionBuilder,
          $$MoodLogsTableUpdateCompanionBuilder,
          (MoodLog, BaseReferences<_$AppDatabase, $MoodLogsTable, MoodLog>),
          MoodLog,
          PrefetchHooks Function()
        > {
  $$MoodLogsTableTableManager(_$AppDatabase db, $MoodLogsTable table)
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
      _$AppDatabase,
      $MoodLogsTable,
      MoodLog,
      $$MoodLogsTableFilterComposer,
      $$MoodLogsTableOrderingComposer,
      $$MoodLogsTableAnnotationComposer,
      $$MoodLogsTableCreateCompanionBuilder,
      $$MoodLogsTableUpdateCompanionBuilder,
      (MoodLog, BaseReferences<_$AppDatabase, $MoodLogsTable, MoodLog>),
      MoodLog,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      Value<String?> description,
      Value<String?> icon,
      Value<String?> color,
      required String frequency,
      Value<int> targetCount,
      Value<String?> reminderTime,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<String?> icon,
      Value<String?> color,
      Value<String> frequency,
      Value<int> targetCount,
      Value<String?> reminderTime,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
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

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
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

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get targetCount => $composableBuilder(
    column: $table.targetCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reminderTime => $composableBuilder(
    column: $table.reminderTime,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
          Habit,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<int> targetCount = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                icon: icon,
                color: color,
                frequency: frequency,
                targetCount: targetCount,
                reminderTime: reminderTime,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<String?> color = const Value.absent(),
                required String frequency,
                Value<int> targetCount = const Value.absent(),
                Value<String?> reminderTime = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => HabitsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                icon: icon,
                color: color,
                frequency: frequency,
                targetCount: targetCount,
                reminderTime: reminderTime,
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

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
      Habit,
      PrefetchHooks Function()
    >;
typedef $$HabitCompletionsTableCreateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      required int habitId,
      required String userId,
      required DateTime completedAt,
      Value<int> count,
      Value<String?> notes,
      required DateTime createdAt,
    });
typedef $$HabitCompletionsTableUpdateCompanionBuilder =
    HabitCompletionsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<String> userId,
      Value<DateTime> completedAt,
      Value<int> count,
      Value<String?> notes,
      Value<DateTime> createdAt,
    });

class $$HabitCompletionsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableFilterComposer({
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

  ColumnFilters<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitCompletionsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableOrderingComposer({
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

  ColumnOrderings<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitCompletionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitCompletionsTable> {
  $$HabitCompletionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HabitCompletionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitCompletionsTable,
          HabitCompletion,
          $$HabitCompletionsTableFilterComposer,
          $$HabitCompletionsTableOrderingComposer,
          $$HabitCompletionsTableAnnotationComposer,
          $$HabitCompletionsTableCreateCompanionBuilder,
          $$HabitCompletionsTableUpdateCompanionBuilder,
          (
            HabitCompletion,
            BaseReferences<
              _$AppDatabase,
              $HabitCompletionsTable,
              HabitCompletion
            >,
          ),
          HabitCompletion,
          PrefetchHooks Function()
        > {
  $$HabitCompletionsTableTableManager(
    _$AppDatabase db,
    $HabitCompletionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitCompletionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitCompletionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitCompletionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> completedAt = const Value.absent(),
                Value<int> count = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HabitCompletionsCompanion(
                id: id,
                habitId: habitId,
                userId: userId,
                completedAt: completedAt,
                count: count,
                notes: notes,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required String userId,
                required DateTime completedAt,
                Value<int> count = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
              }) => HabitCompletionsCompanion.insert(
                id: id,
                habitId: habitId,
                userId: userId,
                completedAt: completedAt,
                count: count,
                notes: notes,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitCompletionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitCompletionsTable,
      HabitCompletion,
      $$HabitCompletionsTableFilterComposer,
      $$HabitCompletionsTableOrderingComposer,
      $$HabitCompletionsTableAnnotationComposer,
      $$HabitCompletionsTableCreateCompanionBuilder,
      $$HabitCompletionsTableUpdateCompanionBuilder,
      (
        HabitCompletion,
        BaseReferences<_$AppDatabase, $HabitCompletionsTable, HabitCompletion>,
      ),
      HabitCompletion,
      PrefetchHooks Function()
    >;
typedef $$BodyMeasurementsTableCreateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      required String userId,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<double?> bmi,
      Value<double?> bodyFatPercent,
      Value<double?> muscleMassKg,
      Value<double?> waistCm,
      Value<double?> chestCm,
      Value<double?> hipCm,
      Value<double?> bicepCm,
      Value<String?> notes,
      required DateTime measuredAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$BodyMeasurementsTableUpdateCompanionBuilder =
    BodyMeasurementsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<double?> weightKg,
      Value<double?> heightCm,
      Value<double?> bmi,
      Value<double?> bodyFatPercent,
      Value<double?> muscleMassKg,
      Value<double?> waistCm,
      Value<double?> chestCm,
      Value<double?> hipCm,
      Value<double?> bicepCm,
      Value<String?> notes,
      Value<DateTime> measuredAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BodyMeasurementsTableFilterComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableFilterComposer({
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

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyFatPercent => $composableBuilder(
    column: $table.bodyFatPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get muscleMassKg => $composableBuilder(
    column: $table.muscleMassKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waistCm => $composableBuilder(
    column: $table.waistCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get chestCm => $composableBuilder(
    column: $table.chestCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get hipCm => $composableBuilder(
    column: $table.hipCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bicepCm => $composableBuilder(
    column: $table.bicepCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
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

class $$BodyMeasurementsTableOrderingComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableOrderingComposer({
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

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bmi => $composableBuilder(
    column: $table.bmi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyFatPercent => $composableBuilder(
    column: $table.bodyFatPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get muscleMassKg => $composableBuilder(
    column: $table.muscleMassKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waistCm => $composableBuilder(
    column: $table.waistCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get chestCm => $composableBuilder(
    column: $table.chestCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get hipCm => $composableBuilder(
    column: $table.hipCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bicepCm => $composableBuilder(
    column: $table.bicepCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
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

class $$BodyMeasurementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BodyMeasurementsTable> {
  $$BodyMeasurementsTableAnnotationComposer({
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

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get bmi =>
      $composableBuilder(column: $table.bmi, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPercent => $composableBuilder(
    column: $table.bodyFatPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get muscleMassKg => $composableBuilder(
    column: $table.muscleMassKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waistCm =>
      $composableBuilder(column: $table.waistCm, builder: (column) => column);

  GeneratedColumn<double> get chestCm =>
      $composableBuilder(column: $table.chestCm, builder: (column) => column);

  GeneratedColumn<double> get hipCm =>
      $composableBuilder(column: $table.hipCm, builder: (column) => column);

  GeneratedColumn<double> get bicepCm =>
      $composableBuilder(column: $table.bicepCm, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
    column: $table.measuredAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BodyMeasurementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BodyMeasurementsTable,
          BodyMeasurement,
          $$BodyMeasurementsTableFilterComposer,
          $$BodyMeasurementsTableOrderingComposer,
          $$BodyMeasurementsTableAnnotationComposer,
          $$BodyMeasurementsTableCreateCompanionBuilder,
          $$BodyMeasurementsTableUpdateCompanionBuilder,
          (
            BodyMeasurement,
            BaseReferences<
              _$AppDatabase,
              $BodyMeasurementsTable,
              BodyMeasurement
            >,
          ),
          BodyMeasurement,
          PrefetchHooks Function()
        > {
  $$BodyMeasurementsTableTableManager(
    _$AppDatabase db,
    $BodyMeasurementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BodyMeasurementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BodyMeasurementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BodyMeasurementsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                Value<double?> bodyFatPercent = const Value.absent(),
                Value<double?> muscleMassKg = const Value.absent(),
                Value<double?> waistCm = const Value.absent(),
                Value<double?> chestCm = const Value.absent(),
                Value<double?> hipCm = const Value.absent(),
                Value<double?> bicepCm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> measuredAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BodyMeasurementsCompanion(
                id: id,
                userId: userId,
                weightKg: weightKg,
                heightCm: heightCm,
                bmi: bmi,
                bodyFatPercent: bodyFatPercent,
                muscleMassKg: muscleMassKg,
                waistCm: waistCm,
                chestCm: chestCm,
                hipCm: hipCm,
                bicepCm: bicepCm,
                notes: notes,
                measuredAt: measuredAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                Value<double?> weightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> bmi = const Value.absent(),
                Value<double?> bodyFatPercent = const Value.absent(),
                Value<double?> muscleMassKg = const Value.absent(),
                Value<double?> waistCm = const Value.absent(),
                Value<double?> chestCm = const Value.absent(),
                Value<double?> hipCm = const Value.absent(),
                Value<double?> bicepCm = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime measuredAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => BodyMeasurementsCompanion.insert(
                id: id,
                userId: userId,
                weightKg: weightKg,
                heightCm: heightCm,
                bmi: bmi,
                bodyFatPercent: bodyFatPercent,
                muscleMassKg: muscleMassKg,
                waistCm: waistCm,
                chestCm: chestCm,
                hipCm: hipCm,
                bicepCm: bicepCm,
                notes: notes,
                measuredAt: measuredAt,
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

typedef $$BodyMeasurementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BodyMeasurementsTable,
      BodyMeasurement,
      $$BodyMeasurementsTableFilterComposer,
      $$BodyMeasurementsTableOrderingComposer,
      $$BodyMeasurementsTableAnnotationComposer,
      $$BodyMeasurementsTableCreateCompanionBuilder,
      $$BodyMeasurementsTableUpdateCompanionBuilder,
      (
        BodyMeasurement,
        BaseReferences<_$AppDatabase, $BodyMeasurementsTable, BodyMeasurement>,
      ),
      BodyMeasurement,
      PrefetchHooks Function()
    >;
typedef $$MedicationsTableCreateCompanionBuilder =
    MedicationsCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      required String dosage,
      required String frequency,
      Value<String?> unit,
      Value<String?> instructions,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<String?> reminderTimes,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MedicationsTableUpdateCompanionBuilder =
    MedicationsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<String> dosage,
      Value<String> frequency,
      Value<String?> unit,
      Value<String?> instructions,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<String?> reminderTimes,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MedicationsTableFilterComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reminderTimes => $composableBuilder(
    column: $table.reminderTimes,
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

class $$MedicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dosage => $composableBuilder(
    column: $table.dosage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderTimes => $composableBuilder(
    column: $table.reminderTimes,
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

class $$MedicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MedicationsTable> {
  $$MedicationsTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get dosage =>
      $composableBuilder(column: $table.dosage, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get reminderTimes => $composableBuilder(
    column: $table.reminderTimes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MedicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MedicationsTable,
          Medication,
          $$MedicationsTableFilterComposer,
          $$MedicationsTableOrderingComposer,
          $$MedicationsTableAnnotationComposer,
          $$MedicationsTableCreateCompanionBuilder,
          $$MedicationsTableUpdateCompanionBuilder,
          (
            Medication,
            BaseReferences<_$AppDatabase, $MedicationsTable, Medication>,
          ),
          Medication,
          PrefetchHooks Function()
        > {
  $$MedicationsTableTableManager(_$AppDatabase db, $MedicationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> dosage = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<String?> unit = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> reminderTimes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MedicationsCompanion(
                id: id,
                userId: userId,
                name: name,
                dosage: dosage,
                frequency: frequency,
                unit: unit,
                instructions: instructions,
                startDate: startDate,
                endDate: endDate,
                reminderTimes: reminderTimes,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                required String dosage,
                required String frequency,
                Value<String?> unit = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> reminderTimes = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MedicationsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                dosage: dosage,
                frequency: frequency,
                unit: unit,
                instructions: instructions,
                startDate: startDate,
                endDate: endDate,
                reminderTimes: reminderTimes,
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

typedef $$MedicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MedicationsTable,
      Medication,
      $$MedicationsTableFilterComposer,
      $$MedicationsTableOrderingComposer,
      $$MedicationsTableAnnotationComposer,
      $$MedicationsTableCreateCompanionBuilder,
      $$MedicationsTableUpdateCompanionBuilder,
      (
        Medication,
        BaseReferences<_$AppDatabase, $MedicationsTable, Medication>,
      ),
      Medication,
      PrefetchHooks Function()
    >;
typedef $$FastingLogsTableCreateCompanionBuilder =
    FastingLogsCompanion Function({
      Value<int> id,
      required String userId,
      required String fastingType,
      required DateTime startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      required String status,
      Value<int?> caloriesConsumed,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$FastingLogsTableUpdateCompanionBuilder =
    FastingLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> fastingType,
      Value<DateTime> startTime,
      Value<DateTime?> endTime,
      Value<int?> durationMinutes,
      Value<String> status,
      Value<int?> caloriesConsumed,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$FastingLogsTableFilterComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableFilterComposer({
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

  ColumnFilters<String> get fastingType => $composableBuilder(
    column: $table.fastingType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesConsumed => $composableBuilder(
    column: $table.caloriesConsumed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$FastingLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableOrderingComposer({
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

  ColumnOrderings<String> get fastingType => $composableBuilder(
    column: $table.fastingType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startTime => $composableBuilder(
    column: $table.startTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endTime => $composableBuilder(
    column: $table.endTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesConsumed => $composableBuilder(
    column: $table.caloriesConsumed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$FastingLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FastingLogsTable> {
  $$FastingLogsTableAnnotationComposer({
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

  GeneratedColumn<String> get fastingType => $composableBuilder(
    column: $table.fastingType,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startTime =>
      $composableBuilder(column: $table.startTime, builder: (column) => column);

  GeneratedColumn<DateTime> get endTime =>
      $composableBuilder(column: $table.endTime, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get caloriesConsumed => $composableBuilder(
    column: $table.caloriesConsumed,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FastingLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FastingLogsTable,
          FastingLog,
          $$FastingLogsTableFilterComposer,
          $$FastingLogsTableOrderingComposer,
          $$FastingLogsTableAnnotationComposer,
          $$FastingLogsTableCreateCompanionBuilder,
          $$FastingLogsTableUpdateCompanionBuilder,
          (
            FastingLog,
            BaseReferences<_$AppDatabase, $FastingLogsTable, FastingLog>,
          ),
          FastingLog,
          PrefetchHooks Function()
        > {
  $$FastingLogsTableTableManager(_$AppDatabase db, $FastingLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FastingLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FastingLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FastingLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> fastingType = const Value.absent(),
                Value<DateTime> startTime = const Value.absent(),
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> caloriesConsumed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => FastingLogsCompanion(
                id: id,
                userId: userId,
                fastingType: fastingType,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                status: status,
                caloriesConsumed: caloriesConsumed,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String fastingType,
                required DateTime startTime,
                Value<DateTime?> endTime = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                required String status,
                Value<int?> caloriesConsumed = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => FastingLogsCompanion.insert(
                id: id,
                userId: userId,
                fastingType: fastingType,
                startTime: startTime,
                endTime: endTime,
                durationMinutes: durationMinutes,
                status: status,
                caloriesConsumed: caloriesConsumed,
                notes: notes,
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

typedef $$FastingLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FastingLogsTable,
      FastingLog,
      $$FastingLogsTableFilterComposer,
      $$FastingLogsTableOrderingComposer,
      $$FastingLogsTableAnnotationComposer,
      $$FastingLogsTableCreateCompanionBuilder,
      $$FastingLogsTableUpdateCompanionBuilder,
      (
        FastingLog,
        BaseReferences<_$AppDatabase, $FastingLogsTable, FastingLog>,
      ),
      FastingLog,
      PrefetchHooks Function()
    >;
typedef $$MealPlansTableCreateCompanionBuilder =
    MealPlansCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      Value<String?> description,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<int?> targetCalories,
      Value<double?> targetProtein,
      Value<double?> targetCarbs,
      Value<double?> targetFat,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MealPlansTableUpdateCompanionBuilder =
    MealPlansCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<int?> targetCalories,
      Value<double?> targetProtein,
      Value<double?> targetCarbs,
      Value<double?> targetFat,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$MealPlansTableFilterComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetProtein => $composableBuilder(
    column: $table.targetProtein,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetCarbs => $composableBuilder(
    column: $table.targetCarbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetFat => $composableBuilder(
    column: $table.targetFat,
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

class $$MealPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetProtein => $composableBuilder(
    column: $table.targetProtein,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetCarbs => $composableBuilder(
    column: $table.targetCarbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetFat => $composableBuilder(
    column: $table.targetFat,
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

class $$MealPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealPlansTable> {
  $$MealPlansTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get targetCalories => $composableBuilder(
    column: $table.targetCalories,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetProtein => $composableBuilder(
    column: $table.targetProtein,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetCarbs => $composableBuilder(
    column: $table.targetCarbs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetFat =>
      $composableBuilder(column: $table.targetFat, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MealPlansTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MealPlansTable,
          MealPlan,
          $$MealPlansTableFilterComposer,
          $$MealPlansTableOrderingComposer,
          $$MealPlansTableAnnotationComposer,
          $$MealPlansTableCreateCompanionBuilder,
          $$MealPlansTableUpdateCompanionBuilder,
          (MealPlan, BaseReferences<_$AppDatabase, $MealPlansTable, MealPlan>),
          MealPlan,
          PrefetchHooks Function()
        > {
  $$MealPlansTableTableManager(_$AppDatabase db, $MealPlansTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> targetCalories = const Value.absent(),
                Value<double?> targetProtein = const Value.absent(),
                Value<double?> targetCarbs = const Value.absent(),
                Value<double?> targetFat = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MealPlansCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                targetCalories: targetCalories,
                targetProtein: targetProtein,
                targetCarbs: targetCarbs,
                targetFat: targetFat,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> targetCalories = const Value.absent(),
                Value<double?> targetProtein = const Value.absent(),
                Value<double?> targetCarbs = const Value.absent(),
                Value<double?> targetFat = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MealPlansCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                startDate: startDate,
                endDate: endDate,
                targetCalories: targetCalories,
                targetProtein: targetProtein,
                targetCarbs: targetCarbs,
                targetFat: targetFat,
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

typedef $$MealPlansTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MealPlansTable,
      MealPlan,
      $$MealPlansTableFilterComposer,
      $$MealPlansTableOrderingComposer,
      $$MealPlansTableAnnotationComposer,
      $$MealPlansTableCreateCompanionBuilder,
      $$MealPlansTableUpdateCompanionBuilder,
      (MealPlan, BaseReferences<_$AppDatabase, $MealPlansTable, MealPlan>),
      MealPlan,
      PrefetchHooks Function()
    >;
typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      required String userId,
      required String name,
      Value<String?> description,
      required String instructions,
      Value<int?> prepTimeMinutes,
      Value<int?> cookTimeMinutes,
      Value<int?> servings,
      Value<int?> caloriesPerServing,
      Value<double?> proteinPerServing,
      Value<double?> carbsPerServing,
      Value<double?> fatPerServing,
      required String ingredients,
      Value<String?> imageUrl,
      Value<String?> category,
      Value<bool> isPublic,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<String> instructions,
      Value<int?> prepTimeMinutes,
      Value<int?> cookTimeMinutes,
      Value<int?> servings,
      Value<int?> caloriesPerServing,
      Value<double?> proteinPerServing,
      Value<double?> carbsPerServing,
      Value<double?> fatPerServing,
      Value<String> ingredients,
      Value<String?> imageUrl,
      Value<String?> category,
      Value<bool> isPublic,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
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

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get servings => $composableBuilder(
    column: $table.servings,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrl => $composableBuilder(
    column: $table.imageUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPublic => $composableBuilder(
    column: $table.isPublic,
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

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
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

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get prepTimeMinutes => $composableBuilder(
    column: $table.prepTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get servings =>
      $composableBuilder(column: $table.servings, builder: (column) => column);

  GeneratedColumn<int> get caloriesPerServing => $composableBuilder(
    column: $table.caloriesPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinPerServing => $composableBuilder(
    column: $table.proteinPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbsPerServing => $composableBuilder(
    column: $table.carbsPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get fatPerServing => $composableBuilder(
    column: $table.fatPerServing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ingredients => $composableBuilder(
    column: $table.ingredients,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPublic =>
      $composableBuilder(column: $table.isPublic, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
          Recipe,
          PrefetchHooks Function()
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> servings = const Value.absent(),
                Value<int?> caloriesPerServing = const Value.absent(),
                Value<double?> proteinPerServing = const Value.absent(),
                Value<double?> carbsPerServing = const Value.absent(),
                Value<double?> fatPerServing = const Value.absent(),
                Value<String> ingredients = const Value.absent(),
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                instructions: instructions,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                carbsPerServing: carbsPerServing,
                fatPerServing: fatPerServing,
                ingredients: ingredients,
                imageUrl: imageUrl,
                category: category,
                isPublic: isPublic,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                required String instructions,
                Value<int?> prepTimeMinutes = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<int?> servings = const Value.absent(),
                Value<int?> caloriesPerServing = const Value.absent(),
                Value<double?> proteinPerServing = const Value.absent(),
                Value<double?> carbsPerServing = const Value.absent(),
                Value<double?> fatPerServing = const Value.absent(),
                required String ingredients,
                Value<String?> imageUrl = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<bool> isPublic = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RecipesCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                instructions: instructions,
                prepTimeMinutes: prepTimeMinutes,
                cookTimeMinutes: cookTimeMinutes,
                servings: servings,
                caloriesPerServing: caloriesPerServing,
                proteinPerServing: proteinPerServing,
                carbsPerServing: carbsPerServing,
                fatPerServing: fatPerServing,
                ingredients: ingredients,
                imageUrl: imageUrl,
                category: category,
                isPublic: isPublic,
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

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, BaseReferences<_$AppDatabase, $RecipesTable, Recipe>),
      Recipe,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
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
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
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
    extends Composer<_$AppDatabase, $BloodPressureLogsTable> {
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
          _$AppDatabase,
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
              _$AppDatabase,
              $BloodPressureLogsTable,
              BloodPressureLog
            >,
          ),
          BloodPressureLog,
          PrefetchHooks Function()
        > {
  $$BloodPressureLogsTableTableManager(
    _$AppDatabase db,
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
      _$AppDatabase,
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
          _$AppDatabase,
          $BloodPressureLogsTable,
          BloodPressureLog
        >,
      ),
      BloodPressureLog,
      PrefetchHooks Function()
    >;
typedef $$GlucoseLogsTableCreateCompanionBuilder =
    GlucoseLogsCompanion Function({
      Value<int> id,
      required String userId,
      required double value,
      required String unit,
      required String measurementType,
      Value<String?> notes,
      required DateTime loggedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$GlucoseLogsTableUpdateCompanionBuilder =
    GlucoseLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<double> value,
      Value<String> unit,
      Value<String> measurementType,
      Value<String?> notes,
      Value<DateTime> loggedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$GlucoseLogsTableFilterComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableFilterComposer({
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

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
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

class $$GlucoseLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableOrderingComposer({
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

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
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

class $$GlucoseLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlucoseLogsTable> {
  $$GlucoseLogsTableAnnotationComposer({
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

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get measurementType => $composableBuilder(
    column: $table.measurementType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GlucoseLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GlucoseLogsTable,
          GlucoseLog,
          $$GlucoseLogsTableFilterComposer,
          $$GlucoseLogsTableOrderingComposer,
          $$GlucoseLogsTableAnnotationComposer,
          $$GlucoseLogsTableCreateCompanionBuilder,
          $$GlucoseLogsTableUpdateCompanionBuilder,
          (
            GlucoseLog,
            BaseReferences<_$AppDatabase, $GlucoseLogsTable, GlucoseLog>,
          ),
          GlucoseLog,
          PrefetchHooks Function()
        > {
  $$GlucoseLogsTableTableManager(_$AppDatabase db, $GlucoseLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlucoseLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlucoseLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlucoseLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> measurementType = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> loggedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => GlucoseLogsCompanion(
                id: id,
                userId: userId,
                value: value,
                unit: unit,
                measurementType: measurementType,
                notes: notes,
                loggedAt: loggedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required double value,
                required String unit,
                required String measurementType,
                Value<String?> notes = const Value.absent(),
                required DateTime loggedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => GlucoseLogsCompanion.insert(
                id: id,
                userId: userId,
                value: value,
                unit: unit,
                measurementType: measurementType,
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

typedef $$GlucoseLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GlucoseLogsTable,
      GlucoseLog,
      $$GlucoseLogsTableFilterComposer,
      $$GlucoseLogsTableOrderingComposer,
      $$GlucoseLogsTableAnnotationComposer,
      $$GlucoseLogsTableCreateCompanionBuilder,
      $$GlucoseLogsTableUpdateCompanionBuilder,
      (
        GlucoseLog,
        BaseReferences<_$AppDatabase, $GlucoseLogsTable, GlucoseLog>,
      ),
      GlucoseLog,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
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
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
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
    extends Composer<_$AppDatabase, $Spo2LogsTable> {
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
          _$AppDatabase,
          $Spo2LogsTable,
          Spo2Log,
          $$Spo2LogsTableFilterComposer,
          $$Spo2LogsTableOrderingComposer,
          $$Spo2LogsTableAnnotationComposer,
          $$Spo2LogsTableCreateCompanionBuilder,
          $$Spo2LogsTableUpdateCompanionBuilder,
          (Spo2Log, BaseReferences<_$AppDatabase, $Spo2LogsTable, Spo2Log>),
          Spo2Log,
          PrefetchHooks Function()
        > {
  $$Spo2LogsTableTableManager(_$AppDatabase db, $Spo2LogsTable table)
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
      _$AppDatabase,
      $Spo2LogsTable,
      Spo2Log,
      $$Spo2LogsTableFilterComposer,
      $$Spo2LogsTableOrderingComposer,
      $$Spo2LogsTableAnnotationComposer,
      $$Spo2LogsTableCreateCompanionBuilder,
      $$Spo2LogsTableUpdateCompanionBuilder,
      (Spo2Log, BaseReferences<_$AppDatabase, $Spo2LogsTable, Spo2Log>),
      Spo2Log,
      PrefetchHooks Function()
    >;
typedef $$PeriodLogsTableCreateCompanionBuilder =
    PeriodLogsCompanion Function({
      Value<int> id,
      required String userId,
      required DateTime startDate,
      Value<DateTime?> endDate,
      Value<int?> flowLevel,
      Value<String?> symptoms,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PeriodLogsTableUpdateCompanionBuilder =
    PeriodLogsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<DateTime> startDate,
      Value<DateTime?> endDate,
      Value<int?> flowLevel,
      Value<String?> symptoms,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PeriodLogsTableFilterComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get flowLevel => $composableBuilder(
    column: $table.flowLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$PeriodLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get flowLevel => $composableBuilder(
    column: $table.flowLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get symptoms => $composableBuilder(
    column: $table.symptoms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$PeriodLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PeriodLogsTable> {
  $$PeriodLogsTableAnnotationComposer({
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

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<int> get flowLevel =>
      $composableBuilder(column: $table.flowLevel, builder: (column) => column);

  GeneratedColumn<String> get symptoms =>
      $composableBuilder(column: $table.symptoms, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PeriodLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PeriodLogsTable,
          PeriodLog,
          $$PeriodLogsTableFilterComposer,
          $$PeriodLogsTableOrderingComposer,
          $$PeriodLogsTableAnnotationComposer,
          $$PeriodLogsTableCreateCompanionBuilder,
          $$PeriodLogsTableUpdateCompanionBuilder,
          (
            PeriodLog,
            BaseReferences<_$AppDatabase, $PeriodLogsTable, PeriodLog>,
          ),
          PeriodLog,
          PrefetchHooks Function()
        > {
  $$PeriodLogsTableTableManager(_$AppDatabase db, $PeriodLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PeriodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PeriodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PeriodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> flowLevel = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PeriodLogsCompanion(
                id: id,
                userId: userId,
                startDate: startDate,
                endDate: endDate,
                flowLevel: flowLevel,
                symptoms: symptoms,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required DateTime startDate,
                Value<DateTime?> endDate = const Value.absent(),
                Value<int?> flowLevel = const Value.absent(),
                Value<String?> symptoms = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PeriodLogsCompanion.insert(
                id: id,
                userId: userId,
                startDate: startDate,
                endDate: endDate,
                flowLevel: flowLevel,
                symptoms: symptoms,
                notes: notes,
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

typedef $$PeriodLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PeriodLogsTable,
      PeriodLog,
      $$PeriodLogsTableFilterComposer,
      $$PeriodLogsTableOrderingComposer,
      $$PeriodLogsTableAnnotationComposer,
      $$PeriodLogsTableCreateCompanionBuilder,
      $$PeriodLogsTableUpdateCompanionBuilder,
      (PeriodLog, BaseReferences<_$AppDatabase, $PeriodLogsTable, PeriodLog>),
      PeriodLog,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableCreateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      required String userId,
      Value<String?> title,
      required String content,
      Value<String?> mood,
      Value<String?> tags,
      Value<String?> imageUrls,
      Value<bool> isPrivate,
      required DateTime entryDate,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$JournalEntriesTableUpdateCompanionBuilder =
    JournalEntriesCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String?> title,
      Value<String> content,
      Value<String?> mood,
      Value<String?> tags,
      Value<String?> imageUrls,
      Value<bool> isPrivate,
      Value<DateTime> entryDate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$JournalEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
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

class $$JournalEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrls => $composableBuilder(
    column: $table.imageUrls,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrivate => $composableBuilder(
    column: $table.isPrivate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
    column: $table.entryDate,
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

class $$JournalEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTable> {
  $$JournalEntriesTableAnnotationComposer({
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

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get mood =>
      $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get imageUrls =>
      $composableBuilder(column: $table.imageUrls, builder: (column) => column);

  GeneratedColumn<bool> get isPrivate =>
      $composableBuilder(column: $table.isPrivate, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$JournalEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTable,
          JournalEntry,
          $$JournalEntriesTableFilterComposer,
          $$JournalEntriesTableOrderingComposer,
          $$JournalEntriesTableAnnotationComposer,
          $$JournalEntriesTableCreateCompanionBuilder,
          $$JournalEntriesTableUpdateCompanionBuilder,
          (
            JournalEntry,
            BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
          ),
          JournalEntry,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> imageUrls = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                Value<DateTime> entryDate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => JournalEntriesCompanion(
                id: id,
                userId: userId,
                title: title,
                content: content,
                mood: mood,
                tags: tags,
                imageUrls: imageUrls,
                isPrivate: isPrivate,
                entryDate: entryDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                Value<String?> title = const Value.absent(),
                required String content,
                Value<String?> mood = const Value.absent(),
                Value<String?> tags = const Value.absent(),
                Value<String?> imageUrls = const Value.absent(),
                Value<bool> isPrivate = const Value.absent(),
                required DateTime entryDate,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => JournalEntriesCompanion.insert(
                id: id,
                userId: userId,
                title: title,
                content: content,
                mood: mood,
                tags: tags,
                imageUrls: imageUrls,
                isPrivate: isPrivate,
                entryDate: entryDate,
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

typedef $$JournalEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTable,
      JournalEntry,
      $$JournalEntriesTableFilterComposer,
      $$JournalEntriesTableOrderingComposer,
      $$JournalEntriesTableAnnotationComposer,
      $$JournalEntriesTableCreateCompanionBuilder,
      $$JournalEntriesTableUpdateCompanionBuilder,
      (
        JournalEntry,
        BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>,
      ),
      JournalEntry,
      PrefetchHooks Function()
    >;
typedef $$DoctorAppointmentsTableCreateCompanionBuilder =
    DoctorAppointmentsCompanion Function({
      Value<int> id,
      required String userId,
      required String doctorName,
      Value<String?> specialty,
      Value<String?> clinicName,
      Value<String?> address,
      Value<String?> phone,
      required DateTime appointmentDate,
      Value<String?> reason,
      Value<String?> notes,
      required String status,
      Value<bool> reminderSet,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$DoctorAppointmentsTableUpdateCompanionBuilder =
    DoctorAppointmentsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> doctorName,
      Value<String?> specialty,
      Value<String?> clinicName,
      Value<String?> address,
      Value<String?> phone,
      Value<DateTime> appointmentDate,
      Value<String?> reason,
      Value<String?> notes,
      Value<String> status,
      Value<bool> reminderSet,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$DoctorAppointmentsTableFilterComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableFilterComposer({
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

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get reminderSet => $composableBuilder(
    column: $table.reminderSet,
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

class $$DoctorAppointmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableOrderingComposer({
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

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get specialty => $composableBuilder(
    column: $table.specialty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get reminderSet => $composableBuilder(
    column: $table.reminderSet,
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

class $$DoctorAppointmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DoctorAppointmentsTable> {
  $$DoctorAppointmentsTableAnnotationComposer({
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

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get clinicName => $composableBuilder(
    column: $table.clinicName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get appointmentDate => $composableBuilder(
    column: $table.appointmentDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get reminderSet => $composableBuilder(
    column: $table.reminderSet,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DoctorAppointmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DoctorAppointmentsTable,
          DoctorAppointment,
          $$DoctorAppointmentsTableFilterComposer,
          $$DoctorAppointmentsTableOrderingComposer,
          $$DoctorAppointmentsTableAnnotationComposer,
          $$DoctorAppointmentsTableCreateCompanionBuilder,
          $$DoctorAppointmentsTableUpdateCompanionBuilder,
          (
            DoctorAppointment,
            BaseReferences<
              _$AppDatabase,
              $DoctorAppointmentsTable,
              DoctorAppointment
            >,
          ),
          DoctorAppointment,
          PrefetchHooks Function()
        > {
  $$DoctorAppointmentsTableTableManager(
    _$AppDatabase db,
    $DoctorAppointmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DoctorAppointmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DoctorAppointmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DoctorAppointmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> doctorName = const Value.absent(),
                Value<String?> specialty = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<DateTime> appointmentDate = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<bool> reminderSet = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => DoctorAppointmentsCompanion(
                id: id,
                userId: userId,
                doctorName: doctorName,
                specialty: specialty,
                clinicName: clinicName,
                address: address,
                phone: phone,
                appointmentDate: appointmentDate,
                reason: reason,
                notes: notes,
                status: status,
                reminderSet: reminderSet,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String doctorName,
                Value<String?> specialty = const Value.absent(),
                Value<String?> clinicName = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                required DateTime appointmentDate,
                Value<String?> reason = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String status,
                Value<bool> reminderSet = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => DoctorAppointmentsCompanion.insert(
                id: id,
                userId: userId,
                doctorName: doctorName,
                specialty: specialty,
                clinicName: clinicName,
                address: address,
                phone: phone,
                appointmentDate: appointmentDate,
                reason: reason,
                notes: notes,
                status: status,
                reminderSet: reminderSet,
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

typedef $$DoctorAppointmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DoctorAppointmentsTable,
      DoctorAppointment,
      $$DoctorAppointmentsTableFilterComposer,
      $$DoctorAppointmentsTableOrderingComposer,
      $$DoctorAppointmentsTableAnnotationComposer,
      $$DoctorAppointmentsTableCreateCompanionBuilder,
      $$DoctorAppointmentsTableUpdateCompanionBuilder,
      (
        DoctorAppointment,
        BaseReferences<
          _$AppDatabase,
          $DoctorAppointmentsTable,
          DoctorAppointment
        >,
      ),
      DoctorAppointment,
      PrefetchHooks Function()
    >;
typedef $$LabReportsTableCreateCompanionBuilder =
    LabReportsCompanion Function({
      Value<int> id,
      required String userId,
      required String reportName,
      Value<String?> labName,
      Value<String?> doctorName,
      required DateTime reportDate,
      Value<String?> results,
      Value<String?> fileUrl,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LabReportsTableUpdateCompanionBuilder =
    LabReportsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> reportName,
      Value<String?> labName,
      Value<String?> doctorName,
      Value<DateTime> reportDate,
      Value<String?> results,
      Value<String?> fileUrl,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LabReportsTableFilterComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableFilterComposer({
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

  ColumnFilters<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get results => $composableBuilder(
    column: $table.results,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$LabReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableOrderingComposer({
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

  ColumnOrderings<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get labName => $composableBuilder(
    column: $table.labName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get results => $composableBuilder(
    column: $table.results,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileUrl => $composableBuilder(
    column: $table.fileUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$LabReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LabReportsTable> {
  $$LabReportsTableAnnotationComposer({
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

  GeneratedColumn<String> get reportName => $composableBuilder(
    column: $table.reportName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get labName =>
      $composableBuilder(column: $table.labName, builder: (column) => column);

  GeneratedColumn<String> get doctorName => $composableBuilder(
    column: $table.doctorName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get reportDate => $composableBuilder(
    column: $table.reportDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get results =>
      $composableBuilder(column: $table.results, builder: (column) => column);

  GeneratedColumn<String> get fileUrl =>
      $composableBuilder(column: $table.fileUrl, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LabReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LabReportsTable,
          LabReport,
          $$LabReportsTableFilterComposer,
          $$LabReportsTableOrderingComposer,
          $$LabReportsTableAnnotationComposer,
          $$LabReportsTableCreateCompanionBuilder,
          $$LabReportsTableUpdateCompanionBuilder,
          (
            LabReport,
            BaseReferences<_$AppDatabase, $LabReportsTable, LabReport>,
          ),
          LabReport,
          PrefetchHooks Function()
        > {
  $$LabReportsTableTableManager(_$AppDatabase db, $LabReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> reportName = const Value.absent(),
                Value<String?> labName = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                Value<DateTime> reportDate = const Value.absent(),
                Value<String?> results = const Value.absent(),
                Value<String?> fileUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LabReportsCompanion(
                id: id,
                userId: userId,
                reportName: reportName,
                labName: labName,
                doctorName: doctorName,
                reportDate: reportDate,
                results: results,
                fileUrl: fileUrl,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String reportName,
                Value<String?> labName = const Value.absent(),
                Value<String?> doctorName = const Value.absent(),
                required DateTime reportDate,
                Value<String?> results = const Value.absent(),
                Value<String?> fileUrl = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LabReportsCompanion.insert(
                id: id,
                userId: userId,
                reportName: reportName,
                labName: labName,
                doctorName: doctorName,
                reportDate: reportDate,
                results: results,
                fileUrl: fileUrl,
                notes: notes,
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

typedef $$LabReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LabReportsTable,
      LabReport,
      $$LabReportsTableFilterComposer,
      $$LabReportsTableOrderingComposer,
      $$LabReportsTableAnnotationComposer,
      $$LabReportsTableCreateCompanionBuilder,
      $$LabReportsTableUpdateCompanionBuilder,
      (LabReport, BaseReferences<_$AppDatabase, $LabReportsTable, LabReport>),
      LabReport,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
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
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
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
    extends Composer<_$AppDatabase, $AbhaLinksTable> {
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
          _$AppDatabase,
          $AbhaLinksTable,
          AbhaLink,
          $$AbhaLinksTableFilterComposer,
          $$AbhaLinksTableOrderingComposer,
          $$AbhaLinksTableAnnotationComposer,
          $$AbhaLinksTableCreateCompanionBuilder,
          $$AbhaLinksTableUpdateCompanionBuilder,
          (AbhaLink, BaseReferences<_$AppDatabase, $AbhaLinksTable, AbhaLink>),
          AbhaLink,
          PrefetchHooks Function()
        > {
  $$AbhaLinksTableTableManager(_$AppDatabase db, $AbhaLinksTable table)
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
      _$AppDatabase,
      $AbhaLinksTable,
      AbhaLink,
      $$AbhaLinksTableFilterComposer,
      $$AbhaLinksTableOrderingComposer,
      $$AbhaLinksTableAnnotationComposer,
      $$AbhaLinksTableCreateCompanionBuilder,
      $$AbhaLinksTableUpdateCompanionBuilder,
      (AbhaLink, BaseReferences<_$AppDatabase, $AbhaLinksTable, AbhaLink>),
      AbhaLink,
      PrefetchHooks Function()
    >;
typedef $$EmergencyCardTableCreateCompanionBuilder =
    EmergencyCardCompanion Function({
      Value<int> id,
      required String userId,
      required String fullName,
      Value<DateTime?> dateOfBirth,
      Value<String?> bloodType,
      Value<String?> allergies,
      Value<String?> conditions,
      Value<String?> medications,
      Value<String?> emergencyContactName,
      Value<String?> emergencyContactPhone,
      Value<String?> notes,
      Value<bool> isVisibleOnLockScreen,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$EmergencyCardTableUpdateCompanionBuilder =
    EmergencyCardCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> fullName,
      Value<DateTime?> dateOfBirth,
      Value<String?> bloodType,
      Value<String?> allergies,
      Value<String?> conditions,
      Value<String?> medications,
      Value<String?> emergencyContactName,
      Value<String?> emergencyContactPhone,
      Value<String?> notes,
      Value<bool> isVisibleOnLockScreen,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$EmergencyCardTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableFilterComposer({
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

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVisibleOnLockScreen => $composableBuilder(
    column: $table.isVisibleOnLockScreen,
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

class $$EmergencyCardTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableOrderingComposer({
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

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bloodType => $composableBuilder(
    column: $table.bloodType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allergies => $composableBuilder(
    column: $table.allergies,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVisibleOnLockScreen => $composableBuilder(
    column: $table.isVisibleOnLockScreen,
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

class $$EmergencyCardTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyCardTable> {
  $$EmergencyCardTableAnnotationComposer({
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

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bloodType =>
      $composableBuilder(column: $table.bloodType, builder: (column) => column);

  GeneratedColumn<String> get allergies =>
      $composableBuilder(column: $table.allergies, builder: (column) => column);

  GeneratedColumn<String> get conditions => $composableBuilder(
    column: $table.conditions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medications => $composableBuilder(
    column: $table.medications,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactName => $composableBuilder(
    column: $table.emergencyContactName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emergencyContactPhone => $composableBuilder(
    column: $table.emergencyContactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isVisibleOnLockScreen => $composableBuilder(
    column: $table.isVisibleOnLockScreen,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EmergencyCardTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyCardTable,
          EmergencyCardData,
          $$EmergencyCardTableFilterComposer,
          $$EmergencyCardTableOrderingComposer,
          $$EmergencyCardTableAnnotationComposer,
          $$EmergencyCardTableCreateCompanionBuilder,
          $$EmergencyCardTableUpdateCompanionBuilder,
          (
            EmergencyCardData,
            BaseReferences<
              _$AppDatabase,
              $EmergencyCardTable,
              EmergencyCardData
            >,
          ),
          EmergencyCardData,
          PrefetchHooks Function()
        > {
  $$EmergencyCardTableTableManager(_$AppDatabase db, $EmergencyCardTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyCardTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyCardTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmergencyCardTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> bloodType = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> conditions = const Value.absent(),
                Value<String?> medications = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isVisibleOnLockScreen = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EmergencyCardCompanion(
                id: id,
                userId: userId,
                fullName: fullName,
                dateOfBirth: dateOfBirth,
                bloodType: bloodType,
                allergies: allergies,
                conditions: conditions,
                medications: medications,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                notes: notes,
                isVisibleOnLockScreen: isVisibleOnLockScreen,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String fullName,
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> bloodType = const Value.absent(),
                Value<String?> allergies = const Value.absent(),
                Value<String?> conditions = const Value.absent(),
                Value<String?> medications = const Value.absent(),
                Value<String?> emergencyContactName = const Value.absent(),
                Value<String?> emergencyContactPhone = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isVisibleOnLockScreen = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => EmergencyCardCompanion.insert(
                id: id,
                userId: userId,
                fullName: fullName,
                dateOfBirth: dateOfBirth,
                bloodType: bloodType,
                allergies: allergies,
                conditions: conditions,
                medications: medications,
                emergencyContactName: emergencyContactName,
                emergencyContactPhone: emergencyContactPhone,
                notes: notes,
                isVisibleOnLockScreen: isVisibleOnLockScreen,
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

typedef $$EmergencyCardTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyCardTable,
      EmergencyCardData,
      $$EmergencyCardTableFilterComposer,
      $$EmergencyCardTableOrderingComposer,
      $$EmergencyCardTableAnnotationComposer,
      $$EmergencyCardTableCreateCompanionBuilder,
      $$EmergencyCardTableUpdateCompanionBuilder,
      (
        EmergencyCardData,
        BaseReferences<_$AppDatabase, $EmergencyCardTable, EmergencyCardData>,
      ),
      EmergencyCardData,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
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
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
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
    extends Composer<_$AppDatabase, $FestivalCalendarTable> {
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
          _$AppDatabase,
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
              _$AppDatabase,
              $FestivalCalendarTable,
              FestivalCalendarData
            >,
          ),
          FestivalCalendarData,
          PrefetchHooks Function()
        > {
  $$FestivalCalendarTableTableManager(
    _$AppDatabase db,
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
      _$AppDatabase,
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
          _$AppDatabase,
          $FestivalCalendarTable,
          FestivalCalendarData
        >,
      ),
      FestivalCalendarData,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
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
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
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
    extends Composer<_$AppDatabase, $RemoteConfigCacheTable> {
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
          _$AppDatabase,
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
              _$AppDatabase,
              $RemoteConfigCacheTable,
              RemoteConfigCacheData
            >,
          ),
          RemoteConfigCacheData,
          PrefetchHooks Function()
        > {
  $$RemoteConfigCacheTableTableManager(
    _$AppDatabase db,
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
      _$AppDatabase,
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
          _$AppDatabase,
          $RemoteConfigCacheTable,
          RemoteConfigCacheData
        >,
      ),
      RemoteConfigCacheData,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
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
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
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
    extends Composer<_$AppDatabase, $KarmaTransactionsTable> {
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
          _$AppDatabase,
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
              _$AppDatabase,
              $KarmaTransactionsTable,
              KarmaTransaction
            >,
          ),
          KarmaTransaction,
          PrefetchHooks Function()
        > {
  $$KarmaTransactionsTableTableManager(
    _$AppDatabase db,
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
      _$AppDatabase,
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
          _$AppDatabase,
          $KarmaTransactionsTable,
          KarmaTransaction
        >,
      ),
      KarmaTransaction,
      PrefetchHooks Function()
    >;
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
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
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
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
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
    extends Composer<_$AppDatabase, $NutritionGoalsTable> {
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
          _$AppDatabase,
          $NutritionGoalsTable,
          NutritionGoal,
          $$NutritionGoalsTableFilterComposer,
          $$NutritionGoalsTableOrderingComposer,
          $$NutritionGoalsTableAnnotationComposer,
          $$NutritionGoalsTableCreateCompanionBuilder,
          $$NutritionGoalsTableUpdateCompanionBuilder,
          (
            NutritionGoal,
            BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
          ),
          NutritionGoal,
          PrefetchHooks Function()
        > {
  $$NutritionGoalsTableTableManager(
    _$AppDatabase db,
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
      _$AppDatabase,
      $NutritionGoalsTable,
      NutritionGoal,
      $$NutritionGoalsTableFilterComposer,
      $$NutritionGoalsTableOrderingComposer,
      $$NutritionGoalsTableAnnotationComposer,
      $$NutritionGoalsTableCreateCompanionBuilder,
      $$NutritionGoalsTableUpdateCompanionBuilder,
      (
        NutritionGoal,
        BaseReferences<_$AppDatabase, $NutritionGoalsTable, NutritionGoal>,
      ),
      NutritionGoal,
      PrefetchHooks Function()
    >;
typedef $$PersonalRecordsTableCreateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      required String userId,
      required String exerciseName,
      required String recordType,
      required double value,
      required String unit,
      required DateTime achievedAt,
      Value<int?> workoutLogId,
      Value<String?> notes,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$PersonalRecordsTableUpdateCompanionBuilder =
    PersonalRecordsCompanion Function({
      Value<int> id,
      Value<String> userId,
      Value<String> exerciseName,
      Value<String> recordType,
      Value<double> value,
      Value<String> unit,
      Value<DateTime> achievedAt,
      Value<int?> workoutLogId,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$PersonalRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableFilterComposer({
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

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get workoutLogId => $composableBuilder(
    column: $table.workoutLogId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$PersonalRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableOrderingComposer({
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

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get workoutLogId => $composableBuilder(
    column: $table.workoutLogId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
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

class $$PersonalRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonalRecordsTable> {
  $$PersonalRecordsTableAnnotationComposer({
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

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordType => $composableBuilder(
    column: $table.recordType,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get achievedAt => $composableBuilder(
    column: $table.achievedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get workoutLogId => $composableBuilder(
    column: $table.workoutLogId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PersonalRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonalRecordsTable,
          PersonalRecord,
          $$PersonalRecordsTableFilterComposer,
          $$PersonalRecordsTableOrderingComposer,
          $$PersonalRecordsTableAnnotationComposer,
          $$PersonalRecordsTableCreateCompanionBuilder,
          $$PersonalRecordsTableUpdateCompanionBuilder,
          (
            PersonalRecord,
            BaseReferences<
              _$AppDatabase,
              $PersonalRecordsTable,
              PersonalRecord
            >,
          ),
          PersonalRecord,
          PrefetchHooks Function()
        > {
  $$PersonalRecordsTableTableManager(
    _$AppDatabase db,
    $PersonalRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonalRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonalRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonalRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> exerciseName = const Value.absent(),
                Value<String> recordType = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime> achievedAt = const Value.absent(),
                Value<int?> workoutLogId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PersonalRecordsCompanion(
                id: id,
                userId: userId,
                exerciseName: exerciseName,
                recordType: recordType,
                value: value,
                unit: unit,
                achievedAt: achievedAt,
                workoutLogId: workoutLogId,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String userId,
                required String exerciseName,
                required String recordType,
                required double value,
                required String unit,
                required DateTime achievedAt,
                Value<int?> workoutLogId = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => PersonalRecordsCompanion.insert(
                id: id,
                userId: userId,
                exerciseName: exerciseName,
                recordType: recordType,
                value: value,
                unit: unit,
                achievedAt: achievedAt,
                workoutLogId: workoutLogId,
                notes: notes,
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

typedef $$PersonalRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonalRecordsTable,
      PersonalRecord,
      $$PersonalRecordsTableFilterComposer,
      $$PersonalRecordsTableOrderingComposer,
      $$PersonalRecordsTableAnnotationComposer,
      $$PersonalRecordsTableCreateCompanionBuilder,
      $$PersonalRecordsTableUpdateCompanionBuilder,
      (
        PersonalRecord,
        BaseReferences<_$AppDatabase, $PersonalRecordsTable, PersonalRecord>,
      ),
      PersonalRecord,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String syncTable,
      required int recordId,
      required String operation,
      required String payload,
      Value<String> status,
      Value<int> retryCount,
      required DateTime createdAt,
      Value<DateTime?> lastAttemptAt,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> syncTable,
      Value<int> recordId,
      Value<String> operation,
      Value<String> payload,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttemptAt,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
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

  ColumnFilters<String> get syncTable => $composableBuilder(
    column: $table.syncTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
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

  ColumnOrderings<String> get syncTable => $composableBuilder(
    column: $table.syncTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTable =>
      $composableBuilder(column: $table.syncTable, builder: (column) => column);

  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttemptAt => $composableBuilder(
    column: $table.lastAttemptAt,
    builder: (column) => column,
  );
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncTable = const Value.absent(),
                Value<int> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                syncTable: syncTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncTable,
                required int recordId,
                required String operation,
                required String payload,
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lastAttemptAt = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                syncTable: syncTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttemptAt: lastAttemptAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$SyncDeadLetterTableCreateCompanionBuilder =
    SyncDeadLetterCompanion Function({
      Value<int> id,
      required String syncTable,
      required int recordId,
      required String operation,
      required String payload,
      Value<String?> errorMessage,
      required int originalRetryCount,
      required DateTime createdAt,
    });
typedef $$SyncDeadLetterTableUpdateCompanionBuilder =
    SyncDeadLetterCompanion Function({
      Value<int> id,
      Value<String> syncTable,
      Value<int> recordId,
      Value<String> operation,
      Value<String> payload,
      Value<String?> errorMessage,
      Value<int> originalRetryCount,
      Value<DateTime> createdAt,
    });

class $$SyncDeadLetterTableFilterComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableFilterComposer({
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

  ColumnFilters<String> get syncTable => $composableBuilder(
    column: $table.syncTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get originalRetryCount => $composableBuilder(
    column: $table.originalRetryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncDeadLetterTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableOrderingComposer({
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

  ColumnOrderings<String> get syncTable => $composableBuilder(
    column: $table.syncTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get originalRetryCount => $composableBuilder(
    column: $table.originalRetryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncDeadLetterTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncDeadLetterTable> {
  $$SyncDeadLetterTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get syncTable =>
      $composableBuilder(column: $table.syncTable, builder: (column) => column);

  GeneratedColumn<int> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get originalRetryCount => $composableBuilder(
    column: $table.originalRetryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncDeadLetterTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncDeadLetterTable,
          SyncDeadLetterData,
          $$SyncDeadLetterTableFilterComposer,
          $$SyncDeadLetterTableOrderingComposer,
          $$SyncDeadLetterTableAnnotationComposer,
          $$SyncDeadLetterTableCreateCompanionBuilder,
          $$SyncDeadLetterTableUpdateCompanionBuilder,
          (
            SyncDeadLetterData,
            BaseReferences<
              _$AppDatabase,
              $SyncDeadLetterTable,
              SyncDeadLetterData
            >,
          ),
          SyncDeadLetterData,
          PrefetchHooks Function()
        > {
  $$SyncDeadLetterTableTableManager(
    _$AppDatabase db,
    $SyncDeadLetterTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncDeadLetterTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncDeadLetterTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncDeadLetterTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> syncTable = const Value.absent(),
                Value<int> recordId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<int> originalRetryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SyncDeadLetterCompanion(
                id: id,
                syncTable: syncTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                errorMessage: errorMessage,
                originalRetryCount: originalRetryCount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String syncTable,
                required int recordId,
                required String operation,
                required String payload,
                Value<String?> errorMessage = const Value.absent(),
                required int originalRetryCount,
                required DateTime createdAt,
              }) => SyncDeadLetterCompanion.insert(
                id: id,
                syncTable: syncTable,
                recordId: recordId,
                operation: operation,
                payload: payload,
                errorMessage: errorMessage,
                originalRetryCount: originalRetryCount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncDeadLetterTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncDeadLetterTable,
      SyncDeadLetterData,
      $$SyncDeadLetterTableFilterComposer,
      $$SyncDeadLetterTableOrderingComposer,
      $$SyncDeadLetterTableAnnotationComposer,
      $$SyncDeadLetterTableCreateCompanionBuilder,
      $$SyncDeadLetterTableUpdateCompanionBuilder,
      (
        SyncDeadLetterData,
        BaseReferences<_$AppDatabase, $SyncDeadLetterTable, SyncDeadLetterData>,
      ),
      SyncDeadLetterData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db, _db.foodLogs);
  $$FoodItemsTableTableManager get foodItems =>
      $$FoodItemsTableTableManager(_db, _db.foodItems);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db, _db.workoutLogs);
  $$StepLogsTableTableManager get stepLogs =>
      $$StepLogsTableTableManager(_db, _db.stepLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$MoodLogsTableTableManager get moodLogs =>
      $$MoodLogsTableTableManager(_db, _db.moodLogs);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitCompletionsTableTableManager get habitCompletions =>
      $$HabitCompletionsTableTableManager(_db, _db.habitCompletions);
  $$BodyMeasurementsTableTableManager get bodyMeasurements =>
      $$BodyMeasurementsTableTableManager(_db, _db.bodyMeasurements);
  $$MedicationsTableTableManager get medications =>
      $$MedicationsTableTableManager(_db, _db.medications);
  $$FastingLogsTableTableManager get fastingLogs =>
      $$FastingLogsTableTableManager(_db, _db.fastingLogs);
  $$MealPlansTableTableManager get mealPlans =>
      $$MealPlansTableTableManager(_db, _db.mealPlans);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$BloodPressureLogsTableTableManager get bloodPressureLogs =>
      $$BloodPressureLogsTableTableManager(_db, _db.bloodPressureLogs);
  $$GlucoseLogsTableTableManager get glucoseLogs =>
      $$GlucoseLogsTableTableManager(_db, _db.glucoseLogs);
  $$Spo2LogsTableTableManager get spo2Logs =>
      $$Spo2LogsTableTableManager(_db, _db.spo2Logs);
  $$PeriodLogsTableTableManager get periodLogs =>
      $$PeriodLogsTableTableManager(_db, _db.periodLogs);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$DoctorAppointmentsTableTableManager get doctorAppointments =>
      $$DoctorAppointmentsTableTableManager(_db, _db.doctorAppointments);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db, _db.labReports);
  $$AbhaLinksTableTableManager get abhaLinks =>
      $$AbhaLinksTableTableManager(_db, _db.abhaLinks);
  $$EmergencyCardTableTableManager get emergencyCard =>
      $$EmergencyCardTableTableManager(_db, _db.emergencyCard);
  $$FestivalCalendarTableTableManager get festivalCalendar =>
      $$FestivalCalendarTableTableManager(_db, _db.festivalCalendar);
  $$RemoteConfigCacheTableTableManager get remoteConfigCache =>
      $$RemoteConfigCacheTableTableManager(_db, _db.remoteConfigCache);
  $$KarmaTransactionsTableTableManager get karmaTransactions =>
      $$KarmaTransactionsTableTableManager(_db, _db.karmaTransactions);
  $$NutritionGoalsTableTableManager get nutritionGoals =>
      $$NutritionGoalsTableTableManager(_db, _db.nutritionGoals);
  $$PersonalRecordsTableTableManager get personalRecords =>
      $$PersonalRecordsTableTableManager(_db, _db.personalRecords);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SyncDeadLetterTableTableManager get syncDeadLetter =>
      $$SyncDeadLetterTableTableManager(_db, _db.syncDeadLetter);
}
