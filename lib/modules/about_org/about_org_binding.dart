import 'package:get/get.dart';

class AboutOrgBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutOrgController>(() => AboutOrgController());
  }
}

class AboutOrgController extends GetxController {}
