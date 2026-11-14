import 'dart:convert';

class AppSettings {
  const AppSettings({
    this.appName = 'PointagePro',
    this.companyName = '',
    this.companyAddress = '',
    this.companyPhone = '',
    this.companyEmail = '',
    this.directorName = '',
    this.logoPath,
    this.languageCode = 'fr',
    this.themeMode = 'system',
    this.primaryColor = 0xFF4F46E5,
    this.accentColor = 0xFF14B8A6,
    this.textScale = 1.0,
    this.cardRadius = 20,
    this.density = 'comfortable',
    this.startMinutes = 8 * 60,
    this.endMinutes = 17 * 60,
    this.breakMinutes = 60,
    this.workDays = const [1, 2, 3, 4, 5],
    this.lateToleranceMinutes = 10,
    this.earlyLeaveToleranceMinutes = 10,
    this.overtimeThresholdMinutes = 8 * 60,
    this.duplicateWindowMinutes = 2,
    this.dayCutoffHour = 4,
    this.updateCheckoutOnLateScan = true,
    this.scanSound = true,
    this.scanVibration = true,
    this.autoReturnSeconds = 3,
    this.pinEnabled = false,
    this.biometricEnabled = false,
    this.autoLockMinutes = 1,
    this.onboardingComplete = false,
  });

  static const Object _unset = Object();

  final String appName;
  final String companyName;
  final String companyAddress;
  final String companyPhone;
  final String companyEmail;
  final String directorName;
  final String? logoPath;
  final String languageCode;
  final String themeMode;
  final int primaryColor;
  final int accentColor;
  final double textScale;
  final double cardRadius;
  final String density;
  final int startMinutes;
  final int endMinutes;
  final int breakMinutes;
  final List<int> workDays;
  final int lateToleranceMinutes;
  final int earlyLeaveToleranceMinutes;
  final int overtimeThresholdMinutes;
  final int duplicateWindowMinutes;
  final int dayCutoffHour;
  final bool updateCheckoutOnLateScan;
  final bool scanSound;
  final bool scanVibration;
  final int autoReturnSeconds;
  final bool pinEnabled;
  final bool biometricEnabled;
  final int autoLockMinutes;
  final bool onboardingComplete;

  bool get hasLock => pinEnabled || biometricEnabled;
  bool get isDark => themeMode == 'dark';

  String get displayCompanyName =>
      companyName.trim().isEmpty ? 'Mon entreprise' : companyName.trim();

  AppSettings copyWith({
    String? appName,
    String? companyName,
    String? companyAddress,
    String? companyPhone,
    String? companyEmail,
    String? directorName,
    Object? logoPath = _unset,
    String? languageCode,
    String? themeMode,
    int? primaryColor,
    int? accentColor,
    double? textScale,
    double? cardRadius,
    String? density,
    int? startMinutes,
    int? endMinutes,
    int? breakMinutes,
    List<int>? workDays,
    int? lateToleranceMinutes,
    int? earlyLeaveToleranceMinutes,
    int? overtimeThresholdMinutes,
    int? duplicateWindowMinutes,
    int? dayCutoffHour,
    bool? updateCheckoutOnLateScan,
    bool? scanSound,
    bool? scanVibration,
    int? autoReturnSeconds,
    bool? pinEnabled,
    bool? biometricEnabled,
    int? autoLockMinutes,
    bool? onboardingComplete,
  }) {
    return AppSettings(
      appName: appName ?? this.appName,
      companyName: companyName ?? this.companyName,
      companyAddress: companyAddress ?? this.companyAddress,
      companyPhone: companyPhone ?? this.companyPhone,
      companyEmail: companyEmail ?? this.companyEmail,
      directorName: directorName ?? this.directorName,
      logoPath: identical(logoPath, _unset)
          ? this.logoPath
          : logoPath as String?,
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      textScale: textScale ?? this.textScale,
      cardRadius: cardRadius ?? this.cardRadius,
      density: density ?? this.density,
      startMinutes: startMinutes ?? this.startMinutes,
      endMinutes: endMinutes ?? this.endMinutes,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      workDays: workDays ?? this.workDays,
      lateToleranceMinutes: lateToleranceMinutes ?? this.lateToleranceMinutes,
      earlyLeaveToleranceMinutes:
          earlyLeaveToleranceMinutes ?? this.earlyLeaveToleranceMinutes,
      overtimeThresholdMinutes:
          overtimeThresholdMinutes ?? this.overtimeThresholdMinutes,
      duplicateWindowMinutes:
          duplicateWindowMinutes ?? this.duplicateWindowMinutes,
      dayCutoffHour: dayCutoffHour ?? this.dayCutoffHour,
      updateCheckoutOnLateScan:
          updateCheckoutOnLateScan ?? this.updateCheckoutOnLateScan,
      scanSound: scanSound ?? this.scanSound,
      scanVibration: scanVibration ?? this.scanVibration,
      autoReturnSeconds: autoReturnSeconds ?? this.autoReturnSeconds,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      autoLockMinutes: autoLockMinutes ?? this.autoLockMinutes,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    );
  }

