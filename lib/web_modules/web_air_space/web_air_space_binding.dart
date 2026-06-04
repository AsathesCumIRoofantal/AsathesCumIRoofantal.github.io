// web_modules/web_air_space/web_air_space_binding.dart
import 'package:get/get.dart';
import 'web_air_space_controller.dart';

class WebAirSpaceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAirSpaceController>(() => WebAirSpaceController());
  }
}
