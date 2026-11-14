import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';

import '../../../core/db/app_database.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/security/pin_service.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_widgets.dart';
import 'audit_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _companyName;
  late final TextEditingController _companyAddress;
  late final TextEditingController _companyPhone;
  late final TextEditingController _companyEmail;
  late final TextEditingController _directorName;
  late final TextEditingController _break;
  late final TextEditingController _lateTolerance;
  late final TextEditingController _earlyTolerance;
  late final TextEditingController _overtime;
  late final TextEditingController _duplicateWindow;
  late final TextEditingController _cutoff;
  late final TextEditingController _autoReturn;
  late TimeOfDay _start;
  late TimeOfDay _end;
  late Set<int> _workDays;
  late String _themeMode;
  late String _language;
  late bool _sound;
  late bool _vibration;
  late bool _updateCheckout;
  late int _primaryColor;
  late double _textScale;
  late bool _pinEnabled;
  late bool _biometricEnabled;
  late int _autoLockMinutes;
  String? _logoPath;
  bool _saving = false;

  static const _palette = [
    0xFF4F46E5,
    0xFF2563EB,
    0xFF0D9488,
    0xFF059669,
    0xFFD97706,
    0xFFDC2626,
    0xFFDB2777,
    0xFF7C3AED,
  ];

  @override
  void initState() {
    super.initState();
    final settings = ref.read(settingsProvider);
    _companyName = TextEditingController(text: settings.companyName);
    _companyAddress = TextEditingController(text: settings.companyAddress);
    _companyPhone = TextEditingController(text: settings.companyPhone);
    _companyEmail = TextEditingController(text: settings.companyEmail);
    _directorName = TextEditingController(text: settings.directorName);
    _break = TextEditingController(text: '${settings.breakMinutes}');
    _lateTolerance = TextEditingController(
      text: '${settings.lateToleranceMinutes}',
    );
    _earlyTolerance = TextEditingController(
      text: '${settings.earlyLeaveToleranceMinutes}',
    );
    _overtime = TextEditingController(
      text: '${settings.overtimeThresholdMinutes}',
    );
    _duplicateWindow = TextEditingController(
      text: '${settings.duplicateWindowMinutes}',
    );
    _cutoff = TextEditingController(text: '${settings.dayCutoffHour}');
    _autoReturn = TextEditingController(text: '${settings.autoReturnSeconds}');
    _start = _toTime(settings.startMinutes);
    _end = _toTime(settings.endMinutes);
    _workDays = settings.workDays.toSet();
    _themeMode = settings.themeMode;
    _language = settings.languageCode;
    _sound = settings.scanSound;
    _vibration = settings.scanVibration;
    _updateCheckout = settings.updateCheckoutOnLateScan;
    _primaryColor = settings.primaryColor;
    _textScale = settings.textScale;
    _pinEnabled = settings.pinEnabled;
    _biometricEnabled = settings.biometricEnabled;
    _autoLockMinutes = settings.autoLockMinutes;
    _logoPath = settings.logoPath;
  }

  TimeOfDay _toTime(int minutes) =>
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);

  @override
  void dispose() {
    _companyName.dispose();
    _companyAddress.dispose();
    _companyPhone.dispose();
    _companyEmail.dispose();
    _directorName.dispose();
    _break.dispose();
    _lateTolerance.dispose();
    _earlyTolerance.dispose();
    _overtime.dispose();
    _duplicateWindow.dispose();
    _cutoff.dispose();
    _autoReturn.dispose();
    super.dispose();
  }

  int _int(TextEditingController controller, int fallback) =>
      int.tryParse(controller.text.trim()) ?? fallback;

  Future<String?> _promptPin({
    required String title,
    bool confirm = false,
  }) async {
    final pin = TextEditingController();
    final confirmation = TextEditingController();
    String? error;
    final result = await showDialog<String>(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: pin,
                autofocus: true,
                obscureText: true,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: context.l10n.settingsPin,
                  counterText: '',
                  errorText: error,
                ),
              ),
              if (confirm) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: confirmation,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: InputDecoration(
                    labelText: context.l10n.onboardingConfirmPin,
                    counterText: '',
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(context.l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                final value = pin.text.trim();
                if (!PinService.isValidPin(value)) {
                  setDialogState(
                    () => error = context.l10n.onboardingPinInvalid,
                  );
                  return;
                }
                if (confirm && confirmation.text.trim() != value) {
                  setDialogState(
                    () => error = context.l10n.onboardingPinMismatch,
                  );
                  return;
                }
                Navigator.pop(context, value);
              },
              child: Text(context.l10n.commonValidate),
            ),
          ],
        ),
      ),
    );
    pin.dispose();
    confirmation.dispose();
    return result;
  }

  Future<void> _togglePin(bool enabled) async {
    if (_saving) return;
    final l10n = context.l10n;
    final pinService = ref.read(pinServiceProvider);
    final controller = ref.read(settingsControllerProvider.notifier);
    if (enabled) {
      final pin = await _promptPin(title: l10n.settingsPin, confirm: true);
      if (pin == null) return;
      await pinService.setPin(pin);
      if (!mounted) return;
      setState(() => _pinEnabled = true);
      await controller.patch((settings) => settings.copyWith(pinEnabled: true));
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.settingsPinSet)));
      }
      return;
    }
    if (await pinService.hasPin()) {
      final pin = await _promptPin(title: l10n.settingsPinEnterCurrent);
      if (pin == null) return;
      final valid = await pinService.verifyPin(pin);
      if (!valid) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.settingsPinWrong)));
        }
        return;
      }
    }
    await pinService.clearPin();
    if (!mounted) return;
    setState(() => _pinEnabled = false);
    await controller.patch((settings) => settings.copyWith(pinEnabled: false));
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.settingsPinDisabled)));
    }
  }

  Future<void> _changePin() async {
    final l10n = context.l10n;
    final pinService = ref.read(pinServiceProvider);
    if (await pinService.hasPin()) {
      final current = await _promptPin(title: l10n.settingsPinEnterCurrent);
      if (current == null) return;
      if (!await pinService.verifyPin(current)) {
        if (mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(l10n.settingsPinWrong)));
        }
        return;
      }
    }
    if (!mounted) return;
    final next = await _promptPin(title: l10n.settingsChangePin, confirm: true);
    if (next == null) return;
    await pinService.setPin(next);
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.settingsPinChanged)));
    }
  }

  Future<void> _toggleBiometric(bool enabled) async {
    final l10n = context.l10n;
    if (enabled) {
      if (!_pinEnabled) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(l10n.settingsPin)));
        return;
      }
      final auth = LocalAuthentication();
      bool supported = false;
      try {
        supported =
            await auth.isDeviceSupported() && await auth.canCheckBiometrics;
      } catch (_) {}
      if (!supported) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.onboardingBiometricUnavailable)),
          );
        }
        return;
      }
    }
    setState(() => _biometricEnabled = enabled);
    await ref
        .read(settingsControllerProvider.notifier)
        .patch((settings) => settings.copyWith(biometricEnabled: enabled));
  }

  String _autoLockLabel(BuildContext context, int minutes) => switch (minutes) {
    0 => context.l10n.settingsAutoLockImmediate,
    1 => context.l10n.settingsAutoLock1,
    5 => context.l10n.settingsAutoLock5,
    _ => context.l10n.settingsAutoLock15,
  };

  Future<void> _chooseAutoLock() async {
    final selected = await showDialog<int>(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text(context.l10n.settingsAutoLock),
        children: [
          for (final minutes in const [0, 1, 5, 15])
            ListTile(
              leading: Icon(
                minutes == _autoLockMinutes
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: minutes == _autoLockMinutes
                    ? Theme.of(context).colorScheme.primary
                    : null,
              ),
              title: Text(_autoLockLabel(context, minutes)),
              onTap: () => Navigator.pop(context, minutes),
            ),
        ],
      ),
    );
    if (selected == null || !mounted) return;
    setState(() => _autoLockMinutes = selected);
    await ref
        .read(settingsControllerProvider.notifier)
        .patch((settings) => settings.copyWith(autoLockMinutes: selected));
  }

  Future<void> _backup() async {
    final l10n = context.l10n;
    setState(() => _saving = true);
    try {
      final settings = ref.read(settingsProvider);
      final bytes = await ref.read(backupServiceProvider).exportBytes(settings);
      final stamp = DateTime.now().toUtc().toIso8601String().replaceAll(
        RegExp(r'[:.]'),
        '-',
      );
      final path = await FilePicker.platform.saveFile(
        dialogTitle: l10n.settingsBackup,
        fileName: 'pointagepro_backup_$stamp.json',
        type: FileType.custom,
        allowedExtensions: const ['json'],
        bytes: bytes,
      );
      if (path == null) return;
      final file = File(path);
      try {
        if (!await file.exists() || await file.length() != bytes.length) {
          await file.writeAsBytes(bytes, flush: true);
        }
      } catch (_) {}
      await ref.read(settingsRepositoryProvider).markBackupNow();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.settingsBackupCreated)),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsRestoreFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _restore() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      withData: true,
    );
    if (picked == null || picked.files.isEmpty) return;
    final file = picked.files.single;
    setState(() => _saving = true);
    try {
      final bytes = file.bytes ?? await File(file.path!).readAsBytes();
      await ref.read(backupServiceProvider).restoreBytes(bytes);
      await ref.read(settingsControllerProvider.notifier).load();
      ref.invalidate(activeEmployeesProvider);
      ref.invalidate(recentScansProvider);
      ref.invalidate(holidaysProvider);
      ref.invalidate(auditLogsProvider);
      if (!mounted) return;
      final restored = ref.read(settingsProvider);
      setState(() {
        _companyName.text = restored.companyName;
        _companyAddress.text = restored.companyAddress;
        _companyPhone.text = restored.companyPhone;
        _companyEmail.text = restored.companyEmail;
        _directorName.text = restored.directorName;
        _logoPath = restored.logoPath;
        _pinEnabled = restored.pinEnabled;
        _biometricEnabled = restored.biometricEnabled;
        _autoLockMinutes = restored.autoLockMinutes;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.settingsRestoreSuccess)),
      );
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsInvalidBackup)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _pickLogo(ImageSource source) async {
    final path = await ref
        .read(mediaServiceProvider)
        .pickImage(source: source, prefix: 'logo');
    if (path == null || !mounted) return;
    final previous = _logoPath;
    setState(() => _logoPath = path);
    await ref
        .read(settingsControllerProvider.notifier)
        .patch((settings) => settings.copyWith(logoPath: path));
    if (previous != null && previous != path) {
      await ref.read(mediaServiceProvider).delete(previous);
    }
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.settingsLogoUpdated)));
    }
  }

  Future<void> _removeLogo() async {
    final previous = _logoPath;
    setState(() => _logoPath = null);
    await ref
        .read(settingsControllerProvider.notifier)
        .patch((settings) => settings.copyWith(logoPath: null));
    await ref.read(mediaServiceProvider).delete(previous);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final current = ref.read(settingsProvider);
      final next = current.copyWith(
        companyName: _companyName.text.trim(),
        companyAddress: _companyAddress.text.trim(),
        companyPhone: _companyPhone.text.trim(),
        companyEmail: _companyEmail.text.trim(),
        directorName: _directorName.text.trim(),
        startMinutes: _start.hour * 60 + _start.minute,
        endMinutes: _end.hour * 60 + _end.minute,
        breakMinutes: _int(_break, 60).clamp(0, 240),
        workDays: (_workDays.toList()..sort()),
        lateToleranceMinutes: _int(_lateTolerance, 10).clamp(0, 240),
        earlyLeaveToleranceMinutes: _int(_earlyTolerance, 10).clamp(0, 240),
        overtimeThresholdMinutes: _int(_overtime, 480).clamp(0, 1440),
        duplicateWindowMinutes: _int(_duplicateWindow, 2).clamp(0, 60),
        dayCutoffHour: _int(_cutoff, 4).clamp(0, 23),
        autoReturnSeconds: _int(_autoReturn, 3).clamp(1, 20),
        scanSound: _sound,
        scanVibration: _vibration,
        updateCheckoutOnLateScan: _updateCheckout,
        themeMode: _themeMode,
        languageCode: _language,
        primaryColor: _primaryColor,
        textScale: _textScale,
        logoPath: _logoPath,
        pinEnabled: _pinEnabled,
        biometricEnabled: _biometricEnabled,
        autoLockMinutes: _autoLockMinutes,
        onboardingComplete: true,
      );
      await ref.read(settingsControllerProvider.notifier).update(next);
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(context.l10n.settingsSaved)));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final holidays =
        ref.watch(holidaysProvider).valueOrNull ?? const <Holiday>[];
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.settingsTitle),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(context.l10n.commonSave),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(tokens.spacingMd),
          children: [
            _sectionTitle(context, context.l10n.settingsCompany),
            AppCard(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(tokens.smallRadius),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: _logoPath != null && File(_logoPath!).existsSync()
                          ? Image.file(File(_logoPath!), fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/company_default.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.settingsCompanyLogo,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: [
                            TextButton.icon(
                              onPressed: () => _pickLogo(ImageSource.camera),
                              icon: const Icon(
                                Icons.photo_camera_outlined,
                                size: 18,
                              ),
                              label: Text(context.l10n.commonCamera),
                            ),
                            TextButton.icon(
                              onPressed: () => _pickLogo(ImageSource.gallery),
                              icon: const Icon(
                                Icons.photo_library_outlined,
                                size: 18,
                              ),
                              label: Text(context.l10n.commonGallery),
                            ),
                            if (_logoPath != null)
                              TextButton.icon(
                                onPressed: _removeLogo,
                                icon: const Icon(
                                  Icons.delete_outline,
                                  size: 18,
                                ),
                                label: Text(context.l10n.commonRemove),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _field(_companyName, context.l10n.onboardingCompanyName),
            _field(_companyAddress, 'Adresse'),
            _field(
              _companyPhone,
              context.l10n.employeesPhone,
              keyboardType: TextInputType.phone,
            ),
            _field(
              _companyEmail,
              'E-mail',
              keyboardType: TextInputType.emailAddress,
            ),
            _field(_directorName, 'Nom du directeur'),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsDefaultSchedule),
            Row(
              children: [
                Expanded(
                  child: _timeTile(
                    context,
                    label: context.l10n.commonStart,
                    value: _start,
                    onChanged: (value) => setState(() => _start = value),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _timeTile(
                    context,
                    label: context.l10n.commonEnd,
                    value: _end,
                    onChanged: (value) => setState(() => _end = value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: List.generate(7, (index) {
                final day = index + 1;
                return FilterChip(
                  label: Text(
                    [
                      context.l10n.daysMon,
                      context.l10n.daysTue,
                      context.l10n.daysWed,
                      context.l10n.daysThu,
                      context.l10n.daysFri,
                      context.l10n.daysSat,
                      context.l10n.daysSun,
                    ][index],
                  ),
                  selected: _workDays.contains(day),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _workDays.add(day);
                      } else {
                        _workDays.remove(day);
                      }
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 12),
            _numberField(_break, 'Pause (minutes)'),
            _numberField(_lateTolerance, context.l10n.settingsLateTolerance),
            _numberField(_earlyTolerance, context.l10n.settingsEarlyTolerance),
            _numberField(_overtime, context.l10n.settingsOvertimeThreshold),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsScan),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _sound,
              onChanged: (value) => setState(() => _sound = value),
              title: Text(context.l10n.settingsScanSound),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _vibration,
              onChanged: (value) => setState(() => _vibration = value),
              title: Text(context.l10n.settingsScanVibration),
            ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _updateCheckout,
              onChanged: (value) => setState(() => _updateCheckout = value),
              title: Text(context.l10n.settingsScan),
            ),
            _numberField(_autoReturn, context.l10n.settingsAutoReturn),
            _numberField(
              _duplicateWindow,
              context.l10n.settingsDuplicateWindow,
            ),
            _numberField(_cutoff, context.l10n.settingsDayCutoff),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsAppearance),
            SegmentedButton<String>(
              segments: [
                ButtonSegment(
                  value: 'light',
                  label: Text(context.l10n.settingsLight),
                  icon: const Icon(Icons.light_mode_outlined),
                ),
                ButtonSegment(
                  value: 'dark',
                  label: Text(context.l10n.settingsDark),
                  icon: const Icon(Icons.dark_mode_outlined),
                ),
                ButtonSegment(
                  value: 'system',
                  label: Text(context.l10n.settingsSystem),
                  icon: const Icon(Icons.brightness_auto_outlined),
                ),
              ],
              selected: {_themeMode},
              onSelectionChanged: (value) =>
                  setState(() => _themeMode = value.first),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              initialValue: _language,
              decoration: InputDecoration(
                labelText: context.l10n.settingsLanguage,
              ),
              items: [
                DropdownMenuItem(
                  value: 'fr',
                  child: Text(context.l10n.settingsFrench),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text(context.l10n.settingsEnglish),
                ),
              ],
              onChanged: (value) => setState(() => _language = value ?? 'fr'),
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.settingsPrimaryColor,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _palette.map((color) {
                final selected = _primaryColor == color;
                return InkWell(
                  onTap: () => setState(() => _primaryColor = color),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: Color(color),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected
                            ? Theme.of(context).colorScheme.onSurface
                            : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check, color: Colors.white, size: 20)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 12),
            Text(
              '${context.l10n.settingsFontSize} : ${(_textScale * 100).round()} %',
            ),
            Slider(
              value: _textScale,
              min: 0.85,
              max: 1.3,
              divisions: 9,
              label: '${(_textScale * 100).round()} %',
              onChanged: (value) => setState(() => _textScale = value),
            ),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(
              context,
              context.l10n.settingsHolidays,
              trailing: TextButton.icon(
                onPressed: _addHoliday,
                icon: const Icon(Icons.add),
                label: Text(context.l10n.commonAdd),
              ),
            ),
            if (holidays.isEmpty)
              AppCard(
                child: Text(
                  context.l10n.settingsNoHolidays,
                  style: TextStyle(color: tokens.muted),
                ),
              )
            else
              ...holidays.map(
                (holiday) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: AppCard(
                    padding: EdgeInsets.symmetric(
                      horizontal: tokens.spacingSm,
                      vertical: 4,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.celebration_outlined),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                holiday.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                MaterialLocalizations.of(context)
                                    .formatMediumDate(holiday.date),
                                style: TextStyle(
                                  color: tokens.muted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          tooltip: context.l10n.commonDelete,
                          onPressed: () => _deleteHoliday(holiday),
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsSecurity),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _pinEnabled,
              onChanged: _togglePin,
              secondary: const Icon(Icons.pin_outlined),
              title: Text(context.l10n.settingsPin),
              subtitle: Text(
                _pinEnabled
                    ? context.l10n.settingsPinSet
                    : context.l10n.onboardingEnablePin,
              ),
            ),
            if (_pinEnabled)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.password),
                title: Text(context.l10n.settingsChangePin),
                trailing: const Icon(Icons.chevron_right),
                onTap: _changePin,
              ),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              value: _biometricEnabled,
              onChanged: _toggleBiometric,
              secondary: const Icon(Icons.fingerprint),
              title: Text(context.l10n.settingsBiometric),
              subtitle: Text(context.l10n.onboardingBiometricUnavailable),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.timer_outlined),
              title: Text(context.l10n.settingsAutoLock),
              subtitle: Text(_autoLockLabel(context, _autoLockMinutes)),
              trailing: const Icon(Icons.chevron_right),
              onTap: _chooseAutoLock,
            ),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsData),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.cloud_upload_outlined),
              title: Text(context.l10n.settingsBackup),
              subtitle: Text(context.l10n.settingsBackupBody),
              onTap: _backup,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.restore_outlined),
              title: Text(context.l10n.settingsRestore),
              onTap: _restore,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.history),
              title: Text(context.l10n.settingsAudit),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const AuditScreen())),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                Icons.restart_alt,
                color: Theme.of(context).colorScheme.error,
              ),
              title: Text(
                context.l10n.settingsReset,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
              subtitle: Text(context.l10n.settingsResetConfirm2),
              onTap: _resetApp,
            ),
            SizedBox(height: tokens.spacingLg),
            _sectionTitle(context, context.l10n.settingsAbout),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.appName,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.settingsAboutBody,
                    style: TextStyle(color: tokens.muted),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${context.l10n.commonVersion} 1.1.0',
                    style: TextStyle(color: tokens.muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: tokens.spacingXl),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title, {Widget? trailing}) {
    return SectionHeader(
      title: title,
      trailing: trailing,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }

  Widget _numberField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        validator: (value) {
          if (value == null || value.trim().isEmpty) return null;
          if (int.tryParse(value.trim()) == null) return 'Nombre invalide';
          return null;
        },
      ),
    );
  }

  Widget _timeTile(
    BuildContext context, {
    required String label,
    required TimeOfDay value,
    required ValueChanged<TimeOfDay> onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: value,
        );
        if (picked != null) onChanged(picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(labelText: label),
        child: Row(
          children: [
            Expanded(child: Text(value.format(context))),
            const Icon(Icons.schedule, size: 18),
          ],
        ),
      ),
    );
  }

  Future<void> _addHoliday() async {
    final l10n = context.l10n;
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 3650)),
    );
    if (date == null || !mounted) return;
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsAddHoliday),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: InputDecoration(
            labelText: context.l10n.settingsHolidayName,
            hintText: context.l10n.settingsHolidayNameHint,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, nameController.text.trim()),
            child: Text(context.l10n.commonAdd),
          ),
        ],
      ),
    );
    nameController.dispose();
    if (name == null) return;
    await ref
        .read(holidayRepositoryProvider)
        .add(date, name.isEmpty ? l10n.attendanceStatusHoliday : name);
    if (mounted) {
      ref.invalidate(holidaysProvider);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.settingsHolidayAdded)));
    }
  }

  Future<void> _deleteHoliday(Holiday holiday) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.settingsDeleteHoliday),
        content: Text(holiday.name),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(holidayRepositoryProvider).delete(holiday.id);
    if (mounted) ref.invalidate(holidaysProvider);
  }

  Future<void> _resetApp() async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsResetConfirm1),
        content: Text(l10n.settingsResetConfirm2),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.commonReset),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(databaseProvider).wipe();
    await ref.read(settingsRepositoryProvider).clear();
    await ref.read(pinServiceProvider).clearPin();
    await ref.read(mediaServiceProvider).delete(_logoPath);
    ref.invalidate(activeEmployeesProvider);
    ref.invalidate(recentScansProvider);
    ref.invalidate(holidaysProvider);
    ref.invalidate(auditLogsProvider);
    await ref.read(settingsControllerProvider.notifier).load();
    if (!mounted) return;
    setState(() {
      _companyName.clear();
      _companyAddress.clear();
      _companyPhone.clear();
      _companyEmail.clear();
      _directorName.clear();
      _break.text = '60';
      _lateTolerance.text = '10';
      _earlyTolerance.text = '10';
      _overtime.text = '480';
      _duplicateWindow.text = '2';
      _cutoff.text = '4';
      _autoReturn.text = '3';
      _start = const TimeOfDay(hour: 8, minute: 0);
      _end = const TimeOfDay(hour: 17, minute: 0);
      _workDays = {1, 2, 3, 4, 5};
      _themeMode = 'system';
      _language = 'fr';
      _sound = true;
      _vibration = true;
      _updateCheckout = true;
      _primaryColor = 0xFF4F46E5;
      _textScale = 1.0;
      _pinEnabled = false;
      _biometricEnabled = false;
      _autoLockMinutes = 1;
      _logoPath = null;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(l10n.settingsResetDone)));
  }
}
