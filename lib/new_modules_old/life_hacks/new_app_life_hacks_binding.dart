import 'package:get/get.dart';
import 'new_app_life_hacks_controller.dart';

class NewAppLifeHacksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewAppLifeHacksController>(() => NewAppLifeHacksController());
  }
}
