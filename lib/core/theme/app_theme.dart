import 'package:flutter/material.dart';

import '../models/app_settings.dart';
import '../utils/color_utils.dart';
import 'app_tokens.dart';

class AppTheme {
  AppTheme._();

  static const Color defaultPresent = Color(0xFF16A34A);
  static const Color defaultLate = Color(0xFFF59E0B);
  static const Color defaultAbsent = Color(0xFFDC2626);
  static const Color defaultLeave = Color(0xFF0EA5E9);
  static const Color defaultHoliday = Color(0xFF8B5CF6);

  static ThemeData build(AppSettings settings, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final primary = Color(settings.primaryColor);
    final accent = Color(settings.accentColor);
    final background = isDark
        ? const Color(0xFF0B1020)
        : const Color(0xFFF8FAFC);
    final surface = isDark ? const Color(0xFF151B2E) : Colors.white;
    final surfaceVariant = isDark
        ? const Color(0xFF1E2740)
        : const Color(0xFFF1F5F9);
    final text = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF0F172A);
    final muted = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    final border = isDark ? const Color(0xFF263049) : const Color(0xFFE2E8F0);
    final densityFactor = switch (settings.density) {
      'compact' => 0.86,
      'spacious' => 1.18,
      _ => 1.0,
    };
    final radius = settings.cardRadius;
    final smallRadius = (radius - 6).clamp(8.0, 18.0).toDouble();

    Color soft(Color fill) =>
        Color.alphaBlend(fill.withValues(alpha: isDark ? 0.22 : 0.13), surface);

    final present = defaultPresent;
    final late = defaultLate;
    final absent = defaultAbsent;
    final leave = defaultLeave;
    final holiday = defaultHoliday;
    final presentSoft = soft(present);
    final lateSoft = soft(late);
    final absentSoft = soft(absent);
    final leaveSoft = soft(leave);
    final holidaySoft = soft(holiday);

    final tokens = AppTokens(
      primary: primary,
      onPrimary: readableOn(primary),
      primaryDark: darken(primary),
      accent: accent,
      onAccent: readableOn(accent),
      present: present,
      onPresent: readableOn(present),
      presentSoft: presentSoft,
      onPresentSoft: readableOn(presentSoft, dark: text),
      late: late,
      onLate: readableOn(late),
      lateSoft: lateSoft,
      onLateSoft: readableOn(lateSoft, dark: text),
      absent: absent,
      onAbsent: readableOn(absent),
      absentSoft: absentSoft,
      onAbsentSoft: readableOn(absentSoft, dark: text),
      leave: leave,
      onLeave: readableOn(leave),
      leaveSoft: leaveSoft,
      onLeaveSoft: readableOn(leaveSoft, dark: text),
      holiday: holiday,
      onHoliday: readableOn(holiday),
      holidaySoft: holidaySoft,
      onHolidaySoft: readableOn(holidaySoft, dark: text),
      background: background,
      surface: surface,
      surfaceVariant: surfaceVariant,
      text: text,
      muted: muted,
      border: border,
      shadow: isDark
          ? Colors.black.withValues(alpha: 0.45)
          : const Color(0x140F172A),
      cardRadius: radius,
      smallRadius: smallRadius,
      pillRadius: 999,
      spacingXs: 4 * densityFactor,
      spacingSm: 8 * densityFactor,
      spacingMd: 12 * densityFactor,
      spacingLg: 16 * densityFactor,
      spacingXl: 24 * densityFactor,
      spacingXxl: 32 * densityFactor,
      densityFactor: densityFactor,
      chartColors: [primary, accent, present, late, leave, holiday, absent],
    );

    final scheme =
        ColorScheme.fromSeed(
          seedColor: primary,
          brightness: brightness,
        ).copyWith(
          primary: primary,
          onPrimary: tokens.onPrimary,
          secondary: accent,
          onSecondary: tokens.onAccent,
          surface: surface,
          onSurface: text,
          error: absent,
          onError: tokens.onAbsent,
          outline: border,
          surfaceContainerLowest: background,
          surfaceContainerLow: surface,
          surfaceContainer: surfaceVariant,
          surfaceContainerHigh: surfaceVariant,
          surfaceContainerHighest: surfaceVariant,
        );

