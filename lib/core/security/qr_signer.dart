import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../constants/app_constants.dart';

class QrBadgePayload {
  const QrBadgePayload({
    required this.employeeUuid,
    required this.version,
    required this.hmac,
    required this.raw,
  });

  final String employeeUuid;
  final int version;
  final String hmac;
  final String raw;
}

enum QrSignatureStatus { valid, malformed, badHmac }

class QrSignatureCheck {
  const QrSignatureCheck._(this.status, this.payload, this.reason);

  factory QrSignatureCheck.valid(QrBadgePayload payload) =>
      QrSignatureCheck._(QrSignatureStatus.valid, payload, null);
  factory QrSignatureCheck.malformed([String? reason]) =>
      QrSignatureCheck._(QrSignatureStatus.malformed, null, reason);
  factory QrSignatureCheck.badHmac() =>
      QrSignatureCheck._(QrSignatureStatus.badHmac, null, 'hmac');

  final QrSignatureStatus status;
  final QrBadgePayload? payload;
  final String? reason;

  bool get isValid => status == QrSignatureStatus.valid;
}

class QrSigner {
  const QrSigner(this.secret);

  final String secret;

  String hmacFor(String employeeUuid, int version) {
    final digest = Hmac(
      sha256,
      utf8.encode(secret),
    ).convert(utf8.encode('$employeeUuid:$version')).toString();
    return digest.substring(0, AppConstants.qrHmacLength);
  }

  String encode(String employeeUuid, int version) {
    return '${AppConstants.qrPrefix}:$employeeUuid:$version:${hmacFor(employeeUuid, version)}';
  }

  QrSignatureCheck verify(String raw) {
    final trimmed = raw.trim();
    final parts = trimmed.split(':');
    if (parts.length != 4) return QrSignatureCheck.malformed('parts');
    if (parts[0] != AppConstants.qrPrefix) {
      return QrSignatureCheck.malformed('prefix');
    }
    final uuid = parts[1];
    if (uuid.isEmpty) return QrSignatureCheck.malformed('uuid');
    final version = int.tryParse(parts[2]);
    if (version == null || version <= 0) {
      return QrSignatureCheck.malformed('version');
    }
    final provided = parts[3].toLowerCase();
    if (provided.length != AppConstants.qrHmacLength) {
      return QrSignatureCheck.malformed('hmac');
    }
    final expected = hmacFor(uuid, version);
    if (!constantTimeEquals(provided, expected)) {
      return QrSignatureCheck.badHmac();
    }
    return QrSignatureCheck.valid(
      QrBadgePayload(
        employeeUuid: uuid,
        version: version,
        hmac: provided,
        raw: trimmed,
      ),
    );
  }
}

bool constantTimeEquals(String a, String b) {
  if (a.length != b.length) return false;
  var diff = 0;
  for (var i = 0; i < a.length; i++) {
    diff |= a.codeUnitAt(i) ^ b.codeUnitAt(i);
  }
  return diff == 0;
}
