import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/db/app_database.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/app_widgets.dart';

class AuditScreen extends ConsumerWidget {
  const AuditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tokens = AppTokens.of(context);
    final logs = ref.watch(auditLogsProvider).valueOrNull ?? const <AuditLog>[];
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.settingsAudit)),
      body: logs.isEmpty
          ? EmptyState(
              icon: Icons.history,
              title: context.l10n.commonNoData,
              message: context.l10n.attendanceNoRecords,
            )
          : ListView.separated(
              padding: EdgeInsets.all(tokens.spacingMd),
              itemCount: logs.length,
              separatorBuilder: (_, _) => SizedBox(height: tokens.spacingSm),
              itemBuilder: (context, index) {
                final log = logs[index];
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            switch (log.action) {
                              'delete' => Icons.delete_outline,
                              'update' => Icons.edit_outlined,
                              _ => Icons.add_circle_outline,
                            },
                            size: 18,
                            color: tokens.primary,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${log.entityType} · ${log.action}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            formatDateTime(
                              log.createdAt.toLocal(),
                              Localizations.localeOf(context).languageCode,
                            ),
                            style: TextStyle(color: tokens.muted, fontSize: 11),
                          ),
                        ],
                      ),
                      if (log.previousValue != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          context.l10n.attendancePreviousValue,
                          style: TextStyle(color: tokens.muted, fontSize: 11),
                        ),
                        Text(
                          _pretty(log.previousValue!),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                      if (log.newValue != null) ...[
                        const SizedBox(height: 6),
                        Text(
                          context.l10n.attendanceNewValue,
                          style: TextStyle(color: tokens.muted, fontSize: 11),
                        ),
                        Text(
                          _pretty(log.newValue!),
                          style: const TextStyle(fontSize: 11),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
    );
  }

  String _pretty(String raw) {
    try {
      final decoded = jsonDecode(raw);
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return raw;
    }
  }
}
