import 'attendance_models.dart';

DayEvaluation evaluateDay(DayInput input) {
  final schedule = input.schedule;
  final workDay = schedule.isWorkDay(input.date);
  final expected = schedule.expectedMinutes;
  final hasCheckIn = input.checkInUtc != null && input.checkInLocal != null;

  AttendanceStatus? overrideStatus = input.overrideStatus;
  if (overrideStatus != null &&
      overrideStatus != AttendanceStatus.justified &&
      overrideStatus != AttendanceStatus.leave &&
      overrideStatus != AttendanceStatus.holiday &&
      overrideStatus != AttendanceStatus.absent) {
    overrideStatus = null;
  }

  if (!hasCheckIn) {
    if (overrideStatus != null) {
      return DayEvaluation(
        status: overrideStatus,
        expectedMinutes: overrideStatus == AttendanceStatus.absent
            ? expected
            : 0,
        workedMinutes: 0,
        overtimeMinutes: 0,
        lateMinutes: 0,
        earlyLeaveMinutes: 0,
        missingCheckout: false,
        isWorkDay: workDay,
        isHoliday: input.isHoliday,
        hasCheckIn: false,
      );
    }
    if (input.isHoliday) {
      return DayEvaluation(
        status: AttendanceStatus.holiday,
        expectedMinutes: 0,
        workedMinutes: 0,
        overtimeMinutes: 0,
        lateMinutes: 0,
        earlyLeaveMinutes: 0,
        missingCheckout: false,
        isWorkDay: workDay,
        isHoliday: true,
        hasCheckIn: false,
      );
    }
    if (!workDay) {
      return DayEvaluation(
        status: AttendanceStatus.dayOff,
        expectedMinutes: 0,
        workedMinutes: 0,
        overtimeMinutes: 0,
        lateMinutes: 0,
        earlyLeaveMinutes: 0,
        missingCheckout: false,
        isWorkDay: false,
        isHoliday: false,
        hasCheckIn: false,
      );
    }
    final threshold = schedule
        .startOn(input.date)
        .add(Duration(minutes: schedule.lateToleranceMinutes));
    final isFuture = _dateOnly(input.date).isAfter(_dateOnly(input.nowLocal));
    final status = isFuture || input.nowLocal.isBefore(threshold)
        ? AttendanceStatus.notYetArrived
        : AttendanceStatus.absent;
    return DayEvaluation(
      status: status,
      expectedMinutes: status == AttendanceStatus.absent ? expected : 0,
      workedMinutes: 0,
      overtimeMinutes: 0,
      lateMinutes: 0,
      earlyLeaveMinutes: 0,
      missingCheckout: false,
      isWorkDay: true,
      isHoliday: false,
      hasCheckIn: false,
    );
  }

  final checkInUtc = input.checkInUtc!;
  final checkInLocal = input.checkInLocal!;
  final checkOutUtc = input.checkOutUtc;
  final checkOutLocal = input.checkOutLocal;

  final start = schedule.startOn(input.date);
  final end = schedule.endOn(input.date);
  final lateThreshold = start.add(
    Duration(minutes: schedule.lateToleranceMinutes),
  );
  final lateMinutes = checkInLocal.isAfter(lateThreshold)
      ? checkInLocal.difference(lateThreshold).inMinutes
      : 0;

  int worked = 0;
  int overtime = 0;
  int earlyLeave = 0;
  var missingCheckout = checkOutUtc == null || checkOutLocal == null;

  if (!missingCheckout) {
    worked = checkOutUtc.difference(checkInUtc).inMinutes;
    if (worked < 0) worked = 0;
    if (worked > schedule.breakMinutes) {
      worked -= schedule.breakMinutes;
    }
    if (worked < 0) worked = 0;
    overtime = (worked - schedule.overtimeThresholdMinutes).clamp(0, 24 * 60);
    final earlyThreshold = end.subtract(
      Duration(minutes: schedule.earlyLeaveToleranceMinutes),
    );
    if (checkOutLocal.isBefore(earlyThreshold)) {
      earlyLeave = earlyThreshold.difference(checkOutLocal).inMinutes;
    }
  }

  final status = lateMinutes > 0
      ? AttendanceStatus.late
      : earlyLeave > 0
      ? AttendanceStatus.leftEarly
      : AttendanceStatus.present;

  return DayEvaluation(
    status: status,
    expectedMinutes: expected,
    workedMinutes: worked,
    overtimeMinutes: overtime,
    lateMinutes: lateMinutes,
    earlyLeaveMinutes: earlyLeave,
    missingCheckout: missingCheckout,
    isWorkDay: workDay,
    isHoliday: input.isHoliday,
    hasCheckIn: true,
  );
}

