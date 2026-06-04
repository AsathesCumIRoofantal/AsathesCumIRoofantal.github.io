import 'package:get/get.dart';
import 'your_business_controller.dart';

class YourBusinessBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourBusinessController>(() => YourBusinessController());
  }
}
