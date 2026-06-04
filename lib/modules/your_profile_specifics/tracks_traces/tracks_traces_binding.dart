import 'package:get/get.dart';
import 'tracks_traces_controller.dart';

class TracksTracesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TracksTracesController>(() => TracksTracesController());
  }
}
