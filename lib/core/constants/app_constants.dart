class AppConstants {
  AppConstants._();

  static const String appName = 'PointagePro';
  static const String dbFileName = 'pointagepro.sqlite';
  static const String qrPrefix = 'PTG1';
  static const int qrHmacLength = 16;
  static const int scannerDebounceMs = 3000;
  static const int defaultDuplicateWindowMinutes = 2;
  static const int defaultDayCutoffHour = 4;
  static const int defaultStartMinutes = 8 * 60;
  static const int defaultEndMinutes = 17 * 60;
  static const int defaultBreakMinutes = 60;
  static const int defaultLateToleranceMinutes = 10;
  static const int defaultEarlyLeaveToleranceMinutes = 10;
  static const int defaultOvertimeThresholdMinutes = 8 * 60;
  static const String defaultWorkDays = '1,2,3,4,5';
  static const String secretKey = 'qr_hmac_secret';
  static const String pinHashKey = 'lock_pin_hash';
  static const String pinSaltKey = 'lock_pin_salt';
  static const String pinIterationsKey = 'lock_pin_iterations';
  static const int pinIterations = 12000;
  static const int maxTextScale = 130;
  static const int backupVersion = 1;
}
