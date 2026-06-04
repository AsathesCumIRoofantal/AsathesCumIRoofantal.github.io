import 'package:get/get.dart';
import 'travel_transport_controller.dart';

class TravelTransportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TravelTransportController>(() => TravelTransportController());
  }
}
