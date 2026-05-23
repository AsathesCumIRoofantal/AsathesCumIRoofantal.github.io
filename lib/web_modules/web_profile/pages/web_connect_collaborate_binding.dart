import 'package:get/get.dart';
import 'web_connect_collaborate_controller.dart';
class WebConnectCollaborateBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<WebConnectCollaborateController>(() => WebConnectCollaborateController());
}
