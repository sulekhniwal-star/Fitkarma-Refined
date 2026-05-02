import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/tables_db.dart';
import '../../../core/config/app_config.dart';
import '../../../core/providers/core_providers.dart';

class SocialRepository {
  final AppDatabase _db;
  final TablesDB _tables;

  SocialRepository(this._db, this._tables);

  Future<void> pushPostToRemote(String localId) async {
    try {
      final post = await (_db.select(_db.socialPosts)..where((t) => t.id.equals(localId))).getSingle();
      
      await _tables.createRow(
        databaseId: AppConfig.dbId,
        tableId: AppConfig.postsCol,
        rowId: post.id,
        data: {
          'userId': post.userId,
          'userName': post.userName,
          'userAvatarId': post.userAvatarId,
          'content': post.content,
          'mediaFileId': post.mediaFileId,
          'likeCount': post.likeCount,
          'commentCount': post.commentCount,
          'createdAt': post.createdAt.toIso8601String(),
        },
      );

      await _db.markSynced(localId, post.id, 'social_posts');
    } catch (e) {
      await _db.incrementFailedAttempts(localId, 'social_posts');
      rethrow;
    }
  }

  Future<void> syncGroups() async {
    // In a real app, we would fetch groups from Appwrite and update local DB
    // For now, this is a placeholder
  }
}

final socialRepositoryProvider = Provider<SocialRepository>((ref) {
  return SocialRepository(
    ref.read(appDatabaseProvider),
    ref.read(appwriteTablesDBProvider),
  );
});
