import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables_db.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

class JournalRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  JournalRepository(this._db, this._tables);

  Future<void> pushEntryToRemote(String localId) async {
    try {
      final entry = await (_db.select(_db.journalEntries)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.journalCol,
        rowId: entry.id,
        data: {
          'userId': entry.userId,
          'title': entry.title,
          'body': entry.body,
          'moodEmoji': entry.moodEmoji,
          'moodScore': entry.moodScore,
          'tagsJson': entry.tagsJson,
          'createdAt': entry.createdAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, entry.id, 'journal_entries');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'journal_entries');
      rethrow;
    }
  }
}

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepository(
    ref.read(appDatabaseProvider),
    ref.read(appwriteTablesDBProvider),
  );
});
