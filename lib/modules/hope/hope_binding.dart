import 'package:get/get.dart';
import 'hope_controller.dart';
class HopeBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => HopeController());
}