  Map<String, dynamic> toJson() => {
    'appName': appName,
    'companyName': companyName,
    'companyAddress': companyAddress,
    'companyPhone': companyPhone,
    'companyEmail': companyEmail,
    'directorName': directorName,
    'logoPath': logoPath,
    'languageCode': languageCode,
    'themeMode': themeMode,
    'primaryColor': primaryColor,
    'accentColor': accentColor,
    'textScale': textScale,
    'cardRadius': cardRadius,
    'density': density,
    'startMinutes': startMinutes,
    'endMinutes': endMinutes,
    'breakMinutes': breakMinutes,
    'workDays': workDays,
    'lateToleranceMinutes': lateToleranceMinutes,
    'earlyLeaveToleranceMinutes': earlyLeaveToleranceMinutes,
    'overtimeThresholdMinutes': overtimeThresholdMinutes,
    'duplicateWindowMinutes': duplicateWindowMinutes,
    'dayCutoffHour': dayCutoffHour,
    'updateCheckoutOnLateScan': updateCheckoutOnLateScan,
    'scanSound': scanSound,
    'scanVibration': scanVibration,
    'autoReturnSeconds': autoReturnSeconds,
    'pinEnabled': pinEnabled,
    'biometricEnabled': biometricEnabled,
    'autoLockMinutes': autoLockMinutes,
    'onboardingComplete': onboardingComplete,
  };

  String toJsonString() => jsonEncode(toJson());

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    final defaults = const AppSettings();
    T pick<T>(String key, T fallback) {
      final value = json[key];
      return value is T ? value : fallback;
    }

    final rawDays = json['workDays'];
    final days = rawDays is List
        ? rawDays.whereType<num>().map((e) => e.toInt()).toList()
        : defaults.workDays;
    return AppSettings(
      appName: pick('appName', defaults.appName),
      companyName: pick('companyName', defaults.companyName),
      companyAddress: pick('companyAddress', defaults.companyAddress),
      companyPhone: pick('companyPhone', defaults.companyPhone),
      companyEmail: pick('companyEmail', defaults.companyEmail),
      directorName: pick('directorName', defaults.directorName),
      logoPath: json['logoPath'] is String ? json['logoPath'] as String : null,
      languageCode: pick('languageCode', defaults.languageCode),
      themeMode: pick('themeMode', defaults.themeMode),
      primaryColor: pick('primaryColor', defaults.primaryColor),
      accentColor: pick('accentColor', defaults.accentColor),
      textScale:
          (json['textScale'] is num
                  ? (json['textScale'] as num).toDouble()
                  : defaults.textScale)
              .clamp(0.85, 1.3),
      cardRadius:
          (json['cardRadius'] is num
                  ? (json['cardRadius'] as num).toDouble()
                  : defaults.cardRadius)
              .clamp(8.0, 28.0),
      density: pick('density', defaults.density),
      startMinutes: pick('startMinutes', defaults.startMinutes),
      endMinutes: pick('endMinutes', defaults.endMinutes),
      breakMinutes: pick('breakMinutes', defaults.breakMinutes),
      workDays: days.isEmpty ? defaults.workDays : days,
      lateToleranceMinutes: pick(
        'lateToleranceMinutes',
        defaults.lateToleranceMinutes,
      ),
      earlyLeaveToleranceMinutes: pick(
        'earlyLeaveToleranceMinutes',
        defaults.earlyLeaveToleranceMinutes,
      ),
      overtimeThresholdMinutes: pick(
        'overtimeThresholdMinutes',
        defaults.overtimeThresholdMinutes,
      ),
      duplicateWindowMinutes: pick(
        'duplicateWindowMinutes',
        defaults.duplicateWindowMinutes,
      ),
      dayCutoffHour: pick('dayCutoffHour', defaults.dayCutoffHour),
      updateCheckoutOnLateScan: pick(
        'updateCheckoutOnLateScan',
        defaults.updateCheckoutOnLateScan,
      ),
      scanSound: pick('scanSound', defaults.scanSound),
      scanVibration: pick('scanVibration', defaults.scanVibration),
      autoReturnSeconds: pick('autoReturnSeconds', defaults.autoReturnSeconds),
      pinEnabled: pick('pinEnabled', defaults.pinEnabled),
      biometricEnabled: pick('biometricEnabled', defaults.biometricEnabled),
      autoLockMinutes: pick('autoLockMinutes', defaults.autoLockMinutes),
      onboardingComplete: pick(
        'onboardingComplete',
        defaults.onboardingComplete,
      ),
    );
  }

  factory AppSettings.fromJsonString(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) return AppSettings.fromJson(decoded);
    } catch (_) {}
    return const AppSettings();
  }
}
