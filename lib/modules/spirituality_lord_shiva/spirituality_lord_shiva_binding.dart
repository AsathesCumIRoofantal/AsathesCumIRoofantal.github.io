import 'package:get/get.dart';
import 'spirituality_lord_shiva_controller.dart';

class SpiritualityLordShivaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpiritualityLordShivaController>(() => SpiritualityLordShivaController());
  }
}
