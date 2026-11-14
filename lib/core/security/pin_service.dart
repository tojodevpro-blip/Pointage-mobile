import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

import '../constants/app_constants.dart';
import 'secret_store.dart';

class PinService {
  PinService(this._store);

  final SecretStore _store;

  static bool isValidPin(String pin) => RegExp(r'^\d{4,6}$').hasMatch(pin);

  Future<bool> hasPin() async {
    final hash = await _store.read(AppConstants.pinHashKey);
    return hash != null && hash.isNotEmpty;
  }

  Future<void> setPin(String pin) async {
    if (!isValidPin(pin)) throw ArgumentError('PIN must be 4 to 6 digits');
    final random = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => random.nextInt(256));
    final salt = base64Encode(saltBytes);
    final hash = _derive(pin, saltBytes, AppConstants.pinIterations);
    await _store.write(AppConstants.pinSaltKey, salt);
    await _store.write(
      AppConstants.pinIterationsKey,
      AppConstants.pinIterations.toString(),
    );
    await _store.write(AppConstants.pinHashKey, hash);
  }

  Future<bool> verifyPin(String pin) async {
    final salt = await _store.read(AppConstants.pinSaltKey);
    final hash = await _store.read(AppConstants.pinHashKey);
    if (salt == null || hash == null) return false;
    final iterations =
        int.tryParse(await _store.read(AppConstants.pinIterationsKey) ?? '') ??
        AppConstants.pinIterations;
    final candidate = _derive(pin, base64Decode(salt), iterations);
    return constantTimeStringEquals(candidate, hash);
  }

  Future<void> clearPin() async {
    await _store.delete(AppConstants.pinHashKey);
    await _store.delete(AppConstants.pinSaltKey);
    await _store.delete(AppConstants.pinIterationsKey);
  }

  String _derive(String pin, List<int> salt, int iterations) {
    final hmac = Hmac(sha256, utf8.encode(pin));
    var block = hmac.convert([...salt, 0, 0, 0, 1]).bytes;
    final result = List<int>.from(block);
    for (var i = 1; i < iterations; i++) {
      block = hmac.convert(block).bytes;
      for (var j = 0; j < result.length; j++) {
        result[j] ^= block[j];
      }
    }
    return base64Encode(result);
  }
}

bool constantTimeStringEquals(String a, String b) {
  if (a.length != b.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return diff == 0;
}
