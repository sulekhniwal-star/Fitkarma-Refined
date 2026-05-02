import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;

/// A wrapper around Appwrite Databases to provide a more "table-like" API
/// as used throughout the repositories.
class TablesDB {
  final Databases _databases;

  TablesDB(Client client) : _databases = Databases(client);

  Future<void> createRow({
    required String databaseId,
    required String tableId,
    required String rowId,
    required Map<String, dynamic> data,
  }) async {
    await _databases.createDocument(
      databaseId: databaseId,
      collectionId: tableId,
      documentId: rowId,
      data: data,
    );
  }

  Future<void> updateRow({
    required String databaseId,
    required String tableId,
    required String rowId,
    required Map<String, dynamic> data,
  }) async {
    await _databases.updateDocument(
      databaseId: databaseId,
      collectionId: tableId,
      documentId: rowId,
      data: data,
    );
  }

  Future<void> deleteRow({
    required String databaseId,
    required String tableId,
    required String rowId,
  }) async {
    await _databases.deleteDocument(
      databaseId: databaseId,
      collectionId: tableId,
      documentId: rowId,
    );
  }

  Future<models.DocumentList> listRows({
    required String databaseId,
    required String tableId,
    List<String>? queries,
  }) async {
    return await _databases.listDocuments(
      databaseId: databaseId,
      collectionId: tableId,
      queries: queries,
    );
  }

  Future<models.Document> getRow({
    required String databaseId,
    required String tableId,
    required String rowId,
  }) async {
    return await _databases.getDocument(
      databaseId: databaseId,
      collectionId: tableId,
      documentId: rowId,
    );
  }
}
