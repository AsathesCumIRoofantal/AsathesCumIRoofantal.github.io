import 'package:get/get.dart';
import 'being_recorded_rewarded_controller.dart';

class BeingRecordedRewardedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BeingRecordedRewardedController>(() => BeingRecordedRewardedController());
  }
}
