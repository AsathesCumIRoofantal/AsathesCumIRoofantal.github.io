import 'package:get/get.dart';
import 'web_word_motivation_controller.dart';
class WebWordMotivationBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebWordMotivationController>(() => WebWordMotivationController());
}
