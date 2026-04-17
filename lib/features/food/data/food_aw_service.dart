import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import '../../../core/network/appwrite_client.dart';
import '../../../core/constants/api_endpoints.dart';

class FoodAwService {
  final Databases _databases;

  FoodAwService({Databases? databases}) : _databases = databases ?? AppwriteClient.databases;

  /// Searches for food items in the remote Appwrite database.
  Future<List<models.Document>> searchRemote(String query) async {
    final response = await _databases.listDocuments(
      databaseId: AW.dbId,
      collectionId: AW.foodItems,
      queries: [
        Query.search('name', query),
        Query.limit(10),
      ],
    );
    return response.documents;
  }
}

