import 'package:get/get.dart';
import 'prayer_for_all_controller.dart';

class PrayerForAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PrayerForAllController>(() => PrayerForAllController());
  }
}
