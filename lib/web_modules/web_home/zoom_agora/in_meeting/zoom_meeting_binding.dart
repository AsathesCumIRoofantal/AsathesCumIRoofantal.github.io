import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
import '../mock/mock_data.dart';
import '../models/rtc_config.dart';
import '../services/rtc_backend_manager.dart';

/// Binds the controller, the RTC backend manager (Agora <-> WebRTC swap),
/// and seeds dummy users so the meeting UI behaves like a deployed product.
class ZoomMeetingBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RtcBackendManager>()) {
      final mgr = Get.put(RtcBackendManager(), permanent: true);
      mgr.init(RtcConfig.fromEnvironment());
    }
    Get.lazyPut<ZoomMeetingController>(() {
      final c = ZoomMeetingController();
      final sim = MockMeetingSim(c)..seed();
      Future.microtask(sim.start);
      return c;
    });
  }
}
