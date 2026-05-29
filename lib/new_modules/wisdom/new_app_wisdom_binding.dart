import 'package:get/get.dart';
import 'new_app_wisdom_controller.dart';

class NewAppWisdomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppWisdomController>(() => NewAppWisdomController());
  }
}
