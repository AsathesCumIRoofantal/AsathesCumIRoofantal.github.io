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
}
