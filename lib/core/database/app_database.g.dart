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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodNameMeta =
      const VerificationMeta('foodName');
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
      'food_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodNameLocalMeta =
      const VerificationMeta('foodNameLocal');
  @override
  late final GeneratedColumn<String> foodNameLocal = GeneratedColumn<String>(
      'food_name_local', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
      'meal_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _proteinGMeta =
      const VerificationMeta('proteinG');
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
      'protein_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
      'carbs_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
      'fat_g', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _portionUnitMeta =
      const VerificationMeta('portionUnit');
  @override
  late final GeneratedColumn<String> portionUnit = GeneratedColumn<String>(
      'portion_unit', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _portionQtyMeta =
      const VerificationMeta('portionQty');
  @override
  late final GeneratedColumn<double> portionQty = GeneratedColumn<double>(
      'portion_qty', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1.0));
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        foodName,
        foodNameLocal,
        mealType,
        loggedAt,
        calories,
        proteinG,
        carbsG,
        fatG,
        portionUnit,
        portionQty,
        source,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_logs';
  @override
  VerificationContext validateIntegrity(Insertable<FoodLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('food_name')) {
      context.handle(_foodNameMeta,
          foodName.isAcceptableOrUnknown(data['food_name']!, _foodNameMeta));
    } else if (isInserting) {
      context.missing(_foodNameMeta);
    }
    if (data.containsKey('food_name_local')) {
      context.handle(
          _foodNameLocalMeta,
          foodNameLocal.isAcceptableOrUnknown(
              data['food_name_local']!, _foodNameLocalMeta));
    }
    if (data.containsKey('meal_type')) {
      context.handle(_mealTypeMeta,
          mealType.isAcceptableOrUnknown(data['meal_type']!, _mealTypeMeta));
    } else if (isInserting) {
      context.missing(_mealTypeMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(_loggedAtMeta,
          loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta));
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('protein_g')) {
      context.handle(_proteinGMeta,
          proteinG.isAcceptableOrUnknown(data['protein_g']!, _proteinGMeta));
    }
    if (data.containsKey('carbs_g')) {
      context.handle(_carbsGMeta,
          carbsG.isAcceptableOrUnknown(data['carbs_g']!, _carbsGMeta));
    }
    if (data.containsKey('fat_g')) {
      context.handle(
          _fatGMeta, fatG.isAcceptableOrUnknown(data['fat_g']!, _fatGMeta));
    }
    if (data.containsKey('portion_unit')) {
      context.handle(
          _portionUnitMeta,
          portionUnit.isAcceptableOrUnknown(
              data['portion_unit']!, _portionUnitMeta));
    } else if (isInserting) {
      context.missing(_portionUnitMeta);
    }
    if (data.containsKey('portion_qty')) {
      context.handle(
          _portionQtyMeta,
          portionQty.isAcceptableOrUnknown(
              data['portion_qty']!, _portionQtyMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      foodName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_name'])!,
      foodNameLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_name_local']),
      mealType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_type'])!,
      loggedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logged_at'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories'])!,
      proteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_g'])!,
      carbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_g'])!,
      fatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g'])!,
      portionUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}portion_unit'])!,
      portionQty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_qty'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $FoodLogsTable createAlias(String alias) {
    return $FoodLogsTable(attachedDatabase, alias);
  }
}

