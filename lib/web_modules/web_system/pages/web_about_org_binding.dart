import 'package:get/get.dart';
import 'web_about_org_controller.dart';
class WebAboutOrgBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebAboutOrgController>(() => WebAboutOrgController());
}
