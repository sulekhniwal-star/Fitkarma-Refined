// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emergency_card_dao.dart';

// ignore_for_file: type=lint
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

abstract class _$EmergencyCardDao extends GeneratedDatabase {
  _$EmergencyCardDao(QueryExecutor e) : super(e);
  $EmergencyCardDaoManager get managers => $EmergencyCardDaoManager(this);
  late final $EmergencyCardTable emergencyCard = $EmergencyCardTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [emergencyCard];
}

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
    extends Composer<_$EmergencyCardDao, $EmergencyCardTable> {
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
    extends Composer<_$EmergencyCardDao, $EmergencyCardTable> {
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
    extends Composer<_$EmergencyCardDao, $EmergencyCardTable> {
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
          _$EmergencyCardDao,
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
              _$EmergencyCardDao,
              $EmergencyCardTable,
              EmergencyCardData
            >,
          ),
          EmergencyCardData,
          PrefetchHooks Function()
        > {
  $$EmergencyCardTableTableManager(
    _$EmergencyCardDao db,
    $EmergencyCardTable table,
  ) : super(
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
      _$EmergencyCardDao,
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
          _$EmergencyCardDao,
          $EmergencyCardTable,
          EmergencyCardData
        >,
      ),
      EmergencyCardData,
      PrefetchHooks Function()
    >;

class $EmergencyCardDaoManager {
  final _$EmergencyCardDao _db;
  $EmergencyCardDaoManager(this._db);
  $$EmergencyCardTableTableManager get emergencyCard =>
      $$EmergencyCardTableTableManager(_db, _db.emergencyCard);
}
