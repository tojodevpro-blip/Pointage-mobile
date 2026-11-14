import '../../../core/utils/app_date_utils.dart';

enum AttendanceStatus {
  present,
  late,
  absent,
  leftEarly,
  justified,
  leave,
  holiday,
  notYetArrived,
  dayOff,
}

extension AttendanceStatusX on AttendanceStatus {
  bool get isPresent =>
      this == AttendanceStatus.present ||
      this == AttendanceStatus.late ||
      this == AttendanceStatus.leftEarly;
  bool get isAbsent => this == AttendanceStatus.absent;
  bool get isExcused =>
      this == AttendanceStatus.justified ||
      this == AttendanceStatus.leave ||
      this == AttendanceStatus.holiday;
  bool get isDayOff => this == AttendanceStatus.dayOff;
  bool get isPending => this == AttendanceStatus.notYetArrived;
  String get storageValue => name;
}

AttendanceStatus? attendanceStatusFromStorage(String? value) {
  if (value == null) return null;
  for (final status in AttendanceStatus.values) {
    if (status.name == value) return status;
  }
  return null;
}

class ScheduleConfig {
  const ScheduleConfig({
    required this.workDays,
    required this.startMinutes,
    required this.endMinutes,
    required this.breakMinutes,
    required this.lateToleranceMinutes,
    required this.earlyLeaveToleranceMinutes,
    required this.overtimeThresholdMinutes,
  });

  final Set<int> workDays;
  final int startMinutes;
  final int endMinutes;
  final int breakMinutes;
  final int lateToleranceMinutes;
  final int earlyLeaveToleranceMinutes;
  final int overtimeThresholdMinutes;

  int get expectedMinutes {
    final raw = endMinutes > startMinutes
        ? endMinutes - startMinutes
        : (1440 - startMinutes) + endMinutes;
    return (raw - breakMinutes).clamp(0, 1440);
  }

  bool isWorkDay(DateTime date) => workDays.contains(date.weekday);

  DateTime startOn(DateTime date) => DateTime(
    date.year,
    date.month,
    date.day,
    startMinutes ~/ 60,
    startMinutes % 60,
  );

  DateTime endOn(DateTime date) {
    final sameDay = DateTime(
      date.year,
      date.month,
      date.day,
      endMinutes ~/ 60,
      endMinutes % 60,
    );
    if (endMinutes > startMinutes) return sameDay;
    return sameDay.add(const Duration(days: 1));
  }
}

class DayInput {
  const DayInput({
    required this.date,
    required this.schedule,
    required this.nowLocal,
    this.checkInUtc,
    this.checkOutUtc,
    this.checkInLocal,
    this.checkOutLocal,
    this.overrideStatus,
    this.isHoliday = false,
  });

  final DateTime date;
  final ScheduleConfig schedule;
  final DateTime nowLocal;
  final DateTime? checkInUtc;
  final DateTime? checkOutUtc;
  final DateTime? checkInLocal;
  final DateTime? checkOutLocal;
  final AttendanceStatus? overrideStatus;
  final bool isHoliday;
}

class DayEvaluation {
  const DayEvaluation({
    required this.status,
    required this.expectedMinutes,
    required this.workedMinutes,
    required this.overtimeMinutes,
    required this.lateMinutes,
    required this.earlyLeaveMinutes,
    required this.missingCheckout,
    required this.isWorkDay,
    required this.isHoliday,
    required this.hasCheckIn,
  });

  final AttendanceStatus status;
  final int expectedMinutes;
  final int workedMinutes;
  final int overtimeMinutes;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final bool missingCheckout;
  final bool isWorkDay;
  final bool isHoliday;
  final bool hasCheckIn;

  bool get isLate => lateMinutes > 0;
  bool get isEarlyLeave => earlyLeaveMinutes > 0;
}

class DayStat {
  const DayStat({
    required this.employeeId,
    required this.date,
    required this.status,
    required this.workedMinutes,
    required this.overtimeMinutes,
    required this.lateMinutes,
    required this.earlyLeaveMinutes,
    this.checkInLocal,
    this.checkOutLocal,
    this.department = '',
  });

  final int employeeId;
  final DateTime date;
  final AttendanceStatus status;
  final int workedMinutes;
  final int overtimeMinutes;
  final int lateMinutes;
  final int earlyLeaveMinutes;
  final DateTime? checkInLocal;
  final DateTime? checkOutLocal;
  final String department;

  bool get isPresent => status.isPresent;
  bool get isLate => lateMinutes > 0 || status == AttendanceStatus.late;
  bool get isEarlyLeave =>
      earlyLeaveMinutes > 0 || status == AttendanceStatus.leftEarly;

  int? get arrivalMinute =>
      checkInLocal == null ? null : minutesOfDay(checkInLocal!);
}
