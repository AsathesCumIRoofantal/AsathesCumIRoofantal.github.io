import 'package:get/get.dart';
import 'imagination_features_controller.dart';

class ImaginationFeaturesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImaginationFeaturesController>(() => ImaginationFeaturesController());
  }
}
