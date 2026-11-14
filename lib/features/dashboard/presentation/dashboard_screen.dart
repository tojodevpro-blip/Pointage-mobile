import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/models/app_settings.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/presence_chart.dart';
import '../../attendance/data/attendance_repository.dart';
import '../../attendance/domain/attendance_models.dart';
import '../../attendance/domain/attendance_rules.dart';
import '../../attendance/domain/schedule_resolver.dart';
import '../../../core/db/app_database.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = AppTokens.of(context);
    final settings = ref.watch(settingsProvider);
    final employees =
        ref.watch(activeEmployeesProvider).valueOrNull ?? const <Employee>[];
    final recent = ref.watch(recentScansProvider).valueOrNull ?? const [];
    final weekly =
        ref.watch(weeklyRecordsProvider).valueOrNull ??
        const <RecordWithEmployee>[];
    final today = todayLocal();
    final repo = ref.watch(attendanceRepositoryProvider);
    final locale = Localizations.localeOf(context).languageCode;

    final employeeById = {for (final e in employees) e.id: e};
    final weeklyCounts = <String, int>{};
    for (final item in weekly) {
      if (item.record.checkInUtc == null) continue;
      final date = item.record.localDate;
      final key =
          '${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}';
      weeklyCounts[key] = (weeklyCounts[key] ?? 0) + 1;
    }
    final weeklyPoints = List<PresencePoint>.generate(7, (index) {
      final date = addDays(today, index - 6);
      final key =
          '${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}';
      return PresencePoint(
        label: weekdayShort(date, locale),
        value: weeklyCounts[key] ?? 0,
      );
    });

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<RecordWithEmployee>>(
          stream: repo.watchWithEmployee(today, today),
          builder: (context, snapshot) {
            final records = snapshot.data ?? const [];
            var late = 0;
            var onSite = 0;
            var checkedIn = 0;
            final tz = currentTzOffsetMinutes();
            for (final item in records) {
              final record = item.record;
              final employee = employeeById[record.employeeId];
              if (employee == null || record.checkInUtc == null) continue;
              checkedIn++;
              if (record.checkOutUtc == null) onSite++;
              final schedule = resolveSchedule(employee, settings);
              final localIn = localTimeFromUtc(
                record.checkInUtc!,
                record.checkInTzOffsetMinutes == 0
                    ? tz
                    : record.checkInTzOffsetMinutes,
              );
              final localOut = record.checkOutUtc == null
                  ? null
                  : localTimeFromUtc(
                      record.checkOutUtc!,
                      record.checkOutTzOffsetMinutes ?? tz,
                    );
              final evaluation = evaluateDay(
                DayInput(
                  date: record.localDate,
                  schedule: schedule,
                  nowLocal: DateTime.now(),
                  checkInUtc: record.checkInUtc,
                  checkOutUtc: record.checkOutUtc,
                  checkInLocal: localIn,
                  checkOutLocal: localOut,
                  overrideStatus: attendanceStatusFromStorage(
                    record.overrideStatus,
                  ),
                ),
              );
              if (evaluation.isLate) late++;
            }
            final absent = employees.isEmpty
                ? 0
                : (employees.length - checkedIn).clamp(0, employees.length);

            return ListView(
              padding: EdgeInsets.fromLTRB(
                tokens.spacingMd,
                tokens.spacingMd,
                tokens.spacingMd,
                tokens.spacingXl,
              ),
              children: [
                _Header(settings: settings, tokens: tokens),
                SizedBox(height: tokens.spacingLg),
                _ScanHero(onTap: () => context.go('/scanner')),
                SizedBox(height: tokens.spacingLg),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  mainAxisSpacing: tokens.spacingSm,
                  crossAxisSpacing: tokens.spacingSm,
                  childAspectRatio: 1.55,
                  children: [
                    KpiCard(
                      label: context.l10n.dashboardPresent,
                      value: '$checkedIn',
                      icon: Icons.how_to_reg,
                      color: tokens.present,
                      softColor: tokens.presentSoft,
                      onTap: () => context.go('/reports'),
                    ),
                    KpiCard(
                      label: context.l10n.dashboardLate,
                      value: '$late',
                      icon: Icons.schedule,
                      color: tokens.late,
                      softColor: tokens.lateSoft,
                    ),
                    KpiCard(
                      label: context.l10n.dashboardOnSite,
                      value: '$onSite',
                      icon: Icons.badge,
                      color: tokens.primary,
                    ),
                    KpiCard(
                      label: context.l10n.dashboardAbsent,
                      value: '$absent',
                      icon: Icons.person_off,
                      color: tokens.absent,
                      softColor: tokens.absentSoft,
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacingLg),
                SectionHeader(title: context.l10n.dashboardWeekly),
                AppCard(
                  padding: EdgeInsets.fromLTRB(
                    tokens.spacingSm,
                    tokens.spacingMd,
                    tokens.spacingSm,
                    tokens.spacingXs,
                  ),
                  child: SizedBox(
                    height: 170,
                    child: PresenceBarChart(points: weeklyPoints),
                  ),
                ),
                SizedBox(height: tokens.spacingLg),
                SectionHeader(
                  title: context.l10n.dashboardRecentScans,
                  trailing: TextButton(
                    onPressed: () => context.go('/employees'),
                    child: Text(context.l10n.navEmployees),
                  ),
                ),
                if (recent.isEmpty)
                  AppCard(
                    child: Row(
                      children: [
                        Icon(Icons.qr_code_scanner, color: tokens.muted),
                        SizedBox(width: tokens.spacingSm),
                        Expanded(
                          child: Text(
                            context.l10n.dashboardNoScans,
                            style: TextStyle(color: tokens.muted),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  ...recent
                      .take(6)
                      .map(
                        (entry) => Padding(
                          padding: EdgeInsets.only(bottom: tokens.spacingSm),
                          child: _ScanTile(entry: entry, tokens: tokens),
                        ),
                      ),
                if (employees.isEmpty) ...[
                  SizedBox(height: tokens.spacingLg),
                  AppCard(
                    onTap: () => context.go('/employees'),
                    child: Row(
                      children: [
                        Icon(Icons.person_add_alt_1, color: tokens.primary),
                        SizedBox(width: tokens.spacingSm),
                        Expanded(
                          child: Text(
                            context.l10n.dashboardNoEmployeesBody,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.settings, required this.tokens});

  final AppSettings settings;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dateLabel = MaterialLocalizations.of(context).formatFullDate(now);
    final logoPath = settings.logoPath;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(tokens.smallRadius),
          child: SizedBox(
            width: 48,
            height: 48,
            child: logoPath != null && File(logoPath).existsSync()
                ? Image.file(File(logoPath), fit: BoxFit.cover)
                : Image.asset(
                    'assets/images/company_default.png',
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        SizedBox(width: tokens.spacingSm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                settings.displayCompanyName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w800),
              ),
              Text(
                dateLabel,
                style: Theme.of(context).textTheme.bodySmall
                    ?.copyWith(color: tokens.muted),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: context.l10n.navReports,
          onPressed: () => GoRouter.of(context).go('/reports'),
          icon: const Icon(Icons.bar_chart_rounded),
        ),
      ],
    );
  }
}

class _ScanHero extends StatelessWidget {
  const _ScanHero({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Material(
      color: tokens.primary,
      borderRadius: BorderRadius.circular(tokens.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tokens.cardRadius),
        child: Padding(
          padding: EdgeInsets.all(tokens.spacingLg),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.dashboardQuickScan,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: tokens.onPrimary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.appTagline,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: tokens.onPrimary.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: tokens.spacingSm),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: tokens.onPrimary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(tokens.smallRadius),
                ),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: tokens.onPrimary,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScanTile extends StatelessWidget {
  const _ScanTile({required this.entry, required this.tokens});

  final dynamic entry;
  final AppTokens tokens;

  @override
  Widget build(BuildContext context) {
    final event = entry.event;
    final employee = entry.employee;
    final l10n = context.l10n;
    final name = employee == null
        ? l10n.scannerUnknownBadge
        : '${employee.firstName} ${employee.lastName}';
    final result = event.result as String;
    final (label, color, soft) = switch (result) {
      'checkIn' => (l10n.dashboardInAt, tokens.present, tokens.presentSoft),
      'checkOut' => (
        l10n.dashboardOutAt,
        tokens.primary,
        tokens.surfaceVariant,
      ),
      'checkoutUpdated' => (
        l10n.scannerCheckoutUpdated,
        tokens.primary,
        tokens.surfaceVariant,
      ),
      'duplicate' => (l10n.scannerDuplicate, tokens.late, tokens.lateSoft),
      'alreadyComplete' => (
        l10n.scannerAlreadyClockedOut,
        tokens.muted,
        tokens.surfaceVariant,
      ),
      'manualBlocked' => (
        l10n.attendanceManualEntry,
        tokens.late,
        tokens.lateSoft,
      ),
      'archived' => (l10n.commonArchived, tokens.muted, tokens.surfaceVariant),
      'outdated' => (l10n.scannerOutdatedBadge, tokens.late, tokens.lateSoft),
      _ => (l10n.scannerInvalidQr, tokens.absent, tokens.absentSoft),
    };
    final time = TimeOfDay.fromDateTime(
      localTimeFromUtc(
        event.scannedAtUtc as DateTime,
        currentTzOffsetMinutes(),
      ),
    ).format(context);
    return AppCard(
      padding: EdgeInsets.all(tokens.spacingSm),
      child: Row(
        children: [
          InitialsAvatar(name: name, size: 40, photoPath: employee?.photoPath),
          SizedBox(width: tokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(time, style: TextStyle(color: tokens.muted, fontSize: 12)),
              ],
            ),
          ),
          StatusPill(label: label, color: color, background: soft),
        ],
      ),
    );
  }
}
