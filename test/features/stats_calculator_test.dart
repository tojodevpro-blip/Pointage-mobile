import 'package:flutter_test/flutter_test.dart';
import 'package:pointagepro/features/attendance/domain/attendance_models.dart';
import 'package:pointagepro/features/reports/domain/stats_calculator.dart';

DayStat _day(
  AttendanceStatus status, {
  int worked = 0,
  int late = 0,
  int overtime = 0,
}) {
  return DayStat(
    employeeId: 1,
    date: DateTime(2025, 6, 2),
    status: status,
    workedMinutes: worked,
    overtimeMinutes: overtime,
    lateMinutes: late,
    earlyLeaveMinutes: 0,
  );
}

void main() {
  test('summarizes statuses and rates', () {
    final summary = StatsCalculator.summarize([
      _day(AttendanceStatus.present, worked: 480),
      _day(AttendanceStatus.late, worked: 470, late: 20),
      _day(AttendanceStatus.absent),
      _day(AttendanceStatus.justified),
      _day(AttendanceStatus.holiday),
      _day(AttendanceStatus.dayOff),
    ]);
    expect(summary.presentDays, 2);
    expect(summary.lateDays, 1);
    expect(summary.absentDays, 1);
    expect(summary.justifiedDays, 1);
    expect(summary.holidayDays, 1);
    expect(summary.dayOffDays, 1);
    expect(summary.workedMinutes, 950);
    expect(summary.totalLateMinutes, 20);
    expect(summary.attendanceRate, closeTo(66.666, 0.01));
    expect(summary.punctualityRate, closeTo(50, 0.01));
    expect(summary.averageWorkedMinutes, closeTo(475, 0.01));
  });

  test('handles an empty summary', () {
    final summary = StatsCalculator.summarize(const []);
    expect(summary.isEmpty, isTrue);
    expect(summary.attendanceRate, 0);
    expect(summary.punctualityRate, 0);
    expect(summary.averageArrivalMinute, isNull);
  });
}
