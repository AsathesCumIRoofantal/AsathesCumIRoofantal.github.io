import 'package:get/get.dart';
import 'web_training_controller.dart';

class WebTrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebTrainingController>(() => WebTrainingController());
  }
}
