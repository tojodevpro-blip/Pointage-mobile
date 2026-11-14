import 'dart:io';
import 'dart:ui' as ui;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/db/app_database.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/providers/app_providers.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../core/widgets/app_widgets.dart';

class EmployeesScreen extends ConsumerStatefulWidget {
  const EmployeesScreen({super.key});

  @override
  ConsumerState<EmployeesScreen> createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends ConsumerState<EmployeesScreen> {
  final TextEditingController _search = TextEditingController();
  String _sort = 'name';
  String _department = '';
  bool _showArchived = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final repo = ref.watch(employeeRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.employeesTitle),
        actions: [
          IconButton(
            tooltip: context.l10n.employeesShowArchived,
            onPressed: () => setState(() => _showArchived = !_showArchived),
            icon: Icon(
              _showArchived
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
            ),
          ),
          IconButton(
            tooltip: context.l10n.employeesAdd,
            onPressed: () => _openForm(),
            icon: const Icon(Icons.person_add_alt_1),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              tokens.spacingMd,
              tokens.spacingSm,
              tokens.spacingMd,
              0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _search,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: context.l10n.employeesSearch,
                      prefixIcon: const Icon(Icons.search),
                      isDense: true,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                PopupMenuButton<String>(
                  tooltip: context.l10n.employeesSort,
                  initialValue: _sort,
                  onSelected: (value) => setState(() => _sort = value),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'name',
                      child: Text(context.l10n.employeesSortName),
                    ),
                    PopupMenuItem(
                      value: 'recent',
                      child: Text(context.l10n.employeesSortRecent),
                    ),
                    PopupMenuItem(
                      value: 'department',
                      child: Text(context.l10n.employeesSortDepartment),
                    ),
                  ],
                  icon: const Icon(Icons.sort),
                ),
              ],
            ),
          ),
          ref
              .watch(departmentsProvider)
              .maybeWhen(
                data: (departments) => departments.length < 2
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(
                          tokens.spacingMd,
                          tokens.spacingSm,
                          tokens.spacingMd,
                          0,
                        ),
                        child: DropdownButtonFormField<String>(
                          initialValue: _department,
                          isExpanded: true,
                          decoration: InputDecoration(
                            labelText: context.l10n.employeesDepartmentFilter,
                            isDense: true,
                            prefixIcon: const Icon(Icons.apartment_outlined),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: '',
                              child: Text(context.l10n.commonAll),
                            ),
                            ...departments.map(
                              (d) => DropdownMenuItem(value: d, child: Text(d)),
                            ),
                          ],
                          onChanged: (value) =>
                              setState(() => _department = value ?? ''),
                        ),
                      ),
                orElse: () => const SizedBox.shrink(),
              ),
          Expanded(
            child: StreamBuilder<List<Employee>>(
              stream: repo.watchEmployees(
                includeArchived: _showArchived,
                search: _search.text,
                sort: _sort,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final all = snapshot.data ?? const <Employee>[];
                final employees = _department.isEmpty
                    ? all
                    : all.where((e) => e.department == _department).toList();
                if (employees.isEmpty) {
                  return EmptyState(
                    icon: Icons.people_outline,
                    title: _search.text.trim().isEmpty && _department.isEmpty
                        ? context.l10n.employeesEmptyTitle
                        : context.l10n.employeesNoResults,
                    message: _search.text.trim().isEmpty && _department.isEmpty
                        ? context.l10n.employeesEmptyBody
                        : context.l10n.employeesNoResults,
                    action: _search.text.trim().isEmpty && _department.isEmpty
                        ? FilledButton.icon(
                            onPressed: () => _openForm(),
                            icon: const Icon(Icons.add),
                            label: Text(context.l10n.employeesAdd),
                          )
                        : null,
                  );
                }
                return ListView.separated(
                  padding: EdgeInsets.all(tokens.spacingMd),
                  itemCount: employees.length,
                  separatorBuilder: (_, _) =>
                      SizedBox(height: tokens.spacingSm),
                  itemBuilder: (context, index) {
                    final employee = employees[index];
                    return _EmployeeTile(
                      employee: employee,
                      onEdit: () => _openForm(employee: employee),
                      onBadge: () => _openBadge(employee),
                      onArchive: () => _toggleArchive(employee),
                      onDelete: () => _delete(employee),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openForm({Employee? employee}) async {
    final result = await showModalBottomSheet<Employee>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _EmployeeFormSheet(employee: employee),
    );
    if (result != null && mounted) {
      ref.invalidate(activeEmployeesProvider);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.employeesSaved)));
      if (employee == null) _openBadge(result);
    }
  }

  Future<void> _openBadge(Employee employee) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => _BadgeSheet(employee: employee),
    );
  }

  Future<void> _toggleArchive(Employee employee) async {
    final repo = ref.read(employeeRepositoryProvider);
    if (employee.isArchived) {
      await repo.setArchived(employee.id, false);
      if (mounted) {
        ref.invalidate(activeEmployeesProvider);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(context.l10n.employeesSaved)));
      }
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.employeesArchive),
        content: Text(context.l10n.employeesArchiveConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.employeesArchive),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await repo.setArchived(employee.id, true);
    if (mounted) {
      ref.invalidate(activeEmployeesProvider);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.employeesArchived)));
    }
  }

  Future<void> _delete(Employee employee) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.employeesDelete),
        content: Text(
          '${context.l10n.employeesDeleteConfirm1}\n\n${context.l10n.employeesDeleteConfirm2}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    await ref.read(employeeRepositoryProvider).deleteCascade(employee);
    if (mounted) {
      ref.invalidate(activeEmployeesProvider);
      ref.invalidate(recentScansProvider);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(context.l10n.employeesDeleted)));
    }
  }
}

