import 'package:supabase_flutter/supabase_flutter.dart';

class SocialService {
  SocialService({SupabaseClient? client})
      : _db = client ?? Supabase.instance.client;

  final SupabaseClient _db;

  static int _now() => DateTime.now().millisecondsSinceEpoch;

  // ── Posts ──────────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> loadFeed({int page = 0, int limit = 10}) async {
    final rows = await _db
        .from('social_posts')
        .select()
        .eq('is_deleted', 0)
        .order('created_at', ascending: false)
        .range(page * limit, (page + 1) * limit - 1);
    return (rows as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> createPost({
    required String authorId,
    required String authorName,
    String? content,
    List<String> mediaUrls = const [],
    List<String> mediaTypes = const [],
    String visibility = 'public',
    String? communityId,
  }) async {
    final row = await _db.from('social_posts').insert({
      'author_id':    authorId,
      'author_name':  authorName,
      'content':      content,
      'media_urls':   mediaUrls,
      'media_types':  mediaTypes,
      'visibility':   visibility,
      'community_id': communityId,
    }).select().single();
    return row as Map<String, dynamic>;
  }

  Future<void> deletePost(String postId) =>
      _db.from('social_posts').update({'is_deleted': 1}).eq('id', postId);

  Future<void> updatePost(String postId, String newContent) =>
      _db.from('social_posts').update({'content': newContent}).eq('id', postId);

  // ── Reactions ──────────────────────────────────────────────────────────

  Future<void> reactToPost(String postId, String userId, String emoji) async {
    await _db.from('social_reactions').upsert({
      'target_id':   postId,
      'target_type': 'post',
      'user_id':     userId,
      'emoji':       emoji,
    }, onConflict: 'target_id,user_id');
    // Update reaction_counts JSONB via RPC or inline
    await _db.rpc('increment_post_reaction', params: {
      'p_post_id': postId,
      'p_emoji':   emoji,
    });
  }

  Future<void> removeReaction(String postId, String userId) async {
    final existing = await _db
        .from('social_reactions')
        .select('emoji')
        .eq('target_id', postId)
        .eq('user_id', userId)
        .maybeSingle();
    if (existing == null) return;
    final emoji = (existing as Map<String, dynamic>)['emoji'] as String? ?? '👍';
    await _db.from('social_reactions')
        .delete().eq('target_id', postId).eq('user_id', userId);
    await _db.rpc('decrement_post_reaction', params: {
      'p_post_id': postId,
      'p_emoji': emoji,
    });
  }

  // ── Comments ───────────────────────────────────────────────────────────

  Future<List<Map<String, dynamic>>> loadComments(String postId) async {
    final rows = await _db
        .from('social_comments')
        .select()
        .eq('post_id', postId)
        .eq('is_deleted', 0)
        .order('created_at', ascending: true);
    return (rows as List).cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> addComment({
    required String postId,
    required String authorId,
    required String authorName,
    required String content,
    String? parentId,
    String? mediaUrl,
  }) async {
    final row = await _db.from('social_comments').insert({
      'post_id':     postId,
      'parent_id':   parentId,
      'author_id':   authorId,
      'author_name': authorName,
      'content':     content,
      'media_url':   mediaUrl,
    }).select().single();
    // Increment comment_count
    await _db.rpc('increment_post_comments', params: {'p_post_id': postId});
    return row as Map<String, dynamic>;
  }

  Future<void> deleteComment(String commentId) =>
      _db.from('social_comments').update({'is_deleted': 1}).eq('id', commentId);

  // ── Realtime feed subscription ─────────────────────────────────────────

  RealtimeChannel subscribeFeed({
    required void Function(Map<String, dynamic>) onNew,
    required void Function(Map<String, dynamic>) onUpdate,
  }) {
    return _db
        .channel('social_feed')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public', table: 'social_posts',
          callback: (p) => onNew(p.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public', table: 'social_posts',
          callback: (p) => onUpdate(p.newRecord),
        );
  }

  RealtimeChannel subscribeComments(String postId,
      {required void Function(Map<String, dynamic>) onNew}) {
    return _db
        .channel('comments:$postId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public', table: 'social_comments',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'post_id', value: postId,
          ),
          callback: (p) => onNew(p.newRecord),
        );
  }
}
