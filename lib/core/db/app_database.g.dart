// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmployeesTable extends Employees
    with TableInfo<$EmployeesTable, Employee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmployeesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _matriculeMeta = const VerificationMeta(
    'matricule',
  );
  @override
  late final GeneratedColumn<String> matricule = GeneratedColumn<String>(
    'matricule',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _departmentMeta = const VerificationMeta(
    'department',
  );
  @override
  late final GeneratedColumn<String> department = GeneratedColumn<String>(
    'department',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _hireDateMeta = const VerificationMeta(
    'hireDate',
  );
  @override
  late final GeneratedColumn<DateTime> hireDate = GeneratedColumn<DateTime>(
    'hire_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _badgeVersionMeta = const VerificationMeta(
    'badgeVersion',
  );
  @override
  late final GeneratedColumn<int> badgeVersion = GeneratedColumn<int>(
    'badge_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _useCustomScheduleMeta = const VerificationMeta(
    'useCustomSchedule',
  );
  @override
  late final GeneratedColumn<bool> useCustomSchedule = GeneratedColumn<bool>(
    'use_custom_schedule',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("use_custom_schedule" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _workDaysMeta = const VerificationMeta(
    'workDays',
  );
  @override
  late final GeneratedColumn<String> workDays = GeneratedColumn<String>(
    'work_days',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1,2,3,4,5'),
  );
  static const VerificationMeta _startMinutesMeta = const VerificationMeta(
    'startMinutes',
  );
  @override
  late final GeneratedColumn<int> startMinutes = GeneratedColumn<int>(
    'start_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(480),
  );
  static const VerificationMeta _endMinutesMeta = const VerificationMeta(
    'endMinutes',
  );
  @override
  late final GeneratedColumn<int> endMinutes = GeneratedColumn<int>(
    'end_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1020),
  );
  static const VerificationMeta _breakMinutesMeta = const VerificationMeta(
    'breakMinutes',
  );
  @override
  late final GeneratedColumn<int> breakMinutes = GeneratedColumn<int>(
    'break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _lateToleranceMinutesMeta =
      const VerificationMeta('lateToleranceMinutes');
  @override
  late final GeneratedColumn<int> lateToleranceMinutes = GeneratedColumn<int>(
    'late_tolerance_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _earlyLeaveToleranceMinutesMeta =
      const VerificationMeta('earlyLeaveToleranceMinutes');
  @override
  late final GeneratedColumn<int> earlyLeaveToleranceMinutes =
      GeneratedColumn<int>(
        'early_leave_tolerance_minutes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _overtimeThresholdMinutesMeta =
      const VerificationMeta('overtimeThresholdMinutes');
  @override
  late final GeneratedColumn<int> overtimeThresholdMinutes =
      GeneratedColumn<int>(
        'overtime_threshold_minutes',
        aliasedName,
        true,
        type: DriftSqlType.int,
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
    uuid,
    matricule,
    firstName,
    lastName,
    position,
    department,
    phone,
    hireDate,
    photoPath,
    isArchived,
    badgeVersion,
    useCustomSchedule,
    workDays,
    startMinutes,
    endMinutes,
    breakMinutes,
    lateToleranceMinutes,
    earlyLeaveToleranceMinutes,
    overtimeThresholdMinutes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Employee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('matricule')) {
      context.handle(
        _matriculeMeta,
        matricule.isAcceptableOrUnknown(data['matricule']!, _matriculeMeta),
      );
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('department')) {
      context.handle(
        _departmentMeta,
        department.isAcceptableOrUnknown(data['department']!, _departmentMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('hire_date')) {
      context.handle(
        _hireDateMeta,
        hireDate.isAcceptableOrUnknown(data['hire_date']!, _hireDateMeta),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('badge_version')) {
      context.handle(
        _badgeVersionMeta,
        badgeVersion.isAcceptableOrUnknown(
          data['badge_version']!,
          _badgeVersionMeta,
        ),
      );
    }
    if (data.containsKey('use_custom_schedule')) {
      context.handle(
        _useCustomScheduleMeta,
        useCustomSchedule.isAcceptableOrUnknown(
          data['use_custom_schedule']!,
          _useCustomScheduleMeta,
        ),
      );
    }
    if (data.containsKey('work_days')) {
      context.handle(
        _workDaysMeta,
        workDays.isAcceptableOrUnknown(data['work_days']!, _workDaysMeta),
      );
    }
    if (data.containsKey('start_minutes')) {
      context.handle(
        _startMinutesMeta,
        startMinutes.isAcceptableOrUnknown(
          data['start_minutes']!,
          _startMinutesMeta,
        ),
      );
    }
    if (data.containsKey('end_minutes')) {
      context.handle(
        _endMinutesMeta,
        endMinutes.isAcceptableOrUnknown(data['end_minutes']!, _endMinutesMeta),
      );
    }
    if (data.containsKey('break_minutes')) {
      context.handle(
        _breakMinutesMeta,
        breakMinutes.isAcceptableOrUnknown(
          data['break_minutes']!,
          _breakMinutesMeta,
        ),
      );
    }
    if (data.containsKey('late_tolerance_minutes')) {
      context.handle(
        _lateToleranceMinutesMeta,
        lateToleranceMinutes.isAcceptableOrUnknown(
          data['late_tolerance_minutes']!,
          _lateToleranceMinutesMeta,
        ),
      );
    }
    if (data.containsKey('early_leave_tolerance_minutes')) {
      context.handle(
        _earlyLeaveToleranceMinutesMeta,
        earlyLeaveToleranceMinutes.isAcceptableOrUnknown(
          data['early_leave_tolerance_minutes']!,
          _earlyLeaveToleranceMinutesMeta,
        ),
      );
    }
    if (data.containsKey('overtime_threshold_minutes')) {
      context.handle(
        _overtimeThresholdMinutesMeta,
        overtimeThresholdMinutes.isAcceptableOrUnknown(
          data['overtime_threshold_minutes']!,
          _overtimeThresholdMinutesMeta,
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {uuid},
  ];
  @override
  Employee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Employee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      matricule: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}matricule'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      )!,
      department: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}department'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      hireDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hire_date'],
      ),
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      badgeVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}badge_version'],
      )!,
      useCustomSchedule: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}use_custom_schedule'],
      )!,
      workDays: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}work_days'],
      )!,
      startMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minutes'],
      )!,
      endMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minutes'],
      )!,
      breakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}break_minutes'],
      )!,
      lateToleranceMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}late_tolerance_minutes'],
      ),
      earlyLeaveToleranceMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}early_leave_tolerance_minutes'],
      ),
      overtimeThresholdMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}overtime_threshold_minutes'],
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
  $EmployeesTable createAlias(String alias) {
    return $EmployeesTable(attachedDatabase, alias);
  }
}

