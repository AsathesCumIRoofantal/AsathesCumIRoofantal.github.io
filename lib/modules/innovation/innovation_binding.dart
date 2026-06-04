import 'package:get/get.dart';
import 'innovation_controller.dart';
class InnovationBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => InnovationController());
}
