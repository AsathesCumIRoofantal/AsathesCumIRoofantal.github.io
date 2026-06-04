import 'package:air_app/modules/airs_aspects/checked_anomalies/anomalies_controller.dart';
import 'package:get/get.dart';
import 'unchecked_anomalies_controller.dart';

class UncheckedAnomaliesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UncheckedAnomaliesController>(
      () => UncheckedAnomaliesController(),
    );
    Get.lazyPut<AnomaliesController>(() => AnomaliesController());
  }
}
