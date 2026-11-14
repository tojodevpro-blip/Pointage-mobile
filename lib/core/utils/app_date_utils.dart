import 'package:intl/intl.dart';

enum ReportPeriod { today, week, month, quarter, year, custom }

DateTime dateOnly(DateTime value) =>
    DateTime(value.year, value.month, value.day);

DateTime todayLocal() => dateOnly(DateTime.now());

int minutesOfDay(DateTime value) => value.hour * 60 + value.minute;

String twoDigits(int value) => value.toString().padLeft(2, '0');

String formatMinutes(int minutes) {
  final normalized = minutes < 0 ? 0 : minutes;
  return '${twoDigits(normalized ~/ 60)}:${twoDigits(normalized % 60)}';
}

String formatDuration(int minutes) {
  final normalized = minutes < 0 ? 0 : minutes;
  final h = normalized ~/ 60;
  final m = normalized % 60;
  if (m == 0) return '${h}h';
  return '${h}h${twoDigits(m)}';
}

int currentTzOffsetMinutes() => DateTime.now().timeZoneOffset.inMinutes;

DateTime localDateForScan(DateTime utc, int tzOffsetMinutes, int cutoffHour) {
  final local = utc.toUtc().add(Duration(minutes: tzOffsetMinutes));
  final shifted = local.subtract(Duration(hours: cutoffHour));
  return DateTime(shifted.year, shifted.month, shifted.day);
}

DateTime utcFromLocal(DateTime date, int minutes, int tzOffsetMinutes) {
  final localAsUtc = DateTime.utc(
    date.year,
    date.month,
    date.day,
  ).add(Duration(minutes: minutes));
  return localAsUtc.subtract(Duration(minutes: tzOffsetMinutes));
}

DateTime localTimeFromUtc(DateTime utc, int tzOffsetMinutes) {
  return utc.toUtc().add(Duration(minutes: tzOffsetMinutes));
}

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool isWorkDay(List<int> workDays, DateTime date) =>
    workDays.contains(date.weekday);

int daysInclusive(DateTime start, DateTime end) =>
    dateOnly(end).difference(dateOnly(start)).inDays + 1;

DateTime addDays(DateTime date, int days) =>
    DateTime(date.year, date.month, date.day + days);

DateTime addMonths(DateTime date, int months) =>
    DateTime(date.year, date.month + months, 1);

DateTime startOfWeek(DateTime date) {
  final d = dateOnly(date);
  return addDays(d, -(d.weekday - DateTime.monday));
}

DateTime endOfWeek(DateTime date) => addDays(startOfWeek(date), 6);

DateTime startOfMonth(DateTime date) => DateTime(date.year, date.month, 1);

DateTime endOfMonth(DateTime date) => DateTime(date.year, date.month + 1, 0);

DateTime startOfQuarter(DateTime date) {
  final q = ((date.month - 1) ~/ 3) * 3 + 1;
  return DateTime(date.year, q, 1);
}

DateTime endOfQuarter(DateTime date) {
  final start = startOfQuarter(date);
  return DateTime(start.year, start.month + 3, 0);
}

DateTime startOfYear(DateTime date) => DateTime(date.year, 1, 1);

DateTime endOfYear(DateTime date) => DateTime(date.year, 12, 31);

({DateTime start, DateTime end}) periodRange(
  ReportPeriod period,
  DateTime anchor, {
  DateTime? customStart,
  DateTime? customEnd,
}) {
  final a = dateOnly(anchor);
  switch (period) {
    case ReportPeriod.today:
      return (start: a, end: a);
    case ReportPeriod.week:
      return (start: startOfWeek(a), end: endOfWeek(a));
    case ReportPeriod.month:
      return (start: startOfMonth(a), end: endOfMonth(a));
    case ReportPeriod.quarter:
      return (start: startOfQuarter(a), end: endOfQuarter(a));
    case ReportPeriod.year:
      return (start: startOfYear(a), end: endOfYear(a));
    case ReportPeriod.custom:
      final start = dateOnly(customStart ?? a);
      final end = dateOnly(customEnd ?? start);
      return (
        start: start.isAfter(end) ? end : start,
        end: end.isBefore(start) ? start : end,
      );
  }
}

({DateTime start, DateTime end}) previousRange(
  ReportPeriod period,
  DateTime anchor,
  DateTime start,
  DateTime end,
) {
  switch (period) {
    case ReportPeriod.today:
      final day = addDays(start, -1);
      return (start: day, end: day);
    case ReportPeriod.week:
      return (start: addDays(start, -7), end: addDays(end, -7));
    case ReportPeriod.month:
      final ps = DateTime(start.year, start.month - 1, 1);
      return (start: ps, end: DateTime(ps.year, ps.month + 1, 0));
    case ReportPeriod.quarter:
      final ps = DateTime(start.year, start.month - 3, 1);
      return (start: ps, end: DateTime(ps.year, ps.month + 3, 0));
    case ReportPeriod.year:
      return (
        start: DateTime(start.year - 1, 1, 1),
        end: DateTime(start.year - 1, 12, 31),
      );
    case ReportPeriod.custom:
      final length = daysInclusive(start, end);
      final pe = addDays(start, -1);
      return (start: addDays(pe, -(length - 1)), end: pe);
  }
}

String formatDate(DateTime date, String locale) =>
    DateFormat.yMMMd(locale).format(date);

String formatDateShort(DateTime date, String locale) =>
    DateFormat('d MMM', locale).format(date);

String formatMonthYear(DateTime date, String locale) =>
    DateFormat.yMMMM(locale).format(date);

String formatTime(DateTime date, String locale) =>
    DateFormat.Hm(locale).format(date);

String formatDateTime(DateTime date, String locale) =>
    DateFormat.yMMMd(locale).add_Hm().format(date);

String weekdayShort(DateTime date, String locale) =>
    DateFormat.E(locale).format(date);

String monthName(int month, String locale) =>
    DateFormat.MMMM(locale).format(DateTime(2020, month, 1));

List<DateTime> monthGrid(DateTime month) {
  final first = startOfMonth(month);
  final leading = first.weekday - DateTime.monday;
  final start = addDays(first, -leading);
  return List<DateTime>.generate(42, (i) => addDays(start, i));
}

int? safeInt(String? value) => int.tryParse(value?.trim() ?? '');
