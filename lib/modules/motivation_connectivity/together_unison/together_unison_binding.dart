import 'package:get/get.dart';
import 'together_unison_controller.dart';

class TogetherUnisonBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TogetherUnisonController>(() => TogetherUnisonController());
  }
}
