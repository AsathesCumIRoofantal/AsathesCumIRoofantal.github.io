import 'package:supabase_flutter/supabase_flutter.dart';

/// Thin wrapper around `chat_rooms` + `chat_messages` Supabase tables.
/// Powers the WhatsApp-style community / group / DM module.
class CommunityService {
  CommunityService({SupabaseClient? client})
      : _db = client ?? Supabase.instance.client;

  final SupabaseClient _db;

  static int _now() => DateTime.now().millisecondsSinceEpoch;

  // ── Rooms ─────────────────────────────────────────────────────────────

  /// Lists all rooms the current user is a member of, newest activity first.
  Future<List<Map<String, dynamic>>> listRooms(String userId) async {
    final rows = await _db
        .from('chat_rooms')
        .select()
        .contains('member_ids', [userId])
        .order('last_message_at', ascending: false);
    return (rows as List).cast<Map<String, dynamic>>();
  }

  /// Creates a new individual / group / broadcast room.
  Future<Map<String, dynamic>> createRoom({
    required String name,
    required String type,          // 'individual' | 'group' | 'broadcast'
    required List<String> memberIds,
    required String createdBy,
    String? avatarUrl,
  }) async {
    final row = await _db.from('chat_rooms').insert({
      'type':       type,
      'name':       name,
      'member_ids': memberIds,
      'admin_ids':  [createdBy],
      'avatar_url': avatarUrl,
      'created_by': createdBy,
    }).select().single();
    return row as Map<String, dynamic>;
  }

  /// Searches users by name or mobile prefix (for invite picker).
  Future<List<Map<String, dynamic>>> searchUsers(String query) async {
    if (query.trim().isEmpty) return [];
    final rows = await _db
        .from('user_table')
        .select('user_id, name, mobile, profile_photo_url')
        .or('name.ilike.%$query%,mobile.ilike.%$query%')
        .limit(20);
    return (rows as List).cast<Map<String, dynamic>>();
  }

  // ── Messages ──────────────────────────────────────────────────────────

  /// Loads the most recent [limit] messages in a room, older-first.
  Future<List<Map<String, dynamic>>> loadMessages(
    String roomId, {
    int limit = 40,
    int? before, // epoch ms — for pagination
  }) async {
    var query = _db
        .from('chat_messages')
        .select()
        .eq('chat_id', roomId)
        .eq('is_deleted', 0)
        .order('created_at', ascending: false)
        .limit(limit);
    if (before != null) {
      query = query.lt('created_at', before);
    }
    final rows = await query;
    return (rows as List).cast<Map<String, dynamic>>().reversed.toList();
  }

  /// Sends a message and returns the inserted row.
  Future<Map<String, dynamic>> sendMessage({
    required String roomId,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String type = 'text',          // text | image | video | audio | file | location
    String? text,
    String? mediaUrl,
    String? mediaName,
    int? mediaSize,
    String? replyToId,
  }) async {
    final row = await _db.from('chat_messages').insert({
      'chat_id':       roomId,
      'sender_id':     senderId,
      'sender_name':   senderName,
      'sender_avatar': senderAvatar,
      'type':          type,
      'content':       text,
      'media_url':     mediaUrl,
      'media_name':    mediaName,
      'media_size':    mediaSize,
      'reply_to_id':   replyToId,
      'status':        'sent',
    }).select().single();
    return row as Map<String, dynamic>;
  }

  /// Soft-deletes a message (sets is_deleted = 1).
  Future<void> deleteMessage(String messageId) =>
      _db.from('chat_messages')
          .update({'is_deleted': 1}).eq('id', messageId);

  /// Edits a message — saves old content to `chat_message_edits` first.
  Future<void> editMessage(String messageId, String newContent, String editorId) async {
    // Fetch current content
    final row = await _db
        .from('chat_messages')
        .select('content')
        .eq('id', messageId)
        .single();
    final oldContent = (row as Map<String, dynamic>)['content'] as String? ?? '';

    // Archive old version
    await _db.from('chat_message_edits').insert({
      'message_id': messageId,
      'old_content': oldContent,
      'edited_by': editorId,
      'edited_at': _now(),
    });

    // Apply edit
    await _db.from('chat_messages')
        .update({'content': newContent, 'is_edited': 1}).eq('id', messageId);
  }

  /// Returns the edit history for a message.
  Future<List<Map<String, dynamic>>> messageHistory(String messageId) async {
    final rows = await _db
        .from('chat_message_edits')
        .select()
        .eq('message_id', messageId)
        .order('edited_at', ascending: false);
    return (rows as List).cast<Map<String, dynamic>>();
  }

  // ── Realtime ──────────────────────────────────────────────────────────

  /// Returns a live Supabase Realtime channel for a room.
  /// Caller must call `.subscribe()` and `.unsubscribe()` themselves.
  RealtimeChannel subscribeRoom(
    String roomId, {
    required void Function(Map<String, dynamic>) onInsert,
    required void Function(Map<String, dynamic>) onUpdate,
  }) {
    return _db
        .channel('room:$roomId')
        .onPostgresChanges(
          event: PostgresChangeEvent.insert,
          schema: 'public',
          table: 'chat_messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: roomId,
          ),
          callback: (p) => onInsert(p.newRecord),
        )
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'chat_messages',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'chat_id',
            value: roomId,
          ),
          callback: (p) => onUpdate(p.newRecord),
        );
  }
}
