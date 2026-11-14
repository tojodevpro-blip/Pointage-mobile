import 'package:drift/drift.dart';

class Employees extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get uuid => text().unique()();
  TextColumn get matricule => text().withDefault(const Constant(''))();
  TextColumn get firstName => text()();
  TextColumn get lastName => text()();
  TextColumn get position => text().withDefault(const Constant(''))();
  TextColumn get department => text().withDefault(const Constant(''))();
  TextColumn get phone => text().withDefault(const Constant(''))();
  DateTimeColumn get hireDate => dateTime().nullable()();
  TextColumn get photoPath => text().nullable()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get badgeVersion => integer().withDefault(const Constant(1))();
  BoolColumn get useCustomSchedule =>
      boolean().withDefault(const Constant(false))();
  TextColumn get workDays => text().withDefault(const Constant('1,2,3,4,5'))();
  IntColumn get startMinutes => integer().withDefault(const Constant(480))();
  IntColumn get endMinutes => integer().withDefault(const Constant(1020))();
  IntColumn get breakMinutes => integer().withDefault(const Constant(60))();
  IntColumn get lateToleranceMinutes => integer().nullable()();
  IntColumn get earlyLeaveToleranceMinutes => integer().nullable()();
  IntColumn get overtimeThresholdMinutes => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {uuid},
  ];
}

class AttendanceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employeeId => integer().references(Employees, #id)();
  DateTimeColumn get checkInUtc => dateTime().nullable()();
  DateTimeColumn get checkOutUtc => dateTime().nullable()();
  DateTimeColumn get localDate => dateTime()();
  IntColumn get checkInTzOffsetMinutes =>
      integer().withDefault(const Constant(0))();
  IntColumn get checkOutTzOffsetMinutes => integer().nullable()();
  DateTimeColumn get lastScanUtc => dateTime().nullable()();
  TextColumn get overrideStatus => text().nullable()();
  TextColumn get note => text().withDefault(const Constant(''))();
  BoolColumn get isManual => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {employeeId, localDate},
  ];
}

class ScanEvents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get employeeId => integer().nullable().references(Employees, #id)();
  TextColumn get payload => text().nullable()();
  TextColumn get result => text()();
  TextColumn get message => text().withDefault(const Constant(''))();
  DateTimeColumn get scannedAtUtc => dateTime()();
  DateTimeColumn get localDate => dateTime()();
}

class AuditLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  IntColumn get entityId => integer().nullable()();
  TextColumn get action => text()();
  TextColumn get previousValue => text().nullable()();
  TextColumn get newValue => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
}

class Holidays extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get date => dateTime().unique()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();
}
