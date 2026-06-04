import 'package:get/get.dart';
import 'web_nevergiveup_controller.dart';

class WebNeverGiveUpBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebNeverGiveUpController>(() => WebNeverGiveUpController());
}
