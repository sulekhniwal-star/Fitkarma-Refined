import 'package:drift/drift.dart';
import '../tables.dart';
import '../app_database.dart';

part 'abha_links_dao.g.dart';


@DriftAccessor(tables: [AbhaLinks])
class AbhaLinksDao extends DatabaseAccessor<AppDatabase>
    with _$AbhaLinksDaoMixin {
  AbhaLinksDao(super.db);

  Future<List<AbhaLink>> getActive(String userId) =>
      (select(abhaLinks)
            ..where((t) => t.userId.equals(userId))
            ..where((t) => t.isActive.equals(true)))
          .get();

  Future<int> insertLink(AbhaLinksCompanion entry) =>
      into(abhaLinks).insert(entry);

  Future<bool> updateLink(AbhaLinksCompanion entry) =>
      update(abhaLinks).replace(entry);

  Future<int> deleteLink(int id) =>
      (delete(abhaLinks)..where((t) => t.id.equals(id))).go();
}
