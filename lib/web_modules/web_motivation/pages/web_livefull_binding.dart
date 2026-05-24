import 'package:get/get.dart';
import 'web_livefull_controller.dart';

class WebLiveFullBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebLiveFullController>(() => WebLiveFullController());
}
