import '../../../core/db/app_database.dart';
import '../../../core/security/qr_signer.dart';
import '../../employees/data/employee_repository.dart';

enum BadgeStatus { valid, malformed, forged, unknown, archived, outdated }

class BadgeVerification {
  const BadgeVerification({
    required this.status,
    required this.raw,
    this.employee,
    this.payload,
  });

  final BadgeStatus status;
  final String raw;
  final Employee? employee;
  final QrBadgePayload? payload;

  bool get isValid => status == BadgeStatus.valid && employee != null;
}

class BadgeService {
  BadgeService(this._employees, this._signer);

  final EmployeeRepository _employees;
  final QrSigner _signer;

  QrSigner get signer => _signer;

  String payloadFor(Employee employee) =>
      _signer.encode(employee.uuid, employee.badgeVersion);

  Future<BadgeVerification> verify(String raw) async {
    final check = _signer.verify(raw);
    if (check.status == QrSignatureStatus.malformed) {
      return BadgeVerification(status: BadgeStatus.malformed, raw: raw);
    }
    if (check.status == QrSignatureStatus.badHmac || check.payload == null) {
      return BadgeVerification(status: BadgeStatus.forged, raw: raw);
    }
    final payload = check.payload!;
    final employee = await _employees.byUuid(payload.employeeUuid);
    if (employee == null) {
      return BadgeVerification(
        status: BadgeStatus.unknown,
        raw: raw,
        payload: payload,
      );
    }
    if (employee.isArchived) {
      return BadgeVerification(
        status: BadgeStatus.archived,
        raw: raw,
        employee: employee,
        payload: payload,
      );
    }
    if (employee.badgeVersion != payload.version) {
      return BadgeVerification(
        status: BadgeStatus.outdated,
        raw: raw,
        employee: employee,
        payload: payload,
      );
    }
    return BadgeVerification(
      status: BadgeStatus.valid,
      raw: raw,
      employee: employee,
      payload: payload,
    );
  }
}
