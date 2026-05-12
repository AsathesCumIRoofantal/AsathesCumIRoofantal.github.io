import 'package:get/get.dart';
import 'share_care_controller.dart';

class ShareCareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareCareController>(() => ShareCareController());
  }
}
