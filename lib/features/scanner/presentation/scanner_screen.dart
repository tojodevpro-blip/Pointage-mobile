import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/l10n/l10n.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/utils/app_date_utils.dart';
import '../../../core/widgets/app_widgets.dart';
import '../domain/scan_service.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen>
    with WidgetsBindingObserver {
  final MobileScannerController _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
  );
  final AudioPlayer _player = AudioPlayer();

  bool _busy = false;
  bool _torch = false;
  bool _showResult = false;
  ScanResult? _result;
  Timer? _timer;
  String? _lastRaw;
  DateTime? _lastRawAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _controller.dispose();
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_busy && !_showResult) {
      _controller.start().catchError((_) {});
    }
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_busy || _showResult) return;
    final raw = capture.barcodes.isEmpty
        ? null
        : capture.barcodes.first.rawValue;
    if (raw == null || raw.isEmpty) return;
    final now = DateTime.now();
    if (raw == _lastRaw &&
        _lastRawAt != null &&
        now.difference(_lastRawAt!).inMilliseconds < 800) {
      return;
    }
    _lastRaw = raw;
    _lastRawAt = now;
    await _process(raw);
  }

  Future<void> _process(String raw) async {
    setState(() => _busy = true);
    try {
      await _controller.stop();
    } catch (_) {}
    try {
      final badge = await ref.read(badgeServiceProvider.future);
      final settings = ref.read(settingsProvider);
      final service = ScanService(
        badgeService: badge,
        attendanceRepository: ref.read(attendanceRepositoryProvider),
        settings: settings,
        tzOffsetMinutes: currentTzOffsetMinutes(),
      );
      final result = await service.handle(raw);
      if (!mounted) return;
      if (result.type.isSuccess) {
        if (settings.scanSound) {
          try {
            await _player.play(AssetSource('sounds/scan.wav'));
          } catch (_) {}
        }
        if (settings.scanVibration) {
          await HapticFeedback.mediumImpact();
        }
      } else {
        await HapticFeedback.heavyImpact();
      }
      setState(() {
        _result = result;
        _showResult = true;
        _busy = false;
      });
      ref.invalidate(recentScansProvider);
      _timer?.cancel();
      final seconds = settings.autoReturnSeconds.clamp(1, 20);
      _timer = Timer(Duration(seconds: seconds), _resume);
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _result = const ScanResult(
          type: ScanResultType.failure,
          late: false,
          lateMinutes: 0,
        );
        _showResult = true;
        _busy = false;
      });
      _timer?.cancel();
      _timer = Timer(const Duration(seconds: 3), _resume);
    }
  }

  Future<void> _resume() async {
    _timer?.cancel();
    if (!mounted) return;
    setState(() {
      _showResult = false;
      _result = null;
      _busy = false;
    });
    try {
      await _controller.start();
    } catch (_) {}
  }

  Future<void> _toggleTorch() async {
    try {
      await _controller.toggleTorch();
      setState(() => _torch = !_torch);
    } catch (_) {}
  }

  Future<void> _switchCamera() async {
    try {
      await _controller.switchCamera();
    } catch (_) {}
  }

  Future<void> _openManualEntry() async {
    final textController = TextEditingController();
    final raw = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.scannerManualTitle),
        content: TextField(
          controller: textController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'PTG1:…',
            labelText: context.l10n.scannerManualLabel,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, textController.text.trim()),
            child: Text(context.l10n.commonValidate),
          ),
        ],
      ),
    );
    textController.dispose();
    if (raw != null && raw.isNotEmpty) await _process(raw);
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error, child) =>
                _CameraError(error: error, onRetry: _resume),
            placeholderBuilder: (context, child) => const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
          IgnorePointer(
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: _showResult
                        ? Colors.transparent
                        : Colors.white.withValues(alpha: 0.9),
                    width: 3,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            context.l10n.scannerManualTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _RoundAction(
                        icon: _torch ? Icons.flash_on : Icons.flash_off,
                        onTap: _toggleTorch,
                        tooltip: context.l10n.scannerFlash,
                      ),
                      const SizedBox(width: 8),
                      _RoundAction(
                        icon: Icons.cameraswitch_outlined,
                        onTap: _switchCamera,
                        tooltip: context.l10n.scannerSwitchCamera,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (!_showResult)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      context.l10n.scannerHint,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                if (_showResult && _result != null)
                  _ResultPanel(result: _result!, onDismiss: _resume),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    tokens.spacingMd,
                    tokens.spacingSm,
                    tokens.spacingMd,
                    tokens.spacingMd,
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            onPressed: _openManualEntry,
                            icon: const Icon(Icons.keyboard_alt_outlined),
                            label: Text(context.l10n.scannerManualTitle),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundAction extends StatelessWidget {
  const _RoundAction({
    required this.icon,
    required this.onTap,
    required this.tooltip,
  });

  final IconData icon;
  final VoidCallback onTap;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.black.withValues(alpha: 0.45),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Icon(icon, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _ResultPanel extends StatelessWidget {
  const _ResultPanel({required this.result, required this.onDismiss});

  final ScanResult result;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final employee = result.employee;
    final name = employee == null
        ? null
        : '${employee.firstName} ${employee.lastName}';
    final success = result.type.isSuccess;
    final color = success ? tokens.present : tokens.absent;
    final soft = success ? tokens.presentSoft : tokens.absentSoft;
    final l10n = context.l10n;
    final (title, message) = switch (result.type) {
      ScanResultType.checkIn => (
        l10n.scannerCheckInSuccess,
        name == null
            ? l10n.dashboardInAt
            : result.late
            ? '$name — ${l10n.scannerLateArrival} (${result.lateMinutes} ${l10n.minutesShort})'
            : '$name — ${l10n.scannerOnTime}',
      ),
      ScanResultType.checkOut => (
        l10n.scannerCheckOutSuccess,
        name == null ? l10n.dashboardOutAt : '$name — ${l10n.dashboardOutAt}',
      ),
      ScanResultType.checkoutUpdated => (
        l10n.scannerCheckoutUpdated,
        name ?? l10n.scannerCheckoutUpdated,
      ),
      ScanResultType.duplicate => (
        l10n.scannerDuplicate,
        l10n.scannerDuplicate,
      ),
      ScanResultType.alreadyComplete => (
        l10n.scannerAlreadyClockedOut,
        l10n.scannerAlreadyClockedOut,
      ),
      ScanResultType.manualBlocked => (
        l10n.scannerManualBlocked,
        l10n.scannerManualBlocked,
      ),
      ScanResultType.malformed => (
        l10n.scannerInvalidQr,
        l10n.scannerInvalidQr,
      ),
      ScanResultType.forged => (l10n.scannerInvalidQr, l10n.scannerInvalidQr),
      ScanResultType.unknown => (
        l10n.scannerUnknownBadge,
        l10n.scannerUnknownBadge,
      ),
      ScanResultType.archived => (
        l10n.scannerArchivedBadge,
        name == null
            ? l10n.scannerArchivedBadge
            : '$name — ${l10n.scannerArchivedBadge}',
      ),
      ScanResultType.outdated => (
        l10n.scannerOutdatedBadge,
        l10n.scannerOutdatedBadge,
      ),
      ScanResultType.failure => (l10n.scannerError, l10n.scannerError),
    };
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Material(
        color: tokens.surface,
        borderRadius: BorderRadius.circular(tokens.cardRadius),
        child: InkWell(
          onTap: onDismiss,
          borderRadius: BorderRadius.circular(tokens.cardRadius),
          child: Padding(
            padding: EdgeInsets.all(tokens.spacingMd),
            child: Row(
              children: [
                if (name != null)
                  InitialsAvatar(name: name, size: 52, color: soft)
                else
                  Container(
                    width: 52,
                    height: 52,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: soft,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      success ? Icons.check_rounded : Icons.close_rounded,
                      color: color,
                      size: 28,
                    ),
                  ),
                SizedBox(width: tokens.spacingSm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            success ? Icons.check_circle : Icons.error,
                            color: color,
                            size: 18,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: color,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(message, style: TextStyle(color: tokens.text)),
                      const SizedBox(height: 6),
                      Text(
                        context.l10n.scannerTapAgain,
                        style: TextStyle(color: tokens.muted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CameraError extends StatelessWidget {
  const _CameraError({required this.error, required this.onRetry});

  final MobileScannerException error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final denied = error.errorCode == MobileScannerErrorCode.permissionDenied;
    return Container(
      color: tokens.background,
      padding: EdgeInsets.all(tokens.spacingXl),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              denied
                  ? Icons.no_photography_outlined
                  : Icons.camera_alt_outlined,
              size: 48,
              color: tokens.muted,
            ),
            SizedBox(height: tokens.spacingMd),
            Text(
              denied
                  ? context.l10n.scannerPermissionTitle
                  : context.l10n.scannerCameraUnavailable,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: tokens.spacingXs),
            Text(
              denied
                  ? context.l10n.scannerPermissionBody
                  : context.l10n.scannerCameraBusy,
              textAlign: TextAlign.center,
              style: TextStyle(color: tokens.muted),
            ),
            SizedBox(height: tokens.spacingLg),
            Wrap(
              spacing: 8,
              children: [
                OutlinedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: Text(context.l10n.scannerRestart),
                ),
                if (denied)
                  FilledButton.icon(
                    onPressed: openAppSettings,
                    icon: const Icon(Icons.settings_outlined),
                    label: Text(context.l10n.scannerOpenSettings),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
