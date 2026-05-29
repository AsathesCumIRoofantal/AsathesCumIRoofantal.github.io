// ============================================================
//  AIR App – Meeting List Controller
// ============================================================
import 'package:get/get.dart';
import '../../../models/meeting_model.dart';
import '../../../services/meeting_service.dart';

class MeetingListController extends GetxController {
  static MeetingListController get to => Get.find();

  final RxList<MeetingModel> meetings   = <MeetingModel>[].obs;
  final RxBool  isLoading               = false.obs;
  final RxString activeTab              = 'upcoming'.obs; // upcoming | live | ended

  List<MeetingModel> get filtered => meetings.where((m) {
    switch (activeTab.value) {
      case 'live':     return m.status == MeetingStatus.live;
      case 'ended':    return m.status == MeetingStatus.ended;
      default:         return m.status == MeetingStatus.scheduled;
    }
  }).toList();

  @override
  void onInit() {
    super.onInit();
    fetchMeetings();
  }

  Future<void> fetchMeetings() async {
    isLoading.value = true;
    try {
      meetings.value = await MeetingService.to.getMeetings();
    } finally {
      isLoading.value = false;
    }
  }

  void setTab(String tab) => activeTab.value = tab;
}
