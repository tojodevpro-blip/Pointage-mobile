import 'package:flutter/material.dart';

@immutable
class AppTokens extends ThemeExtension<AppTokens> {
  const AppTokens({
    required this.primary,
    required this.onPrimary,
    required this.primaryDark,
    required this.accent,
    required this.onAccent,
    required this.present,
    required this.onPresent,
    required this.presentSoft,
    required this.onPresentSoft,
    required this.late,
    required this.onLate,
    required this.lateSoft,
    required this.onLateSoft,
    required this.absent,
    required this.onAbsent,
    required this.absentSoft,
    required this.onAbsentSoft,
    required this.leave,
    required this.onLeave,
    required this.leaveSoft,
    required this.onLeaveSoft,
    required this.holiday,
    required this.onHoliday,
    required this.holidaySoft,
    required this.onHolidaySoft,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.text,
    required this.muted,
    required this.border,
    required this.shadow,
    required this.cardRadius,
    required this.smallRadius,
    required this.pillRadius,
    required this.spacingXs,
    required this.spacingSm,
    required this.spacingMd,
    required this.spacingLg,
    required this.spacingXl,
    required this.spacingXxl,
    required this.densityFactor,
    required this.chartColors,
  });

  final Color primary;
  final Color onPrimary;
  final Color primaryDark;
  final Color accent;
  final Color onAccent;
  final Color present;
  final Color onPresent;
  final Color presentSoft;
  final Color onPresentSoft;
  final Color late;
  final Color onLate;
  final Color lateSoft;
  final Color onLateSoft;
  final Color absent;
  final Color onAbsent;
  final Color absentSoft;
  final Color onAbsentSoft;
  final Color leave;
  final Color onLeave;
  final Color leaveSoft;
  final Color onLeaveSoft;
  final Color holiday;
  final Color onHoliday;
  final Color holidaySoft;
  final Color onHolidaySoft;
  final Color background;
  final Color surface;
  final Color surfaceVariant;
  final Color text;
  final Color muted;
  final Color border;
  final Color shadow;
  final double cardRadius;
  final double smallRadius;
  final double pillRadius;
  final double spacingXs;
  final double spacingSm;
  final double spacingMd;
  final double spacingLg;
  final double spacingXl;
  final double spacingXxl;
  final double densityFactor;
  final List<Color> chartColors;

