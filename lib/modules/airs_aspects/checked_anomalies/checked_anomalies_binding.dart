import 'package:air_app/modules/airs_aspects/checked_anomalies/anomalies_controller.dart';
import 'package:get/get.dart';
import 'checked_anomalies_controller.dart';

class CheckedAnomaliesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckedAnomaliesController>(() => CheckedAnomaliesController());
    Get.lazyPut<AnomaliesController>(() => AnomaliesController());
  }
}
