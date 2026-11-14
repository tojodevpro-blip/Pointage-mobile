import 'package:drift/drift.dart';

import '../../../core/db/app_database.dart';
import '../../../core/utils/app_date_utils.dart';

class HolidayRepository {
  HolidayRepository(this._db);

  final AppDatabase _db;

  Stream<List<Holiday>> watchAll() {
    return (_db.select(
      _db.holidays,
    )..orderBy([(t) => OrderingTerm.asc(t.date)])).watch();
  }

  Future<Set<DateTime>> datesInRange(DateTime start, DateTime end) async {
    final rows =
        await (_db.select(_db.holidays)..where(
              (t) =>
                  t.date.isBiggerOrEqualValue(dateOnly(start)) &
                  t.date.isSmallerOrEqualValue(dateOnly(end)),
            ))
            .get();
    return rows.map((e) => dateOnly(e.date)).toSet();
  }

  Future<void> add(DateTime date, String name) async {
    final normalized = dateOnly(date);
    final existing = await (_db.select(
      _db.holidays,
    )..where((t) => t.date.equals(normalized))).getSingleOrNull();
    if (existing != null) {
      await (_db.update(
        _db.holidays,
      )..where((t) => t.id.equals(existing.id))).write(
        HolidaysCompanion(
          name: Value(name.trim().isEmpty ? 'Férié' : name.trim()),
        ),
      );
      return;
    }
    await _db
        .into(_db.holidays)
        .insert(
          HolidaysCompanion.insert(
            date: normalized,
            name: name.trim().isEmpty ? 'Férié' : name.trim(),
            createdAt: DateTime.now().toUtc(),
          ),
        );
  }

  Future<void> delete(int id) {
    return (_db.delete(_db.holidays)..where((t) => t.id.equals(id))).go();
  }
}
