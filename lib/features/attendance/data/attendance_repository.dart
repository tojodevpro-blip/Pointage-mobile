import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/utils/app_date_utils.dart';
import '../domain/attendance_rules.dart';

class RecordWithEmployee {
  const RecordWithEmployee(this.record, this.employee);

  final AttendanceRecord record;
  final Employee employee;
}

class ScanEventWithEmployee {
  const ScanEventWithEmployee(this.event, this.employee);

  final ScanEvent event;
  final Employee? employee;
}

class AttendanceRepository {
  AttendanceRepository(this._db);

  final AppDatabase _db;

  Stream<List<AttendanceRecord>> watchRange(
    DateTime start,
    DateTime end, {
    int? employeeId,
  }) {
    final query = _db.select(_db.attendanceRecords)
      ..where(
        (t) =>
            t.localDate.isBiggerOrEqualValue(dateOnly(start)) &
            t.localDate.isSmallerOrEqualValue(dateOnly(end)),
      );
    if (employeeId != null) {
      query.where((t) => t.employeeId.equals(employeeId));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.localDate)]);
    return query.watch();
  }

  Future<List<AttendanceRecord>> recordsInRange(
    DateTime start,
    DateTime end, {
    int? employeeId,
  }) {
    final query = _db.select(_db.attendanceRecords)
      ..where(
        (t) =>
            t.localDate.isBiggerOrEqualValue(dateOnly(start)) &
            t.localDate.isSmallerOrEqualValue(dateOnly(end)),
      );
    if (employeeId != null) {
      query.where((t) => t.employeeId.equals(employeeId));
    }
    query.orderBy([(t) => OrderingTerm.asc(t.localDate)]);
    return query.get();
  }

  Stream<List<RecordWithEmployee>> watchWithEmployee(
    DateTime start,
    DateTime end,
  ) {
    final query =
        _db.select(_db.attendanceRecords).join([
            innerJoin(
              _db.employees,
              _db.employees.id.equalsExp(_db.attendanceRecords.employeeId),
            ),
          ])
          ..where(
            _db.attendanceRecords.localDate.isBiggerOrEqualValue(
                  dateOnly(start),
                ) &
                _db.attendanceRecords.localDate.isSmallerOrEqualValue(
                  dateOnly(end),
                ),
          )
          ..orderBy([OrderingTerm.desc(_db.attendanceRecords.localDate)]);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => RecordWithEmployee(
              row.readTable(_db.attendanceRecords),
              row.readTable(_db.employees),
            ),
          )
          .toList(),
    );
  }

  Future<AttendanceRecord?> forEmployeeDate(int employeeId, DateTime date) {
    return (_db.select(_db.attendanceRecords)..where(
          (t) =>
              t.employeeId.equals(employeeId) &
              t.localDate.equals(dateOnly(date)),
        ))
        .getSingleOrNull();
  }

  Future<AttendanceRecord> applyScan({
    required Employee employee,
    required ScanDecision decision,
    required DateTime nowUtc,
    required int tzOffsetMinutes,
  }) async {
    final existing = await forEmployeeDate(employee.id, decision.localDate);
    final now = nowUtc.toUtc();
    switch (decision.outcome) {
      case ScanOutcome.checkIn:
        final id = await _db
            .into(_db.attendanceRecords)
            .insert(
              AttendanceRecordsCompanion.insert(
                employeeId: employee.id,
                checkInUtc: Value(now),
                localDate: decision.localDate,
                checkInTzOffsetMinutes: Value(tzOffsetMinutes),
                lastScanUtc: Value(now),
                createdAt: now,
                updatedAt: now,
              ),
            );
        return (await (_db.select(
          _db.attendanceRecords,
        )..where((t) => t.id.equals(id))).getSingle());
      case ScanOutcome.checkOut:
      case ScanOutcome.checkoutUpdated:
        if (existing == null) {
          throw StateError('No attendance record to update');
        }
        await (_db.update(
          _db.attendanceRecords,
        )..where((t) => t.id.equals(existing.id))).write(
          AttendanceRecordsCompanion(
            checkOutUtc: Value(now),
            checkOutTzOffsetMinutes: Value(tzOffsetMinutes),
            lastScanUtc: Value(now),
            overrideStatus: const Value(null),
            updatedAt: Value(now),
          ),
        );
        return (await (_db.select(
          _db.attendanceRecords,
        )..where((t) => t.id.equals(existing.id))).getSingle());
      case ScanOutcome.duplicate:
      case ScanOutcome.alreadyComplete:
      case ScanOutcome.manualBlocked:
        if (existing == null) throw StateError('No record for ignored scan');
        return existing;
    }
  }

  Future<void> logScan({
    int? employeeId,
    String? payload,
    required String result,
    required String message,
    required DateTime nowUtc,
    required DateTime localDate,
  }) {
    return _db
        .into(_db.scanEvents)
        .insert(
          ScanEventsCompanion.insert(
            employeeId: Value(employeeId),
            payload: Value(payload),
            result: result,
            message: Value(message),
            scannedAtUtc: nowUtc.toUtc(),
            localDate: localDate,
          ),
        );
  }

  Stream<List<ScanEventWithEmployee>> watchRecentScans({int limit = 12}) {
    final query =
        _db.select(_db.scanEvents).join([
            leftOuterJoin(
              _db.employees,
              _db.employees.id.equalsExp(_db.scanEvents.employeeId),
            ),
          ])
          ..orderBy([OrderingTerm.desc(_db.scanEvents.scannedAtUtc)])
          ..limit(limit);
    return query.watch().map(
      (rows) => rows
          .map(
            (row) => ScanEventWithEmployee(
              row.readTable(_db.scanEvents),
              row.readTableOrNull(_db.employees),
            ),
          )
          .toList(),
    );
  }

  Future<AttendanceRecord> saveManual({
    required Employee employee,
    required DateTime date,
    int? checkInMinutes,
    int? checkOutMinutes,
    String? overrideStatus,
    required String note,
    required int tzOffsetMinutes,
    AttendanceRecord? existing,
  }) async {
    final now = DateTime.now().toUtc();
    final target = existing ?? await forEmployeeDate(employee.id, date);
    final checkInUtc = checkInMinutes == null
        ? null
        : utcFromLocal(date, checkInMinutes, tzOffsetMinutes);
    final checkOutUtc = checkOutMinutes == null
        ? null
        : utcFromLocal(date, checkOutMinutes, tzOffsetMinutes);
    final companion = AttendanceRecordsCompanion(
      employeeId: Value(employee.id),
      checkInUtc: Value(checkInUtc),
      checkOutUtc: Value(checkOutUtc),
      localDate: Value(dateOnly(date)),
      checkInTzOffsetMinutes: Value(tzOffsetMinutes),
      checkOutTzOffsetMinutes: Value(
        checkOutMinutes == null ? null : tzOffsetMinutes,
      ),
      lastScanUtc: Value(now),
      overrideStatus: Value(overrideStatus),
      note: Value(note),
      isManual: const Value(true),
      createdAt: Value(target?.createdAt ?? now),
      updatedAt: Value(now),
    );
    AttendanceRecord saved;
    if (target == null) {
      final id = await _db.into(_db.attendanceRecords).insert(companion);
      saved = await (_db.select(
        _db.attendanceRecords,
      )..where((t) => t.id.equals(id))).getSingle();
      await _writeAudit(
        entityId: saved.id,
        action: 'create',
        previous: null,
        next: saved.toJson(),
      );
    } else {
      await (_db.update(
        _db.attendanceRecords,
      )..where((t) => t.id.equals(target.id))).write(companion);
      saved = await (_db.select(
        _db.attendanceRecords,
      )..where((t) => t.id.equals(target.id))).getSingle();
      await _writeAudit(
        entityId: saved.id,
        action: 'update',
        previous: target.toJson(),
        next: saved.toJson(),
      );
    }
    return saved;
  }

  Future<void> deleteManual(AttendanceRecord record) async {
    await (_db.delete(_db.auditLogs)..where(
          (t) =>
              t.entityType.equals('attendance') & t.entityId.equals(record.id),
        ))
        .go();
    await (_db.delete(
      _db.attendanceRecords,
    )..where((t) => t.id.equals(record.id))).go();
    await _writeAudit(
      entityId: record.id,
      action: 'delete',
      previous: record.toJson(),
      next: null,
    );
  }

  Future<void> _writeAudit({
    required int entityId,
    required String action,
    required Map<String, dynamic>? previous,
    required Map<String, dynamic>? next,
  }) {
    return _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            entityType: 'attendance',
            entityId: Value(entityId),
            action: action,
            previousValue: Value(
              previous == null ? null : jsonEncode(previous),
            ),
            newValue: Value(next == null ? null : jsonEncode(next)),
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Stream<List<AuditLog>> watchAuditLogs({int limit = 200}) {
    return (_db.select(_db.auditLogs)
          ..where((t) => t.entityType.equals('attendance'))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .watch();
  }
}
