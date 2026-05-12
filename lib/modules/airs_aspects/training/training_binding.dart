import 'package:get/get.dart';
import 'training_controller.dart';

class TrainingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrainingController>(() => TrainingController());
  }
}
