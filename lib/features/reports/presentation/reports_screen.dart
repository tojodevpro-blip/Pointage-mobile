import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/db/app_database.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/utils/format_utils.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/presence_chart.dart';
import '../../attendance/domain/attendance_models.dart';
import '../../attendance/domain/attendance_rules.dart';
import '../../attendance/domain/schedule_resolver.dart';
import '../domain/stats_calculator.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  ReportPeriod _period = ReportPeriod.month;
  DateTime _anchor = todayLocal();
  bool _loading = true;
  String? _error;
  List<Employee> _employees = const [];
  List<AttendanceRecord> _records = const [];
  StatsSummary _total = StatsCalculator.summarize(const []);
  Map<int, StatsSummary> _byEmployee = const {};
  Map<DateTime, StatsSummary> _byDayStats = const {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final settings = ref.read(settingsProvider);
      final employeeRepo = ref.read(employeeRepositoryProvider);
      final attendanceRepo = ref.read(attendanceRepositoryProvider);
      final holidayRepo = ref.read(holidayRepositoryProvider);
      final range = periodRange(_period, _anchor);
      final employees = await employeeRepo.activeEmployees();
      final records = await attendanceRepo.recordsInRange(
        range.start,
        range.end,
      );
      final holidays = await holidayRepo.datesInRange(range.start, range.end);
      final recordMap = <String, AttendanceRecord>{};
      for (final record in records) {
        recordMap['${record.employeeId}|${_key(record.localDate)}'] = record;
      }
      final nowLocal = DateTime.now();
      final days = <DayStat>[];
      final totalDays = daysInclusive(range.start, range.end);
      for (final employee in employees) {
        final schedule = resolveSchedule(employee, settings);
        for (var i = 0; i < totalDays; i++) {
          final date = addDays(range.start, i);
          final record = recordMap['${employee.id}|${_key(date)}'];
          final holiday = holidays.contains(dateOnly(date));
          if (record == null && !schedule.isWorkDay(date) && !holiday) continue;
          final tz = record?.checkInTzOffsetMinutes ?? currentTzOffsetMinutes();
          final checkInLocal = record?.checkInUtc == null
              ? null
              : localTimeFromUtc(record!.checkInUtc!, tz);
          final checkOutLocal = record?.checkOutUtc == null
              ? null
              : localTimeFromUtc(
                  record!.checkOutUtc!,
                  record.checkOutTzOffsetMinutes ?? tz,
                );
          final evaluation = evaluateDay(
            DayInput(
              date: date,
              schedule: schedule,
              nowLocal: nowLocal,
              checkInUtc: record?.checkInUtc,
              checkOutUtc: record?.checkOutUtc,
              checkInLocal: checkInLocal,
              checkOutLocal: checkOutLocal,
              overrideStatus: attendanceStatusFromStorage(
                record?.overrideStatus,
              ),
              isHoliday: holiday,
            ),
          );
          days.add(
            DayStat(
              employeeId: employee.id,
              date: date,
              status: evaluation.status,
              workedMinutes: evaluation.workedMinutes,
              overtimeMinutes: evaluation.overtimeMinutes,
              lateMinutes: evaluation.lateMinutes,
              earlyLeaveMinutes: evaluation.earlyLeaveMinutes,
              checkInLocal: checkInLocal,
              checkOutLocal: checkOutLocal,
              department: employee.department,
            ),
          );
        }
      }
      if (!mounted) return;
      setState(() {
        _employees = employees;
        _records = records;
        _total = StatsCalculator.summarize(days);
        _byEmployee = StatsCalculator.byEmployee(days);
        _byDayStats = StatsCalculator.byDay(days);
        _loading = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _error = 'Impossible de charger le rapport.';
        _loading = false;
      });
    }
  }

  String _key(DateTime date) =>
      '${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}';

  Future<void> _pickAnchor() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _anchor,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _anchor = dateOnly(picked));
      await _load();
    }
  }

  Future<void> _shift(int delta) async {
    switch (_period) {
      case ReportPeriod.today:
        _anchor = addDays(_anchor, delta);
        break;
      case ReportPeriod.week:
        _anchor = addDays(_anchor, 7 * delta);
        break;
      case ReportPeriod.month:
        _anchor = addMonths(_anchor, delta);
        break;
      case ReportPeriod.quarter:
        _anchor = addMonths(_anchor, 3 * delta);
        break;
      case ReportPeriod.year:
        _anchor = DateTime(_anchor.year + delta, 1, 1);
        break;
      case ReportPeriod.custom:
        _anchor = addDays(_anchor, delta);
        break;
    }
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final range = periodRange(_period, _anchor);
    final dayEntries = _byDayStats.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    final chartEntries = dayEntries.length > 14
        ? dayEntries.sublist(dayEntries.length - 14)
        : dayEntries;
    final hoursPoints = chartEntries
        .map(
          (entry) => PresencePoint(
            label: formatDateShort(entry.key, locale),
            value: (entry.value.workedMinutes / 60).round(),
          ),
        )
        .toList();
    final onTime = (_total.presentDays - _total.lateDays).clamp(
      0,
      _total.presentDays,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.reportsTitle),
        actions: [
          IconButton(
            tooltip: 'Correction manuelle',
            onPressed: _openManualEntry,
            icon: const Icon(Icons.edit_calendar_outlined),
          ),
          PopupMenuButton<String>(
            tooltip: 'Exporter',
            onSelected: (value) {
              if (value == 'pdf') _exportPdf();
              if (value == 'csv') _exportCsv();
              if (value == 'xlsx') _exportXlsx();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'pdf',
                child: Text(context.l10n.reportsExportPdf),
              ),
              PopupMenuItem(
                value: 'csv',
                child: Text(context.l10n.reportsExportCsv),
              ),
              PopupMenuItem(
                value: 'xlsx',
                child: Text(context.l10n.reportsExportXlsx),
              ),
            ],
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? EmptyState(
              icon: Icons.error_outline,
              title: _error!,
              action: FilledButton(
                onPressed: _load,
                child: Text(context.l10n.commonRetry),
              ),
            )
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: EdgeInsets.all(tokens.spacingMd),
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final entry in {
                          ReportPeriod.today: context.l10n.commonToday,
                          ReportPeriod.week: context.l10n.commonWeek,
                          ReportPeriod.month: context.l10n.commonMonth,
                          ReportPeriod.quarter: context.l10n.commonQuarter,
                          ReportPeriod.year: context.l10n.commonYear,
                        }.entries)
                          Padding(
                            padding: const EdgeInsets.only(right: 6),
                            child: ChoiceChip(
                              label: Text(entry.value),
                              selected: _period == entry.key,
                              onSelected: (_) {
                                setState(() => _period = entry.key);
                                _load();
                              },
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: tokens.spacingSm),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => _shift(-1),
                        icon: const Icon(Icons.chevron_left),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: _pickAnchor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Text(
                                  context.l10n.reportsPeriodLabel(
                                    formatDateShort(range.start, locale),
                                    formatDateShort(range.end, locale),
                                  ),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  formatMonthYear(_anchor, locale),
                                  style: TextStyle(
                                    color: tokens.muted,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => _shift(1),
                        icon: const Icon(Icons.chevron_right),
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacingSm),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: tokens.spacingSm,
                    crossAxisSpacing: tokens.spacingSm,
                    childAspectRatio: 1.7,
                    children: [
                      KpiCard(
                        label: context.l10n.reportsPresenceRate,
                        value: formatPercent(_total.attendanceRate, locale),
                        icon: Icons.fact_check_outlined,
                        color: tokens.present,
                        softColor: tokens.presentSoft,
                      ),
                      KpiCard(
                        label: context.l10n.reportsPunctualityRate,
                        value: formatPercent(_total.punctualityRate, locale),
                        icon: Icons.alarm_on_outlined,
                        color: tokens.primary,
                      ),
                      KpiCard(
                        label: context.l10n.reportsAbsentDays,
                        value: '${_total.absentDays}',
                        icon: Icons.person_off_outlined,
                        color: tokens.absent,
                        softColor: tokens.absentSoft,
                      ),
                      KpiCard(
                        label: context.l10n.reportsTotalHours,
                        value: formatDuration(_total.workedMinutes),
                        icon: Icons.timer_outlined,
                        color: tokens.accent,
                      ),
                      KpiCard(
                        label: context.l10n.reportsOvertimeHours,
                        value: formatDuration(_total.overtimeMinutes),
                        icon: Icons.more_time,
                        color: tokens.leave,
                        softColor: tokens.leaveSoft,
                      ),
                      KpiCard(
                        label: context.l10n.reportsAverageArrival,
                        value: _total.averageArrivalMinute == null
                            ? '—'
                            : formatMinutes(_total.averageArrivalMinute!),
                        icon: Icons.login,
                        color: tokens.holiday,
                        softColor: tokens.holidaySoft,
                      ),
                    ],
                  ),
                  SizedBox(height: tokens.spacingLg),
                  SectionHeader(title: context.l10n.reportsHoursPerDay),
                  AppCard(
                    padding: EdgeInsets.fromLTRB(
                      tokens.spacingSm,
                      tokens.spacingMd,
                      tokens.spacingSm,
                      tokens.spacingXs,
                    ),
                    child: SizedBox(
                      height: 170,
                      child: hoursPoints.isEmpty
                          ? Center(
                              child: Text(
                                context.l10n.reportsNoData,
                                style: TextStyle(color: tokens.muted),
                              ),
                            )
                          : PresenceBarChart(points: hoursPoints),
                    ),
                  ),
                  SizedBox(height: tokens.spacingLg),
                  SectionHeader(title: context.l10n.reportsStatusDistribution),
                  AppCard(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 32,
                              sections: [
                                if (onTime > 0)
                                  PieChartSectionData(
                                    value: onTime.toDouble(),
                                    color: tokens.present,
                                    radius: 28,
                                    title: '$onTime',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (_total.lateDays > 0)
                                  PieChartSectionData(
                                    value: _total.lateDays.toDouble(),
                                    color: tokens.late,
                                    radius: 28,
                                    title: '${_total.lateDays}',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (_total.absentDays > 0)
                                  PieChartSectionData(
                                    value: _total.absentDays.toDouble(),
                                    color: tokens.absent,
                                    radius: 28,
                                    title: '${_total.absentDays}',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                if (_total.leaveDays > 0)
                                  PieChartSectionData(
                                    value: _total.leaveDays.toDouble(),
                                    color: tokens.leave,
                                    radius: 28,
                                    title: '${_total.leaveDays}',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: tokens.spacingSm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _ChartLegend(
                                color: tokens.present,
                                label: context.l10n.attendanceStatusPresent,
                                value: '$onTime',
                              ),
                              _ChartLegend(
                                color: tokens.late,
                                label: context.l10n.attendanceStatusLate,
                                value: '${_total.lateDays}',
                              ),
                              _ChartLegend(
                                color: tokens.absent,
                                label: context.l10n.attendanceStatusAbsent,
                                value: '${_total.absentDays}',
                              ),
                              _ChartLegend(
                                color: tokens.leave,
                                label: context.l10n.attendanceStatusLeave,
                                value: '${_total.leaveDays}',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: tokens.spacingLg),
                  SectionHeader(title: context.l10n.employeesTitle),
                  if (_employees.isEmpty)
                    AppCard(child: Text(context.l10n.employeesEmptyTitle))
                  else
                    ..._employees.map((employee) {
                      final stats =
                          _byEmployee[employee.id] ??
                          StatsCalculator.summarize(const []);
                      return Padding(
                        padding: EdgeInsets.only(bottom: tokens.spacingSm),
                        child: AppCard(
                          child: Row(
                            children: [
                              InitialsAvatar(
                                name:
                                    '${employee.firstName} ${employee.lastName}',
                                size: 44,
                              ),
                              SizedBox(width: tokens.spacingSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${employee.firstName} ${employee.lastName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      '${stats.presentDays} ${l10n.attendanceStatusPresent} · ${stats.lateDays} ${l10n.attendanceStatusLate} · ${formatDuration(stats.workedMinutes)}',
                                      style: TextStyle(
                                        color: tokens.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                formatPercent(stats.attendanceRate, locale),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: stats.attendanceRate >= 90
                                      ? tokens.present
                                      : tokens.late,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  SizedBox(height: tokens.spacingLg),
                  SectionHeader(title: context.l10n.reportsTimeline),
                  if (_records.isEmpty)
                    AppCard(child: Text(context.l10n.attendanceNoRecords))
                  else
                    ..._records.reversed.take(20).map((record) {
                      final employee = _employees
                          .where((e) => e.id == record.employeeId)
                          .firstOrNull;
                      final name = employee == null
                          ? l10n.employeesTitle
                          : '${employee.firstName} ${employee.lastName}';
                      final tz = record.checkInTzOffsetMinutes == 0
                          ? currentTzOffsetMinutes()
                          : record.checkInTzOffsetMinutes;
                      final checkIn = record.checkInUtc == null
                          ? '—'
                          : formatTime(
                              localTimeFromUtc(record.checkInUtc!, tz),
                              locale,
                            );
                      final checkOut = record.checkOutUtc == null
                          ? '—'
                          : formatTime(
                              localTimeFromUtc(
                                record.checkOutUtc!,
                                record.checkOutTzOffsetMinutes ?? tz,
                              ),
                              locale,
                            );
                      return Padding(
                        padding: EdgeInsets.only(bottom: tokens.spacingSm),
                        child: AppCard(
                          padding: EdgeInsets.all(tokens.spacingSm),
                          child: Row(
                            children: [
                              InitialsAvatar(name: name, size: 38),
                              SizedBox(width: tokens.spacingSm),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      formatDateShort(record.localDate, locale),
                                      style: TextStyle(
                                        color: tokens.muted,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '$checkIn → $checkOut',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                ],
              ),
            ),
    );
  }

  Future<void> _openManualEntry() async {
    if (_employees.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.employeesEmptyBody)));
      return;
    }
    final saved = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) =>
          _ManualEntrySheet(employees: _employees, initialDate: _anchor),
    );
    if (saved == true) await _load();
  }

  Future<void> _exportXlsx() async {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final range = periodRange(_period, _anchor);
    final excel = Excel.createExcel();
    final sheet = excel['Rapport'];
    sheet.appendRow([
      TextCellValue(l10n.employeesLastName),
      TextCellValue(l10n.employeesFirstName),
      TextCellValue(l10n.employeesDepartment),
      TextCellValue(l10n.reportsWorkedDays),
      TextCellValue(l10n.reportsLateDays),
      TextCellValue(l10n.reportsAbsentDays),
      TextCellValue(l10n.reportsTotalHours),
      TextCellValue(l10n.reportsOvertimeHours),
      TextCellValue(l10n.reportsPresenceRate),
    ]);
    for (final employee in _employees) {
      final stats =
          _byEmployee[employee.id] ?? StatsCalculator.summarize(const []);
      sheet.appendRow([
        TextCellValue(employee.lastName),
        TextCellValue(employee.firstName),
        TextCellValue(employee.department),
        IntCellValue(stats.presentDays),
        IntCellValue(stats.lateDays),
        IntCellValue(stats.absentDays),
        TextCellValue(formatDuration(stats.workedMinutes)),
        TextCellValue(formatDuration(stats.overtimeMinutes)),
        TextCellValue(formatPercent(stats.attendanceRate, locale)),
      ]);
    }
    final bytes = excel.save();
    if (bytes == null) return;
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/rapport_pointage.xlsx');
    await file.writeAsBytes(bytes, flush: true);
    await Share.shareXFiles(
      [
        XFile(
          file.path,
          mimeType: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
        ),
      ],
      subject:
          '${l10n.reportsTitle} ${formatDateShort(range.start, locale)} - ${formatDateShort(range.end, locale)}',
    );
  }

  Future<void> _exportCsv() async {
    final l10n = context.l10n;
    final locale = Localizations.localeOf(context).languageCode;
    final range = periodRange(_period, _anchor);
    final rows = <List<dynamic>>[
      [
        l10n.employeesLastName,
        l10n.employeesFirstName,
        l10n.employeesDepartment,
        l10n.reportsWorkedDays,
        l10n.reportsLateDays,
        l10n.reportsAbsentDays,
        l10n.reportsTotalHours,
        l10n.reportsOvertimeHours,
        l10n.reportsPresenceRate,
      ],
    ];
    for (final employee in _employees) {
      final stats =
          _byEmployee[employee.id] ?? StatsCalculator.summarize(const []);
      rows.add([
        employee.lastName,
        employee.firstName,
        employee.department,
        stats.presentDays,
        stats.lateDays,
        stats.absentDays,
        formatDuration(stats.workedMinutes),
        formatDuration(stats.overtimeMinutes),
        formatPercent(stats.attendanceRate, locale),
      ]);
    }
    final csv = const ListToCsvConverter(fieldDelimiter: ';').convert(rows);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/rapport_pointage.csv');
    await file.writeAsString('\uFEFF$csv', encoding: utf8);
    await Share.shareXFiles(
      [XFile(file.path, mimeType: 'text/csv')],
      subject:
          '${l10n.reportsTitle} ${formatDateShort(range.start, locale)} - ${formatDateShort(range.end, locale)}',
    );
  }

  Future<void> _exportPdf() async {
    final l10n = context.l10n;
    final settings = ref.read(settingsProvider);
    final locale = Localizations.localeOf(context).languageCode;
    final range = periodRange(_period, _anchor);
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      settings.companyName.trim().isEmpty
                          ? 'PointagePro'
                          : settings.companyName,
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 2),
                    pw.Text(
                      l10n.reportsTitle,
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                    pw.Text(
                      l10n.reportsPeriodLabel(
                        formatDateShort(range.start, locale),
                        formatDateShort(range.end, locale),
                      ),
                      style: const pw.TextStyle(fontSize: 10),
                    ),
                  ],
                ),
              ),
              pw.Text(
                formatDateTime(DateTime.now(), locale),
                style: const pw.TextStyle(
                  fontSize: 9,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                '${l10n.reportsPresenceRate} : ${formatPercent(_total.attendanceRate, locale)}',
              ),
              pw.Text(
                '${l10n.reportsPunctualityRate} : ${formatPercent(_total.punctualityRate, locale)}',
              ),
              pw.Text(
                '${l10n.reportsTotalHours} : ${formatDuration(_total.workedMinutes)}',
              ),
              pw.Text('${l10n.reportsAbsentDays} : ${_total.absentDays}'),
            ],
          ),
          pw.SizedBox(height: 16),
          pw.TableHelper.fromTextArray(
            headers: [
              l10n.employeesTitle,
              l10n.employeesDepartment,
              l10n.attendanceStatusPresent,
              l10n.reportsLateDays,
              l10n.reportsAbsentDays,
              l10n.reportsTotalHours,
              l10n.reportsPresenceRate,
            ],
            data: _employees.map((employee) {
              final stats =
                  _byEmployee[employee.id] ??
                  StatsCalculator.summarize(const []);
              return [
                '${employee.firstName} ${employee.lastName}',
                employee.department,
                '${stats.presentDays}',
                '${stats.lateDays}',
                '${stats.absentDays}',
                formatDuration(stats.workedMinutes),
                formatPercent(stats.attendanceRate, locale),
              ];
            }).toList(),
            headerStyle: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 9,
            ),
            cellStyle: const pw.TextStyle(fontSize: 8),
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerLeft,
              2: pw.Alignment.center,
              3: pw.Alignment.center,
              4: pw.Alignment.center,
              5: pw.Alignment.center,
              6: pw.Alignment.center,
            },
          ),
        ],
      ),
    );
    final bytes = await doc.save();
    await Printing.sharePdf(
      bytes: bytes,
      filename:
          'rapport_${formatDateShort(range.start, locale)}_${formatDateShort(range.end, locale)}.pdf',
    );
  }
}

class _ChartLegend extends StatelessWidget {
  const _ChartLegend({
    required this.color,
    required this.label,
    required this.value,
  });

  final Color color;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: tokens.muted, fontSize: 12),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _ManualEntrySheet extends ConsumerStatefulWidget {
  const _ManualEntrySheet({required this.employees, required this.initialDate});

  final List<Employee> employees;
  final DateTime initialDate;

  @override
  ConsumerState<_ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends ConsumerState<_ManualEntrySheet> {
  late Employee _employee = widget.employees.first;
  late DateTime _date = widget.initialDate;
  TimeOfDay? _checkIn;
  TimeOfDay? _checkOut;
  String? _status;
  final TextEditingController _note = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final repo = ref.read(attendanceRepositoryProvider);
      final existing = await repo.forEmployeeDate(_employee.id, _date);
      await repo.saveManual(
        employee: _employee,
        date: _date,
        checkInMinutes: _checkIn == null
            ? null
            : _checkIn!.hour * 60 + _checkIn!.minute,
        checkOutMinutes: _checkOut == null
            ? null
            : _checkOut!.hour * 60 + _checkOut!.minute,
        overrideStatus: _status,
        note: _note.text.trim(),
        tzOffsetMinutes: currentTzOffsetMinutes(),
        existing: existing,
      );
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(tokens.spacingMd),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Correction manuelle',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<Employee>(
            initialValue: _employee,
            decoration: InputDecoration(
              labelText: context.l10n.attendanceSelectEmployee,
            ),
            items: [
              for (final employee in widget.employees)
                DropdownMenuItem(
                  value: employee,
                  child: Text('${employee.firstName} ${employee.lastName}'),
                ),
            ],
            onChanged: (value) {
              if (value != null) setState(() => _employee = value);
            },
          ),
          const SizedBox(height: 12),
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(context.l10n.attendanceSelectDate),
            subtitle: Text(
              MaterialLocalizations.of(context).formatFullDate(_date),
            ),
            trailing: const Icon(Icons.calendar_today_outlined),
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2000),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) setState(() => _date = picked);
            },
          ),
          Row(
            children: [
              Expanded(
                child: _OptionalTimeField(
                  label: context.l10n.attendanceCheckIn,
                  value: _checkIn,
                  onChanged: (value) => setState(() => _checkIn = value),
                  onClear: () => setState(() => _checkIn = null),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OptionalTimeField(
                  label: context.l10n.attendanceCheckOut,
                  value: _checkOut,
                  onChanged: (value) => setState(() => _checkOut = value),
                  onClear: () => setState(() => _checkOut = null),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _status ?? '',
            decoration: InputDecoration(
              labelText: context.l10n.attendanceStatus,
            ),
            items: [
              DropdownMenuItem(
                value: '',
                child: Text(context.l10n.attendanceStatusNotYet),
              ),
              DropdownMenuItem(
                value: 'justified',
                child: Text(context.l10n.attendanceStatusJustified),
              ),
              DropdownMenuItem(
                value: 'leave',
                child: Text(context.l10n.attendanceStatusLeave),
              ),
              DropdownMenuItem(
                value: 'holiday',
                child: Text(context.l10n.attendanceStatusHoliday),
              ),
              DropdownMenuItem(
                value: 'absent',
                child: Text(context.l10n.attendanceStatusAbsent),
              ),
            ],
            onChanged: (value) => setState(
              () => _status = (value == null || value.isEmpty) ? null : value,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _note,
            maxLines: 2,
            decoration: InputDecoration(labelText: context.l10n.attendanceNote),
          ),
          SizedBox(height: tokens.spacingMd),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: _saving
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(context.l10n.attendanceAddRecord),
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionalTimeField extends StatelessWidget {
  const _OptionalTimeField({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.onClear,
  });

  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay> onChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: value ?? const TimeOfDay(hour: 8, minute: 0),
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: value == null
              ? const Icon(Icons.schedule, size: 18)
              : IconButton(
                  onPressed: onClear,
                  icon: const Icon(Icons.clear, size: 18),
                ),
        ),
        child: Text(value?.format(context) ?? 'Non saisi'),
      ),
    );
  }
}
