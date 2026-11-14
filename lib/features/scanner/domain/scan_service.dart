import '../../../core/db/app_database.dart';
import '../../../core/models/app_settings.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../attendance/data/attendance_repository.dart';
import '../../attendance/domain/attendance_rules.dart';
import '../../attendance/domain/schedule_resolver.dart';
import '../../badges/data/badge_service.dart';

enum ScanResultType {
  checkIn,
  checkOut,
  checkoutUpdated,
  duplicate,
  alreadyComplete,
  manualBlocked,
  malformed,
  forged,
  unknown,
  archived,
  outdated,
  failure,
}

extension ScanResultTypeX on ScanResultType {
  bool get isSuccess =>
      this == ScanResultType.checkIn ||
      this == ScanResultType.checkOut ||
      this == ScanResultType.checkoutUpdated;
  bool get isBadgeError =>
      this == ScanResultType.malformed ||
      this == ScanResultType.forged ||
      this == ScanResultType.unknown ||
      this == ScanResultType.archived ||
      this == ScanResultType.outdated ||
      this == ScanResultType.failure;
}

class ScanResult {
  const ScanResult({
    required this.type,
    required this.late,
    required this.lateMinutes,
    this.employee,
    this.record,
    this.localDate,
    this.error,
  });

  final ScanResultType type;
  final bool late;
  final int lateMinutes;
  final Employee? employee;
  final AttendanceRecord? record;
  final DateTime? localDate;
  final Object? error;
}

class ScanService {
  ScanService({
    required this.badgeService,
    required this.attendanceRepository,
    required this.settings,
    required this.tzOffsetMinutes,
  });

  final BadgeService badgeService;
  final AttendanceRepository attendanceRepository;
  final AppSettings settings;
  final int tzOffsetMinutes;

  Future<ScanResult> handle(String raw, {DateTime? now}) async {
    final nowUtc = (now ?? DateTime.now()).toUtc();
    final localDate = localDateForScan(
      nowUtc,
      tzOffsetMinutes,
      settings.dayCutoffHour,
    );
    try {
      final verification = await badgeService.verify(raw);
      final employee = verification.employee;
      switch (verification.status) {
        case BadgeStatus.malformed:
          await _log(employee?.id, raw, 'malformed', localDate, nowUtc);
          return const ScanResult(
            type: ScanResultType.malformed,
            late: false,
            lateMinutes: 0,
          );
        case BadgeStatus.forged:
          await _log(employee?.id, raw, 'forged', localDate, nowUtc);
          return const ScanResult(
            type: ScanResultType.forged,
            late: false,
            lateMinutes: 0,
          );
        case BadgeStatus.unknown:
          await _log(null, raw, 'unknown', localDate, nowUtc);
          return const ScanResult(
            type: ScanResultType.unknown,
            late: false,
            lateMinutes: 0,
          );
        case BadgeStatus.archived:
          await _log(employee?.id, raw, 'archived', localDate, nowUtc);
          return ScanResult(
            type: ScanResultType.archived,
            late: false,
            lateMinutes: 0,
            employee: employee,
          );
        case BadgeStatus.outdated:
          await _log(employee?.id, raw, 'outdated', localDate, nowUtc);
          return ScanResult(
            type: ScanResultType.outdated,
            late: false,
            lateMinutes: 0,
            employee: employee,
          );
        case BadgeStatus.valid:
          break;
      }
      if (employee == null) {
        await _log(null, raw, 'unknown', localDate, nowUtc);
        return const ScanResult(
          type: ScanResultType.unknown,
          late: false,
          lateMinutes: 0,
        );
      }
      final schedule = resolveSchedule(employee, settings);
      final existing = await attendanceRepository.forEmployeeDate(
        employee.id,
        localDate,
      );
      final decision = decideScan(
        nowUtc: nowUtc,
        tzOffsetMinutes: tzOffsetMinutes,
        cutoffHour: settings.dayCutoffHour,
        schedule: schedule,
        duplicateWindowMinutes: settings.duplicateWindowMinutes,
        updateCheckoutOnLateScan: settings.updateCheckoutOnLateScan,
        existingCheckInUtc: existing?.checkInUtc,
        existingCheckOutUtc: existing?.checkOutUtc,
        lastScanUtc: existing?.lastScanUtc,
        overrideStatus: existing?.overrideStatus,
      );
      ScanResultType type;
      AttendanceRecord? record;
      switch (decision.outcome) {
        case ScanOutcome.checkIn:
          type = ScanResultType.checkIn;
          break;
        case ScanOutcome.checkOut:
          type = ScanResultType.checkOut;
          break;
        case ScanOutcome.checkoutUpdated:
          type = ScanResultType.checkoutUpdated;
          break;
        case ScanOutcome.duplicate:
          type = ScanResultType.duplicate;
          break;
        case ScanOutcome.alreadyComplete:
          type = ScanResultType.alreadyComplete;
          break;
        case ScanOutcome.manualBlocked:
          type = ScanResultType.manualBlocked;
          break;
      }
      if (decision.recordsTime) {
        record = await attendanceRepository.applyScan(
          employee: employee,
          decision: decision,
          nowUtc: nowUtc,
          tzOffsetMinutes: tzOffsetMinutes,
        );
      }
      await _log(employee.id, raw, type.name, decision.localDate, nowUtc);
      return ScanResult(
        type: type,
        late: decision.late && type == ScanResultType.checkIn,
        lateMinutes: decision.lateMinutes,
        employee: employee,
        record: record,
        localDate: decision.localDate,
      );
    } catch (error) {
      try {
        await _log(null, raw, 'failure', localDate, nowUtc);
      } catch (_) {}
      return ScanResult(
        type: ScanResultType.failure,
        late: false,
        lateMinutes: 0,
        error: error,
      );
    }
  }

  Future<void> _log(
    int? employeeId,
    String raw,
    String result,
    DateTime localDate,
    DateTime nowUtc,
  ) {
    return attendanceRepository.logScan(
      employeeId: employeeId,
      payload: raw,
      result: result,
      message: result,
      nowUtc: nowUtc,
      localDate: localDate,
    );
  }
}
