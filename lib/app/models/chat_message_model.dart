// ============================================================
//  AIR App – Chat Message Model
// ============================================================
enum MessageType { text, image, video, audio, file, location, sticker }
enum MessageStatus { sending, sent, delivered, seen, failed }

class ChatMessageModel {
  final String        id;
  final String        chatId;
  final String        senderId;
  final String        senderName;
  final String?       senderAvatar;
  final MessageType   type;
  final String?       content;      // text body
  final String?       mediaUrl;     // image/video/file URL
  final String?       mediaName;
  final int?          mediaSizeBytes;
  final String?       replyToId;    // reply thread
  final List<String>  reactions;    // emoji list
  final MessageStatus status;
  final int           createdAt;    // epoch ms
  final int           updatedAt;
  final bool          isDeleted;

  const ChatMessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    required this.type,
    this.content,
    this.mediaUrl,
    this.mediaName,
    this.mediaSizeBytes,
    this.replyToId,
    this.reactions = const [],
    this.status    = MessageStatus.sending,
    required this.createdAt,
    required this.updatedAt,
    this.isDeleted = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> j) => ChatMessageModel(
    id:            j['id']           as String,
    chatId:        j['chat_id']      as String,
    senderId:      j['sender_id']    as String,
    senderName:    j['sender_name']  as String,
    senderAvatar:  j['sender_avatar'] as String?,
    type:          MessageType.values.firstWhere((e) => e.name == j['type'], orElse: () => MessageType.text),
    content:       j['content']      as String?,
    mediaUrl:      j['media_url']    as String?,
    mediaName:     j['media_name']   as String?,
    mediaSizeBytes: j['media_size']  as int?,
    replyToId:     j['reply_to_id']  as String?,
    reactions:     (j['reactions']   as List? ?? []).cast<String>(),
    status:        MessageStatus.values.firstWhere((e) => e.name == j['status'], orElse: () => MessageStatus.sent),
    createdAt:     j['created_at']   as int,
    updatedAt:     j['updated_at']   as int,
    isDeleted:     (j['is_deleted']  as int? ?? 0) == 1,
  );

  Map<String, dynamic> toJson() => {
    'id':           id,
    'chat_id':      chatId,
    'sender_id':    senderId,
    'sender_name':  senderName,
    'sender_avatar': senderAvatar,
    'type':         type.name,
    'content':      content,
    'media_url':    mediaUrl,
    'media_name':   mediaName,
    'media_size':   mediaSizeBytes,
    'reply_to_id':  replyToId,
    'reactions':    reactions,
    'status':       status.name,
    'created_at':   createdAt,
    'updated_at':   updatedAt,
    'is_deleted':   isDeleted ? 1 : 0,
  };

  ChatMessageModel copyWith({MessageStatus? status, List<String>? reactions}) =>
      ChatMessageModel(
        id: id, chatId: chatId, senderId: senderId, senderName: senderName,
        senderAvatar: senderAvatar, type: type, content: content,
        mediaUrl: mediaUrl, mediaName: mediaName, mediaSizeBytes: mediaSizeBytes,
        replyToId: replyToId, reactions: reactions ?? this.reactions,
        status: status ?? this.status, createdAt: createdAt, updatedAt: updatedAt,
        isDeleted: isDeleted,
      );
}
