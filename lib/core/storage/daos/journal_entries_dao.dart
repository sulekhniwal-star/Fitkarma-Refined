import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'journal_entries_dao.g.dart';


@DriftAccessor(tables: [JournalEntries])
class JournalEntriesDao extends DatabaseAccessor<AppDatabase>
    with _$JournalEntriesDaoMixin {
  JournalEntriesDao(super.db);

  Future<List<JournalEntry>> getAll(String userId) =>
      (select(journalEntries)
            ..where((t) => t.userId.equals(userId))
            ..orderBy([(t) => OrderingTerm.desc(t.entryDate)]))
          .get();

  Future<List<JournalEntry>> getByDateRange(
      String userId, DateTime start, DateTime end) {
    return (select(journalEntries)
          ..where((t) => t.userId.equals(userId))
          ..where((t) => t.entryDate.isBetweenValues(start, end))
          ..orderBy([(t) => OrderingTerm.desc(t.entryDate)]))
        .get();
  }

  Future<JournalEntry?> getById(int id) =>
      (select(journalEntries)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<int> insertEntry(JournalEntriesCompanion entry) =>
      into(journalEntries).insert(entry);

  Future<bool> updateEntry(JournalEntriesCompanion entry) =>
      update(journalEntries).replace(entry);

  Future<int> deleteEntry(int id) =>
      (delete(journalEntries)..where((t) => t.id.equals(id))).go();

  Stream<List<JournalEntry>> watchRecent(String userId, {int limit = 10}) {
    return (select(journalEntries)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.entryDate)])
          ..limit(limit))
        .watch();
  }
}
