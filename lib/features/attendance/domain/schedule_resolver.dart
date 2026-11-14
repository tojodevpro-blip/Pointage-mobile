import '../../../core/db/app_database.dart';
import '../../../core/models/app_settings.dart';
import 'attendance_models.dart';

ScheduleConfig resolveSchedule(Employee employee, AppSettings settings) {
  if (!employee.useCustomSchedule) {
    return ScheduleConfig(
      workDays: settings.workDays.toSet(),
      startMinutes: settings.startMinutes,
      endMinutes: settings.endMinutes,
      breakMinutes: settings.breakMinutes,
      lateToleranceMinutes: settings.lateToleranceMinutes,
      earlyLeaveToleranceMinutes: settings.earlyLeaveToleranceMinutes,
      overtimeThresholdMinutes: settings.overtimeThresholdMinutes,
    );
  }
  final days = employee.workDays
      .split(',')
      .map((e) => int.tryParse(e.trim()))
      .whereType<int>()
      .where((e) => e >= 1 && e <= 7)
      .toSet();
  return ScheduleConfig(
    workDays: days.isEmpty ? settings.workDays.toSet() : days,
    startMinutes: employee.startMinutes,
    endMinutes: employee.endMinutes,
    breakMinutes: employee.breakMinutes,
    lateToleranceMinutes:
        employee.lateToleranceMinutes ?? settings.lateToleranceMinutes,
    earlyLeaveToleranceMinutes:
        employee.earlyLeaveToleranceMinutes ??
        settings.earlyLeaveToleranceMinutes,
    overtimeThresholdMinutes:
        employee.overtimeThresholdMinutes ?? settings.overtimeThresholdMinutes,
  );
}
