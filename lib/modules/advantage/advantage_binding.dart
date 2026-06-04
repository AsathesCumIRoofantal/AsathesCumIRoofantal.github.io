import 'package:get/get.dart';
import 'advantage_controller.dart';
class AdvantageBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => AdvantageController());
}