enum ScanOutcome {
  checkIn,
  checkOut,
  checkoutUpdated,
  duplicate,
  alreadyComplete,
  manualBlocked,
}

class ScanDecision {
  const ScanDecision({
    required this.outcome,
    required this.localDate,
    required this.late,
    required this.lateMinutes,
  });

  final ScanOutcome outcome;
  final DateTime localDate;
  final bool late;
  final int lateMinutes;

  bool get recordsTime =>
      outcome == ScanOutcome.checkIn ||
      outcome == ScanOutcome.checkOut ||
      outcome == ScanOutcome.checkoutUpdated;
}

ScanDecision decideScan({
  required DateTime nowUtc,
  required int tzOffsetMinutes,
  required int cutoffHour,
  required ScheduleConfig schedule,
  required int duplicateWindowMinutes,
  required bool updateCheckoutOnLateScan,
  required DateTime? existingCheckInUtc,
  required DateTime? existingCheckOutUtc,
  required DateTime? lastScanUtc,
  required String? overrideStatus,
}) {
  final localNow = nowUtc.toUtc().add(Duration(minutes: tzOffsetMinutes));
  final localDate = DateTime(
    localNow.subtract(Duration(hours: cutoffHour)).year,
    localNow.subtract(Duration(hours: cutoffHour)).month,
    localNow.subtract(Duration(hours: cutoffHour)).day,
  );
  final start = schedule.startOn(localDate);
  final lateThreshold = start.add(
    Duration(minutes: schedule.lateToleranceMinutes),
  );
  final late = localNow.isAfter(lateThreshold);
  final lateMinutes = late ? localNow.difference(lateThreshold).inMinutes : 0;

  if (overrideStatus != null &&
      overrideStatus != AttendanceStatus.absent.name) {
    return ScanDecision(
      outcome: ScanOutcome.manualBlocked,
      localDate: localDate,
      late: false,
      lateMinutes: 0,
    );
  }

  final isDuplicate =
      lastScanUtc != null &&
      nowUtc.difference(lastScanUtc).inMinutes.abs() < duplicateWindowMinutes;

  if (existingCheckInUtc == null) {
    return ScanDecision(
      outcome: ScanOutcome.checkIn,
      localDate: localDate,
      late: late,
      lateMinutes: lateMinutes,
    );
  }
  if (existingCheckOutUtc == null) {
    if (isDuplicate) {
      return ScanDecision(
        outcome: ScanOutcome.duplicate,
        localDate: localDate,
        late: late,
        lateMinutes: lateMinutes,
      );
    }
    return ScanDecision(
      outcome: ScanOutcome.checkOut,
      localDate: localDate,
      late: late,
      lateMinutes: lateMinutes,
    );
  }
  if (isDuplicate) {
    return ScanDecision(
      outcome: ScanOutcome.duplicate,
      localDate: localDate,
      late: late,
      lateMinutes: lateMinutes,
    );
  }
  if (updateCheckoutOnLateScan) {
    return ScanDecision(
      outcome: ScanOutcome.checkoutUpdated,
      localDate: localDate,
      late: late,
      lateMinutes: lateMinutes,
    );
  }
  return ScanDecision(
    outcome: ScanOutcome.alreadyComplete,
    localDate: localDate,
    late: late,
    lateMinutes: lateMinutes,
  );
}

DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
