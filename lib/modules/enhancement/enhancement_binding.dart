import 'package:get/get.dart';
import 'enhancement_controller.dart';
class EnhancementBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => EnhancementController());
}
