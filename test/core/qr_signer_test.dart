import 'package:flutter_test/flutter_test.dart';
import 'package:pointagepro/core/security/qr_signer.dart';

void main() {
  const signer = QrSigner('secret-test');

  test('encodes and verifies a valid badge', () {
    final raw = signer.encode('employee-uuid', 3);
    final check = signer.verify(raw);
    expect(check.status, QrSignatureStatus.valid);
    expect(check.payload?.employeeUuid, 'employee-uuid');
    expect(check.payload?.version, 3);
  });

  test('rejects a tampered badge', () {
    final raw = signer.encode('employee-uuid', 3);
    final tampered = raw.replaceFirst('employee-uuid', 'other-uuid');
    expect(signer.verify(tampered).status, QrSignatureStatus.badHmac);
  });

  test('rejects malformed payloads', () {
    expect(signer.verify('').status, QrSignatureStatus.malformed);
    expect(signer.verify('PTG1:uuid:3').status, QrSignatureStatus.malformed);
    expect(
      signer.verify('WRONG:uuid:3:0011223344556677').status,
      QrSignatureStatus.malformed,
    );
    expect(
      signer.verify('PTG1:uuid:0:0011223344556677').status,
      QrSignatureStatus.malformed,
    );
  });

  test('badge version changes the signature', () {
    final first = signer.encode('employee-uuid', 1);
    final second = signer.encode('employee-uuid', 2);
    expect(first, isNot(second));
    expect(signer.verify(second).status, QrSignatureStatus.valid);
  });
}
