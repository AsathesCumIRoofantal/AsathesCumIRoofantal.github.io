import 'package:get/get.dart';
import 'web_life_hacks_controller.dart';
class WebLifeHacksBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebLifeHacksController>(() => WebLifeHacksController());
}
