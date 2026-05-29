// ============================================================
//  AIR App – Chat Room Controller (single conversation)
// ============================================================
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../../models/chat_message_model.dart';
import '../../../models/chat_room_model.dart';
import '../../../services/auth_service_new.dart';
import '../../../services/chat_service.dart';

class ChatRoomController extends GetxController {
  final ChatRoomModel room;
  ChatRoomController({required this.room});

  final RxList<ChatMessageModel> messages     = <ChatMessageModel>[].obs;
  final RxBool isLoading                      = false.obs;
  final RxBool isSending                      = false.obs;
  final RxBool isTyping                       = false.obs;  // remote user typing
  final Rx<ChatMessageModel?> replyTo         = Rx(null);
  final RxString recordingState               = ''.obs; // '' | 'recording'
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final _uuid = const Uuid();

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> fetchMessages() async {
    isLoading.value = true;
    try {
      messages.value = await ChatService.to.getMessages(room.id);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendTextMessage() async {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    textController.clear();

    final now = DateTime.now().millisecondsSinceEpoch;
    final msg = ChatMessageModel(
      id:         _uuid.v4(),
      chatId:     room.id,
      senderId:   AirAuthService.to.currentUser.value?.userId ?? 'me',
      senderName: AirAuthService.to.currentUser.value?.name  ?? 'You',
      type:       MessageType.text,
      content:    text,
      replyToId:  replyTo.value?.id,
      status:     MessageStatus.sending,
      createdAt:  now,
      updatedAt:  now,
    );
    messages.insert(0, msg);
    cancelReply();
    _scrollToBottom();

    isSending.value = true;
    try {
      final sent = await ChatService.to.sendMessage(msg);
      if (sent != null) {
        final idx = messages.indexWhere((m) => m.id == msg.id);
        if (idx != -1) messages[idx] = sent;
      }
    } finally {
      isSending.value = false;
    }
  }

  void setReply(ChatMessageModel msg) => replyTo.value = msg;
  void cancelReply()                  => replyTo.value = null;

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }
}
