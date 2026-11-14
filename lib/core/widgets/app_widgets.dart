import 'dart:io';

import 'package:flutter/material.dart';

import '../theme/app_tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Material(
      color: color ?? tokens.surface,
      borderRadius: BorderRadius.circular(tokens.cardRadius),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(tokens.cardRadius),
        child: Container(
          padding: padding ?? EdgeInsets.all(tokens.spacingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(tokens.cardRadius),
            border: Border.all(color: tokens.border),
          ),
          child: child,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.padding,
  });

  final String title;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: tokens.spacingSm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          ?trailing,
        ],
      ),
    );
  }
}

class InitialsAvatar extends StatelessWidget {
  const InitialsAvatar({
    super.key,
    required this.name,
    this.size = 44,
    this.color,
    this.photoPath,
  });

  final String name;
  final double size;
  final Color? color;
  final String? photoPath;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final photo = photoPath;
    final hasPhoto =
        photo != null && photo.isNotEmpty && File(photo).existsSync();
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((e) => e.isNotEmpty)
        .toList();
    final initials = parts.isEmpty
        ? '?'
        : parts.length == 1
        ? parts.first.substring(0, 1).toUpperCase()
        : '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
              .toUpperCase();
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color ?? tokens.presentSoft,
        borderRadius: BorderRadius.circular(size / 2.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: hasPhoto
          ? Image.file(
              File(photo),
              width: size,
              height: size,
              fit: BoxFit.cover,
            )
          : Text(
              initials,
              style: TextStyle(
                color: tokens.onPresentSoft,
                fontWeight: FontWeight.w700,
                fontSize: size * 0.34,
              ),
            ),
    );
  }
}

class KpiCard extends StatelessWidget {
  const KpiCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    this.softColor,
    this.onTap,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final Color? softColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.all(tokens.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: softColor ?? color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(tokens.smallRadius),
            ),
            child: Icon(icon, size: 20, color: color),
          ),
          SizedBox(height: tokens.spacingSm),
          Text(
            value,
            style: Theme.of(context).textTheme.headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: tokens.muted),
          ),
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Center(
      child: Padding(
        padding: EdgeInsets.all(tokens.spacingXl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(tokens.spacingLg),
              decoration: BoxDecoration(
                color: tokens.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 40, color: tokens.muted),
            ),
            SizedBox(height: tokens.spacingMd),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            if (message != null) ...[
              SizedBox(height: tokens.spacingXs),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium
                    ?.copyWith(color: tokens.muted),
              ),
            ],
            if (action != null) ...[
              SizedBox(height: tokens.spacingLg),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    required this.color,
    required this.background,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class LabeledValue extends StatelessWidget {
  const LabeledValue({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: tokens.muted),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
