// ============================================================
//  AIR App – Dashboard Controller
// ============================================================
import 'package:get/get.dart';
import '../../../models/meeting_model.dart';
import '../../../models/chat_room_model.dart';
import '../../../models/remote_support_model.dart';
import '../../../services/auth_service_new.dart';
import '../../../services/chat_service.dart';
import '../../../services/meeting_service.dart';
import '../../../services/remote_support_service.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find();

  final RxInt    selectedIndex  = 0.obs;  // bottom-nav / sidebar index
  final RxBool   isLoading      = false.obs;

  // ── Summary stats ─────────────────────────────────────
  final RxInt  totalChats       = 0.obs;
  final RxInt  unreadMessages   = 0.obs;
  final RxInt  activeMeetings   = 0.obs;
  final RxInt  onlineDevices    = 0.obs;

  final RxList<MeetingModel>   upcomingMeetings = <MeetingModel>[].obs;
  final RxList<ChatRoomModel>  recentChats      = <ChatRoomModel>[].obs;
  final RxList<RemoteDevice>   pairedDevices    = <RemoteDevice>[].obs;

  String get greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good Morning';
    if (h < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  String get userName =>
      AirAuthService.to.currentUser.value?.name.split(' ').first ?? 'User';

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    isLoading.value = true;
    try {
      final results = await Future.wait([
        ChatService.to.getRooms(),
        MeetingService.to.getMeetings(),
        RemoteSupportService.to.getDevices(),
      ]);

      recentChats.value     = (results[0] as List<ChatRoomModel>).take(5).toList();
      upcomingMeetings.value = (results[1] as List<MeetingModel>)
          .where((m) => m.status != MeetingStatus.ended).take(3).toList();
      pairedDevices.value   = results[2] as List<RemoteDevice>;

      unreadMessages.value  = recentChats.fold(0, (s, r) => s + r.unreadCount);
      activeMeetings.value  = upcomingMeetings
          .where((m) => m.status == MeetingStatus.live).length;
      onlineDevices.value   = pairedDevices
          .where((d) => d.status == DeviceStatus.online).length;
      totalChats.value      = recentChats.length;
    } finally {
      isLoading.value = false;
    }
  }

  void navigate(int index) => selectedIndex.value = index;
}
