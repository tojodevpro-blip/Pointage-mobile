import 'package:intl/intl.dart';

String formatPercent(double value, String locale, {int decimals = 0}) {
  final pattern = decimals == 0 ? '#0' : '#0.${'0' * decimals}';
  return '${NumberFormat(pattern, locale).format(value)} %';
}

String formatDecimal(double value, String locale, {int decimals = 1}) {
  final pattern = decimals == 0 ? '#0' : '#0.${'0' * decimals}';
  return NumberFormat(pattern, locale).format(value);
}

String formatInteger(int value, String locale) =>
    NumberFormat.decimalPattern(locale).format(value);

String formatSignedPercent(double value, String locale) {
  final abs = value.abs();
  final formatted = NumberFormat('#0.#', locale).format(abs);
  if (value.abs() < 0.05) return '0';
  return value > 0 ? '+$formatted' : '−$formatted';
}
