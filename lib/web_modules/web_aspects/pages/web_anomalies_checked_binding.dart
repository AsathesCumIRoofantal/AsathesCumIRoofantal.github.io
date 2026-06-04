import 'package:get/get.dart';
import 'web_anomalies_checked_controller.dart';

class WebAnomaliesCheckedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAnomaliesCheckedController>(
      () => WebAnomaliesCheckedController(),
    );
  }
}
