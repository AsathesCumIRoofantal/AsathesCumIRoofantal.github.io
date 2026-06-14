import 'package:get/get.dart';
import 'zoom_meeting_controller.dart';
import '../mock/mock_data.dart';

/// Binds the controller and seeds dummy users + a live simulation tick so
/// the meeting UI behaves like a deployed product without a backend.
class ZoomMeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ZoomMeetingController>(() {
      final c = ZoomMeetingController();
      final sim = MockMeetingSim(c)..seed();
      // Defer ticking until the first frame so Obx widgets are listening.
      Future.microtask(sim.start);
      return c;
    });
  }
}
