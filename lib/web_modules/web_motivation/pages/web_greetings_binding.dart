import 'package:get/get.dart';
import 'web_greetings_controller.dart';

class WebGreetingsBinding extends Bindings {
  @override
  void dependencies() =>
      Get.lazyPut<WebGreetingsController>(() => WebGreetingsController());
}