class _EmployeeTile extends StatelessWidget {
  const _EmployeeTile({
    required this.employee,
    required this.onEdit,
    required this.onBadge,
    required this.onArchive,
    required this.onDelete,
  });

  final Employee employee;
  final VoidCallback onEdit;
  final VoidCallback onBadge;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final subtitle = [
      employee.position,
      employee.department,
    ].where((e) => e.trim().isNotEmpty).join(' · ');
    return AppCard(
      onTap: onEdit,
      padding: EdgeInsets.all(tokens.spacingSm),
      child: Row(
        children: [
          InitialsAvatar(
            name: '${employee.firstName} ${employee.lastName}',
            size: 46,
            photoPath: employee.photoPath,
          ),
          SizedBox(width: tokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${employee.firstName} ${employee.lastName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    if (employee.isArchived) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: tokens.surfaceVariant,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          context.l10n.commonArchived,
                          style: TextStyle(fontSize: 10, color: tokens.muted),
                        ),
                      ),
                    ],
                  ],
                ),
                if (subtitle.isNotEmpty)
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: tokens.muted, fontSize: 12),
                  ),
                if (employee.matricule.isNotEmpty)
                  Text(
                    '${context.l10n.employeesMatricule} ${employee.matricule}',
                    style: TextStyle(color: tokens.muted, fontSize: 11),
                  ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Badge QR',
            onPressed: onBadge,
            icon: const Icon(Icons.qr_code_2),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  onEdit();
                  break;
                case 'badge':
                  onBadge();
                  break;
                case 'archive':
                  onArchive();
                  break;
                case 'delete':
                  onDelete();
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'edit',
                child: Text(context.l10n.commonEdit),
              ),
              PopupMenuItem(
                value: 'badge',
                child: Text(context.l10n.badgesView),
              ),
              PopupMenuItem(
                value: 'archive',
                child: Text(
                  employee.isArchived
                      ? context.l10n.employeesUnarchive
                      : context.l10n.employeesArchive,
                ),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text(context.l10n.commonDelete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmployeeFormSheet extends ConsumerStatefulWidget {
  const _EmployeeFormSheet({this.employee});

  final Employee? employee;

  @override
  ConsumerState<_EmployeeFormSheet> createState() => _EmployeeFormSheetState();
}

class _EmployeeFormSheetState extends ConsumerState<_EmployeeFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _firstName;
  late final TextEditingController _lastName;
  late final TextEditingController _matricule;
  late final TextEditingController _position;
  late final TextEditingController _department;
  late final TextEditingController _phone;
  late final TextEditingController _break;
  DateTime? _hireDate;
  bool _customSchedule = false;
  late Set<int> _workDays;
  late TimeOfDay _start;
  late TimeOfDay _end;
  String? _photoPath;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final e = widget.employee;
    final settings = ref.read(settingsProvider);
    _firstName = TextEditingController(text: e?.firstName ?? '');
    _lastName = TextEditingController(text: e?.lastName ?? '');
    _matricule = TextEditingController(text: e?.matricule ?? '');
    _position = TextEditingController(text: e?.position ?? '');
    _department = TextEditingController(text: e?.department ?? '');
    _phone = TextEditingController(text: e?.phone ?? '');
    _break = TextEditingController(
      text: '${e?.breakMinutes ?? settings.breakMinutes}',
    );
    _photoPath = e?.photoPath;
    _hireDate = e?.hireDate;
    _customSchedule = e?.useCustomSchedule ?? false;
    _workDays = (e != null && e.useCustomSchedule)
        ? e.workDays
              .split(',')
              .map((v) => int.tryParse(v.trim()))
              .whereType<int>()
              .toSet()
        : settings.workDays.toSet();
    _start = _toTime(e?.startMinutes ?? settings.startMinutes);
    _end = _toTime(e?.endMinutes ?? settings.endMinutes);
  }

  TimeOfDay _toTime(int minutes) =>
      TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);

  Future<void> _pickPhoto(ImageSource source) async {
    final path = await ref
        .read(mediaServiceProvider)
        .pickImage(source: source, prefix: 'employee');
    if (path != null && mounted) setState(() => _photoPath = path);
  }

  Future<void> _removePhoto() async {
    final current = _photoPath;
    if (current != null) await ref.read(mediaServiceProvider).delete(current);
    if (mounted) setState(() => _photoPath = null);
  }

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _matricule.dispose();
    _position.dispose();
    _department.dispose();
    _phone.dispose();
    _break.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final repo = ref.read(employeeRepositoryProvider);
      final startMinutes = _start.hour * 60 + _start.minute;
      final endMinutes = _end.hour * 60 + _end.minute;
      final breakMinutes = int.tryParse(_break.text.trim()) ?? 60;
      final days = _workDays.toList()..sort();
      Employee? saved;
      if (widget.employee == null) {
        saved = await repo.create(
          firstName: _firstName.text,
          lastName: _lastName.text,
          matricule: _matricule.text,
          position: _position.text,
          department: _department.text,
          phone: _phone.text,
          hireDate: _hireDate,
          photoPath: _photoPath,
          useCustomSchedule: _customSchedule,
          workDays: days,
          startMinutes: startMinutes,
          endMinutes: endMinutes,
          breakMinutes: breakMinutes,
        );
      } else {
        await repo.updateEmployee(
          widget.employee!.id,
          firstName: _firstName.text,
          lastName: _lastName.text,
          matricule: _matricule.text,
          position: _position.text,
          department: _department.text,
          phone: _phone.text,
          hireDate: _hireDate,
          photoPath: _photoPath,
          useCustomSchedule: _customSchedule,
          workDays: days,
          startMinutes: startMinutes,
          endMinutes: endMinutes,
          breakMinutes: breakMinutes,
        );
        saved = widget.employee;
      }
      if (mounted) Navigator.pop(context, saved);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Form(
            key: _formKey,
            child: ListView(
              controller: scrollController,
              padding: EdgeInsets.all(tokens.spacingMd),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.employee == null
                            ? context.l10n.employeesAdd
                            : context.l10n.employeesEdit,
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacingSm),
                Row(
                  children: [
                    InitialsAvatar(
                      name: '${_firstName.text} ${_lastName.text}'.trim(),
                      size: 76,
                      photoPath: _photoPath,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () => _pickPhoto(ImageSource.camera),
                            icon: const Icon(Icons.photo_camera_outlined),
                            label: Text(context.l10n.commonCamera),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => _pickPhoto(ImageSource.gallery),
                            icon: const Icon(Icons.photo_library_outlined),
                            label: Text(context.l10n.commonGallery),
                          ),
                          if (_photoPath != null)
                            TextButton.icon(
                              onPressed: _removePhoto,
                              icon: const Icon(Icons.delete_outline),
                              label: Text(context.l10n.commonRemove),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: tokens.spacingMd),
                TextFormField(
                  controller: _firstName,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '${context.l10n.employeesFirstName} *',
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? context.l10n.employeesRequiredField
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _lastName,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '${context.l10n.employeesLastName} *',
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? context.l10n.employeesRequiredField
                      : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _matricule,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.l10n.employeesMatricule,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _position,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.l10n.employeesPosition,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _department,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: context.l10n.employeesDepartment,
                  ),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: context.l10n.employeesPhone,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(context.l10n.employeesHireDate),
                  subtitle: Text(
                    _hireDate == null
                        ? context.l10n.commonNone
                        : MaterialLocalizations.of(context)
                              .formatMediumDate(_hireDate!),
                  ),
                  trailing: const Icon(Icons.calendar_today_outlined),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: _hireDate ?? DateTime.now(),
                      firstDate: DateTime(1950),
                      lastDate: DateTime.now().add(const Duration(days: 3650)),
                    );
                    if (picked != null) setState(() => _hireDate = picked);
                  },
                ),
                const Divider(),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  value: _customSchedule,
                  onChanged: (value) => setState(() => _customSchedule = value),
                  title: Text(context.l10n.employeesCustomSchedule),
                  subtitle: Text(context.l10n.employeesUseCustomSchedule),
                ),
                if (_customSchedule) ...[
                  const SizedBox(height: 8),
                  Text(
                    context.l10n.employeesWorkDays,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    children: List.generate(7, (index) {
                      final day = index + 1;
                      return FilterChip(
                        label: Text(
                          const [
                            'Lun',
                            'Mar',
                            'Mer',
                            'Jeu',
                            'Ven',
                            'Sam',
                            'Dim',
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
                  Row(
                    children: [
                      Expanded(
                        child: _TimeField(
                          label: context.l10n.commonStart,
                          value: _start,
                          onChanged: (value) => setState(() => _start = value),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _TimeField(
                          label: context.l10n.commonEnd,
                          value: _end,
                          onChanged: (value) => setState(() => _end = value),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                TextFormField(
                  controller: _break,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: context.l10n.settingsBreakMinutes,
                  ),
                ),
                SizedBox(height: tokens.spacingLg),
                FilledButton(
                  onPressed: _saving ? null : _save,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _saving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(context.l10n.commonSave),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final TimeOfDay value;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
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
}

class _BadgeSheet extends ConsumerStatefulWidget {
  const _BadgeSheet({required this.employee});

  final Employee employee;

  @override
  ConsumerState<_BadgeSheet> createState() => _BadgeSheetState();
}

class _BadgeSheetState extends ConsumerState<_BadgeSheet> {
  final GlobalKey _badgeKey = GlobalKey();
  String? _payload;
  late Employee _employee;
  bool _working = false;

  @override
  void initState() {
    super.initState();
    _employee = widget.employee;
    _load();
  }

  Future<void> _load() async {
    final service = await ref.read(badgeServiceProvider.future);
    if (!mounted) return;
    setState(() => _payload = service.payloadFor(_employee));
  }

  Future<pw.MemoryImage?> _memoryImage(String? path) async {
    if (path == null || path.isEmpty) return null;
    final file = File(path);
    if (!await file.exists()) return null;
    try {
      return pw.MemoryImage(await file.readAsBytes());
    } catch (_) {
      return null;
    }
  }

  Future<pw.Document> _buildDocument() async {
    final footer = context.l10n.badgesPreview;
    final service = await ref.read(badgeServiceProvider.future);
    final settings = ref.read(settingsProvider);
    final payload = service.payloadFor(_employee);
    final imageData = await QrPainter(
      data: payload,
      version: QrVersions.auto,
      gapless: true,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square,
        color: Colors.black,
      ),
    ).toImageData(600);
    final image = imageData == null
        ? null
        : pw.MemoryImage(imageData.buffer.asUint8List());
    final logo = await _memoryImage(settings.logoPath);
    final photo = await _memoryImage(_employee.photoPath);
    final doc = pw.Document();
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a6,
        margin: const pw.EdgeInsets.all(18),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            if (logo != null) ...[
              pw.SizedBox(
                height: 34,
                child: pw.Image(logo, fit: pw.BoxFit.contain),
              ),
              pw.SizedBox(height: 6),
            ],
            pw.Text(
              settings.companyName.trim().isEmpty
                  ? 'PointagePro'
                  : settings.companyName,
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            pw.SizedBox(height: 6),
            if (photo != null) ...[
              pw.ClipOval(
                child: pw.SizedBox(
                  width: 44,
                  height: 44,
                  child: pw.Image(photo, fit: pw.BoxFit.cover),
                ),
              ),
              pw.SizedBox(height: 4),
            ],
            pw.Text(
              '${_employee.firstName} ${_employee.lastName}',
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center,
            ),
            if (_employee.position.trim().isNotEmpty)
              pw.Text(
                _employee.position,
                style: const pw.TextStyle(fontSize: 10),
                textAlign: pw.TextAlign.center,
              ),
            pw.Spacer(),
            if (image != null) pw.Image(image, width: 150, height: 150),
            pw.Spacer(),
            pw.Text(
              footer,
              style: const pw.TextStyle(fontSize: 8),
              textAlign: pw.TextAlign.center,
            ),
          ],
        ),
      ),
    );
    return doc;
  }

  Future<void> _share() async {
    setState(() => _working = true);
    try {
      final doc = await _buildDocument();
      final bytes = await doc.save();
      await Printing.sharePdf(
        bytes: bytes,
        filename: 'badge_${_employee.lastName}.pdf',
      );
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _print() async {
    setState(() => _working = true);
    try {
      final doc = await _buildDocument();
      await Printing.layoutPdf(onLayout: (format) => doc.save());
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _downloadPng() async {
    final boundary =
        _badgeKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return;
    final l10n = context.l10n;
    setState(() => _working = true);
    try {
      final image = await boundary.toImage(pixelRatio: 3);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) throw StateError('No PNG data');
      final bytes = data.buffer.asUint8List();
      final fileName = 'badge_${_employee.lastName}_${_employee.firstName}.png'
          .replaceAll(RegExp(r'[^A-Za-z0-9_.-]'), '_');
      String? path;
      try {
        path = await FilePicker.platform.saveFile(
          dialogTitle: l10n.badgesDownloadPng,
          fileName: fileName,
          type: FileType.image,
          bytes: bytes,
        );
      } catch (_) {
        path = null;
      }
      if (path == null) {
        final dir = await getTemporaryDirectory();
        final file = File('${dir.path}/$fileName');
        await file.writeAsBytes(bytes, flush: true);
        await Share.shareXFiles([
          XFile(file.path, mimeType: 'image/png'),
        ], subject: l10n.badgesDownloadPng);
      } else {
        final file = File(path);
        try {
          if (!await file.exists() || await file.length() != bytes.length) {
            await file.writeAsBytes(bytes, flush: true);
          }
        } catch (_) {}
      }
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.badgesImageSaved)));
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.badgesImageFailed)));
      }
    } finally {
      if (mounted) setState(() => _working = false);
    }
  }

  Future<void> _regenerate() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.badgesRegenerate),
        content: Text(context.l10n.badgesRegenerateConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.badgesRegenerate),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    final updated = await ref
        .read(employeeRepositoryProvider)
        .regenerateBadge(_employee);
    final repo = ref.read(employeeRepositoryProvider);
    final fresh = await repo.byId(_employee.id);
    if (fresh == null) return;
    setState(() {
      _employee = fresh;
      _payload = null;
    });
    await _load();
    ref.invalidate(activeEmployeesProvider);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${context.l10n.badgesRegenerated} (v$updated)'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = AppTokens.of(context);
    final settings = ref.watch(settingsProvider);
    return Padding(
      padding: EdgeInsets.all(tokens.spacingMd),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.badgesBadge,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: tokens.spacingSm),
          RepaintBoundary(
            key: _badgeKey,
            child: Container(
              padding: EdgeInsets.all(tokens.spacingMd),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(tokens.cardRadius),
                border: Border.all(color: tokens.border),
              ),
              child: Column(
                children: [
                  if (settings.logoPath != null &&
                      File(settings.logoPath!).existsSync()) ...[
                    Image.file(
                      File(settings.logoPath!),
                      height: 38,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 6),
                  ],
                  Text(
                    settings.companyName.trim().isEmpty
                        ? 'PointagePro'
                        : settings.companyName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_payload == null)
                    const SizedBox(
                      width: 220,
                      height: 220,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else
                    QrImageView(
                      data: _payload!,
                      version: QrVersions.auto,
                      size: 220,
                      backgroundColor: Colors.white,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Colors.black,
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Colors.black,
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InitialsAvatar(
                        name: '${_employee.firstName} ${_employee.lastName}',
                        size: 42,
                        photoPath: _employee.photoPath,
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${_employee.firstName} ${_employee.lastName}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            if (_employee.position.trim().isNotEmpty)
                              Text(
                                _employee.position,
                                style: const TextStyle(color: Colors.black54),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${context.l10n.badgesBadge} v${_employee.badgeVersion}',
                    style: const TextStyle(color: Colors.black38, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: tokens.spacingMd),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: _working ? null : _share,
                  icon: const Icon(Icons.share),
                  label: Text(context.l10n.commonShare),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _working ? null : _print,
                  icon: const Icon(Icons.print_outlined),
                  label: Text(context.l10n.commonPrint),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: _working || _payload == null ? null : _downloadPng,
              icon: const Icon(Icons.download_outlined),
              label: Text(context.l10n.badgesDownloadPng),
            ),
          ),
          TextButton.icon(
            onPressed: _working ? null : _regenerate,
            icon: const Icon(Icons.refresh),
            label: Text(context.l10n.badgesRegenerate),
          ),
        ],
      ),
    );
  }
}
