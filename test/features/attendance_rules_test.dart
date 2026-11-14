import 'package:flutter_test/flutter_test.dart';
import 'package:pointagepro/features/attendance/domain/attendance_models.dart';
import 'package:pointagepro/features/attendance/domain/attendance_rules.dart';

void main() {
  const schedule = ScheduleConfig(
    workDays: {1, 2, 3, 4, 5},
    startMinutes: 8 * 60,
    endMinutes: 17 * 60,
    breakMinutes: 60,
    lateToleranceMinutes: 10,
    earlyLeaveToleranceMinutes: 10,
    overtimeThresholdMinutes: 8 * 60,
  );
  final monday = DateTime(2025, 6, 2);

  test('on-time arrival is present', () {
    final evaluation = evaluateDay(
      DayInput(
        date: monday,
        schedule: schedule,
        nowLocal: DateTime(2025, 6, 2, 12),
        checkInUtc: DateTime.utc(2025, 6, 2, 7, 5),
        checkInLocal: DateTime(2025, 6, 2, 8, 5),
      ),
    );
    expect(evaluation.status, AttendanceStatus.present);
    expect(evaluation.lateMinutes, 0);
    expect(evaluation.missingCheckout, isTrue);
  });

  test('late arrival and overtime are computed', () {
    final evaluation = evaluateDay(
      DayInput(
        date: monday,
        schedule: schedule,
        nowLocal: DateTime(2025, 6, 2, 18),
        checkInUtc: DateTime.utc(2025, 6, 2, 7, 30),
        checkOutUtc: DateTime.utc(2025, 6, 2, 16, 40),
        checkInLocal: DateTime(2025, 6, 2, 8, 30),
        checkOutLocal: DateTime(2025, 6, 2, 17, 40),
      ),
    );
    expect(evaluation.status, AttendanceStatus.late);
    expect(evaluation.lateMinutes, 20);
    expect(evaluation.workedMinutes, 8 * 60 + 10);
    expect(evaluation.overtimeMinutes, 10);
  });

  test('non-working days are day off', () {
    final sunday = DateTime(2025, 6, 8);
    final evaluation = evaluateDay(
      DayInput(
        date: sunday,
        schedule: schedule,
        nowLocal: DateTime(2025, 6, 8, 12),
      ),
    );
    expect(evaluation.status, AttendanceStatus.dayOff);
  });

  test('missing arrival after tolerance is absent', () {
    final evaluation = evaluateDay(
      DayInput(
        date: monday,
        schedule: schedule,
        nowLocal: DateTime(2025, 6, 2, 12),
      ),
    );
    expect(evaluation.status, AttendanceStatus.absent);
  });

  test('scan decisions alternate arrivals and departures', () {
    final checkIn = decideScan(
      nowUtc: DateTime.utc(2025, 6, 2, 7),
      tzOffsetMinutes: 0,
      cutoffHour: 0,
      schedule: schedule,
      duplicateWindowMinutes: 2,
      updateCheckoutOnLateScan: true,
      existingCheckInUtc: null,
      existingCheckOutUtc: null,
      lastScanUtc: null,
      overrideStatus: null,
    );
    expect(checkIn.outcome, ScanOutcome.checkIn);

    final checkOut = decideScan(
      nowUtc: DateTime.utc(2025, 6, 2, 16),
      tzOffsetMinutes: 0,
      cutoffHour: 0,
      schedule: schedule,
      duplicateWindowMinutes: 2,
      updateCheckoutOnLateScan: true,
      existingCheckInUtc: DateTime.utc(2025, 6, 2, 7),
      existingCheckOutUtc: null,
      lastScanUtc: DateTime.utc(2025, 6, 2, 7),
      overrideStatus: null,
    );
    expect(checkOut.outcome, ScanOutcome.checkOut);

    final duplicate = decideScan(
      nowUtc: DateTime.utc(2025, 6, 2, 16),
      tzOffsetMinutes: 0,
      cutoffHour: 0,
      schedule: schedule,
      duplicateWindowMinutes: 2,
      updateCheckoutOnLateScan: true,
      existingCheckInUtc: DateTime.utc(2025, 6, 2, 7),
      existingCheckOutUtc: null,
      lastScanUtc: DateTime.utc(2025, 6, 2, 15, 59),
      overrideStatus: null,
    );
    expect(duplicate.outcome, ScanOutcome.duplicate);

    final locked = decideScan(
      nowUtc: DateTime.utc(2025, 6, 2, 16),
      tzOffsetMinutes: 0,
      cutoffHour: 0,
      schedule: schedule,
      duplicateWindowMinutes: 2,
      updateCheckoutOnLateScan: true,
      existingCheckInUtc: null,
      existingCheckOutUtc: null,
      lastScanUtc: null,
      overrideStatus: 'justified',
    );
    expect(locked.outcome, ScanOutcome.manualBlocked);
  });
}