    const numeric = [FontFeature.tabularFigures()];
    final textTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        height: 1.1,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
        fontFeatures: numeric,
      ),
      displayMedium: TextStyle(
        fontSize: 30,
        height: 1.12,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
        fontFeatures: numeric,
      ),
      displaySmall: TextStyle(
        fontSize: 26,
        height: 1.15,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.4,
        fontFeatures: numeric,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.3,
        fontFeatures: numeric,
      ),
      headlineMedium: TextStyle(
        fontSize: 21,
        height: 1.2,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        fontFeatures: numeric,
      ),
      headlineSmall: TextStyle(
        fontSize: 18,
        height: 1.25,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        height: 1.3,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        height: 1.3,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        height: 1.3,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        height: 1.45,
        fontWeight: FontWeight.w400,
        fontFeatures: numeric,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        height: 1.45,
        fontWeight: FontWeight.w400,
        fontFeatures: numeric,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        height: 1.4,
        fontWeight: FontWeight.w400,
        fontFeatures: numeric,
      ),
      labelLarge: TextStyle(
        fontSize: 14,
        height: 1.2,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        height: 1.2,
        fontWeight: FontWeight.w600,
        fontFeatures: numeric,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        height: 1.2,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.2,
        fontFeatures: numeric,
      ),
    ).apply(fontFamily: 'Inter', bodyColor: text, displayColor: text);

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: 'Inter',
      colorScheme: scheme,
      scaffoldBackgroundColor: background,
      visualDensity: switch (settings.density) {
        'compact' => VisualDensity.compact,
        'spacious' => VisualDensity.comfortable,
        _ => VisualDensity.standard,
      },
    );

    final outline = OutlineInputBorder(
      borderRadius: BorderRadius.circular(smallRadius),
      borderSide: BorderSide(color: border),
    );

    return base.copyWith(
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[tokens],
      appBarTheme: AppBarThemeData(
        backgroundColor: background,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
        iconTheme: IconThemeData(color: text, size: 24),
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: border),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        modalBackgroundColor: surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        ),
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: surfaceVariant,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * densityFactor,
          vertical: 14 * densityFactor,
        ),
        border: outline,
        enabledBorder: outline,
        focusedBorder: outline.copyWith(
          borderSide: BorderSide(color: primary, width: 1.6),
        ),
        errorBorder: outline.copyWith(borderSide: BorderSide(color: absent)),
        focusedErrorBorder: outline.copyWith(
          borderSide: BorderSide(color: absent, width: 1.6),
        ),
        labelStyle: TextStyle(color: muted),
        hintStyle: TextStyle(color: muted),
        prefixIconColor: muted,
        suffixIconColor: muted,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: tokens.onPrimary,
          minimumSize: const Size(48, 48),
          padding: EdgeInsets.symmetric(
            horizontal: 20 * densityFactor,
            vertical: 14 * densityFactor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: text,
          minimumSize: const Size(48, 48),
          padding: EdgeInsets.symmetric(
            horizontal: 18 * densityFactor,
            vertical: 14 * densityFactor,
          ),
          side: BorderSide(color: border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          minimumSize: const Size(48, 48),
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(smallRadius),
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: tokens.onPrimary,
        elevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        height: 72 * densityFactor,
        indicatorColor: primary.withValues(alpha: 0.14),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return textTheme.labelSmall?.copyWith(
            color: selected ? primary : muted,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(color: selected ? primary : muted, size: 24);
        }),
      ),
      dividerTheme: DividerThemeData(color: border, thickness: 1, space: 1),
      chipTheme: ChipThemeData(
        backgroundColor: surfaceVariant,
        selectedColor: primary.withValues(alpha: 0.16),
        disabledColor: surfaceVariant,
        side: BorderSide(color: border),
        shape: const StadiumBorder(),
        labelStyle: textTheme.labelMedium ?? const TextStyle(),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: text,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: background),
        actionTextColor: accent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallRadius),
        ),
        elevation: 0,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: muted,
        textColor: text,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16 * densityFactor,
          vertical: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(smallRadius),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),
      iconTheme: IconThemeData(color: text, size: 24),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: text,
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: textTheme.bodySmall?.copyWith(color: background),
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }
}
