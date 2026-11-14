import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/models/app_settings.dart';

class SettingsRepository {
  static const String settingsKey = 'app_settings';
  static const String lastBackupKey = 'last_backup_at';

  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(settingsKey);
    if (raw == null || raw.isEmpty) return const AppSettings();
    return AppSettings.fromJsonString(raw);
  }

  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(settingsKey, settings.toJsonString());
  }

  Future<DateTime?> lastBackupAt() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(lastBackupKey);
    return raw == null ? null : DateTime.tryParse(raw);
  }

  Future<void> markBackupNow() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      lastBackupKey,
      DateTime.now().toUtc().toIso8601String(),
    );
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
