import 'package:get/get.dart';
import 'web_tracks_and_traces_controller.dart';

class WebTracksAndTracesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WebTracksAndTracesController());
  }
}
