import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'social_service.dart';
import '../services/current_user.dart';

class SocialController extends GetxController {
  final _svc = SocialService();

  final posts       = <Map<String, dynamic>>[].obs;
  final isLoading   = false.obs;
  final hasMore     = true.obs;
  int _page         = 0;

  // Active post comments
  final comments    = <Map<String, dynamic>>[].obs;
  final isLoadingComments = false.obs;

  RealtimeChannel? _feedChannel;
  RealtimeChannel? _commentChannel;

  @override
  void onInit() {
    super.onInit();
    loadFeed();
    _subscribeToFeed();
  }

  // ── Feed ─────────────────────────────────────────────────────────────

  Future<void> loadFeed({bool refresh = false}) async {
    if (refresh) { _page = 0; posts.clear(); hasMore.value = true; }
    if (!hasMore.value || isLoading.value) return;
    isLoading.value = true;
    try {
      final batch = await _svc.loadFeed(page: _page);
      if (batch.isEmpty) {
        hasMore.value = false;
      } else {
        posts.addAll(batch);
        _page++;
      }
    } catch (e) {
      Get.snackbar('Feed error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createPost({
    required String content,
    List<String> mediaUrls = const [],
    List<String> mediaTypes = const [],
  }) async {
    if (!CurrentUser.isSignedIn) return;
    final post = await _svc.createPost(
      authorId:   CurrentUser.id,
      authorName: CurrentUser.name,
      content:    content.trim().isEmpty ? null : content.trim(),
      mediaUrls:  mediaUrls,
      mediaTypes: mediaTypes,
    );
    posts.insert(0, post);
  }

  Future<void> deletePost(String postId) async {
    await _svc.deletePost(postId);
    posts.removeWhere((p) => p['id'] == postId);
  }

  // ── Reactions ──────────────────────────────────────────────────────────

  Future<void> toggleReaction(String postId, String emoji) async {
    if (!CurrentUser.isSignedIn) return;
    final idx = posts.indexWhere((p) => p['id'] == postId);
    if (idx == -1) return;

    final counts = Map<String, dynamic>.from(
        (posts[idx]['reaction_counts'] as Map?)?.cast<String, dynamic>() ?? {});
    final userReacted = (posts[idx]['user_reacted'] as String?) == emoji;

    if (userReacted) {
      await _svc.removeReaction(postId, CurrentUser.id);
      final cur = (counts[emoji] as int? ?? 1) - 1;
      counts[emoji] = cur < 0 ? 0 : cur;
      posts[idx] = {...posts[idx], 'reaction_counts': counts, 'user_reacted': null};
    } else {
      await _svc.reactToPost(postId, CurrentUser.id, emoji);
      counts[emoji] = (counts[emoji] as int? ?? 0) + 1;
      posts[idx] = {...posts[idx], 'reaction_counts': counts, 'user_reacted': emoji};
    }
  }

  // ── Comments ───────────────────────────────────────────────────────────

  Future<void> loadComments(String postId) async {
    isLoadingComments.value = true;
    try {
      final list = await _svc.loadComments(postId);
      comments.assignAll(list);
    } finally {
      isLoadingComments.value = false;
    }
    _commentChannel?.unsubscribe();
    _commentChannel = _svc.subscribeComments(postId, onNew: (row) {
      if (!comments.any((c) => c['id'] == row['id'])) comments.add(row);
    })..subscribe();
  }

  Future<void> addComment({
    required String postId,
    required String content,
    String? parentId,
  }) async {
    if (!CurrentUser.isSignedIn || content.trim().isEmpty) return;
    final c = await _svc.addComment(
      postId: postId,
      authorId: CurrentUser.id,
      authorName: CurrentUser.name,
      content: content.trim(),
      parentId: parentId,
    );
    if (!comments.any((x) => x['id'] == c['id'])) comments.add(c);
    // Update comment_count locally
    final idx = posts.indexWhere((p) => p['id'] == postId);
    if (idx != -1) {
      posts[idx] = {
        ...posts[idx],
        'comment_count': (posts[idx]['comment_count'] as int? ?? 0) + 1,
      };
    }
  }

  Future<void> deleteComment(String commentId) async {
    await _svc.deleteComment(commentId);
    comments.removeWhere((c) => c['id'] == commentId);
  }

  // ── Realtime ──────────────────────────────────────────────────────────

  void _subscribeToFeed() {
    _feedChannel = _svc.subscribeFeed(
      onNew: (row) {
        if (!posts.any((p) => p['id'] == row['id'])) posts.insert(0, row);
      },
      onUpdate: (row) {
        final idx = posts.indexWhere((p) => p['id'] == row['id']);
        if (idx != -1) posts[idx] = row;
      },
    )..subscribe();
  }

  @override
  void onClose() {
    _feedChannel?.unsubscribe();
    _commentChannel?.unsubscribe();
    super.onClose();
  }
}
