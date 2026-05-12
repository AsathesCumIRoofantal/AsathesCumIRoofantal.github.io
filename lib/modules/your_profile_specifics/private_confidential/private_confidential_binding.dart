import 'package:get/get.dart';
import 'private_confidential_controller.dart';

class PrivateConfidentialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrivateConfidentialController>(() => PrivateConfidentialController());
  }
}
