import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import '../l10n/l10n.dart';
import '../models/app_settings.dart';
import '../providers/app_providers.dart';
import '../theme/app_tokens.dart';

class AppLockGate extends ConsumerStatefulWidget {
  const AppLockGate({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<AppLockGate> createState() => _AppLockGateState();
}

class _AppLockGateState extends ConsumerState<AppLockGate>
    with WidgetsBindingObserver {
  bool _locked = true;
  DateTime? _pausedAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _pausedAt = DateTime.now();
      return;
    }
    if (state != AppLifecycleState.resumed) return;
    final pausedAt = _pausedAt;
    _pausedAt = null;
    if (pausedAt == null) return;
    final settings = ref.read(settingsProvider);
    if (!settings.hasLock) return;
    final elapsed = DateTime.now().difference(pausedAt);
    final delay = Duration(minutes: settings.autoLockMinutes.clamp(0, 1440));
    if (settings.autoLockMinutes == 0 || elapsed >= delay) {
      if (mounted) setState(() => _locked = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    ref.listen(settingsControllerProvider, (previous, next) {
      final value = next.valueOrNull;
      if (value == null || !mounted) return;
      if (!value.hasLock && _locked) {
        setState(() => _locked = false);
      } else if (value.hasLock && previous?.valueOrNull?.hasLock != true) {
        setState(() => _locked = true);
      }
    });
    final showLock = settings.hasLock && _locked;
    return Stack(
      fit: StackFit.expand,
      children: [
        widget.child,
        if (showLock)
          Positioned.fill(
            child: LockScreen(
              settings: settings,
              onUnlocked: () {
                if (mounted) setState(() => _locked = false);
              },
            ),
          ),
      ],
    );
  }
}

class LockScreen extends ConsumerStatefulWidget {
  const LockScreen({
    super.key,
    required this.settings,
    required this.onUnlocked,
  });

  final AppSettings settings;
  final VoidCallback onUnlocked;

  @override
  ConsumerState<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends ConsumerState<LockScreen> {
  final TextEditingController _pin = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();
  bool _checking = false;
  bool _biometricAvailable = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    if (widget.settings.biometricEnabled) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => _unlockWithBiometrics(auto: true),
      );
    }
  }

  @override
  void dispose() {
    _pin.dispose();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    try {
      final supported = await _auth.isDeviceSupported();
      final canCheck = await _auth.canCheckBiometrics;
      if (mounted) setState(() => _biometricAvailable = supported && canCheck);
    } catch (_) {
      if (mounted) setState(() => _biometricAvailable = false);
    }
  }

  Future<void> _unlockWithPin() async {
    if (_checking) return;
    if (!widget.settings.pinEnabled) return;
    final pin = _pin.text.trim();
    if (pin.isEmpty) {
      setState(() => _error = context.l10n.lockEnterPin);
      return;
    }
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      final valid = await ref.read(pinServiceProvider).verifyPin(pin);
      if (!mounted) return;
      if (valid) {
        widget.onUnlocked();
      } else {
        setState(() => _error = context.l10n.lockWrongPin);
      }
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  Future<void> _unlockWithBiometrics({bool auto = false}) async {
    if (_checking || !widget.settings.biometricEnabled) return;
    final reason = context.l10n.lockBiometricReason;
    final unavailable = context.l10n.onboardingBiometricUnavailable;
    setState(() {
      _checking = true;
      _error = null;
    });
    try {
      final available = _biometricAvailable || await _auth.isDeviceSupported();
      if (!available) {
        if (mounted && !auto) setState(() => _error = unavailable);
        return;
      }
      final ok = await _auth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
      if (ok && mounted) widget.onUnlocked();
    } catch (_) {
      if (mounted && !auto) setState(() => _error = unavailable);
    } finally {
      if (mounted) setState(() => _checking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final settings = widget.settings;
    final logoPath = settings.logoPath;
    final hasLogo = logoPath != null && File(logoPath).existsSync();
    return PopScope(
      canPop: false,
      child: Material(
        color: tokens.background,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(tokens.spacingXl),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(tokens.cardRadius),
                      child: SizedBox(
                        width: 84,
                        height: 84,
                        child: hasLogo
                            ? Image.file(File(logoPath), fit: BoxFit.cover)
                            : Image.asset(
                                'assets/images/company_default.png',
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    SizedBox(height: tokens.spacingLg),
                    Text(
                      context.l10n.lockTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: tokens.spacingXs),
                    Text(
                      settings.displayCompanyName,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: tokens.muted),
                    ),
                    SizedBox(height: tokens.spacingXl),
                    if (settings.pinEnabled) ...[
                      TextField(
                        controller: _pin,
                        autofocus: true,
                        obscureText: true,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _unlockWithPin(),
                        decoration: InputDecoration(
                          labelText: context.l10n.lockEnterPin,
                          counterText: '',
                          errorText: _error,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                      ),
                      SizedBox(height: tokens.spacingSm),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: _checking ? null : _unlockWithPin,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: _checking
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(context.l10n.lockUnlock),
                          ),
                        ),
                      ),
                    ] else if (_error != null) ...[
                      Text(
                        _error!,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: tokens.absent),
                      ),
                      SizedBox(height: tokens.spacingSm),
                    ],
                    if (settings.biometricEnabled) ...[
                      SizedBox(height: tokens.spacingSm),
                      OutlinedButton.icon(
                        onPressed: _checking ? null : _unlockWithBiometrics,
                        icon: const Icon(Icons.fingerprint),
                        label: Text(context.l10n.lockUseBiometrics),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
