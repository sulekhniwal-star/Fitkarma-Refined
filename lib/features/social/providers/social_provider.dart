import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../../core/config/app_config.dart';
import '../../auth/providers/auth_provider.dart';

import 'package:appwrite/appwrite.dart';
import '../repositories/social_repository.dart';

part 'social_provider.g.dart';

@riverpod
class SocialFeedNotifier extends _$SocialFeedNotifier {
  @override
  Stream<List<dynamic>> build({int limit = 20, int offset = 0}) {
    return ref.watch(appDatabaseProvider).watchSocialFeed(limit: limit, offset: offset);
  }

  Future<void> createPost({required String content, String? mediaFileId}) async {
    final authState = ref.read(authProvider);
    final user = authState.asData?.value;
    if (user == null) return;

    final db = ref.read(appDatabaseProvider);
    final id = const Uuid().v4();

    final companion = SocialPostsCompanion.insert(
      id: id,
      userId: user.$id,
      userName: user.name,
      userAvatarId: const Value.absent(), 
      content: content,
      mediaFileId: Value(mediaFileId),
      createdAt: DateTime.now(),
      syncStatus: const Value('pending'),
    );

    await db.into(db.socialPosts).insert(companion);
    
    _pushToRemote(id);
  }

  Future<void> likePost(String postId) async {
    final db = ref.read(appDatabaseProvider);
    final post = await (db.select(db.socialPosts)..where((t) => t.id.equals(postId))).getSingle();
    
    await (db.update(db.socialPosts)..where((t) => t.id.equals(postId))).write(
      SocialPostsCompanion(
        isLiked: Value(!post.isLiked),
        likeCount: Value(post.isLiked ? post.likeCount - 1 : post.likeCount + 1),
        syncStatus: const Value('pending'),
      ),
    );
    
    _pushToRemote(postId);
  }

  Future<void> _pushToRemote(String id) async {
    try {
      await ref.read(socialRepositoryProvider).pushPostToRemote(id);
    } catch (_) {}
  }
}

@riverpod
Stream<RealtimeMessage> socialRealtime(Ref ref) {
  final realtime = ref.watch(appwriteRealtimeProvider);
  return realtime.subscribe([
    'databases.${AppConfig.dbId}.collections.${AppConfig.postsCol}.documents'
  ]).stream;
}

@riverpod
Stream<List<dynamic>> communityGroups(Ref ref) {
  return ref.watch(appDatabaseProvider).watchAllGroups();
}

@riverpod
Stream<List<dynamic>> myGroups(Ref ref) {
  return ref.watch(appDatabaseProvider).watchJoinedGroups();
}

@riverpod
class GroupsNotifier extends _$GroupsNotifier {
  @override
  void build() {}

  Future<void> joinGroup(String groupId) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.communityGroups)..where((t) => t.id.equals(groupId))).write(
      const CommunityGroupsCompanion(isJoined: Value(true)),
    );
  }

  Future<void> leaveGroup(String groupId) async {
    final db = ref.read(appDatabaseProvider);
    await (db.update(db.communityGroups)..where((t) => t.id.equals(groupId))).write(
      const CommunityGroupsCompanion(isJoined: Value(false)),
    );
  }
}
