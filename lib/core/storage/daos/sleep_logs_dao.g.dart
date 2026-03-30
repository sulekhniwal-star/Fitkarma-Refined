// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_logs_dao.dart';

// ignore_for_file: type=lint
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

abstract class _$SleepLogsDao extends GeneratedDatabase {
  _$SleepLogsDao(QueryExecutor e) : super(e);
  $SleepLogsDaoManager get managers => $SleepLogsDaoManager(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [sleepLogs];
}

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
    extends Composer<_$SleepLogsDao, $SleepLogsTable> {
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
    extends Composer<_$SleepLogsDao, $SleepLogsTable> {
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
    extends Composer<_$SleepLogsDao, $SleepLogsTable> {
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
          _$SleepLogsDao,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$SleepLogsDao, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$SleepLogsDao db, $SleepLogsTable table)
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
      _$SleepLogsDao,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$SleepLogsDao, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;

class $SleepLogsDaoManager {
  final _$SleepLogsDao _db;
  $SleepLogsDaoManager(this._db);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
}
