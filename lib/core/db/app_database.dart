import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../constants/app_constants.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [Employees, AttendanceRecords, ScanEvents, AuditLogs, Holidays],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  AppDatabase.open() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await customStatement(
        'CREATE UNIQUE INDEX IF NOT EXISTS idx_attendance_employee_date ON attendance_records(employee_id, local_date)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_attendance_date ON attendance_records(local_date)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_attendance_employee ON attendance_records(employee_id)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_scan_time ON scan_events(scanned_at_utc)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_audit_time ON audit_logs(created_at)',
      );
      await customStatement(
        'CREATE INDEX IF NOT EXISTS idx_employee_archived ON employees(is_archived)',
      );
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );

  Future<void> wipe() async {
    await transaction(() async {
      await delete(scanEvents).go();
      await delete(auditLogs).go();
      await delete(attendanceRecords).go();
      await delete(holidays).go();
      await delete(employees).go();
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, AppConstants.dbFileName));
    return NativeDatabase.createInBackground(file);
  });
}
