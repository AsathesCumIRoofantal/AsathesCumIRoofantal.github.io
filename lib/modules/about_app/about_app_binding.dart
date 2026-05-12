import 'package:get/get.dart';

class AboutAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutAppController>(() => AboutAppController());
  }
}

class AboutAppController extends GetxController {}
