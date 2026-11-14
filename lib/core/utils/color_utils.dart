import 'dart:math' as math;

import 'package:flutter/material.dart';

double relativeLuminance(Color color) {
  double channel(double c) {
    final v = c <= 0.03928
        ? c / 12.92
        : math.pow((c + 0.055) / 1.055, 2.4).toDouble();
    return v;
  }

  return 0.2126 * channel(color.r) +
      0.7152 * channel(color.g) +
      0.0722 * channel(color.b);
}

double contrastRatio(Color a, Color b) {
  final la = relativeLuminance(a);
  final lb = relativeLuminance(b);
  final light = math.max(la, lb);
  final dark = math.min(la, lb);
  return (light + 0.05) / (dark + 0.05);
}

Color readableOn(
  Color background, {
  Color dark = const Color(0xFF0F172A),
  Color light = Colors.white,
}) {
  final darkRatio = contrastRatio(background, dark);
  final lightRatio = contrastRatio(background, light);
  if (darkRatio >= lightRatio) {
    return darkRatio >= 4.5 ? dark : light;
  }
  return lightRatio >= 4.5 ? light : dark;
}

Color darken(Color color, [double amount = 0.18]) {
  final hsl = HSLColor.fromColor(color);
  return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
}

Color lighten(Color color, [double amount = 0.12]) {
  final hsl = HSLColor.fromColor(color);
  return hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0)).toColor();
}

Color colorFromHex(String value, {Color fallback = const Color(0xFF4F46E5)}) {
  final cleaned = value.replaceAll('#', '').trim();
  if (cleaned.length != 6 && cleaned.length != 8) return fallback;
  final parsed = int.tryParse(cleaned, radix: 16);
  if (parsed == null) return fallback;
  if (cleaned.length == 6) return Color(0xFF000000 | parsed);
  return Color(parsed);
}

String colorToHex(Color color) {
  final r = (color.r * 255).round().toRadixString(16).padLeft(2, '0');
  final g = (color.g * 255).round().toRadixString(16).padLeft(2, '0');
  final b = (color.b * 255).round().toRadixString(16).padLeft(2, '0');
  return '#${r.toUpperCase()}${g.toUpperCase()}${b.toUpperCase()}';
}