  @override
  AppTokens copyWith({
    Color? primary,
    Color? onPrimary,
    Color? primaryDark,
    Color? accent,
    Color? onAccent,
    Color? present,
    Color? onPresent,
    Color? presentSoft,
    Color? onPresentSoft,
    Color? late,
    Color? onLate,
    Color? lateSoft,
    Color? onLateSoft,
    Color? absent,
    Color? onAbsent,
    Color? absentSoft,
    Color? onAbsentSoft,
    Color? leave,
    Color? onLeave,
    Color? leaveSoft,
    Color? onLeaveSoft,
    Color? holiday,
    Color? onHoliday,
    Color? holidaySoft,
    Color? onHolidaySoft,
    Color? background,
    Color? surface,
    Color? surfaceVariant,
    Color? text,
    Color? muted,
    Color? border,
    Color? shadow,
    double? cardRadius,
    double? smallRadius,
    double? pillRadius,
    double? spacingXs,
    double? spacingSm,
    double? spacingMd,
    double? spacingLg,
    double? spacingXl,
    double? spacingXxl,
    double? densityFactor,
    List<Color>? chartColors,
  }) {
    return AppTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      primaryDark: primaryDark ?? this.primaryDark,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      present: present ?? this.present,
      onPresent: onPresent ?? this.onPresent,
      presentSoft: presentSoft ?? this.presentSoft,
      onPresentSoft: onPresentSoft ?? this.onPresentSoft,
      late: late ?? this.late,
      onLate: onLate ?? this.onLate,
      lateSoft: lateSoft ?? this.lateSoft,
      onLateSoft: onLateSoft ?? this.onLateSoft,
      absent: absent ?? this.absent,
      onAbsent: onAbsent ?? this.onAbsent,
      absentSoft: absentSoft ?? this.absentSoft,
      onAbsentSoft: onAbsentSoft ?? this.onAbsentSoft,
      leave: leave ?? this.leave,
      onLeave: onLeave ?? this.onLeave,
      leaveSoft: leaveSoft ?? this.leaveSoft,
      onLeaveSoft: onLeaveSoft ?? this.onLeaveSoft,
      holiday: holiday ?? this.holiday,
      onHoliday: onHoliday ?? this.onHoliday,
      holidaySoft: holidaySoft ?? this.holidaySoft,
      onHolidaySoft: onHolidaySoft ?? this.onHolidaySoft,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      text: text ?? this.text,
      muted: muted ?? this.muted,
      border: border ?? this.border,
      shadow: shadow ?? this.shadow,
      cardRadius: cardRadius ?? this.cardRadius,
      smallRadius: smallRadius ?? this.smallRadius,
      pillRadius: pillRadius ?? this.pillRadius,
      spacingXs: spacingXs ?? this.spacingXs,
      spacingSm: spacingSm ?? this.spacingSm,
      spacingMd: spacingMd ?? this.spacingMd,
      spacingLg: spacingLg ?? this.spacingLg,
      spacingXl: spacingXl ?? this.spacingXl,
      spacingXxl: spacingXxl ?? this.spacingXxl,
      densityFactor: densityFactor ?? this.densityFactor,
      chartColors: chartColors ?? this.chartColors,
    );
  }

  @override
  AppTokens lerp(covariant AppTokens? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    double d(double a, double b) => a + (b - a) * t;
    return AppTokens(
      primary: c(primary, other.primary),
      onPrimary: c(onPrimary, other.onPrimary),
      primaryDark: c(primaryDark, other.primaryDark),
      accent: c(accent, other.accent),
      onAccent: c(onAccent, other.onAccent),
      present: c(present, other.present),
      onPresent: c(onPresent, other.onPresent),
      presentSoft: c(presentSoft, other.presentSoft),
      onPresentSoft: c(onPresentSoft, other.onPresentSoft),
      late: c(late, other.late),
      onLate: c(onLate, other.onLate),
      lateSoft: c(lateSoft, other.lateSoft),
      onLateSoft: c(onLateSoft, other.onLateSoft),
      absent: c(absent, other.absent),
      onAbsent: c(onAbsent, other.onAbsent),
      absentSoft: c(absentSoft, other.absentSoft),
      onAbsentSoft: c(onAbsentSoft, other.onAbsentSoft),
      leave: c(leave, other.leave),
      onLeave: c(onLeave, other.onLeave),
      leaveSoft: c(leaveSoft, other.leaveSoft),
      onLeaveSoft: c(onLeaveSoft, other.onLeaveSoft),
      holiday: c(holiday, other.holiday),
      onHoliday: c(onHoliday, other.onHoliday),
      holidaySoft: c(holidaySoft, other.holidaySoft),
      onHolidaySoft: c(onHolidaySoft, other.onHolidaySoft),
      background: c(background, other.background),
      surface: c(surface, other.surface),
      surfaceVariant: c(surfaceVariant, other.surfaceVariant),
      text: c(text, other.text),
      muted: c(muted, other.muted),
      border: c(border, other.border),
      shadow: c(shadow, other.shadow),
      cardRadius: d(cardRadius, other.cardRadius),
      smallRadius: d(smallRadius, other.smallRadius),
      pillRadius: d(pillRadius, other.pillRadius),
      spacingXs: d(spacingXs, other.spacingXs),
      spacingSm: d(spacingSm, other.spacingSm),
      spacingMd: d(spacingMd, other.spacingMd),
      spacingLg: d(spacingLg, other.spacingLg),
      spacingXl: d(spacingXl, other.spacingXl),
      spacingXxl: d(spacingXxl, other.spacingXxl),
      densityFactor: d(densityFactor, other.densityFactor),
      chartColors: t < 0.5 ? chartColors : other.chartColors,
    );
  }

  static AppTokens of(BuildContext context) {
    final tokens = Theme.of(context).extension<AppTokens>();
    assert(tokens != null, 'AppTokens missing from ThemeData.extensions');
    return tokens!;
  }
}
