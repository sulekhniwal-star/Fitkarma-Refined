import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/core_providers.dart';
import '../../auth/providers/auth_provider.dart';

part 'social_provider.g.dart';

@riverpod
class SocialFeedNotifier extends _$SocialFeedNotifier {
  @override
  Stream<List<SocialPost>> build() {
    return ref.watch(appDatabaseProvider).watchSocialFeed();
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
    );

    await db.into(db.socialPosts).insert(companion);
  }

  Future<void> likePost(String postId) async {
    final db = ref.read(appDatabaseProvider);
    final post = await (db.select(db.socialPosts)..where((t) => t.id.equals(postId))).getSingle();
    
    await (db.update(db.socialPosts)..where((t) => t.id.equals(postId))).write(
      SocialPostsCompanion(
        isLiked: Value(!post.isLiked),
        likeCount: Value(post.isLiked ? post.likeCount - 1 : post.likeCount + 1),
      ),
    );
  }
}

@riverpod
Stream<void> socialRealtime(Ref ref) {
  // Realtime subscription placeholder
  return const Stream.empty();
}

@riverpod
Stream<List<CommunityGroup>> groups(Ref ref) {
  return ref.watch(appDatabaseProvider).watchAllGroups();
}

@riverpod
Stream<List<CommunityGroup>> myGroups(Ref ref) {
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
