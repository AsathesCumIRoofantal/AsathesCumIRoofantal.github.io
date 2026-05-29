// ============================================================
//  AIR App – Chat List Controller
// ============================================================
import 'package:get/get.dart';
import '../../../models/chat_room_model.dart';
import '../../../services/chat_service.dart';

class ChatListController extends GetxController {
  static ChatListController get to => Get.find();

  final RxList<ChatRoomModel> rooms      = <ChatRoomModel>[].obs;
  final RxList<ChatRoomModel> filtered   = <ChatRoomModel>[].obs;
  final RxBool  isLoading                = false.obs;
  final RxString searchQuery             = ''.obs;
  final RxString activeFilter            = 'all'.obs; // all | unread | groups

  @override
  void onInit() {
    super.onInit();
    fetchRooms();
    debounce(searchQuery, (_) => _applyFilter(), time: const Duration(milliseconds: 300));
    ever(activeFilter, (_) => _applyFilter());
  }

  Future<void> fetchRooms() async {
    isLoading.value = true;
    try {
      rooms.value = await ChatService.to.getRooms();
      _applyFilter();
    } finally {
      isLoading.value = false;
    }
  }

  void _applyFilter() {
    var list = rooms.toList();
    // Search filter
    final q = searchQuery.value.toLowerCase();
    if (q.isNotEmpty) {
      list = list.where((r) => r.name.toLowerCase().contains(q)).toList();
    }
    // Tab filter
    switch (activeFilter.value) {
      case 'unread': list = list.where((r) => r.unreadCount > 0).toList(); break;
      case 'groups': list = list.where((r) => r.type == ChatRoomType.group).toList();  break;
    }
    // Pinned first
    list.sort((a, b) {
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;
      return (b.lastMessageAt ?? 0).compareTo(a.lastMessageAt ?? 0);
    });
    filtered.value = list;
  }

  void onSearch(String q)     => searchQuery.value = q;
  void setFilter(String f)    => activeFilter.value = f;
  int  get totalUnread        => rooms.fold(0, (s, r) => s + r.unreadCount);
}
