// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lab_reports_dao.dart';

// ignore_for_file: type=lint
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

abstract class _$LabReportsDao extends GeneratedDatabase {
  _$LabReportsDao(QueryExecutor e) : super(e);
  $LabReportsDaoManager get managers => $LabReportsDaoManager(this);
  late final $LabReportsTable labReports = $LabReportsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [labReports];
}

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
    extends Composer<_$LabReportsDao, $LabReportsTable> {
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
    extends Composer<_$LabReportsDao, $LabReportsTable> {
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
    extends Composer<_$LabReportsDao, $LabReportsTable> {
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
          _$LabReportsDao,
          $LabReportsTable,
          LabReport,
          $$LabReportsTableFilterComposer,
          $$LabReportsTableOrderingComposer,
          $$LabReportsTableAnnotationComposer,
          $$LabReportsTableCreateCompanionBuilder,
          $$LabReportsTableUpdateCompanionBuilder,
          (
            LabReport,
            BaseReferences<_$LabReportsDao, $LabReportsTable, LabReport>,
          ),
          LabReport,
          PrefetchHooks Function()
        > {
  $$LabReportsTableTableManager(_$LabReportsDao db, $LabReportsTable table)
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
      _$LabReportsDao,
      $LabReportsTable,
      LabReport,
      $$LabReportsTableFilterComposer,
      $$LabReportsTableOrderingComposer,
      $$LabReportsTableAnnotationComposer,
      $$LabReportsTableCreateCompanionBuilder,
      $$LabReportsTableUpdateCompanionBuilder,
      (LabReport, BaseReferences<_$LabReportsDao, $LabReportsTable, LabReport>),
      LabReport,
      PrefetchHooks Function()
    >;

class $LabReportsDaoManager {
  final _$LabReportsDao _db;
  $LabReportsDaoManager(this._db);
  $$LabReportsTableTableManager get labReports =>
      $$LabReportsTableTableManager(_db, _db.labReports);
}
