import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/attendance/data/attendance_repository.dart';
import '../../features/badges/data/badge_service.dart';
import '../../features/employees/data/employee_repository.dart';
import '../../features/settings/data/backup_service.dart';
import '../../features/settings/data/holiday_repository.dart';
import '../../features/settings/data/settings_repository.dart';
import '../db/app_database.dart';
import '../media/media_service.dart';
import '../models/app_settings.dart';
import '../security/pin_service.dart';
import '../utils/app_date_utils.dart';
import '../security/qr_signer.dart';
import '../security/secret_store.dart';

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(),
);

final settingsControllerProvider =
    StateNotifierProvider<AppSettingsController, AsyncValue<AppSettings>>((
      ref,
    ) {
      return AppSettingsController(ref.watch(settingsRepositoryProvider));
    });

final settingsProvider = Provider<AppSettings>((ref) {
  return ref.watch(settingsControllerProvider).valueOrNull ??
      const AppSettings();
});

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  return EmployeeRepository(ref.watch(databaseProvider));
});

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepository(ref.watch(databaseProvider));
});

final holidayRepositoryProvider = Provider<HolidayRepository>((ref) {
  return HolidayRepository(ref.watch(databaseProvider));
});

final mediaServiceProvider = Provider<MediaService>((ref) => MediaService());

final backupServiceProvider = Provider<BackupService>((ref) {
  return BackupService(
    ref.watch(databaseProvider),
    ref.watch(settingsRepositoryProvider),
  );
});

final secretStoreProvider = Provider<SecretStore>((ref) => SecretStore());

final pinServiceProvider = Provider<PinService>(
  (ref) => PinService(ref.watch(secretStoreProvider)),
);

final badgeServiceProvider = FutureProvider<BadgeService>((ref) async {
  final secret = await ref.watch(secretStoreProvider).getOrCreateQrSecret();
  return BadgeService(ref.watch(employeeRepositoryProvider), QrSigner(secret));
});

final activeEmployeesProvider = StreamProvider<List<Employee>>((ref) {
  return ref.watch(employeeRepositoryProvider).watchActiveEmployees();
});

final recentScansProvider = StreamProvider<List<ScanEventWithEmployee>>((ref) {
  return ref.watch(attendanceRepositoryProvider).watchRecentScans();
});

final departmentsProvider = FutureProvider<List<String>>((ref) {
  ref.watch(activeEmployeesProvider);
  return ref.watch(employeeRepositoryProvider).departments();
});

final weeklyRecordsProvider = StreamProvider<List<RecordWithEmployee>>((ref) {
  final end = todayLocal();
  final start = addDays(end, -6);
  return ref.watch(attendanceRepositoryProvider).watchWithEmployee(start, end);
});

final holidaysProvider = StreamProvider<List<Holiday>>((ref) {
  return ref.watch(holidayRepositoryProvider).watchAll();
});

final auditLogsProvider = StreamProvider<List<AuditLog>>((ref) {
  return ref.watch(attendanceRepositoryProvider).watchAuditLogs();
});

final refreshProvider = StateProvider<int>((ref) => 0);

class AppSettingsController extends StateNotifier<AsyncValue<AppSettings>> {
  AppSettingsController(this._repository) : super(const AsyncValue.loading()) {
    load();
  }

  final SettingsRepository _repository;

  Future<void> load() async {
    if (!mounted) return;
    state = const AsyncValue.loading();
    try {
      final settings = await _repository.load();
      if (mounted) state = AsyncValue.data(settings);
    } catch (error, stack) {
      if (mounted) state = AsyncValue.error(error, stack);
    }
  }

  Future<void> update(AppSettings next) async {
    state = AsyncValue.data(next);
    await _repository.save(next);
  }

  Future<void> patch(
    AppSettings Function(AppSettings current) transform,
  ) async {
    final current = state.valueOrNull ?? const AppSettings();
    await update(transform(current));
  }

  Future<void> refresh() async {
    final settings = await _repository.load();
    if (mounted) state = AsyncValue.data(settings);
  }
}
