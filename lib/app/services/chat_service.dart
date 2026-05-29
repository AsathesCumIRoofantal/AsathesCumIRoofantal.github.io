// ============================================================
//  AIR App – Chat Service  (Dummy + Supabase Realtime ready)
// ============================================================
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';
import '../../core/network/api_client.dart';

abstract class IChatService {
  Future<List<ChatRoomModel>>    getRooms();
  Future<List<ChatMessageModel>> getMessages(String roomId, {int page = 0});
  Future<ChatMessageModel?>      sendMessage(ChatMessageModel msg);
  Future<void>                   markSeen(String roomId, String messageId);
  Stream<ChatMessageModel>       listenMessages(String roomId);
}

class ChatService extends GetxService implements IChatService {
  static ChatService get to => Get.find();

  // ── Dummy in-memory store ────────────────────────────────
  final _rooms    = DummyChatRooms.rooms;
  final _messages = <String, List<ChatMessageModel>>{};

  @override
  void onInit() {
    super.onInit();
    _seedDummyMessages();
  }

  void _seedDummyMessages() {
    for (final room in _rooms) {
      _messages[room.id] = List.generate(20, (i) {
        final isMine = i % 3 != 0;
        final now    = DateTime.now().millisecondsSinceEpoch - (i * 60000);
        return ChatMessageModel(
          id:         'msg_${room.id}_$i',
          chatId:     room.id,
          senderId:   isMine ? 'usr_demo_001' : 'usr_other_$i',
          senderName: isMine ? 'You'          : 'User ${i + 1}',
          type:       i % 7 == 0 ? MessageType.image : MessageType.text,
          content:    i % 7 == 0 ? null : [
            'Hey! How are you?', 'Meeting confirmed ✅', 'Please check the file.',
            'On my way 🚗', 'Call you in 5 mins', 'Done! 🎉',
          ][i % 6],
          mediaUrl:   i % 7 == 0 ? 'https://picsum.photos/seed/$i/400/300' : null,
          status:     MessageStatus.seen,
          createdAt:  now,
          updatedAt:  now,
        );
      });
    }
  }

  @override
  Future<List<ChatRoomModel>> getRooms() async {
    if (AppConstants.isDummyMode) {
      await Future.delayed(const Duration(milliseconds: 300));
      return _rooms;
    }
    final data = await ApiClient.to.get('chat_rooms',
        query: {'order': 'last_message_at.desc', 'limit': '${AppConstants.defaultPageSize}'});
    return (data as List).map((j) => ChatRoomModel.fromJson(j)).toList();
  }

  @override
  Future<List<ChatMessageModel>> getMessages(String roomId, {int page = 0}) async {
    if (AppConstants.isDummyMode) {
      await Future.delayed(const Duration(milliseconds: 200));
      return _messages[roomId] ?? [];
    }
    final offset = page * AppConstants.chatMessagePageSize;
    final data   = await ApiClient.to.get('chat_messages', query: {
      'chat_id': 'eq.$roomId',
      'order':   'created_at.desc',
      'limit':   '${AppConstants.chatMessagePageSize}',
      'offset':  '$offset',
    });
    return (data as List).map((j) => ChatMessageModel.fromJson(j)).toList();
  }

  @override
  Future<ChatMessageModel?> sendMessage(ChatMessageModel msg) async {
    if (AppConstants.isDummyMode) {
      await Future.delayed(const Duration(milliseconds: 150));
      final sent = msg.copyWith(status: MessageStatus.delivered);
      _messages[msg.chatId] = [sent, ...(_messages[msg.chatId] ?? [])];
      return sent;
    }
    final data = await ApiClient.to.post('chat_messages', msg.toJson());
    return ChatMessageModel.fromJson(data);
  }

  @override
  Future<void> markSeen(String roomId, String messageId) async {
    if (AppConstants.isDummyMode) return;
    await ApiClient.to.patch('chat_messages',
        {'status': 'seen', 'updated_at': DateTime.now().millisecondsSinceEpoch},
        query: {'id': 'eq.$messageId'});
  }

  @override
  Stream<ChatMessageModel> listenMessages(String roomId) {
    // TODO: replace with Supabase realtime subscription
    // supabase.from('chat_messages').stream(primaryKey: ['id']).eq('chat_id', roomId)
    return Stream.empty();
  }
}