class Employee extends DataClass implements Insertable<Employee> {
  final int id;
  final String uuid;
  final String matricule;
  final String firstName;
  final String lastName;
  final String position;
  final String department;
  final String phone;
  final DateTime? hireDate;
  final String? photoPath;
  final bool isArchived;
  final int badgeVersion;
  final bool useCustomSchedule;
  final String workDays;
  final int startMinutes;
  final int endMinutes;
  final int breakMinutes;
  final int? lateToleranceMinutes;
  final int? earlyLeaveToleranceMinutes;
  final int? overtimeThresholdMinutes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Employee({
    required this.id,
    required this.uuid,
    required this.matricule,
    required this.firstName,
    required this.lastName,
    required this.position,
    required this.department,
    required this.phone,
    this.hireDate,
    this.photoPath,
    required this.isArchived,
    required this.badgeVersion,
    required this.useCustomSchedule,
    required this.workDays,
    required this.startMinutes,
    required this.endMinutes,
    required this.breakMinutes,
    this.lateToleranceMinutes,
    this.earlyLeaveToleranceMinutes,
    this.overtimeThresholdMinutes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['uuid'] = Variable<String>(uuid);
    map['matricule'] = Variable<String>(matricule);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['position'] = Variable<String>(position);
    map['department'] = Variable<String>(department);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || hireDate != null) {
      map['hire_date'] = Variable<DateTime>(hireDate);
    }
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['badge_version'] = Variable<int>(badgeVersion);
    map['use_custom_schedule'] = Variable<bool>(useCustomSchedule);
    map['work_days'] = Variable<String>(workDays);
    map['start_minutes'] = Variable<int>(startMinutes);
    map['end_minutes'] = Variable<int>(endMinutes);
    map['break_minutes'] = Variable<int>(breakMinutes);
    if (!nullToAbsent || lateToleranceMinutes != null) {
      map['late_tolerance_minutes'] = Variable<int>(lateToleranceMinutes);
    }
    if (!nullToAbsent || earlyLeaveToleranceMinutes != null) {
      map['early_leave_tolerance_minutes'] = Variable<int>(
        earlyLeaveToleranceMinutes,
      );
    }
    if (!nullToAbsent || overtimeThresholdMinutes != null) {
      map['overtime_threshold_minutes'] = Variable<int>(
        overtimeThresholdMinutes,
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EmployeesCompanion toCompanion(bool nullToAbsent) {
    return EmployeesCompanion(
      id: Value(id),
      uuid: Value(uuid),
      matricule: Value(matricule),
      firstName: Value(firstName),
      lastName: Value(lastName),
      position: Value(position),
      department: Value(department),
      phone: Value(phone),
      hireDate: hireDate == null && nullToAbsent
          ? const Value.absent()
          : Value(hireDate),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      isArchived: Value(isArchived),
      badgeVersion: Value(badgeVersion),
      useCustomSchedule: Value(useCustomSchedule),
      workDays: Value(workDays),
      startMinutes: Value(startMinutes),
      endMinutes: Value(endMinutes),
      breakMinutes: Value(breakMinutes),
      lateToleranceMinutes: lateToleranceMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(lateToleranceMinutes),
      earlyLeaveToleranceMinutes:
          earlyLeaveToleranceMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(earlyLeaveToleranceMinutes),
      overtimeThresholdMinutes: overtimeThresholdMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(overtimeThresholdMinutes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Employee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Employee(
      id: serializer.fromJson<int>(json['id']),
      uuid: serializer.fromJson<String>(json['uuid']),
      matricule: serializer.fromJson<String>(json['matricule']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      position: serializer.fromJson<String>(json['position']),
      department: serializer.fromJson<String>(json['department']),
      phone: serializer.fromJson<String>(json['phone']),
      hireDate: serializer.fromJson<DateTime?>(json['hireDate']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      badgeVersion: serializer.fromJson<int>(json['badgeVersion']),
      useCustomSchedule: serializer.fromJson<bool>(json['useCustomSchedule']),
      workDays: serializer.fromJson<String>(json['workDays']),
      startMinutes: serializer.fromJson<int>(json['startMinutes']),
      endMinutes: serializer.fromJson<int>(json['endMinutes']),
      breakMinutes: serializer.fromJson<int>(json['breakMinutes']),
      lateToleranceMinutes: serializer.fromJson<int?>(
        json['lateToleranceMinutes'],
      ),
      earlyLeaveToleranceMinutes: serializer.fromJson<int?>(
        json['earlyLeaveToleranceMinutes'],
      ),
      overtimeThresholdMinutes: serializer.fromJson<int?>(
        json['overtimeThresholdMinutes'],
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
      'uuid': serializer.toJson<String>(uuid),
      'matricule': serializer.toJson<String>(matricule),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'position': serializer.toJson<String>(position),
      'department': serializer.toJson<String>(department),
      'phone': serializer.toJson<String>(phone),
      'hireDate': serializer.toJson<DateTime?>(hireDate),
      'photoPath': serializer.toJson<String?>(photoPath),
      'isArchived': serializer.toJson<bool>(isArchived),
      'badgeVersion': serializer.toJson<int>(badgeVersion),
      'useCustomSchedule': serializer.toJson<bool>(useCustomSchedule),
      'workDays': serializer.toJson<String>(workDays),
      'startMinutes': serializer.toJson<int>(startMinutes),
      'endMinutes': serializer.toJson<int>(endMinutes),
      'breakMinutes': serializer.toJson<int>(breakMinutes),
      'lateToleranceMinutes': serializer.toJson<int?>(lateToleranceMinutes),
      'earlyLeaveToleranceMinutes': serializer.toJson<int?>(
        earlyLeaveToleranceMinutes,
      ),
      'overtimeThresholdMinutes': serializer.toJson<int?>(
        overtimeThresholdMinutes,
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Employee copyWith({
    int? id,
    String? uuid,
    String? matricule,
    String? firstName,
    String? lastName,
    String? position,
    String? department,
    String? phone,
    Value<DateTime?> hireDate = const Value.absent(),
    Value<String?> photoPath = const Value.absent(),
    bool? isArchived,
    int? badgeVersion,
    bool? useCustomSchedule,
    String? workDays,
    int? startMinutes,
    int? endMinutes,
    int? breakMinutes,
    Value<int?> lateToleranceMinutes = const Value.absent(),
    Value<int?> earlyLeaveToleranceMinutes = const Value.absent(),
    Value<int?> overtimeThresholdMinutes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Employee(
    id: id ?? this.id,
    uuid: uuid ?? this.uuid,
    matricule: matricule ?? this.matricule,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    position: position ?? this.position,
    department: department ?? this.department,
    phone: phone ?? this.phone,
    hireDate: hireDate.present ? hireDate.value : this.hireDate,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    isArchived: isArchived ?? this.isArchived,
    badgeVersion: badgeVersion ?? this.badgeVersion,
    useCustomSchedule: useCustomSchedule ?? this.useCustomSchedule,
    workDays: workDays ?? this.workDays,
    startMinutes: startMinutes ?? this.startMinutes,
    endMinutes: endMinutes ?? this.endMinutes,
    breakMinutes: breakMinutes ?? this.breakMinutes,
    lateToleranceMinutes: lateToleranceMinutes.present
        ? lateToleranceMinutes.value
        : this.lateToleranceMinutes,
    earlyLeaveToleranceMinutes: earlyLeaveToleranceMinutes.present
        ? earlyLeaveToleranceMinutes.value
        : this.earlyLeaveToleranceMinutes,
    overtimeThresholdMinutes: overtimeThresholdMinutes.present
        ? overtimeThresholdMinutes.value
        : this.overtimeThresholdMinutes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Employee copyWithCompanion(EmployeesCompanion data) {
    return Employee(
      id: data.id.present ? data.id.value : this.id,
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      matricule: data.matricule.present ? data.matricule.value : this.matricule,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      position: data.position.present ? data.position.value : this.position,
      department: data.department.present
          ? data.department.value
          : this.department,
      phone: data.phone.present ? data.phone.value : this.phone,
      hireDate: data.hireDate.present ? data.hireDate.value : this.hireDate,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      badgeVersion: data.badgeVersion.present
          ? data.badgeVersion.value
          : this.badgeVersion,
      useCustomSchedule: data.useCustomSchedule.present
          ? data.useCustomSchedule.value
          : this.useCustomSchedule,
      workDays: data.workDays.present ? data.workDays.value : this.workDays,
      startMinutes: data.startMinutes.present
          ? data.startMinutes.value
          : this.startMinutes,
      endMinutes: data.endMinutes.present
          ? data.endMinutes.value
          : this.endMinutes,
      breakMinutes: data.breakMinutes.present
          ? data.breakMinutes.value
          : this.breakMinutes,
      lateToleranceMinutes: data.lateToleranceMinutes.present
          ? data.lateToleranceMinutes.value
          : this.lateToleranceMinutes,
      earlyLeaveToleranceMinutes: data.earlyLeaveToleranceMinutes.present
          ? data.earlyLeaveToleranceMinutes.value
          : this.earlyLeaveToleranceMinutes,
      overtimeThresholdMinutes: data.overtimeThresholdMinutes.present
          ? data.overtimeThresholdMinutes.value
          : this.overtimeThresholdMinutes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Employee(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('matricule: $matricule, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('position: $position, ')
          ..write('department: $department, ')
          ..write('phone: $phone, ')
          ..write('hireDate: $hireDate, ')
          ..write('photoPath: $photoPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('badgeVersion: $badgeVersion, ')
          ..write('useCustomSchedule: $useCustomSchedule, ')
          ..write('workDays: $workDays, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('lateToleranceMinutes: $lateToleranceMinutes, ')
          ..write('earlyLeaveToleranceMinutes: $earlyLeaveToleranceMinutes, ')
          ..write('overtimeThresholdMinutes: $overtimeThresholdMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    uuid,
    matricule,
    firstName,
    lastName,
    position,
    department,
    phone,
    hireDate,
    photoPath,
    isArchived,
    badgeVersion,
    useCustomSchedule,
    workDays,
    startMinutes,
    endMinutes,
    breakMinutes,
    lateToleranceMinutes,
    earlyLeaveToleranceMinutes,
    overtimeThresholdMinutes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Employee &&
          other.id == this.id &&
          other.uuid == this.uuid &&
          other.matricule == this.matricule &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.position == this.position &&
          other.department == this.department &&
          other.phone == this.phone &&
          other.hireDate == this.hireDate &&
          other.photoPath == this.photoPath &&
          other.isArchived == this.isArchived &&
          other.badgeVersion == this.badgeVersion &&
          other.useCustomSchedule == this.useCustomSchedule &&
          other.workDays == this.workDays &&
          other.startMinutes == this.startMinutes &&
          other.endMinutes == this.endMinutes &&
          other.breakMinutes == this.breakMinutes &&
          other.lateToleranceMinutes == this.lateToleranceMinutes &&
          other.earlyLeaveToleranceMinutes == this.earlyLeaveToleranceMinutes &&
          other.overtimeThresholdMinutes == this.overtimeThresholdMinutes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EmployeesCompanion extends UpdateCompanion<Employee> {
  final Value<int> id;
  final Value<String> uuid;
  final Value<String> matricule;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> position;
  final Value<String> department;
  final Value<String> phone;
  final Value<DateTime?> hireDate;
  final Value<String?> photoPath;
  final Value<bool> isArchived;
  final Value<int> badgeVersion;
  final Value<bool> useCustomSchedule;
  final Value<String> workDays;
  final Value<int> startMinutes;
  final Value<int> endMinutes;
  final Value<int> breakMinutes;
  final Value<int?> lateToleranceMinutes;
  final Value<int?> earlyLeaveToleranceMinutes;
  final Value<int?> overtimeThresholdMinutes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const EmployeesCompanion({
    this.id = const Value.absent(),
    this.uuid = const Value.absent(),
    this.matricule = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.position = const Value.absent(),
    this.department = const Value.absent(),
    this.phone = const Value.absent(),
    this.hireDate = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.badgeVersion = const Value.absent(),
    this.useCustomSchedule = const Value.absent(),
    this.workDays = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    this.breakMinutes = const Value.absent(),
    this.lateToleranceMinutes = const Value.absent(),
    this.earlyLeaveToleranceMinutes = const Value.absent(),
    this.overtimeThresholdMinutes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  EmployeesCompanion.insert({
    this.id = const Value.absent(),
    required String uuid,
    this.matricule = const Value.absent(),
    required String firstName,
    required String lastName,
    this.position = const Value.absent(),
    this.department = const Value.absent(),
    this.phone = const Value.absent(),
    this.hireDate = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.badgeVersion = const Value.absent(),
    this.useCustomSchedule = const Value.absent(),
    this.workDays = const Value.absent(),
    this.startMinutes = const Value.absent(),
    this.endMinutes = const Value.absent(),
    this.breakMinutes = const Value.absent(),
    this.lateToleranceMinutes = const Value.absent(),
    this.earlyLeaveToleranceMinutes = const Value.absent(),
    this.overtimeThresholdMinutes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : uuid = Value(uuid),
       firstName = Value(firstName),
       lastName = Value(lastName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Employee> custom({
    Expression<int>? id,
    Expression<String>? uuid,
    Expression<String>? matricule,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? position,
    Expression<String>? department,
    Expression<String>? phone,
    Expression<DateTime>? hireDate,
    Expression<String>? photoPath,
    Expression<bool>? isArchived,
    Expression<int>? badgeVersion,
    Expression<bool>? useCustomSchedule,
    Expression<String>? workDays,
    Expression<int>? startMinutes,
    Expression<int>? endMinutes,
    Expression<int>? breakMinutes,
    Expression<int>? lateToleranceMinutes,
    Expression<int>? earlyLeaveToleranceMinutes,
    Expression<int>? overtimeThresholdMinutes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uuid != null) 'uuid': uuid,
      if (matricule != null) 'matricule': matricule,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (position != null) 'position': position,
      if (department != null) 'department': department,
      if (phone != null) 'phone': phone,
      if (hireDate != null) 'hire_date': hireDate,
      if (photoPath != null) 'photo_path': photoPath,
      if (isArchived != null) 'is_archived': isArchived,
      if (badgeVersion != null) 'badge_version': badgeVersion,
      if (useCustomSchedule != null) 'use_custom_schedule': useCustomSchedule,
      if (workDays != null) 'work_days': workDays,
      if (startMinutes != null) 'start_minutes': startMinutes,
      if (endMinutes != null) 'end_minutes': endMinutes,
      if (breakMinutes != null) 'break_minutes': breakMinutes,
      if (lateToleranceMinutes != null)
        'late_tolerance_minutes': lateToleranceMinutes,
      if (earlyLeaveToleranceMinutes != null)
        'early_leave_tolerance_minutes': earlyLeaveToleranceMinutes,
      if (overtimeThresholdMinutes != null)
        'overtime_threshold_minutes': overtimeThresholdMinutes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  EmployeesCompanion copyWith({
    Value<int>? id,
    Value<String>? uuid,
    Value<String>? matricule,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<String>? position,
    Value<String>? department,
    Value<String>? phone,
    Value<DateTime?>? hireDate,
    Value<String?>? photoPath,
    Value<bool>? isArchived,
    Value<int>? badgeVersion,
    Value<bool>? useCustomSchedule,
    Value<String>? workDays,
    Value<int>? startMinutes,
    Value<int>? endMinutes,
    Value<int>? breakMinutes,
    Value<int?>? lateToleranceMinutes,
    Value<int?>? earlyLeaveToleranceMinutes,
    Value<int?>? overtimeThresholdMinutes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return EmployeesCompanion(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      matricule: matricule ?? this.matricule,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      position: position ?? this.position,
      department: department ?? this.department,
      phone: phone ?? this.phone,
      hireDate: hireDate ?? this.hireDate,
      photoPath: photoPath ?? this.photoPath,
      isArchived: isArchived ?? this.isArchived,
      badgeVersion: badgeVersion ?? this.badgeVersion,
      useCustomSchedule: useCustomSchedule ?? this.useCustomSchedule,
      workDays: workDays ?? this.workDays,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      lateToleranceMinutes: lateToleranceMinutes ?? this.lateToleranceMinutes,
      earlyLeaveToleranceMinutes:
          earlyLeaveToleranceMinutes ?? this.earlyLeaveToleranceMinutes,
      overtimeThresholdMinutes:
          overtimeThresholdMinutes ?? this.overtimeThresholdMinutes,
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
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (matricule.present) {
      map['matricule'] = Variable<String>(matricule.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (department.present) {
      map['department'] = Variable<String>(department.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (hireDate.present) {
      map['hire_date'] = Variable<DateTime>(hireDate.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (badgeVersion.present) {
      map['badge_version'] = Variable<int>(badgeVersion.value);
    }
    if (useCustomSchedule.present) {
      map['use_custom_schedule'] = Variable<bool>(useCustomSchedule.value);
    }
    if (workDays.present) {
      map['work_days'] = Variable<String>(workDays.value);
    }
    if (startMinutes.present) {
      map['start_minutes'] = Variable<int>(startMinutes.value);
    }
    if (endMinutes.present) {
      map['end_minutes'] = Variable<int>(endMinutes.value);
    }
    if (breakMinutes.present) {
      map['break_minutes'] = Variable<int>(breakMinutes.value);
    }
    if (lateToleranceMinutes.present) {
      map['late_tolerance_minutes'] = Variable<int>(lateToleranceMinutes.value);
    }
    if (earlyLeaveToleranceMinutes.present) {
      map['early_leave_tolerance_minutes'] = Variable<int>(
        earlyLeaveToleranceMinutes.value,
      );
    }
    if (overtimeThresholdMinutes.present) {
      map['overtime_threshold_minutes'] = Variable<int>(
        overtimeThresholdMinutes.value,
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
    return (StringBuffer('EmployeesCompanion(')
          ..write('id: $id, ')
          ..write('uuid: $uuid, ')
          ..write('matricule: $matricule, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('position: $position, ')
          ..write('department: $department, ')
          ..write('phone: $phone, ')
          ..write('hireDate: $hireDate, ')
          ..write('photoPath: $photoPath, ')
          ..write('isArchived: $isArchived, ')
          ..write('badgeVersion: $badgeVersion, ')
          ..write('useCustomSchedule: $useCustomSchedule, ')
          ..write('workDays: $workDays, ')
          ..write('startMinutes: $startMinutes, ')
          ..write('endMinutes: $endMinutes, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('lateToleranceMinutes: $lateToleranceMinutes, ')
          ..write('earlyLeaveToleranceMinutes: $earlyLeaveToleranceMinutes, ')
          ..write('overtimeThresholdMinutes: $overtimeThresholdMinutes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AttendanceRecordsTable extends AttendanceRecords
    with TableInfo<$AttendanceRecordsTable, AttendanceRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttendanceRecordsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _checkInUtcMeta = const VerificationMeta(
    'checkInUtc',
  );
  @override
  late final GeneratedColumn<DateTime> checkInUtc = GeneratedColumn<DateTime>(
    'check_in_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _checkOutUtcMeta = const VerificationMeta(
    'checkOutUtc',
  );
  @override
  late final GeneratedColumn<DateTime> checkOutUtc = GeneratedColumn<DateTime>(
    'check_out_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<DateTime> localDate = GeneratedColumn<DateTime>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInTzOffsetMinutesMeta =
      const VerificationMeta('checkInTzOffsetMinutes');
  @override
  late final GeneratedColumn<int> checkInTzOffsetMinutes = GeneratedColumn<int>(
    'check_in_tz_offset_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _checkOutTzOffsetMinutesMeta =
      const VerificationMeta('checkOutTzOffsetMinutes');
  @override
  late final GeneratedColumn<int> checkOutTzOffsetMinutes =
      GeneratedColumn<int>(
        'check_out_tz_offset_minutes',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastScanUtcMeta = const VerificationMeta(
    'lastScanUtc',
  );
  @override
  late final GeneratedColumn<DateTime> lastScanUtc = GeneratedColumn<DateTime>(
    'last_scan_utc',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _overrideStatusMeta = const VerificationMeta(
    'overrideStatus',
  );
  @override
  late final GeneratedColumn<String> overrideStatus = GeneratedColumn<String>(
    'override_status',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _isManualMeta = const VerificationMeta(
    'isManual',
  );
  @override
  late final GeneratedColumn<bool> isManual = GeneratedColumn<bool>(
    'is_manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_manual" IN (0, 1))',
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
    employeeId,
    checkInUtc,
    checkOutUtc,
    localDate,
    checkInTzOffsetMinutes,
    checkOutTzOffsetMinutes,
    lastScanUtc,
    overrideStatus,
    note,
    isManual,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attendance_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttendanceRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_employeeIdMeta);
    }
    if (data.containsKey('check_in_utc')) {
      context.handle(
        _checkInUtcMeta,
        checkInUtc.isAcceptableOrUnknown(
          data['check_in_utc']!,
          _checkInUtcMeta,
        ),
      );
    }
    if (data.containsKey('check_out_utc')) {
      context.handle(
        _checkOutUtcMeta,
        checkOutUtc.isAcceptableOrUnknown(
          data['check_out_utc']!,
          _checkOutUtcMeta,
        ),
      );
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    if (data.containsKey('check_in_tz_offset_minutes')) {
      context.handle(
        _checkInTzOffsetMinutesMeta,
        checkInTzOffsetMinutes.isAcceptableOrUnknown(
          data['check_in_tz_offset_minutes']!,
          _checkInTzOffsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('check_out_tz_offset_minutes')) {
      context.handle(
        _checkOutTzOffsetMinutesMeta,
        checkOutTzOffsetMinutes.isAcceptableOrUnknown(
          data['check_out_tz_offset_minutes']!,
          _checkOutTzOffsetMinutesMeta,
        ),
      );
    }
    if (data.containsKey('last_scan_utc')) {
      context.handle(
        _lastScanUtcMeta,
        lastScanUtc.isAcceptableOrUnknown(
          data['last_scan_utc']!,
          _lastScanUtcMeta,
        ),
      );
    }
    if (data.containsKey('override_status')) {
      context.handle(
        _overrideStatusMeta,
        overrideStatus.isAcceptableOrUnknown(
          data['override_status']!,
          _overrideStatusMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('is_manual')) {
      context.handle(
        _isManualMeta,
        isManual.isAcceptableOrUnknown(data['is_manual']!, _isManualMeta),
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
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {employeeId, localDate},
  ];
  @override
  AttendanceRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttendanceRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      )!,
      checkInUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in_utc'],
      ),
      checkOutUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out_utc'],
      ),
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_date'],
      )!,
      checkInTzOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_in_tz_offset_minutes'],
      )!,
      checkOutTzOffsetMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}check_out_tz_offset_minutes'],
      ),
      lastScanUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_scan_utc'],
      ),
      overrideStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}override_status'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      isManual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_manual'],
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
  $AttendanceRecordsTable createAlias(String alias) {
    return $AttendanceRecordsTable(attachedDatabase, alias);
  }
}

class AttendanceRecord extends DataClass
    implements Insertable<AttendanceRecord> {
  final int id;
  final int employeeId;
  final DateTime? checkInUtc;
  final DateTime? checkOutUtc;
  final DateTime localDate;
  final int checkInTzOffsetMinutes;
  final int? checkOutTzOffsetMinutes;
  final DateTime? lastScanUtc;
  final String? overrideStatus;
  final String note;
  final bool isManual;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AttendanceRecord({
    required this.id,
    required this.employeeId,
    this.checkInUtc,
    this.checkOutUtc,
    required this.localDate,
    required this.checkInTzOffsetMinutes,
    this.checkOutTzOffsetMinutes,
    this.lastScanUtc,
    this.overrideStatus,
    required this.note,
    required this.isManual,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['employee_id'] = Variable<int>(employeeId);
    if (!nullToAbsent || checkInUtc != null) {
      map['check_in_utc'] = Variable<DateTime>(checkInUtc);
    }
    if (!nullToAbsent || checkOutUtc != null) {
      map['check_out_utc'] = Variable<DateTime>(checkOutUtc);
    }
    map['local_date'] = Variable<DateTime>(localDate);
    map['check_in_tz_offset_minutes'] = Variable<int>(checkInTzOffsetMinutes);
    if (!nullToAbsent || checkOutTzOffsetMinutes != null) {
      map['check_out_tz_offset_minutes'] = Variable<int>(
        checkOutTzOffsetMinutes,
      );
    }
    if (!nullToAbsent || lastScanUtc != null) {
      map['last_scan_utc'] = Variable<DateTime>(lastScanUtc);
    }
    if (!nullToAbsent || overrideStatus != null) {
      map['override_status'] = Variable<String>(overrideStatus);
    }
    map['note'] = Variable<String>(note);
    map['is_manual'] = Variable<bool>(isManual);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AttendanceRecordsCompanion toCompanion(bool nullToAbsent) {
    return AttendanceRecordsCompanion(
      id: Value(id),
      employeeId: Value(employeeId),
      checkInUtc: checkInUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(checkInUtc),
      checkOutUtc: checkOutUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutUtc),
      localDate: Value(localDate),
      checkInTzOffsetMinutes: Value(checkInTzOffsetMinutes),
      checkOutTzOffsetMinutes: checkOutTzOffsetMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(checkOutTzOffsetMinutes),
      lastScanUtc: lastScanUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(lastScanUtc),
      overrideStatus: overrideStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(overrideStatus),
      note: Value(note),
      isManual: Value(isManual),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AttendanceRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttendanceRecord(
      id: serializer.fromJson<int>(json['id']),
      employeeId: serializer.fromJson<int>(json['employeeId']),
      checkInUtc: serializer.fromJson<DateTime?>(json['checkInUtc']),
      checkOutUtc: serializer.fromJson<DateTime?>(json['checkOutUtc']),
      localDate: serializer.fromJson<DateTime>(json['localDate']),
      checkInTzOffsetMinutes: serializer.fromJson<int>(
        json['checkInTzOffsetMinutes'],
      ),
      checkOutTzOffsetMinutes: serializer.fromJson<int?>(
        json['checkOutTzOffsetMinutes'],
      ),
      lastScanUtc: serializer.fromJson<DateTime?>(json['lastScanUtc']),
      overrideStatus: serializer.fromJson<String?>(json['overrideStatus']),
      note: serializer.fromJson<String>(json['note']),
      isManual: serializer.fromJson<bool>(json['isManual']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeId': serializer.toJson<int>(employeeId),
      'checkInUtc': serializer.toJson<DateTime?>(checkInUtc),
      'checkOutUtc': serializer.toJson<DateTime?>(checkOutUtc),
      'localDate': serializer.toJson<DateTime>(localDate),
      'checkInTzOffsetMinutes': serializer.toJson<int>(checkInTzOffsetMinutes),
      'checkOutTzOffsetMinutes': serializer.toJson<int?>(
        checkOutTzOffsetMinutes,
      ),
      'lastScanUtc': serializer.toJson<DateTime?>(lastScanUtc),
      'overrideStatus': serializer.toJson<String?>(overrideStatus),
      'note': serializer.toJson<String>(note),
      'isManual': serializer.toJson<bool>(isManual),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AttendanceRecord copyWith({
    int? id,
    int? employeeId,
    Value<DateTime?> checkInUtc = const Value.absent(),
    Value<DateTime?> checkOutUtc = const Value.absent(),
    DateTime? localDate,
    int? checkInTzOffsetMinutes,
    Value<int?> checkOutTzOffsetMinutes = const Value.absent(),
    Value<DateTime?> lastScanUtc = const Value.absent(),
    Value<String?> overrideStatus = const Value.absent(),
    String? note,
    bool? isManual,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AttendanceRecord(
    id: id ?? this.id,
    employeeId: employeeId ?? this.employeeId,
    checkInUtc: checkInUtc.present ? checkInUtc.value : this.checkInUtc,
    checkOutUtc: checkOutUtc.present ? checkOutUtc.value : this.checkOutUtc,
    localDate: localDate ?? this.localDate,
    checkInTzOffsetMinutes:
        checkInTzOffsetMinutes ?? this.checkInTzOffsetMinutes,
    checkOutTzOffsetMinutes: checkOutTzOffsetMinutes.present
        ? checkOutTzOffsetMinutes.value
        : this.checkOutTzOffsetMinutes,
    lastScanUtc: lastScanUtc.present ? lastScanUtc.value : this.lastScanUtc,
    overrideStatus: overrideStatus.present
        ? overrideStatus.value
        : this.overrideStatus,
    note: note ?? this.note,
    isManual: isManual ?? this.isManual,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AttendanceRecord copyWithCompanion(AttendanceRecordsCompanion data) {
    return AttendanceRecord(
      id: data.id.present ? data.id.value : this.id,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      checkInUtc: data.checkInUtc.present
          ? data.checkInUtc.value
          : this.checkInUtc,
      checkOutUtc: data.checkOutUtc.present
          ? data.checkOutUtc.value
          : this.checkOutUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
      checkInTzOffsetMinutes: data.checkInTzOffsetMinutes.present
          ? data.checkInTzOffsetMinutes.value
          : this.checkInTzOffsetMinutes,
      checkOutTzOffsetMinutes: data.checkOutTzOffsetMinutes.present
          ? data.checkOutTzOffsetMinutes.value
          : this.checkOutTzOffsetMinutes,
      lastScanUtc: data.lastScanUtc.present
          ? data.lastScanUtc.value
          : this.lastScanUtc,
      overrideStatus: data.overrideStatus.present
          ? data.overrideStatus.value
          : this.overrideStatus,
      note: data.note.present ? data.note.value : this.note,
      isManual: data.isManual.present ? data.isManual.value : this.isManual,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttendanceRecord(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('checkInUtc: $checkInUtc, ')
          ..write('checkOutUtc: $checkOutUtc, ')
          ..write('localDate: $localDate, ')
          ..write('checkInTzOffsetMinutes: $checkInTzOffsetMinutes, ')
          ..write('checkOutTzOffsetMinutes: $checkOutTzOffsetMinutes, ')
          ..write('lastScanUtc: $lastScanUtc, ')
          ..write('overrideStatus: $overrideStatus, ')
          ..write('note: $note, ')
          ..write('isManual: $isManual, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeId,
    checkInUtc,
    checkOutUtc,
    localDate,
    checkInTzOffsetMinutes,
    checkOutTzOffsetMinutes,
    lastScanUtc,
    overrideStatus,
    note,
    isManual,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttendanceRecord &&
          other.id == this.id &&
          other.employeeId == this.employeeId &&
          other.checkInUtc == this.checkInUtc &&
          other.checkOutUtc == this.checkOutUtc &&
          other.localDate == this.localDate &&
          other.checkInTzOffsetMinutes == this.checkInTzOffsetMinutes &&
          other.checkOutTzOffsetMinutes == this.checkOutTzOffsetMinutes &&
          other.lastScanUtc == this.lastScanUtc &&
          other.overrideStatus == this.overrideStatus &&
          other.note == this.note &&
          other.isManual == this.isManual &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AttendanceRecordsCompanion extends UpdateCompanion<AttendanceRecord> {
  final Value<int> id;
  final Value<int> employeeId;
  final Value<DateTime?> checkInUtc;
  final Value<DateTime?> checkOutUtc;
  final Value<DateTime> localDate;
  final Value<int> checkInTzOffsetMinutes;
  final Value<int?> checkOutTzOffsetMinutes;
  final Value<DateTime?> lastScanUtc;
  final Value<String?> overrideStatus;
  final Value<String> note;
  final Value<bool> isManual;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AttendanceRecordsCompanion({
    this.id = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.checkInUtc = const Value.absent(),
    this.checkOutUtc = const Value.absent(),
    this.localDate = const Value.absent(),
    this.checkInTzOffsetMinutes = const Value.absent(),
    this.checkOutTzOffsetMinutes = const Value.absent(),
    this.lastScanUtc = const Value.absent(),
    this.overrideStatus = const Value.absent(),
    this.note = const Value.absent(),
    this.isManual = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AttendanceRecordsCompanion.insert({
    this.id = const Value.absent(),
    required int employeeId,
    this.checkInUtc = const Value.absent(),
    this.checkOutUtc = const Value.absent(),
    required DateTime localDate,
    this.checkInTzOffsetMinutes = const Value.absent(),
    this.checkOutTzOffsetMinutes = const Value.absent(),
    this.lastScanUtc = const Value.absent(),
    this.overrideStatus = const Value.absent(),
    this.note = const Value.absent(),
    this.isManual = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : employeeId = Value(employeeId),
       localDate = Value(localDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AttendanceRecord> custom({
    Expression<int>? id,
    Expression<int>? employeeId,
    Expression<DateTime>? checkInUtc,
    Expression<DateTime>? checkOutUtc,
    Expression<DateTime>? localDate,
    Expression<int>? checkInTzOffsetMinutes,
    Expression<int>? checkOutTzOffsetMinutes,
    Expression<DateTime>? lastScanUtc,
    Expression<String>? overrideStatus,
    Expression<String>? note,
    Expression<bool>? isManual,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeId != null) 'employee_id': employeeId,
      if (checkInUtc != null) 'check_in_utc': checkInUtc,
      if (checkOutUtc != null) 'check_out_utc': checkOutUtc,
      if (localDate != null) 'local_date': localDate,
      if (checkInTzOffsetMinutes != null)
        'check_in_tz_offset_minutes': checkInTzOffsetMinutes,
      if (checkOutTzOffsetMinutes != null)
        'check_out_tz_offset_minutes': checkOutTzOffsetMinutes,
      if (lastScanUtc != null) 'last_scan_utc': lastScanUtc,
      if (overrideStatus != null) 'override_status': overrideStatus,
      if (note != null) 'note': note,
      if (isManual != null) 'is_manual': isManual,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AttendanceRecordsCompanion copyWith({
    Value<int>? id,
    Value<int>? employeeId,
    Value<DateTime?>? checkInUtc,
    Value<DateTime?>? checkOutUtc,
    Value<DateTime>? localDate,
    Value<int>? checkInTzOffsetMinutes,
    Value<int?>? checkOutTzOffsetMinutes,
    Value<DateTime?>? lastScanUtc,
    Value<String?>? overrideStatus,
    Value<String>? note,
    Value<bool>? isManual,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AttendanceRecordsCompanion(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      checkInUtc: checkInUtc ?? this.checkInUtc,
      checkOutUtc: checkOutUtc ?? this.checkOutUtc,
      localDate: localDate ?? this.localDate,
      checkInTzOffsetMinutes:
          checkInTzOffsetMinutes ?? this.checkInTzOffsetMinutes,
      checkOutTzOffsetMinutes:
          checkOutTzOffsetMinutes ?? this.checkOutTzOffsetMinutes,
      lastScanUtc: lastScanUtc ?? this.lastScanUtc,
      overrideStatus: overrideStatus ?? this.overrideStatus,
      note: note ?? this.note,
      isManual: isManual ?? this.isManual,
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
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (checkInUtc.present) {
      map['check_in_utc'] = Variable<DateTime>(checkInUtc.value);
    }
    if (checkOutUtc.present) {
      map['check_out_utc'] = Variable<DateTime>(checkOutUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<DateTime>(localDate.value);
    }
    if (checkInTzOffsetMinutes.present) {
      map['check_in_tz_offset_minutes'] = Variable<int>(
        checkInTzOffsetMinutes.value,
      );
    }
    if (checkOutTzOffsetMinutes.present) {
      map['check_out_tz_offset_minutes'] = Variable<int>(
        checkOutTzOffsetMinutes.value,
      );
    }
    if (lastScanUtc.present) {
      map['last_scan_utc'] = Variable<DateTime>(lastScanUtc.value);
    }
    if (overrideStatus.present) {
      map['override_status'] = Variable<String>(overrideStatus.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (isManual.present) {
      map['is_manual'] = Variable<bool>(isManual.value);
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
    return (StringBuffer('AttendanceRecordsCompanion(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('checkInUtc: $checkInUtc, ')
          ..write('checkOutUtc: $checkOutUtc, ')
          ..write('localDate: $localDate, ')
          ..write('checkInTzOffsetMinutes: $checkInTzOffsetMinutes, ')
          ..write('checkOutTzOffsetMinutes: $checkOutTzOffsetMinutes, ')
          ..write('lastScanUtc: $lastScanUtc, ')
          ..write('overrideStatus: $overrideStatus, ')
          ..write('note: $note, ')
          ..write('isManual: $isManual, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ScanEventsTable extends ScanEvents
    with TableInfo<$ScanEventsTable, ScanEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScanEventsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _employeeIdMeta = const VerificationMeta(
    'employeeId',
  );
  @override
  late final GeneratedColumn<int> employeeId = GeneratedColumn<int>(
    'employee_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES employees (id)',
    ),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _scannedAtUtcMeta = const VerificationMeta(
    'scannedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAtUtc = GeneratedColumn<DateTime>(
    'scanned_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localDateMeta = const VerificationMeta(
    'localDate',
  );
  @override
  late final GeneratedColumn<DateTime> localDate = GeneratedColumn<DateTime>(
    'local_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    employeeId,
    payload,
    result,
    message,
    scannedAtUtc,
    localDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'scan_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScanEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('employee_id')) {
      context.handle(
        _employeeIdMeta,
        employeeId.isAcceptableOrUnknown(data['employee_id']!, _employeeIdMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    } else if (isInserting) {
      context.missing(_resultMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('scanned_at_utc')) {
      context.handle(
        _scannedAtUtcMeta,
        scannedAtUtc.isAcceptableOrUnknown(
          data['scanned_at_utc']!,
          _scannedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scannedAtUtcMeta);
    }
    if (data.containsKey('local_date')) {
      context.handle(
        _localDateMeta,
        localDate.isAcceptableOrUnknown(data['local_date']!, _localDateMeta),
      );
    } else if (isInserting) {
      context.missing(_localDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScanEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScanEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      employeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}employee_id'],
      ),
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      scannedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanned_at_utc'],
      )!,
      localDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}local_date'],
      )!,
    );
  }

  @override
  $ScanEventsTable createAlias(String alias) {
    return $ScanEventsTable(attachedDatabase, alias);
  }
}

class ScanEvent extends DataClass implements Insertable<ScanEvent> {
  final int id;
  final int? employeeId;
  final String? payload;
  final String result;
  final String message;
  final DateTime scannedAtUtc;
  final DateTime localDate;
  const ScanEvent({
    required this.id,
    this.employeeId,
    this.payload,
    required this.result,
    required this.message,
    required this.scannedAtUtc,
    required this.localDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || employeeId != null) {
      map['employee_id'] = Variable<int>(employeeId);
    }
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['result'] = Variable<String>(result);
    map['message'] = Variable<String>(message);
    map['scanned_at_utc'] = Variable<DateTime>(scannedAtUtc);
    map['local_date'] = Variable<DateTime>(localDate);
    return map;
  }

  ScanEventsCompanion toCompanion(bool nullToAbsent) {
    return ScanEventsCompanion(
      id: Value(id),
      employeeId: employeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(employeeId),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      result: Value(result),
      message: Value(message),
      scannedAtUtc: Value(scannedAtUtc),
      localDate: Value(localDate),
    );
  }

  factory ScanEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScanEvent(
      id: serializer.fromJson<int>(json['id']),
      employeeId: serializer.fromJson<int?>(json['employeeId']),
      payload: serializer.fromJson<String?>(json['payload']),
      result: serializer.fromJson<String>(json['result']),
      message: serializer.fromJson<String>(json['message']),
      scannedAtUtc: serializer.fromJson<DateTime>(json['scannedAtUtc']),
      localDate: serializer.fromJson<DateTime>(json['localDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'employeeId': serializer.toJson<int?>(employeeId),
      'payload': serializer.toJson<String?>(payload),
      'result': serializer.toJson<String>(result),
      'message': serializer.toJson<String>(message),
      'scannedAtUtc': serializer.toJson<DateTime>(scannedAtUtc),
      'localDate': serializer.toJson<DateTime>(localDate),
    };
  }

  ScanEvent copyWith({
    int? id,
    Value<int?> employeeId = const Value.absent(),
    Value<String?> payload = const Value.absent(),
    String? result,
    String? message,
    DateTime? scannedAtUtc,
    DateTime? localDate,
  }) => ScanEvent(
    id: id ?? this.id,
    employeeId: employeeId.present ? employeeId.value : this.employeeId,
    payload: payload.present ? payload.value : this.payload,
    result: result ?? this.result,
    message: message ?? this.message,
    scannedAtUtc: scannedAtUtc ?? this.scannedAtUtc,
    localDate: localDate ?? this.localDate,
  );
  ScanEvent copyWithCompanion(ScanEventsCompanion data) {
    return ScanEvent(
      id: data.id.present ? data.id.value : this.id,
      employeeId: data.employeeId.present
          ? data.employeeId.value
          : this.employeeId,
      payload: data.payload.present ? data.payload.value : this.payload,
      result: data.result.present ? data.result.value : this.result,
      message: data.message.present ? data.message.value : this.message,
      scannedAtUtc: data.scannedAtUtc.present
          ? data.scannedAtUtc.value
          : this.scannedAtUtc,
      localDate: data.localDate.present ? data.localDate.value : this.localDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScanEvent(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('payload: $payload, ')
          ..write('result: $result, ')
          ..write('message: $message, ')
          ..write('scannedAtUtc: $scannedAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    employeeId,
    payload,
    result,
    message,
    scannedAtUtc,
    localDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScanEvent &&
          other.id == this.id &&
          other.employeeId == this.employeeId &&
          other.payload == this.payload &&
          other.result == this.result &&
          other.message == this.message &&
          other.scannedAtUtc == this.scannedAtUtc &&
          other.localDate == this.localDate);
}

class ScanEventsCompanion extends UpdateCompanion<ScanEvent> {
  final Value<int> id;
  final Value<int?> employeeId;
  final Value<String?> payload;
  final Value<String> result;
  final Value<String> message;
  final Value<DateTime> scannedAtUtc;
  final Value<DateTime> localDate;
  const ScanEventsCompanion({
    this.id = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.payload = const Value.absent(),
    this.result = const Value.absent(),
    this.message = const Value.absent(),
    this.scannedAtUtc = const Value.absent(),
    this.localDate = const Value.absent(),
  });
  ScanEventsCompanion.insert({
    this.id = const Value.absent(),
    this.employeeId = const Value.absent(),
    this.payload = const Value.absent(),
    required String result,
    this.message = const Value.absent(),
    required DateTime scannedAtUtc,
    required DateTime localDate,
  }) : result = Value(result),
       scannedAtUtc = Value(scannedAtUtc),
       localDate = Value(localDate);
  static Insertable<ScanEvent> custom({
    Expression<int>? id,
    Expression<int>? employeeId,
    Expression<String>? payload,
    Expression<String>? result,
    Expression<String>? message,
    Expression<DateTime>? scannedAtUtc,
    Expression<DateTime>? localDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (employeeId != null) 'employee_id': employeeId,
      if (payload != null) 'payload': payload,
      if (result != null) 'result': result,
      if (message != null) 'message': message,
      if (scannedAtUtc != null) 'scanned_at_utc': scannedAtUtc,
      if (localDate != null) 'local_date': localDate,
    });
  }

  ScanEventsCompanion copyWith({
    Value<int>? id,
    Value<int?>? employeeId,
    Value<String?>? payload,
    Value<String>? result,
    Value<String>? message,
    Value<DateTime>? scannedAtUtc,
    Value<DateTime>? localDate,
  }) {
    return ScanEventsCompanion(
      id: id ?? this.id,
      employeeId: employeeId ?? this.employeeId,
      payload: payload ?? this.payload,
      result: result ?? this.result,
      message: message ?? this.message,
      scannedAtUtc: scannedAtUtc ?? this.scannedAtUtc,
      localDate: localDate ?? this.localDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (employeeId.present) {
      map['employee_id'] = Variable<int>(employeeId.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (scannedAtUtc.present) {
      map['scanned_at_utc'] = Variable<DateTime>(scannedAtUtc.value);
    }
    if (localDate.present) {
      map['local_date'] = Variable<DateTime>(localDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScanEventsCompanion(')
          ..write('id: $id, ')
          ..write('employeeId: $employeeId, ')
          ..write('payload: $payload, ')
          ..write('result: $result, ')
          ..write('message: $message, ')
          ..write('scannedAtUtc: $scannedAtUtc, ')
          ..write('localDate: $localDate')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTable extends AuditLogs
    with TableInfo<$AuditLogsTable, AuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<int> entityId = GeneratedColumn<int>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousValueMeta = const VerificationMeta(
    'previousValue',
  );
  @override
  late final GeneratedColumn<String> previousValue = GeneratedColumn<String>(
    'previous_value',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _newValueMeta = const VerificationMeta(
    'newValue',
  );
  @override
  late final GeneratedColumn<String> newValue = GeneratedColumn<String>(
    'new_value',
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
    entityType,
    entityId,
    action,
    previousValue,
    newValue,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('previous_value')) {
      context.handle(
        _previousValueMeta,
        previousValue.isAcceptableOrUnknown(
          data['previous_value']!,
          _previousValueMeta,
        ),
      );
    }
    if (data.containsKey('new_value')) {
      context.handle(
        _newValueMeta,
        newValue.isAcceptableOrUnknown(data['new_value']!, _newValueMeta),
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
  AuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entity_id'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      previousValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_value'],
      ),
      newValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTable createAlias(String alias) {
    return $AuditLogsTable(attachedDatabase, alias);
  }
}

class AuditLog extends DataClass implements Insertable<AuditLog> {
  final int id;
  final String entityType;
  final int? entityId;
  final String action;
  final String? previousValue;
  final String? newValue;
  final DateTime createdAt;
  const AuditLog({
    required this.id,
    required this.entityType,
    this.entityId,
    required this.action,
    this.previousValue,
    this.newValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<int>(entityId);
    }
    map['action'] = Variable<String>(action);
    if (!nullToAbsent || previousValue != null) {
      map['previous_value'] = Variable<String>(previousValue);
    }
    if (!nullToAbsent || newValue != null) {
      map['new_value'] = Variable<String>(newValue);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      action: Value(action),
      previousValue: previousValue == null && nullToAbsent
          ? const Value.absent()
          : Value(previousValue),
      newValue: newValue == null && nullToAbsent
          ? const Value.absent()
          : Value(newValue),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLog(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<int?>(json['entityId']),
      action: serializer.fromJson<String>(json['action']),
      previousValue: serializer.fromJson<String?>(json['previousValue']),
      newValue: serializer.fromJson<String?>(json['newValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<int?>(entityId),
      'action': serializer.toJson<String>(action),
      'previousValue': serializer.toJson<String?>(previousValue),
      'newValue': serializer.toJson<String?>(newValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLog copyWith({
    int? id,
    String? entityType,
    Value<int?> entityId = const Value.absent(),
    String? action,
    Value<String?> previousValue = const Value.absent(),
    Value<String?> newValue = const Value.absent(),
    DateTime? createdAt,
  }) => AuditLog(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    action: action ?? this.action,
    previousValue: previousValue.present
        ? previousValue.value
        : this.previousValue,
    newValue: newValue.present ? newValue.value : this.newValue,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLog copyWithCompanion(AuditLogsCompanion data) {
    return AuditLog(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      action: data.action.present ? data.action.value : this.action,
      previousValue: data.previousValue.present
          ? data.previousValue.value
          : this.previousValue,
      newValue: data.newValue.present ? data.newValue.value : this.newValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLog(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('previousValue: $previousValue, ')
          ..write('newValue: $newValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    action,
    previousValue,
    newValue,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLog &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.action == this.action &&
          other.previousValue == this.previousValue &&
          other.newValue == this.newValue &&
          other.createdAt == this.createdAt);
}

class AuditLogsCompanion extends UpdateCompanion<AuditLog> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<int?> entityId;
  final Value<String> action;
  final Value<String?> previousValue;
  final Value<String?> newValue;
  final Value<DateTime> createdAt;
  const AuditLogsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.action = const Value.absent(),
    this.previousValue = const Value.absent(),
    this.newValue = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogsCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    this.entityId = const Value.absent(),
    required String action,
    this.previousValue = const Value.absent(),
    this.newValue = const Value.absent(),
    required DateTime createdAt,
  }) : entityType = Value(entityType),
       action = Value(action),
       createdAt = Value(createdAt);
  static Insertable<AuditLog> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<int>? entityId,
    Expression<String>? action,
    Expression<String>? previousValue,
    Expression<String>? newValue,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (action != null) 'action': action,
      if (previousValue != null) 'previous_value': previousValue,
      if (newValue != null) 'new_value': newValue,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogsCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<int?>? entityId,
    Value<String>? action,
    Value<String?>? previousValue,
    Value<String?>? newValue,
    Value<DateTime>? createdAt,
  }) {
    return AuditLogsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      action: action ?? this.action,
      previousValue: previousValue ?? this.previousValue,
      newValue: newValue ?? this.newValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<int>(entityId.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (previousValue.present) {
      map['previous_value'] = Variable<String>(previousValue.value);
    }
    if (newValue.present) {
      map['new_value'] = Variable<String>(newValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('action: $action, ')
          ..write('previousValue: $previousValue, ')
          ..write('newValue: $newValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $HolidaysTable extends Holidays with TableInfo<$HolidaysTable, Holiday> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HolidaysTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
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
  List<GeneratedColumn> get $columns => [id, date, name, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'holidays';
  @override
  VerificationContext validateIntegrity(
    Insertable<Holiday> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
  Holiday map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Holiday(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HolidaysTable createAlias(String alias) {
    return $HolidaysTable(attachedDatabase, alias);
  }
}

class Holiday extends DataClass implements Insertable<Holiday> {
  final int id;
  final DateTime date;
  final String name;
  final DateTime createdAt;
  const Holiday({
    required this.id,
    required this.date,
    required this.name,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['date'] = Variable<DateTime>(date);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HolidaysCompanion toCompanion(bool nullToAbsent) {
    return HolidaysCompanion(
      id: Value(id),
      date: Value(date),
      name: Value(name),
      createdAt: Value(createdAt),
    );
  }

  factory Holiday.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Holiday(
      id: serializer.fromJson<int>(json['id']),
      date: serializer.fromJson<DateTime>(json['date']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'date': serializer.toJson<DateTime>(date),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Holiday copyWith({
    int? id,
    DateTime? date,
    String? name,
    DateTime? createdAt,
  }) => Holiday(
    id: id ?? this.id,
    date: date ?? this.date,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );
  Holiday copyWithCompanion(HolidaysCompanion data) {
    return Holiday(
      id: data.id.present ? data.id.value : this.id,
      date: data.date.present ? data.date.value : this.date,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Holiday(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, date, name, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Holiday &&
          other.id == this.id &&
          other.date == this.date &&
          other.name == this.name &&
          other.createdAt == this.createdAt);
}

class HolidaysCompanion extends UpdateCompanion<Holiday> {
  final Value<int> id;
  final Value<DateTime> date;
  final Value<String> name;
  final Value<DateTime> createdAt;
  const HolidaysCompanion({
    this.id = const Value.absent(),
    this.date = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HolidaysCompanion.insert({
    this.id = const Value.absent(),
    required DateTime date,
    required String name,
    required DateTime createdAt,
  }) : date = Value(date),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<Holiday> custom({
    Expression<int>? id,
    Expression<DateTime>? date,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (date != null) 'date': date,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HolidaysCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? date,
    Value<String>? name,
    Value<DateTime>? createdAt,
  }) {
    return HolidaysCompanion(
      id: id ?? this.id,
      date: date ?? this.date,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HolidaysCompanion(')
          ..write('id: $id, ')
          ..write('date: $date, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmployeesTable employees = $EmployeesTable(this);
  late final $AttendanceRecordsTable attendanceRecords =
      $AttendanceRecordsTable(this);
  late final $ScanEventsTable scanEvents = $ScanEventsTable(this);
  late final $AuditLogsTable auditLogs = $AuditLogsTable(this);
  late final $HolidaysTable holidays = $HolidaysTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    employees,
    attendanceRecords,
    scanEvents,
    auditLogs,
    holidays,
  ];
}

typedef $$EmployeesTableCreateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  required String uuid,
  Value<String> matricule,
  required String firstName,
  required String lastName,
  Value<String> position,
  Value<String> department,
  Value<String> phone,
  Value<DateTime?> hireDate,
  Value<String?> photoPath,
  Value<bool> isArchived,
  Value<int> badgeVersion,
  Value<bool> useCustomSchedule,
  Value<String> workDays,
  Value<int> startMinutes,
  Value<int> endMinutes,
  Value<int> breakMinutes,
  Value<int?> lateToleranceMinutes,
  Value<int?> earlyLeaveToleranceMinutes,
  Value<int?> overtimeThresholdMinutes,
  required DateTime createdAt,
  required DateTime updatedAt,
});
typedef $$EmployeesTableUpdateCompanionBuilder = EmployeesCompanion Function({
  Value<int> id,
  Value<String> uuid,
  Value<String> matricule,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> position,
  Value<String> department,
  Value<String> phone,
  Value<DateTime?> hireDate,
  Value<String?> photoPath,
  Value<bool> isArchived,
  Value<int> badgeVersion,
  Value<bool> useCustomSchedule,
  Value<String> workDays,
  Value<int> startMinutes,
  Value<int> endMinutes,
  Value<int> breakMinutes,
  Value<int?> lateToleranceMinutes,
  Value<int?> earlyLeaveToleranceMinutes,
  Value<int?> overtimeThresholdMinutes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$EmployeesTableReferences
    extends BaseReferences<_$AppDatabase, $EmployeesTable, Employee> {
  $$EmployeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$AttendanceRecordsTable, List<AttendanceRecord>>
  _attendanceRecordsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.attendanceRecords,
        aliasName: 'employees__id__attendance_records__employee_id',
      );

  $$AttendanceRecordsTableProcessedTableManager get attendanceRecordsRefs {
    final manager = $$AttendanceRecordsTableTableManager(
      $_db,
      $_db.attendanceRecords,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _attendanceRecordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ScanEventsTable, List<ScanEvent>>
  _scanEventsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.scanEvents,
    aliasName: 'employees__id__scan_events__employee_id',
  );

  $$ScanEventsTableProcessedTableManager get scanEventsRefs {
    final manager = $$ScanEventsTableTableManager(
      $_db,
      $_db.scanEvents,
    ).filter((f) => f.employeeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_scanEventsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableFilterComposer({
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

  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get matricule => $composableBuilder(
    column: $table.matricule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get badgeVersion => $composableBuilder(
    column: $table.badgeVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get useCustomSchedule => $composableBuilder(
    column: $table.useCustomSchedule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workDays => $composableBuilder(
    column: $table.workDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lateToleranceMinutes => $composableBuilder(
    column: $table.lateToleranceMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get earlyLeaveToleranceMinutes => $composableBuilder(
    column: $table.earlyLeaveToleranceMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get overtimeThresholdMinutes => $composableBuilder(
    column: $table.overtimeThresholdMinutes,
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

  Expression<bool> attendanceRecordsRefs(
    Expression<bool> Function($$AttendanceRecordsTableFilterComposer f) f,
  ) {
    final $$AttendanceRecordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.attendanceRecords,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AttendanceRecordsTableFilterComposer(
            $db: $db,
            $table: $db.attendanceRecords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> scanEventsRefs(
    Expression<bool> Function($$ScanEventsTableFilterComposer f) f,
  ) {
    final $$ScanEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanEvents,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanEventsTableFilterComposer(
            $db: $db,
            $table: $db.scanEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableOrderingComposer({
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

  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get matricule => $composableBuilder(
    column: $table.matricule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get hireDate => $composableBuilder(
    column: $table.hireDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get badgeVersion => $composableBuilder(
    column: $table.badgeVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get useCustomSchedule => $composableBuilder(
    column: $table.useCustomSchedule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workDays => $composableBuilder(
    column: $table.workDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lateToleranceMinutes => $composableBuilder(
    column: $table.lateToleranceMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get earlyLeaveToleranceMinutes => $composableBuilder(
    column: $table.earlyLeaveToleranceMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get overtimeThresholdMinutes => $composableBuilder(
    column: $table.overtimeThresholdMinutes,
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

class $$EmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmployeesTable> {
  $$EmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get matricule =>
      $composableBuilder(column: $table.matricule, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get department => $composableBuilder(
    column: $table.department,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get hireDate =>
      $composableBuilder(column: $table.hireDate, builder: (column) => column);

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get badgeVersion => $composableBuilder(
    column: $table.badgeVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get useCustomSchedule => $composableBuilder(
    column: $table.useCustomSchedule,
    builder: (column) => column,
  );

  GeneratedColumn<String> get workDays =>
      $composableBuilder(column: $table.workDays, builder: (column) => column);

  GeneratedColumn<int> get startMinutes => $composableBuilder(
    column: $table.startMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinutes => $composableBuilder(
    column: $table.endMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lateToleranceMinutes => $composableBuilder(
    column: $table.lateToleranceMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get earlyLeaveToleranceMinutes => $composableBuilder(
    column: $table.earlyLeaveToleranceMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get overtimeThresholdMinutes => $composableBuilder(
    column: $table.overtimeThresholdMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> attendanceRecordsRefs<T extends Object>(
    Expression<T> Function($$AttendanceRecordsTableAnnotationComposer a) f,
  ) {
    final $$AttendanceRecordsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.attendanceRecords,
          getReferencedColumn: (t) => t.employeeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AttendanceRecordsTableAnnotationComposer(
                $db: $db,
                $table: $db.attendanceRecords,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> scanEventsRefs<T extends Object>(
    Expression<T> Function($$ScanEventsTableAnnotationComposer a) f,
  ) {
    final $$ScanEventsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.scanEvents,
      getReferencedColumn: (t) => t.employeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ScanEventsTableAnnotationComposer(
            $db: $db,
            $table: $db.scanEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmployeesTable,
          Employee,
          $$EmployeesTableFilterComposer,
          $$EmployeesTableOrderingComposer,
          $$EmployeesTableAnnotationComposer,
          $$EmployeesTableCreateCompanionBuilder,
          $$EmployeesTableUpdateCompanionBuilder,
          (Employee, $$EmployeesTableReferences),
          Employee,
          PrefetchHooks Function({
            bool attendanceRecordsRefs,
            bool scanEventsRefs,
          })
        > {
  $$EmployeesTableTableManager(_$AppDatabase db, $EmployeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> uuid = const Value.absent(),
                Value<String> matricule = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<String> position = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<DateTime?> hireDate = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> badgeVersion = const Value.absent(),
                Value<bool> useCustomSchedule = const Value.absent(),
                Value<String> workDays = const Value.absent(),
                Value<int> startMinutes = const Value.absent(),
                Value<int> endMinutes = const Value.absent(),
                Value<int> breakMinutes = const Value.absent(),
                Value<int?> lateToleranceMinutes = const Value.absent(),
                Value<int?> earlyLeaveToleranceMinutes = const Value.absent(),
                Value<int?> overtimeThresholdMinutes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => EmployeesCompanion(
                id: id,
                uuid: uuid,
                matricule: matricule,
                firstName: firstName,
                lastName: lastName,
                position: position,
                department: department,
                phone: phone,
                hireDate: hireDate,
                photoPath: photoPath,
                isArchived: isArchived,
                badgeVersion: badgeVersion,
                useCustomSchedule: useCustomSchedule,
                workDays: workDays,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                breakMinutes: breakMinutes,
                lateToleranceMinutes: lateToleranceMinutes,
                earlyLeaveToleranceMinutes: earlyLeaveToleranceMinutes,
                overtimeThresholdMinutes: overtimeThresholdMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String uuid,
                Value<String> matricule = const Value.absent(),
                required String firstName,
                required String lastName,
                Value<String> position = const Value.absent(),
                Value<String> department = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<DateTime?> hireDate = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> badgeVersion = const Value.absent(),
                Value<bool> useCustomSchedule = const Value.absent(),
                Value<String> workDays = const Value.absent(),
                Value<int> startMinutes = const Value.absent(),
                Value<int> endMinutes = const Value.absent(),
                Value<int> breakMinutes = const Value.absent(),
                Value<int?> lateToleranceMinutes = const Value.absent(),
                Value<int?> earlyLeaveToleranceMinutes = const Value.absent(),
                Value<int?> overtimeThresholdMinutes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => EmployeesCompanion.insert(
                id: id,
                uuid: uuid,
                matricule: matricule,
                firstName: firstName,
                lastName: lastName,
                position: position,
                department: department,
                phone: phone,
                hireDate: hireDate,
                photoPath: photoPath,
                isArchived: isArchived,
                badgeVersion: badgeVersion,
                useCustomSchedule: useCustomSchedule,
                workDays: workDays,
                startMinutes: startMinutes,
                endMinutes: endMinutes,
                breakMinutes: breakMinutes,
                lateToleranceMinutes: lateToleranceMinutes,
                earlyLeaveToleranceMinutes: earlyLeaveToleranceMinutes,
                overtimeThresholdMinutes: overtimeThresholdMinutes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EmployeesTable, Employee>(table),
                  $$EmployeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({attendanceRecordsRefs = false, scanEventsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (attendanceRecordsRefs) db.attendanceRecords,
                    if (scanEventsRefs) db.scanEvents,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (attendanceRecordsRefs)
                        await $_getPrefetchedDataByColumns<
                          Employee,
                          $EmployeesTable,
                          AttendanceRecord,
                          $AttendanceRecordsTable
                        >(
                          currentTable: table,
                          referencedTable: $$EmployeesTableReferences
                              ._attendanceRecordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EmployeesTableReferences(
                                db,
                                table,
                                p0,
                              ).attendanceRecordsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'employee_id',
                          typedResults: items,
                        ),
                      if (scanEventsRefs)
                        await $_getPrefetchedDataByColumns<
                          Employee,
                          $EmployeesTable,
                          ScanEvent,
                          $ScanEventsTable
                        >(
                          currentTable: table,
                          referencedTable: $$EmployeesTableReferences
                              ._scanEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EmployeesTableReferences(
                                db,
                                table,
                                p0,
                              ).scanEventsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'employee_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$EmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmployeesTable,
      Employee,
      $$EmployeesTableFilterComposer,
      $$EmployeesTableOrderingComposer,
      $$EmployeesTableAnnotationComposer,
      $$EmployeesTableCreateCompanionBuilder,
      $$EmployeesTableUpdateCompanionBuilder,
      (Employee, $$EmployeesTableReferences),
      Employee,
      PrefetchHooks Function({bool attendanceRecordsRefs, bool scanEventsRefs})
    >;
typedef $$AttendanceRecordsTableCreateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<int> id,
      required int employeeId,
      Value<DateTime?> checkInUtc,
      Value<DateTime?> checkOutUtc,
      required DateTime localDate,
      Value<int> checkInTzOffsetMinutes,
      Value<int?> checkOutTzOffsetMinutes,
      Value<DateTime?> lastScanUtc,
      Value<String?> overrideStatus,
      Value<String> note,
      Value<bool> isManual,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$AttendanceRecordsTableUpdateCompanionBuilder =
    AttendanceRecordsCompanion Function({
      Value<int> id,
      Value<int> employeeId,
      Value<DateTime?> checkInUtc,
      Value<DateTime?> checkOutUtc,
      Value<DateTime> localDate,
      Value<int> checkInTzOffsetMinutes,
      Value<int?> checkOutTzOffsetMinutes,
      Value<DateTime?> lastScanUtc,
      Value<String?> overrideStatus,
      Value<String> note,
      Value<bool> isManual,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$AttendanceRecordsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord
        > {
  $$AttendanceRecordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $EmployeesTable _employeeIdTable(_$AppDatabase db) => db.employees
      .createAlias('attendance_records__employee_id__employees__id');

  $$EmployeesTableProcessedTableManager get employeeId {
    final $_column = $_itemColumn<int>('employee_id')!;

    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AttendanceRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableFilterComposer({
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

  ColumnFilters<DateTime> get checkInUtc => $composableBuilder(
    column: $table.checkInUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOutUtc => $composableBuilder(
    column: $table.checkOutUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkInTzOffsetMinutes => $composableBuilder(
    column: $table.checkInTzOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get checkOutTzOffsetMinutes => $composableBuilder(
    column: $table.checkOutTzOffsetMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastScanUtc => $composableBuilder(
    column: $table.lastScanUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overrideStatus => $composableBuilder(
    column: $table.overrideStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isManual => $composableBuilder(
    column: $table.isManual,
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

  $$EmployeesTableFilterComposer get employeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get checkInUtc => $composableBuilder(
    column: $table.checkInUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOutUtc => $composableBuilder(
    column: $table.checkOutUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkInTzOffsetMinutes => $composableBuilder(
    column: $table.checkInTzOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get checkOutTzOffsetMinutes => $composableBuilder(
    column: $table.checkOutTzOffsetMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastScanUtc => $composableBuilder(
    column: $table.lastScanUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overrideStatus => $composableBuilder(
    column: $table.overrideStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isManual => $composableBuilder(
    column: $table.isManual,
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

  $$EmployeesTableOrderingComposer get employeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttendanceRecordsTable> {
  $$AttendanceRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get checkInUtc => $composableBuilder(
    column: $table.checkInUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get checkOutUtc => $composableBuilder(
    column: $table.checkOutUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  GeneratedColumn<int> get checkInTzOffsetMinutes => $composableBuilder(
    column: $table.checkInTzOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get checkOutTzOffsetMinutes => $composableBuilder(
    column: $table.checkOutTzOffsetMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastScanUtc => $composableBuilder(
    column: $table.lastScanUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overrideStatus => $composableBuilder(
    column: $table.overrideStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<bool> get isManual =>
      $composableBuilder(column: $table.isManual, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$EmployeesTableAnnotationComposer get employeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AttendanceRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttendanceRecordsTable,
          AttendanceRecord,
          $$AttendanceRecordsTableFilterComposer,
          $$AttendanceRecordsTableOrderingComposer,
          $$AttendanceRecordsTableAnnotationComposer,
          $$AttendanceRecordsTableCreateCompanionBuilder,
          $$AttendanceRecordsTableUpdateCompanionBuilder,
          (AttendanceRecord, $$AttendanceRecordsTableReferences),
          AttendanceRecord,
          PrefetchHooks Function({bool employeeId})
        > {
  $$AttendanceRecordsTableTableManager(
    _$AppDatabase db,
    $AttendanceRecordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttendanceRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttendanceRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttendanceRecordsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> employeeId = const Value.absent(),
                Value<DateTime?> checkInUtc = const Value.absent(),
                Value<DateTime?> checkOutUtc = const Value.absent(),
                Value<DateTime> localDate = const Value.absent(),
                Value<int> checkInTzOffsetMinutes = const Value.absent(),
                Value<int?> checkOutTzOffsetMinutes = const Value.absent(),
                Value<DateTime?> lastScanUtc = const Value.absent(),
                Value<String?> overrideStatus = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AttendanceRecordsCompanion(
                id: id,
                employeeId: employeeId,
                checkInUtc: checkInUtc,
                checkOutUtc: checkOutUtc,
                localDate: localDate,
                checkInTzOffsetMinutes: checkInTzOffsetMinutes,
                checkOutTzOffsetMinutes: checkOutTzOffsetMinutes,
                lastScanUtc: lastScanUtc,
                overrideStatus: overrideStatus,
                note: note,
                isManual: isManual,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int employeeId,
                Value<DateTime?> checkInUtc = const Value.absent(),
                Value<DateTime?> checkOutUtc = const Value.absent(),
                required DateTime localDate,
                Value<int> checkInTzOffsetMinutes = const Value.absent(),
                Value<int?> checkOutTzOffsetMinutes = const Value.absent(),
                Value<DateTime?> lastScanUtc = const Value.absent(),
                Value<String?> overrideStatus = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<bool> isManual = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => AttendanceRecordsCompanion.insert(
                id: id,
                employeeId: employeeId,
                checkInUtc: checkInUtc,
                checkOutUtc: checkOutUtc,
                localDate: localDate,
                checkInTzOffsetMinutes: checkInTzOffsetMinutes,
                checkOutTzOffsetMinutes: checkOutTzOffsetMinutes,
                lastScanUtc: lastScanUtc,
                overrideStatus: overrideStatus,
                note: note,
                isManual: isManual,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttendanceRecordsTable, AttendanceRecord>(table),
                  $$AttendanceRecordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (employeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.employeeId,
                        referencedTable: $$AttendanceRecordsTableReferences
                            ._employeeIdTable(db),
                        referencedColumn: $$AttendanceRecordsTableReferences
                            ._employeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AttendanceRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttendanceRecordsTable,
      AttendanceRecord,
      $$AttendanceRecordsTableFilterComposer,
      $$AttendanceRecordsTableOrderingComposer,
      $$AttendanceRecordsTableAnnotationComposer,
      $$AttendanceRecordsTableCreateCompanionBuilder,
      $$AttendanceRecordsTableUpdateCompanionBuilder,
      (AttendanceRecord, $$AttendanceRecordsTableReferences),
      AttendanceRecord,
      PrefetchHooks Function({bool employeeId})
    >;
typedef $$ScanEventsTableCreateCompanionBuilder = ScanEventsCompanion Function({
  Value<int> id,
  Value<int?> employeeId,
  Value<String?> payload,
  required String result,
  Value<String> message,
  required DateTime scannedAtUtc,
  required DateTime localDate,
});
typedef $$ScanEventsTableUpdateCompanionBuilder = ScanEventsCompanion Function({
  Value<int> id,
  Value<int?> employeeId,
  Value<String?> payload,
  Value<String> result,
  Value<String> message,
  Value<DateTime> scannedAtUtc,
  Value<DateTime> localDate,
});

final class $$ScanEventsTableReferences
    extends BaseReferences<_$AppDatabase, $ScanEventsTable, ScanEvent> {
  $$ScanEventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EmployeesTable _employeeIdTable(_$AppDatabase db) =>
      db.employees.createAlias('scan_events__employee_id__employees__id');

  $$EmployeesTableProcessedTableManager? get employeeId {
    final $_column = $_itemColumn<int>('employee_id');
    if ($_column == null) return null;
    final manager = $$EmployeesTableTableManager(
      $_db,
      $_db.employees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_employeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ScanEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ScanEventsTable> {
  $$ScanEventsTableFilterComposer({
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

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAtUtc => $composableBuilder(
    column: $table.scannedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnFilters(column),
  );

  $$EmployeesTableFilterComposer get employeeId {
    final $$EmployeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableFilterComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ScanEventsTable> {
  $$ScanEventsTableOrderingComposer({
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

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAtUtc => $composableBuilder(
    column: $table.scannedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get localDate => $composableBuilder(
    column: $table.localDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$EmployeesTableOrderingComposer get employeeId {
    final $$EmployeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableOrderingComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScanEventsTable> {
  $$ScanEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAtUtc => $composableBuilder(
    column: $table.scannedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get localDate =>
      $composableBuilder(column: $table.localDate, builder: (column) => column);

  $$EmployeesTableAnnotationComposer get employeeId {
    final $$EmployeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.employeeId,
      referencedTable: $db.employees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EmployeesTableAnnotationComposer(
            $db: $db,
            $table: $db.employees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ScanEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScanEventsTable,
          ScanEvent,
          $$ScanEventsTableFilterComposer,
          $$ScanEventsTableOrderingComposer,
          $$ScanEventsTableAnnotationComposer,
          $$ScanEventsTableCreateCompanionBuilder,
          $$ScanEventsTableUpdateCompanionBuilder,
          (ScanEvent, $$ScanEventsTableReferences),
          ScanEvent,
          PrefetchHooks Function({bool employeeId})
        > {
  $$ScanEventsTableTableManager(_$AppDatabase db, $ScanEventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScanEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScanEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScanEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> employeeId = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String> result = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<DateTime> scannedAtUtc = const Value.absent(),
                Value<DateTime> localDate = const Value.absent(),
              }) => ScanEventsCompanion(
                id: id,
                employeeId: employeeId,
                payload: payload,
                result: result,
                message: message,
                scannedAtUtc: scannedAtUtc,
                localDate: localDate,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> employeeId = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                required String result,
                Value<String> message = const Value.absent(),
                required DateTime scannedAtUtc,
                required DateTime localDate,
              }) => ScanEventsCompanion.insert(
                id: id,
                employeeId: employeeId,
                payload: payload,
                result: result,
                message: message,
                scannedAtUtc: scannedAtUtc,
                localDate: localDate,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ScanEventsTable, ScanEvent>(table),
                  $$ScanEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({employeeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (employeeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.employeeId,
                        referencedTable: $$ScanEventsTableReferences
                            ._employeeIdTable(db),
                        referencedColumn: $$ScanEventsTableReferences
                            ._employeeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ScanEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScanEventsTable,
      ScanEvent,
      $$ScanEventsTableFilterComposer,
      $$ScanEventsTableOrderingComposer,
      $$ScanEventsTableAnnotationComposer,
      $$ScanEventsTableCreateCompanionBuilder,
      $$ScanEventsTableUpdateCompanionBuilder,
      (ScanEvent, $$ScanEventsTableReferences),
      ScanEvent,
      PrefetchHooks Function({bool employeeId})
    >;
typedef $$AuditLogsTableCreateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  required String entityType,
  Value<int?> entityId,
  required String action,
  Value<String?> previousValue,
  Value<String?> newValue,
  required DateTime createdAt,
});
typedef $$AuditLogsTableUpdateCompanionBuilder = AuditLogsCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<int?> entityId,
  Value<String> action,
  Value<String?> previousValue,
  Value<String?> newValue,
  Value<DateTime> createdAt,
});

class $$AuditLogsTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableFilterComposer({
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

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableOrderingComposer({
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

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newValue => $composableBuilder(
    column: $table.newValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTable> {
  $$AuditLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get previousValue => $composableBuilder(
    column: $table.previousValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get newValue =>
      $composableBuilder(column: $table.newValue, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTable,
          AuditLog,
          $$AuditLogsTableFilterComposer,
          $$AuditLogsTableOrderingComposer,
          $$AuditLogsTableAnnotationComposer,
          $$AuditLogsTableCreateCompanionBuilder,
          $$AuditLogsTableUpdateCompanionBuilder,
          (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
          AuditLog,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableManager(_$AppDatabase db, $AuditLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<int?> entityId = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String?> previousValue = const Value.absent(),
                Value<String?> newValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => AuditLogsCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                previousValue: previousValue,
                newValue: newValue,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                Value<int?> entityId = const Value.absent(),
                required String action,
                Value<String?> previousValue = const Value.absent(),
                Value<String?> newValue = const Value.absent(),
                required DateTime createdAt,
              }) => AuditLogsCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                action: action,
                previousValue: previousValue,
                newValue: newValue,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTable, AuditLog>(table),
                  BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTable,
      AuditLog,
      $$AuditLogsTableFilterComposer,
      $$AuditLogsTableOrderingComposer,
      $$AuditLogsTableAnnotationComposer,
      $$AuditLogsTableCreateCompanionBuilder,
      $$AuditLogsTableUpdateCompanionBuilder,
      (AuditLog, BaseReferences<_$AppDatabase, $AuditLogsTable, AuditLog>),
      AuditLog,
      PrefetchHooks Function()
    >;
typedef $$HolidaysTableCreateCompanionBuilder = HolidaysCompanion Function({
  Value<int> id,
  required DateTime date,
  required String name,
  required DateTime createdAt,
});
typedef $$HolidaysTableUpdateCompanionBuilder = HolidaysCompanion Function({
  Value<int> id,
  Value<DateTime> date,
  Value<String> name,
  Value<DateTime> createdAt,
});

class $$HolidaysTableFilterComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableFilterComposer({
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

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HolidaysTableOrderingComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableOrderingComposer({
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

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HolidaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $HolidaysTable> {
  $$HolidaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HolidaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HolidaysTable,
          Holiday,
          $$HolidaysTableFilterComposer,
          $$HolidaysTableOrderingComposer,
          $$HolidaysTableAnnotationComposer,
          $$HolidaysTableCreateCompanionBuilder,
          $$HolidaysTableUpdateCompanionBuilder,
          (Holiday, BaseReferences<_$AppDatabase, $HolidaysTable, Holiday>),
          Holiday,
          PrefetchHooks Function()
        > {
  $$HolidaysTableTableManager(_$AppDatabase db, $HolidaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HolidaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HolidaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HolidaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HolidaysCompanion(
                id: id,
                date: date,
                name: name,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime date,
                required String name,
                required DateTime createdAt,
              }) => HolidaysCompanion.insert(
                id: id,
                date: date,
                name: name,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HolidaysTable, Holiday>(table),
                  BaseReferences<_$AppDatabase, $HolidaysTable, Holiday>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HolidaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HolidaysTable,
      Holiday,
      $$HolidaysTableFilterComposer,
      $$HolidaysTableOrderingComposer,
      $$HolidaysTableAnnotationComposer,
      $$HolidaysTableCreateCompanionBuilder,
      $$HolidaysTableUpdateCompanionBuilder,
      (Holiday, BaseReferences<_$AppDatabase, $HolidaysTable, Holiday>),
      Holiday,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmployeesTableTableManager get employees =>
      $$EmployeesTableTableManager(_db, _db.employees);
  $$AttendanceRecordsTableTableManager get attendanceRecords =>
      $$AttendanceRecordsTableTableManager(_db, _db.attendanceRecords);
  $$ScanEventsTableTableManager get scanEvents =>
      $$ScanEventsTableTableManager(_db, _db.scanEvents);
  $$AuditLogsTableTableManager get auditLogs =>
      $$AuditLogsTableTableManager(_db, _db.auditLogs);
  $$HolidaysTableTableManager get holidays =>
      $$HolidaysTableTableManager(_db, _db.holidays);
}
