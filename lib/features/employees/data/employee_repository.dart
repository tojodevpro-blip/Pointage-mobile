import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/db/app_database.dart';

class EmployeeRepository {
  EmployeeRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<Employee>> watchEmployees({
    bool includeArchived = false,
    String search = '',
    String department = '',
    String sort = 'name',
  }) {
    final query = _db.select(_db.employees);
    if (!includeArchived) {
      query.where((t) => t.isArchived.equals(false));
    }
    if (search.trim().isNotEmpty) {
      final pattern = '%${search.trim().replaceAll('%', '\\%')}%';
      query.where(
        (t) =>
            t.firstName.like(pattern) |
            t.lastName.like(pattern) |
            t.matricule.like(pattern) |
            t.position.like(pattern),
      );
    }
    if (department.trim().isNotEmpty) {
      query.where((t) => t.department.equals(department.trim()));
    }
    switch (sort) {
      case 'recent':
        query.orderBy([(t) => OrderingTerm.desc(t.createdAt)]);
        break;
      case 'department':
        query.orderBy([
          (t) => OrderingTerm.asc(t.department),
          (t) => OrderingTerm.asc(t.lastName),
          (t) => OrderingTerm.asc(t.firstName),
        ]);
        break;
      default:
        query.orderBy([
          (t) => OrderingTerm.asc(t.lastName),
          (t) => OrderingTerm.asc(t.firstName),
        ]);
    }
    return query.watch();
  }

  Future<List<Employee>> activeEmployees() {
    return (_db.select(_db.employees)
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([
            (t) => OrderingTerm.asc(t.lastName),
            (t) => OrderingTerm.asc(t.firstName),
          ]))
        .get();
  }

  Stream<List<Employee>> watchActiveEmployees() {
    return (_db.select(_db.employees)
          ..where((t) => t.isArchived.equals(false))
          ..orderBy([
            (t) => OrderingTerm.asc(t.lastName),
            (t) => OrderingTerm.asc(t.firstName),
          ]))
        .watch();
  }

  Future<Employee?> byId(int id) {
    return (_db.select(
      _db.employees,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<Employee?> byUuid(String uuid) {
    return (_db.select(
      _db.employees,
    )..where((t) => t.uuid.equals(uuid))).getSingleOrNull();
  }

  Future<Employee> create({
    required String firstName,
    required String lastName,
    required String matricule,
    required String position,
    required String department,
    required String phone,
    DateTime? hireDate,
    String? photoPath,
    bool useCustomSchedule = false,
    List<int> workDays = const [1, 2, 3, 4, 5],
    int startMinutes = 480,
    int endMinutes = 1020,
    int breakMinutes = 60,
    int? lateToleranceMinutes,
    int? earlyLeaveToleranceMinutes,
    int? overtimeThresholdMinutes,
  }) async {
    final now = DateTime.now().toUtc();
    final id = await _db
        .into(_db.employees)
        .insert(
          EmployeesCompanion.insert(
            uuid: _uuid.v4(),
            firstName: firstName.trim(),
            lastName: lastName.trim(),
            matricule: Value(matricule.trim()),
            position: Value(position.trim()),
            department: Value(department.trim()),
            phone: Value(phone.trim()),
            hireDate: Value(hireDate),
            photoPath: Value(photoPath),
            isArchived: const Value(false),
            badgeVersion: const Value(1),
            useCustomSchedule: Value(useCustomSchedule),
            workDays: Value(workDays.join(',')),
            startMinutes: Value(startMinutes),
            endMinutes: Value(endMinutes),
            breakMinutes: Value(breakMinutes),
            lateToleranceMinutes: Value(lateToleranceMinutes),
            earlyLeaveToleranceMinutes: Value(earlyLeaveToleranceMinutes),
            overtimeThresholdMinutes: Value(overtimeThresholdMinutes),
            createdAt: now,
            updatedAt: now,
          ),
        );
    return (await byId(id))!;
  }

  Future<void> updateEmployee(
    int id, {
    required String firstName,
    required String lastName,
    required String matricule,
    required String position,
    required String department,
    required String phone,
    DateTime? hireDate,
    String? photoPath,
    required bool useCustomSchedule,
    required List<int> workDays,
    required int startMinutes,
    required int endMinutes,
    required int breakMinutes,
    int? lateToleranceMinutes,
    int? earlyLeaveToleranceMinutes,
    int? overtimeThresholdMinutes,
  }) {
    return (_db.update(_db.employees)..where((t) => t.id.equals(id))).write(
      EmployeesCompanion(
        firstName: Value(firstName.trim()),
        lastName: Value(lastName.trim()),
        matricule: Value(matricule.trim()),
        position: Value(position.trim()),
        department: Value(department.trim()),
        phone: Value(phone.trim()),
        hireDate: Value(hireDate),
        photoPath: Value(photoPath),
        useCustomSchedule: Value(useCustomSchedule),
        workDays: Value(workDays.join(',')),
        startMinutes: Value(startMinutes),
        endMinutes: Value(endMinutes),
        breakMinutes: Value(breakMinutes),
        lateToleranceMinutes: Value(lateToleranceMinutes),
        earlyLeaveToleranceMinutes: Value(earlyLeaveToleranceMinutes),
        overtimeThresholdMinutes: Value(overtimeThresholdMinutes),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<void> setArchived(int id, bool archived) {
    return (_db.update(_db.employees)..where((t) => t.id.equals(id))).write(
      EmployeesCompanion(
        isArchived: Value(archived),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
  }

  Future<int> regenerateBadge(Employee employee) async {
    final next = employee.badgeVersion + 1;
    await (_db.update(
      _db.employees,
    )..where((t) => t.id.equals(employee.id))).write(
      EmployeesCompanion(
        badgeVersion: Value(next),
        updatedAt: Value(DateTime.now().toUtc()),
      ),
    );
    return next;
  }

  Future<void> deleteCascade(Employee employee) async {
    await _db.transaction(() async {
      final records = await (_db.select(
        _db.attendanceRecords,
      )..where((t) => t.employeeId.equals(employee.id))).get();
      final ids = records.map((e) => e.id).toList();
      if (ids.isNotEmpty) {
        await (_db.delete(_db.auditLogs)..where(
              (t) => t.entityType.equals('attendance') & t.entityId.isIn(ids),
            ))
            .go();
      }
      await (_db.delete(
        _db.attendanceRecords,
      )..where((t) => t.employeeId.equals(employee.id))).go();
      await (_db.delete(
        _db.scanEvents,
      )..where((t) => t.employeeId.equals(employee.id))).go();
      await (_db.delete(
        _db.employees,
      )..where((t) => t.id.equals(employee.id))).go();
    });
  }

  Future<List<String>> departments() async {
    final query = _db.selectOnly(_db.employees, distinct: true)
      ..addColumns([_db.employees.department])
      ..where(_db.employees.isArchived.equals(false));
    final rows = await query.get();
    return rows
        .map((r) => r.read(_db.employees.department) ?? '')
        .where((e) => e.trim().isNotEmpty)
        .toSet()
        .toList()
      ..sort();
  }

  String snapshot(Employee employee) => jsonEncode(employee.toJson());
}
