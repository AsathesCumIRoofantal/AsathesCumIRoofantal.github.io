import 'package:get/get.dart';
import 'web_recorded_rewarded_controller.dart';

class WebRecordedRewardedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebRecordedRewardedController>(
      () => WebRecordedRewardedController(),
    );
  }
}
