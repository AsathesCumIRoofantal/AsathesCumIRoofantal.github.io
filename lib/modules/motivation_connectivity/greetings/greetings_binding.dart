import 'package:get/get.dart';
import 'greetings_controller.dart';

class GreetingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GreetingsController>(() => GreetingsController());
  }
}
