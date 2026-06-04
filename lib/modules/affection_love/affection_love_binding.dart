import 'package:get/get.dart';
import 'affection_love_controller.dart';

class AffectionLoveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffectionLoveController>(() => AffectionLoveController());
  }
}
