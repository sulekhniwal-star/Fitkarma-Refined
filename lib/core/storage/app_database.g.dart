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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodNameMeta =
      const VerificationMeta('foodName');
  @override
  late final GeneratedColumn<String> foodName = GeneratedColumn<String>(
      'food_name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _foodNameLocalMeta =
      const VerificationMeta('foodNameLocal');
  @override
  late final GeneratedColumn<String> foodNameLocal = GeneratedColumn<String>(
      'food_name_local', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumn<String> mealType = GeneratedColumn<String>(
      'meal_type', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<int> loggedAt = GeneratedColumn<int>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinGMeta =
      const VerificationMeta('proteinG');
  @override
  late final GeneratedColumn<double> proteinG = GeneratedColumn<double>(
      'protein_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _carbsGMeta = const VerificationMeta('carbsG');
  @override
  late final GeneratedColumn<double> carbsG = GeneratedColumn<double>(
      'carbs_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fatGMeta = const VerificationMeta('fatG');
  @override
  late final GeneratedColumn<double> fatG = GeneratedColumn<double>(
      'fat_g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _portionUnitMeta =
      const VerificationMeta('portionUnit');
  @override
  late final GeneratedColumn<String> portionUnit = GeneratedColumn<String>(
      'portion_unit', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _portionQtyMeta =
      const VerificationMeta('portionQty');
  @override
  late final GeneratedColumn<double> portionQty = GeneratedColumn<double>(
      'portion_qty', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_caloriesMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}logged_at'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories'])!,
      proteinG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein_g']),
      carbsG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_g']),
      fatG: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g']),
      portionUnit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}portion_unit']),
      portionQty: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}portion_qty']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
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
  final int loggedAt;
  final double calories;
  final double? proteinG;
  final double? carbsG;
  final double? fatG;
  final String? portionUnit;
  final double? portionQty;
  final String? source;
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
      this.proteinG,
      this.carbsG,
      this.fatG,
      this.portionUnit,
      this.portionQty,
      this.source,
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
    map['logged_at'] = Variable<int>(loggedAt);
    map['calories'] = Variable<double>(calories);
    if (!nullToAbsent || proteinG != null) {
      map['protein_g'] = Variable<double>(proteinG);
    }
    if (!nullToAbsent || carbsG != null) {
      map['carbs_g'] = Variable<double>(carbsG);
    }
    if (!nullToAbsent || fatG != null) {
      map['fat_g'] = Variable<double>(fatG);
    }
    if (!nullToAbsent || portionUnit != null) {
      map['portion_unit'] = Variable<String>(portionUnit);
    }
    if (!nullToAbsent || portionQty != null) {
      map['portion_qty'] = Variable<double>(portionQty);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
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
      proteinG: proteinG == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinG),
      carbsG:
          carbsG == null && nullToAbsent ? const Value.absent() : Value(carbsG),
      fatG: fatG == null && nullToAbsent ? const Value.absent() : Value(fatG),
      portionUnit: portionUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(portionUnit),
      portionQty: portionQty == null && nullToAbsent
          ? const Value.absent()
          : Value(portionQty),
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
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
      loggedAt: serializer.fromJson<int>(json['loggedAt']),
      calories: serializer.fromJson<double>(json['calories']),
      proteinG: serializer.fromJson<double?>(json['proteinG']),
      carbsG: serializer.fromJson<double?>(json['carbsG']),
      fatG: serializer.fromJson<double?>(json['fatG']),
      portionUnit: serializer.fromJson<String?>(json['portionUnit']),
      portionQty: serializer.fromJson<double?>(json['portionQty']),
      source: serializer.fromJson<String?>(json['source']),
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
      'loggedAt': serializer.toJson<int>(loggedAt),
      'calories': serializer.toJson<double>(calories),
      'proteinG': serializer.toJson<double?>(proteinG),
      'carbsG': serializer.toJson<double?>(carbsG),
      'fatG': serializer.toJson<double?>(fatG),
      'portionUnit': serializer.toJson<String?>(portionUnit),
      'portionQty': serializer.toJson<double?>(portionQty),
      'source': serializer.toJson<String?>(source),
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
          int? loggedAt,
          double? calories,
          Value<double?> proteinG = const Value.absent(),
          Value<double?> carbsG = const Value.absent(),
          Value<double?> fatG = const Value.absent(),
          Value<String?> portionUnit = const Value.absent(),
          Value<double?> portionQty = const Value.absent(),
          Value<String?> source = const Value.absent(),
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
        proteinG: proteinG.present ? proteinG.value : this.proteinG,
        carbsG: carbsG.present ? carbsG.value : this.carbsG,
        fatG: fatG.present ? fatG.value : this.fatG,
        portionUnit: portionUnit.present ? portionUnit.value : this.portionUnit,
        portionQty: portionQty.present ? portionQty.value : this.portionQty,
        source: source.present ? source.value : this.source,
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
  final Value<int> loggedAt;
  final Value<double> calories;
  final Value<double?> proteinG;
  final Value<double?> carbsG;
  final Value<double?> fatG;
  final Value<String?> portionUnit;
  final Value<double?> portionQty;
  final Value<String?> source;
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
    required int loggedAt,
    required double calories,
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
  })  : id = Value(id),
        userId = Value(userId),
        foodName = Value(foodName),
        mealType = Value(mealType),
        loggedAt = Value(loggedAt),
        calories = Value(calories);
  static Insertable<FoodLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? foodName,
    Expression<String>? foodNameLocal,
    Expression<String>? mealType,
    Expression<int>? loggedAt,
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
      Value<int>? loggedAt,
      Value<double>? calories,
      Value<double?>? proteinG,
      Value<double?>? carbsG,
      Value<double?>? fatG,
      Value<String?>? portionUnit,
      Value<double?>? portionQty,
      Value<String?>? source,
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
      map['logged_at'] = Variable<int>(loggedAt.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
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
  late final GeneratedColumn<int> measuredAt = GeneratedColumn<int>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  @override
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
      'classification', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
          .read(DriftSqlType.int, data['${effectivePrefix}measured_at'])!,
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
  final int measuredAt;
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
    map['measured_at'] = Variable<int>(measuredAt);
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
      measuredAt: serializer.fromJson<int>(json['measuredAt']),
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
      'measuredAt': serializer.toJson<int>(measuredAt),
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
          int? measuredAt,
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
  final Value<int> measuredAt;
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
    required int measuredAt,
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
    Expression<int>? measuredAt,
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
      Value<int>? measuredAt,
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
      map['measured_at'] = Variable<int>(measuredAt.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _measuredAtMeta =
      const VerificationMeta('measuredAt');
  @override
  late final GeneratedColumn<int> measuredAt = GeneratedColumn<int>(
      'measured_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _classificationMeta =
      const VerificationMeta('classification');
  @override
  late final GeneratedColumn<String> classification = GeneratedColumn<String>(
      'classification', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _linkedFoodLogIdMeta =
      const VerificationMeta('linkedFoodLogId');
  @override
  late final GeneratedColumn<String> linkedFoodLogId = GeneratedColumn<String>(
      'linked_food_log_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
          .read(DriftSqlType.int, data['${effectivePrefix}measured_at'])!,
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
  final int measuredAt;
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
    map['measured_at'] = Variable<int>(measuredAt);
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
      measuredAt: serializer.fromJson<int>(json['measuredAt']),
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
      'measuredAt': serializer.toJson<int>(measuredAt),
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
          int? measuredAt,
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
  final Value<int> measuredAt;
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
    required int measuredAt,
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
    Expression<int>? measuredAt,
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
      Value<int>? measuredAt,
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
      map['measured_at'] = Variable<int>(measuredAt.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sleepStartMeta =
      const VerificationMeta('sleepStart');
  @override
  late final GeneratedColumn<int> sleepStart = GeneratedColumn<int>(
      'sleep_start', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _sleepEndMeta =
      const VerificationMeta('sleepEnd');
  @override
  late final GeneratedColumn<int> sleepEnd = GeneratedColumn<int>(
      'sleep_end', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
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
      'source', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_start'])!,
      sleepEnd: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}sleep_end'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      qualityScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quality_score']),
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source']),
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
  final int sleepStart;
  final int sleepEnd;
  final int durationMinutes;
  final int? qualityScore;
  final String? source;
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
      this.source,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['sleep_start'] = Variable<int>(sleepStart);
    map['sleep_end'] = Variable<int>(sleepEnd);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || qualityScore != null) {
      map['quality_score'] = Variable<int>(qualityScore);
    }
    if (!nullToAbsent || source != null) {
      map['source'] = Variable<String>(source);
    }
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
      source:
          source == null && nullToAbsent ? const Value.absent() : Value(source),
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
      sleepStart: serializer.fromJson<int>(json['sleepStart']),
      sleepEnd: serializer.fromJson<int>(json['sleepEnd']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      qualityScore: serializer.fromJson<int?>(json['qualityScore']),
      source: serializer.fromJson<String?>(json['source']),
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
      'sleepStart': serializer.toJson<int>(sleepStart),
      'sleepEnd': serializer.toJson<int>(sleepEnd),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'qualityScore': serializer.toJson<int?>(qualityScore),
      'source': serializer.toJson<String?>(source),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  SleepLog copyWith(
          {String? id,
          String? userId,
          int? sleepStart,
          int? sleepEnd,
          int? durationMinutes,
          Value<int?> qualityScore = const Value.absent(),
          Value<String?> source = const Value.absent(),
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
        source: source.present ? source.value : this.source,
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
  final Value<int> sleepStart;
  final Value<int> sleepEnd;
  final Value<int> durationMinutes;
  final Value<int?> qualityScore;
  final Value<String?> source;
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
    required int sleepStart,
    required int sleepEnd,
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
    Expression<int>? sleepStart,
    Expression<int>? sleepEnd,
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
      Value<int>? sleepStart,
      Value<int>? sleepEnd,
      Value<int>? durationMinutes,
      Value<int?>? qualityScore,
      Value<String?>? source,
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
      map['sleep_start'] = Variable<int>(sleepStart.value);
    }
    if (sleepEnd.present) {
      map['sleep_end'] = Variable<int>(sleepEnd.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<int> startedAt = GeneratedColumn<int>(
      'started_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _durationMinutesMeta =
      const VerificationMeta('durationMinutes');
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
      'duration_minutes', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesBurnedMeta =
      const VerificationMeta('caloriesBurned');
  @override
  late final GeneratedColumn<int> caloriesBurned = GeneratedColumn<int>(
      'calories_burned', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5000),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
    } else if (isInserting) {
      context.missing(_durationMinutesMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}started_at'])!,
      durationMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_minutes'])!,
      caloriesBurned: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories_burned']),
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
  final int startedAt;
  final int durationMinutes;
  final int? caloriesBurned;
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
      required this.durationMinutes,
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
    map['started_at'] = Variable<int>(startedAt);
    map['duration_minutes'] = Variable<int>(durationMinutes);
    if (!nullToAbsent || caloriesBurned != null) {
      map['calories_burned'] = Variable<int>(caloriesBurned);
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
      durationMinutes: Value(durationMinutes),
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
      startedAt: serializer.fromJson<int>(json['startedAt']),
      durationMinutes: serializer.fromJson<int>(json['durationMinutes']),
      caloriesBurned: serializer.fromJson<int?>(json['caloriesBurned']),
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
      'startedAt': serializer.toJson<int>(startedAt),
      'durationMinutes': serializer.toJson<int>(durationMinutes),
      'caloriesBurned': serializer.toJson<int?>(caloriesBurned),
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
          int? startedAt,
          int? durationMinutes,
          Value<int?> caloriesBurned = const Value.absent(),
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
        durationMinutes: durationMinutes ?? this.durationMinutes,
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
  final Value<int> startedAt;
  final Value<int> durationMinutes;
  final Value<int?> caloriesBurned;
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
    required int startedAt,
    required int durationMinutes,
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
        startedAt = Value(startedAt),
        durationMinutes = Value(durationMinutes);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<int>? startedAt,
    Expression<int>? durationMinutes,
    Expression<int>? caloriesBurned,
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
      Value<int>? startedAt,
      Value<int>? durationMinutes,
      Value<int?>? caloriesBurned,
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
      map['started_at'] = Variable<int>(startedAt.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (caloriesBurned.present) {
      map['calories_burned'] = Variable<int>(caloriesBurned.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
  static const VerificationMeta _completedDatesMeta =
      const VerificationMeta('completedDates');
  @override
  late final GeneratedColumn<String> completedDates = GeneratedColumn<String>(
      'completed_dates', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 5000),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
        completedDates,
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
    if (data.containsKey('completed_dates')) {
      context.handle(
          _completedDatesMeta,
          completedDates.isAcceptableOrUnknown(
              data['completed_dates']!, _completedDatesMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      currentStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_streak'])!,
      longestStreak: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}longest_streak'])!,
      completedDates: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}completed_dates']),
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
  final String? icon;
  final int currentStreak;
  final int longestStreak;
  final String? completedDates;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const Habit(
      {required this.id,
      required this.userId,
      required this.name,
      this.icon,
      required this.currentStreak,
      required this.longestStreak,
      this.completedDates,
      required this.syncStatus,
      this.remoteId,
      required this.failedAttempts});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['current_streak'] = Variable<int>(currentStreak);
    map['longest_streak'] = Variable<int>(longestStreak);
    if (!nullToAbsent || completedDates != null) {
      map['completed_dates'] = Variable<String>(completedDates);
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
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      currentStreak: Value(currentStreak),
      longestStreak: Value(longestStreak),
      completedDates: completedDates == null && nullToAbsent
          ? const Value.absent()
          : Value(completedDates),
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
      icon: serializer.fromJson<String?>(json['icon']),
      currentStreak: serializer.fromJson<int>(json['currentStreak']),
      longestStreak: serializer.fromJson<int>(json['longestStreak']),
      completedDates: serializer.fromJson<String?>(json['completedDates']),
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
      'icon': serializer.toJson<String?>(icon),
      'currentStreak': serializer.toJson<int>(currentStreak),
      'longestStreak': serializer.toJson<int>(longestStreak),
      'completedDates': serializer.toJson<String?>(completedDates),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  Habit copyWith(
          {String? id,
          String? userId,
          String? name,
          Value<String?> icon = const Value.absent(),
          int? currentStreak,
          int? longestStreak,
          Value<String?> completedDates = const Value.absent(),
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      Habit(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        icon: icon.present ? icon.value : this.icon,
        currentStreak: currentStreak ?? this.currentStreak,
        longestStreak: longestStreak ?? this.longestStreak,
        completedDates:
            completedDates.present ? completedDates.value : this.completedDates,
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
      completedDates: data.completedDates.present
          ? data.completedDates.value
          : this.completedDates,
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
          ..write('completedDates: $completedDates, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, name, icon, currentStreak,
      longestStreak, completedDates, syncStatus, remoteId, failedAttempts);
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
          other.completedDates == this.completedDates &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> icon;
  final Value<int> currentStreak;
  final Value<int> longestStreak;
  final Value<String?> completedDates;
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
    this.completedDates = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.icon = const Value.absent(),
    this.currentStreak = const Value.absent(),
    this.longestStreak = const Value.absent(),
    this.completedDates = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        name = Value(name);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<int>? currentStreak,
    Expression<int>? longestStreak,
    Expression<String>? completedDates,
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
      if (completedDates != null) 'completed_dates': completedDates,
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
      Value<String?>? icon,
      Value<int>? currentStreak,
      Value<int>? longestStreak,
      Value<String?>? completedDates,
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
      completedDates: completedDates ?? this.completedDates,
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
    if (completedDates.present) {
      map['completed_dates'] = Variable<String>(completedDates.value);
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
          ..write('completedDates: $completedDates, ')
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10000),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _moodEmojiMeta =
      const VerificationMeta('moodEmoji');
  @override
  late final GeneratedColumn<String> moodEmoji = GeneratedColumn<String>(
      'mood_emoji', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 10),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _moodScoreMeta =
      const VerificationMeta('moodScore');
  @override
  late final GeneratedColumn<int> moodScore = GeneratedColumn<int>(
      'mood_score', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _remoteIdMeta =
      const VerificationMeta('remoteId');
  @override
  late final GeneratedColumn<String> remoteId = GeneratedColumn<String>(
      'remote_id', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
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
        tags,
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
    }
    if (data.containsKey('mood_emoji')) {
      context.handle(_moodEmojiMeta,
          moodEmoji.isAcceptableOrUnknown(data['mood_emoji']!, _moodEmojiMeta));
    }
    if (data.containsKey('mood_score')) {
      context.handle(_moodScoreMeta,
          moodScore.isAcceptableOrUnknown(data['mood_score']!, _moodScoreMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
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
          .read(DriftSqlType.string, data['${effectivePrefix}body']),
      moodEmoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood_emoji']),
      moodScore: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mood_score']),
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
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
  final String? body;
  final String? moodEmoji;
  final int? moodScore;
  final String? tags;
  final int createdAt;
  final String syncStatus;
  final String? remoteId;
  final int failedAttempts;
  const JournalEntry(
      {required this.id,
      required this.userId,
      this.title,
      this.body,
      this.moodEmoji,
      this.moodScore,
      this.tags,
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
    if (!nullToAbsent || body != null) {
      map['body'] = Variable<String>(body);
    }
    if (!nullToAbsent || moodEmoji != null) {
      map['mood_emoji'] = Variable<String>(moodEmoji);
    }
    if (!nullToAbsent || moodScore != null) {
      map['mood_score'] = Variable<int>(moodScore);
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['created_at'] = Variable<int>(createdAt);
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
      body: body == null && nullToAbsent ? const Value.absent() : Value(body),
      moodEmoji: moodEmoji == null && nullToAbsent
          ? const Value.absent()
          : Value(moodEmoji),
      moodScore: moodScore == null && nullToAbsent
          ? const Value.absent()
          : Value(moodScore),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
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
      body: serializer.fromJson<String?>(json['body']),
      moodEmoji: serializer.fromJson<String?>(json['moodEmoji']),
      moodScore: serializer.fromJson<int?>(json['moodScore']),
      tags: serializer.fromJson<String?>(json['tags']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
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
      'body': serializer.toJson<String?>(body),
      'moodEmoji': serializer.toJson<String?>(moodEmoji),
      'moodScore': serializer.toJson<int?>(moodScore),
      'tags': serializer.toJson<String?>(tags),
      'createdAt': serializer.toJson<int>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'remoteId': serializer.toJson<String?>(remoteId),
      'failedAttempts': serializer.toJson<int>(failedAttempts),
    };
  }

  JournalEntry copyWith(
          {String? id,
          String? userId,
          Value<String?> title = const Value.absent(),
          Value<String?> body = const Value.absent(),
          Value<String?> moodEmoji = const Value.absent(),
          Value<int?> moodScore = const Value.absent(),
          Value<String?> tags = const Value.absent(),
          int? createdAt,
          String? syncStatus,
          Value<String?> remoteId = const Value.absent(),
          int? failedAttempts}) =>
      JournalEntry(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title.present ? title.value : this.title,
        body: body.present ? body.value : this.body,
        moodEmoji: moodEmoji.present ? moodEmoji.value : this.moodEmoji,
        moodScore: moodScore.present ? moodScore.value : this.moodScore,
        tags: tags.present ? tags.value : this.tags,
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
      tags: data.tags.present ? data.tags.value : this.tags,
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
          ..write('tags: $tags, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('remoteId: $remoteId, ')
          ..write('failedAttempts: $failedAttempts')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, body, moodEmoji, moodScore,
      tags, createdAt, syncStatus, remoteId, failedAttempts);
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
          other.tags == this.tags &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus &&
          other.remoteId == this.remoteId &&
          other.failedAttempts == this.failedAttempts);
}

class JournalEntriesCompanion extends UpdateCompanion<JournalEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> title;
  final Value<String?> body;
  final Value<String?> moodEmoji;
  final Value<int?> moodScore;
  final Value<String?> tags;
  final Value<int> createdAt;
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
    this.tags = const Value.absent(),
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
    this.body = const Value.absent(),
    this.moodEmoji = const Value.absent(),
    this.moodScore = const Value.absent(),
    this.tags = const Value.absent(),
    required int createdAt,
    this.syncStatus = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.failedAttempts = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        createdAt = Value(createdAt);
  static Insertable<JournalEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? title,
    Expression<String>? body,
    Expression<String>? moodEmoji,
    Expression<int>? moodScore,
    Expression<String>? tags,
    Expression<int>? createdAt,
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
      if (tags != null) 'tags': tags,
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
      Value<String?>? body,
      Value<String?>? moodEmoji,
      Value<int?>? moodScore,
      Value<String?>? tags,
      Value<int>? createdAt,
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
      tags: tags ?? this.tags,
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
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
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
          ..write('tags: $tags, ')
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _relationMeta =
      const VerificationMeta('relation');
  @override
  late final GeneratedColumn<String> relation = GeneratedColumn<String>(
      'relation', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _firstEventTsMeta =
      const VerificationMeta('firstEventTs');
  @override
  late final GeneratedColumn<int> firstEventTs = GeneratedColumn<int>(
      'first_event_ts', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastEventTsMeta =
      const VerificationMeta('lastEventTs');
  @override
  late final GeneratedColumn<int> lastEventTs = GeneratedColumn<int>(
      'last_event_ts', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _eventsJsonMeta =
      const VerificationMeta('eventsJson');
  @override
  late final GeneratedColumn<String> eventsJson = GeneratedColumn<String>(
      'events_json', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 1000),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _currentPhaseMeta =
      const VerificationMeta('currentPhase');
  @override
  late final GeneratedColumn<String> currentPhase = GeneratedColumn<String>(
      'current_phase', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
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
      firstEventTs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}first_event_ts'])!,
      lastEventTs: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_event_ts'])!,
      eventsJson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}events_json'])!,
      prepWeeks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}prep_weeks'])!,
      primaryGoal: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}primary_goal'])!,
      currentPhase: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}current_phase'])!,
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
  final int firstEventTs;
  final int lastEventTs;
  final String eventsJson;
  final int prepWeeks;
  final String primaryGoal;
  final String currentPhase;
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
    map['first_event_ts'] = Variable<int>(firstEventTs);
    map['last_event_ts'] = Variable<int>(lastEventTs);
    map['events_json'] = Variable<String>(eventsJson);
    map['prep_weeks'] = Variable<int>(prepWeeks);
    map['primary_goal'] = Variable<String>(primaryGoal);
    map['current_phase'] = Variable<String>(currentPhase);
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
      firstEventTs: serializer.fromJson<int>(json['firstEventTs']),
      lastEventTs: serializer.fromJson<int>(json['lastEventTs']),
      eventsJson: serializer.fromJson<String>(json['eventsJson']),
      prepWeeks: serializer.fromJson<int>(json['prepWeeks']),
      primaryGoal: serializer.fromJson<String>(json['primaryGoal']),
      currentPhase: serializer.fromJson<String>(json['currentPhase']),
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
      'firstEventTs': serializer.toJson<int>(firstEventTs),
      'lastEventTs': serializer.toJson<int>(lastEventTs),
      'eventsJson': serializer.toJson<String>(eventsJson),
      'prepWeeks': serializer.toJson<int>(prepWeeks),
      'primaryGoal': serializer.toJson<String>(primaryGoal),
      'currentPhase': serializer.toJson<String>(currentPhase),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  WeddingPlan copyWith(
          {String? id,
          String? userId,
          String? role,
          Value<String?> relation = const Value.absent(),
          int? firstEventTs,
          int? lastEventTs,
          String? eventsJson,
          int? prepWeeks,
          String? primaryGoal,
          String? currentPhase,
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
          other.syncStatus == this.syncStatus);
}

class WeddingPlansCompanion extends UpdateCompanion<WeddingPlan> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> role;
  final Value<String?> relation;
  final Value<int> firstEventTs;
  final Value<int> lastEventTs;
  final Value<String> eventsJson;
  final Value<int> prepWeeks;
  final Value<String> primaryGoal;
  final Value<String> currentPhase;
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
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeddingPlansCompanion.insert({
    required String id,
    required String userId,
    required String role,
    this.relation = const Value.absent(),
    required int firstEventTs,
    required int lastEventTs,
    required String eventsJson,
    required int prepWeeks,
    required String primaryGoal,
    required String currentPhase,
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
        currentPhase = Value(currentPhase);
  static Insertable<WeddingPlan> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? role,
    Expression<String>? relation,
    Expression<int>? firstEventTs,
    Expression<int>? lastEventTs,
    Expression<String>? eventsJson,
    Expression<int>? prepWeeks,
    Expression<String>? primaryGoal,
    Expression<String>? currentPhase,
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
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeddingPlansCompanion copyWith(
      {Value<String>? id,
      Value<String>? userId,
      Value<String>? role,
      Value<String?>? relation,
      Value<int>? firstEventTs,
      Value<int>? lastEventTs,
      Value<String>? eventsJson,
      Value<int>? prepWeeks,
      Value<String>? primaryGoal,
      Value<String>? currentPhase,
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
      map['first_event_ts'] = Variable<int>(firstEventTs.value);
    }
    if (lastEventTs.present) {
      map['last_event_ts'] = Variable<int>(lastEventTs.value);
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
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
      'plan_id', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 36),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _eventTagMeta =
      const VerificationMeta('eventTag');
  @override
  late final GeneratedColumn<String> eventTag = GeneratedColumn<String>(
      'event_tag', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timingMeta = const VerificationMeta('timing');
  @override
  late final GeneratedColumn<String> timing = GeneratedColumn<String>(
      'timing', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _loggedAtMeta =
      const VerificationMeta('loggedAt');
  @override
  late final GeneratedColumn<int> loggedAt = GeneratedColumn<int>(
      'logged_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: false);
  static const VerificationMeta _syncStatusMeta =
      const VerificationMeta('syncStatus');
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
      'sync_status', aliasedName, false,
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
    } else if (isInserting) {
      context.missing(_caloriesMeta);
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
          .read(DriftSqlType.int, data['${effectivePrefix}logged_at'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories'])!,
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
  final int loggedAt;
  final double calories;
  final String? notes;
  final String syncStatus;
  const WeddingMealLog(
      {required this.id,
      required this.userId,
      required this.planId,
      required this.eventTag,
      required this.timing,
      required this.loggedAt,
      required this.calories,
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
    map['logged_at'] = Variable<int>(loggedAt);
    map['calories'] = Variable<double>(calories);
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
      calories: Value(calories),
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
      loggedAt: serializer.fromJson<int>(json['loggedAt']),
      calories: serializer.fromJson<double>(json['calories']),
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
      'loggedAt': serializer.toJson<int>(loggedAt),
      'calories': serializer.toJson<double>(calories),
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
          int? loggedAt,
          double? calories,
          Value<String?> notes = const Value.absent(),
          String? syncStatus}) =>
      WeddingMealLog(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        planId: planId ?? this.planId,
        eventTag: eventTag ?? this.eventTag,
        timing: timing ?? this.timing,
        loggedAt: loggedAt ?? this.loggedAt,
        calories: calories ?? this.calories,
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
  final Value<int> loggedAt;
  final Value<double> calories;
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
    required int loggedAt,
    required double calories,
    this.notes = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        userId = Value(userId),
        planId = Value(planId),
        eventTag = Value(eventTag),
        timing = Value(timing),
        loggedAt = Value(loggedAt),
        calories = Value(calories);
  static Insertable<WeddingMealLog> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? planId,
    Expression<String>? eventTag,
    Expression<String>? timing,
    Expression<int>? loggedAt,
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
      Value<int>? loggedAt,
      Value<double>? calories,
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
      map['logged_at'] = Variable<int>(loggedAt.value);
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
        weddingMealLogs
      ];
}

typedef $$FoodLogsTableCreateCompanionBuilder = FoodLogsCompanion Function({
  required String id,
  required String userId,
  required String foodName,
  Value<String?> foodNameLocal,
  required String mealType,
  required int loggedAt,
  required double calories,
  Value<double?> proteinG,
  Value<double?> carbsG,
  Value<double?> fatG,
  Value<String?> portionUnit,
  Value<double?> portionQty,
  Value<String?> source,
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
  Value<int> loggedAt,
  Value<double> calories,
  Value<double?> proteinG,
  Value<double?> carbsG,
  Value<double?> fatG,
  Value<String?> portionUnit,
  Value<double?> portionQty,
  Value<String?> source,
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

  ColumnFilters<int> get loggedAt => $composableBuilder(
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

  ColumnOrderings<int> get loggedAt => $composableBuilder(
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

  GeneratedColumn<int> get loggedAt =>
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
            Value<int> loggedAt = const Value.absent(),
            Value<double> calories = const Value.absent(),
            Value<double?> proteinG = const Value.absent(),
            Value<double?> carbsG = const Value.absent(),
            Value<double?> fatG = const Value.absent(),
            Value<String?> portionUnit = const Value.absent(),
            Value<double?> portionQty = const Value.absent(),
            Value<String?> source = const Value.absent(),
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
            required int loggedAt,
            required double calories,
            Value<double?> proteinG = const Value.absent(),
            Value<double?> carbsG = const Value.absent(),
            Value<double?> fatG = const Value.absent(),
            Value<String?> portionUnit = const Value.absent(),
            Value<double?> portionQty = const Value.absent(),
            Value<String?> source = const Value.absent(),
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
  required int measuredAt,
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
  Value<int> measuredAt,
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

  ColumnFilters<int> get measuredAt => $composableBuilder(
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

  ColumnOrderings<int> get measuredAt => $composableBuilder(
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

  GeneratedColumn<int> get measuredAt => $composableBuilder(
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
            Value<int> measuredAt = const Value.absent(),
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
            required int measuredAt,
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
  required int measuredAt,
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
  Value<int> measuredAt,
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

  ColumnFilters<int> get measuredAt => $composableBuilder(
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

  ColumnOrderings<int> get measuredAt => $composableBuilder(
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

  GeneratedColumn<int> get measuredAt => $composableBuilder(
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
            Value<int> measuredAt = const Value.absent(),
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
            required int measuredAt,
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
  required int sleepStart,
  required int sleepEnd,
  required int durationMinutes,
  Value<int?> qualityScore,
  Value<String?> source,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$SleepLogsTableUpdateCompanionBuilder = SleepLogsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<int> sleepStart,
  Value<int> sleepEnd,
  Value<int> durationMinutes,
  Value<int?> qualityScore,
  Value<String?> source,
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

  ColumnFilters<int> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get sleepEnd => $composableBuilder(
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

  ColumnOrderings<int> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get sleepEnd => $composableBuilder(
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

  GeneratedColumn<int> get sleepStart => $composableBuilder(
      column: $table.sleepStart, builder: (column) => column);

  GeneratedColumn<int> get sleepEnd =>
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
            Value<int> sleepStart = const Value.absent(),
            Value<int> sleepEnd = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int?> qualityScore = const Value.absent(),
            Value<String?> source = const Value.absent(),
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
            required int sleepStart,
            required int sleepEnd,
            required int durationMinutes,
            Value<int?> qualityScore = const Value.absent(),
            Value<String?> source = const Value.absent(),
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
  required int startedAt,
  required int durationMinutes,
  Value<int?> caloriesBurned,
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
  Value<int> startedAt,
  Value<int> durationMinutes,
  Value<int?> caloriesBurned,
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

  ColumnFilters<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get caloriesBurned => $composableBuilder(
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

  ColumnOrderings<int> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get caloriesBurned => $composableBuilder(
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

  GeneratedColumn<int> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
      column: $table.durationMinutes, builder: (column) => column);

  GeneratedColumn<int> get caloriesBurned => $composableBuilder(
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
            Value<int> startedAt = const Value.absent(),
            Value<int> durationMinutes = const Value.absent(),
            Value<int?> caloriesBurned = const Value.absent(),
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
            required int startedAt,
            required int durationMinutes,
            Value<int?> caloriesBurned = const Value.absent(),
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
  Value<String?> icon,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> completedDates,
  Value<String> syncStatus,
  Value<String?> remoteId,
  Value<int> failedAttempts,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> userId,
  Value<String> name,
  Value<String?> icon,
  Value<int> currentStreak,
  Value<int> longestStreak,
  Value<String?> completedDates,
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

  ColumnFilters<String> get completedDates => $composableBuilder(
      column: $table.completedDates,
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

  ColumnOrderings<String> get completedDates => $composableBuilder(
      column: $table.completedDates,
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

  GeneratedColumn<String> get completedDates => $composableBuilder(
      column: $table.completedDates, builder: (column) => column);

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
            Value<String?> icon = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> completedDates = const Value.absent(),
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
            completedDates: completedDates,
            syncStatus: syncStatus,
            remoteId: remoteId,
            failedAttempts: failedAttempts,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String name,
            Value<String?> icon = const Value.absent(),
            Value<int> currentStreak = const Value.absent(),
            Value<int> longestStreak = const Value.absent(),
            Value<String?> completedDates = const Value.absent(),
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
            completedDates: completedDates,
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
  Value<String?> body,
  Value<String?> moodEmoji,
  Value<int?> moodScore,
  Value<String?> tags,
  required int createdAt,
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
  Value<String?> body,
  Value<String?> moodEmoji,
  Value<int?> moodScore,
  Value<String?> tags,
  Value<int> createdAt,
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

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
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

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
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

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
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
            Value<String?> body = const Value.absent(),
            Value<String?> moodEmoji = const Value.absent(),
            Value<int?> moodScore = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
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
            tags: tags,
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
            Value<String?> body = const Value.absent(),
            Value<String?> moodEmoji = const Value.absent(),
            Value<int?> moodScore = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            required int createdAt,
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
            tags: tags,
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
  required int firstEventTs,
  required int lastEventTs,
  required String eventsJson,
  required int prepWeeks,
  required String primaryGoal,
  required String currentPhase,
  Value<String> syncStatus,
  Value<int> rowid,
});
typedef $$WeddingPlansTableUpdateCompanionBuilder = WeddingPlansCompanion
    Function({
  Value<String> id,
  Value<String> userId,
  Value<String> role,
  Value<String?> relation,
  Value<int> firstEventTs,
  Value<int> lastEventTs,
  Value<String> eventsJson,
  Value<int> prepWeeks,
  Value<String> primaryGoal,
  Value<String> currentPhase,
  Value<String> syncStatus,
  Value<int> rowid,
});

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

  ColumnFilters<int> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastEventTs => $composableBuilder(
      column: $table.lastEventTs, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventsJson => $composableBuilder(
      column: $table.eventsJson, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get prepWeeks => $composableBuilder(
      column: $table.prepWeeks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<int> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastEventTs => $composableBuilder(
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

  GeneratedColumn<int> get firstEventTs => $composableBuilder(
      column: $table.firstEventTs, builder: (column) => column);

  GeneratedColumn<int> get lastEventTs => $composableBuilder(
      column: $table.lastEventTs, builder: (column) => column);

  GeneratedColumn<String> get eventsJson => $composableBuilder(
      column: $table.eventsJson, builder: (column) => column);

  GeneratedColumn<int> get prepWeeks =>
      $composableBuilder(column: $table.prepWeeks, builder: (column) => column);

  GeneratedColumn<String> get primaryGoal => $composableBuilder(
      column: $table.primaryGoal, builder: (column) => column);

  GeneratedColumn<String> get currentPhase => $composableBuilder(
      column: $table.currentPhase, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
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
    (
      WeddingPlan,
      BaseReferences<_$AppDatabase, $WeddingPlansTable, WeddingPlan>
    ),
    WeddingPlan,
    PrefetchHooks Function()> {
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
            Value<int> firstEventTs = const Value.absent(),
            Value<int> lastEventTs = const Value.absent(),
            Value<String> eventsJson = const Value.absent(),
            Value<int> prepWeeks = const Value.absent(),
            Value<String> primaryGoal = const Value.absent(),
            Value<String> currentPhase = const Value.absent(),
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
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String userId,
            required String role,
            Value<String?> relation = const Value.absent(),
            required int firstEventTs,
            required int lastEventTs,
            required String eventsJson,
            required int prepWeeks,
            required String primaryGoal,
            required String currentPhase,
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
            syncStatus: syncStatus,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      WeddingPlan,
      BaseReferences<_$AppDatabase, $WeddingPlansTable, WeddingPlan>
    ),
    WeddingPlan,
    PrefetchHooks Function()>;
typedef $$WeddingMealLogsTableCreateCompanionBuilder = WeddingMealLogsCompanion
    Function({
  required String id,
  required String userId,
  required String planId,
  required String eventTag,
  required String timing,
  required int loggedAt,
  required double calories,
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
  Value<int> loggedAt,
  Value<double> calories,
  Value<String?> notes,
  Value<String> syncStatus,
  Value<int> rowid,
});

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

  ColumnFilters<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get eventTag => $composableBuilder(
      column: $table.eventTag, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timing => $composableBuilder(
      column: $table.timing, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get planId => $composableBuilder(
      column: $table.planId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get eventTag => $composableBuilder(
      column: $table.eventTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timing => $composableBuilder(
      column: $table.timing, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get loggedAt => $composableBuilder(
      column: $table.loggedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get planId =>
      $composableBuilder(column: $table.planId, builder: (column) => column);

  GeneratedColumn<String> get eventTag =>
      $composableBuilder(column: $table.eventTag, builder: (column) => column);

  GeneratedColumn<String> get timing =>
      $composableBuilder(column: $table.timing, builder: (column) => column);

  GeneratedColumn<int> get loggedAt =>
      $composableBuilder(column: $table.loggedAt, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => column);
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
    (
      WeddingMealLog,
      BaseReferences<_$AppDatabase, $WeddingMealLogsTable, WeddingMealLog>
    ),
    WeddingMealLog,
    PrefetchHooks Function()> {
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
            Value<int> loggedAt = const Value.absent(),
            Value<double> calories = const Value.absent(),
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
            required int loggedAt,
            required double calories,
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
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
    (
      WeddingMealLog,
      BaseReferences<_$AppDatabase, $WeddingMealLogsTable, WeddingMealLog>
    ),
    WeddingMealLog,
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
}
