import '../../attendance/domain/attendance_models.dart';

class StatsSummary {
  const StatsSummary({
    required this.presentDays,
    required this.lateDays,
    required this.earlyLeaveDays,
    required this.absentDays,
    required this.justifiedDays,
    required this.leaveDays,
    required this.holidayDays,
    required this.dayOffDays,
    required this.pendingDays,
    required this.workedMinutes,
    required this.overtimeMinutes,
    required this.expectedMinutes,
    required this.totalLateMinutes,
    required this.totalEarlyLeaveMinutes,
    required this.arrivalMinutesSum,
    required this.arrivalCount,
  });

  final int presentDays;
  final int lateDays;
  final int earlyLeaveDays;
  final int absentDays;
  final int justifiedDays;
  final int leaveDays;
  final int holidayDays;
  final int dayOffDays;
  final int pendingDays;
  final int workedMinutes;
  final int overtimeMinutes;
  final int expectedMinutes;
  final int totalLateMinutes;
  final int totalEarlyLeaveMinutes;
  final int arrivalMinutesSum;
  final int arrivalCount;

  int get scheduledDays => presentDays + absentDays + justifiedDays + leaveDays;
  int get accountedDays => presentDays + absentDays;
  double get attendanceRate =>
      accountedDays == 0 ? 0 : (presentDays / accountedDays) * 100;
  double get absenceRate =>
      accountedDays == 0 ? 0 : (absentDays / accountedDays) * 100;
  double get punctualityRate =>
      presentDays == 0 ? 0 : ((presentDays - lateDays) / presentDays) * 100;
  double get averageWorkedMinutes =>
      presentDays == 0 ? 0 : workedMinutes / presentDays;
  double get averageOvertimeMinutes =>
      presentDays == 0 ? 0 : overtimeMinutes / presentDays;
  int? get averageArrivalMinute =>
      arrivalCount == 0 ? null : (arrivalMinutesSum / arrivalCount).round();
  bool get isEmpty =>
      presentDays == 0 &&
      absentDays == 0 &&
      justifiedDays == 0 &&
      leaveDays == 0 &&
      holidayDays == 0 &&
      dayOffDays == 0 &&
      pendingDays == 0;
}

class StatsCalculator {
  StatsCalculator._();

  static StatsSummary summarize(Iterable<DayStat> days) {
    var present = 0,
        late = 0,
        early = 0,
        absent = 0,
        justified = 0,
        leave = 0,
        holiday = 0,
        off = 0,
        pending = 0;
    var worked = 0,
        overtime = 0,
        expected = 0,
        lateMinutes = 0,
        earlyMinutes = 0,
        arrivalSum = 0,
        arrivalCount = 0;
    for (final day in days) {
      switch (day.status) {
        case AttendanceStatus.present:
        case AttendanceStatus.late:
        case AttendanceStatus.leftEarly:
          present++;
          break;
        case AttendanceStatus.absent:
          absent++;
          break;
        case AttendanceStatus.justified:
          justified++;
          break;
        case AttendanceStatus.leave:
          leave++;
          break;
        case AttendanceStatus.holiday:
          holiday++;
          break;
        case AttendanceStatus.dayOff:
          off++;
          break;
        case AttendanceStatus.notYetArrived:
          pending++;
          break;
      }
      if (day.isPresent) {
        if (day.isLate) late++;
        if (day.isEarlyLeave) early++;
        worked += day.workedMinutes;
        overtime += day.overtimeMinutes;
        lateMinutes += day.lateMinutes;
        earlyMinutes += day.earlyLeaveMinutes;
        final arrival = day.arrivalMinute;
        if (arrival != null) {
          arrivalSum += arrival;
          arrivalCount++;
        }
      }
      if (day.status != AttendanceStatus.holiday &&
          day.status != AttendanceStatus.dayOff &&
          day.status != AttendanceStatus.notYetArrived &&
          day.status != AttendanceStatus.leave &&
          day.status != AttendanceStatus.justified) {
        expected += 0;
      }
    }
    return StatsSummary(
      presentDays: present,
      lateDays: late,
      earlyLeaveDays: early,
      absentDays: absent,
      justifiedDays: justified,
      leaveDays: leave,
      holidayDays: holiday,
      dayOffDays: off,
      pendingDays: pending,
      workedMinutes: worked,
      overtimeMinutes: overtime,
      expectedMinutes: expected,
      totalLateMinutes: lateMinutes,
      totalEarlyLeaveMinutes: earlyMinutes,
      arrivalMinutesSum: arrivalSum,
      arrivalCount: arrivalCount,
    );
  }

  static Map<int, StatsSummary> byEmployee(Iterable<DayStat> days) {
    final grouped = <int, List<DayStat>>{};
    for (final day in days) {
      grouped.putIfAbsent(day.employeeId, () => []).add(day);
    }
    return grouped.map((key, value) => MapEntry(key, summarize(value)));
  }

  static Map<String, StatsSummary> byDepartment(Iterable<DayStat> days) {
    final grouped = <String, List<DayStat>>{};
    for (final day in days) {
      final department = day.department.trim().isEmpty
          ? '—'
          : day.department.trim();
      grouped.putIfAbsent(department, () => []).add(day);
    }
    return grouped.map((key, value) => MapEntry(key, summarize(value)));
  }

  static Map<DateTime, StatsSummary> byDay(Iterable<DayStat> days) {
    final grouped = <DateTime, List<DayStat>>{};
    for (final day in days) {
      final key = DateTime(day.date.year, day.date.month, day.date.day);
      grouped.putIfAbsent(key, () => []).add(day);
    }
    return grouped.map((key, value) => MapEntry(key, summarize(value)));
  }

  static double percentChange(double current, double previous) {
    if (previous.abs() < 0.0001) return current.abs() < 0.0001 ? 0 : 100;
    return ((current - previous) / previous.abs()) * 100;
  }

  static double changeFrom(StatsSummary current, StatsSummary previous) =>
      percentChange(current.attendanceRate, previous.attendanceRate);
}
