import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'community_service.dart';
import '../services/current_user.dart';

class CommunityController extends GetxController {
  final _svc = CommunityService();

  final rooms          = <Map<String, dynamic>>[].obs;
  final isLoadingRooms = false.obs;

  // Active room
  final activeRoomId    = RxnString();
  final messages        = <Map<String, dynamic>>[].obs;
  final isLoadingMsgs   = false.obs;
  final hasMoreMessages = true.obs;

  // Search
  final searchResults   = <Map<String, dynamic>>[].obs;

  RealtimeChannel? _liveChannel;

  @override
  void onInit() {
    super.onInit();
    if (CurrentUser.isSignedIn) loadRooms();
  }

  // ── Rooms ───────────────────────────────────────────────────────────

  Future<void> loadRooms() async {
    if (!CurrentUser.isSignedIn) return;
    isLoadingRooms.value = true;
    try {
      final list = await _svc.listRooms(CurrentUser.id);
      rooms.assignAll(list);
    } catch (e) {
      Get.snackbar('Error', 'Could not load rooms: $e');
    } finally {
      isLoadingRooms.value = false;
    }
  }

  Future<void> openRoom(String roomId) async {
    if (activeRoomId.value == roomId) return;
    _unsubscribe();
    activeRoomId.value = roomId;
    messages.clear();
    hasMoreMessages.value = true;
    await loadMessages(roomId);
    _subscribeRoom(roomId);
  }

  // ── Messages ─────────────────────────────────────────────────────────

  Future<void> loadMessages(String roomId) async {
    isLoadingMsgs.value = true;
    try {
      final oldest = messages.isNotEmpty
          ? messages.first['created_at'] as int?
          : null;
      final batch = await _svc.loadMessages(roomId, before: oldest);
      if (batch.isEmpty) {
        hasMoreMessages.value = false;
      } else {
        messages.insertAll(0, batch);
      }
    } finally {
      isLoadingMsgs.value = false;
    }
  }

  Future<void> sendMessage(
    String text, {
    String type = 'text',
    String? mediaUrl,
    String? mediaName,
    int? mediaSize,
    String? replyToId,
  }) async {
    final roomId = activeRoomId.value;
    if (roomId == null || !CurrentUser.isSignedIn) return;
    if (text.trim().isEmpty && mediaUrl == null) return;

    final msg = await _svc.sendMessage(
      roomId: roomId,
      senderId: CurrentUser.id,
      senderName: CurrentUser.name,
      type: type,
      text: text.trim().isEmpty ? null : text.trim(),
      mediaUrl: mediaUrl,
      mediaName: mediaName,
      mediaSize: mediaSize,
      replyToId: replyToId,
    );
    // Realtime will add it via subscription; add locally for instant feedback
    if (!messages.any((m) => m['id'] == msg['id'])) {
      messages.add(msg);
    }
  }

  Future<void> deleteMessage(String msgId) =>
      _svc.deleteMessage(msgId).then((_) {
        final idx = messages.indexWhere((m) => m['id'] == msgId);
        if (idx != -1) {
          messages[idx] = {...messages[idx], 'is_deleted': 1, 'content': 'This message was deleted'};
        }
      });

  Future<void> editMessage(String msgId, String newContent) async {
    await _svc.editMessage(msgId, newContent, CurrentUser.id);
    final idx = messages.indexWhere((m) => m['id'] == msgId);
    if (idx != -1) {
      messages[idx] = {...messages[idx], 'content': newContent, 'is_edited': 1};
    }
  }

  Future<List<Map<String, dynamic>>> messageHistory(String msgId) =>
      _svc.messageHistory(msgId);

  // ── Search ───────────────────────────────────────────────────────────

  Future<void> searchUsers(String query) async {
    searchResults.assignAll(await _svc.searchUsers(query));
  }

  // ── Create room ───────────────────────────────────────────────────────

  Future<void> createRoom({
    required String name,
    required String type,
    required List<String> memberIds,
    String? avatarUrl,
  }) async {
    if (!CurrentUser.isSignedIn) return;
    final allMembers = {...memberIds, CurrentUser.id}.toList();
    await _svc.createRoom(
      name: name, type: type,
      memberIds: allMembers, createdBy: CurrentUser.id,
      avatarUrl: avatarUrl,
    );
    await loadRooms();
  }

  // ── Realtime ──────────────────────────────────────────────────────────

  void _subscribeRoom(String roomId) {
    _liveChannel = _svc.subscribeRoom(
      roomId,
      onInsert: (row) {
        if (!messages.any((m) => m['id'] == row['id'])) messages.add(row);
      },
      onUpdate: (row) {
        final idx = messages.indexWhere((m) => m['id'] == row['id']);
        if (idx != -1) messages[idx] = row;
      },
    )..subscribe();
  }

  void _unsubscribe() {
    if (_liveChannel != null) {
      Supabase.instance.client.removeChannel(_liveChannel!);
      _liveChannel = null;
    }
  }

  @override
  void onClose() {
    _unsubscribe();
    super.onClose();
  }
}