class FoodLog extends DataClass implements Insertable<FoodLog> {
  final String id;
  final String userId;
  final String foodName;
  final String? foodNameLocal;
  final String mealType;
  final DateTime loggedAt;
  final double calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final String portionUnit;
  final double portionQty;
  final String source;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const FoodLog(
      {required this.id,
      required this.userId,
      required this.foodName,
      this.foodNameLocal,
      required this.mealType,
      required this.loggedAt,
      required this.calories,
      required this.proteinG,
      required this.carbsG,
      required this.fatG,
      required this.portionUnit,
      required this.portionQty,
      required this.source,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['food_name'] = Variable<String>(foodName);
    if (!nullToAbsent || foodNameLocal != null) {
      map['food_name_local'] = Variable<String>(foodNameLocal);
    }
    map['meal_type'] = Variable<String>(mealType);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    map['calories'] = Variable<double>(calories);
    map['protein_g'] = Variable<double>(proteinG);
    map['carbs_g'] = Variable<double>(carbsG);
    map['fat_g'] = Variable<double>(fatG);
    map['portion_unit'] = Variable<String>(portionUnit);
    map['portion_qty'] = Variable<double>(portionQty);
    map['source'] = Variable<String>(source);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  FoodLogsCompanion toCompanion(bool nullToAbsent) {
    return FoodLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      foodName: Value(foodName),
      foodNameLocal: foodNameLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(foodNameLocal),
      mealType: Value(mealType),
      loggedAt: Value(loggedAt),
      calories: Value(calories),
      proteinG: Value(proteinG),
      carbsG: Value(carbsG),
      fatG: Value(fatG),
      portionUnit: Value(portionUnit),
      portionQty: Value(portionQty),
      source: Value(source),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory FoodLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodLog(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      foodName: serializer.fromJson<String>(json['foodName']),
      foodNameLocal: serializer.fromJson<String?>(json['foodNameLocal']),
      mealType: serializer.fromJson<String>(json['mealType']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      calories: serializer.fromJson<double>(json['calories']),
      proteinG: serializer.fromJson<double>(json['proteinG']),
      carbsG: serializer.fromJson<double>(json['carbsG']),
      fatG: serializer.fromJson<double>(json['fatG']),
      portionUnit: serializer.fromJson<String>(json['portionUnit']),
      portionQty: serializer.fromJson<double>(json['portionQty']),
      source: serializer.fromJson<String>(json['source']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'foodName': serializer.toJson<String>(foodName),
      'foodNameLocal': serializer.toJson<String?>(foodNameLocal),
      'mealType': serializer.toJson<String>(mealType),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'calories': serializer.toJson<double>(calories),
      'proteinG': serializer.toJson<double>(proteinG),
      'carbsG': serializer.toJson<double>(carbsG),
      'fatG': serializer.toJson<double>(fatG),
      'portionUnit': serializer.toJson<String>(portionUnit),
      'portionQty': serializer.toJson<double>(portionQty),
      'source': serializer.toJson<String>(source),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  FoodLog copyWith(
          {String? id,
          String? userId,
          String? foodName,
          Value<String?> foodNameLocal = const Value.absent(),
          String? mealType,
          DateTime? loggedAt,
          double? calories,
          double? proteinG,
          double? carbsG,
          double? fatG,
          String? portionUnit,
          double? portionQty,
          String? source,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      FoodLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        foodName: foodName ?? this.foodName,
        foodNameLocal:
            foodNameLocal.present ? foodNameLocal.value : this.foodNameLocal,
        mealType: mealType ?? this.mealType,
        loggedAt: loggedAt ?? this.loggedAt,
        calories: calories ?? this.calories,
        proteinG: proteinG ?? this.proteinG,
        carbsG: carbsG ?? this.carbsG,
        fatG: fatG ?? this.fatG,
        portionUnit: portionUnit ?? this.portionUnit,
        portionQty: portionQty ?? this.portionQty,
        source: source ?? this.source,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  FoodLog copyWithCompanion(FoodLogsCompanion data) {
    return FoodLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      foodName: data.foodName.present ? data.foodName.value : this.foodName,
      foodNameLocal: data.foodNameLocal.present
          ? data.foodNameLocal.value
          : this.foodNameLocal,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      calories: data.calories.present ? data.calories.value : this.calories,
      proteinG: data.proteinG.present ? data.proteinG.value : this.proteinG,
      carbsG: data.carbsG.present ? data.carbsG.value : this.carbsG,
      fatG: data.fatG.present ? data.fatG.value : this.fatG,
      portionUnit:
          data.portionUnit.present ? data.portionUnit.value : this.portionUnit,
      portionQty:
          data.portionQty.present ? data.portionQty.value : this.portionQty,
      source: data.source.present ? data.source.value : this.source,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodName: $foodName, ')
          ..write('foodNameLocal: $foodNameLocal, ')
          ..write('mealType: $mealType, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('portionQty: $portionQty, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      foodName,
      foodNameLocal,
      mealType,
      loggedAt,
      calories,
      proteinG,
      carbsG,
      fatG,
      portionUnit,
      portionQty,
      source,
      syncStatus,
      remoteId,
      failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.foodName == this.foodName &&
          other.foodNameLocal == this.foodNameLocal &&
          other.mealType == this.mealType &&
          other.loggedAt == this.loggedAt &&
          other.calories == this.calories &&
          other.proteinG == this.proteinG &&
          other.carbsG == this.carbsG &&
          other.fatG == this.fatG &&
          other.portionUnit == this.portionUnit &&
          other.portionQty == this.portionQty &&
          other.source == this.source &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class FoodLogsCompanion extends UpdateCompanion<FoodLog> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> foodName;
  final Value<String?> foodNameLocal;
  final Value<String> mealType;
  final Value<DateTime> loggedAt;
  final Value<double> calories;
  final Value<double> proteinG;
  final Value<double> carbsG;
  final Value<double> fatG;
  final Value<String> portionUnit;
  final Value<double> portionQty;
  final Value<String> source;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const FoodLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.foodName = const Value.absent(),
    this.foodNameLocal = const Value.absent(),
    this.mealType = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    this.portionUnit = const Value.absent(),
    this.portionQty = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodLogsCompanion.insert({
    required String id,
    required String userId,
    required String foodName,
    this.foodNameLocal = const Value.absent(),
    required String mealType,
    required DateTime loggedAt,
    this.calories = const Value.absent(),
    this.proteinG = const Value.absent(),
    this.carbsG = const Value.absent(),
    this.fatG = const Value.absent(),
    required String portionUnit,
    this.portionQty = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        foodName = Value(foodName),
        mealType = Value(mealType),
        loggedAt = Value(loggedAt),
        portionUnit = Value(portionUnit);
  static Insertable<FoodLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? foodName,
    Expression<String>? foodNameLocal,
    Expression<String>? mealType,
    Expression<DateTime>? loggedAt,
    Expression<double>? calories,
    Expression<double>? proteinG,
    Expression<double>? carbsG,
    Expression<double>? fatG,
    Expression<String>? portionUnit,
    Expression<double>? portionQty,
    Expression<String>? source,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (foodName != null) 'food_name': foodName,
      if (foodNameLocal != null) 'food_name_local': foodNameLocal,
      if (mealType != null) 'meal_type': mealType,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (calories != null) 'calories': calories,
      if (proteinG != null) 'protein_g': proteinG,
      if (carbsG != null) 'carbs_g': carbsG,
      if (fatG != null) 'fat_g': fatG,
      if (portionUnit != null) 'portion_unit': portionUnit,
      if (portionQty != null) 'portion_qty': portionQty,
      if (source != null) 'source': source,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? foodName,
      Value<String?>? foodNameLocal,
      Value<String>? mealType,
      Value<DateTime>? loggedAt,
      Value<double>? calories,
      Value<double>? proteinG,
      Value<double>? carbsG,
      Value<double>? fatG,
      Value<String>? portionUnit,
      Value<double>? portionQty,
      Value<String>? source,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return FoodLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      foodName: foodName ?? this.foodName,
      foodNameLocal: foodNameLocal ?? this.foodNameLocal,
      mealType: mealType ?? this.mealType,
      loggedAt: loggedAt ?? this.loggedAt,
      calories: calories ?? this.calories,
      proteinG: proteinG ?? this.proteinG,
      carbsG: carbsG ?? this.carbsG,
      fatG: fatG ?? this.fatG,
      portionUnit: portionUnit ?? this.portionUnit,
      portionQty: portionQty ?? this.portionQty,
      source: source ?? this.source,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (foodName.present) {
      map['food_name'] = Variable<String>(foodName.value);
    }
    if (foodNameLocal.present) {
      map['food_name_local'] = Variable<String>(foodNameLocal.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(mealType.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (proteinG.present) {
      map['protein_g'] = Variable<double>(proteinG.value);
    }
    if (carbsG.present) {
      map['carbs_g'] = Variable<double>(carbsG.value);
    }
    if (fatG.present) {
      map['fat_g'] = Variable<double>(fatG.value);
    }
    if (portionUnit.present) {
      map['portion_unit'] = Variable<String>(portionUnit.value);
    }
    if (portionQty.present) {
      map['portion_qty'] = Variable<double>(portionQty.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('foodName: $foodName, ')
          ..write('foodNameLocal: $foodNameLocal, ')
          ..write('mealType: $mealType, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('calories: $calories, ')
          ..write('proteinG: $proteinG, ')
          ..write('carbsG: $carbsG, ')
          ..write('fatG: $fatG, ')
          ..write('portionUnit: $portionUnit, ')
          ..write('portionQty: $portionQty, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BpReadingsTable extends BpReadings
    with TableInfo<$BpReadingsTable, BpReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BpReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _systolicMeta =
      const VerificationMeta('systolic');
  @override
  late final GeneratedColumn<int> systolic = GeneratedColumn<int>(
      'systolic', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _diastolicMeta =
      const VerificationMeta('diastolic');
  @override
  late final GeneratedColumn<int> diastolic = GeneratedColumn<int>(
      'diastolic', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  @override
  late final GeneratedColumn<int> pulse = GeneratedColumn<int>(
      'pulse', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  @override
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
      'classification', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        systolic,
        diastolic,
        pulse,
        measuredAt,
        notes,
        classification,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bp_readings';
  @override
  VerificationContext validateIntegrity(Insertable<BpReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('systolic')) {
      context.handle(_systolicMeta,
          systolic.isAcceptableOrUnknown(data['systolic']!, _systolicMeta));
    } else if (isInserting) {
      context.missing(_systolicMeta);
    }
    if (data.containsKey('diastolic')) {
      context.handle(_diastolicMeta,
          diastolic.isAcceptableOrUnknown(data['diastolic']!, _diastolicMeta));
    } else if (isInserting) {
      context.missing(_diastolicMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
          _pulseMeta, pulse.isAcceptableOrUnknown(data['pulse']!, _pulseMeta));
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BpReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BpReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      systolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}systolic'])!,
      diastolic: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}diastolic'])!,
      pulse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pulse']),
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classification']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $BpReadingsTable createAlias(String alias) {
    return $BpReadingsTable(attachedDatabase, alias);
  }
}

class BpReading extends DataClass implements Insertable<BpReading> {
  final String id;
  final String userId;
  final int systolic;
  final int diastolic;
  final int? pulse;
  final DateTime measuredAt;
  final String? notes;
  final String? classification;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const BpReading(
      {required this.id,
      required this.userId,
      required this.systolic,
      required this.diastolic,
      this.pulse,
      required this.measuredAt,
      this.notes,
      this.classification,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['systolic'] = Variable<int>(systolic);
    map['diastolic'] = Variable<int>(diastolic);
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    map['measured_at'] = Variable<DateTime>(measuredAt);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || classification != null) {
      map['classification'] = Variable<String>(classification);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  BpReadingsCompanion toCompanion(bool nullToAbsent) {
    return BpReadingsCompanion(
      id: Value(id),
      userId: Value(userId),
      systolic: Value(systolic),
      diastolic: Value(diastolic),
      pulse:
          pulse == null && nullToAbsent ? const Value.absent() : Value(pulse),
      measuredAt: Value(measuredAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      classification: classification == null && nullToAbsent
          ? const Value.absent()
          : Value(classification),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory BpReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BpReading(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      systolic: serializer.fromJson<int>(json['systolic']),
      diastolic: serializer.fromJson<int>(json['diastolic']),
      pulse: serializer.fromJson<int?>(json['pulse']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      notes: serializer.fromJson<String?>(json['notes']),
      classification: serializer.fromJson<String?>(json['classification']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'systolic': serializer.toJson<int>(systolic),
      'diastolic': serializer.toJson<int>(diastolic),
      'pulse': serializer.toJson<int?>(pulse),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'notes': serializer.toJson<String?>(notes),
      'classification': serializer.toJson<String?>(classification),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  BpReading copyWith(
          {String? id,
          String? userId,
          int? systolic,
          int? diastolic,
          Value<int?> pulse = const Value.absent(),
          DateTime? measuredAt,
          Value<String?> notes = const Value.absent(),
          Value<String?> classification = const Value.absent(),
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      BpReading(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        systolic: systolic ?? this.systolic,
        diastolic: diastolic ?? this.diastolic,
        pulse: pulse.present ? pulse.value : this.pulse,
        measuredAt: measuredAt ?? this.measuredAt,
        notes: notes.present ? notes.value : this.notes,
        classification:
            classification.present ? classification.value : this.classification,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  BpReading copyWithCompanion(BpReadingsCompanion data) {
    return BpReading(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      systolic: data.systolic.present ? data.systolic.value : this.systolic,
      diastolic: data.diastolic.present ? data.diastolic.value : this.diastolic,
      pulse: data.pulse.present ? data.pulse.value : this.pulse,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      notes: data.notes.present ? data.notes.value : this.notes,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BpReading(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('notes: $notes, ')
          ..write('classification: $classification, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, systolic, diastolic, pulse,
      measuredAt, notes, classification, syncStatus, remoteId, failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BpReading &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.systolic == this.systolic &&
          other.diastolic == this.diastolic &&
          other.pulse == this.pulse &&
          other.measuredAt == this.measuredAt &&
          other.notes == this.notes &&
          other.classification == this.classification &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class BpReadingsCompanion extends UpdateCompanion<BpReading> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> systolic;
  final Value<int> diastolic;
  final Value<int?> pulse;
  final Value<DateTime> measuredAt;
  final Value<String?> notes;
  final Value<String?> classification;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const BpReadingsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.systolic = const Value.absent(),
    this.diastolic = const Value.absent(),
    this.pulse = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.classification = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BpReadingsCompanion.insert({
    required String id,
    required String userId,
    required int systolic,
    required int diastolic,
    this.pulse = const Value.absent(),
    required DateTime measuredAt,
    this.notes = const Value.absent(),
    this.classification = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        systolic = Value(systolic),
        diastolic = Value(diastolic),
        measuredAt = Value(measuredAt);
  static Insertable<BpReading> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? systolic,
    Expression<int>? diastolic,
    Expression<int>? pulse,
    Expression<DateTime>? measuredAt,
    Expression<String>? notes,
    Expression<String>? classification,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (systolic != null) 'systolic': systolic,
      if (diastolic != null) 'diastolic': diastolic,
      if (pulse != null) 'pulse': pulse,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (notes != null) 'notes': notes,
      if (classification != null) 'classification': classification,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BpReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<int>? systolic,
      Value<int>? diastolic,
      Value<int?>? pulse,
      Value<DateTime>? measuredAt,
      Value<String?>? notes,
      Value<String?>? classification,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return BpReadingsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      pulse: pulse ?? this.pulse,
      measuredAt: measuredAt ?? this.measuredAt,
      notes: notes ?? this.notes,
      classification: classification ?? this.classification,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (classification.present) {
      map['classification'] = Variable<String>(classification.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BpReadingsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('systolic: $systolic, ')
          ..write('diastolic: $diastolic, ')
          ..write('pulse: $pulse, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('notes: $notes, ')
          ..write('classification: $classification, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GlucoseReadingsTable extends GlucoseReadings
    with TableInfo<$GlucoseReadingsTable, GlucoseReading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GlucoseReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _valueMgDlMeta =
      const VerificationMeta('valueMgDl');
  @override
  late final GeneratedColumn<double> valueMgDl = GeneratedColumn<double>(
      'value_mg_dl', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _readingTypeMeta =
      const VerificationMeta('readingType');
  @override
  late final GeneratedColumn<String> readingType = GeneratedColumn<String>(
      'reading_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  @override
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
      'classification', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkedFoodLogIdMeta =
      const VerificationMeta('linkedFoodLogId');
  @override
  late final GeneratedColumn<String> linkedFoodLogId = GeneratedColumn<String>(
      'linked_food_log_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        valueMgDl,
        readingType,
        measuredAt,
        classification,
        linkedFoodLogId,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'glucose_readings';
  @override
  VerificationContext validateIntegrity(Insertable<GlucoseReading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('value_mg_dl')) {
      context.handle(
          _valueMgDlMeta,
          valueMgDl.isAcceptableOrUnknown(
              data['value_mg_dl']!, _valueMgDlMeta));
    } else if (isInserting) {
      context.missing(_valueMgDlMeta);
    }
    if (data.containsKey('reading_type')) {
      context.handle(
          _readingTypeMeta,
          readingType.isAcceptableOrUnknown(
              data['reading_type']!, _readingTypeMeta));
    } else if (isInserting) {
      context.missing(_readingTypeMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('classification')) {
      context.handle(
          _classificationMeta,
          classification.isAcceptableOrUnknown(
              data['classification']!, _classificationMeta));
    }
    if (data.containsKey('linked_food_log_id')) {
      context.handle(
          _linkedFoodLogIdMeta,
          linkedFoodLogId.isAcceptableOrUnknown(
              data['linked_food_log_id']!, _linkedFoodLogIdMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GlucoseReading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GlucoseReading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      valueMgDl: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value_mg_dl'])!,
      readingType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reading_type'])!,
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      classification: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}classification']),
      linkedFoodLogId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}linked_food_log_id']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $GlucoseReadingsTable createAlias(String alias) {
    return $GlucoseReadingsTable(attachedDatabase, alias);
  }
}

class GlucoseReading extends DataClass implements Insertable<GlucoseReading> {
  final String id;
  final String userId;
  final double valueMgDl;
  final String readingType;
  final DateTime measuredAt;
  final String? classification;
  final String? linkedFoodLogId;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const GlucoseReading(
      {required this.id,
      required this.userId,
      required this.valueMgDl,
      required this.readingType,
      required this.measuredAt,
      this.classification,
      this.linkedFoodLogId,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['value_mg_dl'] = Variable<double>(valueMgDl);
    map['reading_type'] = Variable<String>(readingType);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    if (!nullToAbsent || classification != null) {
      map['classification'] = Variable<String>(classification);
    }
    if (!nullToAbsent || linkedFoodLogId != null) {
      map['linked_food_log_id'] = Variable<String>(linkedFoodLogId);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  GlucoseReadingsCompanion toCompanion(bool nullToAbsent) {
    return GlucoseReadingsCompanion(
      id: Value(id),
      userId: Value(userId),
      valueMgDl: Value(valueMgDl),
      readingType: Value(readingType),
      measuredAt: Value(measuredAt),
      classification: classification == null && nullToAbsent
          ? const Value.absent()
          : Value(classification),
      linkedFoodLogId: linkedFoodLogId == null && nullToAbsent
          ? const Value.absent()
          : Value(linkedFoodLogId),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory GlucoseReading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GlucoseReading(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      valueMgDl: serializer.fromJson<double>(json['valueMgDl']),
      readingType: serializer.fromJson<String>(json['readingType']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      classification: serializer.fromJson<String?>(json['classification']),
      linkedFoodLogId: serializer.fromJson<String?>(json['linkedFoodLogId']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'valueMgDl': serializer.toJson<double>(valueMgDl),
      'readingType': serializer.toJson<String>(readingType),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'classification': serializer.toJson<String?>(classification),
      'linkedFoodLogId': serializer.toJson<String?>(linkedFoodLogId),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  GlucoseReading copyWith(
          {String? id,
          String? userId,
          double? valueMgDl,
          String? readingType,
          DateTime? measuredAt,
          Value<String?> classification = const Value.absent(),
          Value<String?> linkedFoodLogId = const Value.absent(),
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      GlucoseReading(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        valueMgDl: valueMgDl ?? this.valueMgDl,
        readingType: readingType ?? this.readingType,
        measuredAt: measuredAt ?? this.measuredAt,
        classification:
            classification.present ? classification.value : this.classification,
        linkedFoodLogId: linkedFoodLogId.present
            ? linkedFoodLogId.value
            : this.linkedFoodLogId,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  GlucoseReading copyWithCompanion(GlucoseReadingsCompanion data) {
    return GlucoseReading(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      valueMgDl: data.valueMgDl.present ? data.valueMgDl.value : this.valueMgDl,
      readingType:
          data.readingType.present ? data.readingType.value : this.readingType,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      classification: data.classification.present
          ? data.classification.value
          : this.classification,
      linkedFoodLogId: data.linkedFoodLogId.present
          ? data.linkedFoodLogId.value
          : this.linkedFoodLogId,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseReading(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('valueMgDl: $valueMgDl, ')
          ..write('readingType: $readingType, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('classification: $classification, ')
          ..write('linkedFoodLogId: $linkedFoodLogId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      valueMgDl,
      readingType,
      measuredAt,
      classification,
      linkedFoodLogId,
      syncStatus,
      remoteId,
      failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GlucoseReading &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.valueMgDl == this.valueMgDl &&
          other.readingType == this.readingType &&
          other.measuredAt == this.measuredAt &&
          other.classification == this.classification &&
          other.linkedFoodLogId == this.linkedFoodLogId &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class GlucoseReadingsCompanion extends UpdateCompanion<GlucoseReading> {
  final Value<String> id;
  final Value<String> userId;
  final Value<double> valueMgDl;
  final Value<String> readingType;
  final Value<DateTime> measuredAt;
  final Value<String?> classification;
  final Value<String?> linkedFoodLogId;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const GlucoseReadingsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.valueMgDl = const Value.absent(),
    this.readingType = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.classification = const Value.absent(),
    this.linkedFoodLogId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GlucoseReadingsCompanion.insert({
    required String id,
    required String userId,
    required double valueMgDl,
    required String readingType,
    required DateTime measuredAt,
    this.classification = const Value.absent(),
    this.linkedFoodLogId = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        valueMgDl = Value(valueMgDl),
        readingType = Value(readingType),
        measuredAt = Value(measuredAt);
  static Insertable<GlucoseReading> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<double>? valueMgDl,
    Expression<String>? readingType,
    Expression<DateTime>? measuredAt,
    Expression<String>? classification,
    Expression<String>? linkedFoodLogId,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (valueMgDl != null) 'value_mg_dl': valueMgDl,
      if (readingType != null) 'reading_type': readingType,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (classification != null) 'classification': classification,
      if (linkedFoodLogId != null) 'linked_food_log_id': linkedFoodLogId,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GlucoseReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<double>? valueMgDl,
      Value<String>? readingType,
      Value<DateTime>? measuredAt,
      Value<String?>? classification,
      Value<String?>? linkedFoodLogId,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return GlucoseReadingsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      valueMgDl: valueMgDl ?? this.valueMgDl,
      readingType: readingType ?? this.readingType,
      measuredAt: measuredAt ?? this.measuredAt,
      classification: classification ?? this.classification,
      linkedFoodLogId: linkedFoodLogId ?? this.linkedFoodLogId,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (valueMgDl.present) {
      map['value_mg_dl'] = Variable<double>(valueMgDl.value);
    }
    if (readingType.present) {
      map['reading_type'] = Variable<String>(readingType.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (classification.present) {
      map['classification'] = Variable<String>(classification.value);
    }
    if (linkedFoodLogId.present) {
      map['linked_food_log_id'] = Variable<String>(linkedFoodLogId.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GlucoseReadingsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('valueMgDl: $valueMgDl, ')
          ..write('readingType: $readingType, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('classification: $classification, ')
          ..write('linkedFoodLogId: $linkedFoodLogId, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sleepStartMeta =
      const VerificationMeta('sleepStart');
  @override
  late final GeneratedColumn<DateTime> sleepStart = GeneratedColumn<DateTime>(
      'sleep_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _sleepEndMeta =
      const VerificationMeta('sleepEnd');
  @override
  late final GeneratedColumn<DateTime> sleepEnd = GeneratedColumn<DateTime>(
      'sleep_end', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _qualityScoreMeta =
      const VerificationMeta('qualityScore');
  @override
  late final GeneratedColumn<int> qualityScore = GeneratedColumn<int>(
      'quality_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 32),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('manual'));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        sleepStart,
        sleepEnd,
        durationMinutes,
        qualityScore,
        source,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SleepLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('sleep_start')) {
      context.handle(
          _sleepStartMeta,
          sleepStart.isAcceptableOrUnknown(
              data['sleep_start']!, _sleepStartMeta));
    } else if (isInserting) {
      context.missing(_sleepStartMeta);
    }
    if (data.containsKey('sleep_end')) {
      context.handle(_sleepEndMeta,
          sleepEnd.isAcceptableOrUnknown(data['sleep_end']!, _sleepEndMeta));
    } else if (isInserting) {
      context.missing(_sleepEndMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
    }
    if (data.containsKey('quality_score')) {
      context.handle(
          _qualityScoreMeta,
          qualityScore.isAcceptableOrUnknown(
              data['quality_score']!, _qualityScoreMeta));
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      sleepStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sleep_start'])!,
      sleepEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sleep_end'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quality_score']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final String id;
  final String userId;
  final DateTime sleepStart;
  final DateTime sleepEnd;
  final int durationMinutes;
  final int? qualityScore;
  final String source;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const SleepLog(
      {required this.id,
      required this.userId,
      required this.sleepStart,
      required this.sleepEnd,
      required this.durationMinutes,
      this.qualityScore,
      required this.source,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['sleep_start'] = Variable<DateTime>(sleepStart);
    map['sleep_end'] = Variable<DateTime>(sleepEnd);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<int>(qualityScore);
    }
    map['source'] = Variable<String>(source);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      sleepStart: Value(sleepStart),
      sleepEnd: Value(sleepEnd),
      durationMinutes: Value(durationMinutes),
      qualityScore: qualityScore == null && nullToAbsent
          ? const Value.absent()
          : Value(qualityScore),
      source: Value(source),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory SleepLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      sleepStart: serializer.fromJson<DateTime>(json['sleepStart']),
      sleepEnd: serializer.fromJson<DateTime>(json['sleepEnd']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      qualityScore: serializer.fromJson<int?>(json['qualityScore']),
      source: serializer.fromJson<String>(json['source']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'sleepStart': serializer.toJson<DateTime>(sleepStart),
      'sleepEnd': serializer.toJson<DateTime>(sleepEnd),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'qualityScore': serializer.toJson<int?>(qualityScore),
      'source': serializer.toJson<String>(source),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  SleepLog copyWith(
          {String? id,
          String? userId,
          DateTime? sleepStart,
          DateTime? sleepEnd,
          int? durationMinutes,
          Value<int?> qualityScore = const Value.absent(),
          String? source,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      SleepLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        sleepStart: sleepStart ?? this.sleepStart,
        sleepEnd: sleepEnd ?? this.sleepEnd,
        durationMinutes: durationMinutes ?? this.durationMinutes,
        qualityScore:
            qualityScore.present ? qualityScore.value : this.qualityScore,
        source: source ?? this.source,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      sleepStart:
          data.sleepStart.present ? data.sleepStart.value : this.sleepStart,
      sleepEnd: data.sleepEnd.present ? data.sleepEnd.value : this.sleepEnd,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      qualityScore: data.qualityScore.present
          ? data.qualityScore.value
          : this.qualityScore,
      source: data.source.present ? data.source.value : this.source,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
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
          ..write('qualityScore: $qualityScore, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
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
      qualityScore,
      source,
      syncStatus,
      remoteId,
      failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.sleepStart == this.sleepStart &&
          other.sleepEnd == this.sleepEnd &&
          other.durationMinutes == this.durationMinutes &&
          other.qualityScore == this.qualityScore &&
          other.source == this.source &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> sleepStart;
  final Value<DateTime> sleepEnd;
  final Value<int> durationMinutes;
  final Value<int?> qualityScore;
  final Value<String> source;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.sleepStart = const Value.absent(),
    this.sleepEnd = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.qualityScore = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    required String id,
    required String userId,
    required DateTime sleepStart,
    required DateTime sleepEnd,
    required int durationMinutes,
    this.qualityScore = const Value.absent(),
    this.source = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        sleepStart = Value(sleepStart),
        sleepEnd = Value(sleepEnd),
        durationMinutes = Value(durationMinutes);
  static Insertable<SleepLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? sleepStart,
    Expression<DateTime>? sleepEnd,
    Expression<int>? durationMinutes,
    Expression<int>? qualityScore,
    Expression<String>? source,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (sleepStart != null) 'sleep_start': sleepStart,
      if (sleepEnd != null) 'sleep_end': sleepEnd,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (qualityScore != null) 'quality_score': qualityScore,
      if (source != null) 'source': source,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<DateTime>? sleepStart,
      Value<DateTime>? sleepEnd,
      Value<int>? durationMinutes,
      Value<int?>? qualityScore,
      Value<String>? source,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      sleepStart: sleepStart ?? this.sleepStart,
      sleepEnd: sleepEnd ?? this.sleepEnd,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      qualityScore: qualityScore ?? this.qualityScore,
      source: source ?? this.source,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (qualityScore.present) {
      map['quality_score'] = Variable<int>(qualityScore.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
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
          ..write('qualityScore: $qualityScore, ')
          ..write('source: $source, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<double> caloriesBurned = GeneratedColumn<double>(
      'calories_burned', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _distanceKmMeta =
      const VerificationMeta('distanceKm');
  @override
  late final GeneratedColumn<double> distanceKm = GeneratedColumn<double>(
      'distance_km', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _avgHeartRateMeta =
      const VerificationMeta('avgHeartRate');
  @override
  late final GeneratedColumn<int> avgHeartRate = GeneratedColumn<int>(
      'avg_heart_rate', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _exercisesJsonMeta =
      const VerificationMeta('exercisesJson');
  @override
  late final GeneratedColumn<String> exercisesJson = GeneratedColumn<String>(
      'exercises_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        type,
        startedAt,
        durationMinutes,
        caloriesBurned,
        distanceKm,
        avgHeartRate,
        exercisesJson,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(Insertable<Workout> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
          _durationMinutesMeta,
          durationMinutes.isAcceptableOrUnknown(
              data['duration_minutes']!, _durationMinutesMeta));
    }
    if (data.containsKey('calories_burned')) {
      context.handle(
          _caloriesBurnedMeta,
          caloriesBurned.isAcceptableOrUnknown(
              data['calories_burned']!, _caloriesBurnedMeta));
    }
    if (data.containsKey('distance_km')) {
      context.handle(
          _distanceKmMeta,
          distanceKm.isAcceptableOrUnknown(
              data['distance_km']!, _distanceKmMeta));
    }
    if (data.containsKey('avg_heart_rate')) {
      context.handle(
          _avgHeartRateMeta,
          avgHeartRate.isAcceptableOrUnknown(
              data['avg_heart_rate']!, _avgHeartRateMeta));
    }
    if (data.containsKey('exercises_json')) {
      context.handle(
          _exercisesJsonMeta,
          exercisesJson.isAcceptableOrUnknown(
              data['exercises_json']!, _exercisesJsonMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes']),
      caloriesBurned: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories_burned']),
      distanceKm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}distance_km']),
      avgHeartRate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}avg_heart_rate']),
      exercisesJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercises_json']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final String id;
  final String userId;
  final String name;
  final String type;
  final DateTime startedAt;
  final int? durationMinutes;
  final double? caloriesBurned;
  final double? distanceKm;
  final int? avgHeartRate;
  final String? exercisesJson;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const Workout(
      {required this.id,
      required this.userId,
      required this.name,
      required this.type,
      required this.startedAt,
      this.durationMinutes,
      this.caloriesBurned,
      this.distanceKm,
      this.avgHeartRate,
      this.exercisesJson,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['type'] = Variable<String>(type);
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<double>(caloriesBurned);
    }
    if (!nullToAbsent || distanceKm != null) {
      map['distance_km'] = Variable<double>(distanceKm);
    }
    if (!nullToAbsent || avgHeartRate != null) {
      map['avg_heart_rate'] = Variable<int>(avgHeartRate);
    }
    if (!nullToAbsent || exercisesJson != null) {
      map['exercises_json'] = Variable<String>(exercisesJson);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      type: Value(type),
      startedAt: Value(startedAt),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      caloriesBurned: caloriesBurned == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesBurned),
      distanceKm: distanceKm == null && nullToAbsent
          ? const Value.absent()
          : Value(distanceKm),
      avgHeartRate: avgHeartRate == null && nullToAbsent
          ? const Value.absent()
          : Value(avgHeartRate),
      exercisesJson: exercisesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(exercisesJson),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory Workout.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String>(json['type']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      caloriesBurned: serializer.fromJson<double?>(json['caloriesBurned']),
      distanceKm: serializer.fromJson<double?>(json['distanceKm']),
      avgHeartRate: serializer.fromJson<int?>(json['avgHeartRate']),
      exercisesJson: serializer.fromJson<String?>(json['exercisesJson']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String>(type),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'caloriesBurned': serializer.toJson<double?>(caloriesBurned),
      'distanceKm': serializer.toJson<double?>(distanceKm),
      'avgHeartRate': serializer.toJson<int?>(avgHeartRate),
      'exercisesJson': serializer.toJson<String?>(exercisesJson),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  Workout copyWith(
          {String? id,
          String? userId,
          String? name,
          String? type,
          DateTime? startedAt,
          Value<int?> durationMinutes = const Value.absent(),
          Value<double?> caloriesBurned = const Value.absent(),
          Value<double?> distanceKm = const Value.absent(),
          Value<int?> avgHeartRate = const Value.absent(),
          Value<String?> exercisesJson = const Value.absent(),
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      Workout(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        type: type ?? this.type,
        startedAt: startedAt ?? this.startedAt,
        durationMinutes: durationMinutes.present
            ? durationMinutes.value
            : this.durationMinutes,
        caloriesBurned:
            caloriesBurned.present ? caloriesBurned.value : this.caloriesBurned,
        distanceKm: distanceKm.present ? distanceKm.value : this.distanceKm,
        avgHeartRate:
            avgHeartRate.present ? avgHeartRate.value : this.avgHeartRate,
        exercisesJson:
            exercisesJson.present ? exercisesJson.value : this.exercisesJson,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      caloriesBurned: data.caloriesBurned.present
          ? data.caloriesBurned.value
          : this.caloriesBurned,
      distanceKm:
          data.distanceKm.present ? data.distanceKm.value : this.distanceKm,
      avgHeartRate: data.avgHeartRate.present
          ? data.avgHeartRate.value
          : this.avgHeartRate,
      exercisesJson: data.exercisesJson.present
          ? data.exercisesJson.value
          : this.exercisesJson,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('avgHeartRate: $avgHeartRate, ')
          ..write('exercisesJson: $exercisesJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      name,
      type,
      startedAt,
      durationMinutes,
      caloriesBurned,
      distanceKm,
      avgHeartRate,
      exercisesJson,
      syncStatus,
      remoteId,
      failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.type == this.type &&
          other.startedAt == this.startedAt &&
          other.durationMinutes == this.durationMinutes &&
          other.caloriesBurned == this.caloriesBurned &&
          other.distanceKm == this.distanceKm &&
          other.avgHeartRate == this.avgHeartRate &&
          other.exercisesJson == this.exercisesJson &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> type;
  final Value<DateTime> startedAt;
  final Value<int?> durationMinutes;
  final Value<double?> caloriesBurned;
  final Value<double?> distanceKm;
  final Value<int?> avgHeartRate;
  final Value<String?> exercisesJson;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.avgHeartRate = const Value.absent(),
    this.exercisesJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String type,
    required DateTime startedAt,
    this.durationMinutes = const Value.absent(),
    this.caloriesBurned = const Value.absent(),
    this.distanceKm = const Value.absent(),
    this.avgHeartRate = const Value.absent(),
    this.exercisesJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        type = Value(type),
        startedAt = Value(startedAt);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? startedAt,
    Expression<int>? durationMinutes,
    Expression<double>? caloriesBurned,
    Expression<double>? distanceKm,
    Expression<int>? avgHeartRate,
    Expression<String>? exercisesJson,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (startedAt != null) 'started_at': startedAt,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (caloriesBurned != null) 'calories_burned': caloriesBurned,
      if (distanceKm != null) 'distance_km': distanceKm,
      if (avgHeartRate != null) 'avg_heart_rate': avgHeartRate,
      if (exercisesJson != null) 'exercises_json': exercisesJson,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? type,
      Value<DateTime>? startedAt,
      Value<int?>? durationMinutes,
      Value<double?>? caloriesBurned,
      Value<double?>? distanceKm,
      Value<int?>? avgHeartRate,
      Value<String?>? exercisesJson,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      type: type ?? this.type,
      startedAt: startedAt ?? this.startedAt,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      distanceKm: distanceKm ?? this.distanceKm,
      avgHeartRate: avgHeartRate ?? this.avgHeartRate,
      exercisesJson: exercisesJson ?? this.exercisesJson,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<double>(caloriesBurned.value);
    }
    if (distanceKm.present) {
      map['distance_km'] = Variable<double>(distanceKm.value);
    }
    if (avgHeartRate.present) {
      map['avg_heart_rate'] = Variable<int>(avgHeartRate.value);
    }
    if (exercisesJson.present) {
      map['exercises_json'] = Variable<String>(exercisesJson.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('startedAt: $startedAt, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('caloriesBurned: $caloriesBurned, ')
          ..write('distanceKm: $distanceKm, ')
          ..write('avgHeartRate: $avgHeartRate, ')
          ..write('exercisesJson: $exercisesJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _currentStreakMeta =
      const VerificationMeta('currentStreak');
  @override
  late final GeneratedColumn<int> currentStreak = GeneratedColumn<int>(
      'current_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _longestStreakMeta =
      const VerificationMeta('longestStreak');
  @override
  late final GeneratedColumn<int> longestStreak = GeneratedColumn<int>(
      'longest_streak', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedDatesJsonMeta =
      const VerificationMeta('completedDatesJson');
  @override
  late final GeneratedColumn<String> completedDatesJson =
      GeneratedColumn<String>('completed_dates_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        name,
        icon,
        currentStreak,
        longestStreak,
        completedDatesJson,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('current_streak')) {
      context.handle(
          _currentStreakMeta,
          currentStreak.isAcceptableOrUnknown(
              data['current_streak']!, _currentStreakMeta));
    }
    if (data.containsKey('longest_streak')) {
      context.handle(
          _longestStreakMeta,
          longestStreak.isAcceptableOrUnknown(
              data['longest_streak']!, _longestStreakMeta));
    }
    if (data.containsKey('completed_dates_json')) {
      context.handle(
          _completedDatesJsonMeta,
          completedDatesJson.isAcceptableOrUnknown(
              data['completed_dates_json']!, _completedDatesJsonMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon'])!,
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      completedDatesJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}completed_dates_json']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String userId;
  final String name;
  final String icon;
  final int currentStreak;
  final int longestStreak;
  final String? completedDatesJson;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const Habit(
      {required this.id,
      required this.userId,
      required this.name,
      required this.icon,
      required this.currentStreak,
      required this.longestStreak,
      this.completedDatesJson,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<String>(icon);
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || completedDatesJson != null) {
      map['completed_dates_json'] = Variable<String>(completedDatesJson);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      icon: Value(icon),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      completedDatesJson: completedDatesJson == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDatesJson),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String>(json['icon']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      completedDatesJson:
          serializer.fromJson<String?>(json['completedDatesJson']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String>(icon),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'completedDatesJson': serializer.toJson<String?>(completedDatesJson),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  Habit copyWith(
          {String? id,
          String? userId,
          String? name,
          String? icon,
          int? currentStreak,
          int? longestStreak,
          Value<String?> completedDatesJson = const Value.absent(),
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      Habit(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        completedDatesJson: completedDatesJson.present
            ? completedDatesJson.value
            : this.completedDatesJson,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      currentStreak: data.currentStreak.present
          ? data.currentStreak.value
          : this.currentStreak,
      longestStreak: data.longestStreak.present
          ? data.longestStreak.value
          : this.longestStreak,
      completedDatesJson: data.completedDatesJson.present
          ? data.completedDatesJson.value
          : this.completedDatesJson,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('completedDatesJson: $completedDatesJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, icon, currentStreak,
      longestStreak, completedDatesJson, syncStatus, remoteId, failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.currentStreak == this.currentStreak &&
          other.longestStreak == this.longestStreak &&
          other.completedDatesJson == this.completedDatesJson &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String> icon;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<String?> completedDatesJson;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.completedDatesJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    required String icon,
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.completedDatesJson = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name),
        icon = Value(icon);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<String>? completedDatesJson,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (currentStreak != null) 'current_streak': currentStreak,
      if (longestStreak != null) 'longest_streak': longestStreak,
      if (completedDatesJson != null)
        'completed_dates_json': completedDatesJson,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? name,
      Value<String>? icon,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<String?>? completedDatesJson,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return HabitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      currentStreak: currentStreak ?? this.currentStreak,
      longestStreak: longestStreak ?? this.longestStreak,
      completedDatesJson: completedDatesJson ?? this.completedDatesJson,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (currentStreak.present) {
      map['current_streak'] = Variable<int>(currentStreak.value);
    }
    if (longestStreak.present) {
      map['longest_streak'] = Variable<int>(longestStreak.value);
    }
    if (completedDatesJson.present) {
      map['completed_dates_json'] = Variable<String>(completedDatesJson.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('currentStreak: $currentStreak, ')
          ..write('longestStreak: $longestStreak, ')
          ..write('completedDatesJson: $completedDatesJson, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 0, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _moodEmojiMeta =
      const VerificationMeta('moodEmoji');
  @override
  late final GeneratedColumn<String> moodEmoji = GeneratedColumn<String>(
      'mood_emoji', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _moodScoreMeta =
      const VerificationMeta('moodScore');
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
      'mood_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tagsJsonMeta =
      const VerificationMeta('tagsJson');
  @override
  late final GeneratedColumn<String> tagsJson = GeneratedColumn<String>(
      'tags_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        body,
        moodEmoji,
        moodScore,
        tagsJson,
        createdAt,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries';
  @override
  VerificationContext validateIntegrity(Insertable<JournalEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('mood_emoji')) {
      context.handle(_moodEmojiMeta,
          moodEmoji.isAcceptableOrUnknown(data['mood_emoji']!, _moodEmojiMeta));
    }
    if (data.containsKey('mood_score')) {
      context.handle(_moodScoreMeta,
          moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta));
    }
    if (data.containsKey('tags_json')) {
      context.handle(_tagsJsonMeta,
          tagsJson.isAcceptableOrUnknown(data['tags_json']!, _tagsJsonMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JournalEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      moodEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood_emoji']),
      moodScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood_score']),
      tagsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags_json']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $JournalEntriesTable createAlias(String alias) {
    return $JournalEntriesTable(attachedDatabase, alias);
  }
}

class JournalEntry extends DataClass implements Insertable<JournalEntry> {
  final String id;
  final String userId;
  final String? title;
  final String body;
  final String? moodEmoji;
  final int? moodScore;
  final String? tagsJson;
  final DateTime createdAt;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const JournalEntry(
      {required this.id,
      required this.userId,
      this.title,
      required this.body,
      this.moodEmoji,
      this.moodScore,
      this.tagsJson,
      required this.createdAt,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || moodEmoji != null) {
      map['mood_emoji'] = Variable<String>(moodEmoji);
    }
    if (!nullToAbsent || moodScore != null) {
      map['mood_score'] = Variable<int>(moodScore);
    }
    if (!nullToAbsent || tagsJson != null) {
      map['tags_json'] = Variable<String>(tagsJson);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  JournalEntriesCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      body: Value(body),
      moodEmoji: moodEmoji == null && nullToAbsent
          ? const Value.absent()
          : Value(moodEmoji),
      moodScore: moodScore == null && nullToAbsent
          ? const Value.absent()
          : Value(moodScore),
      tagsJson: tagsJson == null && nullToAbsent
          ? const Value.absent()
          : Value(tagsJson),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory JournalEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      title: serializer.fromJson<String?>(json['title']),
      body: serializer.fromJson<String>(json['body']),
      moodEmoji: serializer.fromJson<String?>(json['moodEmoji']),
      moodScore: serializer.fromJson<int?>(json['moodScore']),
      tagsJson: serializer.fromJson<String?>(json['tagsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'title': serializer.toJson<String?>(title),
      'body': serializer.toJson<String>(body),
      'moodEmoji': serializer.toJson<String?>(moodEmoji),
      'moodScore': serializer.toJson<int?>(moodScore),
      'tagsJson': serializer.toJson<String?>(tagsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  JournalEntry copyWith(
          {String? id,
          String? userId,
          Value<String?> title = const Value.absent(),
          String? body,
          Value<String?> moodEmoji = const Value.absent(),
          Value<int?> moodScore = const Value.absent(),
          Value<String?> tagsJson = const Value.absent(),
          DateTime? createdAt,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      JournalEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title.present ? title.value : this.title,
        body: body ?? this.body,
        moodEmoji: moodEmoji.present ? moodEmoji.value : this.moodEmoji,
        moodScore: moodScore.present ? moodScore.value : this.moodScore,
        tagsJson: tagsJson.present ? tagsJson.value : this.tagsJson,
        createdAt: createdAt ?? this.createdAt,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  JournalEntry copyWithCompanion(JournalEntriesCompanion data) {
    return JournalEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      body: data.body.present ? data.body.value : this.body,
      moodEmoji: data.moodEmoji.present ? data.moodEmoji.value : this.moodEmoji,
      moodScore: data.moodScore.present ? data.moodScore.value : this.moodScore,
      tagsJson: data.tagsJson.present ? data.tagsJson.value : this.tagsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('moodEmoji: $moodEmoji, ')
          ..write('moodScore: $moodScore, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, body, moodEmoji, moodScore,
      tagsJson, createdAt, syncStatus, remoteId, failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.body == this.body &&
          other.moodEmoji == this.moodEmoji &&
          other.moodScore == this.moodScore &&
          other.tagsJson == this.tagsJson &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> title;
  final Value<String> body;
  final Value<String?> moodEmoji;
  final Value<int?> moodScore;
  final Value<String?> tagsJson;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const JournalEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.body = const Value.absent(),
    this.moodEmoji = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.tagsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesCompanion.insert({
    required String id,
    required String userId,
    this.title = const Value.absent(),
    required String body,
    this.moodEmoji = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.tagsJson = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        body = Value(body),
        createdAt = Value(createdAt);
  static Insertable<JournalEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? moodEmoji,
    Expression<int>? moodScore,
    Expression<String>? tagsJson,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (body != null) 'body': body,
      if (moodEmoji != null) 'mood_emoji': moodEmoji,
      if (moodScore != null) 'mood_score': moodScore,
      if (tagsJson != null) 'tags_json': tagsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String?>? title,
      Value<String>? body,
      Value<String?>? moodEmoji,
      Value<int?>? moodScore,
      Value<String?>? tagsJson,
      Value<DateTime>? createdAt,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return JournalEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      body: body ?? this.body,
      moodEmoji: moodEmoji ?? this.moodEmoji,
      moodScore: moodScore ?? this.moodScore,
      tagsJson: tagsJson ?? this.tagsJson,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (moodEmoji.present) {
      map['mood_emoji'] = Variable<String>(moodEmoji.value);
    }
    if (moodScore.present) {
      map['mood_score'] = Variable<int>(moodScore.value);
    }
    if (tagsJson.present) {
      map['tags_json'] = Variable<String>(tagsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('body: $body, ')
          ..write('moodEmoji: $moodEmoji, ')
          ..write('moodScore: $moodScore, ')
          ..write('tagsJson: $tagsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeddingPlansTable extends WeddingPlans
    with TableInfo<$WeddingPlansTable, WeddingPlan> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeddingPlansTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _relationMeta =
      const VerificationMeta('relation');
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
      'relation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _firstEventTsMeta =
      const VerificationMeta('firstEventTs');
  @override
  late final GeneratedColumn<DateTime> firstEventTs = GeneratedColumn<DateTime>(
      'first_event_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _lastEventTsMeta =
      const VerificationMeta('lastEventTs');
  @override
  late final GeneratedColumn<DateTime> lastEventTs = GeneratedColumn<DateTime>(
      'last_event_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _eventsJsonMeta =
      const VerificationMeta('eventsJson');
  @override
  late final GeneratedColumn<String> eventsJson = GeneratedColumn<String>(
      'events_json', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _prepWeeksMeta =
      const VerificationMeta('prepWeeks');
  @override
  late final GeneratedColumn<int> prepWeeks = GeneratedColumn<int>(
      'prep_weeks', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _primaryGoalMeta =
      const VerificationMeta('primaryGoal');
  @override
  late final GeneratedColumn<String> primaryGoal = GeneratedColumn<String>(
      'primary_goal', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _currentPhaseMeta =
      const VerificationMeta('currentPhase');
  @override
  late final GeneratedColumn<String> currentPhase = GeneratedColumn<String>(
      'current_phase', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        role,
        relation,
        firstEventTs,
        lastEventTs,
        eventsJson,
        prepWeeks,
        primaryGoal,
        currentPhase,
        createdAt,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wedding_plans';
  @override
  VerificationContext validateIntegrity(Insertable<WeddingPlan> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(_relationMeta,
          relation.isAcceptableOrUnknown(data['relation']!, _relationMeta));
    }
    if (data.containsKey('first_event_ts')) {
      context.handle(
          _firstEventTsMeta,
          firstEventTs.isAcceptableOrUnknown(
              data['first_event_ts']!, _firstEventTsMeta));
    } else if (isInserting) {
      context.missing(_firstEventTsMeta);
    }
    if (data.containsKey('last_event_ts')) {
      context.handle(
          _lastEventTsMeta,
          lastEventTs.isAcceptableOrUnknown(
              data['last_event_ts']!, _lastEventTsMeta));
    } else if (isInserting) {
      context.missing(_lastEventTsMeta);
    }
    if (data.containsKey('events_json')) {
      context.handle(
          _eventsJsonMeta,
          eventsJson.isAcceptableOrUnknown(
              data['events_json']!, _eventsJsonMeta));
    } else if (isInserting) {
      context.missing(_eventsJsonMeta);
    }
    if (data.containsKey('prep_weeks')) {
      context.handle(_prepWeeksMeta,
          prepWeeks.isAcceptableOrUnknown(data['prep_weeks']!, _prepWeeksMeta));
    } else if (isInserting) {
      context.missing(_prepWeeksMeta);
    }
    if (data.containsKey('primary_goal')) {
      context.handle(
          _primaryGoalMeta,
          primaryGoal.isAcceptableOrUnknown(
              data['primary_goal']!, _primaryGoalMeta));
    } else if (isInserting) {
      context.missing(_primaryGoalMeta);
    }
    if (data.containsKey('current_phase')) {
      context.handle(
          _currentPhaseMeta,
          currentPhase.isAcceptableOrUnknown(
              data['current_phase']!, _currentPhaseMeta));
    } else if (isInserting) {
      context.missing(_currentPhaseMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeddingPlan map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeddingPlan(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      relation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}relation']),
      firstEventTs: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}first_event_ts'])!,
      lastEventTs: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_event_ts'])!,
      eventsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}events_json'])!,
      prepWeeks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prep_weeks'])!,
      primaryGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_goal'])!,
      currentPhase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_phase'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $WeddingPlansTable createAlias(String alias) {
    return $WeddingPlansTable(attachedDatabase, alias);
  }
}

class WeddingPlan extends DataClass implements Insertable<WeddingPlan> {
  final String id;
  final String userId;
  final String role;
  final String? relation;
  final DateTime firstEventTs;
  final DateTime lastEventTs;
  final String eventsJson;
  final int prepWeeks;
  final String primaryGoal;
  final String currentPhase;
  final DateTime createdAt;
  final String syncStatus;
  const WeddingPlan(
      {required this.id,
      required this.userId,
      required this.role,
      this.relation,
      required this.firstEventTs,
      required this.lastEventTs,
      required this.eventsJson,
      required this.prepWeeks,
      required this.primaryGoal,
      required this.currentPhase,
      required this.createdAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['role'] = Variable<String>(role);
    if (!nullToAbsent || relation != null) {
      map['relation'] = Variable<String>(relation);
    }
    map['first_event_ts'] = Variable<DateTime>(firstEventTs);
    map['last_event_ts'] = Variable<DateTime>(lastEventTs);
    map['events_json'] = Variable<String>(eventsJson);
    map['prep_weeks'] = Variable<int>(prepWeeks);
    map['primary_goal'] = Variable<String>(primaryGoal);
    map['current_phase'] = Variable<String>(currentPhase);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  WeddingPlansCompanion toCompanion(bool nullToAbsent) {
    return WeddingPlansCompanion(
      id: Value(id),
      userId: Value(userId),
      role: Value(role),
      relation: relation == null && nullToAbsent
          ? const Value.absent()
          : Value(relation),
      firstEventTs: Value(firstEventTs),
      lastEventTs: Value(lastEventTs),
      eventsJson: Value(eventsJson),
      prepWeeks: Value(prepWeeks),
      primaryGoal: Value(primaryGoal),
      currentPhase: Value(currentPhase),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory WeddingPlan.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeddingPlan(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      role: serializer.fromJson<String>(json['role']),
      relation: serializer.fromJson<String?>(json['relation']),
      firstEventTs: serializer.fromJson<DateTime>(json['firstEventTs']),
      lastEventTs: serializer.fromJson<DateTime>(json['lastEventTs']),
      eventsJson: serializer.fromJson<String>(json['eventsJson']),
      prepWeeks: serializer.fromJson<int>(json['prepWeeks']),
      primaryGoal: serializer.fromJson<String>(json['primaryGoal']),
      currentPhase: serializer.fromJson<String>(json['currentPhase']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'role': serializer.toJson<String>(role),
      'relation': serializer.toJson<String?>(relation),
      'firstEventTs': serializer.toJson<DateTime>(firstEventTs),
      'lastEventTs': serializer.toJson<DateTime>(lastEventTs),
      'eventsJson': serializer.toJson<String>(eventsJson),
      'prepWeeks': serializer.toJson<int>(prepWeeks),
      'primaryGoal': serializer.toJson<String>(primaryGoal),
      'currentPhase': serializer.toJson<String>(currentPhase),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  WeddingPlan copyWith(
          {String? id,
          String? userId,
          String? role,
          Value<String?> relation = const Value.absent(),
          DateTime? firstEventTs,
          DateTime? lastEventTs,
          String? eventsJson,
          int? prepWeeks,
          String? primaryGoal,
          String? currentPhase,
          DateTime? createdAt,
          String? syncStatus}) =>
      WeddingPlan(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        relation: relation.present ? relation.value : this.relation,
        firstEventTs: firstEventTs ?? this.firstEventTs,
        lastEventTs: lastEventTs ?? this.lastEventTs,
        eventsJson: eventsJson ?? this.eventsJson,
        prepWeeks: prepWeeks ?? this.prepWeeks,
        primaryGoal: primaryGoal ?? this.primaryGoal,
        currentPhase: currentPhase ?? this.currentPhase,
        createdAt: createdAt ?? this.createdAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  WeddingPlan copyWithCompanion(WeddingPlansCompanion data) {
    return WeddingPlan(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      role: data.role.present ? data.role.value : this.role,
      relation: data.relation.present ? data.relation.value : this.relation,
      firstEventTs: data.firstEventTs.present
          ? data.firstEventTs.value
          : this.firstEventTs,
      lastEventTs:
          data.lastEventTs.present ? data.lastEventTs.value : this.lastEventTs,
      eventsJson:
          data.eventsJson.present ? data.eventsJson.value : this.eventsJson,
      prepWeeks: data.prepWeeks.present ? data.prepWeeks.value : this.prepWeeks,
      primaryGoal:
          data.primaryGoal.present ? data.primaryGoal.value : this.primaryGoal,
      currentPhase: data.currentPhase.present
          ? data.currentPhase.value
          : this.currentPhase,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeddingPlan(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('relation: $relation, ')
          ..write('firstEventTs: $firstEventTs, ')
          ..write('lastEventTs: $lastEventTs, ')
          ..write('eventsJson: $eventsJson, ')
          ..write('prepWeeks: $prepWeeks, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('currentPhase: $currentPhase, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      userId,
      role,
      relation,
      firstEventTs,
      lastEventTs,
      eventsJson,
      prepWeeks,
      primaryGoal,
      currentPhase,
      createdAt,
      syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeddingPlan &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.role == this.role &&
          other.relation == this.relation &&
          other.firstEventTs == this.firstEventTs &&
          other.lastEventTs == this.lastEventTs &&
          other.eventsJson == this.eventsJson &&
          other.prepWeeks == this.prepWeeks &&
          other.primaryGoal == this.primaryGoal &&
          other.currentPhase == this.currentPhase &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class WeddingPlansCompanion extends UpdateCompanion<WeddingPlan> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> role;
  final Value<String?> relation;
  final Value<DateTime> firstEventTs;
  final Value<DateTime> lastEventTs;
  final Value<String> eventsJson;
  final Value<int> prepWeeks;
  final Value<String> primaryGoal;
  final Value<String> currentPhase;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const WeddingPlansCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.role = const Value.absent(),
    this.relation = const Value.absent(),
    this.firstEventTs = const Value.absent(),
    this.lastEventTs = const Value.absent(),
    this.eventsJson = const Value.absent(),
    this.prepWeeks = const Value.absent(),
    this.primaryGoal = const Value.absent(),
    this.currentPhase = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeddingPlansCompanion.insert({
    required String id,
    required String userId,
    required String role,
    this.relation = const Value.absent(),
    required DateTime firstEventTs,
    required DateTime lastEventTs,
    required String eventsJson,
    required int prepWeeks,
    required String primaryGoal,
    required String currentPhase,
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        role = Value(role),
        firstEventTs = Value(firstEventTs),
        lastEventTs = Value(lastEventTs),
        eventsJson = Value(eventsJson),
        prepWeeks = Value(prepWeeks),
        primaryGoal = Value(primaryGoal),
        currentPhase = Value(currentPhase),
        createdAt = Value(createdAt);
  static Insertable<WeddingPlan> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<String>? relation,
    Expression<DateTime>? firstEventTs,
    Expression<DateTime>? lastEventTs,
    Expression<String>? eventsJson,
    Expression<int>? prepWeeks,
    Expression<String>? primaryGoal,
    Expression<String>? currentPhase,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (role != null) 'role': role,
      if (relation != null) 'relation': relation,
      if (firstEventTs != null) 'first_event_ts': firstEventTs,
      if (lastEventTs != null) 'last_event_ts': lastEventTs,
      if (eventsJson != null) 'events_json': eventsJson,
      if (prepWeeks != null) 'prep_weeks': prepWeeks,
      if (primaryGoal != null) 'primary_goal': primaryGoal,
      if (currentPhase != null) 'current_phase': currentPhase,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeddingPlansCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? role,
      Value<String?>? relation,
      Value<DateTime>? firstEventTs,
      Value<DateTime>? lastEventTs,
      Value<String>? eventsJson,
      Value<int>? prepWeeks,
      Value<String>? primaryGoal,
      Value<String>? currentPhase,
      Value<DateTime>? createdAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return WeddingPlansCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      relation: relation ?? this.relation,
      firstEventTs: firstEventTs ?? this.firstEventTs,
      lastEventTs: lastEventTs ?? this.lastEventTs,
      eventsJson: eventsJson ?? this.eventsJson,
      prepWeeks: prepWeeks ?? this.prepWeeks,
      primaryGoal: primaryGoal ?? this.primaryGoal,
      currentPhase: currentPhase ?? this.currentPhase,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (relation.present) {
      map['relation'] = Variable<String>(relation.value);
    }
    if (firstEventTs.present) {
      map['first_event_ts'] = Variable<DateTime>(firstEventTs.value);
    }
    if (lastEventTs.present) {
      map['last_event_ts'] = Variable<DateTime>(lastEventTs.value);
    }
    if (eventsJson.present) {
      map['events_json'] = Variable<String>(eventsJson.value);
    }
    if (prepWeeks.present) {
      map['prep_weeks'] = Variable<int>(prepWeeks.value);
    }
    if (primaryGoal.present) {
      map['primary_goal'] = Variable<String>(primaryGoal.value);
    }
    if (currentPhase.present) {
      map['current_phase'] = Variable<String>(currentPhase.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeddingPlansCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('role: $role, ')
          ..write('relation: $relation, ')
          ..write('firstEventTs: $firstEventTs, ')
          ..write('lastEventTs: $lastEventTs, ')
          ..write('eventsJson: $eventsJson, ')
          ..write('prepWeeks: $prepWeeks, ')
          ..write('primaryGoal: $primaryGoal, ')
          ..write('currentPhase: $currentPhase, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeddingMealLogsTable extends WeddingMealLogs
    with TableInfo<$WeddingMealLogsTable, WeddingMealLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeddingMealLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES wedding_plans (id)'));
  static const VerificationMeta _eventTagMeta =
      const VerificationMeta('eventTag');
  @override
  late final GeneratedColumn<String> eventTag = GeneratedColumn<String>(
      'event_tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _timingMeta = const VerificationMeta('timing');
  @override
  late final GeneratedColumn<String> timing = GeneratedColumn<String>(
      'timing', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<DateTime> loggedAt = GeneratedColumn<DateTime>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        planId,
        eventTag,
        timing,
        loggedAt,
        calories,
        notes,
        syncStatus
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wedding_meal_logs';
  @override
  VerificationContext validateIntegrity(Insertable<WeddingMealLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('plan_id')) {
      context.handle(_planIdMeta,
          planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta));
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('event_tag')) {
      context.handle(_eventTagMeta,
          eventTag.isAcceptableOrUnknown(data['event_tag']!, _eventTagMeta));
    } else if (isInserting) {
      context.missing(_eventTagMeta);
    }
    if (data.containsKey('timing')) {
      context.handle(_timingMeta,
          timing.isAcceptableOrUnknown(data['timing']!, _timingMeta));
    } else if (isInserting) {
      context.missing(_timingMeta);
    }
    if (data.containsKey('logged_at')) {
      context.handle(_loggedAtMeta,
          loggedAt.isAcceptableOrUnknown(data['logged_at']!, _loggedAtMeta));
    } else if (isInserting) {
      context.missing(_loggedAtMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeddingMealLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeddingMealLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      planId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plan_id'])!,
      eventTag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_tag'])!,
      timing: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}timing'])!,
      loggedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}logged_at'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $WeddingMealLogsTable createAlias(String alias) {
    return $WeddingMealLogsTable(attachedDatabase, alias);
  }
}

class WeddingMealLog extends DataClass implements Insertable<WeddingMealLog> {
  final String id;
  final String userId;
  final String planId;
  final String eventTag;
  final String timing;
  final DateTime loggedAt;
  final double? calories;
  final String? notes;
  final String syncStatus;
  const WeddingMealLog(
      {required this.id,
      required this.userId,
      required this.planId,
      required this.eventTag,
      required this.timing,
      required this.loggedAt,
      this.calories,
      this.notes,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['plan_id'] = Variable<String>(planId);
    map['event_tag'] = Variable<String>(eventTag);
    map['timing'] = Variable<String>(timing);
    map['logged_at'] = Variable<DateTime>(loggedAt);
    if (!nullToAbsent || calories != null) {
      map['calories'] = Variable<double>(calories);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  WeddingMealLogsCompanion toCompanion(bool nullToAbsent) {
    return WeddingMealLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      planId: Value(planId),
      eventTag: Value(eventTag),
      timing: Value(timing),
      loggedAt: Value(loggedAt),
      calories: calories == null && nullToAbsent
          ? const Value.absent()
          : Value(calories),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      syncStatus: Value(syncStatus),
    );
  }

  factory WeddingMealLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeddingMealLog(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      planId: serializer.fromJson<String>(json['planId']),
      eventTag: serializer.fromJson<String>(json['eventTag']),
      timing: serializer.fromJson<String>(json['timing']),
      loggedAt: serializer.fromJson<DateTime>(json['loggedAt']),
      calories: serializer.fromJson<double?>(json['calories']),
      notes: serializer.fromJson<String?>(json['notes']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'planId': serializer.toJson<String>(planId),
      'eventTag': serializer.toJson<String>(eventTag),
      'timing': serializer.toJson<String>(timing),
      'loggedAt': serializer.toJson<DateTime>(loggedAt),
      'calories': serializer.toJson<double?>(calories),
      'notes': serializer.toJson<String?>(notes),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  WeddingMealLog copyWith(
          {String? id,
          String? userId,
          String? planId,
          String? eventTag,
          String? timing,
          DateTime? loggedAt,
          Value<double?> calories = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? syncStatus}) =>
      WeddingMealLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        planId: planId ?? this.planId,
        eventTag: eventTag ?? this.eventTag,
        timing: timing ?? this.timing,
        loggedAt: loggedAt ?? this.loggedAt,
        calories: calories.present ? calories.value : this.calories,
        notes: notes.present ? notes.value : this.notes,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  WeddingMealLog copyWithCompanion(WeddingMealLogsCompanion data) {
    return WeddingMealLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      planId: data.planId.present ? data.planId.value : this.planId,
      eventTag: data.eventTag.present ? data.eventTag.value : this.eventTag,
      timing: data.timing.present ? data.timing.value : this.timing,
      loggedAt: data.loggedAt.present ? data.loggedAt.value : this.loggedAt,
      calories: data.calories.present ? data.calories.value : this.calories,
      notes: data.notes.present ? data.notes.value : this.notes,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeddingMealLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('planId: $planId, ')
          ..write('eventTag: $eventTag, ')
          ..write('timing: $timing, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('calories: $calories, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, planId, eventTag, timing,
      loggedAt, calories, notes, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeddingMealLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.planId == this.planId &&
          other.eventTag == this.eventTag &&
          other.timing == this.timing &&
          other.loggedAt == this.loggedAt &&
          other.calories == this.calories &&
          other.notes == this.notes &&
          other.syncStatus == this.syncStatus);
}

class WeddingMealLogsCompanion extends UpdateCompanion<WeddingMealLog> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> planId;
  final Value<String> eventTag;
  final Value<String> timing;
  final Value<DateTime> loggedAt;
  final Value<double?> calories;
  final Value<String?> notes;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const WeddingMealLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.planId = const Value.absent(),
    this.eventTag = const Value.absent(),
    this.timing = const Value.absent(),
    this.loggedAt = const Value.absent(),
    this.calories = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeddingMealLogsCompanion.insert({
    required String id,
    required String userId,
    required String planId,
    required String eventTag,
    required String timing,
    required DateTime loggedAt,
    this.calories = const Value.absent(),
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        planId = Value(planId),
        eventTag = Value(eventTag),
        timing = Value(timing),
        loggedAt = Value(loggedAt);
  static Insertable<WeddingMealLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? planId,
    Expression<String>? eventTag,
    Expression<String>? timing,
    Expression<DateTime>? loggedAt,
    Expression<double>? calories,
    Expression<String>? notes,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (planId != null) 'plan_id': planId,
      if (eventTag != null) 'event_tag': eventTag,
      if (timing != null) 'timing': timing,
      if (loggedAt != null) 'logged_at': loggedAt,
      if (calories != null) 'calories': calories,
      if (notes != null) 'notes': notes,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeddingMealLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? planId,
      Value<String>? eventTag,
      Value<String>? timing,
      Value<DateTime>? loggedAt,
      Value<double?>? calories,
      Value<String?>? notes,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return WeddingMealLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      planId: planId ?? this.planId,
      eventTag: eventTag ?? this.eventTag,
      timing: timing ?? this.timing,
      loggedAt: loggedAt ?? this.loggedAt,
      calories: calories ?? this.calories,
      notes: notes ?? this.notes,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (eventTag.present) {
      map['event_tag'] = Variable<String>(eventTag.value);
    }
    if (timing.present) {
      map['timing'] = Variable<String>(timing.value);
    }
    if (loggedAt.present) {
      map['logged_at'] = Variable<DateTime>(loggedAt.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeddingMealLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('planId: $planId, ')
          ..write('eventTag: $eventTag, ')
          ..write('timing: $timing, ')
          ..write('loggedAt: $loggedAt, ')
          ..write('calories: $calories, ')
          ..write('notes: $notes, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StepCountsTable extends StepCounts
    with TableInfo<$StepCountsTable, StepCount> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StepCountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
      'count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns => [id, userId, date, count, syncStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'step_counts';
  @override
  VerificationContext validateIntegrity(Insertable<StepCount> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('count')) {
      context.handle(
          _countMeta, count.isAcceptableOrUnknown(data['count']!, _countMeta));
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StepCount map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StepCount(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      count: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}count'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $StepCountsTable createAlias(String alias) {
    return $StepCountsTable(attachedDatabase, alias);
  }
}

class StepCount extends DataClass implements Insertable<StepCount> {
  final String id;
  final String userId;
  final DateTime date;
  final int count;
  final String syncStatus;
  const StepCount(
      {required this.id,
      required this.userId,
      required this.date,
      required this.count,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['date'] = Variable<DateTime>(date);
    map['count'] = Variable<int>(count);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  StepCountsCompanion toCompanion(bool nullToAbsent) {
    return StepCountsCompanion(
      id: Value(id),
      userId: Value(userId),
      date: Value(date),
      count: Value(count),
      syncStatus: Value(syncStatus),
    );
  }

  factory StepCount.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StepCount(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      date: serializer.fromJson<DateTime>(json['date']),
      count: serializer.fromJson<int>(json['count']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'date': serializer.toJson<DateTime>(date),
      'count': serializer.toJson<int>(count),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  StepCount copyWith(
          {String? id,
          String? userId,
          DateTime? date,
          int? count,
          String? syncStatus}) =>
      StepCount(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        date: date ?? this.date,
        count: count ?? this.count,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  StepCount copyWithCompanion(StepCountsCompanion data) {
    return StepCount(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      date: data.date.present ? data.date.value : this.date,
      count: data.count.present ? data.count.value : this.count,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StepCount(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('count: $count, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, date, count, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StepCount &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.date == this.date &&
          other.count == this.count &&
          other.syncStatus == this.syncStatus);
}

class StepCountsCompanion extends UpdateCompanion<StepCount> {
  final Value<String> id;
  final Value<String> userId;
  final Value<DateTime> date;
  final Value<int> count;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const StepCountsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.date = const Value.absent(),
    this.count = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StepCountsCompanion.insert({
    required String id,
    required String userId,
    required DateTime date,
    this.count = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        date = Value(date);
  static Insertable<StepCount> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<DateTime>? date,
    Expression<int>? count,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (date != null) 'date': date,
      if (count != null) 'count': count,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StepCountsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<DateTime>? date,
      Value<int>? count,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return StepCountsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      date: date ?? this.date,
      count: count ?? this.count,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StepCountsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('date: $date, ')
          ..write('count: $count, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $Spo2ReadingsTable extends Spo2Readings
    with TableInfo<$Spo2ReadingsTable, Spo2Reading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $Spo2ReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _spo2PercentageMeta =
      const VerificationMeta('spo2Percentage');
  @override
  late final GeneratedColumn<int> spo2Percentage = GeneratedColumn<int>(
      'spo2_percentage', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _pulseMeta = const VerificationMeta('pulse');
  @override
  late final GeneratedColumn<int> pulse = GeneratedColumn<int>(
      'pulse', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        spo2Percentage,
        pulse,
        measuredAt,
        syncStatus,
        remoteId,
        failedAttempts
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'spo2_readings';
  @override
  VerificationContext validateIntegrity(Insertable<Spo2Reading> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('spo2_percentage')) {
      context.handle(
          _spo2PercentageMeta,
          spo2Percentage.isAcceptableOrUnknown(
              data['spo2_percentage']!, _spo2PercentageMeta));
    } else if (isInserting) {
      context.missing(_spo2PercentageMeta);
    }
    if (data.containsKey('pulse')) {
      context.handle(
          _pulseMeta, pulse.isAcceptableOrUnknown(data['pulse']!, _pulseMeta));
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Spo2Reading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Spo2Reading(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      spo2Percentage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}spo2_percentage'])!,
      pulse: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}pulse']),
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $Spo2ReadingsTable createAlias(String alias) {
    return $Spo2ReadingsTable(attachedDatabase, alias);
  }
}

class Spo2Reading extends DataClass implements Insertable<Spo2Reading> {
  final String id;
  final String userId;
  final int spo2Percentage;
  final int? pulse;
  final DateTime measuredAt;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const Spo2Reading(
      {required this.id,
      required this.userId,
      required this.spo2Percentage,
      this.pulse,
      required this.measuredAt,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['spo2_percentage'] = Variable<int>(spo2Percentage);
    if (!nullToAbsent || pulse != null) {
      map['pulse'] = Variable<int>(pulse);
    }
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  Spo2ReadingsCompanion toCompanion(bool nullToAbsent) {
    return Spo2ReadingsCompanion(
      id: Value(id),
      userId: Value(userId),
      spo2Percentage: Value(spo2Percentage),
      pulse:
          pulse == null && nullToAbsent ? const Value.absent() : Value(pulse),
      measuredAt: Value(measuredAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory Spo2Reading.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Spo2Reading(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      spo2Percentage: serializer.fromJson<int>(json['spo2Percentage']),
      pulse: serializer.fromJson<int?>(json['pulse']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'spo2Percentage': serializer.toJson<int>(spo2Percentage),
      'pulse': serializer.toJson<int?>(pulse),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  Spo2Reading copyWith(
          {String? id,
          String? userId,
          int? spo2Percentage,
          Value<int?> pulse = const Value.absent(),
          DateTime? measuredAt,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      Spo2Reading(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        spo2Percentage: spo2Percentage ?? this.spo2Percentage,
        pulse: pulse.present ? pulse.value : this.pulse,
        measuredAt: measuredAt ?? this.measuredAt,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  Spo2Reading copyWithCompanion(Spo2ReadingsCompanion data) {
    return Spo2Reading(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      spo2Percentage: data.spo2Percentage.present
          ? data.spo2Percentage.value
          : this.spo2Percentage,
      pulse: data.pulse.present ? data.pulse.value : this.pulse,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Spo2Reading(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('pulse: $pulse, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, spo2Percentage, pulse, measuredAt,
      syncStatus, remoteId, failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Spo2Reading &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.spo2Percentage == this.spo2Percentage &&
          other.pulse == this.pulse &&
          other.measuredAt == this.measuredAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class Spo2ReadingsCompanion extends UpdateCompanion<Spo2Reading> {
  final Value<String> id;
  final Value<String> userId;
  final Value<int> spo2Percentage;
  final Value<int?> pulse;
  final Value<DateTime> measuredAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const Spo2ReadingsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.spo2Percentage = const Value.absent(),
    this.pulse = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  Spo2ReadingsCompanion.insert({
    required String id,
    required String userId,
    required int spo2Percentage,
    this.pulse = const Value.absent(),
    required DateTime measuredAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        spo2Percentage = Value(spo2Percentage),
        measuredAt = Value(measuredAt);
  static Insertable<Spo2Reading> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<int>? spo2Percentage,
    Expression<int>? pulse,
    Expression<DateTime>? measuredAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (spo2Percentage != null) 'spo2_percentage': spo2Percentage,
      if (pulse != null) 'pulse': pulse,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  Spo2ReadingsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<int>? spo2Percentage,
      Value<int?>? pulse,
      Value<DateTime>? measuredAt,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return Spo2ReadingsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      spo2Percentage: spo2Percentage ?? this.spo2Percentage,
      pulse: pulse ?? this.pulse,
      measuredAt: measuredAt ?? this.measuredAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (spo2Percentage.present) {
      map['spo2_percentage'] = Variable<int>(spo2Percentage.value);
    }
    if (pulse.present) {
      map['pulse'] = Variable<int>(pulse.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('Spo2ReadingsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('spo2Percentage: $spo2Percentage, ')
          ..write('pulse: $pulse, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 128),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
      'xp', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<String> rank = GeneratedColumn<String>(
      'rank', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _religionMeta =
      const VerificationMeta('religion');
  @override
  late final GeneratedColumn<String> religion = GeneratedColumn<String>(
      'religion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, xp, level, rank, heightCm, religion, region, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('rank')) {
      context.handle(
          _rankMeta, rank.isAcceptableOrUnknown(data['rank']!, _rankMeta));
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    }
    if (data.containsKey('religion')) {
      context.handle(_religionMeta,
          religion.isAcceptableOrUnknown(data['religion']!, _religionMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      rank: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rank']),
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm']),
      religion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}religion']),
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String name;
  final int xp;
  final int level;
  final String? rank;
  final double? heightCm;
  final String? religion;
  final String? region;
  final DateTime updatedAt;
  const UserProfile(
      {required this.id,
      required this.name,
      required this.xp,
      required this.level,
      this.rank,
      this.heightCm,
      this.religion,
      this.region,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['xp'] = Variable<int>(xp);
    map['level'] = Variable<int>(level);
    if (!nullToAbsent || rank != null) {
      map['rank'] = Variable<String>(rank);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || religion != null) {
      map['religion'] = Variable<String>(religion);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      xp: Value(xp),
      level: Value(level),
      rank: rank == null && nullToAbsent ? const Value.absent() : Value(rank),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      religion: religion == null && nullToAbsent
          ? const Value.absent()
          : Value(religion),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      xp: serializer.fromJson<int>(json['xp']),
      level: serializer.fromJson<int>(json['level']),
      rank: serializer.fromJson<String?>(json['rank']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      religion: serializer.fromJson<String?>(json['religion']),
      region: serializer.fromJson<String?>(json['region']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'xp': serializer.toJson<int>(xp),
      'level': serializer.toJson<int>(level),
      'rank': serializer.toJson<String?>(rank),
      'heightCm': serializer.toJson<double?>(heightCm),
      'religion': serializer.toJson<String?>(religion),
      'region': serializer.toJson<String?>(region),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserProfile copyWith(
          {String? id,
          String? name,
          int? xp,
          int? level,
          Value<String?> rank = const Value.absent(),
          Value<double?> heightCm = const Value.absent(),
          Value<String?> religion = const Value.absent(),
          Value<String?> region = const Value.absent(),
          DateTime? updatedAt}) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        xp: xp ?? this.xp,
        level: level ?? this.level,
        rank: rank.present ? rank.value : this.rank,
        heightCm: heightCm.present ? heightCm.value : this.heightCm,
        religion: religion.present ? religion.value : this.religion,
        region: region.present ? region.value : this.region,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      xp: data.xp.present ? data.xp.value : this.xp,
      level: data.level.present ? data.level.value : this.level,
      rank: data.rank.present ? data.rank.value : this.rank,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      religion: data.religion.present ? data.religion.value : this.religion,
      region: data.region.present ? data.region.value : this.region,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('heightCm: $heightCm, ')
          ..write('religion: $religion, ')
          ..write('region: $region, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, xp, level, rank, heightCm, religion, region, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.xp == this.xp &&
          other.level == this.level &&
          other.rank == this.rank &&
          other.heightCm == this.heightCm &&
          other.religion == this.religion &&
          other.region == this.region &&
          other.updatedAt == this.updatedAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> xp;
  final Value<int> level;
  final Value<String?> rank;
  final Value<double?> heightCm;
  final Value<String?> religion;
  final Value<String?> region;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.religion = const Value.absent(),
    this.region = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String name,
    this.xp = const Value.absent(),
    this.level = const Value.absent(),
    this.rank = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.religion = const Value.absent(),
    this.region = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        updatedAt = Value(updatedAt);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? xp,
    Expression<int>? level,
    Expression<String>? rank,
    Expression<double>? heightCm,
    Expression<String>? religion,
    Expression<String>? region,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (xp != null) 'xp': xp,
      if (level != null) 'level': level,
      if (rank != null) 'rank': rank,
      if (heightCm != null) 'height_cm': heightCm,
      if (religion != null) 'religion': religion,
      if (region != null) 'region': region,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<int>? xp,
      Value<int>? level,
      Value<String?>? rank,
      Value<double?>? heightCm,
      Value<String?>? religion,
      Value<String?>? region,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      rank: rank ?? this.rank,
      heightCm: heightCm ?? this.heightCm,
      religion: religion ?? this.religion,
      region: region ?? this.region,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (rank.present) {
      map['rank'] = Variable<String>(rank.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (religion.present) {
      map['religion'] = Variable<String>(religion.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('xp: $xp, ')
          ..write('level: $level, ')
          ..write('rank: $rank, ')
          ..write('heightCm: $heightCm, ')
          ..write('religion: $religion, ')
          ..write('region: $region, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KarmaEventsTable extends KarmaEvents
    with TableInfo<$KarmaEventsTable, KarmaEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KarmaEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _eventTypeMeta =
      const VerificationMeta('eventType');
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
      'event_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pointsMeta = const VerificationMeta('points');
  @override
  late final GeneratedColumn<int> points = GeneratedColumn<int>(
      'points', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, eventType, points, occurredAt, syncStatus];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'karma_events';
  @override
  VerificationContext validateIntegrity(Insertable<KarmaEvent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(_eventTypeMeta,
          eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta));
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('points')) {
      context.handle(_pointsMeta,
          points.isAcceptableOrUnknown(data['points']!, _pointsMeta));
    } else if (isInserting) {
      context.missing(_pointsMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KarmaEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KarmaEvent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      eventType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}event_type'])!,
      points: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}points'])!,
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
    );
  }

  @override
  $KarmaEventsTable createAlias(String alias) {
    return $KarmaEventsTable(attachedDatabase, alias);
  }
}

class KarmaEvent extends DataClass implements Insertable<KarmaEvent> {
  final String id;
  final String userId;
  final String eventType;
  final int points;
  final DateTime occurredAt;
  final String syncStatus;
  const KarmaEvent(
      {required this.id,
      required this.userId,
      required this.eventType,
      required this.points,
      required this.occurredAt,
      required this.syncStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['event_type'] = Variable<String>(eventType);
    map['points'] = Variable<int>(points);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  KarmaEventsCompanion toCompanion(bool nullToAbsent) {
    return KarmaEventsCompanion(
      id: Value(id),
      userId: Value(userId),
      eventType: Value(eventType),
      points: Value(points),
      occurredAt: Value(occurredAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory KarmaEvent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KarmaEvent(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      eventType: serializer.fromJson<String>(json['eventType']),
      points: serializer.fromJson<int>(json['points']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'eventType': serializer.toJson<String>(eventType),
      'points': serializer.toJson<int>(points),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  KarmaEvent copyWith(
          {String? id,
          String? userId,
          String? eventType,
          int? points,
          DateTime? occurredAt,
          String? syncStatus}) =>
      KarmaEvent(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        eventType: eventType ?? this.eventType,
        points: points ?? this.points,
        occurredAt: occurredAt ?? this.occurredAt,
        syncStatus: syncStatus ?? this.syncStatus,
      );
  KarmaEvent copyWithCompanion(KarmaEventsCompanion data) {
    return KarmaEvent(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      points: data.points.present ? data.points.value : this.points,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KarmaEvent(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('eventType: $eventType, ')
          ..write('points: $points, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, eventType, points, occurredAt, syncStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KarmaEvent &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.eventType == this.eventType &&
          other.points == this.points &&
          other.occurredAt == this.occurredAt &&
          other.syncStatus == this.syncStatus);
}

class KarmaEventsCompanion extends UpdateCompanion<KarmaEvent> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> eventType;
  final Value<int> points;
  final Value<DateTime> occurredAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const KarmaEventsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.eventType = const Value.absent(),
    this.points = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KarmaEventsCompanion.insert({
    required String id,
    required String userId,
    required String eventType,
    required int points,
    required DateTime occurredAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        eventType = Value(eventType),
        points = Value(points),
        occurredAt = Value(occurredAt);
  static Insertable<KarmaEvent> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? eventType,
    Expression<int>? points,
    Expression<DateTime>? occurredAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (eventType != null) 'event_type': eventType,
      if (points != null) 'points': points,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KarmaEventsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? eventType,
      Value<int>? points,
      Value<DateTime>? occurredAt,
      Value<String>? syncStatus,
      Value<int>? rowid}) {
    return KarmaEventsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventType: eventType ?? this.eventType,
      points: points ?? this.points,
      occurredAt: occurredAt ?? this.occurredAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (points.present) {
      map['points'] = Variable<int>(points.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KarmaEventsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('eventType: $eventType, ')
          ..write('points: $points, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightLogsTable extends WeightLogs
    with TableInfo<$WeightLogsTable, WeightLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<DateTime> measuredAt = GeneratedColumn<DateTime>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 16),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _failedAttemptsMeta =
      const VerificationMeta('failedAttempts');
  @override
  late final GeneratedColumn<int> failedAttempts = GeneratedColumn<int>(
      'failed_attempts', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, weightKg, measuredAt, syncStatus, remoteId, failedAttempts];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_logs';
  @override
  VerificationContext validateIntegrity(Insertable<WeightLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('measured_at')) {
      context.handle(
          _measuredAtMeta,
          measuredAt.isAcceptableOrUnknown(
              data['measured_at']!, _measuredAtMeta));
    } else if (isInserting) {
      context.missing(_measuredAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
          _syncStatusMeta,
          syncStatus.isAcceptableOrUnknown(
              data['sync_status']!, _syncStatusMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(_remoteIdMeta,
          remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta));
    }
    if (data.containsKey('failed_attempts')) {
      context.handle(
          _failedAttemptsMeta,
          failedAttempts.isAcceptableOrUnknown(
              data['failed_attempts']!, _failedAttemptsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      measuredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}measured_at'])!,
      syncStatus: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!,
      remoteId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_id']),
      failedAttempts: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}failed_attempts'])!,
    );
  }

  @override
  $WeightLogsTable createAlias(String alias) {
    return $WeightLogsTable(attachedDatabase, alias);
  }
}

class WeightLog extends DataClass implements Insertable<WeightLog> {
  final String id;
  final String userId;
  final double weightKg;
  final DateTime measuredAt;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const WeightLog(
      {required this.id,
      required this.userId,
      required this.weightKg,
      required this.measuredAt,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['weight_kg'] = Variable<double>(weightKg);
    map['measured_at'] = Variable<DateTime>(measuredAt);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<String>(remoteId);
    }
    map['failed_attempts'] = Variable<int>(failedAttempts);
    return map;
  }

  WeightLogsCompanion toCompanion(bool nullToAbsent) {
    return WeightLogsCompanion(
      id: Value(id),
      userId: Value(userId),
      weightKg: Value(weightKg),
      measuredAt: Value(measuredAt),
      syncStatus: Value(syncStatus),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      failedAttempts: Value(failedAttempts),
    );
  }

  factory WeightLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightLog(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      measuredAt: serializer.fromJson<DateTime>(json['measuredAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      remoteId: serializer.fromJson<String?>(json['remoteId']),
      failedAttempts: serializer.fromJson<int>(json['failedAttempts']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'weightKg': serializer.toJson<double>(weightKg),
      'measuredAt': serializer.toJson<DateTime>(measuredAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  WeightLog copyWith(
          {String? id,
          String? userId,
          double? weightKg,
          DateTime? measuredAt,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      WeightLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        weightKg: weightKg ?? this.weightKg,
        measuredAt: measuredAt ?? this.measuredAt,
        syncStatus: syncStatus ?? this.syncStatus,
        remoteId: remoteId.present ? remoteId.value : this.remoteId,
        failedAttempts: failedAttempts ?? this.failedAttempts,
      );
  WeightLog copyWithCompanion(WeightLogsCompanion data) {
    return WeightLog(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      measuredAt:
          data.measuredAt.present ? data.measuredAt.value : this.measuredAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      failedAttempts: data.failedAttempts.present
          ? data.failedAttempts.value
          : this.failedAttempts,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightLog(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, weightKg, measuredAt, syncStatus, remoteId, failedAttempts);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightLog &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.weightKg == this.weightKg &&
          other.measuredAt == this.measuredAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class WeightLogsCompanion extends UpdateCompanion<WeightLog> {
  final Value<String> id;
  final Value<String> userId;
  final Value<double> weightKg;
  final Value<DateTime> measuredAt;
  final Value<String> syncStatus;
  final Value<String?> remoteId;
  final Value<int> failedAttempts;
  final Value<int> rowid;
  const WeightLogsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.measuredAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightLogsCompanion.insert({
    required String id,
    required String userId,
    required double weightKg,
    required DateTime measuredAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        weightKg = Value(weightKg),
        measuredAt = Value(measuredAt);
  static Insertable<WeightLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<double>? weightKg,
    Expression<DateTime>? measuredAt,
    Expression<String>? syncStatus,
    Expression<String>? remoteId,
    Expression<int>? failedAttempts,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (weightKg != null) 'weight_kg': weightKg,
      if (measuredAt != null) 'measured_at': measuredAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (remoteId != null) 'remote_id': remoteId,
      if (failedAttempts != null) 'failed_attempts': failedAttempts,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<double>? weightKg,
      Value<DateTime>? measuredAt,
      Value<String>? syncStatus,
      Value<String?>? remoteId,
      Value<int>? failedAttempts,
      Value<int>? rowid}) {
    return WeightLogsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weightKg: weightKg ?? this.weightKg,
      measuredAt: measuredAt ?? this.measuredAt,
      syncStatus: syncStatus ?? this.syncStatus,
      remoteId: remoteId ?? this.remoteId,
      failedAttempts: failedAttempts ?? this.failedAttempts,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (measuredAt.present) {
      map['measured_at'] = Variable<DateTime>(measuredAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<String>(remoteId.value);
    }
    if (failedAttempts.present) {
      map['failed_attempts'] = Variable<int>(failedAttempts.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightLogsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('weightKg: $weightKg, ')
          ..write('measuredAt: $measuredAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FestivalsTable extends Festivals
    with TableInfo<$FestivalsTable, Festival> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FestivalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _religionMeta =
      const VerificationMeta('religion');
  @override
  late final GeneratedColumn<String> religion = GeneratedColumn<String>(
      'religion', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
      'region', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dietPlanJsonMeta =
      const VerificationMeta('dietPlanJson');
  @override
  late final GeneratedColumn<String> dietPlanJson = GeneratedColumn<String>(
      'diet_plan_json', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        description,
        startDate,
        endDate,
        religion,
        region,
        dietPlanJson
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'festivals';
  @override
  VerificationContext validateIntegrity(Insertable<Festival> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('religion')) {
      context.handle(_religionMeta,
          religion.isAcceptableOrUnknown(data['religion']!, _religionMeta));
    }
    if (data.containsKey('region')) {
      context.handle(_regionMeta,
          region.isAcceptableOrUnknown(data['region']!, _regionMeta));
    }
    if (data.containsKey('diet_plan_json')) {
      context.handle(
          _dietPlanJsonMeta,
          dietPlanJson.isAcceptableOrUnknown(
              data['diet_plan_json']!, _dietPlanJsonMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Festival map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Festival(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      religion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}religion']),
      region: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}region']),
      dietPlanJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}diet_plan_json']),
    );
  }

  @override
  $FestivalsTable createAlias(String alias) {
    return $FestivalsTable(attachedDatabase, alias);
  }
}

class Festival extends DataClass implements Insertable<Festival> {
  final String id;
  final String name;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? religion;
  final String? region;
  final String? dietPlanJson;
  const Festival(
      {required this.id,
      required this.name,
      this.description,
      required this.startDate,
      required this.endDate,
      this.religion,
      this.region,
      this.dietPlanJson});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || religion != null) {
      map['religion'] = Variable<String>(religion);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || dietPlanJson != null) {
      map['diet_plan_json'] = Variable<String>(dietPlanJson);
    }
    return map;
  }

  FestivalsCompanion toCompanion(bool nullToAbsent) {
    return FestivalsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      religion: religion == null && nullToAbsent
          ? const Value.absent()
          : Value(religion),
      region:
          region == null && nullToAbsent ? const Value.absent() : Value(region),
      dietPlanJson: dietPlanJson == null && nullToAbsent
          ? const Value.absent()
          : Value(dietPlanJson),
    );
  }

  factory Festival.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Festival(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      religion: serializer.fromJson<String?>(json['religion']),
      region: serializer.fromJson<String?>(json['region']),
      dietPlanJson: serializer.fromJson<String?>(json['dietPlanJson']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'religion': serializer.toJson<String?>(religion),
      'region': serializer.toJson<String?>(region),
      'dietPlanJson': serializer.toJson<String?>(dietPlanJson),
    };
  }

  Festival copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          DateTime? startDate,
          DateTime? endDate,
          Value<String?> religion = const Value.absent(),
          Value<String?> region = const Value.absent(),
          Value<String?> dietPlanJson = const Value.absent()}) =>
      Festival(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        religion: religion.present ? religion.value : this.religion,
        region: region.present ? region.value : this.region,
        dietPlanJson:
            dietPlanJson.present ? dietPlanJson.value : this.dietPlanJson,
      );
  Festival copyWithCompanion(FestivalsCompanion data) {
    return Festival(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      religion: data.religion.present ? data.religion.value : this.religion,
      region: data.region.present ? data.region.value : this.region,
      dietPlanJson: data.dietPlanJson.present
          ? data.dietPlanJson.value
          : this.dietPlanJson,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Festival(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('religion: $religion, ')
          ..write('region: $region, ')
          ..write('dietPlanJson: $dietPlanJson')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, description, startDate, endDate,
      religion, region, dietPlanJson);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Festival &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.religion == this.religion &&
          other.region == this.region &&
          other.dietPlanJson == this.dietPlanJson);
}

class FestivalsCompanion extends UpdateCompanion<Festival> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String?> religion;
  final Value<String?> region;
  final Value<String?> dietPlanJson;
  final Value<int> rowid;
  const FestivalsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.religion = const Value.absent(),
    this.region = const Value.absent(),
    this.dietPlanJson = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FestivalsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.religion = const Value.absent(),
    this.region = const Value.absent(),
    this.dietPlanJson = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<Festival> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? religion,
    Expression<String>? region,
    Expression<String>? dietPlanJson,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (religion != null) 'religion': religion,
      if (region != null) 'region': region,
      if (dietPlanJson != null) 'diet_plan_json': dietPlanJson,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FestivalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<String?>? religion,
      Value<String?>? region,
      Value<String?>? dietPlanJson,
      Value<int>? rowid}) {
    return FestivalsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      religion: religion ?? this.religion,
      region: region ?? this.region,
      dietPlanJson: dietPlanJson ?? this.dietPlanJson,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
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
    if (religion.present) {
      map['religion'] = Variable<String>(religion.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (dietPlanJson.present) {
      map['diet_plan_json'] = Variable<String>(dietPlanJson.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FestivalsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('religion: $religion, ')
          ..write('region: $region, ')
          ..write('dietPlanJson: $dietPlanJson, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SocialPostsTable extends SocialPosts
    with TableInfo<$SocialPostsTable, SocialPost> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SocialPostsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userNameMeta =
      const VerificationMeta('userName');
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
      'user_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userAvatarIdMeta =
      const VerificationMeta('userAvatarId');
  @override
  late final GeneratedColumn<String> userAvatarId = GeneratedColumn<String>(
      'user_avatar_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mediaFileIdMeta =
      const VerificationMeta('mediaFileId');
  @override
  late final GeneratedColumn<String> mediaFileId = GeneratedColumn<String>(
      'media_file_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _likeCountMeta =
      const VerificationMeta('likeCount');
  @override
  late final GeneratedColumn<int> likeCount = GeneratedColumn<int>(
      'like_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isLikedMeta =
      const VerificationMeta('isLiked');
  @override
  late final GeneratedColumn<bool> isLiked = GeneratedColumn<bool>(
      'is_liked', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_liked" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        userName,
        userAvatarId,
        content,
        mediaFileId,
        likeCount,
        isLiked,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'social_posts';
  @override
  VerificationContext validateIntegrity(Insertable<SocialPost> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(_userNameMeta,
          userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta));
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('user_avatar_id')) {
      context.handle(
          _userAvatarIdMeta,
          userAvatarId.isAcceptableOrUnknown(
              data['user_avatar_id']!, _userAvatarIdMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('media_file_id')) {
      context.handle(
          _mediaFileIdMeta,
          mediaFileId.isAcceptableOrUnknown(
              data['media_file_id']!, _mediaFileIdMeta));
    }
    if (data.containsKey('like_count')) {
      context.handle(_likeCountMeta,
          likeCount.isAcceptableOrUnknown(data['like_count']!, _likeCountMeta));
    }
    if (data.containsKey('is_liked')) {
      context.handle(_isLikedMeta,
          isLiked.isAcceptableOrUnknown(data['is_liked']!, _isLikedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SocialPost map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SocialPost(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      userName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_name'])!,
      userAvatarId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_avatar_id']),
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      mediaFileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}media_file_id']),
      likeCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}like_count'])!,
      isLiked: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_liked'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SocialPostsTable createAlias(String alias) {
    return $SocialPostsTable(attachedDatabase, alias);
  }
}

class SocialPost extends DataClass implements Insertable<SocialPost> {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatarId;
  final String content;
  final String? mediaFileId;
  final int likeCount;
  final bool isLiked;
  final DateTime createdAt;
  const SocialPost(
      {required this.id,
      required this.userId,
      required this.userName,
      this.userAvatarId,
      required this.content,
      this.mediaFileId,
      required this.likeCount,
      required this.isLiked,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['user_name'] = Variable<String>(userName);
    if (!nullToAbsent || userAvatarId != null) {
      map['user_avatar_id'] = Variable<String>(userAvatarId);
    }
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || mediaFileId != null) {
      map['media_file_id'] = Variable<String>(mediaFileId);
    }
    map['like_count'] = Variable<int>(likeCount);
    map['is_liked'] = Variable<bool>(isLiked);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SocialPostsCompanion toCompanion(bool nullToAbsent) {
    return SocialPostsCompanion(
      id: Value(id),
      userId: Value(userId),
      userName: Value(userName),
      userAvatarId: userAvatarId == null && nullToAbsent
          ? const Value.absent()
          : Value(userAvatarId),
      content: Value(content),
      mediaFileId: mediaFileId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaFileId),
      likeCount: Value(likeCount),
      isLiked: Value(isLiked),
      createdAt: Value(createdAt),
    );
  }

  factory SocialPost.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SocialPost(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      userName: serializer.fromJson<String>(json['userName']),
      userAvatarId: serializer.fromJson<String?>(json['userAvatarId']),
      content: serializer.fromJson<String>(json['content']),
      mediaFileId: serializer.fromJson<String?>(json['mediaFileId']),
      likeCount: serializer.fromJson<int>(json['likeCount']),
      isLiked: serializer.fromJson<bool>(json['isLiked']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'userName': serializer.toJson<String>(userName),
      'userAvatarId': serializer.toJson<String?>(userAvatarId),
      'content': serializer.toJson<String>(content),
      'mediaFileId': serializer.toJson<String?>(mediaFileId),
      'likeCount': serializer.toJson<int>(likeCount),
      'isLiked': serializer.toJson<bool>(isLiked),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SocialPost copyWith(
          {String? id,
          String? userId,
          String? userName,
          Value<String?> userAvatarId = const Value.absent(),
          String? content,
          Value<String?> mediaFileId = const Value.absent(),
          int? likeCount,
          bool? isLiked,
          DateTime? createdAt}) =>
      SocialPost(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        userName: userName ?? this.userName,
        userAvatarId:
            userAvatarId.present ? userAvatarId.value : this.userAvatarId,
        content: content ?? this.content,
        mediaFileId: mediaFileId.present ? mediaFileId.value : this.mediaFileId,
        likeCount: likeCount ?? this.likeCount,
        isLiked: isLiked ?? this.isLiked,
        createdAt: createdAt ?? this.createdAt,
      );
  SocialPost copyWithCompanion(SocialPostsCompanion data) {
    return SocialPost(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      userName: data.userName.present ? data.userName.value : this.userName,
      userAvatarId: data.userAvatarId.present
          ? data.userAvatarId.value
          : this.userAvatarId,
      content: data.content.present ? data.content.value : this.content,
      mediaFileId:
          data.mediaFileId.present ? data.mediaFileId.value : this.mediaFileId,
      likeCount: data.likeCount.present ? data.likeCount.value : this.likeCount,
      isLiked: data.isLiked.present ? data.isLiked.value : this.isLiked,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SocialPost(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userAvatarId: $userAvatarId, ')
          ..write('content: $content, ')
          ..write('mediaFileId: $mediaFileId, ')
          ..write('likeCount: $likeCount, ')
          ..write('isLiked: $isLiked, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, userName, userAvatarId, content,
      mediaFileId, likeCount, isLiked, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SocialPost &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.userName == this.userName &&
          other.userAvatarId == this.userAvatarId &&
          other.content == this.content &&
          other.mediaFileId == this.mediaFileId &&
          other.likeCount == this.likeCount &&
          other.isLiked == this.isLiked &&
          other.createdAt == this.createdAt);
}

class SocialPostsCompanion extends UpdateCompanion<SocialPost> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> userName;
  final Value<String?> userAvatarId;
  final Value<String> content;
  final Value<String?> mediaFileId;
  final Value<int> likeCount;
  final Value<bool> isLiked;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SocialPostsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.userName = const Value.absent(),
    this.userAvatarId = const Value.absent(),
    this.content = const Value.absent(),
    this.mediaFileId = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.isLiked = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SocialPostsCompanion.insert({
    required String id,
    required String userId,
    required String userName,
    this.userAvatarId = const Value.absent(),
    required String content,
    this.mediaFileId = const Value.absent(),
    this.likeCount = const Value.absent(),
    this.isLiked = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        userName = Value(userName),
        content = Value(content),
        createdAt = Value(createdAt);
  static Insertable<SocialPost> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? userName,
    Expression<String>? userAvatarId,
    Expression<String>? content,
    Expression<String>? mediaFileId,
    Expression<int>? likeCount,
    Expression<bool>? isLiked,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (userName != null) 'user_name': userName,
      if (userAvatarId != null) 'user_avatar_id': userAvatarId,
      if (content != null) 'content': content,
      if (mediaFileId != null) 'media_file_id': mediaFileId,
      if (likeCount != null) 'like_count': likeCount,
      if (isLiked != null) 'is_liked': isLiked,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SocialPostsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? userName,
      Value<String?>? userAvatarId,
      Value<String>? content,
      Value<String?>? mediaFileId,
      Value<int>? likeCount,
      Value<bool>? isLiked,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return SocialPostsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatarId: userAvatarId ?? this.userAvatarId,
      content: content ?? this.content,
      mediaFileId: mediaFileId ?? this.mediaFileId,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (userAvatarId.present) {
      map['user_avatar_id'] = Variable<String>(userAvatarId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (mediaFileId.present) {
      map['media_file_id'] = Variable<String>(mediaFileId.value);
    }
    if (likeCount.present) {
      map['like_count'] = Variable<int>(likeCount.value);
    }
    if (isLiked.present) {
      map['is_liked'] = Variable<bool>(isLiked.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SocialPostsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('userName: $userName, ')
          ..write('userAvatarId: $userAvatarId, ')
          ..write('content: $content, ')
          ..write('mediaFileId: $mediaFileId, ')
          ..write('likeCount: $likeCount, ')
          ..write('isLiked: $isLiked, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CommunityGroupsTable extends CommunityGroups
    with TableInfo<$CommunityGroupsTable, CommunityGroup> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CommunityGroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconIdMeta = const VerificationMeta('iconId');
  @override
  late final GeneratedColumn<String> iconId = GeneratedColumn<String>(
      'icon_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _memberCountMeta =
      const VerificationMeta('memberCount');
  @override
  late final GeneratedColumn<int> memberCount = GeneratedColumn<int>(
      'member_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isJoinedMeta =
      const VerificationMeta('isJoined');
  @override
  late final GeneratedColumn<bool> isJoined = GeneratedColumn<bool>(
      'is_joined', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_joined" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, description, iconId, memberCount, isJoined];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'community_groups';
  @override
  VerificationContext validateIntegrity(Insertable<CommunityGroup> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('icon_id')) {
      context.handle(_iconIdMeta,
          iconId.isAcceptableOrUnknown(data['icon_id']!, _iconIdMeta));
    }
    if (data.containsKey('member_count')) {
      context.handle(
          _memberCountMeta,
          memberCount.isAcceptableOrUnknown(
              data['member_count']!, _memberCountMeta));
    }
    if (data.containsKey('is_joined')) {
      context.handle(_isJoinedMeta,
          isJoined.isAcceptableOrUnknown(data['is_joined']!, _isJoinedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CommunityGroup map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CommunityGroup(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      iconId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon_id']),
      memberCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}member_count'])!,
      isJoined: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_joined'])!,
    );
  }

  @override
  $CommunityGroupsTable createAlias(String alias) {
    return $CommunityGroupsTable(attachedDatabase, alias);
  }
}

class CommunityGroup extends DataClass implements Insertable<CommunityGroup> {
  final String id;
  final String name;
  final String? description;
  final String? iconId;
  final int memberCount;
  final bool isJoined;
  const CommunityGroup(
      {required this.id,
      required this.name,
      this.description,
      this.iconId,
      required this.memberCount,
      required this.isJoined});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || iconId != null) {
      map['icon_id'] = Variable<String>(iconId);
    }
    map['member_count'] = Variable<int>(memberCount);
    map['is_joined'] = Variable<bool>(isJoined);
    return map;
  }

  CommunityGroupsCompanion toCompanion(bool nullToAbsent) {
    return CommunityGroupsCompanion(
      id: Value(id),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      iconId:
          iconId == null && nullToAbsent ? const Value.absent() : Value(iconId),
      memberCount: Value(memberCount),
      isJoined: Value(isJoined),
    );
  }

  factory CommunityGroup.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CommunityGroup(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      iconId: serializer.fromJson<String?>(json['iconId']),
      memberCount: serializer.fromJson<int>(json['memberCount']),
      isJoined: serializer.fromJson<bool>(json['isJoined']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'iconId': serializer.toJson<String?>(iconId),
      'memberCount': serializer.toJson<int>(memberCount),
      'isJoined': serializer.toJson<bool>(isJoined),
    };
  }

  CommunityGroup copyWith(
          {String? id,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> iconId = const Value.absent(),
          int? memberCount,
          bool? isJoined}) =>
      CommunityGroup(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        iconId: iconId.present ? iconId.value : this.iconId,
        memberCount: memberCount ?? this.memberCount,
        isJoined: isJoined ?? this.isJoined,
      );
  CommunityGroup copyWithCompanion(CommunityGroupsCompanion data) {
    return CommunityGroup(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      iconId: data.iconId.present ? data.iconId.value : this.iconId,
      memberCount:
          data.memberCount.present ? data.memberCount.value : this.memberCount,
      isJoined: data.isJoined.present ? data.isJoined.value : this.isJoined,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CommunityGroup(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconId: $iconId, ')
          ..write('memberCount: $memberCount, ')
          ..write('isJoined: $isJoined')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, description, iconId, memberCount, isJoined);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CommunityGroup &&
          other.id == this.id &&
          other.name == this.name &&
          other.description == this.description &&
          other.iconId == this.iconId &&
          other.memberCount == this.memberCount &&
          other.isJoined == this.isJoined);
}

class CommunityGroupsCompanion extends UpdateCompanion<CommunityGroup> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> iconId;
  final Value<int> memberCount;
  final Value<bool> isJoined;
  final Value<int> rowid;
  const CommunityGroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.iconId = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CommunityGroupsCompanion.insert({
    required String id,
    required String name,
    this.description = const Value.absent(),
    this.iconId = const Value.absent(),
    this.memberCount = const Value.absent(),
    this.isJoined = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<CommunityGroup> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? iconId,
    Expression<int>? memberCount,
    Expression<bool>? isJoined,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (iconId != null) 'icon_id': iconId,
      if (memberCount != null) 'member_count': memberCount,
      if (isJoined != null) 'is_joined': isJoined,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CommunityGroupsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? iconId,
      Value<int>? memberCount,
      Value<bool>? isJoined,
      Value<int>? rowid}) {
    return CommunityGroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      iconId: iconId ?? this.iconId,
      memberCount: memberCount ?? this.memberCount,
      isJoined: isJoined ?? this.isJoined,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (iconId.present) {
      map['icon_id'] = Variable<String>(iconId.value);
    }
    if (memberCount.present) {
      map['member_count'] = Variable<int>(memberCount.value);
    }
    if (isJoined.present) {
      map['is_joined'] = Variable<bool>(isJoined.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CommunityGroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('iconId: $iconId, ')
          ..write('memberCount: $memberCount, ')
          ..write('isJoined: $isJoined, ')
          ..write('rowid: $rowid')
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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 64),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fileNameMeta =
      const VerificationMeta('fileName');
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
      'file_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fileIdMeta = const VerificationMeta('fileId');
  @override
  late final GeneratedColumn<String> fileId = GeneratedColumn<String>(
      'file_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _reportTypeMeta =
      const VerificationMeta('reportType');
  @override
  late final GeneratedColumn<String> reportType = GeneratedColumn<String>(
      'report_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _extractedDataJsonMeta =
      const VerificationMeta('extractedDataJson');
  @override
  late final GeneratedColumn<String> extractedDataJson =
      GeneratedColumn<String>('extracted_data_json', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _reportDateMeta =
      const VerificationMeta('reportDate');
  @override
  late final GeneratedColumn<DateTime> reportDate = GeneratedColumn<DateTime>(
      'report_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        fileName,
        fileId,
        reportType,
        extractedDataJson,
        reportDate,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lab_reports';
  @override
  VerificationContext validateIntegrity(Insertable<LabReport> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(_fileNameMeta,
          fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta));
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('file_id')) {
      context.handle(_fileIdMeta,
          fileId.isAcceptableOrUnknown(data['file_id']!, _fileIdMeta));
    } else if (isInserting) {
      context.missing(_fileIdMeta);
    }
    if (data.containsKey('report_type')) {
      context.handle(
          _reportTypeMeta,
          reportType.isAcceptableOrUnknown(
              data['report_type']!, _reportTypeMeta));
    }
    if (data.containsKey('extracted_data_json')) {
      context.handle(
          _extractedDataJsonMeta,
          extractedDataJson.isAcceptableOrUnknown(
              data['extracted_data_json']!, _extractedDataJsonMeta));
    }
    if (data.containsKey('report_date')) {
      context.handle(
          _reportDateMeta,
          reportDate.isAcceptableOrUnknown(
              data['report_date']!, _reportDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LabReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LabReport(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      fileName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_name'])!,
      fileId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}file_id'])!,
      reportType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}report_type']),
      extractedDataJson: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}extracted_data_json']),
      reportDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}report_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LabReportsTable createAlias(String alias) {
    return $LabReportsTable(attachedDatabase, alias);
  }
}

class LabReport extends DataClass implements Insertable<LabReport> {
  final String id;
  final String userId;
  final String fileName;
  final String fileId;
  final String? reportType;
  final String? extractedDataJson;
  final DateTime? reportDate;
  final DateTime createdAt;
  const LabReport(
      {required this.id,
      required this.userId,
      required this.fileName,
      required this.fileId,
      this.reportType,
      this.extractedDataJson,
      this.reportDate,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['file_name'] = Variable<String>(fileName);
    map['file_id'] = Variable<String>(fileId);
    if (!nullToAbsent || reportType != null) {
      map['report_type'] = Variable<String>(reportType);
    }
    if (!nullToAbsent || extractedDataJson != null) {
      map['extracted_data_json'] = Variable<String>(extractedDataJson);
    }
    if (!nullToAbsent || reportDate != null) {
      map['report_date'] = Variable<DateTime>(reportDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LabReportsCompanion toCompanion(bool nullToAbsent) {
    return LabReportsCompanion(
      id: Value(id),
      userId: Value(userId),
      fileName: Value(fileName),
      fileId: Value(fileId),
      reportType: reportType == null && nullToAbsent
          ? const Value.absent()
          : Value(reportType),
      extractedDataJson: extractedDataJson == null && nullToAbsent
          ? const Value.absent()
          : Value(extractedDataJson),
      reportDate: reportDate == null && nullToAbsent
          ? const Value.absent()
          : Value(reportDate),
      createdAt: Value(createdAt),
    );
  }

  factory LabReport.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LabReport(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      fileName: serializer.fromJson<String>(json['fileName']),
      fileId: serializer.fromJson<String>(json['fileId']),
      reportType: serializer.fromJson<String?>(json['reportType']),
      extractedDataJson:
          serializer.fromJson<String?>(json['extractedDataJson']),
      reportDate: serializer.fromJson<DateTime?>(json['reportDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'fileName': serializer.toJson<String>(fileName),
      'fileId': serializer.toJson<String>(fileId),
      'reportType': serializer.toJson<String?>(reportType),
      'extractedDataJson': serializer.toJson<String?>(extractedDataJson),
      'reportDate': serializer.toJson<DateTime?>(reportDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LabReport copyWith(
          {String? id,
          String? userId,
          String? fileName,
          String? fileId,
          Value<String?> reportType = const Value.absent(),
          Value<String?> extractedDataJson = const Value.absent(),
          Value<DateTime?> reportDate = const Value.absent(),
          DateTime? createdAt}) =>
      LabReport(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        fileName: fileName ?? this.fileName,
        fileId: fileId ?? this.fileId,
        reportType: reportType.present ? reportType.value : this.reportType,
        extractedDataJson: extractedDataJson.present
            ? extractedDataJson.value
            : this.extractedDataJson,
        reportDate: reportDate.present ? reportDate.value : this.reportDate,
        createdAt: createdAt ?? this.createdAt,
      );
  LabReport copyWithCompanion(LabReportsCompanion data) {
    return LabReport(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      fileId: data.fileId.present ? data.fileId.value : this.fileId,
      reportType:
          data.reportType.present ? data.reportType.value : this.reportType,
      extractedDataJson: data.extractedDataJson.present
          ? data.extractedDataJson.value
          : this.extractedDataJson,
      reportDate:
          data.reportDate.present ? data.reportDate.value : this.reportDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LabReport(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fileName: $fileName, ')
          ..write('fileId: $fileId, ')
          ..write('reportType: $reportType, ')
          ..write('extractedDataJson: $extractedDataJson, ')
          ..write('reportDate: $reportDate, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, fileName, fileId, reportType,
      extractedDataJson, reportDate, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LabReport &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.fileName == this.fileName &&
          other.fileId == this.fileId &&
          other.reportType == this.reportType &&
          other.extractedDataJson == this.extractedDataJson &&
          other.reportDate == this.reportDate &&
          other.createdAt == this.createdAt);
}

class LabReportsCompanion extends UpdateCompanion<LabReport> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> fileName;
  final Value<String> fileId;
  final Value<String?> reportType;
  final Value<String?> extractedDataJson;
  final Value<DateTime?> reportDate;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LabReportsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.fileName = const Value.absent(),
    this.fileId = const Value.absent(),
    this.reportType = const Value.absent(),
    this.extractedDataJson = const Value.absent(),
    this.reportDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LabReportsCompanion.insert({
    required String id,
    required String userId,
    required String fileName,
    required String fileId,
    this.reportType = const Value.absent(),
    this.extractedDataJson = const Value.absent(),
    this.reportDate = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        fileName = Value(fileName),
        fileId = Value(fileId),
        createdAt = Value(createdAt);
  static Insertable<LabReport> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? fileName,
    Expression<String>? fileId,
    Expression<String>? reportType,
    Expression<String>? extractedDataJson,
    Expression<DateTime>? reportDate,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (fileName != null) 'file_name': fileName,
      if (fileId != null) 'file_id': fileId,
      if (reportType != null) 'report_type': reportType,
      if (extractedDataJson != null) 'extracted_data_json': extractedDataJson,
      if (reportDate != null) 'report_date': reportDate,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LabReportsCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? fileName,
      Value<String>? fileId,
      Value<String?>? reportType,
      Value<String?>? extractedDataJson,
      Value<DateTime?>? reportDate,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LabReportsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      fileName: fileName ?? this.fileName,
      fileId: fileId ?? this.fileId,
      reportType: reportType ?? this.reportType,
      extractedDataJson: extractedDataJson ?? this.extractedDataJson,
      reportDate: reportDate ?? this.reportDate,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (fileId.present) {
      map['file_id'] = Variable<String>(fileId.value);
    }
    if (reportType.present) {
      map['report_type'] = Variable<String>(reportType.value);
    }
    if (extractedDataJson.present) {
      map['extracted_data_json'] = Variable<String>(extractedDataJson.value);
    }
    if (reportDate.present) {
      map['report_date'] = Variable<DateTime>(reportDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LabReportsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('fileName: $fileName, ')
          ..write('fileId: $fileId, ')
          ..write('reportType: $reportType, ')
          ..write('extractedDataJson: $extractedDataJson, ')
          ..write('reportDate: $reportDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodLogsTable foodLogs = $FoodLogsTable(this);
  late final $BpReadingsTable bpReadings = $BpReadingsTable(this);
  late final $GlucoseReadingsTable glucoseReadings =
      $GlucoseReadingsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $JournalEntriesTable journalEntries = $JournalEntriesTable(this);
  late final $WeddingPlansTable weddingPlans = $WeddingPlansTable(this);
  late final $WeddingMealLogsTable weddingMealLogs =
      $WeddingMealLogsTable(this);
  late final $StepCountsTable stepCounts = $StepCountsTable(this);
  late final $Spo2ReadingsTable spo2Readings = $Spo2ReadingsTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $KarmaEventsTable karmaEvents = $KarmaEventsTable(this);
  late final $WeightLogsTable weightLogs = $WeightLogsTable(this);
  late final $FestivalsTable festivals = $FestivalsTable(this);
  late final $SocialPostsTable socialPosts = $SocialPostsTable(this);
  late final $CommunityGroupsTable communityGroups =
      $CommunityGroupsTable(this);
  late final $LabReportsTable labReports = $LabReportsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        foodLogs,
        bpReadings,
        glucoseReadings,
        sleepLogs,
        workouts,
        habits,
        journalEntries,
        weddingPlans,
        weddingMealLogs,
        stepCounts,
        spo2Readings,
        userProfiles,
        karmaEvents,
        weightLogs,
        festivals,
        socialPosts,
        communityGroups,
        labReports
      ];
}

typedef $$FoodLogsTableCreateCompanionBuilder = FoodLogsCompanion Function({
  required String id,
  required String userId,
  required String foodName,
  Value<String?> foodNameLocal,
  required String mealType,
  required DateTime loggedAt,
  Value<double> calories,
  Value<double> proteinG,
  Value<double> carbsG,
  Value<double> fatG,
  required String portionUnit,
  Value<double> portionQty,
  Value<String> source,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$FoodLogsTableUpdateCompanionBuilder = FoodLogsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> foodName,
  Value<String?> foodNameLocal,
  Value<String> mealType,
  Value<DateTime> loggedAt,
  Value<double> calories,
  Value<double> proteinG,
  Value<double> carbsG,
  Value<double> fatG,
  Value<String> portionUnit,
  Value<double> portionQty,
  Value<String> source,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodNameLocal => $composableBuilder(
      column: $table.foodNameLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get portionQty => $composableBuilder(
      column: $table.portionQty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodName => $composableBuilder(
      column: $table.foodName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodNameLocal => $composableBuilder(
      column: $table.foodNameLocal,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinG => $composableBuilder(
      column: $table.proteinG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsG => $composableBuilder(
      column: $table.carbsG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatG => $composableBuilder(
      column: $table.fatG, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get portionQty => $composableBuilder(
      column: $table.portionQty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get foodName =>
      $composableBuilder(column: $table.foodName, builder: (column) => column);

  GeneratedColumn<String> get foodNameLocal => $composableBuilder(
      column: $table.foodNameLocal, builder: (column) => column);

  GeneratedColumn<String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get proteinG =>
      $composableBuilder(column: $table.proteinG, builder: (column) => column);

  GeneratedColumn<double> get carbsG =>
      $composableBuilder(column: $table.carbsG, builder: (column) => column);

  GeneratedColumn<double> get fatG =>
      $composableBuilder(column: $table.fatG, builder: (column) => column);

  GeneratedColumn<String> get portionUnit => $composableBuilder(
      column: $table.portionUnit, builder: (column) => column);

  GeneratedColumn<double> get portionQty => $composableBuilder(
      column: $table.portionQty, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$FoodLogsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function()> {
  $$FoodLogsTableTableManager(_$AppDatabase db, $FoodLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> foodName = const Value.absent(),
            Value<String?> foodNameLocal = const Value.absent(),
            Value<String> mealType = const Value.absent(),
            Value<DateTime> loggedAt = const Value.absent(),
            Value<double> calories = const Value.absent(),
            Value<double> proteinG = const Value.absent(),
            Value<double> carbsG = const Value.absent(),
            Value<double> fatG = const Value.absent(),
            Value<String> portionUnit = const Value.absent(),
            Value<double> portionQty = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodLogsCompanion(
            id: id,
            userId: userId,
            foodName: foodName,
            foodNameLocal: foodNameLocal,
            mealType: mealType,
            loggedAt: loggedAt,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            portionUnit: portionUnit,
            portionQty: portionQty,
            source: source,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String foodName,
            Value<String?> foodNameLocal = const Value.absent(),
            required String mealType,
            required DateTime loggedAt,
            Value<double> calories = const Value.absent(),
            Value<double> proteinG = const Value.absent(),
            Value<double> carbsG = const Value.absent(),
            Value<double> fatG = const Value.absent(),
            required String portionUnit,
            Value<double> portionQty = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodLogsCompanion.insert(
            id: id,
            userId: userId,
            foodName: foodName,
            foodNameLocal: foodNameLocal,
            mealType: mealType,
            loggedAt: loggedAt,
            calories: calories,
            proteinG: proteinG,
            carbsG: carbsG,
            fatG: fatG,
            portionUnit: portionUnit,
            portionQty: portionQty,
            source: source,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodLogsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function()>;
typedef $$BpReadingsTableCreateCompanionBuilder = BpReadingsCompanion Function({
  required String id,
  required String userId,
  required int systolic,
  required int diastolic,
  Value<int?> pulse,
  required DateTime measuredAt,
  Value<String?> notes,
  Value<String?> classification,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$BpReadingsTableUpdateCompanionBuilder = BpReadingsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<int> systolic,
  Value<int> diastolic,
  Value<int?> pulse,
  Value<DateTime> measuredAt,
  Value<String?> notes,
  Value<String?> classification,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});

class $$BpReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $BpReadingsTable> {
  $$BpReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pulse => $composableBuilder(
      column: $table.pulse, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
}

class $$BpReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $BpReadingsTable> {
  $$BpReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get systolic => $composableBuilder(
      column: $table.systolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get diastolic => $composableBuilder(
      column: $table.diastolic, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pulse => $composableBuilder(
      column: $table.pulse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
}

class $$BpReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BpReadingsTable> {
  $$BpReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get systolic =>
      $composableBuilder(column: $table.systolic, builder: (column) => column);

  GeneratedColumn<int> get diastolic =>
      $composableBuilder(column: $table.diastolic, builder: (column) => column);

  GeneratedColumn<int> get pulse =>
      $composableBuilder(column: $table.pulse, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$BpReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $BpReadingsTable,
    BpReading,
    $$BpReadingsTableFilterComposer,
    $$BpReadingsTableOrderingComposer,
    $$BpReadingsTableAnnotationComposer,
    $$BpReadingsTableCreateCompanionBuilder,
    $$BpReadingsTableUpdateCompanionBuilder,
    (BpReading, BaseReferences<_$AppDatabase, $BpReadingsTable, BpReading>),
    BpReading,
    PrefetchHooks Function()> {
  $$BpReadingsTableTableManager(_$AppDatabase db, $BpReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BpReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BpReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BpReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> systolic = const Value.absent(),
            Value<int> diastolic = const Value.absent(),
            Value<int?> pulse = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> classification = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BpReadingsCompanion(
            id: id,
            userId: userId,
            systolic: systolic,
            diastolic: diastolic,
            pulse: pulse,
            measuredAt: measuredAt,
            notes: notes,
            classification: classification,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required int systolic,
            required int diastolic,
            Value<int?> pulse = const Value.absent(),
            required DateTime measuredAt,
            Value<String?> notes = const Value.absent(),
            Value<String?> classification = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              BpReadingsCompanion.insert(
            id: id,
            userId: userId,
            systolic: systolic,
            diastolic: diastolic,
            pulse: pulse,
            measuredAt: measuredAt,
            notes: notes,
            classification: classification,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$BpReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $BpReadingsTable,
    BpReading,
    $$BpReadingsTableFilterComposer,
    $$BpReadingsTableOrderingComposer,
    $$BpReadingsTableAnnotationComposer,
    $$BpReadingsTableCreateCompanionBuilder,
    $$BpReadingsTableUpdateCompanionBuilder,
    (BpReading, BaseReferences<_$AppDatabase, $BpReadingsTable, BpReading>),
    BpReading,
    PrefetchHooks Function()>;
typedef $$GlucoseReadingsTableCreateCompanionBuilder = GlucoseReadingsCompanion
    Function({
  required String id,
  required String userId,
  required double valueMgDl,
  required String readingType,
  required DateTime measuredAt,
  Value<String?> classification,
  Value<String?> linkedFoodLogId,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$GlucoseReadingsTableUpdateCompanionBuilder = GlucoseReadingsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<double> valueMgDl,
  Value<String> readingType,
  Value<DateTime> measuredAt,
  Value<String?> classification,
  Value<String?> linkedFoodLogId,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});

class $$GlucoseReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $GlucoseReadingsTable> {
  $$GlucoseReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get valueMgDl => $composableBuilder(
      column: $table.valueMgDl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get linkedFoodLogId => $composableBuilder(
      column: $table.linkedFoodLogId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
}

class $$GlucoseReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $GlucoseReadingsTable> {
  $$GlucoseReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get valueMgDl => $composableBuilder(
      column: $table.valueMgDl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get classification => $composableBuilder(
      column: $table.classification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get linkedFoodLogId => $composableBuilder(
      column: $table.linkedFoodLogId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
}

class $$GlucoseReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GlucoseReadingsTable> {
  $$GlucoseReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get valueMgDl =>
      $composableBuilder(column: $table.valueMgDl, builder: (column) => column);

  GeneratedColumn<String> get readingType => $composableBuilder(
      column: $table.readingType, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<String> get classification => $composableBuilder(
      column: $table.classification, builder: (column) => column);

  GeneratedColumn<String> get linkedFoodLogId => $composableBuilder(
      column: $table.linkedFoodLogId, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$GlucoseReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $GlucoseReadingsTable,
    GlucoseReading,
    $$GlucoseReadingsTableFilterComposer,
    $$GlucoseReadingsTableOrderingComposer,
    $$GlucoseReadingsTableAnnotationComposer,
    $$GlucoseReadingsTableCreateCompanionBuilder,
    $$GlucoseReadingsTableUpdateCompanionBuilder,
    (
      GlucoseReading,
      BaseReferences<_$AppDatabase, $GlucoseReadingsTable, GlucoseReading>
    ),
    GlucoseReading,
    PrefetchHooks Function()> {
  $$GlucoseReadingsTableTableManager(
      _$AppDatabase db, $GlucoseReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GlucoseReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GlucoseReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GlucoseReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> valueMgDl = const Value.absent(),
            Value<String> readingType = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<String?> classification = const Value.absent(),
            Value<String?> linkedFoodLogId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GlucoseReadingsCompanion(
            id: id,
            userId: userId,
            valueMgDl: valueMgDl,
            readingType: readingType,
            measuredAt: measuredAt,
            classification: classification,
            linkedFoodLogId: linkedFoodLogId,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required double valueMgDl,
            required String readingType,
            required DateTime measuredAt,
            Value<String?> classification = const Value.absent(),
            Value<String?> linkedFoodLogId = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              GlucoseReadingsCompanion.insert(
            id: id,
            userId: userId,
            valueMgDl: valueMgDl,
            readingType: readingType,
            measuredAt: measuredAt,
            classification: classification,
            linkedFoodLogId: linkedFoodLogId,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$GlucoseReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $GlucoseReadingsTable,
    GlucoseReading,
    $$GlucoseReadingsTableFilterComposer,
    $$GlucoseReadingsTableOrderingComposer,
    $$GlucoseReadingsTableAnnotationComposer,
    $$GlucoseReadingsTableCreateCompanionBuilder,
    $$GlucoseReadingsTableUpdateCompanionBuilder,
    (
      GlucoseReading,
      BaseReferences<_$AppDatabase, $GlucoseReadingsTable, GlucoseReading>
    ),
    GlucoseReading,
    PrefetchHooks Function()>;
typedef $$SleepLogsTableCreateCompanionBuilder = SleepLogsCompanion Function({
  required String id,
  required String userId,
  required DateTime sleepStart,
  required DateTime sleepEnd,
  required int durationMinutes,
  Value<int?> qualityScore,
  Value<String> source,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$SleepLogsTableUpdateCompanionBuilder = SleepLogsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<DateTime> sleepStart,
  Value<DateTime> sleepEnd,
  Value<int> durationMinutes,
  Value<int?> qualityScore,
  Value<String> source,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get sleepEnd => $composableBuilder(
      column: $table.sleepEnd, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get sleepEnd => $composableBuilder(
      column: $table.sleepEnd, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => column);

  GeneratedColumn<DateTime> get sleepEnd =>
      $composableBuilder(column: $table.sleepEnd, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<int> get qualityScore => $composableBuilder(
      column: $table.qualityScore, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$SleepLogsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function()> {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> sleepStart = const Value.absent(),
            Value<DateTime> sleepEnd = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int?> qualityScore = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepLogsCompanion(
            id: id,
            userId: userId,
            sleepStart: sleepStart,
            sleepEnd: sleepEnd,
            durationMinutes: durationMinutes,
            qualityScore: qualityScore,
            source: source,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required DateTime sleepStart,
            required DateTime sleepEnd,
            required int durationMinutes,
            Value<int?> qualityScore = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SleepLogsCompanion.insert(
            id: id,
            userId: userId,
            sleepStart: sleepStart,
            sleepEnd: sleepEnd,
            durationMinutes: durationMinutes,
            qualityScore: qualityScore,
            source: source,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SleepLogsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function()>;
typedef $$WorkoutsTableCreateCompanionBuilder = WorkoutsCompanion Function({
  required String id,
  required String userId,
  required String name,
  required String type,
  required DateTime startedAt,
  Value<int?> durationMinutes,
  Value<double?> caloriesBurned,
  Value<double?> distanceKm,
  Value<int?> avgHeartRate,
  Value<String?> exercisesJson,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$WorkoutsTableUpdateCompanionBuilder = WorkoutsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> type,
  Value<DateTime> startedAt,
  Value<int?> durationMinutes,
  Value<double?> caloriesBurned,
  Value<double?> distanceKm,
  Value<int?> avgHeartRate,
  Value<String?> exercisesJson,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get avgHeartRate => $composableBuilder(
      column: $table.avgHeartRate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get avgHeartRate => $composableBuilder(
      column: $table.avgHeartRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<double> get caloriesBurned => $composableBuilder(
      column: $table.caloriesBurned, builder: (column) => column);

  GeneratedColumn<double> get distanceKm => $composableBuilder(
      column: $table.distanceKm, builder: (column) => column);

  GeneratedColumn<int> get avgHeartRate => $composableBuilder(
      column: $table.avgHeartRate, builder: (column) => column);

  GeneratedColumn<String> get exercisesJson => $composableBuilder(
      column: $table.exercisesJson, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$WorkoutsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
    Workout,
    PrefetchHooks Function()> {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<int?> durationMinutes = const Value.absent(),
            Value<double?> caloriesBurned = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> avgHeartRate = const Value.absent(),
            Value<String?> exercisesJson = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutsCompanion(
            id: id,
            userId: userId,
            name: name,
            type: type,
            startedAt: startedAt,
            durationMinutes: durationMinutes,
            caloriesBurned: caloriesBurned,
            distanceKm: distanceKm,
            avgHeartRate: avgHeartRate,
            exercisesJson: exercisesJson,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required String type,
            required DateTime startedAt,
            Value<int?> durationMinutes = const Value.absent(),
            Value<double?> caloriesBurned = const Value.absent(),
            Value<double?> distanceKm = const Value.absent(),
            Value<int?> avgHeartRate = const Value.absent(),
            Value<String?> exercisesJson = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkoutsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            type: type,
            startedAt: startedAt,
            durationMinutes: durationMinutes,
            caloriesBurned: caloriesBurned,
            distanceKm: distanceKm,
            avgHeartRate: avgHeartRate,
            exercisesJson: exercisesJson,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WorkoutsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WorkoutsTable,
    Workout,
    $$WorkoutsTableFilterComposer,
    $$WorkoutsTableOrderingComposer,
    $$WorkoutsTableAnnotationComposer,
    $$WorkoutsTableCreateCompanionBuilder,
    $$WorkoutsTableUpdateCompanionBuilder,
    (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
    Workout,
    PrefetchHooks Function()>;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String userId,
  required String name,
  required String icon,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> completedDatesJson,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String> icon,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> completedDatesJson,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get completedDatesJson => $composableBuilder(
      column: $table.completedDatesJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get completedDatesJson => $composableBuilder(
      column: $table.completedDatesJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get currentStreak => $composableBuilder(
      column: $table.currentStreak, builder: (column) => column);

  GeneratedColumn<int> get longestStreak => $composableBuilder(
      column: $table.longestStreak, builder: (column) => column);

  GeneratedColumn<String> get completedDatesJson => $composableBuilder(
      column: $table.completedDatesJson, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$HabitsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function()> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> icon = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> completedDatesJson = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            userId: userId,
            name: name,
            icon: icon,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            completedDatesJson: completedDatesJson,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            required String icon,
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> completedDatesJson = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            userId: userId,
            name: name,
            icon: icon,
            currentStreak: currentStreak,
            longestStreak: longestStreak,
            completedDatesJson: completedDatesJson,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function()>;
typedef $$JournalEntriesTableCreateCompanionBuilder = JournalEntriesCompanion
    Function({
  required String id,
  required String userId,
  Value<String?> title,
  required String body,
  Value<String?> moodEmoji,
  Value<int?> moodScore,
  Value<String?> tagsJson,
  required DateTime createdAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$JournalEntriesTableUpdateCompanionBuilder = JournalEntriesCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String?> title,
  Value<String> body,
  Value<String?> moodEmoji,
  Value<int?> moodScore,
  Value<String?> tagsJson,
  Value<DateTime> createdAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get moodEmoji => $composableBuilder(
      column: $table.moodEmoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get moodScore => $composableBuilder(
      column: $table.moodScore, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get body => $composableBuilder(
      column: $table.body, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moodEmoji => $composableBuilder(
      column: $table.moodEmoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get moodScore => $composableBuilder(
      column: $table.moodScore, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tagsJson => $composableBuilder(
      column: $table.tagsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<String> get moodEmoji =>
      $composableBuilder(column: $table.moodEmoji, builder: (column) => column);

  GeneratedColumn<int> get moodScore =>
      $composableBuilder(column: $table.moodScore, builder: (column) => column);

  GeneratedColumn<String> get tagsJson =>
      $composableBuilder(column: $table.tagsJson, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$JournalEntriesTableTableManager extends RootTableManager<
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
      BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>
    ),
    JournalEntry,
    PrefetchHooks Function()> {
  $$JournalEntriesTableTableManager(
      _$AppDatabase db, $JournalEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<String?> moodEmoji = const Value.absent(),
            Value<int?> moodScore = const Value.absent(),
            Value<String?> tagsJson = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JournalEntriesCompanion(
            id: id,
            userId: userId,
            title: title,
            body: body,
            moodEmoji: moodEmoji,
            moodScore: moodScore,
            tagsJson: tagsJson,
            createdAt: createdAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            Value<String?> title = const Value.absent(),
            required String body,
            Value<String?> moodEmoji = const Value.absent(),
            Value<int?> moodScore = const Value.absent(),
            Value<String?> tagsJson = const Value.absent(),
            required DateTime createdAt,
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              JournalEntriesCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            body: body,
            moodEmoji: moodEmoji,
            moodScore: moodScore,
            tagsJson: tagsJson,
            createdAt: createdAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$JournalEntriesTableProcessedTableManager = ProcessedTableManager<
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
      BaseReferences<_$AppDatabase, $JournalEntriesTable, JournalEntry>
    ),
    JournalEntry,
    PrefetchHooks Function()>;
typedef $$WeddingPlansTableCreateCompanionBuilder = WeddingPlansCompanion
    Function({
  required String id,
  required String userId,
  required String role,
  Value<String?> relation,
  required DateTime firstEventTs,
  required DateTime lastEventTs,
  required String eventsJson,
  required int prepWeeks,
  required String primaryGoal,
  required String currentPhase,
  required DateTime createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$WeddingPlansTableUpdateCompanionBuilder = WeddingPlansCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> role,
  Value<String?> relation,
  Value<DateTime> firstEventTs,
  Value<DateTime> lastEventTs,
  Value<String> eventsJson,
  Value<int> prepWeeks,
  Value<String> primaryGoal,
  Value<String> currentPhase,
  Value<DateTime> createdAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$WeddingPlansTableReferences
    extends BaseReferences<_$AppDatabase, $WeddingPlansTable, WeddingPlan> {
  $$WeddingPlansTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$WeddingMealLogsTable, List<WeddingMealLog>>
      _weddingMealLogsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.weddingMealLogs,
              aliasName: $_aliasNameGenerator(
                  db.weddingPlans.id, db.weddingMealLogs.planId));

  $$WeddingMealLogsTableProcessedTableManager get weddingMealLogsRefs {
    final manager =
        $$WeddingMealLogsTableTableManager($_db, $_db.weddingMealLogs)
            .filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_weddingMealLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$WeddingPlansTableFilterComposer
    extends Composer<_$AppDatabase, $WeddingPlansTable> {
  $$WeddingPlansTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get relation => $composableBuilder(
      column: $table.relation, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastEventTs => $composableBuilder(
      column: $table.lastEventTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventsJson => $composableBuilder(
      column: $table.eventsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prepWeeks => $composableBuilder(
      column: $table.prepWeeks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  Expression<bool> weddingMealLogsRefs(
      Expression<bool> Function($$WeddingMealLogsTableFilterComposer f) f) {
    final $$WeddingMealLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weddingMealLogs,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeddingMealLogsTableFilterComposer(
              $db: $db,
              $table: $db.weddingMealLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WeddingPlansTableOrderingComposer
    extends Composer<_$AppDatabase, $WeddingPlansTable> {
  $$WeddingPlansTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get relation => $composableBuilder(
      column: $table.relation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastEventTs => $composableBuilder(
      column: $table.lastEventTs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventsJson => $composableBuilder(
      column: $table.eventsJson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get prepWeeks => $composableBuilder(
      column: $table.prepWeeks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get currentPhase => $composableBuilder(
      column: $table.currentPhase,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$WeddingPlansTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeddingPlansTable> {
  $$WeddingPlansTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get relation =>
      $composableBuilder(column: $table.relation, builder: (column) => column);

  GeneratedColumn<DateTime> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs, builder: (column) => column);

  GeneratedColumn<DateTime> get lastEventTs => $composableBuilder(
      column: $table.lastEventTs, builder: (column) => column);

  GeneratedColumn<String> get eventsJson => $composableBuilder(
      column: $table.eventsJson, builder: (column) => column);

  GeneratedColumn<int> get prepWeeks =>
      $composableBuilder(column: $table.prepWeeks, builder: (column) => column);

  GeneratedColumn<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => column);

  GeneratedColumn<String> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  Expression<T> weddingMealLogsRefs<T extends Object>(
      Expression<T> Function($$WeddingMealLogsTableAnnotationComposer a) f) {
    final $$WeddingMealLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.weddingMealLogs,
        getReferencedColumn: (t) => t.planId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeddingMealLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.weddingMealLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$WeddingPlansTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeddingPlansTable,
    WeddingPlan,
    $$WeddingPlansTableFilterComposer,
    $$WeddingPlansTableOrderingComposer,
    $$WeddingPlansTableAnnotationComposer,
    $$WeddingPlansTableCreateCompanionBuilder,
    $$WeddingPlansTableUpdateCompanionBuilder,
    (WeddingPlan, $$WeddingPlansTableReferences),
    WeddingPlan,
    PrefetchHooks Function({bool weddingMealLogsRefs})> {
  $$WeddingPlansTableTableManager(_$AppDatabase db, $WeddingPlansTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeddingPlansTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeddingPlansTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeddingPlansTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<String?> relation = const Value.absent(),
            Value<DateTime> firstEventTs = const Value.absent(),
            Value<DateTime> lastEventTs = const Value.absent(),
            Value<String> eventsJson = const Value.absent(),
            Value<int> prepWeeks = const Value.absent(),
            Value<String> primaryGoal = const Value.absent(),
            Value<String> currentPhase = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeddingPlansCompanion(
            id: id,
            userId: userId,
            role: role,
            relation: relation,
            firstEventTs: firstEventTs,
            lastEventTs: lastEventTs,
            eventsJson: eventsJson,
            prepWeeks: prepWeeks,
            primaryGoal: primaryGoal,
            currentPhase: currentPhase,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String role,
            Value<String?> relation = const Value.absent(),
            required DateTime firstEventTs,
            required DateTime lastEventTs,
            required String eventsJson,
            required int prepWeeks,
            required String primaryGoal,
            required String currentPhase,
            required DateTime createdAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeddingPlansCompanion.insert(
            id: id,
            userId: userId,
            role: role,
            relation: relation,
            firstEventTs: firstEventTs,
            lastEventTs: lastEventTs,
            eventsJson: eventsJson,
            prepWeeks: prepWeeks,
            primaryGoal: primaryGoal,
            currentPhase: currentPhase,
            createdAt: createdAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WeddingPlansTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({weddingMealLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (weddingMealLogsRefs) db.weddingMealLogs
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (weddingMealLogsRefs)
                    await $_getPrefetchedData<WeddingPlan, $WeddingPlansTable,
                            WeddingMealLog>(
                        currentTable: table,
                        referencedTable: $$WeddingPlansTableReferences
                            ._weddingMealLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$WeddingPlansTableReferences(db, table, p0)
                                .weddingMealLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.planId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$WeddingPlansTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeddingPlansTable,
    WeddingPlan,
    $$WeddingPlansTableFilterComposer,
    $$WeddingPlansTableOrderingComposer,
    $$WeddingPlansTableAnnotationComposer,
    $$WeddingPlansTableCreateCompanionBuilder,
    $$WeddingPlansTableUpdateCompanionBuilder,
    (WeddingPlan, $$WeddingPlansTableReferences),
    WeddingPlan,
    PrefetchHooks Function({bool weddingMealLogsRefs})>;
typedef $$WeddingMealLogsTableCreateCompanionBuilder = WeddingMealLogsCompanion
    Function({
  required String id,
  required String userId,
  required String planId,
  required String eventTag,
  required String timing,
  required DateTime loggedAt,
  Value<double?> calories,
  Value<String?> notes,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$WeddingMealLogsTableUpdateCompanionBuilder = WeddingMealLogsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> planId,
  Value<String> eventTag,
  Value<String> timing,
  Value<DateTime> loggedAt,
  Value<double?> calories,
  Value<String?> notes,
  Value<String> syncStatus,
  Value<int> rowid,
});

final class $$WeddingMealLogsTableReferences extends BaseReferences<
    _$AppDatabase, $WeddingMealLogsTable, WeddingMealLog> {
  $$WeddingMealLogsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $WeddingPlansTable _planIdTable(_$AppDatabase db) =>
      db.weddingPlans.createAlias(
          $_aliasNameGenerator(db.weddingMealLogs.planId, db.weddingPlans.id));

  $$WeddingPlansTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$WeddingPlansTableTableManager($_db, $_db.weddingPlans)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$WeddingMealLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeddingMealLogsTable> {
  $$WeddingMealLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventTag => $composableBuilder(
      column: $table.eventTag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timing => $composableBuilder(
      column: $table.timing, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  $$WeddingPlansTableFilterComposer get planId {
    final $$WeddingPlansTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.weddingPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeddingPlansTableFilterComposer(
              $db: $db,
              $table: $db.weddingPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeddingMealLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeddingMealLogsTable> {
  $$WeddingMealLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventTag => $composableBuilder(
      column: $table.eventTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timing => $composableBuilder(
      column: $table.timing, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  $$WeddingPlansTableOrderingComposer get planId {
    final $$WeddingPlansTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.weddingPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeddingPlansTableOrderingComposer(
              $db: $db,
              $table: $db.weddingPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeddingMealLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeddingMealLogsTable> {
  $$WeddingMealLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get eventTag =>
      $composableBuilder(column: $table.eventTag, builder: (column) => column);

  GeneratedColumn<String> get timing =>
      $composableBuilder(column: $table.timing, builder: (column) => column);

  GeneratedColumn<DateTime> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  $$WeddingPlansTableAnnotationComposer get planId {
    final $$WeddingPlansTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.planId,
        referencedTable: $db.weddingPlans,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$WeddingPlansTableAnnotationComposer(
              $db: $db,
              $table: $db.weddingPlans,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$WeddingMealLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeddingMealLogsTable,
    WeddingMealLog,
    $$WeddingMealLogsTableFilterComposer,
    $$WeddingMealLogsTableOrderingComposer,
    $$WeddingMealLogsTableAnnotationComposer,
    $$WeddingMealLogsTableCreateCompanionBuilder,
    $$WeddingMealLogsTableUpdateCompanionBuilder,
    (WeddingMealLog, $$WeddingMealLogsTableReferences),
    WeddingMealLog,
    PrefetchHooks Function({bool planId})> {
  $$WeddingMealLogsTableTableManager(
      _$AppDatabase db, $WeddingMealLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeddingMealLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeddingMealLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeddingMealLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> planId = const Value.absent(),
            Value<String> eventTag = const Value.absent(),
            Value<String> timing = const Value.absent(),
            Value<DateTime> loggedAt = const Value.absent(),
            Value<double?> calories = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeddingMealLogsCompanion(
            id: id,
            userId: userId,
            planId: planId,
            eventTag: eventTag,
            timing: timing,
            loggedAt: loggedAt,
            calories: calories,
            notes: notes,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String planId,
            required String eventTag,
            required String timing,
            required DateTime loggedAt,
            Value<double?> calories = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeddingMealLogsCompanion.insert(
            id: id,
            userId: userId,
            planId: planId,
            eventTag: eventTag,
            timing: timing,
            loggedAt: loggedAt,
            calories: calories,
            notes: notes,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$WeddingMealLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (planId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.planId,
                    referencedTable:
                        $$WeddingMealLogsTableReferences._planIdTable(db),
                    referencedColumn:
                        $$WeddingMealLogsTableReferences._planIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$WeddingMealLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeddingMealLogsTable,
    WeddingMealLog,
    $$WeddingMealLogsTableFilterComposer,
    $$WeddingMealLogsTableOrderingComposer,
    $$WeddingMealLogsTableAnnotationComposer,
    $$WeddingMealLogsTableCreateCompanionBuilder,
    $$WeddingMealLogsTableUpdateCompanionBuilder,
    (WeddingMealLog, $$WeddingMealLogsTableReferences),
    WeddingMealLog,
    PrefetchHooks Function({bool planId})>;
typedef $$StepCountsTableCreateCompanionBuilder = StepCountsCompanion Function({
  required String id,
  required String userId,
  required DateTime date,
  Value<int> count,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$StepCountsTableUpdateCompanionBuilder = StepCountsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<DateTime> date,
  Value<int> count,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$StepCountsTableFilterComposer
    extends Composer<_$AppDatabase, $StepCountsTable> {
  $$StepCountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$StepCountsTableOrderingComposer
    extends Composer<_$AppDatabase, $StepCountsTable> {
  $$StepCountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get count => $composableBuilder(
      column: $table.count, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$StepCountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StepCountsTable> {
  $$StepCountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$StepCountsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StepCountsTable,
    StepCount,
    $$StepCountsTableFilterComposer,
    $$StepCountsTableOrderingComposer,
    $$StepCountsTableAnnotationComposer,
    $$StepCountsTableCreateCompanionBuilder,
    $$StepCountsTableUpdateCompanionBuilder,
    (StepCount, BaseReferences<_$AppDatabase, $StepCountsTable, StepCount>),
    StepCount,
    PrefetchHooks Function()> {
  $$StepCountsTableTableManager(_$AppDatabase db, $StepCountsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StepCountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StepCountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StepCountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<int> count = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StepCountsCompanion(
            id: id,
            userId: userId,
            date: date,
            count: count,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required DateTime date,
            Value<int> count = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StepCountsCompanion.insert(
            id: id,
            userId: userId,
            date: date,
            count: count,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$StepCountsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StepCountsTable,
    StepCount,
    $$StepCountsTableFilterComposer,
    $$StepCountsTableOrderingComposer,
    $$StepCountsTableAnnotationComposer,
    $$StepCountsTableCreateCompanionBuilder,
    $$StepCountsTableUpdateCompanionBuilder,
    (StepCount, BaseReferences<_$AppDatabase, $StepCountsTable, StepCount>),
    StepCount,
    PrefetchHooks Function()>;
typedef $$Spo2ReadingsTableCreateCompanionBuilder = Spo2ReadingsCompanion
    Function({
  required String id,
  required String userId,
  required int spo2Percentage,
  Value<int?> pulse,
  required DateTime measuredAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$Spo2ReadingsTableUpdateCompanionBuilder = Spo2ReadingsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<int> spo2Percentage,
  Value<int?> pulse,
  Value<DateTime> measuredAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});

class $$Spo2ReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $Spo2ReadingsTable> {
  $$Spo2ReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get pulse => $composableBuilder(
      column: $table.pulse, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
}

class $$Spo2ReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $Spo2ReadingsTable> {
  $$Spo2ReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get pulse => $composableBuilder(
      column: $table.pulse, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
}

class $$Spo2ReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $Spo2ReadingsTable> {
  $$Spo2ReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get spo2Percentage => $composableBuilder(
      column: $table.spo2Percentage, builder: (column) => column);

  GeneratedColumn<int> get pulse =>
      $composableBuilder(column: $table.pulse, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$Spo2ReadingsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $Spo2ReadingsTable,
    Spo2Reading,
    $$Spo2ReadingsTableFilterComposer,
    $$Spo2ReadingsTableOrderingComposer,
    $$Spo2ReadingsTableAnnotationComposer,
    $$Spo2ReadingsTableCreateCompanionBuilder,
    $$Spo2ReadingsTableUpdateCompanionBuilder,
    (
      Spo2Reading,
      BaseReferences<_$AppDatabase, $Spo2ReadingsTable, Spo2Reading>
    ),
    Spo2Reading,
    PrefetchHooks Function()> {
  $$Spo2ReadingsTableTableManager(_$AppDatabase db, $Spo2ReadingsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$Spo2ReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$Spo2ReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$Spo2ReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<int> spo2Percentage = const Value.absent(),
            Value<int?> pulse = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Spo2ReadingsCompanion(
            id: id,
            userId: userId,
            spo2Percentage: spo2Percentage,
            pulse: pulse,
            measuredAt: measuredAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required int spo2Percentage,
            Value<int?> pulse = const Value.absent(),
            required DateTime measuredAt,
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              Spo2ReadingsCompanion.insert(
            id: id,
            userId: userId,
            spo2Percentage: spo2Percentage,
            pulse: pulse,
            measuredAt: measuredAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$Spo2ReadingsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $Spo2ReadingsTable,
    Spo2Reading,
    $$Spo2ReadingsTableFilterComposer,
    $$Spo2ReadingsTableOrderingComposer,
    $$Spo2ReadingsTableAnnotationComposer,
    $$Spo2ReadingsTableCreateCompanionBuilder,
    $$Spo2ReadingsTableUpdateCompanionBuilder,
    (
      Spo2Reading,
      BaseReferences<_$AppDatabase, $Spo2ReadingsTable, Spo2Reading>
    ),
    Spo2Reading,
    PrefetchHooks Function()>;
typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String id,
  required String name,
  Value<int> xp,
  Value<int> level,
  Value<String?> rank,
  Value<double?> heightCm,
  Value<String?> religion,
  Value<String?> region,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<int> xp,
  Value<int> level,
  Value<String?> rank,
  Value<double?> heightCm,
  Value<String?> religion,
  Value<String?> region,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get religion => $composableBuilder(
      column: $table.religion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get rank => $composableBuilder(
      column: $table.rank, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get religion => $composableBuilder(
      column: $table.religion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<String> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<String> get religion =>
      $composableBuilder(column: $table.religion, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String?> rank = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<String?> religion = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            xp: xp,
            level: level,
            rank: rank,
            heightCm: heightCm,
            religion: religion,
            region: region,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<int> xp = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<String?> rank = const Value.absent(),
            Value<double?> heightCm = const Value.absent(),
            Value<String?> religion = const Value.absent(),
            Value<String?> region = const Value.absent(),
            required DateTime updatedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            xp: xp,
            level: level,
            rank: rank,
            heightCm: heightCm,
            religion: religion,
            region: region,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;
typedef $$KarmaEventsTableCreateCompanionBuilder = KarmaEventsCompanion
    Function({
  required String id,
  required String userId,
  required String eventType,
  required int points,
  required DateTime occurredAt,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$KarmaEventsTableUpdateCompanionBuilder = KarmaEventsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> eventType,
  Value<int> points,
  Value<DateTime> occurredAt,
  Value<String> syncStatus,
  Value<int> rowid,
});

class $$KarmaEventsTableFilterComposer
    extends Composer<_$AppDatabase, $KarmaEventsTable> {
  $$KarmaEventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
}

class $$KarmaEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $KarmaEventsTable> {
  $$KarmaEventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventType => $composableBuilder(
      column: $table.eventType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get points => $composableBuilder(
      column: $table.points, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
}

class $$KarmaEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KarmaEventsTable> {
  $$KarmaEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<int> get points =>
      $composableBuilder(column: $table.points, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
}

class $$KarmaEventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KarmaEventsTable,
    KarmaEvent,
    $$KarmaEventsTableFilterComposer,
    $$KarmaEventsTableOrderingComposer,
    $$KarmaEventsTableAnnotationComposer,
    $$KarmaEventsTableCreateCompanionBuilder,
    $$KarmaEventsTableUpdateCompanionBuilder,
    (KarmaEvent, BaseReferences<_$AppDatabase, $KarmaEventsTable, KarmaEvent>),
    KarmaEvent,
    PrefetchHooks Function()> {
  $$KarmaEventsTableTableManager(_$AppDatabase db, $KarmaEventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KarmaEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KarmaEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KarmaEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> eventType = const Value.absent(),
            Value<int> points = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KarmaEventsCompanion(
            id: id,
            userId: userId,
            eventType: eventType,
            points: points,
            occurredAt: occurredAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String eventType,
            required int points,
            required DateTime occurredAt,
            Value<String> syncStatus = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KarmaEventsCompanion.insert(
            id: id,
            userId: userId,
            eventType: eventType,
            points: points,
            occurredAt: occurredAt,
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$KarmaEventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KarmaEventsTable,
    KarmaEvent,
    $$KarmaEventsTableFilterComposer,
    $$KarmaEventsTableOrderingComposer,
    $$KarmaEventsTableAnnotationComposer,
    $$KarmaEventsTableCreateCompanionBuilder,
    $$KarmaEventsTableUpdateCompanionBuilder,
    (KarmaEvent, BaseReferences<_$AppDatabase, $KarmaEventsTable, KarmaEvent>),
    KarmaEvent,
    PrefetchHooks Function()>;
typedef $$WeightLogsTableCreateCompanionBuilder = WeightLogsCompanion Function({
  required String id,
  required String userId,
  required double weightKg,
  required DateTime measuredAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$WeightLogsTableUpdateCompanionBuilder = WeightLogsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<double> weightKg,
  Value<DateTime> measuredAt,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});

class $$WeightLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnFilters(column));
}

class $$WeightLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remoteId => $composableBuilder(
      column: $table.remoteId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts,
      builder: (column) => ColumnOrderings(column));
}

class $$WeightLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightLogsTable> {
  $$WeightLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get measuredAt => $composableBuilder(
      column: $table.measuredAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get failedAttempts => $composableBuilder(
      column: $table.failedAttempts, builder: (column) => column);
}

class $$WeightLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeightLogsTable,
    WeightLog,
    $$WeightLogsTableFilterComposer,
    $$WeightLogsTableOrderingComposer,
    $$WeightLogsTableAnnotationComposer,
    $$WeightLogsTableCreateCompanionBuilder,
    $$WeightLogsTableUpdateCompanionBuilder,
    (WeightLog, BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>),
    WeightLog,
    PrefetchHooks Function()> {
  $$WeightLogsTableTableManager(_$AppDatabase db, $WeightLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<DateTime> measuredAt = const Value.absent(),
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightLogsCompanion(
            id: id,
            userId: userId,
            weightKg: weightKg,
            measuredAt: measuredAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required double weightKg,
            required DateTime measuredAt,
            Value<String> syncStatus = const Value.absent(),
            Value<String?> remoteId = const Value.absent(),
            Value<int> failedAttempts = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightLogsCompanion.insert(
            id: id,
            userId: userId,
            weightKg: weightKg,
            measuredAt: measuredAt,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeightLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeightLogsTable,
    WeightLog,
    $$WeightLogsTableFilterComposer,
    $$WeightLogsTableOrderingComposer,
    $$WeightLogsTableAnnotationComposer,
    $$WeightLogsTableCreateCompanionBuilder,
    $$WeightLogsTableUpdateCompanionBuilder,
    (WeightLog, BaseReferences<_$AppDatabase, $WeightLogsTable, WeightLog>),
    WeightLog,
    PrefetchHooks Function()>;
typedef $$FestivalsTableCreateCompanionBuilder = FestivalsCompanion Function({
  required String id,
  required String name,
  Value<String?> description,
  required DateTime startDate,
  required DateTime endDate,
  Value<String?> religion,
  Value<String?> region,
  Value<String?> dietPlanJson,
  Value<int> rowid,
});
typedef $$FestivalsTableUpdateCompanionBuilder = FestivalsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<DateTime> startDate,
  Value<DateTime> endDate,
  Value<String?> religion,
  Value<String?> region,
  Value<String?> dietPlanJson,
  Value<int> rowid,
});

class $$FestivalsTableFilterComposer
    extends Composer<_$AppDatabase, $FestivalsTable> {
  $$FestivalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get religion => $composableBuilder(
      column: $table.religion, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get dietPlanJson => $composableBuilder(
      column: $table.dietPlanJson, builder: (column) => ColumnFilters(column));
}

class $$FestivalsTableOrderingComposer
    extends Composer<_$AppDatabase, $FestivalsTable> {
  $$FestivalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get religion => $composableBuilder(
      column: $table.religion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get region => $composableBuilder(
      column: $table.region, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get dietPlanJson => $composableBuilder(
      column: $table.dietPlanJson,
      builder: (column) => ColumnOrderings(column));
}

class $$FestivalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FestivalsTable> {
  $$FestivalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get religion =>
      $composableBuilder(column: $table.religion, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get dietPlanJson => $composableBuilder(
      column: $table.dietPlanJson, builder: (column) => column);
}

class $$FestivalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FestivalsTable,
    Festival,
    $$FestivalsTableFilterComposer,
    $$FestivalsTableOrderingComposer,
    $$FestivalsTableAnnotationComposer,
    $$FestivalsTableCreateCompanionBuilder,
    $$FestivalsTableUpdateCompanionBuilder,
    (Festival, BaseReferences<_$AppDatabase, $FestivalsTable, Festival>),
    Festival,
    PrefetchHooks Function()> {
  $$FestivalsTableTableManager(_$AppDatabase db, $FestivalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FestivalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FestivalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FestivalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> endDate = const Value.absent(),
            Value<String?> religion = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String?> dietPlanJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FestivalsCompanion(
            id: id,
            name: name,
            description: description,
            startDate: startDate,
            endDate: endDate,
            religion: religion,
            region: region,
            dietPlanJson: dietPlanJson,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            required DateTime startDate,
            required DateTime endDate,
            Value<String?> religion = const Value.absent(),
            Value<String?> region = const Value.absent(),
            Value<String?> dietPlanJson = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FestivalsCompanion.insert(
            id: id,
            name: name,
            description: description,
            startDate: startDate,
            endDate: endDate,
            religion: religion,
            region: region,
            dietPlanJson: dietPlanJson,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FestivalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FestivalsTable,
    Festival,
    $$FestivalsTableFilterComposer,
    $$FestivalsTableOrderingComposer,
    $$FestivalsTableAnnotationComposer,
    $$FestivalsTableCreateCompanionBuilder,
    $$FestivalsTableUpdateCompanionBuilder,
    (Festival, BaseReferences<_$AppDatabase, $FestivalsTable, Festival>),
    Festival,
    PrefetchHooks Function()>;
typedef $$SocialPostsTableCreateCompanionBuilder = SocialPostsCompanion
    Function({
  required String id,
  required String userId,
  required String userName,
  Value<String?> userAvatarId,
  required String content,
  Value<String?> mediaFileId,
  Value<int> likeCount,
  Value<bool> isLiked,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SocialPostsTableUpdateCompanionBuilder = SocialPostsCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> userName,
  Value<String?> userAvatarId,
  Value<String> content,
  Value<String?> mediaFileId,
  Value<int> likeCount,
  Value<bool> isLiked,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SocialPostsTableFilterComposer
    extends Composer<_$AppDatabase, $SocialPostsTable> {
  $$SocialPostsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userAvatarId => $composableBuilder(
      column: $table.userAvatarId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mediaFileId => $composableBuilder(
      column: $table.mediaFileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLiked => $composableBuilder(
      column: $table.isLiked, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SocialPostsTableOrderingComposer
    extends Composer<_$AppDatabase, $SocialPostsTable> {
  $$SocialPostsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userName => $composableBuilder(
      column: $table.userName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userAvatarId => $composableBuilder(
      column: $table.userAvatarId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mediaFileId => $composableBuilder(
      column: $table.mediaFileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get likeCount => $composableBuilder(
      column: $table.likeCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLiked => $composableBuilder(
      column: $table.isLiked, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SocialPostsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SocialPostsTable> {
  $$SocialPostsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get userAvatarId => $composableBuilder(
      column: $table.userAvatarId, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get mediaFileId => $composableBuilder(
      column: $table.mediaFileId, builder: (column) => column);

  GeneratedColumn<int> get likeCount =>
      $composableBuilder(column: $table.likeCount, builder: (column) => column);

  GeneratedColumn<bool> get isLiked =>
      $composableBuilder(column: $table.isLiked, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SocialPostsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SocialPostsTable,
    SocialPost,
    $$SocialPostsTableFilterComposer,
    $$SocialPostsTableOrderingComposer,
    $$SocialPostsTableAnnotationComposer,
    $$SocialPostsTableCreateCompanionBuilder,
    $$SocialPostsTableUpdateCompanionBuilder,
    (SocialPost, BaseReferences<_$AppDatabase, $SocialPostsTable, SocialPost>),
    SocialPost,
    PrefetchHooks Function()> {
  $$SocialPostsTableTableManager(_$AppDatabase db, $SocialPostsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SocialPostsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SocialPostsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SocialPostsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> userName = const Value.absent(),
            Value<String?> userAvatarId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> mediaFileId = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<bool> isLiked = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SocialPostsCompanion(
            id: id,
            userId: userId,
            userName: userName,
            userAvatarId: userAvatarId,
            content: content,
            mediaFileId: mediaFileId,
            likeCount: likeCount,
            isLiked: isLiked,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String userName,
            Value<String?> userAvatarId = const Value.absent(),
            required String content,
            Value<String?> mediaFileId = const Value.absent(),
            Value<int> likeCount = const Value.absent(),
            Value<bool> isLiked = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SocialPostsCompanion.insert(
            id: id,
            userId: userId,
            userName: userName,
            userAvatarId: userAvatarId,
            content: content,
            mediaFileId: mediaFileId,
            likeCount: likeCount,
            isLiked: isLiked,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SocialPostsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SocialPostsTable,
    SocialPost,
    $$SocialPostsTableFilterComposer,
    $$SocialPostsTableOrderingComposer,
    $$SocialPostsTableAnnotationComposer,
    $$SocialPostsTableCreateCompanionBuilder,
    $$SocialPostsTableUpdateCompanionBuilder,
    (SocialPost, BaseReferences<_$AppDatabase, $SocialPostsTable, SocialPost>),
    SocialPost,
    PrefetchHooks Function()>;
typedef $$CommunityGroupsTableCreateCompanionBuilder = CommunityGroupsCompanion
    Function({
  required String id,
  required String name,
  Value<String?> description,
  Value<String?> iconId,
  Value<int> memberCount,
  Value<bool> isJoined,
  Value<int> rowid,
});
typedef $$CommunityGroupsTableUpdateCompanionBuilder = CommunityGroupsCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> description,
  Value<String?> iconId,
  Value<int> memberCount,
  Value<bool> isJoined,
  Value<int> rowid,
});

class $$CommunityGroupsTableFilterComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get iconId => $composableBuilder(
      column: $table.iconId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isJoined => $composableBuilder(
      column: $table.isJoined, builder: (column) => ColumnFilters(column));
}

class $$CommunityGroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get iconId => $composableBuilder(
      column: $table.iconId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isJoined => $composableBuilder(
      column: $table.isJoined, builder: (column) => ColumnOrderings(column));
}

class $$CommunityGroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CommunityGroupsTable> {
  $$CommunityGroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get iconId =>
      $composableBuilder(column: $table.iconId, builder: (column) => column);

  GeneratedColumn<int> get memberCount => $composableBuilder(
      column: $table.memberCount, builder: (column) => column);

  GeneratedColumn<bool> get isJoined =>
      $composableBuilder(column: $table.isJoined, builder: (column) => column);
}

class $$CommunityGroupsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CommunityGroupsTable,
    CommunityGroup,
    $$CommunityGroupsTableFilterComposer,
    $$CommunityGroupsTableOrderingComposer,
    $$CommunityGroupsTableAnnotationComposer,
    $$CommunityGroupsTableCreateCompanionBuilder,
    $$CommunityGroupsTableUpdateCompanionBuilder,
    (
      CommunityGroup,
      BaseReferences<_$AppDatabase, $CommunityGroupsTable, CommunityGroup>
    ),
    CommunityGroup,
    PrefetchHooks Function()> {
  $$CommunityGroupsTableTableManager(
      _$AppDatabase db, $CommunityGroupsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CommunityGroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CommunityGroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CommunityGroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> iconId = const Value.absent(),
            Value<int> memberCount = const Value.absent(),
            Value<bool> isJoined = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CommunityGroupsCompanion(
            id: id,
            name: name,
            description: description,
            iconId: iconId,
            memberCount: memberCount,
            isJoined: isJoined,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> iconId = const Value.absent(),
            Value<int> memberCount = const Value.absent(),
            Value<bool> isJoined = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CommunityGroupsCompanion.insert(
            id: id,
            name: name,
            description: description,
            iconId: iconId,
            memberCount: memberCount,
            isJoined: isJoined,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CommunityGroupsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CommunityGroupsTable,
    CommunityGroup,
    $$CommunityGroupsTableFilterComposer,
    $$CommunityGroupsTableOrderingComposer,
    $$CommunityGroupsTableAnnotationComposer,
    $$CommunityGroupsTableCreateCompanionBuilder,
    $$CommunityGroupsTableUpdateCompanionBuilder,
    (
      CommunityGroup,
      BaseReferences<_$AppDatabase, $CommunityGroupsTable, CommunityGroup>
    ),
    CommunityGroup,
    PrefetchHooks Function()>;
typedef $$LabReportsTableCreateCompanionBuilder = LabReportsCompanion Function({
  required String id,
  required String userId,
  required String fileName,
  required String fileId,
  Value<String?> reportType,
  Value<String?> extractedDataJson,
  Value<DateTime?> reportDate,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$LabReportsTableUpdateCompanionBuilder = LabReportsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> fileName,
  Value<String> fileId,
  Value<String?> reportType,
  Value<String?> extractedDataJson,
  Value<DateTime?> reportDate,
  Value<DateTime> createdAt,
  Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fileId => $composableBuilder(
      column: $table.fileId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reportType => $composableBuilder(
      column: $table.reportType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get extractedDataJson => $composableBuilder(
      column: $table.extractedDataJson,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
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
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileName => $composableBuilder(
      column: $table.fileName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fileId => $composableBuilder(
      column: $table.fileId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reportType => $composableBuilder(
      column: $table.reportType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get extractedDataJson => $composableBuilder(
      column: $table.extractedDataJson,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<String> get fileId =>
      $composableBuilder(column: $table.fileId, builder: (column) => column);

  GeneratedColumn<String> get reportType => $composableBuilder(
      column: $table.reportType, builder: (column) => column);

  GeneratedColumn<String> get extractedDataJson => $composableBuilder(
      column: $table.extractedDataJson, builder: (column) => column);

  GeneratedColumn<DateTime> get reportDate => $composableBuilder(
      column: $table.reportDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$LabReportsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function()> {
  $$LabReportsTableTableManager(_$AppDatabase db, $LabReportsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LabReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LabReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LabReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<String> fileName = const Value.absent(),
            Value<String> fileId = const Value.absent(),
            Value<String?> reportType = const Value.absent(),
            Value<String?> extractedDataJson = const Value.absent(),
            Value<DateTime?> reportDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LabReportsCompanion(
            id: id,
            userId: userId,
            fileName: fileName,
            fileId: fileId,
            reportType: reportType,
            extractedDataJson: extractedDataJson,
            reportDate: reportDate,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String fileName,
            required String fileId,
            Value<String?> reportType = const Value.absent(),
            Value<String?> extractedDataJson = const Value.absent(),
            Value<DateTime?> reportDate = const Value.absent(),
            required DateTime createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LabReportsCompanion.insert(
            id: id,
            userId: userId,
            fileName: fileName,
            fileId: fileId,
            reportType: reportType,
            extractedDataJson: extractedDataJson,
            reportDate: reportDate,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LabReportsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodLogsTableTableManager get foodLogs =>
      $$FoodLogsTableTableManager(_db, _db.foodLogs);
  $$BpReadingsTableTableManager get bpReadings =>
      $$BpReadingsTableTableManager(_db, _db.bpReadings);
  $$GlucoseReadingsTableTableManager get glucoseReadings =>
      $$GlucoseReadingsTableTableManager(_db, _db.glucoseReadings);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$JournalEntriesTableTableManager get journalEntries =>
      $$JournalEntriesTableTableManager(_db, _db.journalEntries);
  $$WeddingPlansTableTableManager get weddingPlans =>
      $$WeddingPlansTableTableManager(_db, _db.weddingPlans);
  $$WeddingMealLogsTableTableManager get weddingMealLogs =>
      $$WeddingMealLogsTableTableManager(_db, _db.weddingMealLogs);
  $$StepCountsTableTableManager get stepCounts =>
      $$StepCountsTableTableManager(_db, _db.stepCounts);
  $$Spo2ReadingsTableTableManager get spo2Readings =>
      $$Spo2ReadingsTableTableManager(_db, _db.spo2Readings);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$KarmaEventsTableTableManager get karmaEvents =>
      $$KarmaEventsTableTableManager(_db, _db.karmaEvents);
  $$WeightLogsTableTableManager get weightLogs =>
      $$WeightLogsTableTableManager(_db, _db.weightLogs);
  $$FestivalsTableTableManager get festivals =>
      $$FestivalsTableTableManager(_db, _db.festivals);
  $$SocialPostsTableTableManager get socialPosts =>
      $$SocialPostsTableTableManager(_db, _db.socialPosts);
  $$CommunityGroupsTableTableManager get communityGroups =>
      $$CommunityGroupsTableTableManager(_db, _db.communityGroups);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db, _db.labReports);
}
