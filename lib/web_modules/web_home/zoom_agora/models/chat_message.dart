enum ChatScope { everyone, coHosts, direct }

class ChatMessage {
  final String id;
  final int fromUid;
  final String fromName;
  final int? toUid;     // null when scope != direct
  final ChatScope scope;
  final String text;
  final DateTime sentAt;
  final List<String> attachments; // urls
  final Map<String, Set<int>> reactions; // emoji -> uids
  bool edited;
  bool deleted;
  ChatMessage({
    required this.id,
    required this.fromUid,
    required this.fromName,
    required this.text,
    required this.sentAt,
    this.toUid,
    this.scope = ChatScope.everyone,
    this.attachments = const [],
    Map<String, Set<int>>? reactions,
    this.edited = false,
    this.deleted = false,
  }) : reactions = reactions ?? {};

  Map<String, dynamic> toJson() => {
    'id': id, 'fromUid': fromUid, 'fromName': fromName, 'toUid': toUid,
    'scope': scope.name, 'text': text, 'sentAt': sentAt.millisecondsSinceEpoch,
    'attachments': attachments,
  };

  factory ChatMessage.fromJson(Map<String, dynamic> j) => ChatMessage(
    id: j['id'] as String,
    fromUid: j['fromUid'] as int,
    fromName: j['fromName'] as String,
    toUid: j['toUid'] as int?,
    scope: ChatScope.values.firstWhere((s) => s.name == j['scope'], orElse: () => ChatScope.everyone),
    text: j['text'] as String,
    sentAt: DateTime.fromMillisecondsSinceEpoch(j['sentAt'] as int),
    attachments: (j['attachments'] as List?)?.cast<String>() ?? const [],
  );
}
