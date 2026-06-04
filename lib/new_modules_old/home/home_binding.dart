import 'package:get/get.dart';
import 'home_controller.dart';
import '../entities/entities_controller.dart';
import '../unions/unions_controller.dart';
import '../identity/identity_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => EntitiesController());
    Get.lazyPut(() => UnionsController());
    Get.lazyPut(() => IdentityController());
  }
}
