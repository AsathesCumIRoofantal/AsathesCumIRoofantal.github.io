// ============================================================
//  AIR App – Chat Room Model
// ============================================================
enum ChatRoomType { individual, group, broadcast }

class ChatRoomModel {
  final String       id;
  final ChatRoomType type;
  final String       name;
  final String?      avatarUrl;
  final List<String> memberIds;
  final List<String> adminIds;
  final String?      lastMessagePreview;
  final int?         lastMessageAt;
  final int          unreadCount;
  final bool         isMuted;
  final bool         isPinned;
  final bool         isArchived;
  final int          createdAt;
  final int          updatedAt;

  const ChatRoomModel({
    required this.id,
    required this.type,
    required this.name,
    this.avatarUrl,
    this.memberIds  = const [],
    this.adminIds   = const [],
    this.lastMessagePreview,
    this.lastMessageAt,
    this.unreadCount = 0,
    this.isMuted    = false,
    this.isPinned   = false,
    this.isArchived = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> j) => ChatRoomModel(
    id:                 j['id']                  as String,
    type:               ChatRoomType.values.firstWhere((e) => e.name == j['type'], orElse: () => ChatRoomType.individual),
    name:               j['name']                as String,
    avatarUrl:          j['avatar_url']          as String?,
    memberIds:          (j['member_ids']         as List? ?? []).cast<String>(),
    adminIds:           (j['admin_ids']          as List? ?? []).cast<String>(),
    lastMessagePreview: j['last_message_preview'] as String?,
    lastMessageAt:      j['last_message_at']     as int?,
    unreadCount:        j['unread_count']         as int? ?? 0,
    isMuted:            (j['is_muted']            as int? ?? 0) == 1,
    isPinned:           (j['is_pinned']           as int? ?? 0) == 1,
    isArchived:         (j['is_archived']         as int? ?? 0) == 1,
    createdAt:          j['created_at']           as int,
    updatedAt:          j['updated_at']           as int,
  );
}

// ── Dummy Data Factory ─────────────────────────────────────
class DummyChatRooms {
  static final List<ChatRoomModel> rooms = List.generate(12, (i) {
    final now = DateTime.now().millisecondsSinceEpoch;
    final isGroup = i % 3 == 0;
    return ChatRoomModel(
      id:          'room_$i',
      type:        isGroup ? ChatRoomType.group : ChatRoomType.individual,
      name:        isGroup ? 'Team ${['Alpha','Beta','Gamma','Delta'][i % 4]}' : 'User ${i + 1}',
      lastMessagePreview: ['Hey, how are you?', 'Meeting at 3pm', 'File shared 📎', 'Voice note 🎙️'][i % 4],
      lastMessageAt: now - (i * 3600000),
      unreadCount: i % 5,
      isPinned:    i == 0,
      createdAt:   now - (i * 86400000),
      updatedAt:   now - (i * 3600000),
    );
  });
}
