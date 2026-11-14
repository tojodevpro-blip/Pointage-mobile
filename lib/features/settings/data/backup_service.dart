import 'dart:convert';
import 'dart:typed_data';

import '../../../core/constants/app_constants.dart';
import '../../../core/db/app_database.dart';
import '../../../core/models/app_settings.dart';
import 'settings_repository.dart';

class BackupService {
  BackupService(this._db, this._settingsRepository);

  final AppDatabase _db;
  final SettingsRepository _settingsRepository;

  Future<Uint8List> exportBytes(AppSettings settings) async {
    final employees = await _db.select(_db.employees).get();
    final attendance = await _db.select(_db.attendanceRecords).get();
    final scans = await _db.select(_db.scanEvents).get();
    final audits = await _db.select(_db.auditLogs).get();
    final holidays = await _db.select(_db.holidays).get();
    final payload = <String, dynamic>{
      'version': AppConstants.backupVersion,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'settings': settings.toJson(),
      'employees': employees.map((e) => e.toJson()).toList(),
      'attendance': attendance.map((e) => e.toJson()).toList(),
      'scanEvents': scans.map((e) => e.toJson()).toList(),
      'auditLogs': audits.map((e) => e.toJson()).toList(),
      'holidays': holidays.map((e) => e.toJson()).toList(),
    };
    return Uint8List.fromList(
      utf8.encode(const JsonEncoder.withIndent('  ').convert(payload)),
    );
  }

  Future<void> restoreBytes(List<int> bytes) async {
    final decoded = jsonDecode(utf8.decode(bytes));
    if (decoded is! Map<String, dynamic>) {
      throw const FormatException('Invalid backup');
    }
    final version = decoded['version'];
    if (version is! int || version > AppConstants.backupVersion) {
      throw const FormatException('Unsupported backup version');
    }
    final employees = _list(decoded['employees']);
    final attendance = _list(decoded['attendance']);
    final scans = _list(decoded['scanEvents']);
    final audits = _list(decoded['auditLogs']);
    final holidays = _list(decoded['holidays']);
    final settingsJson = decoded['settings'];
    if (settingsJson is! Map<String, dynamic>) {
      throw const FormatException('Missing settings');
    }

    await _db.transaction(() async {
      await _db.delete(_db.scanEvents).go();
      await _db.delete(_db.auditLogs).go();
      await _db.delete(_db.attendanceRecords).go();
      await _db.delete(_db.holidays).go();
      await _db.delete(_db.employees).go();
      for (final item in employees) {
        await _db
            .into(_db.employees)
            .insert(Employee.fromJson(item).toCompanion(true));
      }
      for (final item in attendance) {
        await _db
            .into(_db.attendanceRecords)
            .insert(AttendanceRecord.fromJson(item).toCompanion(true));
      }
      for (final item in scans) {
        await _db
            .into(_db.scanEvents)
            .insert(ScanEvent.fromJson(item).toCompanion(true));
      }
      for (final item in audits) {
        await _db
            .into(_db.auditLogs)
            .insert(AuditLog.fromJson(item).toCompanion(true));
      }
      for (final item in holidays) {
        await _db
            .into(_db.holidays)
            .insert(Holiday.fromJson(item).toCompanion(true));
      }
    });
    await _settingsRepository.save(AppSettings.fromJson(settingsJson));
    await _settingsRepository.markBackupNow();
  }

  List<Map<String, dynamic>> _list(dynamic value) {
    if (value is! List) return const [];
    return value
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }
}
