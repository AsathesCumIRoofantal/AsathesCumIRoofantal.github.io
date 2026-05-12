import 'package:get/get.dart';
import 'life_hacks_controller.dart';
class LifeHacksBinding extends Bindings {
  @override void dependencies() => Get.lazyPut(() => LifeHacksController());
}
