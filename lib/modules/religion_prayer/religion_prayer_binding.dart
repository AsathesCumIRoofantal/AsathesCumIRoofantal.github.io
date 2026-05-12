import 'package:get/get.dart';
import 'religion_prayer_controller.dart';
class ReligionPrayerBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => ReligionPrayerController());
}
