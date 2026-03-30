// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor_appointments_dao.dart';

// ignore_for_file: type=lint
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

abstract class _$DoctorAppointmentsDao extends GeneratedDatabase {
  _$DoctorAppointmentsDao(QueryExecutor e) : super(e);
  $DoctorAppointmentsDaoManager get managers =>
      $DoctorAppointmentsDaoManager(this);
  late final $DoctorAppointmentsTable doctorAppointments =
      $DoctorAppointmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [doctorAppointments];
}

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
    extends Composer<_$DoctorAppointmentsDao, $DoctorAppointmentsTable> {
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
    extends Composer<_$DoctorAppointmentsDao, $DoctorAppointmentsTable> {
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
    extends Composer<_$DoctorAppointmentsDao, $DoctorAppointmentsTable> {
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
          _$DoctorAppointmentsDao,
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
              _$DoctorAppointmentsDao,
              $DoctorAppointmentsTable,
              DoctorAppointment
            >,
          ),
          DoctorAppointment,
          PrefetchHooks Function()
        > {
  $$DoctorAppointmentsTableTableManager(
    _$DoctorAppointmentsDao db,
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
      _$DoctorAppointmentsDao,
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
          _$DoctorAppointmentsDao,
          $DoctorAppointmentsTable,
          DoctorAppointment
        >,
      ),
      DoctorAppointment,
      PrefetchHooks Function()
    >;

class $DoctorAppointmentsDaoManager {
  final _$DoctorAppointmentsDao _db;
  $DoctorAppointmentsDaoManager(this._db);
  $$DoctorAppointmentsTableTableManager get doctorAppointments =>
      $$DoctorAppointmentsTableTableManager(_db, _db.doctorAppointments);
}
