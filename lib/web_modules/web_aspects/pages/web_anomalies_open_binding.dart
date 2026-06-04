import 'package:get/get.dart';
import 'web_anomalies_open_controller.dart';

class WebAnomaliesOpenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WebAnomaliesOpenController>(() => WebAnomaliesOpenController());
  }
}
